Return-Path: <linux-kernel+bounces-31649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C426A8331EA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746D6284F91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFDE17D4;
	Sat, 20 Jan 2024 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vvkQbQLb"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42285650
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711433; cv=none; b=k8yx+CUg+EN+U0RbkIfs4SMfg3nogg2dNlR9gbSolMI7+QV4oRf3oSckBUoK72Zpb7G4pEnYoBt7NOUFRQxdIhlF8EGBusf9AE8BwnVwqcGLz3YYm3sZt/NolDThHpBMmqajVNVdSTLaJpEE8G1wEWc51peTPQ94FlaPFkMGT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711433; c=relaxed/simple;
	bh=leyeBcFJkOelhkt5ST2SMMVIL20doBYceJpBDtuL/v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTKzd9G0SngTTlmVJk85o5Y2SMtSvvJFIk1CxB+xP29zxWiKwvlmNRrkr5CLn7fMJsysEF7OSe9ZV6EcxOAn+mBsx8EEkIJ5tWtbHqR8AUDJ9wD1yi2bgKlbJQa9PEcnWb0wC80wiy/H7GJwDhZu8y75w9Bb7IfJI2/EdAdCO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vvkQbQLb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3606dc4fdf2so6401305ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1705711429; x=1706316229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46obnkf6HiNspFca0IexytJkMImH/ly796+NnSx1ch0=;
        b=vvkQbQLblhuJ7aeH9EqTZIwRdx/VIjTWUHgEcxNAOzfzeiJxm9zvXv7dWWk3C5Nl//
         bNO06zAlN2MP0k96uPqcO8Dvkfjw3ppZpGqiqHcm5FCkZs6WArkq9bgX8j9rYZXcEaJC
         isgcyzCXRKDBiROTCTSsjWGcSomsOkAaeuv6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705711429; x=1706316229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46obnkf6HiNspFca0IexytJkMImH/ly796+NnSx1ch0=;
        b=Xn+aOw4x7xYJ7YUentAGZQv251GMEtAJ6CGyZ/Daffe21pj5+nH2NI4Foh8FymtlHz
         0KUlJd+qV/czOYE9rfN0D7+X4kBV+SdIis6Gun+kK+zqCfmI/e0jPB+preAev0jbO5tY
         iIP2AQghUqKpXzhBLjM8HQY/BAhYt7LTVznU7Ot1q96zZ0bQqHjH84gatDViMfxCvLvJ
         Ya1iaMRUFfxtdPABsnPowRecyPhD/vD6Hbzbqdxl64kk5ATSR/OFn5nYFotTM5OZH552
         Xe2zqQF6G0XRqhDDH2XvvVBZpjvY0AjMam2FEvGvQsBe8y8hB74iu39YiUA8NTYrHDBO
         A5ZQ==
X-Gm-Message-State: AOJu0Yxyk+bse9H15+LnERu9PzOsWzV2G5BjZDRvNzFpJ5GuzcFRgiyU
	+U2M7aH0gdvqDBIhSwBTCC9PXK8073ZM6SjUDxYfoTXhrCWKyuwHjetV2TrhCNI=
X-Google-Smtp-Source: AGHT+IEiLauMOX12GtSj1Q05/y33vn5vvIkQZdiE2JeowwT1m/qjSZxd/D3a+Q2jcRdJVaLHE4vNdg==
X-Received: by 2002:a05:6e02:1b0e:b0:35f:b29c:d2ab with SMTP id i14-20020a056e021b0e00b0035fb29cd2abmr919408ilv.34.1705711429426;
        Fri, 19 Jan 2024 16:43:49 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p7-20020a170903248700b001cf6783fd41sm3563800plw.17.2024.01.19.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 16:43:48 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC 1/1] eventpoll: support busy poll per epoll instance
Date: Sat, 20 Jan 2024 00:42:47 +0000
Message-Id: <20240120004247.42036-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240120004247.42036-1-jdamato@fastly.com>
References: <20240120004247.42036-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add F_EPOLL_{S,G}ET_BUSY_POLL_USECS to allow setting a busy poll timeout
per epoll instance so that individual applications can enable (or
disable) epoll based busy poll as needed.

Prior to this change, epoll-based busy poll could only be enabled
system-wide, which limits the usefulness of busy poll.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c                   | 71 ++++++++++++++++++++++++++++++--
 fs/fcntl.c                       |  5 +++
 include/linux/eventpoll.h        |  2 +
 include/uapi/linux/fcntl.h       |  6 +++
 tools/include/uapi/linux/fcntl.h |  6 +++
 tools/perf/trace/beauty/fcntl.c  |  3 +-
 6 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..a8087c2b47ef 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -227,6 +227,8 @@ struct eventpoll {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
+	/* busy poll timeout */
+	u64 busy_poll_usecs;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -386,12 +388,39 @@ static inline int ep_events_available(struct eventpoll *ep)
 		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
 }
 
