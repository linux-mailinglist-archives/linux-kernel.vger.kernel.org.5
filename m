Return-Path: <linux-kernel+bounces-82597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF78686D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEAE28F25C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749016426;
	Tue, 27 Feb 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oBGGjV/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FF11CBA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000492; cv=none; b=tBj2kZahZOz5Z4ZXxc6u0slYub67eewuxk4BFb185wZBJhgy4jtqoX5wt9Q9K8HOXClr043zDX/SWRgOgnd19R3rtEQWdIqusUrBdZlLueXiUvpmcOtBzR5L7N3VsF9PJswmHiOXkrfHFo3Amg0VQp7SLv+iicJYHaPP/Nb7wSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000492; c=relaxed/simple;
	bh=+YacietmDdx37o43mg8/La+LvNYamHizPwJan7obEho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTq/yoN70A7xIDhBRdMvkdhB9vY2mEt5P2AcAQbiTjpC12s+4SXDEr1evDruD0bQrdrsRr8aizrNeVh3BFP22wTWZKuRAtfLNAk+DifY0CH2eldWZq7jGYK/Ai+DR5UX0dLJW/VcoPVoAET3PUaunnb8sZvyxJsQbEWpmF7NouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oBGGjV/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso5215521276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709000490; x=1709605290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3+1C6nI5i+vIvuA4wiJkN7/yRM+ojEerrFpT9yS6ak=;
        b=1oBGGjV///1Gt1JBBChw4afY53c006mIC++KhhjtFRjKdsKL+Jy68yiNHb8mySyXWz
         C6wcqsMsESIPWXT1X9Q5CwNFjvPzAXSH6/O4Eqlf3kqPwppRKM8IQWRxCKn+bvtX1Nhg
         FWvY/fo+qTardTjgsdHgg0xKN7WMXtwPqweaD6zJT0cz09QAQ2nC9QHT6fKKtOPmWtjI
         rXEjXq6A/uAtZxY5IbyTw+q/ZGfMXZeSKdM4xXN4dA7PC58k1+kdsKMQ1+hAL2nGWfad
         JzA13Gbh49fyD6BuszJm6UL4dI4e5Fi0nRu+dBa03QqRg8K/s/1OWFlUH8E63JmXS6WU
         1O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000490; x=1709605290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3+1C6nI5i+vIvuA4wiJkN7/yRM+ojEerrFpT9yS6ak=;
        b=E8yINkk4K6+8Qaw7nR3tt/hx9mL/MFN6ZZ4mUEDthbIk/VltuGGsYM3DzPuA0DazGb
         FF6J3M1bREZIj5DL/FDTdq1qYBzRz+uYv8FvL1bMKuipObpSX1C1j80+5j/yFXIcueLE
         e0nQ30I+tkd0p3PiLNtTum/4yoe4SW0T833pwcH6GWKKOe7jbN3uc5t1fnncXzL/8bzs
         eQOtl7oyQjRpY288vmMr2LMyePcuzynDYxz95jWZtYY+7f6KCFiSU6+D10LfIo/OoFeC
         KoRX2KBPPTs2EpZz6PzL4r4SxDA2vlIi8wjIQ3CgkjDswGhgMWgAj2mhZ9fjhbZKa6UC
         oetQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCS8RkKVT6B0pbMxaLj53b2R0E2dB2FdiS1pg/6fDjlzlM1jtZ0ibYrCg2rdUy7pm2auWJsL+oxQQwXXdCRaCe10XctpjS1ZyS9BDN
X-Gm-Message-State: AOJu0YxsNOq3JFlx5PxQ7e/J1tqsKMaqqFFAeIVKJA8XF+3Oe/nWgD5w
	2rv9wQLscJ4Ng+M8ujousXkjMz871PzSFlKtL6G3+dKQdyaIFwmbXhTmRygCqpQJYFR48M/17OD
	UhA==
X-Google-Smtp-Source: AGHT+IFpUCSFOLm9aL3Cxkphq0+0QUTbHVsfTTGSbdM6HRraKXrkbwRgLY4K/CdMaPM6Nhty2PQkXvHxUpo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:114a:b0:dbd:b165:441 with SMTP id
 p10-20020a056902114a00b00dbdb1650441mr282713ybu.0.1709000490276; Mon, 26 Feb
 2024 18:21:30 -0800 (PST)
Date: Mon, 26 Feb 2024 18:21:08 -0800
In-Reply-To: <20231206032054.55070-1-likexu@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206032054.55070-1-likexu@tencent.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170899198226.3637605.729140637406873438.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Like Xu <like.xu.linux@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 06 Dec 2023 11:20:54 +0800, Like Xu wrote:
> Explicitly checking the source of external interrupt is indeed NMI and not
> other types in the kvm_arch_pmi_in_guest(), which prevents perf-kvm false
> positive samples generated in perf/core NMI mode after vm-exit but before
> kvm_before_interrupt() from being incorrectly labelled as guest samples:
> 
> # test: perf-record + cpu-cycles:HP (which collects host-only precise samples)
> # Symbol                                   Overhead       sys       usr  guest sys  guest usr
> # .......................................  ........  ........  ........  .........  .........
> #
> # Before:
>   [g] entry_SYSCALL_64                       24.63%     0.00%     0.00%     24.63%      0.00%
>   [g] syscall_return_via_sysret              23.23%     0.00%     0.00%     23.23%      0.00%
>   [g] files_lookup_fd_raw                     6.35%     0.00%     0.00%      6.35%      0.00%
> # After:
>   [k] perf_adjust_freq_unthr_context         57.23%    57.23%     0.00%      0.00%      0.00%
>   [k] __vmx_vcpu_run                          4.09%     4.09%     0.00%      0.00%      0.00%
>   [k] vmx_update_host_rsp                     3.17%     3.17%     0.00%      0.00%      0.00%
> 
> [...]

Applied to kvm-x86 pmu, with the !!in_nmi() fixup squashed.  Thanks!

[1/1] KVM: x86/intr: Explicitly check NMI from guest to eliminate false positives
      https://github.com/kvm-x86/linux/commit/812d432373f6

--
https://github.com/kvm-x86/linux/tree/next

