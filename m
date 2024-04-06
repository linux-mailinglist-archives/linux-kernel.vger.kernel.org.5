Return-Path: <linux-kernel+bounces-134045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA7089AC7E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7511F229FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7740857;
	Sat,  6 Apr 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGZhU82z"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD64438F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425034; cv=none; b=Jlf4K0DzfvxcF5nFoAecPhzlcKjW8C5rCKTo+jASUnn/2tdHjTB4KB0DcomcpQ27D0x2MvseH/WfOc8JVkBAPKybDXOi5hGTYVCUjuGULdZYQvFq/v58Y81oBiqhumFP4FtN5hJzAXkBuCi5n0uIq2EhGBm8o+twHeBG5+MmA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425034; c=relaxed/simple;
	bh=BeIrHW+T2nh/AGpI3eEBpBah42JowlQbOvynMRVHWBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SsZ9bw7dmlCbyZrxYHFPGTor6vI61X0DqMRiDM4ue8w1pN14RRDPcf4bxqyGeoLcS4ctJQVC+TNiBp28KWiAMpkdJO80Zc+eHyOpLooSuPipK9Aei5/hzjs56m4aeL1kSoL3Jrf6c5lPyGnuEeTgOXJP0D4NysdXt+wguyzeo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGZhU82z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41637639f0eso2642045e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712425031; x=1713029831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAJeOxdOPDtRW76Ag7FnaqNs2+ZUgqSGGU0SIC7i8bQ=;
        b=lGZhU82zQ4tUm8IlLBAOp86bCg9WLxWqMRAWRY/ugb7C8YtLJKfBvrMo+v36yEntHb
         8lr8DLYMXWFRHIMlw5r2o/TmtSapToJI6CPmGaj+db7Pdg7GGVDe54JeGOnMmXcp/fu6
         RcptK5igHVuicl7SXeKJRf/FE05PFl+OYok6ZRxaisoAohKKTjt1fLUrUZO2EKe5eNmx
         dhViKerNhDD9T28+MjD1bovNdqqSJCotHTPnqHFXP6m9gzhPep4XeD8PeOwpbeSVl8g0
         lFB6j1Uxme1g+kgPlNXFbjJVDkk5tEk4Z3I89xel95hpQWcaJg+h9SyInOsUL1Nqwbl0
         2bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425031; x=1713029831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAJeOxdOPDtRW76Ag7FnaqNs2+ZUgqSGGU0SIC7i8bQ=;
        b=i46bs0RrCQvMPeGysUuF8BAhe2ZrTxI+VNB7Ha+nb8ecPll6aFtMKeXlTeCzryki65
         zVlCaOxlPeb4Cx2xH7buXsySHFfI5iQYSAcVyL4zf4GDhk8iI5qYSm438WUNCRId9IDN
         OFY1E3k+SdCA7cLhO/c9CXBh4LLVCy5BXz8viKINCnYqvmzJJgvZwFLqwHvdruQ2p7LE
         Bk9qoSrVXnfhX+fE972lqxJsdUfkQ0bq61VrLWrGyKVGjwZrjFbuPqyQ3cSljFOBzuMZ
         i/IpNHOX5POR3WTj5+BcWABSLZkmkromZvP077hu6KAM2CGuom84Z0DgpUDm80he/1HF
         b75Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+trUcxmXouggJoDROfm3KqeSnqST36CQKF6gOfpXjKepU6Z3JSAcmtTUgHmT/HWFWuY/FEJAGsVvjDsp/6uP9XhUyRMKBTult73FA
X-Gm-Message-State: AOJu0YziwLZhr4YhNbjyIbUmWfD0TjvBsn6xRk/Npuqmz3ahYsRNNt4W
	F5Jo/ACCIYwXhnaaHIkfQl2mliff+b5NkYWYLoi63Wt8JCEXzu4xTHQ/QqcbuKmwVK7WjJU0xil
	/riYEJCYE2453vJ9bRw==
X-Google-Smtp-Source: AGHT+IGLf/sk84IAjrrdGcpvC7gOW00K9LWZoLZtutt6vhBA/F6UXSAP20h0RiEYwW6ZuGGixOZHwRNs6xRpsmmM
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:46ce:b0:414:63ba:ac04 with
 SMTP id q14-20020a05600c46ce00b0041463baac04mr12446wmo.8.1712425030803; Sat,
 06 Apr 2024 10:37:10 -0700 (PDT)
Date: Sat,  6 Apr 2024 18:36:45 +0100
In-Reply-To: <20240406173649.3210836-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240406173649.3210836-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406173649.3210836-2-vdonnefort@google.com>
Subject: [PATCH v20 1/5] ring-buffer: allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping, allocate compound
pages for the ring-buffer sub-buffers to enable us to map them to
user-space with vm_insert_pages().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..cc9ebe593571 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1524,7 +1524,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-					mflags | __GFP_ZERO,
+					mflags | __GFP_COMP | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1609,7 +1609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
@@ -5579,7 +5579,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
+				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.44.0.478.gd926399ef9-goog


