Return-Path: <linux-kernel+bounces-100715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B0879C51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D023B1C219F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D3A142651;
	Tue, 12 Mar 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rS2iNbWW"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54C7CF20
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272364; cv=none; b=BJ7v3QGGXb8tDD/fGlBJaO/31qvlqM2jAXdwSm16HxdWld4Lx3PJQY2UPAnK0MrxDc6UpiYgGzWDfs/V6pw/FB5rI44Pik3ZKidzJqYUMioabNUE9RO9zNlKZMCDtUF78/bQ3qOB58kxK68lqVNpl0X1WZvayY+sX0Brp33JvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272364; c=relaxed/simple;
	bh=d/RZlh/p7Lw4UMD+yfh2uAYxD+niqCzu25XwxbYDRxM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XMqXDbUpKoD/d+g6vb0hvzRozXTbJs7sj6qRLnqZn5lYuLNQbbkb+LxyYhqzVYSB+AFZcMYxKSgbwuYxfL+xLGiF8Um2a+75KANSSBYLKIXF1n86b195ru6zde9UbZmGxpOPeresEV8EpaWSqtJAMnE3jvHzCewEh99RcFu2xqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rS2iNbWW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso3528872a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710272362; x=1710877162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE0BxFsqijsc/DHiegQ2xZUP1/bLz9mg3FtR8FbWE88=;
        b=rS2iNbWWUB5iIS5vmLfYbH7UKHMJ7yP/jrXeaQHk8czSm5yHMnnr4Q6nP9UYQBBGmR
         m5FCBEvIiDcgeA3IeGDEjlg1ENIAy9ZIbkqg463yxCS7aszafwLHgLMiOBOeqkSbNduP
         rZO4S64DjewH89+yDHrTzKVbIkqU0Z0AzK0+9PPt+Xey0Nypc90oa8sVV4j1ENFz7DUe
         z5DF+DD0QC5410v8IPHEIsTrOOEwvpXHypSq5GZKz025ZfD/sTmrHPLk7X9zQJzi2jVh
         zVzmwel+FSnqDi5OqmpTv7pjsHja/w1HilhDjVMTbPknBZT3TgPrUqFSVnh6geEeXcwu
         fy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710272362; x=1710877162;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE0BxFsqijsc/DHiegQ2xZUP1/bLz9mg3FtR8FbWE88=;
        b=PsyuVaP5kComkr1ryks5V8XEeBa3PUCczyPojKjnVUbA8BUK4vBCM9IvWk5HUMS5pf
         fD1v7b9NevtRnnJ8NqXFTyzi7LqstEsJRSB7fkyQVMpPw5nIZe2eQnuoSgxFXoXA0lVn
         92+fLEzg4A/Za6e1MIjTzuXHWNR8RYTQxiD3v99hfsM5aTAN8xN86g/p8RssXR/323EC
         WGda3N4kgkZHsaEPkVBS14ZAOgrFbIQlzGDf5RoduxDOewbq+D8rp1G+cX7SEa16jxAI
         HinShF02I+e1xN71OPMGzjqU/sVqDnb52UzfH1LSa3X3N/qHXClYxOFRz7T0G6jBfvSN
         ojbw==
X-Forwarded-Encrypted: i=1; AJvYcCXt1sKq35X/fPKwDhjVS6hCWFNGMLKEJ92MIV4wE3vnNi6WLP+iifcLDQ0NvV8l3jCrOIKtcvjUJzpyupzHM4J0u7PxT+DJEg9Hevk1
X-Gm-Message-State: AOJu0YzdeQVqVhGfErBsy8csyhhNAd0UpCUt60uhVVoVTBOTciGwIcSR
	39ncWOeXgud2hGS4LI2UoFgs7i7PqRPOwiT5fwoIJonKwo9eBX72Z7TEPMzzw7ASv1K8mNFtpCU
	vUw==
X-Google-Smtp-Source: AGHT+IEth0sXa+MFM8dDpSkPk3uejs2rY5crclViUXIf4or2VTiwZwVMTkFa4nNYO7yiMTConwvAiV2iT2g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6252:0:b0:5ca:43c7:a67 with SMTP id
 q18-20020a656252000000b005ca43c70a67mr24921pgv.9.1710272362441; Tue, 12 Mar
 2024 12:39:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Mar 2024 12:39:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312193911.1796717-1-seanjc@google.com>
Subject: [PATCH v2 0/2] sched/core: Fix spinlocks vs. PREEMPT_DYNAMIC=y
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Valentin Schneider <valentin.schneider@arm.com>, 
	Marco Elver <elver@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	David Matlack <dmatlack@google.com>, Friedrich Weber <f.weber@proxmox.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Fix a bug in dynamic preemption where the kernel will yield contended
spinlocks (and rwlocks) even if the selected preemption model is "none" or
"voluntary".  I say "bug" because this divergence from PREEMPT_DYNAMIC=n
behavior effectively broke existing KVM configurations, e.g. vCPUs would
get stuck and become unresponsive for multiple seconds if there was heavy
KSM or NUMA balancing activity in the host.

This isn't super urgent, as 6.8 has a fix in KVM for the over-aggressive
yielding (commit d02c357e5bfa ("KVM: x86/mmu: Retry fault before acquiring
mmu_lock if mapping is changing"), but I wouldn't be surprised if the
behavior is causing other performance issues/regressions that are less
severe and/or less visible.

v2:
 - Rebase onto Linus' tree to deal with the code movement to spinlock.h.
 - Opportunistically document the behavior.
 - Add the PREEMPT_AUTO folks to Cc to get their eyeballs/input.

v1: https://lore.kernel.org/all/20240110214723.695930-1-seanjc@google.com

Sean Christopherson (2):
  sched/core: Move preempt_model_*() helpers from sched.h to preempt.h
  sched/core: Drop spinlocks on contention iff kernel is preemptible

 .../admin-guide/kernel-parameters.txt         |  4 +-
 include/linux/preempt.h                       | 41 +++++++++++++++++++
 include/linux/sched.h                         | 41 -------------------
 include/linux/spinlock.h                      | 14 +++----
 4 files changed, 50 insertions(+), 50 deletions(-)


base-commit: b29f377119f68b942369a9366bdcb1fec82b2cda
-- 
2.44.0.278.ge034bb2e1d-goog


