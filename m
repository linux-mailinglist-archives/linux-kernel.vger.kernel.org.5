Return-Path: <linux-kernel+bounces-63804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14838534A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6567F1F24E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEF5EE73;
	Tue, 13 Feb 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptp4cskL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437D5B672;
	Tue, 13 Feb 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838202; cv=none; b=JKDn+kH4sM7CMP23Of3iBAUN207xrshc34UFreXg2KFZkJ2XBhOpGFBBH2G+E+w7htGSDpsX8C0Us2flMeSutny+W4x8jHJQMSBnJd1d8TJ0DiC+TZHgAJn4MJpL0PQogLi55FrQImeNEKz/JP589+j7FF4KkkLlss7fNh3XPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838202; c=relaxed/simple;
	bh=Wolp+E2RuuY50dt6mNKnn9ygbDFRB5Z1r6QtpNHkTzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3tw0GYQZ926Mpic9di7qKjmoLojSFU0jmJIamG/POJBp3R4D159X1wYKpn2V2ApbU10LGo1sqZVSZkHedsxd8HWQx0KKcTk/iwqgr4bS0Uo4hgCmQKHzdHEZlPKmj3wmULgSIcvD6XHDe/W9QqjoNPBvd749SwObLiYpZubkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptp4cskL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E60C433F1;
	Tue, 13 Feb 2024 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838201;
	bh=Wolp+E2RuuY50dt6mNKnn9ygbDFRB5Z1r6QtpNHkTzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptp4cskLAjbQwPs9slYJTx1Sodnnf+zTUAOGPx+BAQc8gs88zf0+QWq4BmUAb733k
	 c63CFwP0PVCXaFp+YOeOY/1g1cYj1O27g6LlRAY0KfVfwAVeerJ+POxjFB3ur3+kHc
	 QG4DDT3X1jHWDJC58s/Ci+ldxDeSVA/4gUMeI87CJOHSbSQ/ZdYsXjRp4PSEG23Pcx
	 wXJf+h1E0rwSWP9kBWMGus8fNUpW73S+hIo72Nxg3rXgdO/AzEI6r28/jylyj50X5b
	 71eb6HzfvzsSeI/C04zIf8muWwCmhx8/nKCoT+R6dyZ8J75EuUO3XGetXMOxlBOLQc
	 8FyB8z29A9giQ==
Date: Tue, 13 Feb 2024 09:29:59 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Rob Herring <robh+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	quic_ppratap@quicinc.com, Felipe Balbi <balbi@kernel.org>,
	quic_jackp@quicinc.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v14 1/9] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <170783819870.1408892.1824537443967859624.robh@kernel.org>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-2-quic_kriskura@quicinc.com>


On Tue, 06 Feb 2024 10:48:17 +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Synopsys DWC3 controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


