Return-Path: <linux-kernel+bounces-92058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA41871A49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07801F22308
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97865916A;
	Tue,  5 Mar 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="afKW85Vc"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF85677D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633436; cv=none; b=bZ/VypBwpz+mdGx3aAe9haof9FNMF7Adp6RvFZz25z9AYPAU0uvMe1zVenrlUhjyWUDgB7nvQm+lYf+G76SgZQs449aqYjP9SXZnlafAUzbAoc+05/KlcLnYFEHuxg+1UtHvElS5nYkCS00eskQKK53bWZgE9Zd0FuJzUxzdBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633436; c=relaxed/simple;
	bh=6qDL+BboHaqcTpZSUCl+S9ocvneIfXXeMs3ajiQ2O/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlibnD2ot1RHPaz/DPqM/52pYerfOiD8HdScj2/69nxKbyHRxvqnc0usxWTs0v/EMrqiK3uRQt48srnOM3V6ifJSNw+AibO2GgP5lK+nzGhHbtNDpihP48h5aza9Wmd6FniObIHKV8jKwgBzimH0TxR9Qg79rtRSHJDzJV0ps9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=afKW85Vc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc13fb0133so40526895ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633434; x=1710238234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdg+vWQ/glPg3PLzwoChyf7fue9eFP8PVvp8lsS5Lok=;
        b=afKW85VcRubI10YjZUBeM6xATHrPsAt3P4VKvRlK8VNrcMjYzRcdNQdpTMDAqmQ3ax
         kdq/syHQW16HUT9dJ3yWw/h71pEuxNL7YsormhU1ulz6uIajLI3lCvO0qwar2NIEOSYB
         dpPEwMfdU6sRJPZISTZedRn/y3vAWy0ijnM9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633434; x=1710238234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdg+vWQ/glPg3PLzwoChyf7fue9eFP8PVvp8lsS5Lok=;
        b=aMDDsS9ddUPrSk8PaurInONDcB0M3ZMxgJnS+8xzFJIcolyXDzVsY4EKtXjxNmvNPp
         vmTlq+xz8KsK+vaB+KEhXlnouN/F1FaWuej7Bgif/byJkPi5eW9C1/9Qg0lQc8Bor3fh
         mJcexaZHJ98tyZKBKYHPFOSaaflbuuF+20QUMkrJdRKe1Z7KgroTMm/UMmXgLhF4tvWQ
         5tAiZBaPqVhRC28Z2S2JdAJQThWWRReOxxLdo4MUx8DzM/7sZfGxxAFWZRF4XMO/jpNz
         hNEhqCDI3voZHGPJBhXkVztUx5TC+mQzNWINpH5+S+4l8mU5B5ZxANlEB/D2vaBRsVbB
         cPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaO90Xq6dhKmzYobM0AAceU4HwoF7emrx6b9uJZ02Md3uC8Zevw0H11b5dj3F9r/hyJA/FLVe3Oh+lTClBl5QAaXvnOEp1/oqFeDoQ
X-Gm-Message-State: AOJu0YxuR3T5huvblxt/qqGDZxsB3uaR587THIqWG9RMwAXcAPCGL/4o
	jDH/WtPY5KF55YOlP+2d87H2u4UAFqmtjDvAmyPDdOfoY5FaSOX8q/vTAoZubQ==
X-Google-Smtp-Source: AGHT+IHYCn9DBg9xzTvpQ8G0/N3dK13ZQWLK1qCcLYJXKOoBEAWGORs21YgWZoWg8YTIQaCZeo4VAA==
X-Received: by 2002:a17:903:2287:b0:1dd:7da:e0a9 with SMTP id b7-20020a170903228700b001dd07dae0a9mr1791845plh.69.1709633433734;
        Tue, 05 Mar 2024 02:10:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902e31100b001dbcf653017sm10134281plc.289.2024.03.05.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-mm@kvack.org,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 9/9] mm/util: Use dedicated slab buckets for memdup_user()
