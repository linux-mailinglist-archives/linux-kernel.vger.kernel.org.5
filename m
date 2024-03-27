Return-Path: <linux-kernel+bounces-120332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64888D5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4614FB222C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2F1401F;
	Wed, 27 Mar 2024 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oa/DEGd0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463910949
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517891; cv=none; b=K1I5rh4S1Znfg9lDjehSzRMSZDZm6dJHqCrmQsg4nZ1EUqcLy4/UtzVywYLOYWRmCQaHhFS0lnSPRhokkeOlOxtYUB3N3QiGoopVjiDp54xVq0LYsW/Jv6YBQSYl/tr7t79BLSBr/VqXhoUSC35+pllJcj7QWfUqAiKgsgjT5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517891; c=relaxed/simple;
	bh=jxc+ifoFr0vgBSifpzL8V8mividmrbHl9bnUpbSaOyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU0LbEc7d9mTFk29KlBKyAMXQnNdNdpyJyAVjw2VXiajx/aih3u1hcVLN1TF1zlm5hm1/UANhFaMoXBPQeT639/i3sacC5Ej8K2hOK8kH6T1/Mz12JVIsHf0vTQnnAPye3A8usGaxFDXlwn9dlhNvoE+ZLqTCgwIMrL3VpiskdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oa/DEGd0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0025ef1efso41596925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711517889; x=1712122689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+fNf8kwFz9hjq+tSfSz7ViPMcYhwL+6JOaYs7sM0+E=;
        b=oa/DEGd0yovKgc5TNRYErhX7KbrtZ20H/npE9XkgpH+0jQXBC1fEi6OrVpCXbuHimm
         spy2+Alg54Uquex7Xf6npavkiS4HsrJpgT+nhVge2H99YubGN00kBVsmjTkR1VhwkNRa
         ordcTCvz907yrvC50ib+uHa+9it8cVUdWs55AIgam28imOyVOK7+7C86d/Tp207AYujg
         zSArMWlVHMgcZq5E8PfIeHKb/MQTIsYyfC5/MVetG7IoLSRck4LrkLb7oqNdVoj9LIEO
         L8cbFfkYlLb9D7ZoANYb6/b44ZQr0fZdfuZoIIfaOLD6VSZ9iQZPr20QjPNHxSZI8ecu
         ZyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711517889; x=1712122689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+fNf8kwFz9hjq+tSfSz7ViPMcYhwL+6JOaYs7sM0+E=;
        b=XVs21D8i11+mOWfP18QCG/K47mqxhIfL4ZjfazfePetxN66Dp6tMUzpW3V5uJe1W7l
         EV+UsLlmyEa6EnUoUE10MJMfkpgCVeBigqTO4hX2aZiYx/4AfCi4WTa9yV3mNOCuqQ5W
         abO37QmlNMEHH+n9I852d/QDhuoyOtkMXwnTtl1G1lgyUQL9S9VPB0UQihxUMNin9Qt0
         vkwtLPyri33eebWeNtqDIPS5k110BG3Y5ZTLJbvqaerBycuaYeccTv90q6o/2SzLqpyS
         VKd9P28L3ECQm0x8ZQYVkwd+3n+nGrdB0+9osS8XO2E33ZUXxgvz+VKCnMUhCrmXRYWt
         slsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc/aMMIdwzGPmC32Dbzc65dhmoDOnmaxTNHxJmKL9S+n5XlnSvDyD8CgAaB1ZSM2pSjeF87bdCD+ZWKV+ypFqR2CSn6ThmmxQZsJjK
X-Gm-Message-State: AOJu0YxR9fKVR2Al88hMvOLLmz8SCn97C9GvUTitFTQ0pJsp48yskPSR
	yiwjhshN5d5BEPIUT3tGJ71fYRYiDs8+ovJ4LEcxo9B4oz3fjDxrxCgUeTAKUw==
X-Google-Smtp-Source: AGHT+IFfDJJu8eU5vpeHwdnNhSO9hlVbXO/frk+1YOkjU00bY6YbyW2aBR6BF2q3X4HfdBGyzFXKuQ==
X-Received: by 2002:a17:90a:eb04:b0:29d:dbaf:bd77 with SMTP id j4-20020a17090aeb0400b0029ddbafbd77mr2908734pjz.43.1711517889217;
        Tue, 26 Mar 2024 22:38:09 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id pd15-20020a17090b1dcf00b0029fc4b3596bsm662952pjb.7.2024.03.26.22.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:38:08 -0700 (PDT)
Date: Wed, 27 Mar 2024 05:38:05 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhang Xiong <xiong.y.zhang@intel.com>,
	Like Xu <like.xu.linux@gmail.com>,
	Jinrong Liang <cloudliang@tencent.com>,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [kvm-unit-tests Patch v3 05/11] x86: pmu: Refine fixed_events[]
 names
Message-ID: <ZgOwvZREoyINiMwP@google.com>
References: <20240103031409.2504051-1-dapeng1.mi@linux.intel.com>
 <20240103031409.2504051-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103031409.2504051-6-dapeng1.mi@linux.intel.com>

On Wed, Jan 03, 2024, Dapeng Mi wrote:
> In SDM the fixed counter is numbered from 0 but currently the
> fixed_events names are numbered from 1. It would cause confusion for
> users. So Change the fixed_events[] names to number from 0 as well and
> keep identical with SDM.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
> ---
>  x86/pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/x86/pmu.c b/x86/pmu.c
> index 67ebfbe55b49..a2c64a1ce95b 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -44,9 +44,9 @@ struct pmu_event {
>  	{"branches", 0x00c2, 1*N, 1.1*N},
>  	{"branch misses", 0x00c3, 0, 0.1*N},
>  }, fixed_events[] = {
> -	{"fixed 1", MSR_CORE_PERF_FIXED_CTR0, 10*N, 10.2*N},
> -	{"fixed 2", MSR_CORE_PERF_FIXED_CTR0 + 1, 1*N, 30*N},
> -	{"fixed 3", MSR_CORE_PERF_FIXED_CTR0 + 2, 0.1*N, 30*N}
> +	{"fixed 0", MSR_CORE_PERF_FIXED_CTR0, 10*N, 10.2*N},
> +	{"fixed 1", MSR_CORE_PERF_FIXED_CTR0 + 1, 1*N, 30*N},
> +	{"fixed 2", MSR_CORE_PERF_FIXED_CTR0 + 2, 0.1*N, 30*N}
>  };
>  
>  char *buf;
> -- 
> 2.34.1
> 

