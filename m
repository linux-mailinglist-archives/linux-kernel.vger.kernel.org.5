Return-Path: <linux-kernel+bounces-94788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134387453F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82440B21928
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436446BA;
	Thu,  7 Mar 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UslOwuOP"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EB1847
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772237; cv=none; b=OJNwZ4wSqKnQPs2x0ZaMjuvoLIhybP3dZGXtOIZ1P0ebbjTE8RDOEaU+9SZipqOTjuupNL+pwuq0Ti0sNeugdSQVfOxZsnFPoxwePjEaFH5vXqDS8YRYNeqUoSUA5y7GABVaabrH87TpHdoJkkW2FGXQzBmwcy7uJCTyY7OSj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772237; c=relaxed/simple;
	bh=yuOqpNroduXg5pfJXWdF3Zx7nQ75KuKEYW/R0Eoy1uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVMus63v1kFxyctNFpeOe47ULdfDoVktjYyEN+AAhhuVfuTm4Rawd0oMpvdytUusluKsmPZDuVY87pu8/o5t3nSgxIfv9fzoTKWgwQgA/s8fnnKB29jBLGPGyBUgXfHFLar+wsRpXftHmRsptvAzP5VgVP18P5QibQ6ElelOanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UslOwuOP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so305001b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709772236; x=1710377036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lxAB0mMZcaRnEfPEWC3zgZuIdTrf+kqgAsMWEd34IE=;
        b=UslOwuOP0m9IiUcEeDBJN1to8Gv5lECLHbsrRxrMRefznoCydZCUIBGn6Zz8Q7KWcs
         lIWnbdvrSgCiK2ltc6fPIFB/A5VFCqAK0IBvxQWvqdl01TIrHPRivLf1d94LYHbIbff2
         8IG1+8FEB6bskuqWRN/8Opg7YDZGfHUiG0ULtE45SvWpd1tP9I0LLgX+uX5ZzaFxCSkl
         VMx/5s3ZvsEpMIT47jQ48AwG2LH9McTjVfcA+4MWmhHvpkG+yozvQrrnQ+9qAgoNBGOI
         r1Wz3WAWFjIeGtdaqWprgKRhJ1ZB/LJQTxwgvWn7qkwWZdev7LgLquhYrn1lHegb/4zx
         x3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772236; x=1710377036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lxAB0mMZcaRnEfPEWC3zgZuIdTrf+kqgAsMWEd34IE=;
        b=L5c7dQKXKxW3wdOboei9TlIX8yrAyJ4kOuFApmTu/ia6tENlly9XrvufUG88MT+Klr
         a/C2OEP+huAZkwi/8ystbp816dmSJfwpgPko08gnwBNV/Ao3cXiZaTUWEvULV3LKBLHo
         sGeyFpRPXUP9EApFLB79iXXRexiuYraZ+FSpLmHeLssSOqR+OWh9uNxN6FRkz5xY90tW
         5Y9woaBgmsai2f5SGJtwKlFokG2AAgVW1WM469D1sbPi+5pnSDuT4vx2cp/SEsNHYBEq
         9UGUnal048EhO7zsm45cU5ULdxYBUhLAwQ08OprTr/qQPb/yoSkZDsX8GeUSXuwl1C4E
         uo4A==
X-Forwarded-Encrypted: i=1; AJvYcCXQJNhYenO5RNPgKbqXZnf08tR94sw6GxQpehx7J+9Xtv91AgKrOys6PEN0IrgpFlaHFwTmcdaO1NBmfft24rWpQjX7bkRR0qT/VqLn
X-Gm-Message-State: AOJu0YyBzN3BASAEmVSSr6gjpckaLWQ6U75RMAjTBF7BQUoO3sQUFOOY
	e+zWB3TD2UOgEONTU9PHrrZAafPSa79mRwU4mhdbPMmIX/EngjLAUDXl0yQQ3Q==
X-Google-Smtp-Source: AGHT+IEFTRrgkzX0j8hD98rU8k/J1m5xYiNpA8BYWpQ6cPIgu6BWNn+lxUcXKUdUK2yow9CLYGnjFg==
X-Received: by 2002:a05:6a00:63c7:b0:6e6:5575:f0f8 with SMTP id gi7-20020a056a0063c700b006e65575f0f8mr2208915pfb.5.1709772235563;
        Wed, 06 Mar 2024 16:43:55 -0800 (PST)
Received: from google.com (61.139.125.34.bc.googleusercontent.com. [34.125.139.61])
        by smtp.gmail.com with ESMTPSA id g15-20020a62f94f000000b006e657c72cf8sm366183pfm.148.2024.03.06.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:43:54 -0800 (PST)
Date: Wed, 6 Mar 2024 16:43:51 -0800
From: David Matlack <dmatlack@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Federico Parola <federico.parola@polito.it>
Subject: Re: [RFC PATCH 1/8] KVM: Document KVM_MAP_MEMORY ioctl
Message-ID: <ZekNx-WkGNrVfFRD@google.com>
References: <cover.1709288671.git.isaku.yamahata@intel.com>
 <c50dc98effcba3ff68a033661b2941b777c4fb5c.1709288671.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50dc98effcba3ff68a033661b2941b777c4fb5c.1709288671.git.isaku.yamahata@intel.com>

On 2024-03-01 09:28 AM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> +
> +  struct kvm_memory_mapping {
> +	__u64 base_gfn;
> +	__u64 nr_pages;
> +	__u64 flags;
> +	__u64 source;
> +  };
> +
> +  /* For kvm_memory_mapping:: flags */
> +  #define KVM_MEMORY_MAPPING_FLAG_WRITE         _BITULL(0)
> +  #define KVM_MEMORY_MAPPING_FLAG_EXEC          _BITULL(1)
> +  #define KVM_MEMORY_MAPPING_FLAG_USER          _BITULL(2)
> +  #define KVM_MEMORY_MAPPING_FLAG_PRIVATE       _BITULL(3)
> +
> +KVM_MAP_MEMORY populates guest memory in the underlying mapping. If source is
> +not zero and it's supported (depending on underlying technology), the guest
> +memory content is populated with the source.

What does "populated with the source" mean?

> The flags field supports three
> +flags: KVM_MEMORY_MAPPING_FLAG_WRITE, KVM_MEMORY_MAPPING_FLAG_EXEC, and
> +KVM_MEMORY_MAPPING_FLAG_USER.

There are 4 flags.

