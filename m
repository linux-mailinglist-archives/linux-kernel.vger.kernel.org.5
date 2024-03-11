Return-Path: <linux-kernel+bounces-99262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69C8785B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C671F22222
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3154736;
	Mon, 11 Mar 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="xWQwSztA"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0DF51C52
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175611; cv=none; b=kKKtW1beQdzGOl++HXr7odiAQTHykt04jEppq54B4+eEv0jpn2HtddHxEBhgMJloiJzfUh0Rwx0KvNnEXhwWGFfZQ+5okjCDDVZlV4XCNJi4iZ/H4rLCp0oRkBFttBYWBOXYI+vtksK8fhmq5RCrkph5E3/P7OAhXQnRd0kYuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175611; c=relaxed/simple;
	bh=YWX2hBlKKgeraszO5aQgtTxYaDusNvEWibyBtdLpKUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHBhVlMEsw5jOkVnJejAqb7SvWNDdkxPJ8by6qBObi7r+Cvq0FckFF9BB317ZYR0B+o2lVGeQ17Pflb7lmMyuf6aotXcn+JB3OQmqRr1vWynbmXEkhPscomAVs2rkd721ap8UXJCwiTgeRcRiLb/rzozNC0hCgtiGYuGqMij+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=xWQwSztA; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21eea6aab5eso2878629fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175609; x=1710780409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeoI5maDr3l2Ozw1ib0LWqoOcMWVTMRirMYG/aEeKfI=;
        b=xWQwSztAqzOTGlXTBdhkxdWcW1v1o5EuHnBdcTwB6z2pFCyutKVaca0gOxHjj74u2c
         a2Ksr6DsX90ki0Q+G85gofBtxAnRpJA8o4NOgzDJhZDcdcks5E1Zfnzz0M7xjWZB6T41
         RyESUrjst9s2MuCWs35naXuLy7vhYt4VVerF0hr5wytJzFMPjhN8tFs3JYXy8tnigS9m
         mz0iHZDcLaha4BctL4lgKI69jpfQSeREdrdKQdJR3zu3f/z0o6Unw9sle5tR8ds6GZyZ
         fvwwWph6s9QAmcZHXPdNq8zZopHrkbrzx0Iip9A/iaFgPgoYJDNlbMWRomxHtZDxQfqG
         mELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175609; x=1710780409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeoI5maDr3l2Ozw1ib0LWqoOcMWVTMRirMYG/aEeKfI=;
        b=g4oxT2V+lTBMxKLb7Jig+6nw+B1020DM5QsBJX3Ns3DjpM6XBk7C8WBwuHhPwrMNED
         KvB9qyO5+/gPLEoITAinKSrZVDEYVmaWwiItTLa4eAVB1Wra9aAknFgX9ajOjkIfs+OQ
         MXYToaWYqyZhTo5C3PRcKtocziJNE+3brIUGxyyZw4LH/5ekCYlPJKnP9JVURlwS9wAB
         ukiOsfSknqrWypb17uXc7tds1pZVTftIikh58BVxeVFhiH2HOE08EP5F4YtsIsF4EP7D
         THvQxC+T54PFfpHwQakt1aKp1iYyKWHmEC4NgMWdYdbmw0rAQKDyUuSteje46w0F+Qax
         xQzQ==
X-Gm-Message-State: AOJu0YxdcVa0mnQbPYbqbtjf2/ZFpWr++Dq05P4siiV0mc5sSh60D6ZL
	JSv8/yV3LGUceqrXxCjwsMfGE3n9zFcW9PsGu3nepzWpMk8CY9rs80ywP/5Viv+/PZyDHxY5VNA
	P+tk=
X-Google-Smtp-Source: AGHT+IF7PMDKY7qPBLzKisHlCeRFB7P9dZ8FJtUn1b4P6yLcZu1GLHtuFZbDu9s9LwmUDKjKkIy2MQ==
X-Received: by 2002:a05:6870:3307:b0:221:a43d:60ef with SMTP id x7-20020a056870330700b00221a43d60efmr8059130oae.3.1710175609309;
        Mon, 11 Mar 2024 09:46:49 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:49 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 06/14] fork: zero vmap stack using clear_page() instead of memset()
Date: Mon, 11 Mar 2024 16:46:30 +0000
Message-ID: <20240311164638.2015063-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preporation for dynamic kernel stacks do not zero the whole span of
the stack, but instead only the pages that are part of the vm_area.

This is because with dynamic stacks we might have only partially
populated stacks.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/fork.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 6a2f2c85e09f..41e0baee79d2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -263,8 +263,8 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct vm_struct *vm_area;
+	int i, j, nr_pages;
 	void *stack;
-	int i;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
 		vm_area = this_cpu_xchg(cached_stacks[i], NULL);
@@ -282,7 +282,9 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		stack = kasan_reset_tag(vm_area->addr);
 
 		/* Clear stale pointers from reused stack. */
-		memset(stack, 0, THREAD_SIZE);
+		nr_pages = vm_area->nr_pages;
+		for (j = 0; j < nr_pages; j++)
+			clear_page(page_address(vm_area->pages[j]));
 
 		tsk->stack_vm_area = vm_area;
 		tsk->stack = stack;
-- 
2.44.0.278.ge034bb2e1d-goog


