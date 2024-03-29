Return-Path: <linux-kernel+bounces-124002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9658910FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6711F23CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984069DFA;
	Fri, 29 Mar 2024 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmoc2SZv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924F69D3D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677290; cv=none; b=m6IfhbAqp3tlqkt9Y8iC83KWpIV0hqnU1bNYaDQRqXJHISig8FXhKR2U7Yz4iazE/rYN+dHoPS1WQkPdlmJfmvinMx6Sr0u8DaYRRvRfNEEBmZjYQTNxlYPigmB/HiHYWTHVy/RTAkFZTERhZHjbTnB5JvSLvWSkRk0HJdIW3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677290; c=relaxed/simple;
	bh=khFObfDZD9RDH2x00diHiavJfq0/SktiZtvPXG5MlzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsrM0iA7FUUXW2bG62OcIZeP9hf80ZeOMrPowspeDGJ7c9tOcSOqE+SQynCp8dqS7ehDaz0VRwqMC6+oh8onYd4ni4NHCQjRlrhOwssXF+Bd9c2eXkynofDHe64P5r3CUXXrqSqKxaNwxk4MhyO30T07Zzn3kvJHvtjpGpE2bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmoc2SZv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso2325992276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677288; x=1712282088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDLJEVuG9Rbj6C1vTwZ9ezw7r88gt9y1LMBKHsbBCE8=;
        b=jmoc2SZvk2aoUv1xz4bPrYSGvddGhft76CPXgi/v7tXp7O5BwobqQIiovVGV+mVsNY
         hd0y/SWSzjjvxR078oLEaPhwChSrO4ySP+34oO0/U9Hm8dzsaRWUE9mlbRWemiyHhS+U
         pblEFhV82fiFoY6eeSt1Dmmuin6UMTycDAlX9N4wfCDNcMFjVUg7sqIT9BxYKUiFAmzT
         GXSyAimRqT8XfuDlKTdxO1FtP5I+xGhb6h7gP20CyRD2+L8fitMe5jTPtcJcPcDoLpi9
         9MvK4xIfGtLifSmtxkLNNp7XTE/dHhnAXM4pkUvRtsLs18S6BNBbTdCFKeXI+Q8j35by
         dUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677288; x=1712282088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDLJEVuG9Rbj6C1vTwZ9ezw7r88gt9y1LMBKHsbBCE8=;
        b=F7EbzeVKKVAS2NZkVhevtJ6mq7p+xAheUlan3mBFGnadyYveTpu1F/Zz08cTGRzvHU
         c7SXJeIgZaqjT5JNdkWkr/RVkfA3NyDxdRQTOlCE9s1HaJFzmpIfS/i+mlejxQ6dLowY
         1SZytIA3ILNF/WJkVxi4icPNZwafacA5khwXoLmTOpPAI+310/csEmVSz7yyQ8Cqfttw
         i68TqS86HgEw0peJy5LiuPOdf7/yDI04GHBRqyIjiCk8Plvn2+6YPnb0+0aHfjQj3H3m
         38RSx9h72OO/rNgd39YQfdy9qPnlHL6sZ4iAVKVueOrHDw8eXtLW/uC5RDYYAbFr1HZY
         w8HA==
X-Forwarded-Encrypted: i=1; AJvYcCWM1uUGWKDhtSKOrnCLzi0krJiJSKoIGRbvTfw7Tx3HI9ZmN6lPBoq07Y3BfrNv9pPTqgsjvdNCQhH0AGN9B8aICdCOjqVaKEzTd5X2
X-Gm-Message-State: AOJu0YyXDSRMSmnn+Vqi6zqHqAwxZ6hh8zBEvlc7yqcGlzh09bRmTNtD
	nEdG9npYqXuToiDtYzfomDks5NVfNk1N5MQPLLCkRmyZ6ADLabz75Ca77k3ufD9NQrYvcxSuLsr
	QuQ==
X-Google-Smtp-Source: AGHT+IGAbEDexCw+N2JysnI9m0JGtmH2E2g+ERbDEaavjOuwDP/sU418H9UcdiCecEIveINGY+GMY2/U38o=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2481:b0:dd9:2a64:e98a with SMTP id
 ds1-20020a056902248100b00dd92a64e98amr86513ybb.9.1711677288087; Thu, 28 Mar
 2024 18:54:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:37 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-23-drosen@google.com>
Subject: [RFC PATCH v4 22/36] fuse-bpf: Add partial ioctl support
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds passthrough only support for ioctls with fuse-bpf.
compat_ioctls will return -ENOTTY.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c | 13 +++++++++++++
 fs/fuse/fuse_i.h  |  2 ++
 fs/fuse/ioctl.c   |  9 +++++++++
 3 files changed, 24 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index b2df2469c29c..884c690becd5 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1587,6 +1587,19 @@ int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *io
 				iocb, from);
 }
 
+long fuse_backing_ioctl(struct file *file, unsigned int command, unsigned long arg, int flags)
+{
+	struct fuse_file *ff = file->private_data;
+	long ret;
+
+	if (flags & FUSE_IOCTL_COMPAT)
+		ret = -ENOTTY;
+	else
+		ret = vfs_ioctl(ff->backing_file, command, arg);
+
+	return ret;
+}
+
 int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct fuse_file *ff = file->private_data;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e69f83616909..81639c006ac5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1651,6 +1651,8 @@ static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 
 #endif // CONFIG_FUSE_BPF
 
+long fuse_backing_ioctl(struct file *file, unsigned int command, unsigned long arg, int flags);
+
 int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl);
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 8929dfec4970..d40dace24d2b 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -360,6 +360,15 @@ long fuse_ioctl_common(struct file *file, unsigned int cmd,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		struct fuse_file *ff = file->private_data;
+
+		/* TODO - this is simply passthrough, not a proper BPF filter */
+		if (ff->backing_file)
+			return fuse_backing_ioctl(file, cmd, arg, flags);
+	}
+#endif
 	return fuse_do_ioctl(file, cmd, arg, flags);
 }
 
-- 
2.44.0.478.gd926399ef9-goog


