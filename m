Return-Path: <linux-kernel+bounces-92057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC17D871A48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A6C282F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CE25812E;
	Tue,  5 Mar 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jq5k6fQ7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2F55E54
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633434; cv=none; b=Swb/MJ7VPwOk3Le6V959vcV44pFWaxznB+JiffB18uzAWilRkalduajsfo8NEadzBrWx7N+NONLwYDmzU+kUZ3SLiHLNX2CCCZo+5KXS+AhzWL6CHAa6wtcECJHDfw+fpz/SCCe0tgSJFQe2ZODzML39x/9pMEBqNRIA3Rz4lME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633434; c=relaxed/simple;
	bh=5+bllf7wQXoQ1iiymcQxAaVJUnLpEaTtP4WhLyfCGPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qI2p8Z2lbhQvfE7BIs+cBZMfop8th++hz8aXAiQEzDrk7H1KvRRoFGQAG+PifvuQdVvNQbEnOhmU24MfU42rQTAadxorO6NpNpsf1CihTH6T3n1booACXPWfRczDmg6Hrq8D+dG1ZLT4ylTx+BpS4MlzxhHApRchOqGqawQCbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jq5k6fQ7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so3406168b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633432; x=1710238232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6tSmWQUz9mHEs7KKdtWRSqXpZBjknnUveJhwT+v2FU=;
        b=Jq5k6fQ703V9hULNmaMj51rmkGH4CZW4hnaqyjwDdexzJc3KRKc3FZohTAuw3xhVzh
         NAVVN1Lmmtv2M2c2IIeawk+kfjYC5A3Ez3gi9VSBRvidR0CoSLFmZ1WywTNWOPe67oA+
         pbNEBGHPBJYMKL7jN67cKd9iWt4tbRxpFRel8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633432; x=1710238232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6tSmWQUz9mHEs7KKdtWRSqXpZBjknnUveJhwT+v2FU=;
        b=dS/d70fokrk+tcT2bWBEFJEf88RxsrQsqWDNBsD1VE+SPbbaXhxefEqVeuueqYG+01
         oV3xE6oZzO/8EzO2pKzUIVJsEsxGfZ0oPV6N3kDDJ3+0icAzhsNYMdHDFE/0HWQok9ot
         J7ElX+W6JGav3z0Km7sBNenuvOCf3p7cp7R4LSNgyGzkpg1xkSBjLFoJKfWYxY+rx1d4
         pvljXABGbWQGNTPIANg7PHNYqOP76S1uMqqw/IHsrJJCDXN4cnh3YXNp+WFeAGoI3s36
         qIjEPmtB0kW/5/E0+GW7W0C9qzs5QwY5DCDHXmw+xfPwlCi/mdfNHfvm8xEINVOT99As
         7OVg==
X-Forwarded-Encrypted: i=1; AJvYcCVJS4k0t5USgM7r4U21+j9MpvtzWzi0B1SkxY0ssPo2k3NSnc0peFVYZIq2WHuJ3wz1HWKW//minNLIgBgxGyFtM4f9K9LY84h4XWj+
X-Gm-Message-State: AOJu0YxJS88U4FBaieFeCwgLrnnl9IIK5kHd3VmEfN1hCeQr57NA2CCe
	WEQ8fvWJ3NGLFKylPHhhYO0eGEgNDtwirqb57aTUEsRH1Uqd6qunp/Fnq+pJLg==
X-Google-Smtp-Source: AGHT+IGioGxnLf58krzooyXRSux/Zxx7hWwNEvHeCXchceFMByRkqxZ+PaMIxnsL+kY8mFgOqRxI3w==
X-Received: by 2002:a05:6a20:729a:b0:1a1:3b27:4f3f with SMTP id o26-20020a056a20729a00b001a13b274f3fmr1585251pzk.2.1709633432471;
        Tue, 05 Mar 2024 02:10:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m7-20020a62f207000000b006e580678dfbsm8485054pfh.193.2024.03.05.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 6/9] slub: Introduce kmem_buckets_alloc_track_caller()
