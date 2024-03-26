Return-Path: <linux-kernel+bounces-118762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48988BF03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93895B2447D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540067A04;
	Tue, 26 Mar 2024 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJToKba1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EF53809;
	Tue, 26 Mar 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448048; cv=none; b=YIrDWgtUnjqXSIELUHX3mSIhwHSFZU/b6Jm+A/0SE7/kELGiVSIEf7fH/E+vCIFW/sN/I79Uc+fN+04PaPR/D3QAONliWe37w8+NFqKnJc8IRAX7pvw3Xs10nw84pfYJeWcdX5xfrOhEvrlEt1UNr1bRMGZALUFz0wEktrSU2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448048; c=relaxed/simple;
	bh=CXRVBJsyRhRTDPgc71oICHaEoURlLv0EZ/hQT0uJ0l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFv/WxLNYv/I6KYe6CFBktbn9lmmM+lRN6aOgnU/Z+LpbtEccWSpizjuTW3xIzFz5G1GTIILi0ix9meiFgouKB9c1HFm82+rrinhUeSRxeQdS37AsEVSXTEF63xaj+rzpxpw/FvRAYnWXyyuRismOp0LZmQdXPpNkoGfRrEfRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJToKba1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD4AC433C7;
	Tue, 26 Mar 2024 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711448047;
	bh=CXRVBJsyRhRTDPgc71oICHaEoURlLv0EZ/hQT0uJ0l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJToKba1wrDYVyVbMHpJJJg5u+Vr6rFDvsc3BPJAYX78QNGBGvcvo/yH3bO4e2J5A
	 ghogY/09MVHc0YE7MDLk35xLz1e1e8Vgo+u6o+21V2qiD9MUKj/wl31X3ClsnhvIUN
	 P48EaBsFTbD71blJW0UM/svNd627HOvcQYiA/wWnP9wrWiNvXPckZ0G2rnQfKk3V44
	 ryxL+XcZyEbZRJcGghmHHi15zrz6JZV/iPOFBeMT9S0ju+g/j0qhocHj8BCNzgOtwP
	 pFqeueF6LmmAA4UN40Q/6/dUS+3DRyxE6BNlJfyXz2JbJ+sujcPj72Cay3GEVh4Boq
	 bJF/xvC2jUvUg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp3ot-000000007YM-1dnr;
	Tue, 26 Mar 2024 11:14:15 +0100
Date: Tue, 26 Mar 2024 11:14:15 +0100
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
Message-ID: <ZgKf985WGJ2gpffF@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
 <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
 <50926b91-3c61-4dbf-85c9-7558ab96e628@quicinc.com>
 <ZgF6zvaT2OkrbkHK@hovoldconsulting.com>
 <807015d4-c5ed-4e04-9948-fd1ff894a04e@quicinc.com>
 <ZgHUR-Rk-YzqiTtt@hovoldconsulting.com>
 <7b4a6d7f-76ad-471f-a178-dc598fbc0e22@quicinc.com>
 <ZgKHNuziNtBhGO9V@hovoldconsulting.com>
 <ec3bf11a-0dc2-4313-ba93-c81494c4cc38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3bf11a-0dc2-4313-ba93-c81494c4cc38@quicinc.com>

On Tue, Mar 26, 2024 at 03:36:27PM +0530, Krishna Kurapati PSSNV wrote:
> On 3/26/2024 1:58 PM, Johan Hovold wrote:
> > On Tue, Mar 26, 2024 at 01:41:52PM +0530, Krishna Kurapati PSSNV wrote:
> >> On 3/26/2024 1:15 AM, Johan Hovold wrote:
> >>
> >>> Just change the logic in dwc3_qcom_find_num_ports() so that it returns 1
> >>> if "dp_hs_phy_1" is missing, and otherwise you determine the number of
> >>> ports by iterating from 2 to DWC3_MAX_PORTS - 1.

> With the above fixed, can I put your RB tag given on [1] or will you be 
> providing another one. Asking because when you gave that RB, this 
> malformed DT thing wasn't there. So wanted to check with you before 
> pushing the code.

Thanks for checking. I'm fine with you adding the tag after fixing the
above now that we've discussed it.

Johan

