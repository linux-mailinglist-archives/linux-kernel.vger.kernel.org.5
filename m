Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1557AC8C6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjIXNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjIXNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:19:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2DCF4;
        Sun, 24 Sep 2023 06:17:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF457C433CD;
        Sun, 24 Sep 2023 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561462;
        bh=wqJV0D2yVUiguXV6s0oLsSI9drzZk+wy9WPn3ugGs4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIjTdiA2v1rMhPkyEwH9Y9b5fM26qYv/snnVxpyS5p0ST8Wxn7o/MNDNOQ81xfktJ
         YT6Sv0Wiw2OA/Y8Txf9X7NeOJhjEYO+4bJJZ5kS9lR/gkNyLIpoQfGbms8sH5QkfmO
         j8OBnRXrfWWgVY9KAvx3wJQiYr4Pzl/wwFowdFskNRzZ+PGcftGceK+NFemrZtzBwy
         tb8wi9nM7rNJWR8G1qCbySGb0X+omAqkVkQN6wkqG4MqWr0OQv+YCuuH5zniGOvFkY
         r6l+Hk2tynOy+0OtHDFUMp8PiTi4vXP5rOgUT/NSlYXyQpcFEECOD+1O4m/5CywAnI
         WKgweIzNIcFbA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 41/41] ata: libata-eh: do not thaw the port twice in ata_eh_reset()
Date:   Sun, 24 Sep 2023 09:15:29 -0400
Message-Id: <20230924131529.1275335-41-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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

[ Upstream commit 7a3bc2b3989e05bbaa904a63279049a401491c84 ]

commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
a workaround that broke the retry mechanism in ATA EH.

Tejun himself suggested to remove this workaround when it was identified
to cause additional problems:
https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/

He even said:
"Hmm... it seems I wasn't thinking straight when I added that work around."
https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/

While removing the workaround solved the issue, however, the workaround was
kept to avoid "spurious hotplug events during reset", and instead another
workaround was added on top of the existing workaround in commit
8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").

Because these IRQs happened when the port was frozen, we know that they
were actually a side effect of PxIS and IS.IPS(x) not being cleared before
the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: clear
pending interrupt status"), so these workarounds can now be removed.

Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion") has
now been reverted, the ATA EH retry mechanism is functional again, so there
is once again no need to thaw the port more than once in ata_eh_reset().

This reverts "the workaround on top of the workaround" introduced in commit
8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d7914c7d1a0d1..960ef5c6f2c10 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2829,9 +2829,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
-	if (ata_port_is_frozen(ap))
-		ata_eh_thaw_port(ap);
-
 	/*
 	 * Make sure onlineness and classification result correspond.
 	 * Hotplug could have happened during reset and some
-- 
2.40.1

