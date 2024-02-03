Return-Path: <linux-kernel+bounces-50762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1E847DA9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E6B25BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5410A13;
	Sat,  3 Feb 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0ZcI6mv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD7101D4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919207; cv=none; b=KLT4agUUhXshxNjmRnlhPe/2rgrAc4WbH734z1w2F2Z6agQr6ws5qrLLPULj86yLUxLFL1inlqm6BD6XBVzpn7VS1ttOHwkE1ETUDx1jG+EvT/t4Nv1B0XaGPfyRbsRUpKV0Kgj37abs416abL6FhINRs9KfTMgBi6GrjKXc4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919207; c=relaxed/simple;
	bh=0UHnjpZa0/n5Wch+Vjh3VbZabsU3SfAQTGXXdQqFuNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nnsna1uG+K8MPCQj0Npt0Wlq2sRFbdx5CStavswxDUkXg6DkBVT+dbuyb5ath4HSBzOs/awE48xV7KRXMRhxYd/DVRsMFwL6QJHixdaK2iA+VwExqX5aGdihV/dZ7Nk0WVme6nWYmWvJmBoXqu2KCge94on+Qijo/z444h8/T/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0ZcI6mv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d4212b6871so31233295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706919205; x=1707524005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UblZcdIbFFW166FC0SJ65RVKv7Yp//8SVMLiUJZhHNc=;
        b=m0ZcI6mvrHlUQFmb3ztP/G/TtsHgSQ+WvOutvtpTsvEQnsJOqv/X7A6XRvzHaD519w
         7CUUkPGKHh65Zb26rYu4oa3p8jnA2VQ3oGvpgplmGGI50yh+dh0Cze5oAqxPmK/pcDCp
         i86zGNWluErHezEEka48bl3WHghHxX57SdJpdU/nepyQbF4qzK7vBmOTHKo0F02u6si6
         J0WYWMjMJd0tKtWMey/IRPUGlwzEdF19XyRWajPdLmvAFGuy3gyEq/E7A/hJvJjsZWQL
         1bQD4yccVYP+91is715oWDVSKYSyxfQCwqODdXXkzrxR2HA6sppvZegc1B++1KTq71hr
         G9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919205; x=1707524005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UblZcdIbFFW166FC0SJ65RVKv7Yp//8SVMLiUJZhHNc=;
        b=I85e5aTlnHRiVL21z66WXP30JUKL8IQANGNCcyBWzS8JQxMyUtrb+QSmDPkZtCLgkH
         hK1KamIt/9eWV4A4Y6045k6lxeeLnW7kmcZZFDnaswW5OUrqwki2rPn6fX+XLKgpyu51
         V80gjFmMvyH1P5Mmw6DPqCsae4AnNg/rEe/pVQkrzxC2c3DdaD1tdMw/rsjE3PsXuH0z
         I4HooGhROC29uBkNLygZsdLGyTER/tRs74be7jdAhcLXg5LGOgRtWeGMDpz9f5H7yUrb
         qVj9l34+DEzVejvyZp2haZpyVobw4buZMJprGX/4Jh/s7BBerNNzuZbTF/Sm7rrf7gEu
         onuw==
X-Gm-Message-State: AOJu0YxgJvKPHyQ3o43/JmoacYRW1MTPpVvvWShCDgdcDuBCNS25uvzN
	mQlnLlhHPiczNo9lDWCT7y9neJcxgQ5yG3fKl0XKcyIAoxlyqsGoBbIVorX0+WRsOYCFhkkrk8P
	KCw==
X-Google-Smtp-Source: AGHT+IEpA02eLXo5kivTLKOG0egFzivasL8l5/x4YkqvERVRNd7PfchGE4aayftMm/hGrKG0zH0YT9yO09A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c1cb:b0:1d9:8bb4:6c2b with SMTP id
 c11-20020a170902c1cb00b001d98bb46c2bmr27573plc.12.1706919205410; Fri, 02 Feb
 2024 16:13:25 -0800 (PST)
Date: Fri,  2 Feb 2024 16:11:35 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <170691189173.332407.7692729833772898167.b4-ty@google.com>
Subject: Re: [PATCH 00/10] KVM: x86/pmu: Optimize triggering of emulated events
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konstantin Khorenko <khorenko@virtuozzo.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 09 Nov 2023 18:28:47 -0800, Sean Christopherson wrote:
> Optimize code used by, or which impacts, kvm_pmu_trigger_event() to try
> and make a dent in the overhead of emulating PMU events in software, which
> is quite noticeable due to it kicking in anytime the guest has a vPMU and
> KVM is skipping an instruction.
> 
> Note, Jim has a proposal/idea[*] (that I supported) to make
> kvm_pmu_trigger_event() even more performant.  I opted not to do that as
> it's a bit more invasive, and I started chewing on this not so much because
> I care _that_ much about performance, but because it irritates me that the
> PMU code makes things way harder than they need to be.
> 
> [...]

Applied to kvm-x86 pmu, thanks!

[01/10] KVM: x86/pmu: Zero out PMU metadata on AMD if PMU is disabled
        https://github.com/kvm-x86/linux/commit/f933b88e2015
[02/10] KVM: x86/pmu: Add common define to capture fixed counters offset
        https://github.com/kvm-x86/linux/commit/be6b067dae15
[03/10] KVM: x86/pmu: Move pmc_idx => pmc translation helper to common code
        https://github.com/kvm-x86/linux/commit/b31880ca2f41
[04/10] KVM: x86/pmu: Snapshot and clear reprogramming bitmap before reprogramming
        https://github.com/kvm-x86/linux/commit/004a0aa56ede
[05/10] KVM: x86/pmu: Add macros to iterate over all PMCs given a bitmap
        https://github.com/kvm-x86/linux/commit/e5a65d4f723a
[06/10] KVM: x86/pmu: Process only enabled PMCs when emulating events in software
        https://github.com/kvm-x86/linux/commit/d2b321ea9380
[07/10] KVM: x86/pmu: Snapshot event selectors that KVM emulates in software
        https://github.com/kvm-x86/linux/commit/f19063b1ca05
[08/10] KVM: x86/pmu: Expand the comment about what bits are check emulating events
        https://github.com/kvm-x86/linux/commit/afda2d7666f8
[09/10] KVM: x86/pmu: Check eventsel first when emulating (branch) insns retired
        https://github.com/kvm-x86/linux/commit/e35529fb4ac9
[10/10] KVM: x86/pmu: Avoid CPL lookup if PMC enabline for USER and KERNEL is the same
        https://github.com/kvm-x86/linux/commit/83bdfe04c968

--
https://github.com/kvm-x86/linux/tree/next

