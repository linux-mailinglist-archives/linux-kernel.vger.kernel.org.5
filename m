Return-Path: <linux-kernel+bounces-120329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D458888D5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C629B9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CD12B8B;
	Wed, 27 Mar 2024 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k419Lh9f"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0363CF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517420; cv=none; b=bAwF9RGCxlVXBZJPc0x8prZs4dzibzmub3w+tNPpR6Dn0wb7raLB6POPOcdWbKpV77UCBgL6mfyPlK5eIzfLK3pO2s3bts/z/Gs8Tr+ryWc3KqS9wP7rRt7HdwwJ+R7QpiRFzkw0aL9+PzNpGI/0DaWLeWAodAUr0GpoePUhx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517420; c=relaxed/simple;
	bh=NQc7nRPv1d9S3Xkgl83x4eUWpFOJrO1ZnLvgPWT83h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HByF/jUSlNB1hL/uaJNOCwNMmSu+f38EeaWB5D3py3Z9/c5JCORoz4tpf2Sr8fopUSvwhPfAq88ugETVfnrjXFLf/lV++rdN1CI50Sov0XC9CZvZSNP8a+CfsczH2YRpLasQKw8qqzqA5jxlyfkoS5eGuQNcaZlZdx+voPK9r7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k419Lh9f; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so4512431b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711517418; x=1712122218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVMXtjqW+QAkMGD+S/kOxyuhWzew87XrBM54rG8SDqk=;
        b=k419Lh9f2tiioctwLHMaSjGEC9861SF+kzimK+oDK+nG/hBwok+RFV1MVenzr7ug6Y
         1gJYgDj3CT6j5ufXbnXOLhiKf4Rlzl1UntTViubQ5/Eivo3WSYAmqD6BtUffmkuhJ/33
         heZDNFAwDQ3byHccrhnqEH1RkcRRJV37iI7YGcmOga4/E50jsyVItUvysKDKfCwIUnJk
         9bxNBNfjNlEfWMptN2ER1QvU0LhFdP00GMauoTcYCqYtccx/KrP2r5CpJ/cydeoXrxgK
         O8Ft+cgpevudVVZ6JKcwBoh9KibBruXhKsnaRdGx9IIbq+1wEx6V9Zk9n3BAXSrjxqWj
         v7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711517418; x=1712122218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVMXtjqW+QAkMGD+S/kOxyuhWzew87XrBM54rG8SDqk=;
        b=FyycaVZFz2btaudv7Ci5AWwnuw2/ab8PPq+x7Gwzgzfkbvw9x3DLZPt4b43ECHcflh
         0v6x6dNBijG2iySJCgCV7WJChC5A+/yMMupES1ECjxlq0FcHSyOWRt5nPAr/BiMpjGx6
         sfcrmGSxljFkkINKQxti74D0AiDLgKeJKTsUsql0nfxHZ9WPAF/9omKtiJX2rgP0rUNP
         NFR2RGlj0KqHOwK2TirWGI4x4zjay3ac7NZrhyi8wVxVjOM8Kq1XdE5ZAhnWTdM4S1bn
         ky7c6JARbi/G7dsOzERqmTrFG/phIWHBQp3C64OF1uCV2QBe6Ze0aEIP0CfXAtZEczAZ
         +Bpg==
X-Forwarded-Encrypted: i=1; AJvYcCXfD2MrYlMy7xPGTpi/b3+15HAoFgSeyMz5cBbbt6t6SD8fK/KEkYpR224HeOfMS9YOJf7sfBVpkS1kaMcsQ5+9Sqnnr8VndEw6eJjy
X-Gm-Message-State: AOJu0YzpX+iERxLjkMWbppwxdE3aQhBJDVRjJcz+RnFGf0GPMlR9Sq7a
	HjR0HCEgqVivCVLF2dZgcbTEeQ3rU5jIoYh4Q2PQIPBUEMpXKUJSpd2fS0eHwA==
X-Google-Smtp-Source: AGHT+IHhkks7dIOvaFXe2jmlSHjqEQtmU6xHx/LKBsOUAj+YdfH3VVrKnf/kxA0qJ5GUlcEYRTkyZw==
X-Received: by 2002:a05:6a21:350f:b0:1a3:e297:ff17 with SMTP id zc15-20020a056a21350f00b001a3e297ff17mr1455211pzb.50.1711517417622;
        Tue, 26 Mar 2024 22:30:17 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001defd404efdsm5338953plg.13.2024.03.26.22.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:30:16 -0700 (PDT)
Date: Wed, 27 Mar 2024 05:30:12 +0000
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
Subject: Re: [kvm-unit-tests Patch v3 03/11] x86: pmu: Add asserts to warn
 inconsistent fixed events and counters
Message-ID: <ZgOu5PP2qXhbflRc@google.com>
References: <20240103031409.2504051-1-dapeng1.mi@linux.intel.com>
 <20240103031409.2504051-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103031409.2504051-4-dapeng1.mi@linux.intel.com>

On Wed, Jan 03, 2024, Dapeng Mi wrote:
> Current PMU code deosn't check whether PMU fixed counter number is
> larger than pre-defined fixed events. If so, it would cause memory
> access out of range.
> 
> So add assert to warn this invalid case.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
> ---
>  x86/pmu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/x86/pmu.c b/x86/pmu.c
> index a13b8a8398c6..a42fff8d8b36 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -111,8 +111,12 @@ static struct pmu_event* get_counter_event(pmu_counter_t *cnt)
>  		for (i = 0; i < gp_events_size; i++)
>  			if (gp_events[i].unit_sel == (cnt->config & 0xffff))
>  				return &gp_events[i];
> -	} else
> -		return &fixed_events[cnt->ctr - MSR_CORE_PERF_FIXED_CTR0];
> +	} else {
> +		int idx = cnt->ctr - MSR_CORE_PERF_FIXED_CTR0;
maybe unsigned int is better?
> +
> +		assert(idx < ARRAY_SIZE(fixed_events));
> +		return &fixed_events[idx];
> +	}
>  
>  	return (void*)0;
>  }
> @@ -245,6 +249,7 @@ static void check_fixed_counters(void)
>  	};
>  	int i;
>  
> +	assert(pmu.nr_fixed_counters <= ARRAY_SIZE(fixed_events));
>  	for (i = 0; i < pmu.nr_fixed_counters; i++) {
>  		cnt.ctr = fixed_events[i].unit_sel;
>  		measure_one(&cnt);
> @@ -266,6 +271,7 @@ static void check_counters_many(void)
>  			gp_events[i % gp_events_size].unit_sel;
>  		n++;
>  	}
> +	assert(pmu.nr_fixed_counters <= ARRAY_SIZE(fixed_events));
>  	for (i = 0; i < pmu.nr_fixed_counters; i++) {
>  		cnt[n].ctr = fixed_events[i].unit_sel;
>  		cnt[n].config = EVNTSEL_OS | EVNTSEL_USR;
> -- 
> 2.34.1
> 

