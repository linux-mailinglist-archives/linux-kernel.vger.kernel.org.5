Return-Path: <linux-kernel+bounces-42899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC4840848
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1361C22986
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DCB67A00;
	Mon, 29 Jan 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0exiY9Ct"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6267746
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538495; cv=none; b=lSYlHdhXW6Rsu996Azmq4IDUMealbT5lVsb3xeXeMj0O8l+7BGs+t+AXei/B+N43TDmihPpgC+6qjIu1dECJHjVJUphgNYM683KB16MmLicuKBe1z3gWCiBG5gQA4dNrIn2FPVV7Y8x/40EM3skie+raEpMf+ZT08fxZqBB32Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538495; c=relaxed/simple;
	bh=PpF4zLtyNj9CXmhyJ3j64J0DkNQBX7zfEhYVZDwuYVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YbCxCttuZwby5hooBJ+3of8Zk82Oi9/kYqj8JxWlZId4h5CaEqtc+dpKim8NtlHEa3q6R0pZ+hovKVtI2Dk05QfFHTGxJzLSwfWYr51FYqeoSKPTfE+CGqOpMjHc4/LwKHBiN108tkZE/WsAx8oipRdLFabBlbhj7lmPmEqhN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0exiY9Ct; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33af0097cb6so393004f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706538492; x=1707143292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZpw6aKuRWuo4QABAvSv/PLQiD0KFqkUXHNjRNaYsLY=;
        b=0exiY9CtxPZ7f5GuBgQtq8/T1JzglRtIOna0XgdbpWw6FVHssXvzoSAJ1a0Npks43W
         9UjuayYjSqZ4hLAeypMTGc85Ro4txn55m3Fe/tF5CrV2eGcfEP/CK0tQLzBaEWBXTx3q
         xk++YLrY8XYWzaA9ZX5xf8bCA9J8kWEkX5pWpUQbEUZu83MpdKj0r2A61g2vey0Ud8xZ
         xUhe9p7l+QLuxasEcfDzUNKfRIn49T9Hi6NAVrnNgYTpp6+TRgWa4Kw0cdoAo+iZzgdy
         K4HKuIhVLQzwN9KunfQ1BpWUEleoI6k+PTHtWh3AuyEdFRfEDsHP+itUfyH3Ym8jDeqo
         /+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538492; x=1707143292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZpw6aKuRWuo4QABAvSv/PLQiD0KFqkUXHNjRNaYsLY=;
        b=Rvwn8T82CoPkY7xOZLqyOJ+gc3EBuymKwqUFCEkdpBtl11Ub6L7ErezYMFss8TjsE8
         wiEvQJwopDjDtc189NG1Stt/aVXDweaHvZpNKPoMS0HluG+KGe65ZsEOzutFyMsF9jd6
         UldMywXxwIo1fFj6Bp+US+vGumYZfFzIr/Bta3Sxtg3Hvw6rp5WGNXUPT/gBgbh6fn7v
         Hq4oJozqbC98jFSLGdqobaY+jC4YX3Dy94huDzpBjvT8VSDsxgSP2n1bzhCAT0RdOMsx
         NxsgoIrwgDc/cAtaqT2ddTlPKzvUedN5UIvZrhjAWV+23Ubw5DFwo43EWc9PNcf+Cfb0
         4I5A==
X-Gm-Message-State: AOJu0Ywy6+2tLc0+lqwHh7+H5AaR+g6PCJgUBXiUwl6Rm3PYFyzTPD1x
	t3G/0UdbF4d7xCzJ5KHmDqbA3Az5xrOqPUA/Z/IzW9fwDvVBNvVxyFQe55LCy/oLa73m5KlE1Iw
	HaH+pQDXTz+z6Km/k9w==
X-Google-Smtp-Source: AGHT+IFMonkhqDUcN39/ZdeIK7kdmPkLhnphdc1vzw1S4Zd3wpIhO0mhH1F6zCqbaudUglri2jrtIpX9gYa+atF8
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:797:b0:33a:e5f0:f2ee with SMTP
 id bu23-20020a056000079700b0033ae5f0f2eemr10877wrb.7.1706538491940; Mon, 29
 Jan 2024 06:28:11 -0800 (PST)
Date: Mon, 29 Jan 2024 14:27:57 +0000
In-Reply-To: <20240129142802.2145305-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129142802.2145305-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129142802.2145305-2-vdonnefort@google.com>
Subject: [PATCH v13 1/6] ring-buffer: Zero ring-buffer sub-buffers
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
index 13aaf5e85b81..8179e0a8984e 100644
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
2.43.0.429.g432eaa2c6b-goog


