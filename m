Return-Path: <linux-kernel+bounces-152883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631148AC5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02912B21618
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF54D5A5;
	Mon, 22 Apr 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be+2sgZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4C4AEFE;
	Mon, 22 Apr 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771618; cv=none; b=klxtUydSbd/s+NzBr4e5EzTaohNtguHHkNhixB9ZtnNJ5vf2G5HHC+TYwprWGJzu3VNV2uBHYhkcbmpVQ+27EAZjQDmrJFr1LHQl6X4H01i8H5UcrRuaSVXZseOm9Ej8vwnflvCrN8W6HOSSym9I5lk7rKREjoZlw7E/YOAoKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771618; c=relaxed/simple;
	bh=3p99fopQtEIZdwt4QoUoj1J66fCCoXwK2F+w8THHEDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US8REULLmLjnXah2y1JAa9QmN4eGzCwRdxGu45LwE7brA7AYKrcKsijNAZVrAyKCUlffTOBMgO2l50lu00EVh2lCH89p5GILD6BB/B9g95+CimeO6it9pjmHYIPv4SDQbH0wfMEYenx/vINOfDWyk9R3NC26u0RNhjzl9uw4SMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be+2sgZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24630C32782;
	Mon, 22 Apr 2024 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713771618;
	bh=3p99fopQtEIZdwt4QoUoj1J66fCCoXwK2F+w8THHEDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=be+2sgZyy0L9gj3jytR1FK4MPVcb9ZLAlfHqWiaDH7MC4Lv1TbfuZNnnQaeJXzSZv
	 VPHF9h4aN6Z2iBy+sngyZ1gUkYzcdWzXF2DDPdmyWuYre+Jj3UXzrlT8FyKu08X7rW
	 yS1r9jiHUi9nQktfDfFasCRtfbpQ312zdzaxS9UlKo0xZDtGtW41bSd/35A/izdQYu
	 x0t8G3zXHIHRm1t0r9bm6PF04q4jzxJWKPGKNKt02oE+lOrZaQcuIgjovS7XbdYYsP
	 dFoP1wc6+awLNV6Zi4orHWfIeQv1vRQGlmRIr1KuNv9/FlGhV+BREGyto0eZgAt+Eg
	 GPuUJSkueLFCA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ryoHc-00000000487-0cmS;
	Mon, 22 Apr 2024 09:40:12 +0200
Date: Mon, 22 Apr 2024 09:40:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v21 0/9] Add multiport support for DWC3 controllers
Message-ID: <ZiYUXCHGlUKSnXXM@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-1-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:52AM +0530, Krishna Kurapati wrote:

> Krishna Kurapati (9):
>   dt-bindings: usb: Add bindings for multiport properties on DWC3
>     controller
>   usb: dwc3: core: Access XHCI address space temporarily to read port
>     info
>   usb: dwc3: core: Skip setting event buffers for host only controllers
>   usb: dwc3: core: Refactor PHY logic to support Multiport Controller
>   dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
>   usb: dwc3: qcom: Add helper function to request wakeup interrupts
>   usb: dwc3: qcom: Refactor IRQ handling in glue driver
>   usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
>   usb: dwc3: qcom: Add multiport suspend/resume support for wrapper

Verified that the finger print reader on the Lenovo ThinkPad X13s works
with this series (and not yet merged devicetree changes). 

Not sure when or why, but the error message I previously reported seeing
during suspend is now also gone:

	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Thanks for sticking with it, Krishna.

Johan

