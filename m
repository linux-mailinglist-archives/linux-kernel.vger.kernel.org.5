Return-Path: <linux-kernel+bounces-106776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EB87F35D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045CE1C21796
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5965A7A9;
	Mon, 18 Mar 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVmSTA/Y"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FBA5A78C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802245; cv=none; b=Lv/CLOXNJjjAH+cemltXGs2ThlrsWH0tMWZDnpP6oqLZMNkpTCJnKdw3C8AMM9HnGHmANULqiA7sFUuc9E5U/fAHXIy0VgNmsEahONfv3BUHX2C0QGsLyKlFxIkFzzebl+MyPyP+6SshYhTtUfRAdTQVM3dXlQFC2agyIefgAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802245; c=relaxed/simple;
	bh=+ZOk4bVSRifoj+sbTssU81wJKNOhcrPwJpjGcFBL5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMKfPgF96E8xPX0gzCpNhiHPqmgHq1k3V/aUheT1g1y8ENg8a+XJOioxbtnLEaMLGVkPVYBpnajOENk90ueq/Nq+VaEnNserx4LJhjOY/3PorV9WwktvITgsJLWN7jt8+OBXb7oRcCKiEsT/2JIdocmSulnSxqg4H0KORhiMy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVmSTA/Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dde26f7e1dso34706565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710802243; x=1711407043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqfEoWmEnfydY1iESygtrZED0/3Qp9DI+FcFENiGi3Y=;
        b=MVmSTA/YsiIzGJDPuilpBmJBBOHOoT5+Q+rzP5n8JlWiD18lGI9d97h1JGgEaQa4KX
         He/Uzb0UKTyq9kaHkypqLLOI+R64KQjPR1+tVzjyCibve7RhgSMI7Hk4uJW7Ib9KfT0V
         W11HtxAdK1jhEnrJCItX8IuTSbdj2vMi227UoqmV5VQBpd3/fFC5evHDLk2yswB2Oa1F
         e5YjFPe9A8y/OHnlPYAUCEMNqsQCGkyg27la4182sSLvI+T34Uo3Sb8MihHEnji4DeL3
         Dzt1iDVjsl13HqooQwoKzwgtHQyZQjBn15XWpCzYrCTG6lndcSmctur8kFP/2Ry6jC4T
         22aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802243; x=1711407043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqfEoWmEnfydY1iESygtrZED0/3Qp9DI+FcFENiGi3Y=;
        b=X5wT+zqcPZzz7gWe+MFEaBksKfxArhgckwTjbYc+o3chF5dO7fIRDAMIztC8fRtNFI
         hA8Co8q0hjHcPvMQ5H/FzQGoGgElr0Q72lAK7jZBWxu6tq+z5Dncir9RfdlYF7qeSPjH
         UNHI+B3WXRKCh+PU2TsRM0iZKiYtXru2qW95CixMHwHKWZFdxRZJr2eUgY6cReu6BiSZ
         XNe8uJRGeCOyShnB1TOnrkFQLNONN6nAEKaGN3YxXqQMRwS8HZ7Gtf+zUwlNWU6tQ4xU
         mPCXA752T4kXCaiV1b1q4/qM97Ug8v7e2ce7/gMBv8r6lwGJo3LImcT27ty3nPeRf+aX
         64ww==
X-Forwarded-Encrypted: i=1; AJvYcCUmw8Kudrlg1VLQrPlwM/gUL5xKtidvpI1Hh5nqi8wok92eec4sDs5RkgiinKfLXmTfkUOQdVMZdvlET54Dk4i3wSSaUj4hsbBtF3E4
X-Gm-Message-State: AOJu0YzsYw+v3Ce1klKsVxfDf/Vaqzmvt1HDe9eIqnhdDacXtH6O8adH
	TxtuOuvChNq0seYlk+C+FCT6S5i1SBhcmr8pCfNknxal4BNfjstaPavqHZIoaQ==
X-Google-Smtp-Source: AGHT+IH1kOVXzNpj/i2DpqTZUYLKt8uVnZKDqtS2XqjTIJWyCPqL1u+b7kFKVV3yiJRygxa8exrphg==
X-Received: by 2002:a17:902:e882:b0:1e0:1bfd:c1cd with SMTP id w2-20020a170902e88200b001e01bfdc1cdmr5073679plg.54.1710802242904;
        Mon, 18 Mar 2024 15:50:42 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001dd59b54f9fsm4203830pla.136.2024.03.18.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:50:42 -0700 (PDT)
Date: Mon, 18 Mar 2024 22:50:39 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 2/3] perf/x86/intel: Expose existence of callback support
 to KVM
Message-ID: <ZfjFP7E0ME5yHJZC@google.com>
References: <20240307011344.835640-1-seanjc@google.com>
 <20240307011344.835640-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307011344.835640-3-seanjc@google.com>

On Wed, Mar 06, 2024, Sean Christopherson wrote:
> Add a "has_callstack" field to the x86_pmu_lbr structure used to pass
> information to KVM, and set it accordingly in x86_perf_get_lbr().  KVM
> will use has_callstack to avoid trying to create perf LBR events with
> PERF_SAMPLE_BRANCH_CALL_STACK on CPUs that don't support callstacks.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/events/intel/lbr.c       | 1 +
>  arch/x86/include/asm/perf_event.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 78cd5084104e..4367aa77cb8d 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1693,6 +1693,7 @@ void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
>  	lbr->from = x86_pmu.lbr_from;
>  	lbr->to = x86_pmu.lbr_to;
>  	lbr->info = x86_pmu.lbr_info;
> +	lbr->has_callstack = x86_pmu_has_lbr_callstack();
>  }
>  EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
>  
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 3736b8a46c04..7f1e17250546 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -555,6 +555,7 @@ struct x86_pmu_lbr {
>  	unsigned int	from;
>  	unsigned int	to;
>  	unsigned int	info;
> +	bool		has_callstack;
>  };
>  
>  extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

