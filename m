Return-Path: <linux-kernel+bounces-118735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AB88BEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268B32E55A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6E5CDE4;
	Tue, 26 Mar 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5Ay0qJX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF329548FA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447471; cv=none; b=Ot01vDbnhUMOKUWh0IIukgh+F0ZnjtadePzNGfkQTVJRL1/T0QSXyzFYPnxpNL3jRCBua234V0kOeS0ZlUOGoraEcHp40WGUdhFb3WFW55Z7jsOdiGiEOqX7NYuBiR3KRw1W5TGYvH4YSa00aW7EtXCxfwbJfgGJg2AzINI2qVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447471; c=relaxed/simple;
	bh=fmGO1bl7uIIHf3GZWx4iYgb5Kr3yiA9pjGjZZE++s/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+zHKMKYntEladSVCq+bRiQGxXSeQwSmsR6Mr6/qe3ow4ndGLyKqPX6fYnXYFmt11o1GCV4h202tPrcCVBaOJQEkj8DtkWx5iA92sOGVYR70t43RWt5tsBU7JqbcAbHgonYAkj9B9HKNAj75T4TJfF7O8kAGBv1TqhFvfaPWVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5Ay0qJX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4140d2917e6so28877035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447468; x=1712052268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5T04RutDX7ZRsYqi7kr5/lV+ciJTNJOpTaA63uf9M=;
        b=N5Ay0qJX6Jq5BAFwZO+oA1CQZ7nmjGepqIk+7gOlu7pp9oAsXWNwiOkshmq2IJrN19
         WG36QVNhhTT0783qzNRzKTN0upfNV5yE1r+cr6euL0Y7rgtSHDfgcwjIlhsHRmKpBCya
         mOKP1Q3koczXQ2htzLn9Mb+wtAkE46NhxPmT6zCqtBrXu4cpy2LhPVjCVK26WnFO3Ubz
         FXWUYWQaSBt3d3Q2lCV96ROJhJbYvcB3zaq0yczCni8S+2N3VBTpdafpNs0ktHZpqIEx
         eE5uFCAYZDx7fVjVRXIKw33ryB3EN9FwFojTIhL/5AiJ7v8NPnTkAAOU/JC0gFa1CNLj
         E+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447468; x=1712052268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3D5T04RutDX7ZRsYqi7kr5/lV+ciJTNJOpTaA63uf9M=;
        b=eEHlzCgdPfNQ+Kugoq6xCfmj/jbLWz0732I/5XKWXU4ZvGefwggGo+d243WnSuWGAw
         TT2vE/OjC/BT1XQMe38Af4Nlgl6HsxaWrgRFwV3L8d45Bqumucjwm6sB+iL3gy1PI9JZ
         4iS0QzkXXIjDFuBrCCDJE9RBzSj7IQTHjAcI9d7r0MGXQPJdPUqHj/p647xAY59RwPLz
         gt+GY/h0rM81Sdh71A4wxBZQSpYAN8q9jUrOFKjHbyWii1G1+QZ0HqnS+x/4KSK6hTXg
         QQOiiL0GyRpdubRcQmdD82z9QmrhN+1iwTlzeM3MUa80YC6fzHR6auuUFN7wwDAgi+VS
         dxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUQnizxmfGy1sqBP4o8JoHhtsTqmMssJR7XbZdlwOx40ufFheV+R6zlDMpuE5e2LAug+q+DCtxY/soKr9da19nCATjRj0e7kz9EcuSj
X-Gm-Message-State: AOJu0YyZlDFGevSRSUGZI0cc9G5k/g65QSWPXTnFrTnmwg47pRTX1g6f
	7NREuPoFAKPE39Fht0UyBVpYVPmSa5jCi0dK3kRVPmhGb+WjiNmdr1YRDuSQmVw7pbrq/HODpiD
	Lxq7PFUNt0dgc9qffyA==
X-Google-Smtp-Source: AGHT+IGwIllNDYK+IPKSgqo7E8qVb5bWLE1exNxNqbZF8sc5BBGjPKB3Hez5pkqa0YWrbNcvisvZKgiM/PBLH9AG
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d08:b0:414:afb:6199 with SMTP
 id l8-20020a05600c1d0800b004140afb6199mr67220wms.6.1711447468440; Tue, 26 Mar
 2024 03:04:28 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:03:26 +0000
In-Reply-To: <20240326100330.1321861-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100330.1321861-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100330.1321861-2-vdonnefort@google.com>
Subject: [PATCH v19 1/5] ring-buffer: allocate sub-buffers with __GFP_COMP
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


