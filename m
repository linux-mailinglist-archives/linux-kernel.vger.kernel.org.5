Return-Path: <linux-kernel+bounces-140562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6128A1635
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A307DB25A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9F15351F;
	Thu, 11 Apr 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxPhPelt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8E1534FD;
	Thu, 11 Apr 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843121; cv=none; b=ckVP3vogG0fNdmgmgvWvWhjyKheG7WGB7mN36F7GghkF4P63rcdYi6chpdWIZMpSLw4fRtrDjYm5nHa4EjYYk5WPvc1yNeuzfL3OMRVhbzyx1avDIIhVdLrfGi/AftXWXUic4/uFUGYLN5pTOCphCMlzxzx3c7Q0FYCZTUjt6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843121; c=relaxed/simple;
	bh=f9cPCcq92aSfsEKclODGv/6nz5NfLQpRnZ5W4Wc0m5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH6nuo1JNPEeO/jJJaKWTQPv3su+gtWGgsnJqko8RLlx8NhC2smU4qp6FV8mROJvFKDPzOHuoFTCo4n9BZB3Fs9NFYiRkJlPgmL+13KhwJdx6fHk1H0iRjlvZxumA6V+i4PJdN0RxkCD0PTEwcVCKKoqxpXrrhvh2OiUFnkgZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxPhPelt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38571C4AF68;
	Thu, 11 Apr 2024 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712843120;
	bh=f9cPCcq92aSfsEKclODGv/6nz5NfLQpRnZ5W4Wc0m5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxPhPeltbYuybxhCKfwh1yRB60gE8jF+44ZnoMo4j5obfuGMsbIqB9EN1sBBb7Nn+
	 nMFa78797hOjvBy2lZRfH+5sM7owPp/Gyfwz0+67SklCDII0UYBjIdRPpPBeY4kATS
	 addmdIkS+/6PmGqOoBFrHhbvfJuQ25y/rL97aaYTK65DHadelPLR8A98+xkwttctdC
	 5dHD6x2o6RhNaXHAGFtlywCmHMCllJBUGIO0JaNU6h4672Nv3HBsdXNcvrVSiANZbw
	 Q4ezFoZ5/axaKjG4HRHC6CfipZozJ3qFn68pfQaLKzyKuVge9t9NQ1iq/xiqL6XlHE
	 7RokPqaLzbnlw==
Date: Thu, 11 Apr 2024 14:45:14 +0100
From: Lee Jones <lee@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: andy.shevchenko@gmail.com, pavel@ucw.cz, vadimp@nvidia.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] devm_led_classdev_register() usage problem
Message-ID: <20240411134514.GK1980182@google.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
 <20240321181133.GG13211@google.com>
 <9bfd0ccc-a5d8-446c-a08c-bbc36a4d66eb@salutedevices.com>
 <20240322104303.GN13211@google.com>
 <e3dd3ed1-02dc-447c-9fdd-9d8193a25e5f@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3dd3ed1-02dc-447c-9fdd-9d8193a25e5f@salutedevices.com>

On Fri, 29 Mar 2024, George Stark wrote:

> Hello Lee
> 
> On 3/22/24 13:43, Lee Jones wrote:
> > On Fri, 22 Mar 2024, George Stark wrote:
> > 
> > > Hello Lee
> > > 
> > > On 3/21/24 21:11, Lee Jones wrote:
> > > > On Thu, 14 Mar 2024, George Stark wrote:
> > > > 
> > > > > This patch series fixes the problem of devm_led_classdev_register misusing.
> > > > > 
> > > > > The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> > > > > is used then led_classdev_unregister() called after driver's remove() callback.
> > > > > led_classdev_unregister() calls driver's brightness_set callback and that callback
> > > > > may use resources which were destroyed already in driver's remove().
> > > > > 
> > > > > After discussion with maintainers [2] [3] we decided:
> > > > > 1) don't touch led subsystem core code and don't remove led_set_brightness() from it
> > > > > but fix drivers
> > > > > 2) don't use devm_led_classdev_unregister
> > > > > 
> > > > > So the solution is to use devm wrappers for all resources
> > > > > driver's brightness_set() depends on. And introduce dedicated devm wrapper
> > > > > for mutex as it's often used resource.
> > > 
> > > ...
> > > 
> > > > >     locking/mutex: introduce devm_mutex_init()
> > > > >     leds: aw2013: use devm API to cleanup module's resources
> > > > >     leds: aw200xx: use devm API to cleanup module's resources
> > > > >     leds: lp3952: use devm API to cleanup module's resources
> > > > >     leds: lm3532: use devm API to cleanup module's resources
> > > > >     leds: nic78bx: use devm API to cleanup module's resources
> > > > >     leds: mlxreg: use devm_mutex_init() for mutex initialization
> > > > >     leds: an30259a: use devm_mutex_init() for mutex initialization
> > > > > 
> > > > >    drivers/leds/leds-an30259a.c | 14 ++++----------
> > > > >    drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
> > > > >    drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
> > > > >    drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
> > > > >    drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
> > > > >    drivers/leds/leds-mlxreg.c   | 14 +++++---------
> > > > >    drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
> > > > >    include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
> > > > >    kernel/locking/mutex-debug.c | 11 +++++++++++
> > > > >    9 files changed, 122 insertions(+), 74 deletions(-)
> > > > 
> > > > Doesn't apply to v6.8.
> > > > 
> > > > What base was used for this?
> > > 
> > > I've just pulled git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > and v7 was applied cleanly. linux-next is ok too.
> > > 
> > > v6.8 is lack of recent patch 6969d0a2ba1adc9ba6a49b9805f24080896c255c
> > > v7's patch #2 depends on it
> > 
> > No problem.  I'll wait for v6.9-rc1.
> > 
> 
> Just checked the v7 patch series on released 6.9-rc1 and it's applied
> cleanly. If anything i can help please let me know.

It applies, but doesn't seem to build:

make --silent --keep-going --jobs=8 O=../build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- 'CC=sccache aarch64-linux-gnu-gcc' 'HOSTCC=sccache gcc' allmodconfig
make --silent --keep-going --jobs=8 O=../build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- 'CC=sccache aarch64-linux-gnu-gcc' 'HOSTCC=sccache gcc'
ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-an30259a.ko] undefined!
ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-aw200xx.ko] undefined!
ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-aw2013.ko] undefined!
ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-lm3532.ko] undefined!
ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-mlxreg.ko] undefined!
make[3]: *** [/builds/linux/scripts/Makefile.modpost:145: Module.symvers] Error 1

Did you forget to export it?

-- 
Lee Jones [李琼斯]

