Return-Path: <linux-kernel+bounces-109885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA239885757
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BEE1F225DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBB56763;
	Thu, 21 Mar 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk/Lk+/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C230200D3;
	Thu, 21 Mar 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016398; cv=none; b=sGzwXnpLTHaIEPzRVOGlIkBIGKot3wtJOvwsPSZODLwDIeVGXX2qSb+JqwRYalz1TJXFm9NcK5sZhXtRHt5XIwSGHj4dSSgwlAKc0pUyq75QYLP0eGF92/DhJtyiwEN0CyLPPMGF4abndfmp+ml2IbeCDLRBHzV5GSz5RxtJ5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016398; c=relaxed/simple;
	bh=lO/wG4XF/5dsIZJ2dAHwfekBZW7O4cljkSFhVC8pbVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4VKbfwOQhGR9Xk6cSexPNDUEAMFOCo888IyGxtBbw5bGEOitXVfjoOiuFIwZ24qEL2HaN2pT9QLwKa5xZWUTq1WXDHkFRcpAV0Izt/ErSI0kCNtvG8icmGFv869wuSCurR2yfhBffkXUhQNeHL0Q4m62IGugaj+T218FZWQFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk/Lk+/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAF0C433C7;
	Thu, 21 Mar 2024 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711016397;
	bh=lO/wG4XF/5dsIZJ2dAHwfekBZW7O4cljkSFhVC8pbVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tk/Lk+/bAWQql2fWtlvB8hAGfJaZLUBJP0Tymf+c+vFJN7ADMvZ8w7MdAfUTGhs44
	 g7Ln2i+vIu72lW4s1TGBaOUieUqfZmlBKEUowXtlzKae5gQXBkevW1hHPoGPi+Ma8N
	 c9vFf4L4btQdQObh4pK0zM33sqyxZ+eWy5ysNjb55P/QDukzaOUVTceElLKT1pRk33
	 5cdlldCYPrR3q1zZo0FySdz0Xn6A5KWAX4A79VBPRVcxThczUaCeXNG8o5cl9rydjW
	 xTO84YzSK/Id//i4Nfk+kMe+La84xps8U4VszaL3efXd4o7BvyvDfkxwN/hTJURNVp
	 Gzy1eAhxTxhXg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rnFWn-000000005Hl-09if;
	Thu, 21 Mar 2024 11:20:05 +0100
Date: Thu, 21 Mar 2024 11:20:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 RESEND 4/6] dt-bindings: clock: qcom: Add SM8650
 camera clock controller
Message-ID: <ZfwJ1cgFLlWdj7xp@hovoldconsulting.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-5-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321092529.13362-5-quic_jkona@quicinc.com>

On Thu, Mar 21, 2024 at 02:55:27PM +0530, Jagadeesh Kona wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8650 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Did Krzysztof really review this version?

> @@ -18,6 +19,7 @@ description: |
>      include/dt-bindings/clock/qcom,sm8550-camcc.h
>      include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>      include/dt-bindings/clock/qcom,x1e80100-camcc.h
> +    include/dt-bindings/clock/qcom,sm8650-camcc.h

This does not look like alphabetical order.

>  allOf:
>    - $ref: qcom,gcc.yaml#
> @@ -29,6 +31,7 @@ properties:
>        - qcom,sm8450-camcc
>        - qcom,sm8550-camcc
>        - qcom,x1e80100-camcc
> +      - qcom,sm8650-camcc

And neither does this.

Johan

