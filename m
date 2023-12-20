Return-Path: <linux-kernel+bounces-7009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A803981A07F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4872E1F2342F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EBC249EC;
	Wed, 20 Dec 2023 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqgbtzax"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8037168;
	Wed, 20 Dec 2023 13:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179A0C433C8;
	Wed, 20 Dec 2023 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080767;
	bh=6nS84hjjQDBdt98iBZz8SZKjaQiY/+oGazVY2peowjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YqgbtzaxiEfXtgf5evVK8bogkq9OsOhUYJ+l4TRwqelM/a2pd2qUwDkdEvmggUzVT
	 C84OALMEEsi3He2Uub1S5SHNoEwk2X5tH0VuL1Jp78rBF55Gvh5HuIRjIOnH5zlUas
	 00Rhoq1V5JZ863fBtdOoIjpssYLwchUicLqbnFYsVu4FRb+nlvlt5ni/wDEHngkt7r
	 oTU2E0B/+u8hK+00Wuh6JnOzrTNFVEdO2vHslfGEgZ4y5oUgguUT7JPL8luQy1gKhJ
	 W+w3nIYhnaKnJoh4njAAZvm7Wa13iecMmcYzwCcYxP2Z3KxS8SYQvSJJQY0YsmlQEN
	 wzHSH5WIUKhVg==
Date: Wed, 20 Dec 2023 13:59:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Conor Dooley
 <conor@kernel.org>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Message-ID: <20231220135913.50edaa7f@jic23-huawei>
In-Reply-To: <ca96c5d2-33aa-496b-b85f-531e628cb6d6@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
	<20231213094722.31547-1-mike.looijmans@topic.nl>
	<20231213-diffuser-disposal-ea21bbce8b64@spud>
	<20231214102244.000052a3@Huawei.com>
	<ca96c5d2-33aa-496b-b85f-531e628cb6d6@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



> >>> +  avdd-supply:
> >>> +    description:
> >>> +      Analog power supply, voltage between AVDD and AVSS. When providing a
> >>> +      symmetric +/- 2.5V, the regulator should report 5V.  
> > 
> > Any precedence in tree for doing this?  I thought we had bindings that required negative
> > supplies to be specified separately if present - so this would need to be 2
> > supplies. e.g.
> > https://elixir.bootlin.com/linux/v6.7-rc5/source/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml#L37
> >   
> 
> Given that some serious thought...
> 
> Splitting into positive and negative supplies would make sense if the chip 
> would have terminals for positive, negative and ground. Which it does not 
> have, there's only positive and negative (which the datasheet misleadingly 
> calls "analog ground").
> 
> The analog voltage supplied to the chip has no effect on its outputs, the 
> analog supply must be connected between the AVDD and AVSS pins. Its relation 
> to analog ground is not relevant, so whether the voltages are +5/0 or 
> +2.5/-2.5 or +4/-1 or whatever does not affect the output of the ADC, which 
> only reports the difference between its "p" and "n" input signals. It only 
> affects the range of the inputs, as it cannot measure (p or n) outside the 
> analog supply.
> 
Ah.  Not having seen any isolators, I assumed this device was running
against a common ground with the digital side of things.
AVSS to DGND is between -3 and 0.2 so I think there is a ground even if it's
not directly connected.

Given this only operates in differential mode the fact both signals are
referenced to +-vref which is from VASS doesn't matter in the end and any
offset goes away.

So yes I think I agree.  This should be a single supply.

Jonathan

