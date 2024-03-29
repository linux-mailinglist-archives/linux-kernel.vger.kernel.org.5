Return-Path: <linux-kernel+bounces-124004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D6891104
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E011C2811B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68976A8BA;
	Fri, 29 Mar 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2VOdESG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB02C69C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677297; cv=none; b=uMF//ce8VPlMXjJR8RkltBVVgFaEF5I45Ic/tUzyF7KmZOZCwnaz3I46TVBBrg0cnwMXpQ1PjvCJtsCAYiXpKJsgoXOqYXhlnHMhCAi1kKfodrleQGDr5/UI2AUUS3wfAB4CgNNaYr6oMZ5YqT2m9cwV33r7Sl9v2FdOA7nCfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677297; c=relaxed/simple;
	bh=pk9Ej0arFqeZkCMlr0ALuLSLryIAG82IwMSP2yyNpaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hn/1xDVtSNwY4ic1UdtdePqYFzqHbDT9F+KEfr+3QiPT7ejzb++r6pCDN0yAt5YlGvFIir1rj0MmXeMl5KjzFyU+SmY4MMeucXIwcsoHFxTVLQ4olmJRErbVmPmFHmYERc4GMqPZE2r6mcGQ9vvfQNmMd2rF7roIaL0Lig2L/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2VOdESG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc00203faso29576037b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677294; x=1712282094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fgPCyEdk35RPimkCV3pdmwq6y+0q0t2sbyu7i903QQ=;
        b=g2VOdESG7aOUIisPtFkupRcX6ia+1Kfiecp2P94L9rUQd+vzrnMk5RPTbcZ0MzlgYC
         HXbIXoREjqZ4882v06Q0aoemrjFGyQ0PyJMRAof0xZsIWhLRGE9DVItTQvnG8oBVHhVE
         C4TlIcaVFaz2NNBUJj3Tr4JDQZMbEfF8xXeyDZiBGYRjz0JtIswu4QaqAfmnxKsKf4Jb
         nF+cS5hzqPyvlbaCgV5O+6kho+DVMdXmEHdXu7aT+xKU876MA9pILqfbB6tB7KTpwYgn
         YP1jmfssx1pGCOgX9kYZ6G0TPpj1TEQrN+F1e0FqxAywIivT9i9eqrZOns6l8Rf+Avwd
         LAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677294; x=1712282094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fgPCyEdk35RPimkCV3pdmwq6y+0q0t2sbyu7i903QQ=;
        b=bEDNgkxG7zj8yC1Z+lerhIf+thLhGwHj/5ctjCL73pJcezDeybB4lOtmbBaTMSlvK7
         ZGZ7Z/IKWtNDu//rAi6bWCWkv6CNWQtdBG8K/eUHT4ZzG6s3xxxn2Ip3FXtaE6xCtRpH
         lPT5nc51XfTZQRMsORVkkJxIFcQY5B9dz2jbrYAmwm3dz6UEnlEOngBhqZWVoBs1Ip+P
         hLHNLlVYe0XjzLP3DS+y9mzmLwnS0mwEst3q9q3glTBwC1P9kUcsedBaTrbUNmvB1XG0
         3gjhxzmm2ixV04ymeAYNwEL2WGXtj4XdATuCPcxRDOFRyFHCedSpDgGxKTjekxdjFXor
         ClEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoqxcBtuECwVqRWtohDsVdrrZcj41Pa6V0ijvsnX0badd9GGxgK2iiPHfVfNlMc3dof7MYHEUj7104doyOC9OCJNaHngxsNCMgvfWE
X-Gm-Message-State: AOJu0Yzd4wFktZsp8hrY+nsvw1zftpd1u/lmJQr2fL0HEUeua5Rr4j7g
	OsZloSrDvtD9ROYpRC8IncPvMhbXyjx8uqNDcOlzx2G9Gzks4JWhM8jwKfNjTcCaxxKycErsVfB
	igw==
X-Google-Smtp-Source: AGHT+IHo+ItJCz1vEMlMJs25DEazsRdzqnfW39HVVXO67q+uyT3d5CUr2ZMLHU+KkcK6U1vReIfsPel7clY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:d9c8:0:b0:613:eb1a:6407 with SMTP id
 b191-20020a0dd9c8000000b00613eb1a6407mr266377ywe.9.1711677294719; Thu, 28 Mar
 2024 18:54:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:39 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-25-drosen@google.com>
Subject: [RFC PATCH v4 24/36] fuse-bpf: Add fuse-bpf constants
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

This adds constants that fuse_op programs will rely on for communicating
what action fuse should take next.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/uapi/linux/bpf.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 85ec7fc799d7..46c1a3e3166d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7461,4 +7461,16 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+/* Return Codes for Fuse BPF struct_op programs */
+#define BPF_FUSE_CONTINUE		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.44.0.478.gd926399ef9-goog


