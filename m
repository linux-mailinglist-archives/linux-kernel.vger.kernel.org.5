Return-Path: <linux-kernel+bounces-127230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FA89485F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25131C22D29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C116415;
	Tue,  2 Apr 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkdeewZ3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DEC14A9F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016914; cv=none; b=V3fRYiArXC7/LWMJ3q6BrumCPcnKDMxLHHAV0eg9xfvA5KYRuxf+eE0Tmi0+j0eHP29IxEJQza7czfzTKD11MzpbWSw3EIGhO7xUD4H0oY9+ddq/60Kk+lzaM8z1f1rKwKI/NwQk0kLbT+ATv9ky/JZ3GbKbjSYgit4IqRQPE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016914; c=relaxed/simple;
	bh=YOb6Of/mbUQtGB2+wiwG5V0/WzpW/exMJWy6vJJkw3E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=kDhS1f+02pIP2h8WAiuD0wosXoEXOk64ff+Yf6K3S1K4tiZEvNqiDj6jjmlv1Q7Toe6ElB51Nm1NRmr+oGn5R2kjx3N9UYgigVmbSCkTq3A0PdMPfF0Q0c3Ua0wf0TLztO32otLXG5lePkPU6w1kwEEC4GBfYzBfgfRMilPbhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkdeewZ3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6144244c60cso43900067b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712016912; x=1712621712; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ObPEVpHNGOD9pdNTP5+iZiD9N6DasBI0eYYI9ayJs3Y=;
        b=vkdeewZ3wp1ZQeFN6qBKN/MTyrzr6LVFTccOlqPNQNiNPr5nOb79fpYfQY8J7Nn/xn
         qUZ0qmuzGVH43koiDPLBUtNLMJmpr7CtrQLcmLZ+OOFLLOz6g7SXHyELBFJP8KAY6mxf
         ln0XASEvSMEu8B5BbdVZMnJ+pjRwMk1aBC0EGash+cxu06eFcE8kY4QTACxBt3ih9wYP
         WJxyvrKU7Q+kwQqzCG8Lx5nAnN7/WThtL4sn9OY3bKgP42Y+osrdxawlZ6fXPU+RQ1wm
         9Ywx2dl1zzDzLyFvV/N+UNrD2+wT782m5b2rpjy/P6Ts7+DiTdMxwmsYYSXe6K0XcEfq
         DuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712016912; x=1712621712;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObPEVpHNGOD9pdNTP5+iZiD9N6DasBI0eYYI9ayJs3Y=;
        b=P32ym0TdgoUVXFwSoRk4PkcbTkfU85dzR9VJZl2ULgNjzV2pejAvY2fVCSK7csavXW
         8P/bIBVgaiVhlO78oAivgz/+2V9OiwsjPzaY7HH4mVvMxUsH1d6Mp1pE+8Yb3gbFtKX2
         bJLWVG3wiXxwrJH65fk2j1KhdUiYCYDzWMN/DiTkgz4q4KLciCZQ0A0ZzSe1C2gJ8yS4
         xizN40Y6Ni4o3jt69l1pHNUwVy/vvx1EPl6OJMsFsTdzl+NO5Q4gUf6qxeaEG0M6j2do
         qiBB0gY5iPDpUhYDtDorUX02QWD0qrzWa0EkeeXZsHHm3qMmzjIruqtrR9s/rakt4aNM
         xt5g==
X-Forwarded-Encrypted: i=1; AJvYcCW49pN3532qEwN6ZNXm9bt2lrmrDZegXIO6ketn4u/SPf/95IlnSvPvfdx67V8QYDTiabkA5bW+XMbob+tcANkV1axTcBwAMeyDKQkR
X-Gm-Message-State: AOJu0YwoXy/IyIE01XPfG49w3BYLKCi98JLT/PDczaTRhQasWXHPLwMg
	bzv6cLUJozi/TMzFDQ4FsLb6zXco6nDN36BqA8tuyFz4LsSSpwaJb1gHDskme8/U4Q==
X-Google-Smtp-Source: AGHT+IHcf+ixx+OL89EP7m/1Ir1689eKnCKk7owZQ2kqfE8f5cmiNwb1vTS8CEnpi1GrK1srUOQBsLY=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:187d:146c:8be:181e])
 (user=pcc job=sendgmr) by 2002:a05:6902:1021:b0:dc7:82ba:ba6e with SMTP id
 x1-20020a056902102100b00dc782baba6emr775831ybt.7.1712016911935; Mon, 01 Apr
 2024 17:15:11 -0700 (PDT)
Date: Mon,  1 Apr 2024 17:14:58 -0700
Message-Id: <20240402001500.53533-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH] stackdepot: Rename pool_index to pool_index_plus_1
From: Peter Collingbourne <pcc@google.com>
To: Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>
Cc: Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"

Commit 3ee34eabac2a ("lib/stackdepot: fix first entry having a
0-handle") changed the meaning of the pool_index field to mean "the
pool index plus 1". This made the code accessing this field less
self-documenting, as well as causing debuggers such as drgn to not
be able to easily remain compatible with both old and new kernels,
because they typically do that by testing for presence of the new
field. Because stackdepot is a debugging tool, we should make sure
that it is debugger friendly. Therefore, give the field a different
name to improve readability as well as enabling debugger backwards
compatibility.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ib3e70c36c1d230dd0a118dc22649b33e768b9f88
---
Although this technically isn't a bug fix in the kernel,
I would appreciate if this could be picked up for 6.9
to avoid temporarily introducing a silent regression in drgn
(loud regressions are fine).

 include/linux/stackdepot.h | 7 +++----
 lib/stackdepot.c           | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 3c6caa5abc7c..e9ec32fb97d4 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -44,10 +44,9 @@ typedef u32 depot_stack_handle_t;
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		/* pool_index is offset by 1 */
-		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
-		u32 offset	: DEPOT_OFFSET_BITS;
-		u32 extra	: STACK_DEPOT_EXTRA_BITS;
+		u32 pool_index_plus_1	: DEPOT_POOL_INDEX_BITS;
+		u32 offset		: DEPOT_OFFSET_BITS;
+		u32 extra		: STACK_DEPOT_EXTRA_BITS;
 	};
 };
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index af6cc19a2003..68c97387aa54 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -330,7 +330,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 	stack = current_pool + pool_offset;
 
 	/* Pre-initialize handle once. */
-	stack->handle.pool_index = pool_index + 1;
+	stack->handle.pool_index_plus_1 = pool_index + 1;
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.extra = 0;
 	INIT_LIST_HEAD(&stack->hash_list);
@@ -441,7 +441,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
 	void *pool;
-	u32 pool_index = parts.pool_index - 1;
+	u32 pool_index = parts.pool_index_plus_1 - 1;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-- 
2.44.0.478.gd926399ef9-goog


