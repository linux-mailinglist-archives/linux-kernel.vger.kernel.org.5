Return-Path: <linux-kernel+bounces-3015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733A816629
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81D028229E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA516AAC;
	Mon, 18 Dec 2023 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jffKOK2V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC056FA3;
	Mon, 18 Dec 2023 05:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CD2C433C7;
	Mon, 18 Dec 2023 05:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702878788;
	bh=poEh5cZ/XSxXESVgiGQc0+z0JA7uTX6Yt33bDiXj6eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jffKOK2VFuew5xQxKzNVYzj/N/t8nMhU8eEVGJ1OKgDQpLfxArLG5GrFTnz5fWNsT
	 bqJ17UR4eefIaW//mYcaKsvq0q/gR0iWOxl8RtpqqAN4LTnd6Yp/7Ehza1grVJkJ7o
	 qxUE/q/af94viPTJjJH/ZMKN5UICx141Y6KVTPFtuG71aDw5Kzd/PT4y74VxobPG4a
	 1MWLSWA/rW7lzUfdlC1RiC1WKwQAucjnyZ9mE09evVFAWa2CL/QwDtNt02wmdHt87o
	 /cCUN0qB/mCGrsKeA0K8UdeghPW0kcOmhcu0wMnNmftRenMeT+dMmjHW/IfS6uOmVu
	 TKHxFMYvtsJkQ==
Date: Mon, 18 Dec 2023 13:40:33 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v2 0/3] riscv: rtc: sophgo: add rtc support for CV1800
Message-ID: <ZX/bUfSS1+32skCM@xhacker>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>

On Sun, Dec 17, 2023 at 07:09:49PM +0800, Jingbao Qiu wrote:
> This series adds rtc support for Sophgo CV1800.
> 
> Changes since v1
> - fix duplicate names in subject
> - using RTC replace RTC controller
> - improve the properties of dt-bindings
> - using `unevaluatedProperties` replace `additionalProperties`
> - dt-bindings passed the test
> - using `devm_platform_ioremap_resource()` replace
>   `platform_get_resource()` and `devm_ioremap_resource()`
> - fix random order of the code
> - fix wrong wrapping of the `devm_request_irq()` and map the flag with dts
> - using devm_clk_get_enabled replace `devm_clk_get()` and
>   `clk_prepare_enable()`
> - fix return style
> - add rtc clock calibration function
> - use spinlock when write register on read/set time
> 
> Jingbao Qiu (3):
>   dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
>   rtc: sophgo: add rtc support for Sophgo CV1800 SoC
>   riscv: dts: sophgo: add rtc dt node for CV1800

AFAICT, the rtc subsystem supports not only RTC function but also
power/reboot controller, so modeling the rtc subsystem as RTC only doesn't
match the HW. I expect a mfd here.

> 
>  .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  47 ++
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |   7 +
>  drivers/rtc/Kconfig                           |   6 +
>  drivers/rtc/Makefile                          |   1 +
>  drivers/rtc/rtc-cv1800.c                      | 400 ++++++++++++++++++
>  5 files changed, 461 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
>  create mode 100644 drivers/rtc/rtc-cv1800.c
> 
> -- 
> 2.25.1
> 

