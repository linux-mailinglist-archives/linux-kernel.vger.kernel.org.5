Return-Path: <linux-kernel+bounces-124379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA6891695
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E120B22249
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A72652F79;
	Fri, 29 Mar 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EV2OC1gk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F94206B;
	Fri, 29 Mar 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707402; cv=none; b=Z4aeEBTRfajrxigFJQ7t1cBulRlgKEYajaERJ3PSUNIXnjU7wxPCXwAwCBBCyL2Q4/wG+XbO1dqAe/f26Py7TADeMdLoHf4y9d4I0dek2S6xluqwKzsKZ6b1jxm9euS+kUpE+54oHH9aizfHrIbX2mbwIGKrnaW7etMWCJz9sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707402; c=relaxed/simple;
	bh=eJUsaNQv7T98264XySFMHS9OEJalA28Q98BCdfmUF7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgCZqgxvtEv+9JTczuJB9G/wYvOB0MziyVRwO0vUSov88gHfXYoMzIlQ/luAlKVtorBW2UKLpHPkbjiYUg1BYLjKn1/sPIkeSpFiwehX6DQT6cm9NuLusB1tnO9Rxq77H0OCbLuPRgW6YHS3nrYTAMjubWnJDSwc+qH9gfbksvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EV2OC1gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726E9C433F1;
	Fri, 29 Mar 2024 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711707402;
	bh=eJUsaNQv7T98264XySFMHS9OEJalA28Q98BCdfmUF7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EV2OC1gkpaeHVE6l5HD/Fjng4jnC0g1IX6U1N0To6fSRBFkrrKvKHDlo2uKPTeg5g
	 0vk0tz8KRPf5WD9EQlKRaxKd0YHbtsWl9SDD9A4k0CWyhMU6+XDLIHCydOh/r9fGDq
	 4+lasPYJ/M1ZXpC7YQpZVfAnhlJ2vYGC4v90TMfk=
Date: Fri, 29 Mar 2024 11:16:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
	stable@vger.kernel.org, alexandre.chartre@oracle.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH V3 RESEND 0/3] Support intra-function call validation
Message-ID: <2024032928-slit-tricky-cdd2@gregkh>
References: <20240327094447.47375-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327094447.47375-1-qirui.001@bytedance.com>

On Wed, Mar 27, 2024 at 05:44:44PM +0800, Rui Qi wrote:
> Since kernel version 5.4.217 LTS, there has been an issue with the kernel live patching feature becoming unavailable. 
> When compiling the sample code for kernel live patching, the following message is displayed when enabled:
> 
> livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
> 
> Reproduction steps:
> 1.git checkout v5.4.269 -b v5.4.269
> 2.make defconfig
> 3. Set CONFIG_LIVEPATCH=y、CONFIG_SAMPLE_LIVEPATCH=m
> 4. make -j bzImage
> 5. make samples/livepatch/livepatch-sample.ko
> 6. qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage -nographic -append "console=ttyS0" -initrd initrd.img -m 1024M
> 7. insmod livepatch-sample.ko
> 
> Kernel live patch cannot complete successfully.
> 
> After some debugging, the immediate cause of the patch failure is an error in stack checking. The logs are as follows:
> [ 340.974853] livepatch: klp_check_stack: kworker/u256:0:23486 has an unreliable stack
> [ 340.974858] livepatch: klp_check_stack: kworker/u256:1:23487 has an unreliable stack
> [ 340.974863] livepatch: klp_check_stack: kworker/u256:2:23488 has an unreliable stack
> [ 340.974868] livepatch: klp_check_stack: kworker/u256:5:23489 has an unreliable stack
> [ 340.974872] livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
> ......
> 
> BTW,if you use the v5.4.217 tag for testing, make sure to set CONFIG_RETPOLINE = y and CONFIG_LIVEPATCH = y, and other steps are consistent with v5.4.269
> 
> After investigation, The problem is strongly related to the commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool"),
> which would cause incorrect ORC entries to be generated, and the v5.4.217 version can undo this commit to make kernel livepatch work normally. 
> It is a back-ported upstream patch with some code adjustments,from the git log, the author also mentioned no intra-function call validation support.
> 
> Based on commit 24489321d0cd5339f9c2da01eb8bf2bccbac7956 (Linux 5.4.273), This patchset adds stack validation support for intra-function calls, 
> allowing the kernel live patching feature to work correctly.

Sorry for the delay, all now queued up.

greg k-h

