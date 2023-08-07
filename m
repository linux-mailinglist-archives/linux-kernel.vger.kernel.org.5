Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06B77187B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHGCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHGCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:54:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9074E172E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:54:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc3d94d40fso35721105ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691376844; x=1691981644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGsOagw0C9AFCmrPzx7vMQmPgfV2zqYdX4uVR8HZb40=;
        b=GZtO+pdiMrxxlE325qzZ6L+M7/5l1Qd/fq9WW+bbMuTU6myRjCCraVjC10pNc+taui
         rfEFomCSKtrec/1ZiUS58tHGuYHn2de4VYaVVq6VdXlwppxAzOLAY2WW4P0nhrUrH+gf
         H9GstGBZDfvaciOMLgZanLdH820RdH2QZVLgKPmCMExyGR6vkl0KGWf+iR71Dd9obSJ/
         xyDU/Bn3Ec9ngL7m/amgzxdok9q4QMtorX/x9SEoObjuw4YLS/ecNSWidX3zNLZKsCjd
         7pE7TdZuB0HctNRdftmBEu5pME4WeHDLJPPrsNLtBKOUPcaDNTwa7K2lg2SLqdrHahi1
         srsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691376844; x=1691981644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGsOagw0C9AFCmrPzx7vMQmPgfV2zqYdX4uVR8HZb40=;
        b=MkE/tEM2f2505834s9VWtkxp2rQESW5AryLRV5btLL6iVmP/4ongHCAulsJenQJQkC
         lbo9f6eMaRNTt+hYe4wAKVn+a3mMKGlfSbTIteQHVKw5cnkf3iOzP+NZoQon2yg6zzcM
         0sqpkJkCqrYIJHGpfYhIxsULN6NT0rELLKdUJ59qpBu1Vcg67kJGsFZIL9tpbl8fN5Ko
         TZJ5t1bF+j4uJcy+39mso1rBuYs50LzLEHIW9fb9g6JSVPCk/at6bBTMF8rl0uc+mEcv
         8YgoU/lNRvxAO7GSaVkItxZicSQPRMzWloonyjXCwPwScdiNjbVUPBnpvJ07jqefx3X9
         c3Xw==
X-Gm-Message-State: AOJu0Yw33c9o2QwaK+cPSuKvx9ONSy3IRKTmW6ShttQB60TfnOg2V49T
        eVod6hyA2zkB+sDmqgzrURxovA==
X-Google-Smtp-Source: AGHT+IGk6WDTHksGPaG+Srx9mpWgO6lYmaZnUI6RmhT8WBnQR5nOAL+WchaOWpnGgGl72Ee+oYdkiQ==
X-Received: by 2002:a17:902:6b89:b0:1bb:1494:f7f7 with SMTP id p9-20020a1709026b8900b001bb1494f7f7mr8251784plk.23.1691376844080;
        Sun, 06 Aug 2023 19:54:04 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b9ecee9f81sm5574953plb.129.2023.08.06.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:54:03 -0700 (PDT)
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
Subject: [PATCH v8 1/5] efi: expose efivar generic ops register function
Date:   Mon,  7 Aug 2023 11:53:38 +0900
Message-Id: <20230807025343.1939-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807025343.1939-1-masahisa.kojima@linaro.org>
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index e9004358f7bd..faea18b42c08 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1364,4 +1364,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

