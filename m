Return-Path: <linux-kernel+bounces-59211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A602F84F347
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B5281AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FB69D21;
	Fri,  9 Feb 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLlCa8RU"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77A6997E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474137; cv=none; b=mNRf8eyA9DZoxZPw12UuMtBtHZc/MEBKoagUo1ICHiDuG0+zkw3MSZwzB9YLNIvX263ntNoGGsf4qC2YDSZuCFH0dQYFOMBDFPo0iULGZnYAt7DwpW8aP5tJlZ83Rzq3rBkhZP8WXfD1j75Q1NrzYVJuPIetC0e7TLQYfXNzjkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474137; c=relaxed/simple;
	bh=tpt51FeO44HeEXQqmygp1fYLZoXSRZvsHL381MrJybw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cWPCaQ9J5Nb2YBrZyayuWJSmdj8/YtVfnWV5F6A6m8ug29V2PzxK6eiMeU0Rr/PcbGdDWERHhanWbEafwbjmiqAuDXVy+aSzk91Gv3ruHm8hYgOlwyBEfo7151P4mF6qot8xJsuOHsttlU2tHs9Nd47N22xjhXIStNIz+H3RdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLlCa8RU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41024549a9fso4812355e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707474133; x=1708078933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=kLlCa8RUO+aJbOAGzlI200T2102ksm40Zm/LCL3Wby7z/nlFYP3NWZ/657VnDhipGZ
         FYbd1gq6jfLt0HHKJ7lbZ5w7bBu9SjZWzHe4s+G725HkOHfSw/31yYguJAQEd725cBw3
         aa0KRf9tOKsBIIbeqLORDDuduYZVgAAzfXvLQSqeWPXm5tRFhFjCfM2YjZ8XwzIHMvXi
         /I2U4BZCcfkPAX+/c6H8VAehUQkk+fRYDNE+x/fMLJdO1v4OBv4vpTIaeBDHX/+IN0xy
         7GPqjB21aWGMr1lqUuJm389D9yAuj70YSucfg8OvhlMcAh5m+0MnattXBWOznX/2n/EH
         lifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707474133; x=1708078933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=ciip3GTCfhD28l+3OvRSKGv12ktnlhUbzhFzihstjrHwzTgGG4Q5SPI/wqgIPozlCh
         EoQvj18m04GpNcgPsq72nYxIKN9VvRewlsoJeu8C3Y9FO33cmVNK3tIP8q7RZxoxuKEC
         IkqSwX1pEksagF4jEgWEq4O8QSgmTZcsZK+aV6hIDwfFTKw3dewM5eGkATmhxCo5jsn7
         E4ciP7yukCSCDRCP/Q+Psg0rjZWFGeNMaUYC+T3ssAsTwNtx3/hZ3kZ2ZNnRPIaM4o8p
         NIVLTj+EHQntcn+jEjPZeVRW2no2N1hpc/6Nw5zeCXEiXjzWYuuL7DR6grxeOrKe3lHe
         ImlA==
X-Forwarded-Encrypted: i=1; AJvYcCUgXvtRqASxBOttQ8LtJhjL5jdRNBmq9dNkM/kA0HAl2DrpWvVXzT/tP2snAiQllSZOcNus1pmRk7GSoHab/0P1ZVUZ8/dzGxY/ZZEY
X-Gm-Message-State: AOJu0YxU5fNV0NjoNs3uu1lmYixkfsZ1jX0iPxuIg/Y7HoSJ52J7x07e
	IikgepZJRSSafALXNMnm88tEoBEqQNLKOVcS32g05dHA/hZ5xsWxGrqHiru3HrE80NZokQNjehZ
	3nU26pxI+DjB7lKGiHw==
X-Google-Smtp-Source: AGHT+IHsCSAWDoTALZ69dIqskVJ+bDPuZT95tyOFjyEZj05BeKokuUE1iA67QgC/IWMdyoq7Hn3fUiXGCF0cHWUR
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:54c9:b0:410:6ab1:4964 with
 SMTP id iw9-20020a05600c54c900b004106ab14964mr18382wmb.1.1707474133639; Fri,
 09 Feb 2024 02:22:13 -0800 (PST)
Date: Fri,  9 Feb 2024 10:21:57 +0000
In-Reply-To: <20240209102202.649049-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209102202.649049-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209102202.649049-2-vdonnefort@google.com>
Subject: [PATCH v15 1/6] ring-buffer: Zero ring-buffer sub-buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..ca796675c0a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1472,7 +1472,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1557,7 +1558,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+	page = alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.43.0.687.g38aa6559b0-goog


