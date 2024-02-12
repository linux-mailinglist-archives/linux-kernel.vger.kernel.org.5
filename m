Return-Path: <linux-kernel+bounces-61278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BE85103D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F41F21246
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCE1803D;
	Mon, 12 Feb 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="th2F7Xso"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9918021
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732173; cv=none; b=OkfgH1Yk8j3Cb2ZrJ21GON01jKNAoZyVMXfbEA1vIQlrbVUaPIMT9J2HBqn8G/xO9oOFky+EsZU4Cqv3nvgedttI5Rb8jzbTAIOYbOOIaaXC0UYv52BdgtPrxXz7WQITDAOxxDV+/iCAGlw9biVt9Rxvg4LXRep0b1JLjf8JqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732173; c=relaxed/simple;
	bh=EvNl2NgC20KtoxOIZI2VbWr9lTUl32SJ2A3KDaxxmJU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZxePSK4jOokAf5CrenVnr489OjhqacjOISaqjT+VH7pqsm0Q6O2DBkv1pUy7gqItvzHdEZsQ4VoQ7YS61mqcDpQrWe1DP+DFKmA5MnLtl8KeqPlNQAzYbGEcLHz1kZkJ5MU3fPT+6lqWhuRKt7aQxhMTo+oT+Dn3k+QZXkq1nWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=th2F7Xso; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so40945a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707732170; x=1708336970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EvNl2NgC20KtoxOIZI2VbWr9lTUl32SJ2A3KDaxxmJU=;
        b=th2F7XsorPbvY1ayTqmRHkU6YYCMSTy52i242xqZkLtIIE5U+5SFo0b1UIUhUtSsWd
         o8Zh/2M75h/D6O2VFce2IjGRh00AeYnZaQiMjfPzEimOG8yEHDLyZCvNqPPzj3Gp+4SZ
         GrFe+J5LNF95U+NgiJzaaSo5eFy7PomoYpxXlg1HUP7DJdxQyDUu4qdnnXeURxqt1l0q
         9rmtcGqLXa4fmWP+f3lvyBmSgzvv1QM4+hckpyC/H20NNgZV0TyjEP2zVW5VWgWEN+hW
         +1ghwzJ0tAJcnpGT12GIht0X1cMgvFvvIiAZPd76N9PKjHgOPbAxYA6k1M5xm0ZyLdbp
         rzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732170; x=1708336970;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvNl2NgC20KtoxOIZI2VbWr9lTUl32SJ2A3KDaxxmJU=;
        b=ePFR+iWVWj5JMsDIrOCGXVxSD+xRHRTk2ZBK55DN6JpSm2FcHk0/LRZ5uNaskrc6ZH
         72960m6yAncPPwRTCfcBE6IjQn6Y96I/mXiqyGs3//9JQseVb+VnZu5T4fGn7G3ABioX
         g73HQpuhjaLPuVdYJweNkcHlzs0D0WhzAKCaDFJ0EIGEmCMzPp/JRQZ3CTjUYGAuD1jy
         MUhMRIym97lPTEN7xJqze3dUHjA1p1Jo4uEfm6FkpjckKIhWfYrkVO4W8b4pobwZ9FHj
         kOAs+ERd8UWGrucdCeZoWAPmOZMcIgAe2HurkZA9sT/sG7z4PXCYeJO/X3ch3/EW/9br
         PetA==
X-Gm-Message-State: AOJu0YwBOGGPrCSUEerSaxHvedM+7AGxJ7PEKm1WHEHFsulQTaJbBpxW
	dbdlCJenM2vSAJ/jJ3WoxlomowjVeJ1n17BbTV3jFDbWys0ZOdTdDUis2SM8uwZkuopykoGNl5G
	oZs5CroSQFcvmHL3Fgw/8tQMAQm8hG6Ccuz3rAp2/VGa2GvT/mxHN
X-Google-Smtp-Source: AGHT+IGy2rbxkxBgdwRzO0ruHrDxfHwUgXlzx/bQorwXeDoHWcwkIg0iuOSXpyMdfnNv6DIQoMJgNNTg2C6ijXZSSDs=
X-Received: by 2002:a50:8a9e:0:b0:560:f37e:2d5d with SMTP id
 j30-20020a508a9e000000b00560f37e2d5dmr170566edj.5.1707732169786; Mon, 12 Feb
 2024 02:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2024 11:02:38 +0100
Message-ID: <CACT4Y+bXfekygoyhO7pCctjnL15=E=Zs31BUGXU0dk8d4rc1Cw@mail.gmail.com>
Subject: Spurious SIGSEGV with rseq/membarrier
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Oskolkov <posk@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi rseq/membarrier maintainers,

I've spent a bit debugging some spurious SIGSEGVs and it turned out to
be an interesting interaction between page faults, rseq and
membarrier. The manifestation is that membarrier(EXPEDITED_RSEQ) is
effectively not working for a thread (doesn't restart its rseq
critical section).

The real code is inside of tcmalloc and relates to the "slabs resing" procedure:

https://github.com/google/tcmalloc/blob/39775a2d57969eda9497f3673421766bc1e886a0/tcmalloc/internal/percpu_tcmalloc.cc#L176

The essence is:
Threads use a data structure inside of rseq critical section.
The resize procedure replaces the old data structure with a new one,
uses a membarrier to ensure that threads don't use the old one any
more and unmaps/mprotects pages that back the old data structure. At
this point no threads use the old data structure anymore and no
threads should get SIGSEGV.

However, what happens is as follows:
A thread gets a minor page fault on the old data structure inside of
rseq critical section.
The page fault handler re-enables preemption and allows other threads
to be scheduled (I am tno sure this is actually important, but that's
what I observed in all traces, and it makes the failure scenario much
more likely).
Now, the resize procedure is executed, replaces all pointers to the
old data structure to the new one, executes the membarrier and unmaps
the old data structure.
Now the page fault handler resumes, verifies VMA protection and finds
out that the VMA is indeed inaccessible and the page fault is not a
minor one, but rather should result in SIGSEGV and sends SIGSEGV.
Note: at this point the thread has rseq restart pending (from both
preemption and membarrier), and the restart indeed happens as part of
SIGSEGV delivery, but it's already too late.

I think the page fault handling should give the rseq restart
preference in this case, and realize the thread shouldn't be executing
the faulting instruction in the first place. In such case the thread
would be restarted, and access the new data structure after the
restart.

Unmapping/mprotecting the old data in this case is useful for 2 reasons:
1. It allows to release memory (not possible to do reliably now).
2. It allows to ensure there are no logical bugs in the user-space
code and thread don't access the old data when they shouldn't. I was
actually tracking a potential bug in user-space code, but after
mprotecting old data, started seeing more of more confusing crashes
(this spurious SIGSEGV).

