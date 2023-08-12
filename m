Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E54377A165
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHLR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHLR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DCD10E2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 10:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F4796198A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57188C433C8;
        Sat, 12 Aug 2023 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691861257;
        bh=7X4x8jw4F6WxyxJBSlKm6iXGiRPzAF1Ccv9+SBjjtKw=;
        h=From:To:Cc:Subject:Date:From;
        b=MgiDjO3IHAt2oVNOFPBxFXAC35dWjt3ldfVNvy39DSk0ndwTvvOB3hPGDEl+kNdRy
         Qx7/cAD2rGpPUwSLBArNnSattGoE0JCB/z2gJoiiJKnX2AZymwWSrxeiBvJ8ZVeQ1a
         5ImyQptlmCyF+Ff8cLZkQ8XzspmQpMm768TVOzaRAmE/eppMmCePTyfbltkVPjs2YV
         x1uZkaxe9ygiuNlft38shi9fMI4PS2BLOh19gvtCgX+gmoBUy33oNBahe2uQ8zP9hu
         38dMjEUTOlVdfP66lz05gXv1DIdyDs0gr1p7nJsRkc7nWdVmvE9FaKxwdwHyjgrUMp
         2aQacFPa35hVA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Huisong Li <lihuisong@huawei.com>, Wei Xu <xuwei5@hisilicon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: kunpeng_hccs: fix size_t format string
Date:   Sat, 12 Aug 2023 19:21:06 +0200
Message-Id: <20230812172116.3477379-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

Printing a size_t using the %lu format string causes a warning on
architectures that define the type as 'unsigned int':

In file included from include/linux/device.h:15,
                 from include/linux/acpi.h:14,
                 from drivers/soc/hisilicon/kunpeng_hccs.c:25:
drivers/soc/hisilicon/kunpeng_hccs.c: In function 'hccs_get_bd_info':
drivers/soc/hisilicon/kunpeng_hccs.c:441:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]

Use the correct %zu format instead.

Fixes: 886bdf9c883bc ("soc: hisilicon: Support HCCS driver on Kunpeng SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've already applied this one on top of the soc/drivers branch after I
merged the branch with the new driver and noticed the regression.

 drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 6864d203c6782..0d6f6bacd3f62 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -438,7 +438,7 @@ static int hccs_get_bd_info(struct hccs_dev *hdev, u8 opcode,
 	head = &rsp->rsp_head;
 	if (head->data_len > buf_len) {
 		dev_err(hdev->dev,
-			"buffer overflow (buf_len = %lu, data_len = %u)!\n",
+			"buffer overflow (buf_len = %zu, data_len = %u)!\n",
 			buf_len, head->data_len);
 		return -ENOMEM;
 	}
-- 
2.39.2

