Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8637AC965
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjIXNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjIXNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:30:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D34C1C;
        Sun, 24 Sep 2023 06:20:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66287C433A9;
        Sun, 24 Sep 2023 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561613;
        bh=Ozm3VrajNVMfO/Q/19/xtBEg7J/YDv8pH5dJnquSS4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsMVGeHZCyyPfnVa859ksL8oQOenWrkJ/ILiJuLYnIMUVpAeqPpe9DLwjdVzXu738
         PFO+IPk+BO3PVbVdBiXhQhCsNZutt0b4PJMCE4XXeEEch4GD4ukcNUUCTRJWjVLEJL
         pvVVgLYVp7kkuD9A1c4NsHNrGttvPr2UMV1zlMQ779i5mTL4uypCM0kHzDaKDC0u0w
         WuUlHZANpsQg/xxM0LU0Fo7KHnF+LL1Gi+U7GhI0Jwgmg6wv4HzqNBWjJub5rd7m+R
         lefgg88It/Su2P7ml5swoU8tPM6ITDAY0/SRaPtg01MlO69OpU8QAkdUK5cRMmWifS
         DqU41fC64/5HQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/13] ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
Date:   Sun, 24 Sep 2023 09:19:43 -0400
Message-Id: <20230924131945.1276562-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131945.1276562-1-sashal@kernel.org>
References: <20230924131945.1276562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.197
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

[ Upstream commit 80cc944eca4f0baa9c381d0706f3160e491437f2 ]

ata_scsi_port_error_handler() starts off by clearing ATA_PFLAG_EH_PENDING,
before calling ap->ops->error_handler() (without holding the ap->lock).

If an error IRQ is received while ap->ops->error_handler() is running,
the irq handler will set ATA_PFLAG_EH_PENDING.

Once ap->ops->error_handler() returns, ata_scsi_port_error_handler()
checks if ATA_PFLAG_EH_PENDING is set, and if it is, another iteration
of ATA EH is performed.

The problem is that ATA_PFLAG_EH_PENDING is not only cleared by
ata_scsi_port_error_handler(), it is also cleared by ata_eh_reset().

ata_eh_reset() is called by ap->ops->error_handler(). This additional
clearing done by ata_eh_reset() breaks the whole retry logic in
ata_scsi_port_error_handler(). Thus, if an error IRQ is received while
ap->ops->error_handler() is running, the port will currently remain
frozen and will never get re-enabled.

The additional clearing in ata_eh_reset() was introduced in commit
1e641060c4b5 ("libata: clear eh_info on reset completion").

Looking at the original error report:
https://marc.info/?l=linux-ide&m=124765325828495&w=2

We can see the following happening:
[    1.074659] ata3: XXX port freeze
[    1.074700] ata3: XXX hardresetting link, stopping engine
[    1.074746] ata3: XXX flipping SControl

[    1.411471] ata3: XXX irq_stat=400040 CONN|PHY
[    1.411475] ata3: XXX port freeze

[    1.420049] ata3: XXX starting engine
[    1.420096] ata3: XXX rc=0, class=1
[    1.420142] ata3: XXX clearing IRQs for thawing
[    1.420188] ata3: XXX port thawed
[    1.420234] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

We are not supposed to be able to receive an error IRQ while the port is
frozen (PxIE is set to 0, i.e. all IRQs for the port are disabled).

AHCI 1.3.1 section 10.7.1.1 First Tier (IS Register) states:
"Each bit location can be thought of as reporting a '1' if the virtual
"interrupt line" for that port is indicating it wishes to generate an
interrupt. That is, if a port has one or more interrupt status bit set,
and the enables for those status bits are set, then this bit shall be set."

Additionally, AHCI state P:ComInit clearly shows that the state machine
will only jump to P:ComInitSetIS (which sets IS.IPS(x) to '1'), if PxIE.PCE
is set to '1'. In our case, PxIE is set to 0, so IS.IPS(x) won't get set.

So IS.IPS(x) only gets set if PxIS and PxIE is set.

AHCI 1.3.1 section 10.7.1.1 First Tier (IS Register) also states:
"The bits in this register are read/write clear. It is set by the level of
the virtual interrupt line being a set, and cleared by a write of '1' from
the software."

So if IS.IPS(x) is set, you need to explicitly clear it by writing a 1 to
IS.IPS(x) for that port.

Since PxIE is cleared, the only way to get an interrupt while the port is
frozen, is if IS.IPS(x) is set, and the only way IS.IPS(x) can be set when
the port is frozen, is if it was set before the port was frozen.

However, since commit 737dd811a3db ("ata: libahci: clear pending interrupt
status"), we clear both PxIS and IS.IPS(x) after freezing the port, but
before the COMRESET, so the problem that commit 1e641060c4b5 ("libata:
clear eh_info on reset completion") fixed can no longer happen.

Thus, revert commit 1e641060c4b5 ("libata: clear eh_info on reset
completion"), so that the retry logic in ata_scsi_port_error_handler()
works once again. (The retry logic is still needed, since we can still
get an error IRQ _after_ the port has been thawed, but before
ata_scsi_port_error_handler() takes the ap->lock in order to check
if ATA_PFLAG_EH_PENDING is set.)

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 973f4d34d7cda..5fb3eda0a280b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2703,18 +2703,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			postreset(slave, classes);
 	}
 
-	/*
-	 * Some controllers can't be frozen very well and may set spurious
-	 * error conditions during reset.  Clear accumulated error
-	 * information and re-thaw the port if frozen.  As reset is the
-	 * final recovery action and we cross check link onlineness against
-	 * device classification later, no hotplug event is lost by this.
-	 */
+	/* clear cached SError */
 	spin_lock_irqsave(link->ap->lock, flags);
-	memset(&link->eh_info, 0, sizeof(link->eh_info));
+	link->eh_info.serror = 0;
 	if (slave)
-		memset(&slave->eh_info, 0, sizeof(link->eh_info));
-	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
 	if (ap->pflags & ATA_PFLAG_FROZEN)
-- 
2.40.1