+/**
+ * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
+ * from the epoll instance ep is preferred, but if it is not set fallback to
+ * the system-wide global via busy_loop_timeout.
+ */
+static inline bool busy_loop_ep_timeout(unsigned long start_time, struct eventpoll *ep)
+{
 #ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned long bp_usec = READ_ONCE(ep->busy_poll_usecs);
+
+	if (bp_usec) {
+		unsigned long end_time = start_time + bp_usec;
+		unsigned long now = busy_loop_current_time();
+
+		return time_after(now, end_time);
+	} else {
+		return busy_loop_timeout(start_time);
+	}
+#endif
+	return true;
+}
+
+#ifdef CONFIG_NET_RX_BUSY_POLL
+static bool ep_busy_loop_on(struct eventpoll *ep)
+{
+	return !!ep->busy_poll_usecs ^ net_busy_loop_on();
+}
+
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
 {
 	struct eventpoll *ep = p;
 
-	return ep_events_available(ep) || busy_loop_timeout(start_time);
+	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
 }
 
 /*
@@ -404,7 +433,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
-	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
+	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
 			       BUSY_POLL_BUDGET);
 		if (ep_events_available(ep))
@@ -430,7 +459,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	struct socket *sock;
 	struct sock *sk;
 
-	if (!net_busy_loop_on())
+	ep = epi->ep;
+	if (!ep_busy_loop_on(ep))
 		return;
 
 	sock = sock_from_file(epi->ffd.file);
@@ -442,7 +472,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 		return;
 
 	napi_id = READ_ONCE(sk->sk_napi_id);
-	ep = epi->ep;
 
 	/* Non-NAPI IDs can be rejected
 	 *	or
@@ -466,6 +495,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 {
 }
 
+static inline bool ep_busy_loop_on(struct eventpoll *ep)
+{
+	return false;
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -933,6 +966,33 @@ static const struct file_operations eventpoll_fops = {
 	.llseek		= noop_llseek,
 };
 
+unsigned long eventpoll_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	struct eventpoll *ep;
+
+	if (!is_file_epoll(file))
+		return -EINVAL;
+
+	ep = file->private_data;
+
+	switch (cmd) {
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	case F_EPOLL_SET_BUSY_POLL_USECS:
+		ret = ep->busy_poll_usecs = arg;
+		break;
+	case F_EPOLL_GET_BUSY_POLL_USECS:
+		ret = ep->busy_poll_usecs;
+		break;
+#endif
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 /*
  * This is called from eventpoll_release() to unlink files from the eventpoll
  * interface. We need to have this facility to cleanup correctly files that are
@@ -2058,6 +2118,9 @@ static int do_epoll_create(int flags)
 		error = PTR_ERR(file);
 		goto out_free_fd;
 	}
+#ifndef CONFIG_NET_RX_BUSY_POLL
+	ep->busy_poll_usecs = 0;
+#endif
 	ep->file = file;
 	fd_install(fd, file);
 	return fd;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742..f232e7c2eb9d 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/sched/task.h>
+#include <linux/eventpoll.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
 #include <linux/file.h>
@@ -419,6 +420,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_EPOLL_GET_BUSY_POLL_USECS:
+	case F_EPOLL_SET_BUSY_POLL_USECS:
+		err = eventpoll_fcntl(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 3337745d81bd..3e6a49d14f52 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -22,6 +22,8 @@ struct file;
 struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long toff);
 #endif
 
+unsigned long eventpoll_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
+
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 282e90aeb163..522134ab9580 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -56,6 +56,12 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Set/Get busy poll usecs for an epoll instance.
+ */
+#define F_EPOLL_GET_BUSY_POLL_USECS (F_LINUX_SPECIFIC_BASE + 15)
+#define F_EPOLL_SET_BUSY_POLL_USECS (F_LINUX_SPECIFIC_BASE + 16)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 6c80f96049bd..1937f8b74783 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -56,6 +56,12 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Set/Get busy poll usecs for an epoll instance.
+ */
+#define F_EPOLL_GET_BUSY_POLL_USECS (F_LINUX_SPECIFIC_BASE + 15)
+#define F_EPOLL_SET_BUSY_POLL_USECS (F_LINUX_SPECIFIC_BASE + 16)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 56ef83b3d130..dae5647c5c1a 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -94,7 +94,8 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 	    cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
 	    cmd == F_GETOWN_EX || cmd == F_SETOWN_EX ||
 	    cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
-	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
+	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT ||
+	    cmd == F_EPOLL_GET_BUSY_POLL_USECS || cmd == F_EPOLL_SET_BUSY_POLL_USECS)
 		return syscall_arg__scnprintf_hex(bf, size, arg);
 
 	return syscall_arg__scnprintf_long(bf, size, arg);
-- 
2.25.1


