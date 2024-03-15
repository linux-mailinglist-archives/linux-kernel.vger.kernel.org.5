Return-Path: <linux-kernel+bounces-104358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B8387CC92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062B81C2101C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738538392;
	Fri, 15 Mar 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ejCgNeoc"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FF37157;
	Fri, 15 Mar 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502752; cv=none; b=iurlLpIyu3BAEjM9LPHhyhf2DcVRbKcuxFnfKLE/noh3JYE+Wz7AUb8VFZz9rZgDPhuSCGpDhcpP4xhtBX6McUfhe0aAKjj4m6A/vaUwPm6G/sswfqc3k3/9MYa9eJYEHrWAMFkuhO9/FUOfPSdXBJ6udmyPQzBstK8x4IjsAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502752; c=relaxed/simple;
	bh=HmfrjKV80zxN0Qu8spZWjiP4Pz/wzBkFw6jKJtLTo9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIJynGL/w8EycqHA237ihCI0bTeuNVnH0f8xQMkhdhJW3CpFD28ppZBeE8fvlINcC1ObmVrYes8AjPelHpiA40/W0Rkuch8fssg971g/xJZ+4jwMLgnkc6vYAqJqZ9jkg5i5L1Mvr+96htkOt0c/2auu4qPBpSs1/iGIaE9LN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ejCgNeoc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2669901a12.2;
        Fri, 15 Mar 2024 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502748; x=1711107548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFW6eqfgwfb8L9+rUjWWkl22JgKTa/YmYo+cAr3MkEM=;
        b=ejCgNeochwlWc1477r/Z4g5HRldUx+/xKBMuw+6eimumDjMPr5pAhXBdxorIEVvm7o
         WUrhAxDQCzF3X3SVCcqcLOjuoz6l3QvkBJd7ff5OCwwmNWFd+QjZqmd2graR/VGQ7qCk
         AxeEWng52fYRtUvz+LgbqMEQF0zww3216vJBkA7Ls0XxmWwQWmF633ZpEq3U1mgKQYku
         Zw7UpvKIH+PRajkQzP24AYk92WbCmpOpe/0nHzYV/JmRjj7l+5837Rd53Yr90x61rxtb
         ZMaoAffMM746MLoupJZQAXUxJgIAq4aYAtGVgwlsEb34/er5kLDMiOcJ568yLmrGLZMW
         6pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502748; x=1711107548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFW6eqfgwfb8L9+rUjWWkl22JgKTa/YmYo+cAr3MkEM=;
        b=pyuB02cqc+cUQf61kJsrAF874JNZW8D1GZN5Z5N/MXzRU0HwnY+odZArUG8LLgQK2z
         8c8FbH+9vZ81Ey+9hdngNbsN5UOw1aGhI3Fxv/go4NCIlNVB0rw8h/Tov9lH/8k82HCm
         lKogxFfuYL9dWjeMx0mxBpZ9m+sGUQMfV/5Ob4rvQVRoHIEir070NRzdUUqtAKmHlmGs
         pGUpkeukZe376M6bUf9hR+eMFvTqmPiXH3QaU1RCYt8y2J6PMPaWL8MkjJG5uyrRQ/jp
         Fda0HDRAQjgWYUBfR7HcV9XY9qFZ5Zc2uymfKLgTZwup/UuXH03cOdX1IL5mpTH90N1F
         gOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJre3NavNEwhP7uLIR/q5iZTuNzzYPoD/O6zdRCbcBZRIFFqYEGWabKtFvOTnaoHEhwpaxxFOrbS7y/LMwJzVj9jVOrZEd4j3+T3Nf7RvBFo/bUlcdZYaXjLQgiLybRtW
X-Gm-Message-State: AOJu0Yyf+scyy/EjhOYKz23YtUjsMLCSWRQXfDEegXGAOgQTFIrLg/JN
	iDfY9Y3UXxlUS7D5O9Hzh/rTmONCJ45fbebm0qEknJIDleI+M4lct0sN3ze+MhG5nw==
X-Google-Smtp-Source: AGHT+IEVZU6MeO0L8YmsrZvf54E2m+RHVA6YoaRbvM8QTxq/FR7x8zB9pbUVCGt2gLKWzNCplglUvw==
X-Received: by 2002:a05:6402:428b:b0:568:376e:ea2a with SMTP id g11-20020a056402428b00b00568376eea2amr2696148edc.40.1710502748432;
        Fri, 15 Mar 2024 04:39:08 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:08 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] bpf: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:30 +0100
Message-ID: <20240315113828.258005-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in bpf_token_capable() and
bpf_net_capable() implementations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v5:
   add patch
---
 include/linux/bpf.h  | 2 +-
 kernel/bpf/syscall.c | 2 +-
 kernel/bpf/token.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f20f62f9d63..bdadf3291bec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2701,7 +2701,7 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
 
 static inline bool bpf_token_capable(const struct bpf_token *token, int cap)
 {
-	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
+	return capable_any(cap, CAP_SYS_ADMIN);
 }
 
 static inline void bpf_token_inc(struct bpf_token *token)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae2ff73bde7e..a10e6f77002c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1175,7 +1175,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 static bool bpf_net_capable(void)
 {
-	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_NET_ADMIN, CAP_SYS_ADMIN);
 }
 
 #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index d6ccf8d00eab..53f491046a8d 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -11,7 +11,7 @@
 
 static bool bpf_ns_capable(struct user_namespace *ns, int cap)
 {
-	return ns_capable(ns, cap) || (cap != CAP_SYS_ADMIN && ns_capable(ns, CAP_SYS_ADMIN));
+	return ns_capable_any(ns, cap, CAP_SYS_ADMIN);
 }
 
 bool bpf_token_capable(const struct bpf_token *token, int cap)
-- 
2.43.0


