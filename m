Return-Path: <linux-kernel+bounces-99263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971D8785B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9591C21E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE354BE9;
	Mon, 11 Mar 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vm86Zclz"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CB52F78
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175612; cv=none; b=IpsfxuPT7cTJdfZZL7BJGE98+Zp2Xz3VEH8ozSHgJmKcZt4LSJ1MTlWqVhVggSoUhDNlXBcZ3fmIE0ZYIC68yBHPlQM+rtZc0mjlxgPqMzwt6T4v37+JltYumEaH4hNi0uv0PlvCqbo5p0Gr/p9fQ0QwV/g0Z9xlXjd16TZwWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175612; c=relaxed/simple;
	bh=Bwrt2lusa+A0c0rwtSSKV9SaUdudi3XCtrQeJ9sAzzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flQ0+KkugVRzlbEEfk4ov+DsViFK2z2lxfPUoBF1HndTRK4O0yx3GSKnIiItjVHn8TjCLuBzZuwFXGKHmGoWJD6OSpgtndi13jNaFmAhOm84H552Cy7fsIowgvEzQLwAnEHYOCQeZJANiYzhzQskee1KnTorE8E78yQ6YQNcpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vm86Zclz; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c19b7d9de7so3130554b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175610; x=1710780410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85s92hjYUuufTOzCHiSH6hattUyZa1ZbNxNbo2SWk2c=;
        b=vm86ZclzNyd2Fbu+RtCevAm+UgYz83V+wJeCW+RrM6gBlK6BKeX7hPOtcMOFGCfjaM
         iIQ3NTyodNV3ybGzMm1w+TMnKYqoKDrtEAuH0M/yFIrS4+gIgqNXu74ixN3oj+sUIvVJ
         n5n9+IYLd/e+TGjO8XVj381FrxYWib3UxdR5cyAXvKCLqJPVgU6bLaajmGG5s6gfXDAn
         ovCccboyx8X3TlYHgICj/MXNwCQm1+BSAO+PmeraixYgFYRhO7qKSqcolxYjvzEibaze
         gekl9A67eeSLT7kD+nYT0NDz8DijLfsI7ta05zazaICZqic9K1iH6cvHd+E09aey2Kxm
         Pmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175610; x=1710780410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85s92hjYUuufTOzCHiSH6hattUyZa1ZbNxNbo2SWk2c=;
        b=Ttd+OXpBlpXw19OS13PK8ITjsvSffXiVfnbQP8iN8airWNkkBmBJOfu2LSJOTIJm5M
         o8/XzL3ntSYVrYFnDcLhAZd56E4JPhbzR/ztJIcHs4xXD0Kf4w5R5LeM7x7LS4d3vwCw
         ZXlf8zDy3Ip9qAKveYDXCL8pF34RU76nksA6TudnDIywPyXzdUv7acnXkgechB9mRajk
         PZRT4z+dHkJmdzplsJecWvasg8U+BZvN01XgWUb3TNCW7hFhH7395KHawRUlBQAxJdW7
         qAUoOkWoZCc27T9Jq6zwKvdr+bvdoP/4RLf2r3ft7jcO+TOucq80B9MnMlmkjzBXrsxR
         pvmQ==
X-Gm-Message-State: AOJu0YwjiE1388Zn53UwCF3gNVWzdsihgpYSfivtkrw0ioTBFaSw5gFI
	FhYe8TPBOL5/6Grcq+bEAPve8j8D8syT4zy34Cb9boUBe1xfAiZ+EqZBsaDCtsb7LS6JQ5j9Ir1
	kmCo=
X-Google-Smtp-Source: AGHT+IF0sA8TBoTxey5vp022o4Baok5dPg7vNZ4pcZt1EEyuyh5oG+THj2Y1Wu2BsuZNYuYtVQC9/Q==
X-Received: by 2002:a05:6808:15aa:b0:3c2:1262:e04a with SMTP id t42-20020a05680815aa00b003c21262e04amr8114898oiw.1.1710175608379;
        Mon, 11 Mar 2024 09:46:48 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:47 -0700 (PDT)
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
Subject: [RFC 05/14] fork: check charging success before zeroing stack
Date: Mon, 11 Mar 2024 16:46:29 +0000
Message-ID: <20240311164638.2015063-6-pasha.tatashin@soleen.com>
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

No need to do zero cahced stack if memcg charge fails, so move the
charging attempt before the memset operation.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/fork.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index a35f4008afa0..6a2f2c85e09f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -271,6 +271,11 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!vm_area)
 			continue;
 
+		if (memcg_charge_kernel_stack(vm_area)) {
+			vfree(vm_area->addr);
+			return -ENOMEM;
+		}
+
 		/* Reset stack metadata. */
 		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
@@ -279,11 +284,6 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(stack, 0, THREAD_SIZE);
 
-		if (memcg_charge_kernel_stack(vm_area)) {
-			vfree(vm_area->addr);
-			return -ENOMEM;
-		}
-
 		tsk->stack_vm_area = vm_area;
 		tsk->stack = stack;
 		return 0;
-- 
2.44.0.278.ge034bb2e1d-goog


