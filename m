Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC777B7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjHNL5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjHNL43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813810D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED1B02199A;
        Mon, 14 Aug 2023 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQB22YUaqqsp9Lcc9VpyXGAbecK3pOiPSKbU17qgYNI=;
        b=V9QV+xTyT5G0+dZBA/zXvJVOsxOew8RJnlA/Cd+nUJSm4kOG+/WtY7LuiO6NApubG4yB/M
        hX+MERsd0qVp0CTAl+DV9aHV9bXzV0HocuJAtBvoKtWwrLoYYzMwnBclBQYr0Hp93t0xlv
        r59MQUnWwuX39sMc0jPfzmmPoFBWnVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQB22YUaqqsp9Lcc9VpyXGAbecK3pOiPSKbU17qgYNI=;
        b=9OYnNMGLdG5qDbG6B9FMxTf/mk7nEbquTyrzNOkI/DDsv7dkLFo+ectsH46Sb0kLM+ciAq
        SHtnVGtd37nwe2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC7B0138EE;
        Mon, 14 Aug 2023 11:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2P0kLUAW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:44 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/25] ALSA: core: Add memory copy helpers between iov_iter and iomem
Date:   Mon, 14 Aug 2023 13:55:01 +0200
Message-Id: <20230814115523.15279-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814115523.15279-1-tiwai@suse.de>
References: <20230814115523.15279-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two more helpers for copying memory between iov_iter and iomem,
which will be used by the new PCM copy ops in a few drivers.
The existing helpers became wrappers of those now.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h |  5 ++++
 sound/core/memory.c | 56 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ff4a0c1c93a2..f75beead79e3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1559,6 +1559,11 @@ static inline u64 pcm_format_to_bits(snd_pcm_format_t pcm_format)
 #define pcm_dbg(pcm, fmt, args...) \
 	dev_dbg((pcm)->card->dev, fmt, ##args)
 
+/* helpers for copying between iov_iter and iomem */
+int copy_to_iter_fromio(struct iov_iter *itert, const void __iomem *src,
+			size_t count);
+int copy_from_iter_toio(void __iomem *dst, struct iov_iter *iter, size_t count);
+
 struct snd_pcm_status64 {
 	snd_pcm_state_t state;		/* stream state */
 	u8 rsvd[4];
diff --git a/sound/core/memory.c b/sound/core/memory.c
index 5d894dc32f7d..e5b54cd73ed6 100644
--- a/sound/core/memory.c
+++ b/sound/core/memory.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <sound/core.h>
+#include <sound/pcm.h>
 
 /**
  * copy_to_user_fromio - copy data from mmio-space to user-space
@@ -21,9 +22,30 @@
  * Return: Zero if successful, or non-zero on failure.
  */
 int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size_t count)
+{
+	struct iov_iter iter;
+
+	if (import_ubuf(ITER_DEST, dst, count, &iter))
+		return -EFAULT;
+	return copy_to_iter_fromio(&iter, (const void __iomem *)src, count);
+}
+EXPORT_SYMBOL(copy_to_user_fromio);
+
+/**
+ * copy_to_iter_fromio - copy data from mmio-space to iov_iter
+ * @dst: the destination iov_iter
+ * @src: the source pointer on mmio
+ * @count: the data size to copy in bytes
+ *
+ * Copies the data from mmio-space to iov_iter.
+ *
+ * Return: Zero if successful, or non-zero on failure.
+ */
+int copy_to_iter_fromio(struct iov_iter *dst, const void __iomem *src,
+			size_t count)
 {
 #if defined(__i386__) || defined(CONFIG_SPARC32)
-	return copy_to_user(dst, (const void __force*)src, count) ? -EFAULT : 0;
+	return !copy_to_iter((const void __force *)src, count, dst) ? -EFAULT : 0;
 #else
 	char buf[256];
 	while (count) {
@@ -31,16 +53,15 @@ int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size
 		if (c > sizeof(buf))
 			c = sizeof(buf);
 		memcpy_fromio(buf, (void __iomem *)src, c);
-		if (copy_to_user(dst, buf, c))
+		if (!copy_to_iter(buf, c, dst))
 			return -EFAULT;
 		count -= c;
-		dst += c;
 		src += c;
 	}
 	return 0;
 #endif
 }
-EXPORT_SYMBOL(copy_to_user_fromio);
+EXPORT_SYMBOL(copy_to_iter_fromio);
 
 /**
  * copy_from_user_toio - copy data from user-space to mmio-space
@@ -53,23 +74,42 @@ EXPORT_SYMBOL(copy_to_user_fromio);
  * Return: Zero if successful, or non-zero on failure.
  */
 int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count)
+{
+	struct iov_iter iter;
+
+	if (import_ubuf(ITER_SOURCE, (void __user *)src, count, &iter))
+		return -EFAULT;
+	return copy_from_iter_toio((void __iomem *)dst, &iter, count);
+}
+EXPORT_SYMBOL(copy_from_user_toio);
+
+/**
+ * copy_from_iter_toio - copy data from iov_iter to mmio-space
+ * @dst: the destination pointer on mmio-space
+ * @src: the source iov_iter
+ * @count: the data size to copy in bytes
+ *
+ * Copies the data from iov_iter to mmio-space.
+ *
+ * Return: Zero if successful, or non-zero on failure.
+ */
+int copy_from_iter_toio(void __iomem *dst, struct iov_iter *src, size_t count)
 {
 #if defined(__i386__) || defined(CONFIG_SPARC32)
-	return copy_from_user((void __force *)dst, src, count) ? -EFAULT : 0;
+	return !copy_from_iter((void __force *)dst, count, src) ? -EFAULT : 0;
 #else
 	char buf[256];
 	while (count) {
 		size_t c = count;
 		if (c > sizeof(buf))
 			c = sizeof(buf);
-		if (copy_from_user(buf, src, c))
+		if (!copy_from_iter(buf, c, src))
 			return -EFAULT;
 		memcpy_toio(dst, buf, c);
 		count -= c;
 		dst += c;
-		src += c;
 	}
 	return 0;
 #endif
 }
-EXPORT_SYMBOL(copy_from_user_toio);
+EXPORT_SYMBOL(copy_from_iter_toio);
-- 
2.35.3

