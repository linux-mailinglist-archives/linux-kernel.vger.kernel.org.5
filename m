Return-Path: <linux-kernel+bounces-46956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B918446DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4FF0B25623
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2413BEB6;
	Wed, 31 Jan 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PMtahE2n"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B713BEAF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724590; cv=none; b=h56z2cNjniMALUwWVnmZWqDnbq8Fyx9vvnIZ7+xbvkZaX16r4iBYdoVThdRYn8h/t55h3wWfUT4uenPWmqWTXJxJmVDf4lVD8wdtpzHxcn9K8dayEaZK5T8qQKMbL7MmJVgKT2/kcAVWT+65n+kjd1cQ1XP9v9IZxKcITUjuON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724590; c=relaxed/simple;
	bh=7A7sHroL9Ow9RB5SlrBbD5eZxpWYWwUbOvldYd9/zgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Adc7eyRGUq5v15G0T39achKMt5JdRGKYwsLAJlCgBOmlL9q4HOBacVTa+1clx7P4yavwhsMyjr84fYlf8ia39M2sa4+7w6uujAA+7T8kUT7+5UvvIAT3dPBMjBRT5GkGDfOwnNq5q+3I/G8r3hWqPHgOuhlKOom56tnqp+d3FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PMtahE2n; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-599f5e71d85so44271eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706724586; x=1707329386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL7KL2gLPbAb4hjqxQ9bqO5kTIW0debt+d1tm+r3LDo=;
        b=PMtahE2nzTI6NrcNsv9ux64CWk/ga8Ey3k8fsDCJ0ka8O1FdG2frROY36f64eLQRJ/
         qekG4muZzU9V9FEvI5Yg+W0zvkg56aWQotkl/G0V3QG+ifqSLBdvS2sQqPcj/IKFPRbm
         d//41RqxlWTDNRZYpxI8z5FEEPwkD5Tt3cmw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724586; x=1707329386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL7KL2gLPbAb4hjqxQ9bqO5kTIW0debt+d1tm+r3LDo=;
        b=OrExe0Li+R3LYsXTlc52giSRKcmhfENnT3/WP7sSvwd+w81npmoaBdoVVKD9c2fMru
         LGgK74AZF6EL19P3X9GHEnrm7J7WuNPwHQA+epcWuKv1DI2JtbWxrYMDcuzWp9t/4yff
         PFnXBCYdrR0PZKDP2W5zdquJh1vjtYvl/9vmHdgU5DRpYkG6hFaFLAhoI/Rki3ysw/Pc
         TncVF+51S7iScC9ay3dczaakGyPtDVZl74HEcn9bV0az7z2u0l9/DX8NohlRlX0OfKb5
         tBf7HBu+x92ki6wXy9CBf4DbYuKl1LKRVaQxQgbLrzDTE+W6argdhY3uLlDT4Qk4Yibs
         2stw==
X-Gm-Message-State: AOJu0Yw+N/CNtJC1oxv5uFm3xSuDz8wP59nyAog62F3sbz0FILOqe/r9
	BBe+PM3gM6tRG5p7bnQ2P0hZuWTEv4ljS6jxixRafhW/kKgdC4T61rEoaeQQGAhpslq2nBm2oSg
	aMRc0FNnWhP1lsNlRhZikpS9O2NzHXHzSso27jA47Lge0YDjEbCDtz47LWBqEuYdjNOSi3o9Eht
	S7TCwwat8wPXOPA5eFMXzGFh4XmM88jZjuqSY/BwQArsls0Q==
X-Google-Smtp-Source: AGHT+IH6vZMWPVrGq0O5BrjIonOKl2Z+F9QpaXvc/P9ImjsQryVPvIl2cAqRN6GYK8SEKr9YUCu6kQ==
X-Received: by 2002:a05:6870:8a1f:b0:218:d3a2:2430 with SMTP id p31-20020a0568708a1f00b00218d3a22430mr1705910oaq.22.1706724586595;
        Wed, 31 Jan 2024 10:09:46 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b005cfbf96c733sm10876004pga.30.2024.01.31.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:09:46 -0800 (PST)
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
	David.Laight@ACULAB.COM,
	arnd@arndb.de,
	Joe Damato <jdamato@fastly.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Steve French <stfrench@microsoft.com>,
	Julien Panis <jpanis@baylibre.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v5 3/3] eventpoll: Add epoll ioctl for epoll_params
Date: Wed, 31 Jan 2024 18:08:05 +0000
Message-Id: <20240131180811.23566-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131180811.23566-1-jdamato@fastly.com>
References: <20240131180811.23566-1-jdamato@fastly.com>
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

Parameters are limited:
  - busy_poll_usecs is limited to <= u32_max
  - busy_poll_budget is limited to <= NAPI_POLL_WEIGHT by unprivileged
    users (!capable(CAP_NET_ADMIN)).
  - __pad must be 0

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 68 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 12 ++++
 3 files changed, 81 insertions(+)

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
index 3985434df527..96efca6a9238 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/capability.h>
 #include <net/busy_poll.h>
 
 /*
@@ -495,6 +496,45 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
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
+		if (memchr_inv(epoll_params.__pad, 0, sizeof(epoll_params.__pad)))
+			return -EINVAL;
+
+		if (epoll_params.busy_poll_usecs > U32_MAX)
+			return -EINVAL;
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
@@ -510,6 +550,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
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
@@ -869,6 +915,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
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
@@ -975,6 +1041,8 @@ static const struct file_operations eventpoll_fops = {
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= ep_eventpoll_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index cfbcc4cc49ac..98e5ea525dd0 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -85,4 +85,16 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+struct epoll_params {
+	__aligned_u64 busy_poll_usecs;
+	__u16 busy_poll_budget;
+
+	/* pad the struct to a multiple of 64bits for alignment on all arches */
+	__u8 __pad[6];
+};
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.25.1


