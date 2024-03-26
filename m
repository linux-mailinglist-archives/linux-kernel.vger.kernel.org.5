Return-Path: <linux-kernel+bounces-118749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7E88BEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86085B251A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD565197;
	Tue, 26 Mar 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vwgx5YiM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094195C911
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447721; cv=none; b=u6gVGr0SiJF+5ukmopCrZvF+S03LXpQwYl/hmJGSE/xdgiH9IGOfoRpMW4q8zwwBp7T2qGoSEmKC19Aqwt/X8NH6ql83sAgML68i9dQc8oE3Bhj6vD7GO4gW/Zj3MsllbEYcpHvTjR52qtyavK9c2/gzwBkGPARN2fWGmR1y7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447721; c=relaxed/simple;
	bh=fmGO1bl7uIIHf3GZWx4iYgb5Kr3yiA9pjGjZZE++s/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=auLvFs7BZklLUCkLhmD/QoACc6y7kcl2fu20qhZONpqHhwXGg+PiSlwafJOusJ0vt2fxqmA54u4djNqZnpKyozl3if7bb2Queh7ogzyaD43Dic9rpp9EoOP/px+aGWCrnPri3CV3AgQ9owLReyfRE9TSP0QjDYl7bApMwZIbJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vwgx5YiM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4147ddecd52so18334085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447718; x=1712052518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5T04RutDX7ZRsYqi7kr5/lV+ciJTNJOpTaA63uf9M=;
        b=Vwgx5YiM1eLpvv+eSS5uAX30MEjkWWoH+3qjVOaUjTWkANpe563IYDESNAo72hGS+M
         ixgEeI7Stur/gqhcYWyKQWa2vJaAFjCfEgDFbLoqIPrrTXuoY8fjM2cFppD3wIlMF3VV
         iHDjITuLsgTdmd5OG+NxGAjjCpg2ZgZCn68HLu2PBMicrxJ4hNOep0+DNnAhgE7QerrE
         IDA+LdXDV29GnrMSb8HEAaVeh6Rf6h+xcvkB7AsBK4JxIbuSLa74D9e8dG/KPUZUaDgR
         +dLeDHBQJo7xXdb16srOT9gWWeN8tsSSFrEJIijn8W7PWtJNFghuq2C3QbP8quKyga3d
         Lo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447718; x=1712052518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5T04RutDX7ZRsYqi7kr5/lV+ciJTNJOpTaA63uf9M=;
        b=lhuCbNnq6gwGsfRv06ghkez2TD8xKrabU/cEeNfqMv3I158kf8Fn9+9cIMmZ89GA9H
         8BWOKRarynWDtyHi4ryY3/S0oH/6bJxEKanDXudQVwh5x8UOPORaYhVDCU69EOPt6VEt
         wK2RU2C4wM77c3ejpHaj794YFJ5HST+H7cur+MvVpgyKAEPq4LMn9OV+n/s7042UVbWk
         dEXj0R75uwg/yeet1au6vMv41/EHw3xlD4l13w+hjY80ijqo31IRzBY9XEOYMSYHTSkQ
         fUx3MvKprJRWPxk4DhzfyYueBxfkllJ7TFriUfyjzffMvrQk7z27jbLl05g3cQhvVRFQ
         Jp7w==
X-Forwarded-Encrypted: i=1; AJvYcCVIS/7CdpbTuRzCkya3XSZNe4Cc3FmQcIc401LPXjJZv/TuT5qnH0LjKN06Zc48wxhyOHcv+sGKyuLJUX7216YaqQ+138EI8yDcpDqp
X-Gm-Message-State: AOJu0YyXCRYjgKc3fom19+YrHj5pn+OK9/aQnWMJbGq17mdwybN11pX1
	lST8Enn0A46/4ROszuPt4l1DGMOiyr9Z8G/EzdskXBSI17ipym+o8KLMLW61jiPoAIghAbw+FUu
	CPkBrvgeAI/z0o9JB4w==
X-Google-Smtp-Source: AGHT+IGmT0qe/QFYxKgVByBYm8E3je0a+ZMF/017YeJ3F3HMFUeB8IlBDeUvw5gM6vC51gp9kygoLOjDS8Vrfks3
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1c1a:b0:413:fae6:4bac with
 SMTP id j26-20020a05600c1c1a00b00413fae64bacmr29535wms.2.1711447718687; Tue,
 26 Mar 2024 03:08:38 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:08:26 +0000
In-Reply-To: <20240326100830.1326610-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100830.1326610-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100830.1326610-2-vdonnefort@google.com>
Subject: [PATCH v19 RESEND 1/5] ring-buffer: allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
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
2.44.0.396.g6e790dbe36-goog


