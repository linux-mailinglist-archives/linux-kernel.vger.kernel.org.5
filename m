Return-Path: <linux-kernel+bounces-67083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57B8565FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EC41F260A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40D131E39;
	Thu, 15 Feb 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th+RKnPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42E131E20;
	Thu, 15 Feb 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007531; cv=none; b=tSkLQ+boF4HfDq21kKx0aYrd3y2zGc8oJ/PX1tyQCLdjoFW5g//V9miRVzy/17YIFPgCHgcyZbv5IBjvMt22krbTOByzG3VyMob/ZJ1QNaBk7kGpuV0oZD/myKiOI6Scrs7ML4/rP4KbIAErKwGrb5aimCKoHox5p7rc99CWpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007531; c=relaxed/simple;
	bh=5fPHkNbQOnr/Rx0yCFr1hGYmrdP5ePSWpHM505l8J28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSb8W2dZqzq2Agvqi9C5iKl8gquNr6AwGrkUbqdguFoSuThFHX2Xu42sfJPkuYvwQ7opHtw8REZUUq1dBWcMIEoEJcVnfFZzdRudaZuwx6PvSKhEOZsGq+lcwQuMxcw1WN+qjH5hKBKY17lXoPdeE9GPROg4OqrhuslVqQj98rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th+RKnPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D9EC433C7;
	Thu, 15 Feb 2024 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007531;
	bh=5fPHkNbQOnr/Rx0yCFr1hGYmrdP5ePSWpHM505l8J28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=th+RKnPurwzNKta9/48LtBEAxDOWfgwBDjh+4TU+pWHLwl5KSzivIzw90Q95+G9pf
	 Of1SiZ/EWJKC9RZNp357+kdMx+jiYQbOzYU/nXqoGmSdendLEqGg6T6T7LZ7iGpFZg
	 irdPw5Dt7cknyPFplXyahgCsEg/6bRJJFboWVick92+d3frnpTcZXjKZyOIQ3vO0sW
	 LMZS1E8uhZ3NiRrfiA4/pzh5c3Or+ffu6OmFyrOa/QsXxLc+rNYLHCvB1AZ/CA/ui+
	 KBkaro5ZwxHoa8aOpuizOlAh+9LoyTQ7WwP8w2QxTTEyY8q7tM7ZhNXlQPaKck7W06
	 J9tDQzrcplkpQ==
Date: Thu, 15 Feb 2024 08:32:07 -0600
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Eugene Zaikonnikov <ez@norophonic.com>,
	Michael Walle <mwalle@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Pratyush Yadav <pratyush@kernel.org>, Nishanth Menon <nm@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tero Kristo <kristo@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: humidity: hdc20x0: add optional
 interrupts property
Message-ID: <170800752707.10493.10095025505089429224.robh@kernel.org>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
 <20240212-add-am64-som-v6-3-b59edb2bc8c3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-add-am64-som-v6-3-b59edb2bc8c3@solid-run.com>


On Mon, 12 Feb 2024 18:38:10 +0100, Josua Mayer wrote:
> HDC2010 and HDC2080 humidity sensors both have an interrupt / data-ready
> signal which can be used for signaling to the host.
> 
> Add binding for "interrupts" property so that boards wiring this signal
> may describe the connection.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


