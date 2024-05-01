Return-Path: <linux-kernel+bounces-165710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961FD8B9009
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CC21C2116C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC54161309;
	Wed,  1 May 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QzBNm+f7"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24A131726
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591661; cv=none; b=qVxkdXYKhgES1LOfhPGZgUVDseXw36BqHm+sJJCeqpziTwxJReSXrQgnEuL8kSMVxUmNVgUYFa3X8MVOoZTENnwkXU9nKoIq1ini8fR+bfDKtMDv2DPl4iIqpltzLoTsUAfqoGXeZKraXfa2hVmYDt4TWOK2/6IRsSvJRsLYQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591661; c=relaxed/simple;
	bh=oQTD5dOBPZRoT6/0eImWZ1AIIrVNNjtcFO1mwR0zuCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKaD/W9tEKJYUiQOEJv8BXFmIpTqDGSzJd7KTlEfc1URaYrXrU+rQW2iLlD3JcUWpmBrU4OSnFXnVgnYIC2g/3yvsQGHG8mKBSrZhCo7uJRFmb7UbTc3ubiMo2vobiUOzr8KYOtW5FpClj9hFwUjXtwJML9udldVLAmoG8isUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QzBNm+f7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso15010285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714591659; x=1715196459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+gDh6NM77cGHfdw7r6TvXLTNq5DARX9/1cTJfxUhiI=;
        b=QzBNm+f7EAwTJeoYOtqxnK/LV+AvKLZsTD1uMJc9KHzfD8pEJfwjeVhFHK9M0dpuvr
         FR5QbhYpNrYaa0wFzDxQ+P7YIk+9Vt+uNXws/pFQIaGjnUR33oKN0Tl0EPgXT0J3Mkfc
         6+R9q7InsxIOrHfmnUDKOXSwLVV5h/PQ3T2vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591659; x=1715196459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+gDh6NM77cGHfdw7r6TvXLTNq5DARX9/1cTJfxUhiI=;
        b=lDeTIC5AuCHsMWtmZn1LmxP3MlN1JM40hbU1I5a+yzZARE84R9opWktbwUzWY7YAM4
         HMvu+a+ueS0www8kGcsIAtkrxzA6dOiUYUoFun1jYUxJHJMAeDFOWvZ0Sgu7b6x0md1K
         R4pasruqWn9MRuMc2E2ZYqqPd4Ma61DmlstKNZ+mmQo+H7blQ1kL30Z/wQnQORvdu7t4
         l8NqbILOEVP2sEix9qgh+Y6bzGfW9xpi0JjYtmHbhsAQ457YiRcWVrEOd/ir0DM024+f
         x95mSNZyhxL/UTLXCk5lkVnE6uw+NM0MHNntyv4SvSko7/PNXu5iTCD4rOscUcvBrK8V
         gL9w==
X-Forwarded-Encrypted: i=1; AJvYcCVF6tT4vRGdBGZhdNZUiSrzFx27EewWLEmNhosMnNKpVLgAoOrQTEaocQJPVtgwOpT/AWu8epZebYYsPteU53E885ijJ+HBYCT4msd3
X-Gm-Message-State: AOJu0Yz0Tr+zgRh1uqfxyjrcZW6TN9TpuvA6mn97m69/CfiDBBR3wt+s
	ZGpFdXKJZ0rY6tKt5pil0ze91tMcEreoe1R6ddKAgTtt0MRWRfCaY2Ba7Fc88Q==
X-Google-Smtp-Source: AGHT+IFOqiuy3jqUmROs8uWUXbDQ4LpVCOGiqzH5ePrGMAGevXpVZpwp5HMlWqxDJM6lzgjTQUJGyw==
X-Received: by 2002:a17:902:c212:b0:1eb:76ac:b4e5 with SMTP id 18-20020a170902c21200b001eb76acb4e5mr3312554pll.49.1714591659325;
        Wed, 01 May 2024 12:27:39 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001eb17af8493sm10043502plh.184.2024.05.01.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:27:38 -0700 (PDT)
Date: Wed, 1 May 2024 12:27:38 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202405011217.B822CA08@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
 <202404301037.9E34D4811@keescook>
 <20240501110614.GI40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501110614.GI40213@noisy.programming.kicks-ass.net>

On Wed, May 01, 2024 at 01:06:14PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 30, 2024 at 10:48:36AM -0700, Kees Cook wrote:
> > On Tue, Apr 30, 2024 at 11:21:40AM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> > > 
> > > > - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
> > > >   it isn't as secure as straight KCFI.)
> > > 
> > > Oi ?
> > 
> > Same objection I always had[1]: moving the check into the destination
> > means attacks with control over executable memory contents can just omit
> > the check.
> 
> I thought it was game over if you could write arbitrary test anyway?

Yes, an attack having arbitrary write control over an executable memory
area is the place where CFI does get much weaker. But presently, there's
no reason to make it easier. With the hash randomization we have, an
attack needs to locate and read the kcfi_seed, otherwise everything else
is a fixed value.

In the future, when we have viable X^R kernel text, then the trade-off
becomes much more clear: we want FineIBT very very much. :)

> The whole CFI thing was about clobbering data (function pointers to be
> more specific), and both are robust against that.

Yes, if the threat model is limited to arbitrary writes to function
pointers, we're totally good with FineIBT.

-Kees

-- 
Kees Cook

