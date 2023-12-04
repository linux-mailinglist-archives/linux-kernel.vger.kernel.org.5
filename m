Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94587803BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjLDRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjLDRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:48:30 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F8E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:48:36 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d7f68b059fso346107a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701712115; x=1702316915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcVLusmLSrs9AkT8FMUp6dSDeCayjrBTTW9J6mB7iK0=;
        b=p7JV8Y/caMj/APmX9TQww3gp1MqcfKw640XWFOTITkrvHvKPlsJSEgDTGGu+RhcFQK
         p9AJxipdLG4lfrjwRGPXAQpPup50BgTFtJLtX6JUK34QTchhzA6PqFuh7VVjhyhYOv7U
         qp8DvyqX212vmtK2mBhcIOywjYRtSyk/BFpiQoiI6xrSNqYBcEDvusqab0aRemETWEiM
         5IGO1bwHFx65NbzFXMwNdotjIyVCRaFOleDCKpmSAp1D8Ij6na/yfJiutaXRwTPQvUDC
         CrZ0Fk12YEA2f1+3fZSu3CcvKCpLJQeQJ6jOCrqnRKLwpxxH+qCHqysPgfepWgubSg/I
         Owdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712115; x=1702316915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcVLusmLSrs9AkT8FMUp6dSDeCayjrBTTW9J6mB7iK0=;
        b=SkHqXLN9q7VlLkiRd3ZOFMByChB6ocwuiFBBGQVICRwz3PExgD2ATjpBKWAmwPkGy9
         IzdTTU6pDTTi6FdOiXd9YRcAhxQZaAxoHznt95+ivkqbTiCB4nAxXAUboc5zUCSZ063Z
         biySJEhdbYnb8IfBjyWOPvqrmkRdq8PPWOELhLLapNj94HV11Q8vrFP+47fj6ARm7dVK
         BFzGRckW68p0sxNgw4yDZH+i7W0+K0Paowg3yPt7gQo09NEjDBl+lBTw521K55b9TPXT
         ZIlimawHc6bDrYPGPU9rPQ4Wk00mmt5JsNtlYuAixQnVV5OObWi+SyGfRD08fWLYRl6z
         l33w==
X-Gm-Message-State: AOJu0YyoLniAe4LXT9VEuTPfBVzDje7X09XR2bP6NYF9ylkvEzWdXUw7
        KGa+TsoDByro07mJXLAYWCN+iKUCr5JAo7BxvbaFGg==
X-Google-Smtp-Source: AGHT+IFwwDT3dr17ePNHc3E+3xSrdIz18L6eQUk3Fg9nNq0+KGjvlZav4WVn/0HnBS3ScCibRl1xTQ==
X-Received: by 2002:a05:6830:1b6a:b0:6d8:7e05:8e27 with SMTP id d10-20020a0568301b6a00b006d87e058e27mr7223708ote.3.1701712115402;
        Mon, 04 Dec 2023 09:48:35 -0800 (PST)
Received: from m2max.tfbnw.net ([2620:10d:c091:400::5:2355])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05622a610f00b00424059fe96esm3670981qtb.89.2023.12.04.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:48:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] iov_iter: replace import_single_range() with import_ubuf()
Date:   Mon,  4 Dec 2023 10:47:50 -0700
Message-ID: <20231204174827.1258875-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204174827.1258875-1-axboe@kernel.dk>
References: <20231204174827.1258875-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of the 'iov' argument to import_single_range(), the two
functions are now fully identical. Convert the import_single_range()
callers to import_ubuf(), and remove the former fully.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c         |  7 ++-----
 drivers/char/random.c            |  4 ++--
 fs/aio.c                         |  2 +-
 include/linux/uio.h              |  2 --
 kernel/trace/trace_events_user.c |  3 +--
 lib/iov_iter.c                   | 13 -------------
 net/ipv4/tcp.c                   |  8 ++++----
 net/socket.c                     |  4 ++--
 security/keys/keyctl.c           |  4 ++--
 9 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5656b0a1233d..3eaf02ebeebe 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -895,9 +895,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		struct iov_iter iter;
 		const int dir = ITER_DEST;
 
-		import_single_range(dir, u64_to_user_ptr(io->addr), rq_bytes,
-					&iter);
-
+		import_ubuf(dir, u64_to_user_ptr(io->addr), rq_bytes, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
@@ -918,8 +916,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
-		import_single_range(dir, u64_to_user_ptr(io->addr), io->res,
-					&iter);
+		import_ubuf(dir, u64_to_user_ptr(io->addr), io->res, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index e79ae238b30d..456be28ba67c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1384,7 +1384,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 			return ret;
 	}
 
-	ret = import_single_range(ITER_DEST, ubuf, len, &iter);
+	ret = import_ubuf(ITER_DEST, ubuf, len, &iter);
 	if (unlikely(ret))
 		return ret;
 	return get_random_bytes_user(&iter);
@@ -1501,7 +1501,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(len, p++))
 			return -EFAULT;
