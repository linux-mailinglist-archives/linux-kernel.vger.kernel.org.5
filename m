Return-Path: <linux-kernel+bounces-66246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4785590A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE841C221E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B54A05;
	Thu, 15 Feb 2024 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8kV5y6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A84691;
	Thu, 15 Feb 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707965799; cv=none; b=PcFsfsZ7KoKjnaf3tIhjAkccfn1ccThqjufdhKv01BikqmjgmcGIXvPPMMG/5HHDzwtfn9tgJc4T3QI6P4Vlt9Xrac1vkDAsP+GVnFagk4u8b0kLv0d9zxeIP5inv+V7KKcP8C5AJYdASmp2gB1Bx/UqgdqEUw+myVGe2V0B0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707965799; c=relaxed/simple;
	bh=yvs/U+kUCiyR07Pib58VdwJ/XOtbMmpXBVFg4jf9vAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYQk2wcAUOpesBMoyNDiwtFWlbx6I4rtUffv9ZPtBFkDis90ggiKayKJOOhRbgXMgKQaLcNu4DRqLrbCzGwWJZy4xuDX1sIHFgS0s9aebS348E7G8d5IeFKO0ulKYyBuMwBYoduZctdU2GAhY+CA4ni6XmP9eCwM1gfeoVEA5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8kV5y6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A3AC433F1;
	Thu, 15 Feb 2024 02:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707965798;
	bh=yvs/U+kUCiyR07Pib58VdwJ/XOtbMmpXBVFg4jf9vAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8kV5y6kZ/Vq0xa+v6cnaIZ5mCEfJLuZhxYRRbS4uom1kKgd4IgZmx+P2paZdUoD9
	 bBIP2NcGelcd8lU6kzotI/tmMaV0o4//INI6K64AdimC6Re9I6uwV4EjyZZfNSCh3e
	 OA/SA7mUUyH5uh6CqN5PjG8XEeHh/TvBq2uGd7FZ8GCkPnZdRmp6P38GFDxTwmY6sF
	 Z1N3C1/HSiRKP4ckhs4Kdo97oPTlZzLT/geHtRTEEOucJi19W3eISooC4qLbJuGsBk
	 cek5KQZPrMXNJaAxPyyNIyynL11Vl6l23EGS6emrDBZnsUGbjRUZ3FRl/AhMQMoen9
	 a0lXiOTa3/75w==
Date: Wed, 14 Feb 2024 20:56:36 -0600
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: display/msm: Document the DPU for
 X1E80100
Message-ID: <20240215025636.GA2577530-robh@kernel.org>
References: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
 <20240214-x1e80100-display-v2-2-cf05ba887453@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-x1e80100-display-v2-2-cf05ba887453@linaro.org>

On Wed, Feb 14, 2024 at 11:24:31PM +0200, Abel Vesa wrote:
> Document the DPU for Qualcomm X1E80100 platform in the SM8650 schema, as
> they are similar.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> index a01d15a03317..c4087cc5abbd 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> @@ -13,7 +13,9 @@ $ref: /schemas/display/msm/dpu-common.yaml#
>  
>  properties:
>    compatible:
> -    const: qcom,sm8650-dpu
> +    enum:
> +      - qcom,sm8650-dpu
> +      - qcom,x1e80100-dpu

Patch 1 uses this in the example, so this patch needs to come first.

>  
>    reg:
>      items:
> 
> -- 
> 2.34.1
> 

