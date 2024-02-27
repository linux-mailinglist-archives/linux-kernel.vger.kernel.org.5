Return-Path: <linux-kernel+bounces-83608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B59869C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA52913C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667E1F606;
	Tue, 27 Feb 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA+RoLAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231ED1C6B0;
	Tue, 27 Feb 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051529; cv=none; b=T2nKbOtFIDunUSPMwhWZpK5PWaYwibD+QP7gk8ikntcljUDCoUHAuoYutrQQIWBzP7vyTnhAFVO/77gNl8h4p3D/DMihUUS5x/UaGcOWyov+hTkXhU96U4wmH/NnlXG12ekLnSTLxx3DfcJ+oQetKZ0cbIffA1UDV/tK+4UTjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051529; c=relaxed/simple;
	bh=RVOmV7opcG+gfaoaK7ZieDs/a184WdxcY859DX5OCug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRRIIyriPV7rnekSguAALYZW3RMeXIlLk2ybQZVK9lxfU9RfAIbiX1owwQ5Ys9XywbqgJ2SrxtFzdrNanJ0i0+6eGEklXfxw59TNIQVDzsXd1rntuRj1yEAybKGLqti8fuKCJ0RvdjUid0GqHRJjOQk6niFtmkb9SX145HAAjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA+RoLAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63488C433C7;
	Tue, 27 Feb 2024 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051528;
	bh=RVOmV7opcG+gfaoaK7ZieDs/a184WdxcY859DX5OCug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mA+RoLAB5nO4H9jo6BOsampkp8zSGaN6IXadt41IaJ5KW3HoWIhooPDFMSy1Znsw5
	 4Ijj59HZfiLZ7T7Sufm2wwUwYqwXUIxrs0JD76I33pm+B5US4URMQkY1BqHRd4ikSb
	 chkfhAE4TWq1BKv6zpaqQb/cz9GjCYj9diquUmFS/y1JsOolrNuWmabTqJ1pC3bYm2
	 X+vcW3aIjTT/qNtn4f+vy25KJG09gLkyx7h70f0m+V8SXmJLKYJMv0YkDY9ugsjU0u
	 a4ZXXgYBscERlYOWbuCTUw/g6jHEax7H3u+QOj+BfCTW3vcIhoqfoRIDDGsIVJdF3L
	 NoiYkXFTfvG3g==
Date: Tue, 27 Feb 2024 10:32:05 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 00/12] arm64: qcom: add and enable SHM Bridge support
Message-ID: <wgvkhq3ljjrwnqiwojvwvjuiiy4o5gfx5bctaklvmpe3v6pusr@6rwtg5npr3au>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <htsty5siakcu2nxxapiuq7pgs27tjwkb3yxgmfs3bonsl6kylw@joa2viypstoa>
 <98dea91a-5d2b-432e-8949-46179c824d1b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98dea91a-5d2b-432e-8949-46179c824d1b@linaro.org>

On Mon, Feb 19, 2024 at 03:17:24PM +0000, Srinivas Kandagatla wrote:
> On 17/02/2024 19:58, Bjorn Andersson wrote:
> > On Mon, Feb 05, 2024 at 07:27:58PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > 
> > > We've established the need for using separate secured memory pools for
> > > SCM and QSEECOM
> > 
> > Where has this need been established, what is the actual problem you're
> > solving with this series?
> 
> SHMbridge will restrict the amount of memory that TZ can see, making system
> more secure.
> 

Then tell me this in the cover letter and commit messages.

> Need for having different pools makes this more scalable overall, so that
> different usecases can run seamlessly. ex: loading a TA and SCM calls.
> 

How is it more scalable to give each "client" a chunk of 256KB instead
of them sharing a pool of ~4GB memory?

> > 
> > Does SCM and QSEECOM, as it's implemented in the kernel today, not work
> > satisfactory?
> > 
> > > as well as the upcoming scminvoke driver.
> > > 
> > 
> > Is smcinvoke driver upstreaming blocked by not transitioning the scm
> > driver to a "secure memory pool"?
> > 
> > Is this happening now, or do we need to merge this series when that day
> > comes?
> 
> SMCInvoke development is happening now, I see no reason for this patchset to
> wait for it.
> 

As presented, I see no reason to merge this series.

> This series can go as it is for two reasons.
> 1> improves system security in general
> 2> Hardware Wrapped key support patches also use this which are also in good
> shape and tested, ready to be merged.
> 

Then tell me this in the cover letter and commit messages!


It's not sufficient that I happen to know the answer to these questions,
neither community nor maintainer should not have to guess these things.

Regards,
Bjorn