-		ret = import_single_range(ITER_SOURCE, p, len, &iter);
+		ret = import_ubuf(ITER_SOURCE, p, len, &iter);
 		if (unlikely(ret))
 			return ret;
 		ret = write_pool_user(&iter);
diff --git a/fs/aio.c b/fs/aio.c
index 251eeaef7fbf..4ea639509d41 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1498,7 +1498,7 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
 	size_t len = iocb->aio_nbytes;
 
 	if (!vectored) {
-		ssize_t ret = import_single_range(rw, buf, len, iter);
+		ssize_t ret = import_ubuf(rw, buf, len, iter);
 		*iovec = NULL;
 		return ret;
 	}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index bfafd3542fa7..bea9c89922d9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -347,8 +347,6 @@ ssize_t import_iovec(int type, const struct iovec __user *uvec,
 ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat);
-int import_single_range(int type, void __user *buf, size_t len,
-		 struct iov_iter *i);
 int import_ubuf(int type, void __user *buf, size_t len, struct iov_iter *i);
 
 static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4efc75d90a0d..e76f5e1efdf2 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2182,8 +2182,7 @@ static ssize_t user_events_write(struct file *file, const char __user *ubuf,
 	if (unlikely(*ppos != 0))
 		return -EFAULT;
 
-	if (unlikely(import_single_range(ITER_SOURCE, (char __user *)ubuf,
-					 count, &i)))
+	if (unlikely(import_ubuf(ITER_SOURCE, (char __user *)ubuf, count, &i)))
 		return -EFAULT;
 
 	return user_events_write_core(file, &i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d60c73354e1f..009875bc95aa 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1369,19 +1369,6 @@ ssize_t import_iovec(int type, const struct iovec __user *uvec,
 }
 EXPORT_SYMBOL(import_iovec);
 
-int import_single_range(int rw, void __user *buf, size_t len,
-			struct iov_iter *i)
-{
-	if (len > MAX_RW_COUNT)
-		len = MAX_RW_COUNT;
-	if (unlikely(!access_ok(buf, len)))
-		return -EFAULT;
-
-	iov_iter_ubuf(i, rw, buf, len);
-	return 0;
-}
-EXPORT_SYMBOL(import_single_range);
-
 int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
 {
 	if (len > MAX_RW_COUNT)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 57cf3adb191a..54d3c762d400 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1857,8 +1857,8 @@ static int receive_fallback_to_copy(struct sock *sk,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(ITER_DEST, (void __user *)copy_address,
-				  inq, &msg.msg_iter);
+	err = import_ubuf(ITER_DEST, (void __user *)copy_address, inq,
+			  &msg.msg_iter);
 	if (err)
 		return err;
 
@@ -1890,8 +1890,8 @@ static int tcp_copy_straggler_data(struct tcp_zerocopy_receive *zc,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(ITER_DEST, (void __user *)copy_address,
-				  copylen, &msg.msg_iter);
+	err = import_ubuf(ITER_DEST, (void __user *)copy_address, copylen,
+			  &msg.msg_iter);
 	if (err)
 		return err;
 	err = skb_copy_datagram_msg(skb, *offset, &msg, copylen);
diff --git a/net/socket.c b/net/socket.c
index 1f0d0e8d0a50..5d49ae0c1b79 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2163,7 +2163,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	struct msghdr msg;
 	int fput_needed;
 
-	err = import_single_range(ITER_SOURCE, buff, len, &msg.msg_iter);
+	err = import_ubuf(ITER_SOURCE, buff, len, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2228,7 +2228,7 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 	int err, err2;
 	int fput_needed;
 
-	err = import_single_range(ITER_DEST, ubuf, size, &msg.msg_iter);
+	err = import_ubuf(ITER_DEST, ubuf, size, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 193df7ca3ca8..10ba439968f7 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1255,8 +1255,8 @@ long keyctl_instantiate_key(key_serial_t id,
 		struct iov_iter from;
 		int ret;
 
-		ret = import_single_range(ITER_SOURCE, (void __user *)_payload, plen,
-					  &from);
+		ret = import_ubuf(ITER_SOURCE, (void __user *)_payload, plen,
+				  &from);
 		if (unlikely(ret))
 			return ret;
 
-- 
2.42.0

