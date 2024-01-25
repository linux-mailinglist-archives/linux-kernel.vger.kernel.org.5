Return-Path: <linux-kernel+bounces-39395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625F83D025
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1037928EC28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4741B7F0;
	Thu, 25 Jan 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fksUhXYA"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97241947F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223476; cv=none; b=DVztmlm0tu8XouYaCp/B4+H889OO1fylKwZ3w82UkVOCVeDBNWt9YKwex+7xNINxi4jFFuCkmB4M9kvZzPqwYoYMvZVdqxXW5ffWdgpMi0HQLAIcpsD6ZjFjoaBnt80eqLBmiZ3oCbiKhmgBqbR5OUaIiyimypVldW4yZSBFk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223476; c=relaxed/simple;
	bh=BCSqrZ9DLkXBlfucIFiKDapTJzswZizsRiSDn8OrvBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIkWXlN1pbVP9eVReuzVPEithW27sz/eUdnSRyEI+2efYvb5zzSAsf//0+8tlvxVKdy7eC+wBURiRdcE7Spj/T4+ZZOcyfn2n3v6X6KXcHhURp9o83rOUse1kA5r5Qdj9ZSDHuZvWhcsUd1Yd7WQ5rHXtXe9WUeYD0MkCOZGLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fksUhXYA; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-599ef8b1c35so27555eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706223473; x=1706828273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGA3mbdBd/zeAlBJTaRnqUyMp6Mg1t+BBnoYkgoxqFQ=;
        b=fksUhXYAa2oMRpsDfRj3YHst/iyi9aJLZRzTEHZ++MaS/NLAOoBSKbwG2gZ6UKH4RL
         mD63+XN/vjWEf2f10Qm4OtbHDZgVd3nMJsoOEvzv/PdPpfsdTEH8fEe/myeHQ9go0cmV
         DPM9PbYHXWGRyJd89tPDG9zTkoViWNpLnM6DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706223473; x=1706828273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGA3mbdBd/zeAlBJTaRnqUyMp6Mg1t+BBnoYkgoxqFQ=;
        b=sZ4tlV43uocpcwnpwkkXFmkxGMPUXc0D1ecQh50UfYuGYH0XVsRYsE1pmP2kInjG1U
         2kTDCFaichmt19PPIbl1C/29iTiH1Z17WOk5eh0wX3ZiS5lz9yjodUWmzW8umqjshVnG
         d3wCpJR7du7/PxTMb9ML75Lo7rdag5s68wDuINOViMTEkLmoA2yCvByf+ApEqF6BlO+s
         iXzMKhKKb39YKdhOcoDpZdYkK+XHikv5r6RMsSu4D/JJT9Di3GPXuxXDQ+haMh0YTcRR
         RkCQ/4jqcwL/kJlfArCQ+emhuveMt+qCdE7vIuCixnSOVMu/t5m9nsgN6r1Axw8xX5PD
         tGlg==
X-Gm-Message-State: AOJu0Yyk4Z0n9kpM2XiWqOfaKwq/TCXZm53ypD4PDyAAmaHvgluSQaWL
	J2WFrPSqzTUxtohZhaRrWThScamTt38ZyjplKQcURVUzLX6/e3sryWqmE2DHZfbZNIYU6b0J3Ad
	mLGKq9JtS6nWVsHQMTU9AfY3Tg1DOLzgOaBuWa7pmCR9Snn3z/8BWdBPNXCB1TX5S7HM5ekBjKN
	SmhIGQ/AUnQAqxyiAsOvw1XRwAZMZ0E7X93Y1argBM8kwatg==
X-Google-Smtp-Source: AGHT+IEW3JEFunoyoy41GaLatn9iHiQYtfrDt4/zCyJCdZFj9Cft/+u3rpHHfPKfkDooPlp9bHhGaQ==
X-Received: by 2002:a05:6358:9497:b0:176:916b:462b with SMTP id i23-20020a056358949700b00176916b462bmr515749rwb.4.1706223473551;
        Thu, 25 Jan 2024 14:57:53 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z24-20020a631918000000b005d68962e1a7sm19948pgl.24.2024.01.25.14.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:57:53 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for epoll_params
Date: Thu, 25 Jan 2024 22:56:59 +0000
Message-Id: <20240125225704.12781-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125225704.12781-1-jdamato@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ioctl for getting and setting epoll_params. User programs can use
this ioctl to get and set the busy poll usec time or packet budget
params for a specific epoll context.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 64 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 12 ++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..b33918232f78 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
 0x89  0B-DF  linux/sockios.h
 0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
 0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
+0x8A  00-1F  linux/eventpoll.h
 0x8B  all    linux/wireless.h
 0x8C  00-3F                                                          WiNRADiO driver
                                                                      <http://www.winradio.com.au/>
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 40bd97477b91..73ae886efb8a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -6,6 +6,8 @@
  *  Davide Libenzi <davidel@xmailserver.org>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -37,6 +39,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/capability.h>
 #include <net/busy_poll.h>
 
 /*
@@ -495,6 +498,39 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	ep->napi_id = napi_id;
 }
 
+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct eventpoll *ep;
+	struct epoll_params epoll_params;
+	void __user *uarg = (void __user *) arg;
+
+	ep = file->private_data;
+
+	switch (cmd) {
+	case EPIOCSPARAMS:
+		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
+			return -EFAULT;
+
+		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
+		    !capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
+		ep->busy_poll_budget = epoll_params.busy_poll_budget;
+		return 0;
+	case EPIOCGPARAMS:
+		memset(&epoll_params, 0, sizeof(epoll_params));
+		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
+		epoll_params.busy_poll_budget = ep->busy_poll_budget;
+		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
+			return -EFAULT;
+		return 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -510,6 +546,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
 {
 	return false;
 }
+
+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -869,6 +911,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		ep_free(ep);
 }
 
+static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	if (!is_file_epoll(file))
+		return -EINVAL;
+
+	switch (cmd) {
+	case EPIOCSPARAMS:
+	case EPIOCGPARAMS:
+		ret = ep_eventpoll_bp_ioctl(file, cmd, arg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int ep_eventpoll_release(struct inode *inode, struct file *file)
 {
 	struct eventpoll *ep = file->private_data;
@@ -975,6 +1037,8 @@ static const struct file_operations eventpoll_fops = {
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= ep_eventpoll_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index cfbcc4cc49ac..8eb0fdbce995 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -85,4 +85,16 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+struct epoll_params {
+	u64 busy_poll_usecs;
+	u16 busy_poll_budget;
+
+	/* for future fields */
+	u8 data[118];
+} EPOLL_PACKED;
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.25.1


