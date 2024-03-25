Return-Path: <linux-kernel+bounces-116629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965088A199
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1649C1C37B80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733120310;
	Mon, 25 Mar 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE/qlgkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44504153565;
	Mon, 25 Mar 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355510; cv=none; b=ODFj89dfArOnWQHEMtsz6lD8r5ww1Ja+qwKlf/2T1Bv7GKClK3WiQjxNHXeKo7cRk1IaDIMjqhyllWjxxrDNCVJDND6HzHrEzAvs5sfdVIR3YFXPrzCMFK+PK1K8ytAAbGJWQn5IHaIqCYyqnfONp2GAKBiUORuWSVYDUi3K2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355510; c=relaxed/simple;
	bh=VO7AN01rHdiWwam/sZMD7D9zeSM3KWBzcy0Oq/ITPjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umVOsbxa3nNs2Og/n/NUgzyFrsRizlTzrdn7+LIVa+ifrvhLAC1IQ7rtH+8uPwM4xqMtaVbXipz+9mB1TBYIDVEai+BQOYJW4xxTY0XBXJck8ifXIEdAcYCzB6vcy99ZpS7zYsW+L2bmkQn2fNIDMI5yWE6X0wSKkrCoXBJpRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE/qlgkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA13C433F1;
	Mon, 25 Mar 2024 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711355509;
	bh=VO7AN01rHdiWwam/sZMD7D9zeSM3KWBzcy0Oq/ITPjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uE/qlgkn/5Kq3PRzCzI2HOOdIXEspU7f/S8yEEIOGNRuzPmtOTTsjrjEmyoQ2w7Jn
	 dQnjwUNXrsKfZkj49+fqlqcmLPhYdOEg+L+D3I/eJEGd4TKABOOvpse3EUtZyCB5a8
	 uWTp8d5i+Kp0lJ6mTxEaEnlnrk1Wl3RjArSjtQU9fchHt08PfAOKTuUWuiZh4JCvmx
	 ijy2iiDZblGJ3QVv8zyOmznJCqmEceyeAzgojUQ4BUv1b+GH2yyBhtxHAq4+orXIqj
	 XNUXuPojfPZCU1kqAQ+HRe+WGcxCW6bln2mZTErY6LIKupqczCqFfgt1Kksa5UMqxg
	 C6x7KBNcMaSaA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rofkJ-000000002xB-3WZA;
	Mon, 25 Mar 2024 09:31:55 +0100
Date: Mon, 25 Mar 2024 09:31:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Message-ID: <ZgE2eyJ3q4gqd2VU@hovoldconsulting.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
 <20240125-sa8295p-gpu-v4-2-7011c2a63037@quicinc.com>
 <Zf25Sv2x9WaCFuIH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf25Sv2x9WaCFuIH@hovoldconsulting.com>

On Fri, Mar 22, 2024 at 06:00:58PM +0100, Johan Hovold wrote:
> On Thu, Jan 25, 2024 at 01:05:08PM -0800, Bjorn Andersson wrote:
> > The GX GDSC is modelled to aid the GMU in powering down the GPU in the
> > event that the GPU crashes, so that it can be restarted again. But in
> > the event that the power-domain is supplied through a dedicated
> > regulator (in contrast to being a subdomin of another power-domain),
> > something needs to turn that regulator on, both to make sure things are
> > powered and to match the operation in gdsc_disable().
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/clk/qcom/gdsc.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 5358e28122ab..e7a4068b9f39 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
> > @@ -557,7 +557,15 @@ void gdsc_unregister(struct gdsc_desc *desc)
> >   */
> >  int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
> >  {
> > -	/* Do nothing but give genpd the impression that we were successful */
> > -	return 0;
> > +	struct gdsc *sc = domain_to_gdsc(domain);
> > +	int ret = 0;
> > +
> > +	/* Enable the parent supply, when controlled through the regulator framework. */
> > +	if (sc->rsupply)
> > +		ret = regulator_enable(sc->rsupply);
> > +
> > +	/* Do nothing with the GDSC itself */
> > +
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
> 
> This patch (and series) is now in mainline as commit 9187ebb954ab ("clk:
> qcom: gdsc: Enable supply reglator in GPU GX handler") and appears to be
> involved in triggering the below lockdep splat on boot of the Lenovo
> ThinkPad X13s.
> 
> Adding Ulf and the MSM DRM devs as well in case I blamed the wrong
> change here.

I've now verified that applying this series on top of 6.8 also triggers
the lockdep splat even if it is possible that it only exposed an
existing issue.

This is still a regression and also prevents using lockdep on these
platforms, which can lead to further locking issues being introduced
until this is fixed:

#regzbot ^introduced: 9187ebb954ab

Johan

