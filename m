Return-Path: <linux-kernel+bounces-117018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C2F88AC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C44B61E01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B003157E92;
	Mon, 25 Mar 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMJgBwGa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5592157483;
	Mon, 25 Mar 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370120; cv=none; b=Y0JecdNQPhw8PlSozoXfq0cwJPSJYtd3fYJuWTne8p4Qb/r1UWrjoa54iuA+Jueg81G9zr+KbmPBZao99LucMlINHvkxY+9tzIN3X8Utf2jl5MKy6ko2UKtxzfC+tNEcfyjvurr0jN1A1vbaZQ3biMCYrlRCh+OmrWiZLCoy/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370120; c=relaxed/simple;
	bh=FKQQG0pq2Od2LfNdvRIjDxkN9xppB0XdorLSTeVtiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMk49lEzY+Brm0mzHcJG1mzafrcnvuSBA/JLaVTXtcCkySAbKbRa1J2Kd6+oUCNNlIZjPa3rCPjXSFX4W7LwmX14Mj/kyAVvaweKlyYoII295VJjIHwEL5wjrr2pkKuL5qR4rFOW/dpoB7jfzRrMzLQR6nKI+Wz2ELLHQfWw3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMJgBwGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD11C433F1;
	Mon, 25 Mar 2024 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370119;
	bh=FKQQG0pq2Od2LfNdvRIjDxkN9xppB0XdorLSTeVtiFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMJgBwGaQeaTNucLh68IaEiOJD1cK6Ynw/7O3XdJU8ZHfEvtrkPu5t5r/JDsU//6B
	 R9yG5Fvb8pG5//d6q1SMncdrV7JVWXP1CMQq+T/7VNi3+J/uxucP6A6mExv/3J9FG1
	 Iup9qn2HwuvckA+611A9C5ejp7RTeO+xNOgDt6zW0yOLQDFNsH3BZzZqPeZg7VAIB2
	 akzs8n1ojhW23LfuaR6gkgVnvUwmvFW7no/kfhJCHAdMJ5cR2zYstIq0J7IplA7lYy
	 bexLbbuBz+1x14roLfZguYNKWt8FbBYKDZ+551PwApr0pheSa9Df9jeU+Dg6IClp+P
	 vlhSPrX+vFcvw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojXy-000000001SC-2JfB;
	Mon, 25 Mar 2024 13:35:26 +0100
Date: Mon, 25 Mar 2024 13:35:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
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
Subject: Re: [PATCH v16 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Message-ID: <ZgFvjpRRQ1fdJx0k@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-7-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-7-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:49AM +0530, Krishna Kurapati wrote:
> The logic for requesting interrupts is duplicated for each interrupt. In
> the upcoming patches that introduces support for multiport, it would be
> better to clean up the duplication before reading mulitport related
> interrupts.
> 
> Refactor interrupt setup call by adding a new helper function for
> requesting the wakeup interrupts. To simplify implementation, make
> the display name same as the interrupt name expected in DT.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

