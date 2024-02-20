Return-Path: <linux-kernel+bounces-73669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9785C5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0BA5B21E33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003814C5B0;
	Tue, 20 Feb 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCe6XRjN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63814AD0F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460600; cv=none; b=EQsWRCNtroLJkTo/RLIImcmEWX2T7Mi0lHzfZLavbeePXV+x3xd0jIY/BmbsfCSWql6eltu1xeTLmOO0tEeUSwV2Se8aMeE3/CpQGUy4S5wuq33/8aVXPiNVjIfOF5bKq/yjczhhw02nlnySSsfrGFXAi4JGzKKhIBoUqdHcBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460600; c=relaxed/simple;
	bh=okSYdCoqtYalJqTVBXSYlec5NVTxMVA7/+jsV6YNCNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oDtv/Utnrz4/ZeqeTFLDUFWwBcIoAwRLf8hO78IPNdBLOmM54xhojhVza7mC+rDNEgIqDKUNR82z4ItgOex9wHhzNTpHW842AoTE4JAwBYmNpk0qIJW0SqGk9aL7iX4mx1pETTRpL9jU1pd/RerbVSZ2tCJBXWy2cG1j/XAWZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCe6XRjN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso12442037276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460597; x=1709065397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2evzm3HI5GwNbxXWo5kB/PowbSsdEjz5X/q5vGufRc=;
        b=XCe6XRjNKl6p6D+QtnVQ1fd7smNuNNF4gBbip7rGWdP1a9Zwnxyxrd1pYVihv84RY9
         WabywR95mB+MegEgdXAnDXr68KTYX1cqytlQb7wrnLOLVGuu2kqszQpbhTqqn1cIP/gC
         d9Z72cSndzBGxmybUSkSBj0iZXd3pLfFhZ+Xqiyp2J9KCelQXOJymKmMr0PVBZdQsXHX
         b+WskpkM1w1+CPsfhPajAZux0PI+FhOhO1WHZDlJ4Z9XT6lMcHxmK6YShuJe9FiMvtA9
         EzuHCIyvpCTAMSnwjSIA1xUEz5rxDYnp+tx2OeAoW0w8YrhqLeAjLOKa7TU+znrT/IcW
         pfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460597; x=1709065397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2evzm3HI5GwNbxXWo5kB/PowbSsdEjz5X/q5vGufRc=;
        b=qroMiefGuoWRTtVnmreksaTG46fR7a6n4wByKUHoHP1sGIdkLy9cetvbDm83b1lZTD
         bbEZyYWKquosXtgoNqwtc2GIuGyiOKN0NjSh59vjt791oNlMbiq9/AASMVMj7wMis7nq
         MKFrDjBDRKRRiKU1uOP8g4biu1Kz9eaT4zelF05CWwgEHcO9FEO2Zl2dqUny4EzeZ90T
         kM3i9uKyLLKeOEcmNaGYXZ4TGSForslqLuSEHHXmyc4VPPxAWYgzcWWZ4RYk0564o6pZ
         WF4KSZTCMa9yhO63ctaVryRik3YAqHv4KrhtcXOcYo/GzFMd/OUebNKgJq2uIc9a8yyO
         dfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXES5ZfaEfFl6HDW/Z90u0LP6PVhMabas/OzbNyEGjZ7qKSMtkcThe89f8EofpUEUOJ1SSAco8PDYvlzBy+f+a9E1Kk+qr9wFZABDfX
X-Gm-Message-State: AOJu0YyoypzcglBPROaFAAtu9ZYmdZLTHtRrGzV+JMQ5DT4wer+NhjcN
	ISXgfuZupUoj+yLP9xh5S2n7jbumgsxP97/IKTJOYbJ6g6BBXTTpkmUZM0EbUdfgudvf5/VUiHe
	tajbA3Q1QbfKF7K+26g==
X-Google-Smtp-Source: AGHT+IF9l0VKWnBaSreNF7S4sqi6G/8kgHmMrShHsp5wOZWAOcrtrpo0Vk2Q23Wkc3CzfLSQ6ShF4bsT3GENMm1y
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:2188:b0:dc7:6efe:1aab with
 SMTP id dl8-20020a056902218800b00dc76efe1aabmr4730294ybb.6.1708460597013;
 Tue, 20 Feb 2024 12:23:17 -0800 (PST)
Date: Tue, 20 Feb 2024 20:23:05 +0000
In-Reply-To: <20240220202310.2489614-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220202310.2489614-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220202310.2489614-2-vdonnefort@google.com>
Subject: [PATCH v18 1/6] ring-buffer: Zero ring-buffer sub-buffers
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
2.44.0.rc0.258.g7320e95886-goog


