Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B6F7F37FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjKUVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjKUVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:17:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B510E2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:17:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C15C433C8;
        Tue, 21 Nov 2023 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700601463;
        bh=Gw6t4yKIoJH0jVM58wLhTCrKliCl3oXQG36AlAIlWHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3N63W7O+mAyzycndV7HyNu7prGb6dNGDn1fHnPWrHEGNyi10ffUvgBuoZP5OIbil
         tIr0Bd+r+0S89lcmCNo0LL9PyY5EyjJDPg+iKQHNCvfU6NWtEn0cVO+UMnOsEF441o
         wkSb43Xk7pWNJUoi6+PE40PH1EHIpmMiZC4kqiYilnISC1xopZ23dA39CBanFkczY9
         TIGq0p4yK4UVAydvppuqaS4RvGBNj/4t5v4Ah/OD/23Imtts/iJjrBRmDGYhvWdObV
         gxWuUH8+JmpLmvA/hfPGEXt1bWBFrVDxkMUiqM5eTZ6lcE+yPcLycDYtp7W5DG9OFG
         EVoNTpZjI+kfg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>
Subject: [PATCH v4 6/8] tpm: TPM2B formatted buffers
Date:   Tue, 21 Nov 2023 23:17:15 +0200
Message-ID: <20231121211717.31681-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121211717.31681-1-jarkko@kernel.org>
References: <20231121211717.31681-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare tpm_buf_init_sized() and tpm_buf_reset_sized() for creating TPM2B
formatted buffers. These buffers are also known as sized buffers in the
specifications and literature.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2: [2021-11-21] Refine the API according to the comments for
    https://lore.kernel.org/linux-integrity/20231024011531.442587-5-jarkko@kernel.org/
---
 drivers/char/tpm/tpm-buf.c | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/tpm.h        |  4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 545d9c74abf1..12bfade11372 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -48,6 +48,36 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
+/**
+ * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
+ * @buf:	A @tpm_buf
+ *
+ * Return: 0 or -ENOMEM
+ */
+int tpm_buf_init_sized(struct tpm_buf *buf)
+{
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
+		return -ENOMEM;
+
+	tpm_buf_reset_sized(buf);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
+
+/**
+ * tpm_buf_reset_sized() - Initialize a sized buffer
+ * @buf:	A &tpm_buf
+ */
+void tpm_buf_reset_sized(struct tpm_buf *buf)
+{
+	buf->flags = TPM_BUF_TPM2B;
+	buf->length = 2;
+	buf->data[0] = 0;
+	buf->data[1] = 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
+
 void tpm_buf_destroy(struct tpm_buf *buf)
 {
 	free_page((unsigned long)buf->data);
@@ -73,8 +103,6 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
@@ -87,7 +115,11 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 
 	memcpy(&buf->data[buf->length], new_data, new_length);
 	buf->length += new_length;
-	head->length = cpu_to_be32(buf->length);
+
+	if (buf->flags & TPM_BUF_TPM2B)
+		((__be16 *)buf->data)[0] = cpu_to_be16(buf->length - 2);
+	else
+		((struct tpm_header *)buf->data)->length = cpu_to_be32(buf->length);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1d7b39b5c383..715db4a91c1f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -300,6 +300,8 @@ struct tpm_header {
 enum tpm_buf_flags {
 	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
+	/* TPM2B format: */
+	TPM_BUF_TPM2B		= BIT(1),
 };
 
 /*
@@ -328,6 +330,8 @@ struct tpm2_hash {
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_sized(struct tpm_buf *buf);
+void tpm_buf_reset_sized(struct tpm_buf *buf);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
-- 
2.42.1

