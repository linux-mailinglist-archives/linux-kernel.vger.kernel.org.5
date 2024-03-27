Return-Path: <linux-kernel+bounces-120333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C687688D5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6149C1F29475
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A414273;
	Wed, 27 Mar 2024 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKV97/gR"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B941170F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517929; cv=none; b=ldyVtPjZegtpC2yqqIh8ZcxG/4NQ+UlwQoKiFsvsqZPT2bKpcTKfZb+3gnpgzjc26XqYwKX/cFo2DCcFLVRGECEqccsgfSfcUsrQxdSXHVOImpbEQnTM9IvMgs5i8FHeOfFw1pfVw4b7ehWQ3J0Imwga6BZ22vfZDAUFnOydPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517929; c=relaxed/simple;
	bh=c8Qxz3GjemwSldg1rtEYBEhGGs00Vj4gZEX2g47vXU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG/E7Ul92XWz0M6vLyGSvDIMn3IzTG/VtWDpOk8M9Ol//Rwu+vUIQWV8LP7XM/UoziwcAUUhuLq/sIyMM8SR+pGvl1vyMdFUPPcSG1KCevnys1sMkjWzvCIS3Xc8cjQLb5cWJcm/Qv0GIvAw6bgcU5uHOvAo0nJNemKgWqjLgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKV97/gR; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3d859f8e6so897871b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711517927; x=1712122727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEa1wJbE96+0XdxLOBaQ/cWqz0eCFh0pN8QmBlQTfhY=;
        b=lKV97/gRMOT//Q0lDh66iLIpwoJ83uJMWLZaSEyRsIn1YaVlJ1XVewArdLqvHQpUBZ
         ZDsp0QwzN1iYDfEvSB3/pyaglflURGrLvp2K3ZbTU2I+kpPEtnSn8Lx6OPgRjUIAbfSZ
         GdwwIhYqc+Ow9fRgvx5RNhz/4gdHLopjetTg43DlCwD5efjChqg0KZWcVyDkc1qSM1bz
         wCvDRp2mOUIcz8iX5HAzHyYzdTE9y7I1HeacTZa8Sw0aPSUVm+fBmIe4Pc+XgaIjqbdc
         fJWoVPJdFeF89/cQu0GHY+wDKsHaTbkjXmIfo+ooqJpnFZVfKJ7js4kIE8qIs2TJLwjT
         vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711517927; x=1712122727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEa1wJbE96+0XdxLOBaQ/cWqz0eCFh0pN8QmBlQTfhY=;
        b=on/YdMMd+jZwe8aJykTk9zG52XMbljlGbpy5GNRKO8RHGIVnQeOwkt7hPLBHLrQNKi
         6ZrKqFbwEcmYW7T5zWhLhfXFbHgCGfU5Gn3g4cuHlsFZNmYLlB9R09noGjI5byndlu+p
         Ggd1fI8TKR0smKxLdPoTfCnZCUtZfghBziqbXkyreYsD58+Y/qflIsUj51ZU4OoGyNXt
         72yQWHKWQrtDXobnFB8/5mt4eXmmJQz5X2O3NnA5IApmhd1rrbxwSocTGo/rQd1ECrCR
         d6iS4uu5U686+QnJ0diEVhWAW2DAqCBweN81VtnUdJ3ELjGjymBoueiDqKN8V5eTMPlW
         2tYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXeERT7uuDl6w5huxMDW2NoLqZbOT4aY71D46vGbbQApwKSdzHrR3Lr9xJwTq2YKE0cXxMgN0C9P/3SFqg2xMErhOwkGqggl5YhSxt
X-Gm-Message-State: AOJu0YzITNGGhTxGGvkFNiVUwBfkg75p9eyIqA7/Z3R94oBTZviw2zrR
	h1h4NRyYZoX1pXTmt0W1Qg8AxjEW7CxT3BaCagAsNWhXp+IKVjzDniUwx18kZw==
X-Google-Smtp-Source: AGHT+IGp1R8GmfW8HUNyHIR3uCDgu524YP5Rj7c/dj/PXh/ZNJ7GIsh+Jq6UmTViK5/nupAbScuJgQ==
X-Received: by 2002:a05:6808:1381:b0:3c3:ccf2:7f5e with SMTP id c1-20020a056808138100b003c3ccf27f5emr353054oiw.11.1711517926472;
        Tue, 26 Mar 2024 22:38:46 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id g16-20020aa79f10000000b006e669357e83sm6941515pfr.189.2024.03.26.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:38:45 -0700 (PDT)
Date: Wed, 27 Mar 2024 05:38:42 +0000
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
Subject: Re: [kvm-unit-tests Patch v3 06/11] x86: pmu: Remove blank line and
 redundant space
Message-ID: <ZgOw4g61ejwD8oQ5@google.com>
References: <20240103031409.2504051-1-dapeng1.mi@linux.intel.com>
 <20240103031409.2504051-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103031409.2504051-7-dapeng1.mi@linux.intel.com>

On Wed, Jan 03, 2024, Dapeng Mi wrote:
> code style changes.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
> ---
>  x86/pmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/x86/pmu.c b/x86/pmu.c
> index a2c64a1ce95b..46bed66c5c9f 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -207,8 +207,7 @@ static noinline void __measure(pmu_counter_t *evt, uint64_t count)
>  static bool verify_event(uint64_t count, struct pmu_event *e)
>  {
>  	// printf("%d <= %ld <= %d\n", e->min, count, e->max);
> -	return count >= e->min  && count <= e->max;
> -
> +	return count >= e->min && count <= e->max;
>  }
>  
>  static bool verify_counter(pmu_counter_t *cnt)
> -- 
> 2.34.1
> 

