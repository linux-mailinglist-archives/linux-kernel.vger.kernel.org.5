Return-Path: <linux-kernel+bounces-120131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F354188D2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDB932199B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792913F43C;
	Tue, 26 Mar 2024 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRI8ogtn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0813DDCD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494911; cv=none; b=D0LAiYxp9qmMR70f5o4AScunhNTFWISYzwtQK4WdRDDhDj7c8PA89Zm172c8crPPUcomzhsVqhI8qhSN6CZAyLWeA+uXDIIh4YS1SAgp8tUqtU4j2wZMsKukmhoTbXcyrRw/v4+eg9K7Z10rMDDJa9KCi8gZ8LgEgMmO4LsGMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494911; c=relaxed/simple;
	bh=fyMrFp8V3YaU0ogcm5yJYQgEMev0swdNBsiWfJ44G44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nlPmijc1Yc6Her1fYDnoRViBfwSP18YzaGjLS4L+w/EsV34h/dUlsYMdEuT0Vg4GzjOXgAHIqA3qOH5wfSn/SG0GB5O5dV1UA5p4x+5JBY2odjeIYZJiVbe5AyfMpLbzZmg5auJG1YUpLLEsPyAmNUSK3tSPTE4vuG3H7ExFC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRI8ogtn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so10977174276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711494908; x=1712099708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJNXXwIfWIOilmf511swDZU8Qk74qgWKC4xKQmksutQ=;
        b=KRI8ogtn7KiJBPhEXU/8qhTVR6Op3jeVF2+IBE9NmkesjFelaF3rP7hdRULyol54YA
         COmktwp4tF+INmC52WDsJdnArmMEPutOWzjJRxGjstmWpAjHU3/MdeeATRLZh1xBLhuH
         Yiyf/rMYFWh35LuCvqOuaGjLnzeQJqo2wBjx7K1Ic0GbWc3vCqk5puo2OBWRrnYE4XoM
         72Rte15IS1Ddot9Dbl/c8dt5UmWvhuWC0JQ5g4gUkUYhgXOMcKz4IJk/Gvfu/RNp4435
         vQSA878pAfu7m1FJe9yO8zVteoM8zBK6MSI4SWdV/V0szafI/0y9igVb0vEuzENM3VPg
         LUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494908; x=1712099708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJNXXwIfWIOilmf511swDZU8Qk74qgWKC4xKQmksutQ=;
        b=r9SM1bPnYK+FodUNv/2Aw/JJTjUMqQEQHrowMlU5I/+xy/4M6Gl9pGYIVxsORSuQKT
         DY7MT5GMOn5w1EsdMJhaMGbiPjyx8agDDuN2A0GBbA/o0ng4hsJ43zG3uFYrHBHECZ5P
         gI1PyyVQaTndsh/+/NL7kw9jfN1qGpt5ddL/OvmCZjqKMedaZEigsQ/jAzcHFdK2lkcL
         gokJXUf6wjSh6N43tonTRPob1zgxaNvDTHEcV4vEaHuvzhpBVny7EC/TW0Zj+M46D8C3
         m6S6pwDDCdx1lCIdHJ3QWwbPJjZ/azV/7FlvYNlCh+KOXkEcTIaNklinLZKi71C2fDms
         lNvw==
X-Forwarded-Encrypted: i=1; AJvYcCXR3AwZzWTIssPKfNp+3UewZeRhOKr8ULbIxdJ/+Zzcxdb/Q7q77YXLU+KV/ntBxq4LELyOSttxRHFQLhfCl0xTmd3JC5d7wYBvCQkt
X-Gm-Message-State: AOJu0Yy5VAgEKvGK/L02/7//NIEy8fXcSROa6A8huORPXXLAi8xHygug
	qo6IpTGcl3LeP0i3mvnuJ7HHOKs+V9knYcM8GL1mbAgftP+M5aulvH9HSZjLel8KDdRcoCQBfPP
	gHQ==
X-Google-Smtp-Source: AGHT+IHEoaKEBsWwxbO1jgiLciNOYILWX/kr3OXU7eYFR8oe2h78U8w1/qkNR8huCRpwnRfRtdoPQg5B9JI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cef2:761:ad8:ed9a])
 (user=surenb job=sendgmr) by 2002:a05:6902:1141:b0:dd9:3a6b:11f8 with SMTP id
 p1-20020a056902114100b00dd93a6b11f8mr3483289ybu.5.1711494908452; Tue, 26 Mar
 2024 16:15:08 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:14:52 -0700
In-Reply-To: <20240326231453.1206227-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326231453.1206227-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326231453.1206227-7-surenb@google.com>
Subject: [PATCH 6/6] Documentation: mm/slab: undo _noprof additions in the documentation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, kent.overstreet@linux.dev, 
	surenb@google.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With kernel-doc script change to handle xyz_noprof() names, the previous
documentation changes and not needed anymore.

Fixes: bc7b83f5e4bf ("mm/slab: enable slab allocation tagging for kmalloc and friends")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/slub.c | 2 +-
 mm/util.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7b68a3451eb9..be047279c9e9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4091,7 +4091,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
 
 /**
- * kmem_cache_alloc_node_noprof - Allocate an object on the specified node
+ * kmem_cache_alloc_node - Allocate an object on the specified node
  * @s: The cache to allocate from.
  * @gfpflags: See kmalloc().
  * @node: node number of the target node.
diff --git a/mm/util.c b/mm/util.c
index 73703d6cd3dc..a9e911b22b99 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -115,7 +115,7 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
 EXPORT_SYMBOL(kstrndup);
 
 /**
- * kmemdup_noprof - duplicate region of memory
+ * kmemdup - duplicate region of memory
  *
  * @src: memory region to duplicate
  * @len: memory region length
@@ -594,7 +594,7 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 EXPORT_SYMBOL(vm_mmap);
 
 /**
- * kvmalloc_node_noprof - attempt to allocate physically contiguous memory, but upon
+ * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
  * @size: size of the request.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
-- 
2.44.0.396.g6e790dbe36-goog


