Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01417B4339
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjI3TPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjI3TPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:15:33 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AC9EE6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 12:15:30 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 895A57A03C3;
        Sat, 30 Sep 2023 21:15:28 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pata_parport-fit3: implement IDE command set registers
Date:   Sat, 30 Sep 2023 21:15:11 +0200
Message-Id: <20230930191511.24994-5-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230930191511.24994-1-linux@zary.sk>
References: <20230930191511.24994-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fit3 protocol driver does not support accessing IDE control registers
(device control/altstatus). The DOS driver does not use these registers
either (as observed from DOSEMU trace). But the HW seems to be capable
of accessing these registers - I simply tried bit 3 and it works!

The control register is required to properly reset ATAPI devices or
they will be detected only once (after a power cycle).

Tested with EXP Computer CD-865 with MC-1285B EPP cable and
TransDisk 3000.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/fit3.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index bad7aa920cdc..86b39966755b 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -9,11 +9,6 @@
  *
  * The TD-2000 and certain older devices use a different protocol.
  * Try the fit2 protocol module with them.
- *
- * NB:  The FIT adapters do not appear to support the control
- * registers.  So, we map ALT_STATUS to STATUS and NO-OP writes
- * to the device control register - this means that IDE reset
- * will not work on these devices.
  */
 
 #include <linux/module.h>
@@ -35,10 +30,11 @@
  * cont = 1 - access the IDE command set
  */
 
+static int cont_map[] = { 0x00, 0x08 };
+
 static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 {
-	if (cont == 1)
-		return;
+	regr += cont_map[cont];
 
 	switch (pi->mode) {
 	case 0:
@@ -59,11 +55,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
 {
 	int  a, b;
 
-	if (cont) {
-		if (regr != 6)
-			return 0xff;
-		regr = 7;
-	}
+	regr += cont_map[cont];
 
 	switch (pi->mode) {
 	case 0:
-- 
Ondrej Zary

