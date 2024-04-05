Return-Path: <linux-kernel+bounces-133712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92589A7A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F21F22CB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D464DA0B;
	Fri,  5 Apr 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBirsjR1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBA45BE2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361375; cv=none; b=oGSDwZlNzgnUmJiZ4I5tnnSRvTjn7CCwOSzEMlrBmZ5lLC+ViZk4iKbh17lkTwgoUg1Mx/wSYrBPsMZhRKBSCF22J5iH253X6jZg8dNRv18dMgAK0kQxryHma5d3yeBaCDlRQAGiqbQ89wq2g2EHojvZTY1gZCs5GoQzxySreS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361375; c=relaxed/simple;
	bh=chnMm1zFatZ8q6GaXGi1GZwfE6vOSQp47VdBoBbf3AE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QdwxYeECyf6wdfdBTSp5Y9Mn0wt/i9/0w89741fk5WU4E66aZr4eN+4N+JP/25K46dK5V7H4iz8F0EStr6daKYvKDoz8JUWtn3a5m+GLvyfgDJhbiQE9mC8rG3qL5OXyvRUfcWFnh0lZ2RUSY621aqnxxth6XbUAfiWV+b1E8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBirsjR1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a48ed89c7eso580863a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361373; x=1712966173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FffwbB6LnatDKMg9SsqQhArJTyGAeiJWu5lvAsN6Mjk=;
        b=wBirsjR1NQA8cfl+0rDDEQQTvtCOhHgWFQOvuigI9slaJg3pojGmoWmYEFG+toUt2U
         ktmEjlG2SZVoKsvaFfv7kzjIyoiDLpzWDkEpJjYSCLrO1p1izH+LTZVzbPa+xreddn1r
         V6A8boPyQdpB4AsPHmaQFRDhBhM6iz/7wXLM8GxGV4fR3LtEhoubtGk7uvOlgim7PG+W
         ZgksZRd/M41UcpP56SCXRXXuMvcw2RSKuFWXO68p1CQk3l9K8WxOOfU4RSai4W/Rj0vx
         0+zibG0725gigIv/EtMiaYqKCHsrqiVCYhnv6nGO/C4ZETH6nZBBTo/rbWolKCirLVmI
         DSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361373; x=1712966173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FffwbB6LnatDKMg9SsqQhArJTyGAeiJWu5lvAsN6Mjk=;
        b=T1Rsz8vYTDu/1BOi2Crub2+9igXfMJYVRMVku/W2g+4MUps3OH7HrdyLvVazkCnydJ
         mLZvb4zYDmTSDmcywcCg10uu8RKDeZuCNLj5euh6msJGv7ZQ4z8FdXfFyBQlmnIhga8c
         MkcphFS4yCNMYhDVpogTpmQWtgREGHRvvoEVr5vbuRsu+TV9PCKDSNr8asaGel5dkmjs
         BsmJaDsQECSSwv1uqtuLSsUNPvYIz8LfJtx3C02TFCHHnsEIS13Ruv4n1anvffhmrvXl
         VoOv1t20caIWRfYVz4DWEDDdxzuGbNlVe0mFuXAsKkGDT7H8Tettb1w4J7HENvttry9x
         soyw==
X-Forwarded-Encrypted: i=1; AJvYcCVan9NcVAIK06pDft/Dn9lIy9pwcFsqs1qBeqZUW5N4zXRNRnS+blgbQQD3baSGbVy8vLIEiLMs929y/n1IrwifzTB4D0VOcn/980vv
X-Gm-Message-State: AOJu0Yxav5lHypJYUmmCLFNQ87FPZnqoyEFO1/xAYLBZPuUa0RqYWH4J
	QyYn/iqRVB9OEhaBkC/BzIEf3hobjVay5dwSc6yX1b9GldIrX+hq4eOORMCOjSEMkhobTc13kOw
	F8w==
X-Google-Smtp-Source: AGHT+IH9aecytVAOtnV2yNzg2I3ctJJZWmYrY4cvrhScbFQqL+6+y5ypppJF5bqHYcJe2XUZwFiInnFZSBA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c1:b0:1e3:d0fa:dedf with SMTP id
 o1-20020a170902d4c100b001e3d0fadedfmr49827plg.4.1712361373581; Fri, 05 Apr
 2024 16:56:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:55:56 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-4-seanjc@google.com>
Subject: [PATCH 03/10] KVM: x86/pmu: Squash period for checkpointed events
 based on host HLE/RTM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Zero out the sampling period for checkpointed events if the host supports
HLE or RTM, i.e. supports transactions and thus checkpointed events, not
based on whether the vCPU vendor model is Intel.  Perf's refusal to allow
a sample period for checkpointed events is based purely on whether or not
the CPU supports HLE/RTM transactions, i.e. perf has no knowledge of the
vCPU vendor model.

Note, it is _extremely_ unlikely that the existing code is a problem in
real world usage, as there are far, far bigger hurdles that would need to
be cleared to support cross-vendor vPMUs.  The motivation is mainly to
eliminate the use of guest_cpuid_is_intel(), in order to get to a state
where KVM pivots on AMD vs. Intel compatibility, i.e. doesn't check for
exactly vendor==Intel except in rare circumstances (i.e. for CPU quirks).

Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c397b28e3d1b..8c3564917953 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -194,7 +194,7 @@ static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
 	attr.sample_period = get_sample_period(pmc, pmc->counter);
 
 	if ((attr.config & HSW_IN_TX_CHECKPOINTED) &&
-	    guest_cpuid_is_intel(pmc->vcpu)) {
+	    (boot_cpu_has(X86_FEATURE_RTM) || boot_cpu_has(X86_FEATURE_HLE))) {
 		/*
 		 * HSW_IN_TX_CHECKPOINTED is not supported with nonzero
 		 * period. Just clear the sample period so at least
-- 
2.44.0.478.gd926399ef9-goog


