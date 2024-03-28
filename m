Return-Path: <linux-kernel+bounces-123632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBF890C04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C7B2324B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814CA13AA4E;
	Thu, 28 Mar 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkTv1rFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765513A86A;
	Thu, 28 Mar 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659170; cv=none; b=G8Kt91Xc21zfAQzigp8o0Wv3EdkmC039Mgm8rsUNAIwXWrcNh8HTZl7+zxpcecp3Y8K2E/pcMBI9KxXpPQkMJAGN+IhykTAsrZQjpxbkvxu6BpTCRdIZEifd7jayZBZEgmjl/+phMTgGLZJlrp4Idv2xQegHT4Lcyshd1Ai53pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659170; c=relaxed/simple;
	bh=M9alpGSonvC9HQq088c3j8Jt1zhm8w+ga/H5dJYrQe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwI54G0YZol9UkjSVKv4fWUA8pwrlTmgmi7kybRtue1xmfKIs1gADVlzZw/L/459JcOPeR5nnB8J2Mc0I7PSpcHZepkuJmfHp7vzAPzI0HCM+Kz/ljWRcRAy0j6NAMgA3bCMzEPwMNAWtoij1VZOIrAMXdC75XNz0fOHSXO5Fd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkTv1rFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0769AC43394;
	Thu, 28 Mar 2024 20:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711659170;
	bh=M9alpGSonvC9HQq088c3j8Jt1zhm8w+ga/H5dJYrQe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkTv1rFJvYbq0ASv6+ZA/X/T9fbUnAVKggRTD4ISVPJI3XLJaE/ENHWXn0uOFgphW
	 gsgdgG8jSDEQQKLX8nzb+GV/LqtgJfPqfNDJXW1Xn5KvQGB86MdXWzzhVKZn+rLUgS
	 OdUXEb/lRPhsfeLTKPydek6xgxuiZoH8U/vmLpXddHCuGo0Z3Btaetplz4BYKdTkUl
	 TZmYiPg+HTg9i+Im20o52OZnRaw2oxbx5a6vZ3ODm/tOoPnF+oal3HeNnfVbzdhK7E
	 2Sn1+LDNgkotXphJ8oRsVUI19laBrBmkw4fBk1KNkNyYCzi74HoJwC6ClS/2ylgdhx
	 hMF+2NUMpslWA==
Date: Thu, 28 Mar 2024 15:52:47 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: msm: sm6350-mdss: document DP
 controller subnode
Message-ID: <20240328205247.GA324023-robh@kernel.org>
References: <20240328-sm6350-dp-v1-0-215ca2b81c35@fairphone.com>
 <20240328-sm6350-dp-v1-2-215ca2b81c35@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-sm6350-dp-v1-2-215ca2b81c35@fairphone.com>

On Thu, Mar 28, 2024 at 10:42:45AM +0100, Luca Weiss wrote:
> Document the displayport controller subnode of the SM6350 MDSS.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> index c9ba1fae8042..d91b8eca6aba 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> @@ -53,6 +53,16 @@ patternProperties:
>        compatible:
>          const: qcom,sm6350-dpu
>  
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,sm6350-dp
> +          - const: qcom,sm8350-dp

Just use 'contains' here with qcom,sm6350-dp. The full schema will check 
the order.

Rob

