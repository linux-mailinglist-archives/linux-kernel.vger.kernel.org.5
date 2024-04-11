Return-Path: <linux-kernel+bounces-140760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081418A18C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29472872B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7018AE0;
	Thu, 11 Apr 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nry89w5o"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6115E85
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849498; cv=none; b=WxYHkNuBmLhs91BU1XoRsEJIz3nVpC0E1pTHF+ZzrsPyBK/kToAB7iuqH7avsjK8Zt21BiB3T3hm8X3ouI2fFccA89fCEkT3QV1ZfM+qhO8Wm0vbw2ss8Md7EUkiQyEMAKYTPamJLk6fjaQR6pbwz6uUz14vDIBGwKX6WRPilxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849498; c=relaxed/simple;
	bh=zl9Msdkd0nKzFoMLDCdsFP4j4tTnGoCIX29BIyR8eJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYyaVjbCAgw2u8iLw65bxo34+TfGCgiL0ljY2UfMhDfaGIWOqxRtFMAVRcmbKJwcH1Mexf23TKXJlkef7sTAaU4Q/a+Jd5mIPdUvd10QzMs2QAXnf0IWDvRLWhXlaj5uGRFFC2Nh51E9XTI4JXqexAQIthXosRdYq8M74n/Nyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nry89w5o; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69474339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849495; x=1713454295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y1MiOXGemo/TYam3ZjcBOEptr5sK5Ww3DxqkARLkVA=;
        b=Nry89w5o0NzJsYHsdZGweo/b+scWzyHZ+uc2rn6IEwTaXGab8Uq+igF7vFYQewUFVe
         11GBYFr91edzBJwzrZlPxTJbjDDs2azMroAh57poRUVQrMuOWX4gn3sQrvPntTZ3v1zS
         X+UCiZQTVQJ0530BalnN4McJdJlcnktqo6Q5aTJ/DXT6TBz25Y3hsmgHcRpNMK/ze6DU
         WfGpm9UyEMfRQr7M1h01wSRsz2ag5Vu2K2ZT0egNNdO/JMB5cQIi5MNnevDa2NArtkCh
         aGzicfNmZqZE55G8udoHbk4WIxMkAyUqZEKboe6saXT2nmq+s8hQ+QX1N9ja/ppipk8S
         8auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849495; x=1713454295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y1MiOXGemo/TYam3ZjcBOEptr5sK5Ww3DxqkARLkVA=;
        b=ShzxvFa+3mYNG126eTNmaw82ioXmF+9bp1iml/SiANKZlghDyd4beyVtsNGAymkpff
         enuyd9+F1QnX8N1GHDsVYfjK4geLZcudu5nXsunMPh0q3BiCeMl6lQAOo8NE8umseY5k
         te/3mGn918F0F8ijrQx2hZkhso2jaQH5LkWyOeYrjWV/LQrNKPIIHhB5p63WJ92mMXOu
         gn/aTtoooHCWi1j2+kp+SdU1js1PSVImHI9Lg5FYzZmdgYyhFrimefHRnlyu9uOePeTH
         T7bSwiQscIVX7mnNE9HY+IdvetL01ffqUF4PdW/gPXnsS7C5lpujYfNiJJTXMpUoCo9g
         FMQg==
X-Gm-Message-State: AOJu0Yw8HkhBPlWJV+l+7NPZppd9z125I6WMY2D2CIpB5m4EfoClZ4ac
	VcGcksHG5SiFdIX4KxcmO66Zz6r/iH/k7w1tbt2hVvjG6K/xIEmxL6a9AF0CNlMx4E15eZv1EQB
	M
X-Google-Smtp-Source: AGHT+IFQ3QOTzL5/dGQPgVmdYNRGJWtEW/djL7xOVilycMQmk8ilbkP+TblwbyajMiq7Kbm6TUjd1w==
X-Received: by 2002:a05:6e02:1d87:b0:36a:fba4:ec45 with SMTP id h7-20020a056e021d8700b0036afba4ec45mr3413130ila.3.1712849494840;
        Thu, 11 Apr 2024 08:31:34 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 004/437] fs: add simple_copy_{to,from}_iter() helpers
Date: Thu, 11 Apr 2024 09:12:24 -0600
Message-ID: <20240411153126.16201-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While doing so, rename the networking helper that has the same name.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/libfs.c          | 73 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h  |  5 ++++
 net/core/datagram.c | 10 +++----
 3 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3a6f2cb364f8..074cfacc377f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1102,13 +1102,84 @@ ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 	if (count > available - pos)
 		count = available - pos;
 	res = copy_from_user(to + pos, from, count);
