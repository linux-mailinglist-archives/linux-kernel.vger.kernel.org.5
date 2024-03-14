Return-Path: <linux-kernel+bounces-103890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BEC87C64C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE301F25B47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAA412B93;
	Thu, 14 Mar 2024 23:23:46 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490704F890;
	Thu, 14 Mar 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.240.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458626; cv=none; b=bIbgmzwbmW51kFXyVKbjenO95FFoumsvNnV9DLMXwoFcD1unO8GvIhAI+w3lS6vqTfFGnxc3URBp6188EcseOmaylT32XCUxtOuoRe/mS43T9qnMrg/wjxvqvwM2gC+hD9Pg0ZGLsZK1y3Tg3yKB2lvqAyYMDl2MZ+PdDQZIBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458626; c=relaxed/simple;
	bh=QCQRt6QFjp+EcBLspE+SST5PV3XYsmGPH97v7YTiZ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hf8ebnvHiSaLSUvXKtMlTmGye2chfoeijEfQ9ADhngyorp2FAYlHU/znDMkrrsB8+BW5iZ6IsG1MGN+5K8jbH0mbzxrmC200B/8usnyTj6niAeGWwiAPRHxntMb1/O1Vg1JLiKQT1u6DUdcJWJsOn/VEEwRL1AkufQqpWce2e9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de; spf=pass smtp.mailfrom=sraa.de; arc=none smtp.client-ip=85.214.240.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from c-bda170d5.017-30-6c756e3.bbcust.telenor.se ([213.112.161.189] helo=probook)
	by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1rkuQG-006Tj1-HP; Fri, 15 Mar 2024 00:23:40 +0100
Date: Fri, 15 Mar 2024 00:23:38 +0100
From: Sebastian Raase <basti@sraa.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sebastian Raase <linux@sraa.de>, marijn.suijten@somainline.org, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm630-nile: add pinctrl for camera
 key
Message-ID: <20240315002338.3fe1dcfc@probook>
In-Reply-To: <fc7bda50-279e-4afb-8c31-4fcda0e8b2ed@linaro.org>
References: <20240314200037.549206-1-linux@sraa.de>
	<fc7bda50-279e-4afb-8c31-4fcda0e8b2ed@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On Thu, 14 Mar 2024 21:37:30 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/03/2024 21:00, Sebastian Raase wrote:
> > Add pinctrl configuration for gpio-keys. Without this,
> > camera button half-presses are not detected.
> > 
> > Tested on discovery and pioneer.
> > 
> > Fixes: e781633b6067 ("arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)")
> > Signed-off-by: Sebastian Raase <linux@sraa.de>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> > index 87d0293c728d..5eedca6f288f 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> > @@ -90,6 +90,8 @@ cam_vana_rear_vreg: cam-vana-rear-regulator {
> >  
> >  	gpio-keys {
> >  		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&gpio_keys_default>;  
> 
> A nit: Please reverse the order: pinctrl-0 then names

All existing pinctrl definitions use pinctrl-names first, so I followed the existing file. Is this still okay?

> >  
> >  		key-camera-focus {
> >  			label = "Camera Focus";
> > @@ -635,6 +637,13 @@ ts_lcd_id_active: ts-lcd-id-active-state {
> >  		bias-disable;
> >  	};
> >  
> > +	gpio_keys_default: gpio-keys-default {  
> 
> Looks missing suffix (state) and test, so:
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

I did add the suffix and ran the test, and the warning is gone now. Sent an updated patch.

> Best regards,
> Krzysztof

Best Regards,
Sebastian

