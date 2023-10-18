Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0D7CDECE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjJROOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjJRONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:13:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0035B10F6;
        Wed, 18 Oct 2023 07:12:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C619C433CB;
        Wed, 18 Oct 2023 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638379;
        bh=7wEWTbsmHfn29mETzb3JDJjLmW2fn+HIIKe0xNXI+Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMysUu2DximsAPGQCjD+UYPUJW1JPikbh+3cTucZKKVG81eoIYTl2PkrgGCLokKpd
         kMVfx5gS+nE7+Uo64qqmvx0wxLnPY5Zncq6ij54OSdA2MWqUvaLSkRNq7qP0xHHrKt
         akyFvcN+VtWjx7gQzbvLZ9ms1jeu31fu1XDH3B691neU6AeZkT/Y5nIhCNXhGv6cAM
         6kc7GlXQii2wfAOenViVZRfAF1QMI2pg/Lbr/OZVQIfk9gxpwaeMopTEmv0r3OssAJ
         XNTwtOG2V0hZ9KHULQm+dCS6MwUdNuAsDAQE2ow1nm6+5K5PmJ2rRKUSQESuEOv1RY
         fenL0BWVSIPGw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>, martin.petersen@oracle.com,
        gregkh@linuxfoundation.org, bvanassche@acm.org,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 24/31] ata: pata_parport: add custom version of wait_after_reset
Date:   Wed, 18 Oct 2023 10:11:41 -0400
Message-Id: <20231018141151.1334501-24-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Zary <linux@zary.sk>

[ Upstream commit f343e578fef99a69b3322aca38b94a6d8ded2ce7 ]

Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
bogus values when there's no master device present. This can cause
reset to fail, preventing the lone slave device (such as EXP Computer
CD-865) from working.

Add custom version of wait_after_reset that ignores master failure when
a slave device is present. The custom version is also needed because
the generic ata_sff_wait_after_reset uses direct port I/O for slave
device detection.

Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_parport/pata_parport.c | 68 ++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 1af64d435d3c2..cd5463970be2e 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -73,6 +73,72 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 	return (nsect == 0x55) && (lbal == 0xaa);
 }
 
+static int pata_parport_wait_after_reset(struct ata_link *link,
+					 unsigned int devmask,
+					 unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct pi_adapter *pi = ap->host->private_data;
+	unsigned int dev0 = devmask & (1 << 0);
+	unsigned int dev1 = devmask & (1 << 1);
+	int rc, ret = 0;
+
+	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
+
+	/* always check readiness of the master device */
+	rc = ata_sff_wait_ready(link, deadline);
+	if (rc) {
+		/*
+		 * some adapters return bogus values if master device is not
+		 * present, so don't abort now if a slave device is present
+		 */
+		if (!dev1)
+			return rc;
+		ret = -ENODEV;
+	}
+
+	/*
+	 * if device 1 was found in ata_devchk, wait for register
+	 * access briefly, then wait for BSY to clear.
+	 */
+	if (dev1) {
+		int i;
+
+		pata_parport_dev_select(ap, 1);
+
+		/*
+		 * Wait for register access.  Some ATAPI devices fail
+		 * to set nsect/lbal after reset, so don't waste too
+		 * much time on it.  We're gonna wait for !BSY anyway.
+		 */
+		for (i = 0; i < 2; i++) {
+			u8 nsect, lbal;
+
+			nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+			lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+			if (nsect == 1 && lbal == 1)
+				break;
+			/* give drive a breather */
+			ata_msleep(ap, 50);
+		}
+
+		rc = ata_sff_wait_ready(link, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
+	}
+
+	pata_parport_dev_select(ap, 0);
+	if (dev1)
+		pata_parport_dev_select(ap, 1);
+	if (dev0)
+		pata_parport_dev_select(ap, 0);
+
+	return ret;
+}
+
 static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 				      unsigned long deadline)
 {
@@ -87,7 +153,7 @@ static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	ap->last_ctl = ap->ctl;
 
 	/* wait the port to become ready */
-	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+	return pata_parport_wait_after_reset(&ap->link, devmask, deadline);
 }
 
 static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
-- 
2.40.1

