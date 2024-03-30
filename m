Return-Path: <linux-kernel+bounces-125772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4922892BED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2E01C2139D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAE39AF9;
	Sat, 30 Mar 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJSGLSLA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C471C0DEF;
	Sat, 30 Mar 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814583; cv=none; b=rMZoabn8Pvy3/WtUdRbXOs+8zhGhQA/RSXa5wUkSA3iw1DvTYO9EY+NNqa1Wx0J3HqWF5YckGDm4wgss6j+NFPSS+h2w7/3MwxRaHtPm46fwYWoA2M9vcjv7RiYywjOJeA2PPwtFU3Jjo6+UcMWmpI2/vKlM6JAhG42vlE2l1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814583; c=relaxed/simple;
	bh=UluV6B2CNyYDGwjho9wujbbGinHQfPzIlXhBRj5/jwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSjZgNoXUwlQZ3YIF8tDweDnZY/Z/rNXWQJ5FcFyikeipYs3JsisERVBm3/F9Va4IIvMVanmNwvhVfWch71gxoE4t+7TK0zWmfxIjYOGzg3UiQd/71sx7Rrl7ayJ5u9VNjIzwYzVLzPa3BaF3TlyatDDkSUvddPYtRwYewVszGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJSGLSLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FA4C43390;
	Sat, 30 Mar 2024 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711814583;
	bh=UluV6B2CNyYDGwjho9wujbbGinHQfPzIlXhBRj5/jwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJSGLSLAib4ZkmpSDD8pBKfDUosNtVmyEkJK8+xeWQ2RVi+l2/uiyFl+ZHsK26w2U
	 sg/JDS8+wJ4obfWX5+RA0jLYrKoWy/69TMOHt8NNbHMZtVMkHNn1Z2pUxdRFSzdJkK
	 vVA8ONMxBpcbAY/3IuiPJx1zA6f8BCOpWj8nrAz3O+sVZhjJ1CMT8KqZOmnp24ZXko
	 Ujh4f2a5wNvRBBuguv9c7t/Xs5Fiut1pLT5B13kgANH6zi0BgtXTQNJ97kcxjmQnJ2
	 QkbJ2xinb1NCih5rlauTuDtUaTWelA9jhVrKB8k9/dY3YxvINFjmR3JcJTHfGgX5Kh
	 MtPcc26yM2Pmw==
Date: Sat, 30 Mar 2024 16:02:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood
 <lgirdwood@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, Support Opensource <support.opensource@diasemi.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] regulator: devres: add APIs for reference
 supplies
Message-ID: <20240330160246.6b74bd3b@jic23-huawei>
In-Reply-To: <8d98fab7-d73b-45c5-a46a-ace57907d25b@sirena.org.uk>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
	<ZgWw66OpLnLPdCn-@google.com>
	<043b347b-2652-4ffb-a8e0-954a89899ade@sirena.org.uk>
	<ZgXQcGlMiewRzki5@google.com>
	<8d98fab7-d73b-45c5-a46a-ace57907d25b@sirena.org.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 20:25:31 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 28, 2024 at 01:17:52PM -0700, Dmitry Torokhov wrote:
> > On Thu, Mar 28, 2024 at 06:18:32PM +0000, Mark Brown wrote:  
> 
> > > I don't follow what you're saying here?  What normal APIs are not
> > > available?  AFAICT this has nothing to do with a devm enable, it's a
> > > combined operation which reports the voltage for the regulator if one is
> > > available which would still be being added even if it used a devm
> > > enable.  
> 
> > You can not do devm_regulator_get_enable() and then call
> > regulator_get_voltage(), you need a new combined API.  
> 
> I think the theory here is that there are so many instances of this
> reference voltage pattern that it's useful to have a helper for that
> reason alone.

Exactly that - this is just adding a convenience function to
remove boilerplate.  -20ish lines of cut and paste code per
driver. 

Jonathan



