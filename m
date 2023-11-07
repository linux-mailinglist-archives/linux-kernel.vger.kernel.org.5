Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84C7E34ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjKGFnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGFnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:43:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488FFC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:43:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc3388621cso48510725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 21:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699335801; x=1699940601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC9+6o/T27FauGqpCY6UW1sf3Qj4VAGRtqpDENax00E=;
        b=M9reAfX2vaqnuoYE+nOifienaCmhUUzgeC8hVVyxQqaV8IeLd+3/bYxGxKTnixkXLZ
         yuw6/UtNIR3tAIg5T2c0Yvi0aIG/K0EzaB3VWn93oasM9wTI2C2jyE+HS1FbriQwBRvq
         jW88tq+ahKwCzpTBG4QhBG6jraNZrwT7b8IQ/9MfHuTAnH1CjmjWdTEXBjwbsfT5fd2d
         p0+k/MZPqZ7lvsfrCJnFJ47njT8F7hUgekAUi4PF6emLW6BZLC3Y4ZLp7j/pAeM4I2QW
         n5SC2EkBWKrgGtRfAtLeSBRyS0UPWBqldRGdagFv+eyb1uv/OEsW5p5k4EztxVBkHXJO
         bMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699335801; x=1699940601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC9+6o/T27FauGqpCY6UW1sf3Qj4VAGRtqpDENax00E=;
        b=ivtd2k2Gf5WCrW2DvJoqy4ykQduJjL4IKJAsdK3Fe9Z9jaZaMOUMfSGJqhs8GskM5O
         UF4zV2qfeel4rfbj69XOMQHE3V21zcNoWNvb/JYYSoXtQSGJZTQpjgwOUxQHSxOG5svt
         VuDCR8gukmxKBPCGXOLfIUwhOkqH6wQHtiSnaJyH/4qVK3F/KFOP11ce0rj+dYxR3LTO
         EnqvjbODbpFiKd4XrQelA+Y3CNTCL2TLZNxpbp1iX+F9ouTlnPHYKKNoM2xkurTAwPXh
         /jQxPbnbEwvRnezS0yRQiODPmGugo3Y5s6+op6ybQ0ZZLlLwHCmTWFXnvD0S9FB0UhU5
         smpQ==
X-Gm-Message-State: AOJu0YyM8kIXkZJQDC4dbSjKrU67O/UmR0wKssC5lK3hu4Lg8eE9U91y
        b00eGK23dcWIwKuo3YUbwIp/hw==
X-Google-Smtp-Source: AGHT+IGRYaCGocxUcM5RRfcCdHCzJSmAunVBaZlXeMoVP3uVCGHtYEKc+wGDxguUX1U58rJ1oLdyAA==
X-Received: by 2002:a17:902:e851:b0:1cc:42d0:dbc5 with SMTP id t17-20020a170902e85100b001cc42d0dbc5mr2635662plg.13.1699335801028;
        Mon, 06 Nov 2023 21:43:21 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001cc530c495asm6752053pld.113.2023.11.06.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:43:20 -0800 (PST)
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
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Subject: [PATCH v10 4/5] efivarfs: automatically update super block flag
Date:   Tue,  7 Nov 2023 14:40:55 +0900
Message-Id: <20231107054057.1893-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
References: <20231107054057.1893-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efivar operation is updated when the tee_stmm_efi module is probed.
tee_stmm_efi module supports SetVariable runtime service,
but user needs to manually remount the efivarfs as RW to enable
the write access if the previous efivar operation does not support
SerVariable and efivarfs is mounted as read-only.

This commit notifies the update of efivar operation to
efivarfs subsystem, then drops SB_RDONLY flag if the efivar
operation supports SetVariable.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c  |  6 ++++++
 drivers/firmware/efi/vars.c |  8 ++++++++
 fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/efi.h         |  8 ++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 53ae25bbb6ac..d2eec5ed8e5e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -32,6 +32,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
 #include <linux/security.h>
+#include <linux/notifier.h>
 
 #include <asm/early_ioremap.h>
 
@@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
 	.is_visible = efi_attr_is_visible,
 };
 
+struct blocking_notifier_head efivar_ops_nh;
+EXPORT_SYMBOL_GPL(efivar_ops_nh);
+
 static struct efivars generic_efivars;
 static struct efivar_operations generic_ops;
 
@@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
+
 	error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
 	if (error) {
 		pr_err("efi: Sysfs attribute export failed with error %d.\n",
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index e9dc7116daf1..f654e6f6af87 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops)
 {
 	int rv;
+	int event;
 
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
@@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
 
 	__efivars = efivars;
 
+	if (efivar_supports_writes())
+		event = EFIVAR_OPS_RDWR;
+	else
+		event = EFIVAR_OPS_RDONLY;
+
+	blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
+
 	pr_info("Registered efivars operations\n");
 	rv = 0;
 out:
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 46c6446ec280..5751413d124c 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -15,11 +15,36 @@
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include <linux/statfs.h>
+#include <linux/notifier.h>
 
 #include "internal.h"
 
 LIST_HEAD(efivarfs_list);
 
+struct efivarfs_info {
+	struct super_block *sb;
+	struct notifier_block nb;
+};
+
+static struct efivarfs_info info;
+
+static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
+				 void *data)
+{
+	switch (event) {
+	case EFIVAR_OPS_RDONLY:
+		info.sb->s_flags |= SB_RDONLY;
+		break;
+	case EFIVAR_OPS_RDWR:
+		info.sb->s_flags &= ~SB_RDONLY;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -311,6 +336,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root)
 		return -ENOMEM;
 
+	info.sb = sb;
+	info.nb.notifier_call = efivarfs_ops_notifier;
+	err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
+	if (err)
+		return err;
+
 	INIT_LIST_HEAD(&efivarfs_list);
 
 	err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
@@ -348,6 +379,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 
 static void efivarfs_kill_sb(struct super_block *sb)
 {
+	blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
+	info.sb = NULL;
 	kill_litter_super(sb);
 
 	if (!efivar_is_available())
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 3db43957bf19..eacae0cf208c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1356,6 +1356,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+/*
+ * efivar ops event type
+ */
+#define EFIVAR_OPS_RDONLY 0
+#define EFIVAR_OPS_RDWR 1
+
+extern struct blocking_notifier_head efivar_ops_nh;
+
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
-- 
2.39.2