Date: Tue,  5 Mar 2024 02:10:22 -0800
Message-Id: <20240305101026.694758-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914; i=keescook@chromium.org;
 h=from:subject; bh=5+bllf7wQXoQ1iiymcQxAaVJUnLpEaTtP4WhLyfCGPk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+Q9Fez113NbGGVqjvVTslyLAH8TI+6Wb4a3
 UHTy9ESMGeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 Jum0D/9tfCyWy09BzH1L9P4M66z0u2ctSfRJPeQ1x4bgaEnW38mkbjG41ME6e+R5Zj0gpmBgZ+L
 BVNaHnefEXko8smuTRzZ4FGGksACNwKf0+N86253pNgtssxWUfgfa3aQ1EA8XEBCMceHWGnr84H
 h34x9bAbwoUCp96M4lvRDs8cKxVlleF0jjCvDpvMT3T1ZAyvoPvNHYpvj6mth+oFIZTSkt3Wz+X
 919IaLbl/IDuiJVd9rtpALExUWOh+KXL6FuuwYZHWN+SaSa712xlgG/5pLuJ+2l8Ub1IJiEQVWp
 r/4azSgELrhUJFvtIbkEWWKreqYhRzNs/rKZUmxW7K1gGKiGdDk4ZDqhqhclVbw3MMBNLZbLerx
 rSCyI/khhcdBGZYwjg6IFEY/vpFVkrL44xPf13VdK07PEsrsff7tXBBEX59HFI2KvQG5OsvWVhP
 aHHbbGxMkh8n+z9aHH4WpY49kUBjUPRrASB5fIz5FsMzXVgyemQHiUSYTVdkJ3aT34AdKNF6pks
 Immb98LUo/rCvKgXzxq/u49qS0zQkVpV4BWtD/SwK4MuhHIOU8Rm9ytXz8ZSxeZ0v1pYc89qObI
 o3aW/HpIQI7IY2DuYh0+o+TW5k0hDDZa00o0vGiCTiQIKa61gmW3pYCwmM5FPO2U0gagUkJ30W6 V9QFinQCp7WdukA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For better capturing the caller details for allocation wrappers,
introduce kmem_buckets_alloc_track_caller() by plumbing the
buckets into the existing *_track_caller() interfaces.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 11 +++++++----
 mm/slub.c            |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 08d248f9a1ba..7d84f875dcf4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -606,6 +606,9 @@ void *kmem_buckets_alloc(kmem_buckets *b, size_t size, gfp_t flags)
 	return __kmalloc_node(b, size, flags, NUMA_NO_NODE);
 }
 
+#define kmem_buckets_alloc_track_caller(b, size, flags)	\
+	__kmalloc_node_track_caller(b, size, flags, NUMA_NO_NODE, _RET_IP_)
+
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
@@ -670,10 +673,10 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
-				  unsigned long caller) __alloc_size(1);
+void *__kmalloc_node_track_caller(kmem_buckets *b, size_t size, gfp_t flags, int node,
+				  unsigned long caller) __alloc_size(2);
 #define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
+	__kmalloc_node_track_caller(NULL, size, flags, node, \
 				    _RET_IP_)
 
 /*
@@ -685,7 +688,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
  * request comes from.
  */
 #define kmalloc_track_caller(size, flags) \
-	__kmalloc_node_track_caller(size, flags, \
+	__kmalloc_node_track_caller(NULL, size, flags, \
 				    NUMA_NO_NODE, _RET_IP_)
 
 static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
diff --git a/mm/slub.c b/mm/slub.c
index 71220b4b1f79..ae54ec452a11 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3995,10 +3995,10 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
+void *__kmalloc_node_track_caller(kmem_buckets *b, size_t size, gfp_t flags,
 				  int node, unsigned long caller)
 {
-	return __do_kmalloc_node(NULL, size, flags, node, caller);
+	return __do_kmalloc_node(b, size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-- 
2.34.1


