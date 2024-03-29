Return-Path: <linux-kernel+bounces-123986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D828910BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF471F23785
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2F3B2BB;
	Fri, 29 Mar 2024 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmargXJs"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538039FD3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677257; cv=none; b=D4d3V5j3t6gHLCmpcloKWUZ5UKWGexMqYoso2MIK28DEc8NKuGdfh/6hmKLHHjow3Hu1GO/GXoW7P1Oq4AjYyIvdeBwt6TObZbLItW2yxAPZH1kG31mVf+K1MBgpyj3LKTOx231LWiLZKtpNJK+1pD9VcbaKcc6T2Y56BDfDDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677257; c=relaxed/simple;
	bh=tFmf24Mjc0l+J1FvLtlzPLbHQwNkOVITHodym4M2p8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rsDS/Q/9RO2cOLQu1N42ZnDZl9zCDEyf5PiVe9TNcSJIOzUdEwXSg/FO9hYSU4sQ3HCGFy6VuZCwJrmV3JvmcJLvopn5sHEgZlXmEatuk2CNFknosPXvMsEvoBGVjL3mXj8SWvUQg1cW/of/HMJ9F1BZWcFRQDAC4bgnm//9sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmargXJs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a2b82039bso24030367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677255; x=1712282055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeuNGA+8CuovI+htgf5CrcA9lpm9o2FtGFCkGxKFo9c=;
        b=YmargXJsKh02pEkO2JoheAf/ikD8SSfSQ51Blbp5F8DAr5dPQ/rnMKP/5o8iF8+jRv
         7mFRutAXe0FIFDAAWby/UVsz8XTcP8AjpQ1LOwhtLzjPdinT+jauAaBhUymSJOZCvMqb
         1FNIFM2djvTlX3jj3gGgSa9fEPCY0SOrTP9MwQNmkjmmhOqmIqFE4huYbJcpZIy/AAbX
         9FzZUvtp61PhBrXzdY1GPSDadvIX1nht7opJRX0OvTXnhhdTCX98ZJvI8MWkL1VK3fTz
         xzLBQzXRYxFaR8Yp+Kti9kNO2amKVzfC13R7/c/a1EWwZfJzQS8S9SrE7QekU068oUGm
         RRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677255; x=1712282055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeuNGA+8CuovI+htgf5CrcA9lpm9o2FtGFCkGxKFo9c=;
        b=JNjGpvtKUrtfphRzCuiUb+sBpP6++3m8rJ1Qh/yXzp9zRDA/i7EnRdiPMJbBU5V/GQ
         13VypIyg5YyMKBLk9olTkf3wG75FwiQTtWTNxq9R5a6oKw6hoQfvQL76F16p4Ep9Qy7G
         hRLbCCInXPzC9cpPTyL/WLFVpr9Nd5aEyYy8x58OsFIXvq5QB0X6YStjKQQySMMgksbM
         ayjlt/tDyVBXOJAIGt3FU5o6s+oIpMUbrIK88ATB3e1qQ10/YVtOX8qodNRGLfRU/zVG
         RbXmjWDybuwpn72sLVbuUPBBY6GpPCgdWp9WnK3caQXc6Mxg/M4SR/s/P7WOwwhQZyvq
         /0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXioQ6/NHjYDCMV9sPOY0UArR2/KDt0HqPFiWfFvM645smV3k2oWvY2VQvoszLB9COZawRJCBkZEunko3P7aMEZCYWNkbYwvgczwu6N
X-Gm-Message-State: AOJu0YwgSeJf6FOvWrDJ5JweUk5OMYJ7JH7p7FU24fqibfbEHedWp5wk
	FettRQMN3XLrIp2tBpChRmQpPSTm0mckXA9TgUgwqg+bkXnXdXTVkFwLX2nALZNUSVc707zdO1I
	PEA==
X-Google-Smtp-Source: AGHT+IHRQU6ab0eRho+UjDvwkzeb9d7pS8VugdyuU3acPa0I9eBDEaOKo5pla1Pw5XzmlyStLuGkngRj8h4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:4e10:0:b0:611:5ca6:59c3 with SMTP id
 c16-20020a814e10000000b006115ca659c3mr248817ywb.6.1711677254863; Thu, 28 Mar
 2024 18:54:14 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:22 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-8-drosen@google.com>
Subject: [RFC PATCH v4 07/36] fuse-bpf: Add support for access
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
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds backing support for FUSE_ACCESS

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  6 ++++++
 fs/fuse/fuse_i.h  |  6 ++++++
 3 files changed, 59 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 14fcc2032764..a94d99ff9862 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -420,3 +420,50 @@ int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
 		return backing_entry->d_op->d_revalidate(backing_entry, flags);
 	return 1;
 }
+
+static int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *in,
+				     struct inode *inode, int mask)
+{
+	*in = (struct fuse_access_in) {
+		.mask = mask,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_ACCESS,
+			.nodeid = get_node_id(inode),
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+	};
+
+	return 0;
+}
+
+static int fuse_access_initialize_out(struct bpf_fuse_args *fa, struct fuse_access_in *in,
+				      struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static int fuse_access_backing(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	const struct fuse_access_in *fai = fa->in_args[0].value;
+
+	*out = inode_permission(&nop_mnt_idmap, fi->backing_inode, fai->mask);
+	return 0;
+}
+
+static int fuse_access_finalize(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
+{
+	return 0;
+}
+
+int fuse_bpf_access(int *out, struct inode *inode, int mask)
+{
+	return bpf_fuse_backing(inode, struct fuse_access_in, out,
+				fuse_access_initialize_in, fuse_access_initialize_out,
+				fuse_access_backing, fuse_access_finalize, inode, mask);
+}
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6503c91886f6..8db6eb6a0848 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1563,6 +1563,9 @@ static int fuse_access(struct inode *inode, int mask)
 	struct fuse_access_in inarg;
 	int err;
 
+	if (fuse_bpf_access(&err, inode, mask))
+		return err;
+
 	BUG_ON(mask & MAY_NOT_BLOCK);
 
 	if (fm->fc->no_access)
@@ -1619,6 +1622,9 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	if (fuse_bpf_access(&err, inode, mask))
+		return err;
+
 	/*
 	 * If attributes are needed, refresh them before proceeding
 	 */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dd62e78e474c..08ee98b7bb95 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1439,6 +1439,7 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 #ifdef CONFIG_FUSE_BPF
 
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
 
@@ -1447,6 +1448,11 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
+{
+	return 0;
+}
+
 #endif // CONFIG_FUSE_BPF
 
 int fuse_handle_backing(struct fuse_bpf_entry *feb, struct path *backing_path);
-- 
2.44.0.478.gd926399ef9-goog


