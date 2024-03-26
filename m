Return-Path: <linux-kernel+bounces-120129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7488D2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B601C38198
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7E13E89C;
	Tue, 26 Mar 2024 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yA7u+qOR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879B13E6BE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494906; cv=none; b=HGzut8t7xWxwv/Ct7EH9v1cCU2BEJ2Mw6wYC/lpdJ0zO9I0OsUVlXrRlGGOOKSdjB74DGJ47/tr3ObJVoCqK3XuYTTOyANtMqJTjWWcSqP8sXA4X9yT92vPek86qil/rYD7Om9HrKyfhWmid/1AFnRrgxHucLHotCmbw+mzk95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494906; c=relaxed/simple;
	bh=lFeEUshSx6B71Hh+t+eI0HFSWvBQ0JmDWE2YRzMmt+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u8uj0CsGxESV96WpCeUzD0lnKUYbCxOn40D713SsGtmtPEhqAYKTQBn8gwO7WTzBr8Jz6PK8dkLiM2iagav5HVOPdHJnI5X8hnJ0fplI/Nd5u4Ds7mHh7BS7ktP9A5c1Vn7cpI8NHphD7yALE+WGF+YfNoZhiNU74QKjpwlzoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yA7u+qOR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6f571so111623877b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711494904; x=1712099704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1zpMAHTkJIGxVEr35nJnrD/WTFtttLl1QenMrHbBG0=;
        b=yA7u+qORsbvLot4y2I9zIk9G1tqDE5f7ha/ncbgCdyWY/We3bIRFFnFQlAG2+XBbbv
         /LGDtWtVzM0nHZ4NabK2xPA64RCbgNlHYSOzZgDDCX937eXC4nIBpKPVjKLxOmc7NQNC
         MRbT5wJuicbFTO1ryWxWTcd+6/WlRgw+O6WUb3mYhkPEKHQgcwkefVqMjWL+WLZZw06Q
         u4FmS3vXAtUc0PoK1vl6wamjw5jP8TNqxe4pqQNrmjE12JOQEvdiEgYxwTCNLtcL2Inj
         uhfniA8UeAMeLI8wPxDGYhyc1+sRWjwPSO4Opc3xMrz73veExgWSJxVPRsPbljfc+bXN
         Tc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494904; x=1712099704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1zpMAHTkJIGxVEr35nJnrD/WTFtttLl1QenMrHbBG0=;
        b=dt6e4Ug0OJldij0T0sbpf34a7TnPp1K0u1Y5AbzuP0CWnMocmQwrrYQHYxOKBEGxyF
         OGQoJ2YHoDZTvcf4ulqvlFfaHufoKeGxOJyp3SX7LX1JSFX6eZZIKOM2JVWhLhynvDJV
         AsBh3gQzpAb2PPa1TNe15RuiKtmKnZRMql6X7pEnTx4aem8P2W/fr6XyssQU1LpUzO1e
         ee+11R2ffGJW93rhYM4ps9IbE3jWL2IhoGg6iOuqyQf/YAY66wmEq5FtAnx+871BMNQM
         DLMO5+VpuIFKDHGKd+npdlbh3UunGglh3gz+2GsalpVCILVh1orIb5SZeRyUhR81TjW2
         A1UA==
X-Forwarded-Encrypted: i=1; AJvYcCVos8MRyf1wthvoGe4ogQikl2gNYttnmkghU63liGDDrRNUCQsv6pacwd/Wa5LVxiR0qUi434T2Zj7RHegOI/cd++Ztl4D32qEYfGtR
X-Gm-Message-State: AOJu0YyrwKrqaBjGUjpDe+JaZwNcDCWh+jgXXHc0YGpFw/HaEoL58SYh
	oZ4qGL79o+mHR/Zvja43bRUN5xsbFrkvGgOWwQy6Pv8MHy0m/g9NOyGYPKXtEaARsxAE1uiTtOC
	xHA==
X-Google-Smtp-Source: AGHT+IHj5F8DepFyhSxPhI7O3DbFDYyiys5DH6IOqbp8/7mkJ8GY2Mpdf6Up94sIeC0KXppTdKghpYr7NYc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cef2:761:ad8:ed9a])
 (user=surenb job=sendgmr) by 2002:a81:92c6:0:b0:611:2133:8657 with SMTP id
 j189-20020a8192c6000000b0061121338657mr2737319ywg.2.1711494904325; Tue, 26
 Mar 2024 16:15:04 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:14:50 -0700
In-Reply-To: <20240326231453.1206227-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326231453.1206227-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326231453.1206227-5-surenb@google.com>
Subject: [PATCH 4/6] Documentation: mm: vmalloc: undo _noprof additions in the documentation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, kent.overstreet@linux.dev, 
	surenb@google.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With kernel-doc script change to handle xyz_noprof() names, the previous
documentation changes and not needed anymore.

