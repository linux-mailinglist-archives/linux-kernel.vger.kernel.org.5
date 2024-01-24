Return-Path: <linux-kernel+bounces-36366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA2839FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F2D28DA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDC17753;
	Wed, 24 Jan 2024 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RxqyEH6O"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028117578
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064872; cv=none; b=ZFFIHSpWdimTIzIfH0tbuIsIyJiZZ85muiOoq5mfNZUhpVR7Xf/9jhQbHnDSwvB7KluIcPLSbjluGK3yNIPiiK5vQCVKhXTJtufdsg3xkwAE9fldGHJUkFUiaFIkRnZ1p9ta0kmw27V9GVwbGK+itaddXF8FtDmwvQF2+zd2jrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064872; c=relaxed/simple;
	bh=jEpGsvLii/mVQkq2gxlG8k/giShd2XXjSIODjknHbrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrtPcX5nBzbtR4moAsMTK5403tNO9Se1r05GyAasZ79my5LSWt7LeEvX4Ye5DBueh48VZJzCP+glzEtNtsD+OChPye3MMXZJyXi9tleS4A87xkNiA8enYWjZAx7jeU8cgWzUq1od2x7v4GsZENa0aG07LKCi7fZ1qauuaqO85sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RxqyEH6O; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd5c4cffefso4946382b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064869; x=1706669669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDDvozY18VzUKM9utNCLkKJpAjjBedBawVpo6PogSYE=;
        b=RxqyEH6OU/Dc7j7G6TLwlM6PZR/QaiwtH4HVR1DnCmRJe/4X1w2Bnc9H4NUsebsm+G
         RJVqLhphdsHx3sLt+FkjQ8KIqONYPkdSbic+l2OoFYB7tNH0IkLdTEBF7VX9fTDQrHR0
         aevov3B87YxPeJ+AVArv6QjT6f2Ej5LDqxnxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064869; x=1706669669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDDvozY18VzUKM9utNCLkKJpAjjBedBawVpo6PogSYE=;
        b=vJjWsAskAm1vFzC0qklgE7P4tPQVtch0gOvz9/qtE75HoINrQANwUeu7Xl2dKD5kL0
         4H4aJmNaibSmvHst6pnDISJ3nuFeLwfIZDh1UxQSUB7KHKWDS+KQcymXpqs9gFQ/138m
         dR5cJnJKAFjbNSUnYjjJBy5stSdM2tn9i+WB88+u6S6cMT+QV3XOI8LszKClWbezcu7k
         kuJZ94+2Yj977KhrnjleXJ9DVYa4wRzSI6D96C6A56vUt0OxQnVE2Ock929NA4SCxjIE
         g6mgWqLAC4Ls26kXHw582ip0lXw/4VJ8REk/ZtWBaPKirOWajSo/YQrAvtJMIvDlrCmc
         bpGg==
X-Gm-Message-State: AOJu0YwRlNIyba8oKYkAEZURh8qWxHP76zpbFS0ePCv1UmWiutJbLaRK
	hpGIOkH5ERMVhJrcAeJfMux1UeGlpI2aMQLSc3aDyWS1fyvWmnnGL9SolTi8O+U=
X-Google-Smtp-Source: AGHT+IGaSc3GGnCsV9Ic5d+SfutWw9JoOp4upfNTYerkdduW5gB+8NRRZRhFAbcoNuFnhBV46rI2cA==
X-Received: by 2002:a05:6808:1916:b0:3bd:bf4a:686c with SMTP id bf22-20020a056808191600b003bdbf4a686cmr1015263oib.18.1706064869015;
        Tue, 23 Jan 2024 18:54:29 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:28 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 3/3] eventpoll: Add epoll ioctl for epoll_params
Date: Wed, 24 Jan 2024 02:53:59 +0000
Message-Id: <20240124025359.11419-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124025359.11419-1-jdamato@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
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
 fs/eventpoll.c                                | 41 +++++++++++++++++++
 include/uapi/linux/eventpoll.h                | 12 ++++++
 3 files changed, 54 insertions(+)

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
index 40bd97477b91..d973147c015c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -869,6 +869,45 @@ static void ep_clear_and_put(struct eventpoll *ep)
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
@@ -975,6 +1014,8 @@ static const struct file_operations eventpoll_fops = {
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= ep_eventpoll_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index cfbcc4cc49ac..9211103779c4 100644
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
+	uint8_t data[118];
+} EPOLL_PACKED;
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.25.1


