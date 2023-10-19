Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B57D0186
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjJSSaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjJSSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:30:29 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E11CA;
        Thu, 19 Oct 2023 11:30:22 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce2c5b2154so5373a34.3;
        Thu, 19 Oct 2023 11:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740222; x=1698345022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OlisRR/7jSUpcBpgGyXz1Fjy44KjCthVAKQggQWimY=;
        b=pEZz9CVc5QLdOFi5dMxS/RV7K7EZhQhvJpyPcAogvZm4tGJX2XVwiae8RLl7+iZK5l
         CcIvpWNxtpssrpR9OKCHIc7O0OGRwIoNxEsKxAKHNvTFIlhvoAe/KFCdEZYNHrU7jF/J
         Do066qXjzYRpMHkA3gmqSh2n0tWv9xKurGoOWqFiISvCEhEK3be4X8mWTki2WBr6rwma
         4GMH8n9zzI9LkDcRlVW2muEVF4CVQNno5ZFNyFj7AgvGOmluYDrDfj4QSfFEn1H21kbe
         wLXbq377zdTJt0S93K0b4VkYsxuixoA85Ci7UpzbwCq9BsxfAsPfGBfo1bjBk0AMEZSy
         mMGw==
X-Gm-Message-State: AOJu0YzxZSS7O3K7oJaeM42kJiflYvggKg83wTpkO9eVrhmEOM5D7Q6d
        NfbYGFHVJ3yLxNgaCzRdiQYXuJeHEA==
X-Google-Smtp-Source: AGHT+IFg3OHoS5WSSYGvYCn+MO5yYk/KYenlD4LywOXyVMey+Ef0qNeHS/zrWtk3oo7EE/LYCC6YPw==
X-Received: by 2002:aca:1112:0:b0:3a8:83df:d5a4 with SMTP id 18-20020aca1112000000b003a883dfd5a4mr2707867oir.59.1697740221913;
        Thu, 19 Oct 2023 11:30:21 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o13-20020a05680803cd00b003b2df32d9a9sm20077oie.19.2023.10.19.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:30:20 -0700 (PDT)
Received: (nullmailer pid 841631 invoked by uid 1000);
        Thu, 19 Oct 2023 18:30:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: Fix unused ci_hdrc_usb2_of_match warning for !CONFIG_OF
Date:   Thu, 19 Oct 2023 13:30:15 -0500
Message-ID: <20231019183015.841460-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 14485de431b0 ("usb: Use device_get_match_data()") dropped the
unconditional use of ci_hdrc_usb2_of_match resulting in this warning:

drivers/usb/chipidea/ci_hdrc_usb2.c:41:34: warning: unused variable 'ci_hdrc_usb2_of_match' [-Wunused-const-variable]

The fix is to drop of_match_ptr() which is not necessary because DT is
always used for this driver.

Fixes: 14485de431b0 ("usb: Use device_get_match_data()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310131627.M43j234A-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 180a632dd7ba..97379f653b06 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -119,7 +119,7 @@ static struct platform_driver ci_hdrc_usb2_driver = {
 	.remove_new = ci_hdrc_usb2_remove,
 	.driver	= {
 		.name		= "chipidea-usb2",
-		.of_match_table	= of_match_ptr(ci_hdrc_usb2_of_match),
+		.of_match_table	= ci_hdrc_usb2_of_match,
 	},
 };
 module_platform_driver(ci_hdrc_usb2_driver);
-- 
2.42.0

