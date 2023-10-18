Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9117CDECA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbjJROOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbjJRONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:13:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA96170D;
        Wed, 18 Oct 2023 07:13:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77360C433CA;
        Wed, 18 Oct 2023 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638382;
        bh=G4PX3SvDRvuKIAZByj3uRc44e7plgDRY0s8gFiTtkos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8NFRakORLdqlkMO3vnA0qpdnisUdcCq44QBV2Q6qtDDgQhL7Ngz6iJ6LHS/tPwt1
         pPiZyxJnqJ2HoCV1N0/tXKUFgfwnB5TaNYLTnzCr8vXGM1L2++Y6BuCvRtrWvLJJ8S
         mLjpC5K6eoW0dm/iRBAhlK2DK/DYliFY39YVLPBiiUR/ZCWxdgFK8hXdsgZkmD+/lF
         ZKYddroEjggaK+0V/OU4QCHwOS1HccvWO6BfLTaPGzZjg9AK2R7PVT/GgO5OtxdY7N
         dNpSXtIhYEASzrHJ87wklv2A9G5+MAYXo39GZVXsuh1IdZHuVwVUpfsxVR9crFovrV
         B9ZQ2lOsf/jUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>, axboe@kernel.dk,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 25/31] ata: pata_parport: fit3: implement IDE command set registers
Date:   Wed, 18 Oct 2023 10:11:42 -0400
Message-Id: <20231018141151.1334501-25-sashal@kernel.org>
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

[ Upstream commit 0c1e81d0b5ebd5813536dd5fcf5966ad043f37dc ]

fit3 protocol driver does not support accessing IDE control registers
(device control/altstatus). The DOS driver does not use these registers
either (as observed from DOSEMU trace). But the HW seems to be capable
of accessing these registers - I simply tried bit 3 and it works!

The control register is required to properly reset ATAPI devices or
they will be detected only once (after a power cycle).

Tested with EXP Computer CD-865 with MC-1285B EPP cable and
TransDisk 3000.

Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_parport/fit3.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index bad7aa920cdca..d2b81cf2e16d2 100644
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
@@ -37,8 +32,7 @@
 
 static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 {
-	if (cont == 1)
-		return;
+	regr += cont << 3;
 
 	switch (pi->mode) {
 	case 0:
@@ -59,11 +53,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
 {
 	int  a, b;
 
-	if (cont) {
-		if (regr != 6)
-			return 0xff;
-		regr = 7;
-	}
+	regr += cont << 3;
 
 	switch (pi->mode) {
 	case 0:
-- 
2.40.1

