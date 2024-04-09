Return-Path: <linux-kernel+bounces-136850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301789D8FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E131F220F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1DF12C817;
	Tue,  9 Apr 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="my38CGIS"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFC12E1D5;
	Tue,  9 Apr 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664730; cv=none; b=t6/RzBczYBqZJ8hznpBk7xAQgNGJQ8wotiDehabC+kM+vWmMP/efDmhet/3bkOXU7CQgv5GM2nPMpLsxRfJcYuBjyiXvCLCRJzEnbzkzxMGRVG0dr9rewl1Dh68rSwUQqw/lhkg2zXSd3ka4ddArW9Y2x6gDO3KiQl9oZj4vmM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664730; c=relaxed/simple;
	bh=bhAcDsX84r6euMWAqs9kSNF7o9zm3Y8Ymy+vrq4eEHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj8BpNnvZC9d2rKWlNvezf5nsaBWbpE6mChTr+623MDzuFWTsdRSwgBUx/ol1bASzIBp01sOUdIailkzoRLfW5jbuKGbdRJjlsejNbGWPAein9269n6XdTP/JOGr5ELce2usGJ21Fd1fHIAq90EfBldeBEhO5Wrx7xnQ+crOAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=my38CGIS; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91EBBE0004;
	Tue,  9 Apr 2024 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712664719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfWm8vYO3mDEuNQxKWMBm2paN+K8NdDcQizKVDcIoC4=;
	b=my38CGISljwiJ5IwyCJK8F66IO6v+ZQoKG8dNf48uMYkp6aWgPzFutmbt0GJP2xSYK/Rh3
	JoJ2t/QZruB2XuoNFZYqXUDc6qtPUp4rIvI1DzmCi2bZikWmYcXYKkgwd3f2UN3nO7xxIr
	Ma/RleoaEAPuSsj5A4rI8Y+gWy3Sns0quh7Ybo8dgjGo9Cxt9DRPHs7Exum5rnesjLwAYR
	kmnZD0ZMLoiE5GM95Atw5sZLGKYDX6xVVWai8iv/ggPqDuohI90RnD7DwDxJTJju27cmHm
	m88JatRVGUgGG27aqS4R/sNXVBrzXc6j2xkGm1yse3fhIeDkcR9RLbvy/TcF5Q==
Date: Tue, 9 Apr 2024 14:11:53 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/9] dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
Message-ID: <20240409121153e2941468@mail.local>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-3-c447542fc362@gmail.com>
 <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
 <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 09/04/2024 10:52:54+0200, Javier Carrasco wrote:
> On 4/9/24 09:34, Krzysztof Kozlowski wrote:
> > On 08/04/2024 17:53, Javier Carrasco wrote:
> >> This RTC requires a compatible, a reg and a single interrupt,
> >> which makes it suitable for a direct conversion into trivial-rtc.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt  | 15 ---------------
> >>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
> >>  2 files changed, 2 insertions(+), 15 deletions(-)
> > 
> > This one no... and if you tested DTS you would see errors, although you
> > need to test specific lpc config, not multi_v7.
> > 
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check W=1` (see
> > Documentation/devicetree/bindings/writing-schema.rst or
> > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> > for instructions).
> > 
> > Anyway, you *must* check all DTS before moving anything to trivial.
> > 
> > Does it mean all other bindings were not checked against DTS at all?
> > 
> > Best regards,
> > Krzysztof
> > 
> Hi,
> 
> I did check the conversion against nxp/lpc/lpc3250-phy3250.dts, which
> throws a message about the 'clocks' property.
> 
> That property is not documented in the original binding, and even though
> it could be missing, I could not find any function to get a clock (i.e.
> any form of clk_get()) in rtc-lpc32xx.c, which is the only file where
> the compatible can be found.
> 
> Is therefore the property not useless in the dts? My apologies if I am
> missing something here.

The bindings doesn't document the driver but the hardware. In this case,
the only input clock seems to be a 32kHz crystal.

> 
> Thanks and best regards,
> Javier Carrasco

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

