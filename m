Return-Path: <linux-kernel+bounces-117846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A767B88B060
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EC91FA5F90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184041C75;
	Mon, 25 Mar 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyE+1Y9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE71773A;
	Mon, 25 Mar 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395904; cv=none; b=A+6AYtHFHXG9hn8Yiq6hDZq1PjoUSpmYlabaKynrAGlR0oYS+zZXlvHktCeUYav60FoK68YEHJbCCEQy8CExf6LLH97r8Ymeuz9CWWJO9ypgB3L5av9ju5e8xfmANYXlBl9Lqpdt+p3uf67MW+jKglwvWJ6k+lSEoik02cjVhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395904; c=relaxed/simple;
	bh=fmSP58Mlsw0EmWE5dRwtBGOBojXEan7WVvl/tP9c13Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyiF8jXL/tfib3Pexwt8F/Twj28SfOOvGarxERJxqg3WJzufVVBRIRCrH3QzfGFwy16iiOzyGBPlnfNswwIjP3vmCluNjaxOOLC80rtQUN+2HUBMetmFwFz/IlRnSDwyJf4ZupT4O6uZQWPUZw2DW30ByIZB5w6stmmbQt1271Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyE+1Y9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7603C433C7;
	Mon, 25 Mar 2024 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711395904;
	bh=fmSP58Mlsw0EmWE5dRwtBGOBojXEan7WVvl/tP9c13Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyE+1Y9WohHcUH3RjYjT9XlInd+WKuPnKALoxESvLrqFuGqedJNELJVHuf50bbz+L
	 F8VIf/aVJVNPVrkLLtQDXfLB5jfQ9Jtutw+jZDS46K+TELbQ5XSYLir4wgbQxWBjsf
	 MPiyuCxUdvypuPdCIdzzX1hh9ictL6aNyXscb09ZSWZrK9haMhShpaP7TwtQT7hvlY
	 5NcEWdBRWXriJX/geiG7u9vz0MrcmvAJe/H0Z+iPG3ZZY//WigMQDd7oIHpSOpEsdd
	 mnhicwrP7tFbUZu/7GndS7lfV15goZ8amRQm7i8rlTBSFqz7hobgHrrgUtRkUY+7HA
	 TmGcEYHKvTGeA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1roqFr-000000004KO-2Miw;
	Mon, 25 Mar 2024 20:45:11 +0100
Date: Mon, 25 Mar 2024 20:45:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <ZgHUR-Rk-YzqiTtt@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
 <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
 <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
 <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
 <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>

On Mon, Mar 25, 2024 at 10:59:49PM +0530, Krishna Kurapati PSSNV wrote:
> On 3/25/2024 6:53 PM, Johan Hovold wrote:

> > 	ret = dwc3_qcom_find_num_ports(pdev);
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	qcom->num_ports = ret;
> > 
> > It looks like dwc3_qcom_find_num_ports() can also return 0 (e.g. on
> > malformed DT), which also needs to be handled somehow. I missed that
> > earlier.
> 
>  From what I remember, Konrad mentioned that we might not need to 
> support incomplete or improper DT [1]. 

You still need to make sure that the driver doesn't misbehave on
malformed input.

> Also since this is close to getting merged, can we take up any changes
> for Malformed DT handling later given that only one or two devices are
> present and less likely to be given a malformed DT.

No, and I'm a bit disappointed that you're still trying to take short
cuts to getting these patches merged after I've told you repeatedly that
that is not how upstream works.

Fortunately, this is easily fixed and would both simplify the code
further and reduce the risk of breaking backwards compatibility.

Just change the logic in dwc3_qcom_find_num_ports() so that it returns 1
if "dp_hs_phy_1" is missing, and otherwise you determine the number of
ports by iterating from 2 to DWC3_MAX_PORTS - 1.

Johan

