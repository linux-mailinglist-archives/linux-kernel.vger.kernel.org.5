Return-Path: <linux-kernel+bounces-143322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A98A3736
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4841F22FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D43F8E2;
	Fri, 12 Apr 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="yQMQuYjb"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577E39FFB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954687; cv=none; b=WJuzXS9cHVhWpsYHHWqNWVLGNq1fD8cQOTmRDSHX/AtgHZPYQMBN3p4A8caJfKkaORmHS0kFSbcBHg821cqFPsNxaPsQ9stTtdXVgrVPEI309jv1eqbUvycEmC0KqNpli4HiyNXzplsZZ5SCF1HcjlHW27LrwresYDPBNnzF1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954687; c=relaxed/simple;
	bh=4vp5qyEZGAMwuOagLnJKbRJSa5AiEMRLbDSwvkWArmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2kVj+qJjkeYEFO8A6a3hVERmor1Vq3AOJFBMNFKqfSvzmRMp5JLApcebHR+4N2qu2JHIv4BjTr4B7yiF/KdvxcsOe/hXJubWFkzpZizcex+jaVEqDdw0p3ifSOyX/GCbzkQRPaMNBNeG+Yv0aW2IQV3EwsWbQGbUxeJbRY9z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQMQuYjb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so1150361b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712954686; x=1713559486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z+VKNpPRufGEfzC58h5hLq5eFFz0DWRzzztXBo7m7o=;
        b=yQMQuYjbhFOlCQ8Gzdl9Xv5QCd08u8VB0kdTakIKfGcmTWPifX2DN5q+K6tDaZxH5n
         m0uANjkHLbhn93+7D+MspsP2TiTCGrWh2pgaVNYTymjZJ7oJlrywjfqzqFltxdVqmtfh
         spHaY02+TzoAG1rLUD/1xA9suQ5zVPpGahp9VJZJtU/l5QUI1o5+9kCdwblBN83wvfV9
         +jxcKb5OHNiycfISJkgopR8+IlK+6wBMXciW4G3ZDW9yIKMYq6pF8aijFTZdYtmHndsm
         gzF/VTejqERQC//+ZuY+46rEx90KZm0iyYcmg+cdGUZtdRwJ3JFFVuO1SrmWoAoH00Od
         00Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954686; x=1713559486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z+VKNpPRufGEfzC58h5hLq5eFFz0DWRzzztXBo7m7o=;
        b=TlIfVC5h5DTd/0aZNmLjU5kDb+bIi07JtzsJuDPCe+6IN1TEvKAFOvzEA9SB9L4nB7
         nCLfHNMvAnSm59keZ6wcxnC7qloJunCbe5nfNBkF+Cg+Z8tsem3O9fT0oz82c37uhMSE
         tNKZdyWBuUJMVF9j/Ms0jcsi+M5RcwLUNWvJylpPndTm0s2zN4+MuHCakf5nVM4IJE1u
         b6Y2toA9lKPMltQ8Ldh24XJHMDJ8s2EPuxPdPe6PmjVdFuoSP20kusw1t94EKQsFsFws
         tuGfGB//tPhelVoPXln145n9mTttrsYCcoCz5laS7xVLhjaZ46t1a1o69dn1SQ4K4jC2
         gVfw==
X-Forwarded-Encrypted: i=1; AJvYcCVzIRE/c1XJqYP4VOzKzPy7kmpEhvCO6SNaNFnoVd8/yMySbc43pd9XZs9ZYW7C0S+wm6oZQLSZuLxwciSjT8C4wsLE8SvFoJ5KtQgY
X-Gm-Message-State: AOJu0YxNDvR5hFiVPtuewWvwDTNi2aIBmwulf8+newuVz8aPuL8YJmHm
	RHRuWXLMdOqsmqEjYKkHROald7UNQzoWSe4BCJqM0WI2YwP7fr7fxgCacMew6g==
X-Google-Smtp-Source: AGHT+IFZFKdCRdPaL3Vb0XTMjnUQNtJVoruOo48GxoyfTAhTrJOnmmO+jVgRuAaY5z2jRsVdxr03aw==
X-Received: by 2002:a05:6a20:8428:b0:1a9:6c42:77f5 with SMTP id c40-20020a056a20842800b001a96c4277f5mr4669546pzd.59.1712954685790;
        Fri, 12 Apr 2024 13:44:45 -0700 (PDT)
Received: from google.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id lr31-20020a056a00739f00b006ecfe1c9630sm3368108pfb.92.2024.04.12.13.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:44:45 -0700 (PDT)
Date: Fri, 12 Apr 2024 13:44:41 -0700
From: David Matlack <dmatlack@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhao <yuzhao@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaoqin Huang <shahuang@redhat.com>, Gavin Shan <gshan@redhat.com>,
	Ricardo Koller <ricarkol@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Rientjes <rientjes@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] KVM: x86: Participate in bitmap-based PTE aging
Message-ID: <ZhmdOb7lAd3DM5Tq@google.com>
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-6-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401232946.1837665-6-jthoughton@google.com>

On 2024-04-01 11:29 PM, James Houghton wrote:
> Only handle the TDP MMU case for now. In other cases, if a bitmap was
> not provided, fallback to the slowpath that takes mmu_lock, or, if a
> bitmap was provided, inform the caller that the bitmap is unreliable.

I think this patch will trigger a lockdep assert in

  kvm_tdp_mmu_age_gfn_range
    kvm_tdp_mmu_handle_gfn
      for_each_tdp_mmu_root
        __for_each_tdp_mmu_root
          kvm_lockdep_assert_mmu_lock_held

.. because it walks tdp_mmu_roots without holding mmu_lock.

Yu's patch[1] added a lockless walk to the TDP MMU. We'd need something
similar here and also update the comment above tdp_mmu_roots describing
how tdp_mmu_roots can be read locklessly.

[1] https://lore.kernel.org/kvmarm/ZItX64Bbx5vdjo9M@google.com/

