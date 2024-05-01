Return-Path: <linux-kernel+bounces-165739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56048B9070
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA72B228B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36C1635A8;
	Wed,  1 May 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cq73uVVR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00A42A96
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594405; cv=none; b=sEEnWJyP2SeZz0ZaLI+JA0gvgHuGx54sHJ/hu0wyfDVf6N+ZLsNOd9CqoK8WVJGZCcPA/Pw0cD4NI79pLZ5HvofgB4aSK7cqHqBYf4veEHhqPTlBwvMn8F7ataGVi7L9LteAy9ylHFolvCrJFPF9hGk2vFL2cfEl5oKtl8yU9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594405; c=relaxed/simple;
	bh=4ywZCAUhnkyRouoGXFeP3qU1/bxbRV5WojnoTHw3CAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taccVhV5DRUXybrynSmPsDNTcWrrVzQkMQqZCY4BN2vFNJpbstZvAwZDrgdGqw0P7feOirPJtO6UuSjROVD0s52k90gdtxKGvPNXP8krnDmyNjO3qCHpi3bme9JGEJbAs9ic+BycNb/JYejaLzAIhd4VOx9rLd6izcGxn1AScIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cq73uVVR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso6362601b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594404; x=1715199204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzJNyUjTcyvayOGi2RmNTOhiNWDsJ2lrCXlytRPvm1U=;
        b=Cq73uVVRzj6HMzdt5QVbKcr/k76sr9w0oytb6P2zs1XmFrJQL2WJAjDEvo/OXwfGcU
         oQj2RnQNNI+6TylFn99Ju9q37kCwj4K2lsl9p50RDz3Lqf+8GXrsFpwXoC8oYlXs1VeS
         vNiJII/xVcT2nJRFmSyWzO4p1i1CxQHIjlQqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594404; x=1715199204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzJNyUjTcyvayOGi2RmNTOhiNWDsJ2lrCXlytRPvm1U=;
        b=n5ehXP1FYt4Gyv2/RBkhKa68eH5r6Y9+6bAL5/Px+jxzoQO/ky8Dg+Ka1ijzp/h9S9
         d5VVRNfqqollD6JadsccTXmeyihO5BIQv3Cdf3sRAHoCUW0v50W68EOr5lenMjStv2Qq
         VkC/X3QSucDHKfHP/vGC4KQBD2/wAwt0cvKm2WPTs8fEf4bV2DaqwuWeOWbfNpJ86TLY
         hFxsx73r8zIgZUypJgm+zcYf6hYhj4eQOy6YILxifEssJBHXdJ3T922jQ0Z6Qmm6PORy
         VF76XK3gXNGAzwigtzbtYiyX9h8aS5PaimssrC5DU+q+X4mzEyeJc5SIYd+AVmBZlvUN
         YxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs5+2cOt2Sr1anFMGDyBG/U0nAeWIcvth//VvTp8HQGa5z06uTAlLH132CreYx5oob0awxyqnJkJOsgv3T0kugn7xjf2bp/NcU1Na5
X-Gm-Message-State: AOJu0YwpFATx2DGm+oIhfnAJFWYtI8HL8GdcByDBXV+VmvPLhVKzkAwE
	yOVH097zPe3nC/w0qLCDXI/OLFRNVJryhJ8oGWBhdTBdWY1gUkQnjGaehEsOTg==
X-Google-Smtp-Source: AGHT+IH2F7ggeD8WqIrB1Dq6jq/1RLcQimv9rH0YngcVlTmpQvQ888AUBOkKaiZSGmgPfIrw6a4Oig==
X-Received: by 2002:a05:6a21:1a8:b0:1a7:5fbf:3774 with SMTP id le40-20020a056a2101a800b001a75fbf3774mr5708830pzb.55.1714594403848;
        Wed, 01 May 2024 13:13:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b006ed007b3596sm23070981pfn.69.2024.05.01.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:13:23 -0700 (PDT)
Date: Wed, 1 May 2024 13:13:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>, Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
Message-ID: <202405011307.2C8E9BE5E@keescook>
References: <20240501000218.work.998-kees@kernel.org>
 <20240501163314.GA2472577@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501163314.GA2472577@dev-arch.thelio-3990X>

On Wed, May 01, 2024 at 09:33:14AM -0700, Nathan Chancellor wrote:
> On Tue, Apr 30, 2024 at 05:02:22PM -0700, Kees Cook wrote:
> > Since FineIBT performs checking at the destination, it is weaker against
> > attacks that can construct arbitrary executable memory contents. As such,
> > some system builders want to run with FineIBT disabled by default. Allow
> > the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
> > newly introduced CONFIG_CFI_AUTO_DEFAULT.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I verified that flipping the configuration does indeed change the
> default and that 'cfi=' could still be used to override whatever choice
> was made at compile time. This patch was a perfect excuse to put my new
> CET enabled test machine to work.

Heh, yeah. I have my one lonely CET system that is only powered on for
this sort of testing too. ;)

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

> CFI_DEFAULT_AUTO reads a little bit better to me personally but I am not
> looking to get into painting today :)

I went with CFI_AUTO_DEFAULT since this seems to be our current pattern
for setting these kinds of boot param defaults. A selection of examples:

arch/Kconfig:config RANDOMIZE_KSTACK_OFFSET_DEFAULT
lib/Kconfig.debug:config CONSOLE_LOGLEVEL_DEFAULT
mm/Kconfig.debug:config DEBUG_PAGEALLOC_ENABLE_DEFAULT

-- 
Kees Cook

