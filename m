Return-Path: <linux-kernel+bounces-155664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D57B8AF553
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AA1284621
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335E813DDC6;
	Tue, 23 Apr 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="etrO4Snl"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594E13DDA4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892902; cv=none; b=s53nqM6UkjqQpzmsMt8x+rbGXdgVoMfP7LpxDXrvtd0Qq3tRg+6K4JpJnVG4fhVAjMzHS2n9SeRjGzy9qGt38JQbM6ppziRs5Htlj5yU3JLNxwl5vKPxVKMmFhNCOyaL1H03P6zeTLNN5cIC7OMht9pkEvCioIFvnINTPuKjCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892902; c=relaxed/simple;
	bh=RR/mhCut1yZzlo78rvqAn3QoOM7crWMEG6yeIIOea2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rti4VoYFfqh4ylOBA6ANgQLvWmFMLUxs2ZrPByqri2gEYEyx7HfltCxpMtXI7kN5ktlswXJCv9mJ/CI5LnLcZsFEAih+YRlAwpezT3MlGHzLzxGcOkt2Qy4jPLYjWoNSTiCzfynysv7xyhdsi9xCYaoXPzd66BVrOH3VgkokyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=etrO4Snl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so2002757b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713892900; x=1714497700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TicRi0V1qAmMfgKOSSBluVXmEMBw9YUKFX3o6wTkOkA=;
        b=etrO4Snl6wGdplraGaNrGy4NOWhi4O9d2sY14UfGMc27ZiYpkAAh/AuUmQ6wAqtfIO
         ej2EYY9rp0RqBJpjQgvpFIZFXH7Z0AqmkBTdBAvbZ0y3ys1OmU2BvcZTTZ7RhUN9REdm
         AV+1kvQJvYZ3Z20ov9EHaYvfRYCtdhPgNEJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713892900; x=1714497700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TicRi0V1qAmMfgKOSSBluVXmEMBw9YUKFX3o6wTkOkA=;
        b=OomHStY1w8zPCErOofXbc7ysCTbLuiaX3TFMszW0baw9sokGMnJpekbwBRRYnYdDHG
         XNtBmQ8djMcRFw9vOW6YV60ToulFljmgpIBBWUEka+FIYJFPUp1yr6KgEqg3ztVGMg+U
         Hbz6YHAMX3ZhdZ0mnYcoUZW9HvNZg1pbSLnxRrdvvtbsBFV4QgFLUm3GXhpTdYPDvOfK
         AQZzNNbp6sCta5kWwr7fqDpOOeBYMdNl5ylONYUEQiXZGEdv0Og+712HFaJ4DcQIuId+
         81O7iACHR8PIFEafNsVPr0cDghdYcKjbz5kKtxhzM3EXlc2sZscpnLOWct6bXPiUBsb8
         Bw9A==
X-Gm-Message-State: AOJu0YzJDnmo2jphDRId9qGBkdUg75xr+m1amC2byMpdULALfjyWGjzy
	WYR+1a0R1lfcdg1NUUcpJb7jCoA1otftLVi4LFH6k7e/CYrGx3T9sxcs1JZ+FA==
X-Google-Smtp-Source: AGHT+IE6XSvERDfNoRMkS2W/ja3DqBX71Hjak3gJeTYJ9CPh/P13Nw07P+l3XL5uNUwvjqxeZSPiQg==
X-Received: by 2002:a05:6a20:2d06:b0:1aa:5984:d3 with SMTP id g6-20020a056a202d0600b001aa598400d3mr41751pzl.6.1713892900193;
        Tue, 23 Apr 2024 10:21:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b006ed64f4767asm9894062pff.112.2024.04.23.10.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:21:39 -0700 (PDT)
Date: Tue, 23 Apr 2024 10:21:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH] lkdtm/bugs: add test for hung smp_call_function_single()
Message-ID: <202404231021.271D4D0B@keescook>
References: <20240419103452.3530155-1-mark.rutland@arm.com>
 <202404191434.5B051B5DC6@keescook>
 <ZieDsZclwUpzcaeI@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZieDsZclwUpzcaeI@FVFF77S0Q05N>

On Tue, Apr 23, 2024 at 10:47:29AM +0100, Mark Rutland wrote:
> On Fri, Apr 19, 2024 at 02:53:59PM -0700, Kees Cook wrote:
> > On Fri, Apr 19, 2024 at 11:34:52AM +0100, Mark Rutland wrote:
> > > The CONFIG_CSD_LOCK_WAIT_DEBUG option enables debugging of hung
> > > smp_call_function*() calls (e.g. when the target CPU gets stuck within
> > > the callback function). Testing this option requires triggering such
> > > hangs.
> > > 
> > > This patch adds an lkdtm test with a hung smp_call_function_single()
> > > callbac, which can be used to test CONFIG_CSD_LOCK_WAIT_DEBUG and NMI
> > > backtraces (as CONFIG_CSD_LOCK_WAIT_DEBUG will attempt an NMI backtrace
> > > of the hung target CPU).
> 
> [...]
> 
> > > I wrote this because I needed to guide someone through debugging a hung
> > > smp_call_function() call, and I needed examples with/without an NMI
> > > backtrace. It seems like it'd be useful for testing the CSD lockup
> > > detector and NMI backtrace code in future.
> > 
> > Like the other lockup detector, I suspect we should skip it by default
> > in the selftests? Something like this:
> > 
> > diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> > index 368973f05250..32baddc2c85d 100644
> > --- a/tools/testing/selftests/lkdtm/tests.txt
> > +++ b/tools/testing/selftests/lkdtm/tests.txt
> > @@ -31,6 +31,7 @@ SLAB_FREE_CROSS
> >  SLAB_FREE_PAGE
> >  #SOFTLOCKUP Hangs the system
> >  #HARDLOCKUP Hangs the system
> > +#CSDLOCKUP Hangs the system
> >  #SPINLOCKUP Hangs the system
> >  #HUNG_TASK Hangs the system
> >  EXEC_DATA
> 
> Ah, I wasn't ware of that file, yes.
> 
> > > I'm not sure about the CSDLOCKUP name, but everything else I tried
> > > didn't seem great either:
> > > 
> > > * IPILOCKUP sounds like it's testing IPIs generally
> > > * SMPCALLLOCKUP and similar look weirdly long
> > > * SMP_CALL_LOCKUP and similar look different to {HARD,SOFT,SPIN}LOCKUP
> > > 
> > > ... and I'm happy to defer to Kees for the naming. ;)
> > 
> > It looks like it's only useful with CSD lockup detector? If that's true,
> > sure, this name is fine.
> 
> I think it's also useful for testing other things (e.g. RCU stall detection),
> so how about we go with SMP_CALL_LOCKUP, as that says what the test does rather
> than what specifically it can be used to test?

Yeah, that works for me. Thanks!

-Kees

-- 
Kees Cook

