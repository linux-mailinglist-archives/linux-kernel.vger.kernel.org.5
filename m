Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AEC77D2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbjHOTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbjHOTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EA1FF2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99772219A1;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RZMTb1rxLyBEVZU95vweXMEGYopGdvruEyyejDZppQ=;
        b=0Qp9+1vfiiYtF6EG6shZSaICf9cSAJgeWoeNg1/uvV9TI5PC+0YkHSexA4R/JrJw5Dr4d6
        kL8ymL/yG7VOj0BrWNtqioIcg1k6k50qqi8+QrmauxiTRuOsV+zcC/U5iU3ZIIFK0JOhxK
        8TaNg/FpdJYt+3mcxnqZRVlqgOz6cmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RZMTb1rxLyBEVZU95vweXMEGYopGdvruEyyejDZppQ=;
        b=8xWX4G98mxLuQSemC7ipDW41GHaHGhuB+4PV0tsFuRUW29LiE/O1xWbubCSP4tN5g/6VQb
        72t94gOF0coOo7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B97E1390C;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eCdXHZvL22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:47 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 03/25] ALSA: core: Add memory copy helpers between iov_iter and iomem
Date:   Tue, 15 Aug 2023 21:01:14 +0200
Message-Id: <20230815190136.8987-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two more helpers for copying memory between iov_iter and iomem,
which will be used by the new PCM copy ops in a few drivers.
The existing helpers became wrappers of those now.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is adjusted accordingly.

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
index 5d894dc32f7d..2d2d0094c897 100644
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
+	return copy_to_iter((const void __force *)src, count, dst) == count ? 0 : -EFAULT;
 #else
 	char buf[256];
 	while (count) {
@@ -31,16 +53,15 @@ int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size
 		if (c > sizeof(buf))
 			c = sizeof(buf);
 		memcpy_fromio(buf, (void __iomem *)src, c);
-		if (copy_to_user(dst, buf, c))
+		if (copy_to_iter(buf, c, dst) != c)
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
+	return copy_from_iter((void __force *)dst, count, src) == count ? 0 : -EFAULT;
 #else
 	char buf[256];
 	while (count) {
 		size_t c = count;
 		if (c > sizeof(buf))
 			c = sizeof(buf);
-		if (copy_from_user(buf, src, c))
+		if (copy_from_iter(buf, c, src) != c)
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

