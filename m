Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F957E34E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjKGFmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKGFmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:42:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBEA3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:42:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc4f777ab9so37389285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 21:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699335721; x=1699940521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpsPDUKmSBGH2PXQu9l6Jag7HFxdK8uve1cBJF7oaiA=;
        b=ssEE+taa303fAvgsSh0z72mOHCA0yfXrYkHFZK6/eI3bVFPWIAY6vgZtmLtAdezbHV
         /M7p9pC4nHx2HBwB3VW7UxEVB5dYn3jNBNixLGMzD7Nh5+977jJYspe04dPDfMKl+hXe
         1AT4fV+MGwEdwB315xt2cY5c8yVH+acUIsB0Qkgdbe6gt7jDm0P9GWAyximugC2ZDQBi
         utavGPclOZsHifg1967JAo4YfCP+gvNHNvuLnltPmbvhji/WNfhcimxfyw2o5XJM729b
         4eMGdOUaXC6LnaqQAL9aC87AzcfZcoOM8X8vB3ZQ8M4lTMoovBYo+rpDFsyEelA1Y10d
         k8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699335721; x=1699940521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpsPDUKmSBGH2PXQu9l6Jag7HFxdK8uve1cBJF7oaiA=;
        b=cgDHRmFkWC9YA4kFUSQC3T6WzxouzsaBqlZ6mTI6QV9t6KDnZmZ/tr230hqfqfYG7d
         N/Sh9Vd2+is5ORSX2RvFxPrhrTEDHrvZnmjnsCSUS7llovYnw7DLi7ZyaO50FHxu0TPv
         9zEs/QLWYhlQOaEouQAhOz6JsXAYeJcCHNopG0vgyIyuSw2YEYYSDpQGS+vxWLKfuLko
         a0BSJO07svh+XWa3UIojNTs2Hzf8qDIbL6n5ypkwtA3Jqv59hD77hIbNAQ8srZNY/pYo
         Nb5ISUGzWwcZqNUyw1Am0xt307CE+Xd3Oopmbr+cAHMfSZ0swOhZfEdowSkruJ3mswNt
         xaJw==
X-Gm-Message-State: AOJu0YwCiXLSlXMmcq0f5nq9ktWW6GkgRxqMtEFJodVWBGKYobPqYd7q
        w/zeU5mVV2sD48jhJZSB/c8SqA==
X-Google-Smtp-Source: AGHT+IGPUTg89/qbo0Oal/4a7eTPgoKOENxAu2M1bYMDZWaFH9P0wpW81iS3Vlhfl2o0eHpzRmTHhg==
X-Received: by 2002:a17:902:d4c3:b0:1cc:6ab6:df26 with SMTP id o3-20020a170902d4c300b001cc6ab6df26mr20530105plg.49.1699335720948;
        Mon, 06 Nov 2023 21:42:00 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001cc530c495asm6752053pld.113.2023.11.06.21.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:42:00 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-efi@vger.kernel.org
Subject: [PATCH v10 1/5] efi: expose efivar generic ops register function
Date:   Tue,  7 Nov 2023 14:40:52 +0900
Message-Id: <20231107054057.1893-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
References: <20231107054057.1893-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for supporting efivar operations
provided by other than efi subsystem.
Both register and unregister functions are exposed
so that non-efi subsystem can revert the efi generic
operation.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f1176842..53ae25bbb6ac 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -231,6 +231,18 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
 
+void efivars_generic_ops_register(void)
+{
+	generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_register);
+
+void efivars_generic_ops_unregister(void)
+{
+	generic_ops_unregister();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_unregister);
+
 #ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
 #define EFIVAR_SSDT_NAME_MAX	16UL
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b21d1c6eaf..08bc00dad66e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1355,4 +1355,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.39.2