Fixes: ed49858097c1 ("mm: vmalloc: enable memory allocation profiling")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/nommu.c   |  8 ++++----
 mm/util.c    |  6 +++---
 mm/vmalloc.c | 14 +++++++-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index c0c58631d6cb..331d2f778695 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -223,7 +223,7 @@ void *vzalloc_noprof(unsigned long size)
 EXPORT_SYMBOL(vzalloc_noprof);
 
 /**
- * vmalloc_node_noprof - allocate memory on a specific node
+ * vmalloc_node - allocate memory on a specific node
  * @size:	allocation size
  * @node:	numa node
  *
@@ -240,7 +240,7 @@ void *vmalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vmalloc_node_noprof);
 
 /**
- * vzalloc_node_noprof - allocate memory on a specific node with zero fill
+ * vzalloc_node - allocate memory on a specific node with zero fill
  * @size:	allocation size
  * @node:	numa node
  *
@@ -258,7 +258,7 @@ void *vzalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vzalloc_node_noprof);
 
 /**
- * vmalloc_32_noprof  -  allocate virtually contiguous memory (32bit addressable)
+ * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
  *	@size:		allocation size
  *
  *	Allocate enough 32bit PA addressable pages to cover @size from the
@@ -271,7 +271,7 @@ void *vmalloc_32_noprof(unsigned long size)
 EXPORT_SYMBOL(vmalloc_32_noprof);
 
 /**
- * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit memory
+ * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
  *	@size:		allocation size
  *
  * The resulting memory area is 32bit addressable and zeroed so it can be
diff --git a/mm/util.c b/mm/util.c
index 157b5edcba75..73703d6cd3dc 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -715,7 +715,7 @@ void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flag
 EXPORT_SYMBOL(kvrealloc_noprof);
 
 /**
- * __vmalloc_array_noprof - allocate memory for a virtually contiguous array.
+ * __vmalloc_array - allocate memory for a virtually contiguous array.
  * @n: number of elements.
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
@@ -731,7 +731,7 @@ void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 EXPORT_SYMBOL(__vmalloc_array_noprof);
 
 /**
- * vmalloc_array_noprof - allocate memory for a virtually contiguous array.
+ * vmalloc_array - allocate memory for a virtually contiguous array.
  * @n: number of elements.
  * @size: element size.
  */
@@ -754,7 +754,7 @@ void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
 EXPORT_SYMBOL(__vcalloc_noprof);
 
 /**
- * vcalloc_noprof - allocate and zero memory for a virtually contiguous array.
+ * vcalloc - allocate and zero memory for a virtually contiguous array.
  * @n: number of elements.
  * @size: element size.
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e94ce4562805..48344d3014fd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3685,7 +3685,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 }
 
 /**
- * __vmalloc_node_range_noprof - allocate virtually contiguous memory
+ * __vmalloc_node_range - allocate virtually contiguous memory
  * @size:		  allocation size
  * @align:		  desired alignment
  * @start:		  vm area range start
@@ -3841,7 +3841,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 }
 
 /**
- * __vmalloc_node_noprof - allocate virtually contiguous memory
+ * __vmalloc_node - allocate virtually contiguous memory
  * @size:	    allocation size
  * @align:	    desired alignment
  * @gfp_mask:	    flags for the page level allocator
@@ -3921,7 +3921,7 @@ void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
 EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
 
 /**
- * vzalloc_noprof - allocate virtually contiguous memory with zero fill
+ * vzalloc - allocate virtually contiguous memory with zero fill
  * @size:    allocation size
  *
  * Allocate enough pages to cover @size from the page level
@@ -3959,7 +3959,7 @@ void *vmalloc_user_noprof(unsigned long size)
 EXPORT_SYMBOL(vmalloc_user_noprof);
 
 /**
- * vmalloc_node_noprof - allocate memory on a specific node
+ * vmalloc_node - allocate memory on a specific node
  * @size:	  allocation size
  * @node:	  numa node
  *
@@ -3979,7 +3979,7 @@ void *vmalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vmalloc_node_noprof);
 
 /**
- * vzalloc_node_noprof - allocate memory on a specific node with zero fill
+ * vzalloc_node - allocate memory on a specific node with zero fill
  * @size:	allocation size
  * @node:	numa node
  *
@@ -4009,7 +4009,7 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
 #endif
 
 /**
- * vmalloc_32_noprof - allocate virtually contiguous memory (32bit addressable)
+ * vmalloc_32 - allocate virtually contiguous memory (32bit addressable)
  * @size:	allocation size
  *
  * Allocate enough 32bit PA addressable pages to cover @size from the
@@ -4025,7 +4025,7 @@ void *vmalloc_32_noprof(unsigned long size)
 EXPORT_SYMBOL(vmalloc_32_noprof);
 
 /**
- * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit memory
+ * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
  * @size:	     allocation size
  *
  * The resulting memory area is 32bit addressable and zeroed so it can be
-- 
2.44.0.396.g6e790dbe36-goog


