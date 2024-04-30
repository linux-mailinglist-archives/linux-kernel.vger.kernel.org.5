Return-Path: <linux-kernel+bounces-164736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285808B81DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDBEB216F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B391BED63;
	Tue, 30 Apr 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UkpjcoGR"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90B1A38DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512337; cv=none; b=W3AUStnMdRCxUnVK31iTIQuLr6UaCA34BOMJyAskci/GTusDp5nvrHwW5ealTXrmanq4YvECDHP40HtPNR39OYska30evU+ZvRcZwvqf9eiAwftjPc4lzNcfMlRFLJCUPQNn79ax9lvlmr+0zMNRIei+xwYsIzdeDqIumuFF0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512337; c=relaxed/simple;
	bh=A2BKfjstI0QAqB/arpyjcxV2OCbaaJu3tI5uRAVc04s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TolUgD36Vcb2OGdUwsZYvRJk/0fkwrN08nJ7vavWpBRWwZdishrqYKOmNmmwdUWtX+djnlfT3OCQOgG98U1Mi8OTlje29CHmyS2Na4YTb07TU/uC9B+8R5LmPNP8jtjs8AdMA3ak9vbai6fmp0MXRxuw0/doUN/rxkN6IiZdaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UkpjcoGR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso4423574a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512336; x=1715117136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yL344saeiEHbqmyOopyOdGQH0USlm3SnC2xCq0SoJLU=;
        b=UkpjcoGRCslNY+nJjND5YxLCENbqyO69ypLlRWqSPHXpzTLKmSfwTYWM+GIB6q+SSd
         aeb3Tdd59YH6iGyyB4BlE51A1w/RA0MsDF5j1Nl6jn9iqhmyayOF0h6TeF25v87LpPnY
         Hy+S3hDniK3U+a9198PvAmSYCE8zKi1TUKcSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512336; x=1715117136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL344saeiEHbqmyOopyOdGQH0USlm3SnC2xCq0SoJLU=;
        b=Zo8ih2Dr+5cYbRhhQzs3NNEKgxKD/CIW5VkHluAhfbx4UhHX/+Qv/+p7ZiZ2L6YYNj
         BqZYSXfMnjvRGD7YWzaj2KyJmw64t/HDZ+miJpQVs92Y11ImIZbYzOuGojwL8nuI54Oc
         uSmXluyo4b0xdAxiL71ABgj7PScow9Fe8jvTNERRj3EvyDpUq6PptV1DuYfO70L1EpjD
         PkgPdSpHoh5oEQjT97FSfTYIBxXHT8pb8uJnfz9P0Ej+FtjOwmzl2kHmPhgtIW9vULCa
         d3O2sY5LWd/+s50hD7qBReblNjeMLUlpdOfg27qT4a8h3lYkyMDZ9jvpO8IgGSDtt/rj
         QlHg==
X-Forwarded-Encrypted: i=1; AJvYcCVv2Wp4vRpYJvY74na6+82SwbWZFw8kmoLG+jeM2sGd+C0dWlC9aq2r81kGC3JTrL8m7XxKyjAZxIZICUUXQKLYQJnFA/qeIND35PmE
X-Gm-Message-State: AOJu0Yw4wq2JrawPYf29F40Up9xNf56MISrUoV9yma/iXgKuK9yM2wu8
	JL/mYikmMVi41NhtKDKBR4g5r8tl285UlSkcZFesCXUmuuc9Rel6TmoKIrMcgw==
X-Google-Smtp-Source: AGHT+IFIxVelglvKW5StU7tXy2dZZm6BsDNmXrzU8ELIShBXYB5SRyvBVWCFfa0CxoN7Rk5noHrHnA==
X-Received: by 2002:a05:6a21:998:b0:1af:4fd7:6c6f with SMTP id li24-20020a056a21099800b001af4fd76c6fmr545627pzb.35.1714512335948;
        Tue, 30 Apr 2024 14:25:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb33-20020a056a002da100b006ed14fed3a5sm21507308pfb.154.2024.04.30.14.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:25:35 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:25:34 -0700
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
Message-ID: <202404301424.FF88864115@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
 <202404301037.9E34D4811@keescook>
 <202404301409.D3BC98D5@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404301409.D3BC98D5@keescook>

On Tue, Apr 30, 2024 at 02:15:53PM -0700, Kees Cook wrote:
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
> > 
> > But now that I went to go look I see 0c3e806ec0f9 ("x86/cfi: Add boot
> > time hash randomization") is only enabled under FINEIBT... seems better
> > if that were always enabled...
> 
> And FINEIBT actually can't be disabled... :|
> 
> And as it turns out CFI_CLANG doesn't work at all on v6.9...
> 
> [    0.587220] no CFI hash found at: __call_sites+0x339a8/0x34450 ffffffffac20cef8 00 00 00 00 00
> [    0.588226] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:1182 __apply_fineibt+0x7a9/0x820
> ...
> [    0.619220] SMP alternatives: Something went horribly wrong trying to rewrite the CFI implementation.
> *hang*

Welcome to my TED talk.

I'll keep debugging this: boots fine on v6.8, but booting v6.9 with
defconfig+CFI_CLANG _does_ work, so something in my .config broke it...

-- 
Kees Cook

