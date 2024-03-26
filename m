Return-Path: <linux-kernel+bounces-119485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8688C98D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6119FB23E92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2717543;
	Tue, 26 Mar 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlwDWIhG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CE4C65;
	Tue, 26 Mar 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471221; cv=none; b=QtGcwv7cDsLb0tX0/yAe8jCHhIiYCrF4H1v0a4Cjh86FhaQeWXrkZNoWpdQRsax2xcEniyJHZBXSo5X9CLPnUwQTvAGO+D/oNnm0i3VAHglgv6F6ITEbzQ4EDw8719vxkp2E10OpoeEkDkxD+StyFFaIOYnSCNHg5kT9KxTJeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471221; c=relaxed/simple;
	bh=XC0Tz6dQn+zWcj4znd4Z4Av2qID3+Ev9+nT4XPvELVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezQ78y8CrnTuhQNsaXz9/LA8Wx7Gs7DMyxRZD0VtPV4bgqmPO9pR9mcoQ9aEpLC0cTijZb309WLTlBzc64m30SCVIJdsJJDiNOeTdhlzbUqzf/ujU4t2ApLMOPIgJhpJwMWjaqn8I4WjtBFpIZLjmHX7TnBJdgAJ+OVeznKNpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlwDWIhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A758C433C7;
	Tue, 26 Mar 2024 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471221;
	bh=XC0Tz6dQn+zWcj4znd4Z4Av2qID3+Ev9+nT4XPvELVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlwDWIhGk1X6DatgL9hMCQWZnT5f6SsYdnXUNJbDcPgWfM6ioL/KN3Lrw4ZL3wVlg
	 KHHh3KQDD+nzNcEs7E2azywXTR1nwpcOSv1WZ85tJS/Z3TodPCThhGp5f6CN3FhLAu
	 V1v8FACzoJhg72vMO9jIgKvPr9Tb54Ct7cua0her++p0XtYS/+Jlo/ySWyMcnnB0BQ
	 6JXEsuGkM7/9DioVmzL5cPQlPuVRTj5BGMn5YEtFSVwHWx5GMPN7kSoEaB6MfuHH5K
	 ka3Vasxw9R03VjDqGirHNZ+nZYciU+KJM/wFpsedbtm+K4pK9dvvpUXJePa5MVHE3J
	 hzOA3uqFky21Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp9qe-000000006dF-2FhA;
	Tue, 26 Mar 2024 17:40:29 +0100
Date: Tue, 26 Mar 2024 17:40:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: add SA8540P gpucc
Message-ID: <ZgL6fE8bFx7H41kr@hovoldconsulting.com>
References: <20240326140108.21307-1-johan+linaro@kernel.org>
 <20240326140108.21307-2-johan+linaro@kernel.org>
 <a6fbbfd3-516b-4269-b4b2-611979b62fd7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fbbfd3-516b-4269-b4b2-611979b62fd7@kernel.org>

On Tue, Mar 26, 2024 at 04:59:43PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 15:01, Johan Hovold wrote:
> > The SA8540P platform is closely related to SC8280XP but differs in that
> > it uses an external supply for the GX power domain.
> > 
> > Add a new compatible string for the SA8540P GPU clock controller so that
> > the OS can determine which resources to look for.
> > 
> > Fixes: e60b95d2b687 ("dt-bindings: clock: qcom: Allow VDD_GFX supply to GX")
> 
> I don't get why adding new device support is a fix. Commit msg did not
> help me to understand it.

Yeah, perhaps I could have expanded on the problem a bit more here.

Hopefully it's clear if you look at the cover letter, but the commit
referred to above should have added a new compatible for SA8540P which
uses the new supply so that the OS can determine when it should try to
look it up and when it is required.

The Fixes tag can also be dropped, I admit this is not clear-cut.

> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > index f57aceddac6b..5b385e4976b6 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > @@ -28,6 +28,7 @@ properties:
> >    compatible:
> >      enum:
> >        - qcom,sdm845-gpucc
> > +      - qcom,sa8540p-gpucc
> 
> This looks fine and pretty trivial, but I really do not understand why
> skipping our list for automated testing.
> 
> <standard letter>
..
> </standard letter>

Spare me the rant. This was obviously a mistake from reusing and
manually amending a git-send-email command from shell history and
failing to notice that this series also should have been CCed the
devicetree list.

Johan

