Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B388B7B8BED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbjJDSxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244549AbjJDSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:53:12 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1260DCE;
        Wed,  4 Oct 2023 11:52:46 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 997887A0739;
        Wed,  4 Oct 2023 20:52:45 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ata: pata_parport: add custom version of wait_after_reset
Date:   Wed,  4 Oct 2023 20:52:34 +0200
Message-Id: <20231004185235.27417-4-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231004185235.27417-1-linux@zary.sk>
References: <20231004185235.27417-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
bogus values when there's no master device present. This can cause
reset to fail, preventing the lone slave device (such as EXP Computer
CD-865) from working.

Add custom version of wait_after_reset that ignores master failure when
a slave device is present. The custom version is also needed because
the generic ata_sff_wait_after_reset uses direct port I/O for slave
device detection.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 67 ++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index cf87bbb52f1f..318b2ce2d8d1 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -80,6 +80,71 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
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
+			if ((nsect == 1) && (lbal == 1))
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
@@ -94,7 +159,7 @@ static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	ap->last_ctl = ap->ctl;
 
 	/* wait the port to become ready */
-	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+	return pata_parport_wait_after_reset(&ap->link, devmask, deadline);
 }
 
 static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
-- 
Ondrej Zary

