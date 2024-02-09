Return-Path: <linux-kernel+bounces-59610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660F84F9AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D14287196
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9117BAE5;
	Fri,  9 Feb 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phyjwkxs"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F279DB1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496500; cv=none; b=VSah0SCgRtWOeTcctDAHCsvWKQaYlI2t77P6JAVmbQazMtpFZLrq8VcszPhs0hBs4MML+ztX/KI1jFHjg1BB8XRmsYKpu42TJs2DXeMsLpqi9+Xkkb4p9ePyVE6zdwMIMODZKX9ABU3cJIhg9wSJQ7Gdh+RU1mhrrOtJ+jTYNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496500; c=relaxed/simple;
	bh=tpt51FeO44HeEXQqmygp1fYLZoXSRZvsHL381MrJybw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DniC/RN8lo3GNVdrxEMVMQpO6zO5hzq89hdLOSffLYeR9WJrCy3ifDjhZBcWBLFxRVZJEXH8nGzun/akGZNJnRQvou5hL1YNkRh4s3WXRFmRX53ElGXDjxQ/bL2oYos5ovLJYAlJqllNc7GBu1sqQbkmznIud+gRTVSJpz8aM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phyjwkxs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604a4923adaso21423927b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496498; x=1708101298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=phyjwkxs2hfxij1srxXmONjYuSe3PReyQ9CMi2LTWTwvM6LOwGS8xkhOVjrzRwlOLj
         8KtLdsEZziMaYLZLJOnskI2WZfRc8Ykh86PieGQBCGFnwDRMlH96lvbroXdwaC/s/cvZ
         sgN5bUfR0fo+Fb9JEynvKkdBCzwgeCVO/l5Z5tSZImqdaAIcGeOMdUDVFcL4KET75M7f
         2Hn/qrsiDNEBZm69o9wQXRjamdGJCvihcMoNvext8Q+PFFfLrNNh4MkVtHhYmeiH5khN
         pQqBHWoGSrrm1JZw3I+AG2vxNnMYgx1TMVIm2zGPFHhPf4EwQXCUqkzb52BkA6s8DEi+
         DncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496498; x=1708101298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=AYRT/+g2H7xDap/2HzmiIYMTFdn4ATbDYrToo/jdRpbf7IXU4VDaz0ScYFYGmOCM7o
         BYEHXrqIQj8kqi2nNPqEd7PkUloiUdwZDcYRjMWRXd9iicYHGeQlqBmzYyY66CGfxCDu
         MrSEfSIVZifNWuFO0+o7l35D7Yrc/n8ARFE5JxZI8suQXJOpEzotsQIEIuy3Z8bBQDhp
         b4mKgP+EMo/rum9ChtJYVnZQEFx9SRDH6BL+MCK7eLBq23Cut+FxGWQ2ediZyWoqSZAX
         WwATFsVTzy6a7cKhTZSj7AkqzbpFqCob26T54SAVPexpkFFbcd4eESvopFyCXVR1OnXD
         fO0g==
X-Forwarded-Encrypted: i=1; AJvYcCXQlkW88MYy2LUJlIYaxcW7rNsuNdqxNLexOi8wLVeyJBvYucSeq1FTixYKqlLfFc4HyP1bHSkFNUmaKjE+fHH+GPNxEXfORr6Pvlwf
X-Gm-Message-State: AOJu0Yy6fasTohLUhCTJN2x9jDDB3sUjqK3V8f0b48C7IzQx9qy6BgD1
	hGD3PTymOs/x7wNwpz3ieqgUbcwozkbg0KamuvcNlN2tBzvRbWPgg+g9yzTsybrcvRd7Szm6dx4
	7MX4XLZAX664scQt7vQ==
X-Google-Smtp-Source: AGHT+IHsUr4KLeBPkUZktC5moT97bX5Rxc0DBZEC540ur7j/KZeKn8oGEo5KdM8bxIEdnlwUn8otuef9jKTuaqz9
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:8491:0:b0:604:9b73:ee86 with SMTP
 id u139-20020a818491000000b006049b73ee86mr275232ywf.4.1707496498236; Fri, 09
 Feb 2024 08:34:58 -0800 (PST)
Date: Fri,  9 Feb 2024 16:34:43 +0000
In-Reply-To: <20240209163448.944970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209163448.944970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209163448.944970-2-vdonnefort@google.com>
Subject: [PATCH v16 1/6] ring-buffer: Zero ring-buffer sub-buffers
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


