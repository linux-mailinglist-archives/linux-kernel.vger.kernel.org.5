Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F37EC981
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjKORRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjKORRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:11 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EE1A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:07 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5411a36a37fso1451452a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068625; x=1700673425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRY8TG/l5J/FMDXcrN4aaEldbJZIXmAxT86BWF/4hG4=;
        b=a0jOtR2bW8gSOXR1RXl5TD9xOBl1EvWCCofjk7dwO2AalM+bJLbX/SVx8Ym+PamlBv
         o+Iwt9X0GtX0UOYg8xG0IxmsquBHaRAPmJePkE/NrjtB6z5HPOflU1yZCfNXOZ1iWqvD
         k0lC5KWC6hcxGr234sDhKWc2pXI9Oru6xoMfd+j3K6WjrbUzCSAsNCeZj8NTNwV2yDI0
         WFppN48oTZe+U4iXcVHN9vK2Ag10WopDhr3P7WFqyZaD3fyrPxR5ttd369xN8ZuDzmaV
         rZdCDAA/NwL5uEjNxYitwDBi8dyu2/sBTMQaenWKUQVh7V9zQ2gMESt41kKpj6Q+Pfmd
         GEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068625; x=1700673425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRY8TG/l5J/FMDXcrN4aaEldbJZIXmAxT86BWF/4hG4=;
        b=HjQ6JoxzfA0b7ZpgZgGYAQrQQPCIRgpThpT2y8E2Q8/Snpm6DVUpL82tIGJ7QqxjtU
         fRYZHFX1Hu0k9IGCYgKkZulUWfzQMwLfTdfM6XuRisI2bvfhtFQQ9MqCXqIFDRD4H+FU
         pi3s4s47yeBoPlNqBjudINOV0XSUiBrNN/DwGSHIIiphJsrxwo1WSw/Qwh6wDbZ+pT7P
         ajWU7XCPJwAQiCgic0pDC1q/Bx4ilCT7cwjAs+wssGTQkYxb8wvJvl8bpBJWOiEkwEMn
         IGtLgQmVYoe0lINCEGqyB3ThI4N8rSc+ENONyVa0oBmImflYd60sQuJRLOaMcAd3KbYZ
         N42Q==
X-Gm-Message-State: AOJu0Ywo798dA7xwnlWbmqOAxqq/LqN8jQjqiDvjwRZF49z/MskjK5Iw
        8msVS7uI2VbhDPhwSWk7HgyQ7F4+GPB2kWchuk8=
X-Google-Smtp-Source: AGHT+IEOG5AerWV4vOx8AuRc42o64gL06+fbFGWcKCfeIT2GBbZFlEcOhn/Yr4W2MhCZYOUvUqW8pWEYcTbHukKLs3o=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6402:156:b0:53d:ad8a:b0bd with
 SMTP id s22-20020a056402015600b0053dad8ab0bdmr104536edu.3.1700068625280; Wed,
 15 Nov 2023 09:17:05 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:35 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-7-sebastianene@google.com>
Subject: [PATCH v3 05/10] arm64: ptdump: Add hooks on debugfs file operations
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce callbacks invoked when the debugfs entry is accessed from
userspace. This hooks will allow us to allocate and prepare the memory
resources used by ptdump when the debugfs file is opened/closed.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |  7 +++++
 arch/arm64/mm/ptdump_debugfs.c  | 53 +++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 1f6e0aabf16a..9b2bebfcefbe 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -20,9 +20,16 @@ struct ptdump_info {
 	const struct addr_marker	*markers;
 	unsigned long			base_addr;
 	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
+	int (*ptdump_prepare_walk)(void *file_priv);
+	void (*ptdump_end_walk)(void *file_priv);
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
+
+struct ptdump_info_file_priv {
+	struct ptdump_info	info;
+	void			*file_priv;
+};
 #ifdef CONFIG_PTDUMP_DEBUGFS
 #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 7564519db1e6..3bf5de51e8c3 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -7,7 +7,8 @@
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
-	struct ptdump_info *info = m->private;
+	struct ptdump_info_file_priv *f_priv = m->private;
+	struct ptdump_info *info = &f_priv->info;
 
 	get_online_mems();
 	if (info->ptdump_walk)
@@ -15,7 +16,55 @@ static int ptdump_show(struct seq_file *m, void *v)
 	put_online_mems();
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(ptdump);
+
+static int ptdump_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct ptdump_info *info = inode->i_private;
+	struct ptdump_info_file_priv *f_priv;
+
+	f_priv = kzalloc(sizeof(struct ptdump_info_file_priv), GFP_KERNEL);
+	if (!f_priv)
+		return -ENOMEM;
+
+	memcpy(&f_priv->info, info, sizeof(*info));
+
+	ret = single_open(file, ptdump_show, f_priv);
+	if (ret) {
+		kfree(f_priv);
+		return ret;
+	}
+
+	if (info->ptdump_prepare_walk) {
+		ret = info->ptdump_prepare_walk(f_priv);
+		if (ret)
+			kfree(f_priv);
+	}
+
+	return ret;
+}
+
+static int ptdump_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *f = file->private_data;
+	struct ptdump_info_file_priv *f_priv = f->private;
+	struct ptdump_info *info = &f_priv->info;
+
+	if (info->ptdump_end_walk)
+		info->ptdump_end_walk(f_priv);
+
+	kfree(f_priv);
+
+	return single_release(inode, file);
+}
+
+static const struct file_operations ptdump_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= ptdump_release,
+};
 
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.43.0.rc0.421.g78406f8d94-goog

