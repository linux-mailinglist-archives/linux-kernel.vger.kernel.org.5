Return-Path: <linux-kernel+bounces-150101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF528A9A65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1B3283623
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA45A15FD13;
	Thu, 18 Apr 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgVbWLpd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6937165;
	Thu, 18 Apr 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444567; cv=none; b=l41AdFTdwVQTVXVVdp2idOmR+C03RdriBMZ6kaVRuUJ2a1v+WtFYwBCI7wI02xfayYrC1fSeqsWwiE3Syh94e+OSzOOErmgrmQfqUpgh9wSZRq0RBkQ3XModZchYm7gdZO7fHFzjy4S7lbJ3gxjwg+ucnnKXpZlojrAEnp2dLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444567; c=relaxed/simple;
	bh=G8iIaDSoTzX8WwprmZzksy2cT8VoIMe2ObbDA5sfRks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/GxTvu47HWIJ1FXqEtCPEiCIPvhm3ZzVIMe+0Sd+oR6CynWaxjv1pr16PuPmfCKJkqi5s3ADH+9iE5+dpb46sVXLkwK6CGm7jKnsOn0AbHw1YMWyPgZ1Mu8C3vRLEZ8N9THPMDpFfGXV6tINcAMg1iQH2vNmQXtkjTIg16CLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgVbWLpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA4AC113CC;
	Thu, 18 Apr 2024 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713444566;
	bh=G8iIaDSoTzX8WwprmZzksy2cT8VoIMe2ObbDA5sfRks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgVbWLpdSqyUhBogIz8YhMvuKkPpyMVD064SsnwwAWjiH81oDUoAKnL2bTdpYIj7D
	 yjXVcw1l+dhS1QAwLtRs+Q3S9AekJoj7ymUKvL7wsh7mo2WVxMSJwGuIpvOsVz/nwW
	 NNpU9W5T3WM5LNCf3Qn9J1G+YgLSND354UbUm4MqPvsB9Z03+pBIKHHNt6KoWCR5tC
	 eZb/7PuULVOfnmgZLzEQWtaQdDB8bpIem3KkHKDsnKPadqeiFVZ6GtrM5qbJq2tB3n
	 xeLQ8mwZD2ZP37MfBy7HtW728a4DhWHAdnpbVubVJF9oa9uHs6Ravx25tPFHi7g2Zn
	 YGTuLDfsn9g+w==
Date: Thu, 18 Apr 2024 07:49:23 -0500
From: Rob Herring <robh@kernel.org>
To: David Wronek <david@mainlining.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, ~postmarketos/upstreaming@lists.sr.ht,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	phone-devel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add Raydium RM69380
Message-ID: <171344451492.997671.11196384805681693246.robh@kernel.org>
References: <20240417-raydium-rm69380-driver-v4-0-e9c2337d0049@mainlining.org>
 <20240417-raydium-rm69380-driver-v4-1-e9c2337d0049@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-raydium-rm69380-driver-v4-1-e9c2337d0049@mainlining.org>


On Wed, 17 Apr 2024 18:29:33 +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
> Note:
> Depends on commit 48a516363e29 ("dt-bindings: display: panel: add common dual-link schema")
> ---
>  .../bindings/display/panel/raydium,rm69380.yaml    | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


