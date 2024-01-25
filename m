Return-Path: <linux-kernel+bounces-37822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477383B614
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A121C2245F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999437483;
	Thu, 25 Jan 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Q4QliVc8"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC267C45
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142627; cv=none; b=u+SIN0/FLBSzaqQXfbGh1JtYXrsD73lILJWpbULpBrTeyokxP2jUcrZPFZ4la/DMiqXK46CHEMtAvr+7qNSDkhekYu7kJSF+RyCxaE2KovDAPqbs6m0qg8i0SVUfv6ByUXcuxF8OjsBMlQ/jXcks3on2ykBh3ffg6ie73KFLmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142627; c=relaxed/simple;
	bh=WtXmg5IZU3NCkx951uq8x5TaAckhdrLYZZQD0cemNCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ky6j8psij8np0a6Qqa4k0xnO8YBC+Odejlja8Ygbg2ECPP+Blz53OAP1wnCkH4vVLQh3EKKwTBoGyJR4riR8KrmKRv97LFZIR3bWx8Y2YJXaQ8L9WXAH7heXdIvGpCE1b7NslM0iwJgFKvro8Ce7VMEIbnUaCTlI4mXsJiQGcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Q4QliVc8; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21433afcc53so2536924fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706142625; x=1706747425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfXKcx732lyegT0JnbCBFxum6PCwYsIbQ8eg5Ffi0GI=;
        b=Q4QliVc8V5fIHZX0bf1XoosmwpMW41Gj409Sbv/gkf84IutJJTxOSzp9D4rFZmps3c
         JIhAvzZMlQqXfzrB+hRycD2WqbPyMVWBnI5VZIk/sY+z9VOATkB73oiaeiMwv3wbgX+6
         TPb12iW5ju/yoII31ld99vsa7Y1Od43ZxJmc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142625; x=1706747425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfXKcx732lyegT0JnbCBFxum6PCwYsIbQ8eg5Ffi0GI=;
        b=GdPLpeMoxET2+roPfWXZ1Bad81HM5RyshkKfQxY5dyPgXjXe0lrCPkTR936lYxSgdi
         gmLt+61Pyow2CAsbwPLjO/qsVbAzNFb+Nk4WZvchQf/4KgTnVyK5u1Hk6Rvi7TBzR7Ci
         WeNywIIf+qFW0mp36aVEomMfr/5Q5SI5b/7OVrTFf4bYlMMtoz1zcy7bolx4U42bjQy1
         jNwVeiV4I0mQkI5U3HtIP8KLMfvZwTPCfEamuj+8IAwUjZJSlwGwID7wIVppOi45ww/K
         J6r4CI6nWXl1EIpEOBjWouSru8GRiD1XFT1tRzYyZnSmv1K6QeyHnC+5g4z7fzqlAjij
         2vOA==
X-Gm-Message-State: AOJu0YzOEeR4Ytm3oVyj5NmAYhxpsgLGOT20vgsVCEexq/pnm8pk7aAS
	WQ1Sg9HxsCugSdE5OK/DXFyUmEYgPnWH3lsQ3t4K273Wl+rCXE6NFAXdkxWyBT0=
X-Google-Smtp-Source: AGHT+IGG8+mwEQupJBz/pjzOQSEbpI7FI6UmNFYMgH3X7dDvRH8BfBty9RDrCNA7UOvUqbHUql4CMA==
X-Received: by 2002:a05:6871:8191:b0:205:9fe9:67de with SMTP id so17-20020a056871819100b002059fe967demr134665oab.39.1706142625168;
        Wed, 24 Jan 2024 16:30:25 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd945c0399sm12550486pgi.80.2024.01.24.16.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:30:24 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 3/4] eventpoll: Add epoll ioctl for epoll_params
Date: Thu, 25 Jan 2024 00:30:13 +0000
Message-Id: <20240125003014.43103-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125003014.43103-1-jdamato@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
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
 fs/eventpoll.c                                | 47 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 12 +++++
 3 files changed, 60 insertions(+)

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
index 40bd97477b91..c1ee0fe01da1 100644
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
@@ -869,6 +871,49 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		ep_free(ep);
 }
 
+static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	struct eventpoll *ep;
+	struct epoll_params epoll_params;
+	void __user *uarg = (void __user *) arg;
+
+	if (!is_file_epoll(file))
+		return -EINVAL;
+
+	ep = file->private_data;
+
+	switch (cmd) {
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	case EPIOCSPARAMS:
+		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
+			return -EFAULT;
+
+		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT)
+			pr_err("busy poll budget %u exceeds suggested maximum %u\n",
+					epoll_params.busy_poll_budget, NAPI_POLL_WEIGHT);
+
+		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
+		ep->busy_poll_budget = epoll_params.busy_poll_budget;
+		return 0;
+
+	case EPIOCGPARAMS:
+		memset(&epoll_params, 0, sizeof(epoll_params));
+		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
+		epoll_params.busy_poll_budget = ep->busy_poll_budget;
+		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
+			return -EFAULT;
+
+		return 0;
+#endif
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
@@ -975,6 +1020,8 @@ static const struct file_operations eventpoll_fops = {
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


