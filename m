Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB57DB3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJ3G5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjJ3G47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:56:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9BBD4D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:56:47 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xMCXqf3ZpdFbKxMCYqfBpU; Mon, 30 Oct 2023 07:56:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698649004;
        bh=KkbJNouXf1jB9o5VmPFQMXyslZ7BV0Kwtr1ZfMOhED0=;
        h=From:To:Cc:Subject:Date;
        b=EoVYKNhntLWgaYt3lWeEflSOZ13HEfu/PRa3sOcgLqsK3MV7pxUJifqbTgmfk2O7/
         vWjc7K1Z2Qbu21SmYAlk9rUHOYm6MlHCVJqFw2G2qJgljuXyc/CRI+92VrdCXZMPrZ
         AlYLANf8MBiak0D//G9tr+2KOybPtRV2adO1fED9zi91KE9VoSKzeC1xY2I3szqAMw
         zbdBSRWA2TkEOCnTLeTZxt6bUvI6AGzHTeiErlLWZpoDYhc83ym9e859FZQFnQ6rey
         hwbvzwcgRfI5Zf2LSKh96lQUMWAsMjF7ZLWt/OZl4BWM/Cd6WfZuzttBDWgfGm6Eek
         WvVUEnoMFaTiw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 07:56:44 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abdel Alkuor <abdelalkuor@geotab.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH] USB: typec: tps6598x: Fix a memory leak in an error handling path
Date:   Mon, 30 Oct 2023 07:56:40 +0100
Message-Id: <23168336f18a9f6cb1a5b47130fc134dc0510d7f.1698648980.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All error handling end to the error handling path, except these ones.
Go to 'release_fw' as well here, otherwise 'fw' is leaking.

Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/typec/tipd/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0e867f531d34..b0184be06c3d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -968,16 +968,17 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
 	ret = of_property_match_string(np, "reg-names", "patch-address");
 	if (ret < 0) {
 		dev_err(tps->dev, "failed to get patch-address %d\n", ret);
-		return ret;
+		goto release_fw;
 	}
 
 	ret = of_property_read_u32_index(np, "reg", ret, &addr);
 	if (ret)
-		return ret;
+		goto release_fw;
 
 	if (addr == 0 || (addr >= 0x20 && addr <= 0x23)) {
 		dev_err(tps->dev, "wrong patch address %u\n", addr);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_fw;
 	}
 
 	bpms_data.addr = (u8)addr;
-- 
2.34.1

