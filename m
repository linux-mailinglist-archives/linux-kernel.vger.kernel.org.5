Return-Path: <linux-kernel+bounces-119506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99F88C9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BCD323194
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06E1CFBE;
	Tue, 26 Mar 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjbBzDRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF81CF8B;
	Tue, 26 Mar 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471707; cv=none; b=UzT1aASCCd8ngyab4y9HgOTbhkrdJWJFfeP8Vae3CvwapcjuHQN3GJgRiUC7OV0g4s2dfPdcUR5/UQcE3VC+VpFq2r2JyOeroQY9BNQgdexkfcr4d7rqVvxm3eWBkEFPlFObdWmwbinpvwgUynZplwAfOWUJzJ5HIip+/JNMGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471707; c=relaxed/simple;
	bh=AipqUP+M7Jnwp/SDpZmvtbFJFIMal7zQuQnaopnS11Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYBou/lNnm9bpK3tHvBEeqQVwqFUiEsF4/7cdhmuu+Et9Lnwq+SKegeknecPLWoD/cJlPGACirBDxcZq/sJQBL3hj6TD8WhfowaG2hj+W0enGyGZFzwu/DlaVLcqQ51peXW3ipGhOu9sIRoOkyceJuUM9nFDQ5MxANOu7ML0ZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjbBzDRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930D6C43399;
	Tue, 26 Mar 2024 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471705;
	bh=AipqUP+M7Jnwp/SDpZmvtbFJFIMal7zQuQnaopnS11Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjbBzDRzMkrc7jIyMo6ZXxhi0Pwi0Yzei7P3Ps+hJ8/LEK0nxJJ9qDfkKfsD95/U7
	 JPfhqGzZxNk74NoC+nefc9MsXe2Pwhh2MXbOStO9ZSCxCWFFOwEsVWAVbeYE3h4lvt
	 6TqvFn8yNaPv0oVy7mVO48vMyVbcjCjbH9fAjXXZOU1I/TLm362cCZmkDc9iu4v+GR
	 pzFjGjg++fc8G25DBOmreUpSDlsMEDYq0kDUB7PMLNhaHElz5Rz/E68pYcuBzcBuBl
	 HTiB3zHw7d/D9Hpd1EUEe0lwtZivw4gFON2LjlR58Iu2Szlq5R8uVmV1LFwwnkznJ1
	 UWLCQ5N9MrjmQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp9yU-000000006ed-0dnM;
	Tue, 26 Mar 2024 17:48:34 +0100
Date: Tue, 26 Mar 2024 17:48:34 +0100
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
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sa8540p: use sa8540p gpucc
 compatible
Message-ID: <ZgL8YnTEKjf83WdO@hovoldconsulting.com>
References: <20240326140108.21307-1-johan+linaro@kernel.org>
 <20240326140108.21307-3-johan+linaro@kernel.org>
 <af7ef0d4-031d-42ac-aad5-c8ce86deff96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7ef0d4-031d-42ac-aad5-c8ce86deff96@kernel.org>

On Tue, Mar 26, 2024 at 05:02:43PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 15:01, Johan Hovold wrote:
> > The SA8540P platform is closely related to SC8280XP but differs in that
> > it uses an external supply for the GX power domain.
> > 
> > Use the new SA8540P compatible string for the GPU clock controller so
> > that the OS can determine which resources to look for.
> > 
> > Note that a fallback SC8280XP compatible is added temporarily to avoid
> > any temporary regressions for sa8295p-adp.
> > 
> > Fixes: fd5821a1a83c ("arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8540p.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> > index 23888029cc11..3b31a9ea3492 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> > @@ -168,6 +168,8 @@ opp-2592000000 {
> >  };
> >  
> >  &gpucc {
> > +	compatible = "qcom,sa8540p-gpucc", "qcom,sc8280xp-gpucc";
> 
> This introduces new dtbs_check failures. Please fix the binding and drop
> the last patch in the series.

I know, and this is done on purpose.

I doubt anyone cares if the sa8295p GPU breaks for one commit in case
this series goes in through the same tree or even for a couple of RCs in
case they go in through separate trees.

But we recently had a similar discussion about a bluetooth fix and
whatever course of action I would have chosen here, someone is bound to
whine.

In this case I figured it was worth doing the extra work. But this is
just a temporary workaround as "qcom,sa8540p-gpucc" is not truly
compatible with "qcom,sc8280xp-gpucc" as only the former depends on the
external supply.

Heck, I even spelled it out in the commit message...

Johan

