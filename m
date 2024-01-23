Return-Path: <linux-kernel+bounces-36046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3534839AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C2B1F2B907
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7853BA;
	Tue, 23 Jan 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4iu9DrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42513ACC;
	Tue, 23 Jan 2024 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043480; cv=none; b=pRu8axL0szoyqUS6PSDODrHehxH6jGaGwrzahuQEAElc0ffY2VBfpE1JY1kM+GMUDgjByD2mHSb6hM5bFjqufBAWKcQMmRHob2bwcdQwzU+S49xMvaGBHv1UbQ6cbWjqzSTiC/d15pHOKm1AudU+DZ0/UyN9aV6Bu88f/9Mce+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043480; c=relaxed/simple;
	bh=beniaoOVcxeR7gRHaBkA7uCAdkIPvUsqVHb1E+XI+bo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LEhH9gvah9958AvjViJ3Ln15h3D58Z8cUbBGTQuuUVZDGtMHP8q4eETKJsd3y1Cy5VlJP3x6k5p5jtFPJSyxz/qRFM0jW3knsJroNZM436zFZMRHtpRfK6Erau+f2egcnMSOk/NF/lYBwaJ2dLR2Y/LEuGihqsWJuYwywP2b+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4iu9DrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C03C433C7;
	Tue, 23 Jan 2024 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706043479;
	bh=beniaoOVcxeR7gRHaBkA7uCAdkIPvUsqVHb1E+XI+bo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T4iu9DrUuiqMfbn+rWnnPjIF5OPJbWwQEXfwwpWsvqQbm3K3atui4RJT7B6uuhib8
	 8tlCyTXPYKKrBaQN/JshRYeX5/SbNHQLOKB7CWX8S4t8L2kX9EGx2Afwr/7+0mSWDl
	 cwLlUnp71H0VE9H9xQpzDPKL4GkDf/DCyorNpXlr/0tDPNVt39B7vR5oerfqiUULeB
	 hEzDp2h+bzGr2pToW1C5vIDY5JLkv6CQr3y0d//xa9GPRfWJfjJ0oHiIcFqWQCzGSn
	 59cIktQNBGJxZ8g4w+yq4nxxZJB+ye7y4jYWTViOWnhpcD89EIp39OzCUc0ve7On6J
	 Ni5i1pgxVqZJQ==
Date: Tue, 23 Jan 2024 14:57:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240123-mbly-clk-v3-3-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-3-392b010b8281@bootlin.com>
Message-Id: <170604347681.1901901.3923700915063893929.robh@kernel.org>
Subject: Re: [PATCH v3 03/17] dt-bindings: pinctrl: allow pin controller
 device without unit address


On Tue, 23 Jan 2024 19:46:48 +0100, Théo Lebrun wrote:
> Allow a pin controller device to have no address, therefore no unit
> address.
> 
> The previous $nodename was enforcing a unit address, but
> scripts/dtc/checks.c enforced that names with unit addresses have reg
> or ranges:
> 
>    Warning (unit_address_vs_reg): .../pinctrl@0: node has a unit
>    name, but no reg or ranges property
> 
> Fix pinctrl.yaml to adopt a (pinctrl|pinmux)(-[a-z]+)? node name when
> neither reg nor ranges are required. Use [a-z]+ to avoid conflicts with
> pinctrl-consumer.yaml.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl.yaml | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/pinctrl/pinctrl.yaml:45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
/Documentation/devicetree/bindings/pinctrl/pinctrl.yaml:47:8: [warning] wrong indentation: expected 8 but found 7 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240123-mbly-clk-v3-3-392b010b8281@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