+	if (res < 0)
+		return res;
+	count -= res;
+	*ppos = pos + count;
+	return count;
+}
+EXPORT_SYMBOL(simple_write_to_buffer);
+
+/**
+ * simple_copy_to_iter - copy data userspace to iter
+ * @from: the buffer to read from
+ * @ppos: the current position in the buffer
+ * @count: the maximum number of bytes to copy
+ * @to: the iov_iter to copy to
+ *
+ * The simple_copy_to_iter() function reads up to @count bytes from the
+ * buffer @from at offset @ppos into the user space address starting at @to.
+ *
+ * On success, the number of bytes copied is returned, or negative value is
+ * returned on error.
+ **/
+ssize_t simple_copy_to_iter(const void *from, loff_t *ppos, size_t count,
+			    struct iov_iter *to)
+{
+	size_t available = iov_iter_count(to);
+	loff_t pos = *ppos;
+	size_t ret;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	ret = copy_to_iter(from + pos, count, to);
+	if (ret < 0)
+		return ret;
+	count -= ret;
+	*ppos = pos + count;
+	return count;
+}
+EXPORT_SYMBOL(simple_copy_to_iter);
+
+/**
+ * simple_copy_from_iter - copy data from iter to user space buffer
+ * @to: the buffer to write to
+ * @available: the size of the buffer
+ * @ppos: the current position in the buffer
+ * @from: the user space buffer to read from
+ * @count: the maximum number of bytes to read
+ *
+ * The simple_write_to_buffer() function reads up to @count bytes from the user
+ * space address starting at @from into the buffer @to at offset @ppos.
+ *
+ * On success, the number of bytes written is returned and the offset @ppos is
+ * advanced by this number, or negative value is returned on error.
+ **/
+ssize_t simple_copy_from_iter(void *to, loff_t *ppos, size_t count,
+			      struct iov_iter *from)
+{
+	size_t available = iov_iter_count(to);
+	loff_t pos = *ppos;
+	size_t res;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	res = copy_from_iter(to + pos, count, from);
 	if (res == count)
 		return -EFAULT;
 	count -= res;
 	*ppos = pos + count;
 	return count;
 }
-EXPORT_SYMBOL(simple_write_to_buffer);
+EXPORT_SYMBOL(simple_copy_from_iter);
 
 /**
  * memory_read_from_buffer - copy data from the buffer
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 72de0b1d5647..f75049fa1d50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3353,6 +3353,11 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+ssize_t simple_copy_to_iter(const void *from, loff_t *ppos, size_t count,
+			    struct iov_iter *to);
+ssize_t simple_copy_from_iter(void *to, loff_t *ppos, size_t count,
+			      struct iov_iter *from);
+
 struct offset_ctx {
 	struct maple_tree	mt;
 	unsigned long		next_offset;
diff --git a/net/core/datagram.c b/net/core/datagram.c
index a8b625abe242..3dfdddeaf695 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -399,7 +399,7 @@ int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags)
 }
 EXPORT_SYMBOL(skb_kill_datagram);
 
-INDIRECT_CALLABLE_DECLARE(static size_t simple_copy_to_iter(const void *addr,
+INDIRECT_CALLABLE_DECLARE(static size_t __simple_copy_to_iter(const void *addr,
 						size_t bytes,
 						void *data __always_unused,
 						struct iov_iter *i));
@@ -417,7 +417,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
-		n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+		n = INDIRECT_CALL_1(cb, __simple_copy_to_iter,
 				    skb->data + offset, copy, data, to);
 		offset += n;
 		if (n != copy)
@@ -440,7 +440,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 
 			if (copy > len)
 				copy = len;
-			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+			n = INDIRECT_CALL_1(cb, __simple_copy_to_iter,
 					vaddr + skb_frag_off(frag) + offset - start,
 					copy, data, to);
 			kunmap(page);
@@ -526,7 +526,7 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
 
-static size_t simple_copy_to_iter(const void *addr, size_t bytes,
+static size_t __simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
 	return copy_to_iter(addr, bytes, i);
@@ -544,7 +544,7 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 {
 	trace_skb_copy_datagram_iovec(skb, len);
 	return __skb_datagram_iter(skb, offset, to, len, false,
-			simple_copy_to_iter, NULL);
+			__simple_copy_to_iter, NULL);
 }
 EXPORT_SYMBOL(skb_copy_datagram_iter);
 
-- 
2.43.0


