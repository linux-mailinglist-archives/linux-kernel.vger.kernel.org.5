Return-Path: <linux-kernel+bounces-88868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD886E7C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C526B1F2684A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999A134CB;
	Fri,  1 Mar 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrVAiMut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DA282E3;
	Fri,  1 Mar 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315528; cv=none; b=qltlEIgUMOW2aOhwpgpXAL35yLHVeEsvqIPMrsbR+A/jDlCNEdOpS+/liXq1wna3d4qzycZ19uOjmSGBgndcn6i6iAseRKdJ72+ps+g4LWeTnOCH4L5Atk10PNRHbkBBIdG/9Aox+3CWMVXFOJ7ecS1xf8RjX7oYW6LgMdGE1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315528; c=relaxed/simple;
	bh=eXoHHqlUv+ocYn2KKFi9ZKx6ERkFZTOcTcwpaPExuVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mous2Oc8vdsGNGvamGwptYz3dzUtN81iwLBeByoURqGYI3Q+QI0NoCUVIk4zh0o1lEJTaldBrsMFIZZUUqfrkduqszcs9dw6gMSsC/nvYJb+eR+aA+SGRfxu+GgG0/OWbaWq62tiYUiWQbtpXJRfPb/mqzuVccmcZPNIE6Mwa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrVAiMut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F5CC433F1;
	Fri,  1 Mar 2024 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315528;
	bh=eXoHHqlUv+ocYn2KKFi9ZKx6ERkFZTOcTcwpaPExuVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrVAiMutZQezfJbYV3TUqSN6fprFMBM/1O47qXOKKky/Ym8cG43fYrDXnI20zLv9Y
	 QsmCu/fK9X4wOvuy+4yPp9VluDpMkz7ofkMzL3yOdJ9NcLCcBfEaXC7+4Gv8syNF8c
	 uum0r18Id0vJu2MzhTVjx61Ae0YDKUkbX9tm2dxc9Ioytz6248wDLtu/J3RTlC8vQ8
	 lSeYAd/4M0oFNwKaxqt71JBDnJIRw2s7xmgYy+POh4Cqmb4fKkFmYmQ0Y6R4o1Cuzc
	 nSTBS6113X6qTIdNteQH0POeFH46qJDiCnADQQ/UcWHenY+HUY3I4l9B3L8LmH3/de
	 vp+YA2GNpHBvA==
Date: Fri, 1 Mar 2024 11:52:05 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: dp-controller:
 document X1E80100 compatible
Message-ID: <20240301175205.GB2438612-robh@kernel.org>
References: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
 <20240222-x1e80100-display-refactor-connector-v2-1-bd4197dfceab@linaro.org>
 <a90dcd83-d158-4ec1-9186-0658c108afef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90dcd83-d158-4ec1-9186-0658c108afef@linaro.org>

On Tue, Feb 27, 2024 at 04:45:25PM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2024 16:55, Abel Vesa wrote:
> > Add the X1E80100 to the list of compatibles and document the is-edp
> > flag. The controllers are expected to operate in DP mode by default,
> > and this flag can be used to select eDP mode.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > index ae53cbfb2193..ed11852e403d 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > @@ -27,6 +27,7 @@ properties:
> >            - qcom,sdm845-dp
> >            - qcom,sm8350-dp
> >            - qcom,sm8650-dp
> > +          - qcom,x1e80100-dp
> >        - items:
> >            - enum:
> >                - qcom,sm8150-dp
> > @@ -73,6 +74,11 @@ properties:
> >        - description: phy 0 parent
> >        - description: phy 1 parent
> >  
> > +  is-edp:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Tells the controller to switch to eDP mode
> 
> 
> DP controller cannot be edp, so property "is-edp" is confusing. Probably
> you want to choose some phy mode, so you should rather use "phy-mode"
> property. I am sure we've been here...

phy-mode belongs in the phy node though. Not that you couldn't look in 
the phy node and see, but everyone likes all the properties they need 
nicely packaged up in their driver's node.

> Anyway, if you define completely new property without vendor prefix,
> that's a generic property, so you need to put it in some common schema
> for all Display Controllers, not only Qualcomm.

I'm trying to unsee what the driver is doing... Hard-coding the 
connector type and some instance indices. Uhhhh! I'm sure I'm to blame 
for rejecting those in DT.

I've suggested connector nodes in the past. More generally, whatever is 
attached at the other end (as it could be a bridge rather than a 
connector) knows what mode is needed. It's simple negotiation. Each end 
presents what they support. You take the union of the list(s) and get 
the mode. If there's more than one, then the kernel or user gets to 
choose.

Qualcomm is not the only one with this problem. Solve it for everyone...

Rob

