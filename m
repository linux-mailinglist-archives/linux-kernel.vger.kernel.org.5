Return-Path: <linux-kernel+bounces-118988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2988C253
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CFF1C3F814
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAA16D1D7;
	Tue, 26 Mar 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdvHh9QT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E25C61F;
	Tue, 26 Mar 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456672; cv=none; b=DCqEyysTMvp+9CVRiU3L2wZzT3NI05050RJoNM8E8jiXAdx5jtgGAttW85f/f3a8V/BxTY2a5jrYXf1YeEyz779DdaW22ZYF1BWaTl+YSCJxiIzqItvChOp7qu1a6/8Ht9sREUamAjYnBS/tUHNGyqTFFH/gD6o58leZmYm9fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456672; c=relaxed/simple;
	bh=jd2gqZGgGgy6kOe5uqkgenkEPD/a17w2vZt2MhmvK+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0O9m/RHwsYsptaOSqn2WUACO8MB3nm+IF01EfgsqEe5GMmM49gbxB6vh5uxoXhBBGHN4VwwBc/tywqFYGWtQAzNbFQBxPh6Ia+D4GNlllXujVmE/gQN04xxdFXtcPTVUnTUT54l8G/n7D6okfbjruOvClZA3H7XBKHzr40h+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdvHh9QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0C4C433F1;
	Tue, 26 Mar 2024 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456672;
	bh=jd2gqZGgGgy6kOe5uqkgenkEPD/a17w2vZt2MhmvK+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdvHh9QTlaDYmFnILuuqqfgs/z3qoFKLwluyypCFC4a1ApnMMwFfMJFcAd9Xx14u7
	 VRPyOWG6TTEi9JxJLKw2ALE7Hr7OkBLsepwMrAzAEkNspqnac6BO99v2kNkfp1Oo54
	 PwqfoP26728U3My5ZZOOCI/4ayH+fjPwiuoyharpgY9NS5pZozqRQeJzEZNSHrNGeb
	 vFoS90SEjvtZWvb4wYj2Bog4qPQFVlUMUsmTOJjiJhqitrv06F6oZC660oCJedDKNH
	 2Oq/n8ScI5vErrRn+8siNJeQlSlX8FIsoTnCllaFwZrlZXRJbCz3KBCxCV8CAReQjp
	 6q+xbiPgMnqPA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp63y-000000005DZ-3apl;
	Tue, 26 Mar 2024 13:37:59 +0100
Date: Tue, 26 Mar 2024 13:37:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v18 0/9] Add multiport support for DWC3 controllers
Message-ID: <ZgLBpp4Dn7_Imxp8@hovoldconsulting.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326113253.3010447-1-quic_kriskura@quicinc.com>

On Tue, Mar 26, 2024 at 05:02:44PM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller which
> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS
> mode.
> 
> This change primarily refactors the Phy logic in core driver to allow
> multiport support with Generic Phy's.
> 
> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
> are HS+SS capable and 2 are HS only capable).
> 
> This series depends on removal of ACPI from DWC3 QCOM wrapper [1].

> [1]: https://lore.kernel.org/all/20240305093216.3814787-1-quic_kriskura@quicinc.com/

Just to be clear, this dependency is already in 6.9-rc1 and this series
is ready to be merged.

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

Johan

