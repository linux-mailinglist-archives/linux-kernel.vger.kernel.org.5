Return-Path: <linux-kernel+bounces-144263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF788A43C6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727791C21BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022071353F4;
	Sun, 14 Apr 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM57ulN4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA81350FA;
	Sun, 14 Apr 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111864; cv=none; b=oenZY5jJ8YuA9ZcMa24q8RqY+9MCnSCOORAkjQqAREa7+7jtYjd9U72n3kXQuEHfy9w9UX3KbrSRbjGDQtJhIGzO+sWX5fbbu/pa8TN965CFwloNHtLFqpzTgiLKzO6iNh1i/YYBAb4Ljcpgrmp0gxvRUsACI6b6udRf7/Gle3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111864; c=relaxed/simple;
	bh=QeuvJ+PO6AYKR0nCyfG5EEKVnVTDcMMH6uM8m1EBOfw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kfqZRjkvrKghI5bsG/moP0yy3H+XLJ8S076Yh66lvYqOvdVzaMRxcBMF8r5tH85CnI0rU5/+MAkgVYsQw/wOhcbkc631g8u6WBRv8u70XAsa0kEmJ6aI+2VNBMFgsLoe1bOg9A607/jK424I84VfrJxoE48pvbWSPF6i9fjdoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM57ulN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96930C072AA;
	Sun, 14 Apr 2024 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713111863;
	bh=QeuvJ+PO6AYKR0nCyfG5EEKVnVTDcMMH6uM8m1EBOfw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mM57ulN4yzcL1i/NZgwZ45fXjHkAbnLyML+BgrzhXx+IT4kBGEWyDwfQAhA8Ic2uq
	 7Rod5VeVh0tMMOwX3sWkv9iKPnLyoIWrUGnkueRLAY0HiHIVzjeGvgBjYWb4gSq6Aj
	 7mVq3DQfr5fm+0F7k+RfDclBYgbT4SMO0ovRe1xty7yA8TjOdpAJVp0z45MiQPdmYX
	 UmzDE/x2PRT2Yp1Sq8Y3D4lwkouIcEath11hWYBW2umFx57D8v0uWr9bxdX9SuFYXe
	 UwLFvTyQ1aCZj/WdSH4KrOJT1KX7hXRjWLCbqvsgw4/ra1Tutk0LR5W4FoBNR111sH
	 PCIdyQCDulWVA==
Date: Sun, 14 Apr 2024 11:24:22 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: David Wronek <david@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20240414-raydium-rm69380-driver-v1-1-5e86ba2490b5@mainlining.org>
References: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
 <20240414-raydium-rm69380-driver-v1-1-5e86ba2490b5@mainlining.org>
Message-Id: <171311185909.3846249.17342729762911919460.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Raydium RM69380


On Sun, 14 Apr 2024 17:22:30 +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
>  .../bindings/display/panel/raydium,rm69380.yaml    | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.example.dtb: panel@0: False schema does not allow {'compatible': ['lenovo,j716f-edo-rm69380', 'raydium,rm69380'], 'reg': [[0]], 'avdd-supply': [[4294967295]], 'vddio-supply': [[4294967295]], 'reset-gpios': [[4294967295, 75, 1]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}, '$nodename': ['panel@0']}
	from schema $id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240414-raydium-rm69380-driver-v1-1-5e86ba2490b5@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


