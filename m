Return-Path: <linux-kernel+bounces-154807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474918AE147
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E2D2867B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79BC59B4D;
	Tue, 23 Apr 2024 09:47:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97EB55E45
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865658; cv=none; b=sM4ytEh5dWv87+TAzx3WFVQ5nXV9yjkvqUIhOTK4tGiong1joQ0LYlutOSIXNIyOYsJnQIaA74IJYr2ESQrZ/MlEMLwM5WUVFbRGtZIzsZYjQAOwCV0TCbo1GxSVqc4bjnpe/l2VDjSeste/4POAPxm9dlux3ychZVBJFmexmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865658; c=relaxed/simple;
	bh=o8f+brFbNNar+gNRDa+EC2wglP1NAfSvVEiv2tzucYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf3PcBmmi2Ya8Vpgk8hzR7cIjfhLEiaP8toXQg7r5hERyuHTStjucJdJGkjqZTKJsZTFxTVyw5SqmLDWkHhMVpW9LwhfLTL48Xv+0TE2lneuYKyIYIP7tWn8WaaNjQKAHOy6zO8AaDYLwl2zDoD+P6YIQxiFSR/boccCg9kT1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A1DE339;
	Tue, 23 Apr 2024 02:48:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A99F3F64C;
	Tue, 23 Apr 2024 02:47:33 -0700 (PDT)
Date: Tue, 23 Apr 2024 10:47:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH] lkdtm/bugs: add test for hung smp_call_function_single()
Message-ID: <ZieDsZclwUpzcaeI@FVFF77S0Q05N>
References: <20240419103452.3530155-1-mark.rutland@arm.com>
 <202404191434.5B051B5DC6@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404191434.5B051B5DC6@keescook>

On Fri, Apr 19, 2024 at 02:53:59PM -0700, Kees Cook wrote:
> On Fri, Apr 19, 2024 at 11:34:52AM +0100, Mark Rutland wrote:
> > The CONFIG_CSD_LOCK_WAIT_DEBUG option enables debugging of hung
> > smp_call_function*() calls (e.g. when the target CPU gets stuck within
> > the callback function). Testing this option requires triggering such
> > hangs.
> > 
> > This patch adds an lkdtm test with a hung smp_call_function_single()
> > callbac, which can be used to test CONFIG_CSD_LOCK_WAIT_DEBUG and NMI
> > backtraces (as CONFIG_CSD_LOCK_WAIT_DEBUG will attempt an NMI backtrace
> > of the hung target CPU).

[...]

> > I wrote this because I needed to guide someone through debugging a hung
> > smp_call_function() call, and I needed examples with/without an NMI
> > backtrace. It seems like it'd be useful for testing the CSD lockup
> > detector and NMI backtrace code in future.
> 
> Like the other lockup detector, I suspect we should skip it by default
> in the selftests? Something like this:
> 
> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> index 368973f05250..32baddc2c85d 100644
> --- a/tools/testing/selftests/lkdtm/tests.txt
> +++ b/tools/testing/selftests/lkdtm/tests.txt
> @@ -31,6 +31,7 @@ SLAB_FREE_CROSS
>  SLAB_FREE_PAGE
>  #SOFTLOCKUP Hangs the system
>  #HARDLOCKUP Hangs the system
> +#CSDLOCKUP Hangs the system
>  #SPINLOCKUP Hangs the system
>  #HUNG_TASK Hangs the system
>  EXEC_DATA

Ah, I wasn't ware of that file, yes.

> > I'm not sure about the CSDLOCKUP name, but everything else I tried
> > didn't seem great either:
> > 
> > * IPILOCKUP sounds like it's testing IPIs generally
> > * SMPCALLLOCKUP and similar look weirdly long
> > * SMP_CALL_LOCKUP and similar look different to {HARD,SOFT,SPIN}LOCKUP
> > 
> > ... and I'm happy to defer to Kees for the naming. ;)
> 
> It looks like it's only useful with CSD lockup detector? If that's true,
> sure, this name is fine.

I think it's also useful for testing other things (e.g. RCU stall detection),
so how about we go with SMP_CALL_LOCKUP, as that says what the test does rather
than what specifically it can be used to test?

Mark.

