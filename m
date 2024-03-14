Return-Path: <linux-kernel+bounces-103899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44B87C65F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB86BB22EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63728DDB;
	Thu, 14 Mar 2024 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bw0QGiLH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD5225B2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458815; cv=none; b=At0cSyihsokb0Andh3a92htfy/HhSbwmHnTyqwch/HW0Y4pi8UtyXZtX20o30ImCG/uiNUXpd+DpUg8vx8MJe1p0Oe3eE3wTff8XcYdhAleRF7ZtAjCqxDX35Z+0AhCzl4WJ+cq8g2UigobjiN0j3sjuR9cSLMJfrpqbgSiNcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458815; c=relaxed/simple;
	bh=Y4lg842eyRtWuiU4N+Si7fkQtHRQlH6n5P6xF36CfXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oyNQQDQR+c9osZD8R7AyYGjMs+h+hst1ZvIFdFAml2jE5rae46uTgI99H07/39iWb2qJsjGF4t+lusXKvt10U2V1euyTgdmjA7ky0tDcTDWJNG2egU7D0sCPz0dlGw+8fiz3+ZmTgq/N7AE0ReLJt91D+f4NPXZxWyhAXxASITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bw0QGiLH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso29035547b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458813; x=1711063613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bGD1oHLzIwlI71Um3uWf9rz8YDkt0fT9aZFmZxidv5s=;
        b=bw0QGiLHlSL5PVie+rUleZ0Ihg8BETFGnSQKz+gbO6X++AHhbvg910zucl2B8xxvqz
         OtFqTWPL0lF9plJhrLzF0COizAt/NINLn9PG/vKpunqeSzqTP6PFVGv1Aps8DQ0flllE
         qVQArbIpVUBbUJCAAlrayUQgWVKRBnvj/3MUHZfJoW10pM9wW6LJSb3pFvtqS8vlY41g
         /U8bEpmnSrycpzn2J80IyI6o7VAnlpgDV05t7dToGDbAw37RGZkSU3LmxcRIqNtWDmer
         iRSPHeoHzc6LTK6b1b+DhG+Z7S/n+AHmfHf/oySnbdEnjW5IT5Moa3pZgMB2KFdHBSLK
         EPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458813; x=1711063613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGD1oHLzIwlI71Um3uWf9rz8YDkt0fT9aZFmZxidv5s=;
        b=I1HvgCrpqMkUpSu6samw99DmDufJMCGM9QmOB1H/HLDDhQDWhAsM58Yh5oNgUuU4u3
         j8/GfzC06HPSHcM8PyNLtnncUj3Ye6Dr/077ZY4tFT+OyzfCDOOD5Iom6IyHPyH9CDA2
         H8WIJQB+vKODFmbsjPj9rAFWAVNHlNPbjE7pA4xFsNdU+cwUG8mcZlDa397gq1pnSZgS
         8cDuvZZjP7YWO6efsmAPReFw5c3Aj3rbCvLL52ppc2q688ULA9KLIkP+6C5NzdgXdd5i
         bDBxO7kwA00ZMCQFlPOPjasXnIkb0aW84/5z7p5Asswo0xcQ+oZYxYQOXnS8hBd7al1P
         IaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqqtHWFnpnENv96dhD1wMsSGUVmnPcA2sIlSY0t4AGwn9qKZtQEd2MzA78IHCnk1CpwnpZuZsymhiMyd3OijbPe6XEso0YKcqce3Zw
X-Gm-Message-State: AOJu0YwugtydhhZLjRzQiUkapYKebTg/CVvpqSYbbraixQT7aMI2A9Sg
	O3Zl3APR/jOkVajOrYglPadANc2UpzmFMVPLy7uUO7+GG1a6b5lee9I4zYSfPyYWjob/h6IQUaE
	Bvw==
X-Google-Smtp-Source: AGHT+IEf2SHyoW7Ci/nXvsu/vvl6dD716Be1qw4xm14NPqmYsKQJNpbDJU6sbwjkwsuGTYDcc+4TPOzUy5A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b85:b0:dbe:30cd:8fcb with SMTP id
 ei5-20020a0569021b8500b00dbe30cd8fcbmr188618ybb.0.1710458812732; Thu, 14 Mar
 2024 16:26:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:26 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-8-seanjc@google.com>
Subject: [PATCH 07/18] KVM: selftests: Explicitly clobber the IDT in the
 "delete memslot" testcase
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly clobber the guest IDT in the "delete memslot" test, which
expects the deleted memslot to result in either a KVM emulation error, or
a triple fault shutdown.  A future change to the core selftests library
will configuring the guest IDT and exception handlers by default, i.e.
will install a guest #PF handler and put the guest into an infinite #NPF
loop (the guest hits a !PRESENT SPTE when trying to vector a #PF, and KVM
reinjects the #PF without fixing the #NPF, because there is no memslot).

Note, it's not clear whether or not KVM's behavior is reasonable in this
case, e.g. arguably KVM should try (and fail) to emulate in response to
the #NPF.  But barring a goofy/broken userspace, this scenario will likely
never happen in practice.  Punt the KVM investigation to the future.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 06b43ed23580..9b814ea16eb4 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -221,8 +221,20 @@ static void test_move_memory_region(void)
 
 static void guest_code_delete_memory_region(void)
 {
+	struct desc_ptr idt;
 	uint64_t val;
 
+	/*
+	 * Clobber the IDT so that a #PF due to the memory region being deleted
+	 * escalates to triple-fault shutdown.  Because the memory region is
+	 * deleted, there will be no valid mappings.  As a result, KVM will
+	 * repeatedly intercepts the state-2 page fault that occurs when trying
+	 * to vector the guest's #PF.  I.e. trying to actually handle the #PF
+	 * in the guest will never succeed, and so isn't an option.
+	 */
+	memset(&idt, 0, sizeof(idt));
+	__asm__ __volatile__("lidt %0" :: "m"(idt));
+
 	GUEST_SYNC(0);
 
 	/* Spin until the memory region is deleted. */
-- 
2.44.0.291.gc1ea87d7ee-goog