Date: Tue,  5 Mar 2024 02:10:25 -0800
Message-Id: <20240305101026.694758-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; i=keescook@chromium.org;
 h=from:subject; bh=6qDL+BboHaqcTpZSUCl+S9ocvneIfXXeMs3ajiQ2O/Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+Ruvag2LjJsl5BflMWP3F10S0bpaicfQjrP
 em4Flv551eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkQAKCRCJcvTf3G3A
 Jh5rD/wJ5mDNRMwSTsAR06j+XsdZ1LXMSaSe8WeQSfww+7fSDo2bwPbB2YuP2imZfi2Z0ALaDNc
 QjrOdKcPLNAptwDgTvG8rgq8Ads/uaBkD6rP1GpQd9XF7ZP+IN5Tj/Ust9Zx+YZOh1j757Tk9f4
 /2I7O+56tM7rqcJYTzDVwwN3lx5z9LnJAIv9cA2fc5WZw4zdqRbzRZ2x2/jTvOictVZIOz75vdw
 eHxukjUd1puppQSWDfMARwCUPIILs8IjoAaR8UZAfPVGp0pxZe2GBSsLG2wB+yvlBFR58gg+qkr
 PPA4dy4re0Tig2xdNDMKxFzPI2MGhDuckv7+bdXYa1y03Qk/hE9om+kdYryhKz3AJ7c2FU6lReH
 mTQ/EPfpM/DP3hVk1yOvB4YQVT+SsRzeBQyHjE7vMel9E0zPFPRlsHvTQYQfzF3xQMEWSjWW4GG
 5VQ0LGp6u8ey7adQvju72Jq5NXyiMZbaTebl1RgLT0AX7iek73VAJKe9Vp1MeHbuW3KzheQjEhv
 V+GYAiXu51x1VsKLuN69+yg2ofManoTrfcNE9k/KiZywKTTRvzJ7GlsihkF1zScLCrOfnIJLfWn
 mSg61FpR2fsWqar318TaCYm5iTXskabguFfuho/W7iHJo+XHIJRToiRH7s34zAmcK3ETFBpzTUP t3ctwbz/OBT4vHA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Both memdup_user() and vmemdup_user() handle allocations that are
regularly used for exploiting use-after-free type confusion flaws in
the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
respectively).

Since both are designed for contents coming from userspace, it allows
for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
buckets so these allocations do not share caches with the global kmalloc
buckets.

After a fresh boot under Ubuntu 23.10, we can see the caches are already
in active use:

 # grep ^memdup /proc/slabinfo
 memdup_user-8k         4      4   8192    4    8 : ...
 memdup_user-4k         8      8   4096    8    8 : ...
 memdup_user-2k        16     16   2048   16    8 : ...
 memdup_user-1k         0      0   1024   16    4 : ...
 memdup_user-512        0      0    512   16    2 : ...
 memdup_user-256        0      0    256   16    1 : ...
 memdup_user-128        0      0    128   32    1 : ...
 memdup_user-64       256    256     64   64    1 : ...
 memdup_user-32       512    512     32  128    1 : ...
 memdup_user-16      1024   1024     16  256    1 : ...
 memdup_user-8       2048   2048      8  512    1 : ...
 memdup_user-192        0      0    192   21    1 : ...
 memdup_user-96       168    168     96   42    1 : ...

Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
Link: https://etenal.me/archives/1336 [3]
Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Matteo Rizzo <matteorizzo@google.com>
Cc: linux-mm@kvack.org
---
 mm/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 02c895b87a28..25b9122022a7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -181,6 +181,16 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
+static kmem_buckets *user_buckets __ro_after_init;
+
+static int __init init_user_buckets(void)
+{
+	user_buckets = kmem_buckets_create("memdup_user", 0, 0, 0, INT_MAX, NULL);
+
+	return 0;
+}
+subsys_initcall(init_user_buckets);
+
 /**
  * memdup_user - duplicate memory region from user space
  *
@@ -194,7 +204,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	p = kmem_buckets_alloc_track_caller(user_buckets, len, GFP_USER | __GFP_NOWARN);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -220,7 +230,7 @@ void *vmemdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kvmalloc(len, GFP_USER);
+	p = kmem_buckets_valloc(user_buckets, len, GFP_USER);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1


