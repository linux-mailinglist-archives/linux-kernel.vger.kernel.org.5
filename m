Return-Path: <linux-kernel+bounces-40377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E883DF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678BB28A805
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CA1EB57;
	Fri, 26 Jan 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDzAzCuY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74F1EB20;
	Fri, 26 Jan 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287921; cv=none; b=NNQXnpl5LAZ//yPILjb0e98IQQUGqyW47v2tkmRxugMRU680cHMKb9o/bj7FlX8iUJQCSVSL0+ZY3sS+ZJW1sVpICiwlaIaDx3NxXlyUWoNamvDCEVtOpoozASMtOhXa6dcTpzGMu0vwVJbIs41ibvs/WQRJczC82TRAuPLNDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287921; c=relaxed/simple;
	bh=nNQGTQo9Sb3RzF1c8ofntwOpOKnw2X4VGOZwSryubLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/SFTwm3NVcyqm7IChHbQPnBePBOPndWTLkOiM61GT8QFV+44+Hi7UW3zcL97eOwSu0V0hdFo/sVlIRZGtKkqH5gZhBtjF5bhGbVommc6qoJlAGocox5pvcxp4+aWPd2J/Y5nMeCwahErThR/pcvgdX/uA7o8oWvDi49hXvtX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDzAzCuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB54C43390;
	Fri, 26 Jan 2024 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706287920;
	bh=nNQGTQo9Sb3RzF1c8ofntwOpOKnw2X4VGOZwSryubLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDzAzCuYKG0na84fU1IneS7KC2Jy9J4nvn0oyedtZmxrh8h2yoTSgLM7sDNRp80cz
	 rdPy1d9XU5rU/uiZJrleTvH88HJrAAXEZC25GI1rp3PNYnQoyvP0G3S/R33nImCA4k
	 L2FUyLXZ0bbkcM5rxaWDuH9YvHdRD4K3ZZbp0wkKfDxD4etyR+c/QuoIZnkaHdmC0L
	 grung8XQlx2CQtcvNiWWhoV7WaFKq7whQqZn4JkQCNFBQNYQrEx/vk1KkCb9gdrrLZ
	 LKDO7Amgmykf3hX6IiICJa0C/Tgvp3zxeJz0jld5Pv6cNeoZJRfoRerbS8ia9lPRhK
	 /C6a4M3m22aPg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTPR6-0000000008a-282y;
	Fri, 26 Jan 2024 17:52:13 +0100
Date: Fri, 26 Jan 2024 17:52:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Message-ID: <ZbPjPAyNnIurX4X5@hovoldconsulting.com>
References: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
 <20240126-x13s-touchscreen-v2-1-5374ccc9e10d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-x13s-touchscreen-v2-1-5374ccc9e10d@quicinc.com>

On Fri, Jan 26, 2024 at 08:41:38AM -0800, Bjorn Andersson wrote:
> Some I2C HID devices has a reset pin and requires that some specified
> time elapses after this reset pin is deasserted, before communication
> with the device is attempted.
> 
> The Linux implementation is looking for these in the "reset-gpios" and
> "post-reset-deassert-delay-ms" properties already, so use these property
> names.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> index 138caad96a29..f07ff4cb3d26 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> @@ -50,6 +50,12 @@ properties:
>      description: Time required by the device after enabling its regulators
>        or powering it on, before it is ready for communication.
>  
> +  post-reset-deassert-delay-ms:
> +    description: Time required by the device after reset has been deasserted,
> +      before it is ready for communication.

You forgot to remove the now obsolete comment from the HID driver that I
mentioned.

> +
> +  reset-gpios: true
> +
>    touchscreen-inverted-x: true
>  
>    touchscreen-inverted-y: true

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

