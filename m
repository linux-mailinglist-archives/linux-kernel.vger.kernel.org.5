Return-Path: <linux-kernel+bounces-152835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D68AC4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06321B2187B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2650284;
	Mon, 22 Apr 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj1BMdGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC148CF2;
	Mon, 22 Apr 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769839; cv=none; b=IWhwdpJNULj9w/ah0jtWxy3ziRMdAVhvf9csFef7nTWPxswC2ttDr7fu5NmxX1IlLNpd0scMAE1rdd2Lhkx+HG9z/q9v7DQY5DZ1X3hFlZsgGfyWdjdMZO/WlTmQi/YYlh50u1quWy2f8bbCiENpc6xpCsIR1QDzepdHdwt2/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769839; c=relaxed/simple;
	bh=KFsVNGLXwmalWCExiI1bfO6IRb+bF09aXGJFizeOp2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3+EB1+Yf8NPTqpYcJsIRLAdAp7G1ljprXLthk8sglgKDVI2OfMGtwWydfSQH9nelbRAFF58bemN6eh+e7nZrz4GAHwGTbuR3r0jfrNoHad5CNMx0ZRTKxocm3Kt4Mr2ppfTVOqP5ZfBV7iwIGr/jQHmoKMsrLyJHAqMu8vKSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj1BMdGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABEEC113CC;
	Mon, 22 Apr 2024 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713769838;
	bh=KFsVNGLXwmalWCExiI1bfO6IRb+bF09aXGJFizeOp2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jj1BMdGR1FrmoIsUKIUW9iBgDUt/xXxF3tllfdOwY4sI5jrPEPE0EuKLsTJNY1/jI
	 qqaKK2dCBfFrh2ZouMdmvsjTywEhjw0Tp1aXnj2Vba1EE94AlTZCeto2KdMcs7iuta
	 3OY8E4UWjGeqyCIt12BnUZnwhRbVOhp/WGwDg8VeeIRz2QOSiXcsznprm6s9Fugo/L
	 Tv4sVXFifVn33gtoI68Mbj6hKIq32j313P2GTUzUOm4uHUHKkIivrM5oqvkzVhQXOp
	 3berZULi6Zi+BjfzP3t/AwguZ9e7uvjBCuLScNG2KzAoifIjhvZCiHquglQ2bfVcav
	 JQX8QH/ZKIjgQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rynou-000000002ZM-3EbG;
	Mon, 22 Apr 2024 09:10:33 +0200
Date: Mon, 22 Apr 2024 09:10:32 +0200
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
Subject: Re: [PATCH v21 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZiYNaJ8rwz6DXUGT@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-5-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-5-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:56AM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller
> which requires at least one HS PHY and at most one SS PHY.
> 
> But the DWC3 USB controller can be connected to multiple ports and
> each port can have their own PHYs. Each port of the multiport
> controller can either be HS+SS capable or HS only capable
> Proper quantification of them is required to modify GUSB2PHYCFG
> and GUSB3PIPECTL registers appropriately.
> 
> DWC3 multiport controllers are capable to service at most 15 High Speed
> PHYs and 4 Supser Speed PHYs. Add support for detecting, obtaining and
> configuring PHYs supported by a multiport controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

