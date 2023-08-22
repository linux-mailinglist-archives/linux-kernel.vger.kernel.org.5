Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E927848BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjHVRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjHVRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C4196;
        Tue, 22 Aug 2023 10:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F706641CA;
        Tue, 22 Aug 2023 17:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ACDC433C7;
        Tue, 22 Aug 2023 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726752;
        bh=SiVfJ4W6a/bmBWOS0Lq/pdyCODl7wLD9tUpQOHq7WzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNzgm/3GiZPJ5J3oBf1kz5gHZimMq0777J+bO3diprHkZ7qlloKmCuxisIybvuJaf
         avOIS3aLu9Nil/qcx/xy70XqlWgyUie0dSJZh51dIbtW6r0C8MEqDD8KZzXvS1Q7Rc
         OR12fo/FJHFcM1djpeqzljw8xXrpEf0NnH0Bm/dI0N88lMx+qi771OmFzJFu4IRHj2
         swwJhhqPhqvsWZvfmvRjsCPnVFa4fBEktCOUZpW6x/U+Yh5vznMwr6SdNY3RZiH+ot
         DYdzYjCLc84iTohK84Dw+tkffS/Gw2Fb+xj7uLPru+45hk7wNg7p0ZO4I/oYRYpOtX
         q+VW+a5YJVqhQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/6] tpm: Move buffer handling from static inlines to real functions
Date:   Tue, 22 Aug 2023 20:52:16 +0300
Message-Id: <20230822175221.2196136-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822175221.2196136-1-jarkko@kernel.org>
References: <20230822175221.2196136-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>

separate out the tpm_buf_... handling functions from static inlines in
tpm.h and move them to their own tpm-buf.c file.  This is a precursor
to adding new functions for other TPM type handling because the amount
of code will grow from the current 70 lines in tpm.h to about 200
lines when the additions are done.  200 lines of inline functions is a
bit too much to keep in a header file.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

v3: make tpm_buf_tag static
v4: remove space after spdx tag
v5: fix checkpatch.pl --strict issues
---
 drivers/char/tpm/Makefile  |  1 +
 drivers/char/tpm/tpm-buf.c | 87 ++++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h        | 86 ++++---------------------------------
 3 files changed, 97 insertions(+), 77 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 0222b1ddb310..ad3594e383e1 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -15,6 +15,7 @@ tpm-y += tpm-sysfs.o
 tpm-y += eventlog/common.o
 tpm-y += eventlog/tpm1.o
 tpm-y += eventlog/tpm2.o
+tpm-y += tpm-buf.o
 
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
new file mode 100644
index 000000000000..88ce1a5402de
--- /dev/null
+++ b/drivers/char/tpm/tpm-buf.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handing for tpm_buf structures to facilitate the building of commands
+ */
+
+#include <linux/module.h>
+#include <linux/tpm.h>
+
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
+		return -ENOMEM;
+
+	buf->flags = 0;
+	tpm_buf_reset(buf, tag, ordinal);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init);
+
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset);
+
+void tpm_buf_destroy(struct tpm_buf *buf)
+{
+	free_page((unsigned long)buf->data);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_destroy);
+
+u32 tpm_buf_length(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be32_to_cpu(head->length);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_length);
+
+void tpm_buf_append(struct tpm_buf *buf,
+		    const unsigned char *new_data,
+		    unsigned int new_len)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 len = tpm_buf_length(buf);
+
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_OVERFLOW)
+		return;
+
+	if ((len + new_len) > PAGE_SIZE) {
+		WARN(1, "tpm_buf: overflow\n");
+		buf->flags |= TPM_BUF_OVERFLOW;
+		return;
+	}
+
+	memcpy(&buf->data[len], new_data, new_len);
+	head->length = cpu_to_be32(len + new_len);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append);
+
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
+{
+	tpm_buf_append(buf, &value, 1);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
+
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
+{
+	__be16 value2 = cpu_to_be16(value);
+
+	tpm_buf_append(buf, (u8 *)&value2, 2);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
+
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
+{
+	__be32 value2 = cpu_to_be32(value);
+
+	tpm_buf_append(buf, (u8 *)&value2, 4);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..60032c60994b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -326,84 +326,16 @@ struct tpm2_hash {
 	unsigned int tpm_id;
 };
 
-static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	head->tag = cpu_to_be16(tag);
-	head->length = cpu_to_be32(sizeof(*head));
-	head->ordinal = cpu_to_be32(ordinal);
-}
-
-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!buf->data)
-		return -ENOMEM;
-
-	buf->flags = 0;
-	tpm_buf_reset(buf, tag, ordinal);
-	return 0;
-}
-
-static inline void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	free_page((unsigned long)buf->data);
-}
-
-static inline u32 tpm_buf_length(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be32_to_cpu(head->length);
-}
-
-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be16_to_cpu(head->tag);
-}
-
-static inline void tpm_buf_append(struct tpm_buf *buf,
-				  const unsigned char *new_data,
-				  unsigned int new_len)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-	u32 len = tpm_buf_length(buf);
-
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
-		return;
-
-	if ((len + new_len) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
-		return;
-	}
 
-	memcpy(&buf->data[len], new_data, new_len);
-	head->length = cpu_to_be32(len + new_len);
-}
-
-static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
-{
-	tpm_buf_append(buf, &value, 1);
-}
-
-static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
-{
-	__be16 value2 = cpu_to_be16(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 2);
-}
-
-static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
-{
-	__be32 value2 = cpu_to_be32(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 4);
-}
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_destroy(struct tpm_buf *buf);
+u32 tpm_buf_length(struct tpm_buf *buf);
+void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
+		    unsigned int new_len);
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.39.2

