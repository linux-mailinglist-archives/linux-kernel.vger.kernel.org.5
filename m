Return-Path: <linux-kernel+bounces-152810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DCF8AC497
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43613282888
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2C487B6;
	Mon, 22 Apr 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKRwIrma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F528482DA;
	Mon, 22 Apr 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769017; cv=none; b=HIKB6/Ewk/HM/B2WqO3SAVy3sQUfJmc/0mLDvEsm0wJkcFWLq1oqke05SdIQhPtcL9lbd2JFYw7kfUZULrratN1UZU2N8arcdGDdhmZQ3GqSgIy+oWlu/AnX8b/NqvK1qjpEbXxYJw20B71YO0VGBMHu0bi7duW+PNiUUGyk4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769017; c=relaxed/simple;
	bh=hzRcfa23v/DUT+2N5bmwRSQG9X1L2rHH3P2NVUnJhzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeUXJfrYWGAFfMqZhjbsfzzFkuKOoE3R5PheKMbCfMA9yeEVWdrqZYKVwnX+4m2ndR19PMWnTXT8cvPeeWWE7SoOCBX/XE5XO6OoGxtAbCxFLQeSrYpwqIEBLsabhewtziKmoUWm5nnD8w9EN+k0mHTo60SoI+/7Rmb2K4yU1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKRwIrma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D917C2BD11;
	Mon, 22 Apr 2024 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713769017;
	bh=hzRcfa23v/DUT+2N5bmwRSQG9X1L2rHH3P2NVUnJhzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKRwIrmafhE3wmAjRxTDaI7GMTAoAul8XQALTapw4bxL3n6wKBjFb1DnX/NMtDEdm
	 TOUU7QwZOPVKnGatAAdhtPSwpZOBQmENez6M+VepU++yASUhU5J1wwn8acmS2uakAS
	 enkAJ3HtS1zL1v60b69ewlVanugP0e/VuaePpORQxeB8kgqr9X6nHjCB5R6/TrYeqC
	 399IiONqTGiLv7DG2GiL0Y2K1KheiGJPv018eBq6ZkUgKP1Vwvq2SPKIZO/tdQgOo5
	 WrRl3iu3LfLn6TzcBpRldeXNvghtuskDT3visf+RnpBYTDT0rNycAS0l4lqfyfQeXc
	 RB9AVYyDZ4IRg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rynbf-000000002PO-1zHP;
	Mon, 22 Apr 2024 08:56:51 +0200
Date: Mon, 22 Apr 2024 08:56:51 +0200
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
	quic_jackp@quicinc.com, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZiYKM7tQ-FXwTcpD@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-3-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:54AM +0530, Krishna Kurapati wrote:
> All DWC3 Multi Port controllers that exist today only support host mode.
> Temporarily map XHCI address space for host-only controllers and parse
> XHCI Extended Capabilities registers to read number of usb2 ports and
> usb3 ports present on multiport controller. Each USB Port is at least HS
> capable.
> 
> The port info for usb2 and usb3 phy are identified as num_usb2_ports
> and num_usb3_ports and these are used as iterators for phy operations
> and for modifying GUSB2PHYCFG/ GUSB3PIPECTL registers accordingly.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

