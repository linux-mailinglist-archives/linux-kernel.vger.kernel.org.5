Return-Path: <linux-kernel+bounces-149127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC98A8C34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A711C22F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48E2D796;
	Wed, 17 Apr 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ghgGf2f4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100922324;
	Wed, 17 Apr 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382601; cv=none; b=A2EKMwKDXvhOnStVxKxhPrbOzddFYne95bnGT3Mw+XfDP4XsFx0jev2C6T2DER55AP35vAIH2r6a/YdFFdsceOlfZ7MC3sbKZCZhdoemGpB8Lx5tJikWF4XlF/uiPEaecUPCdh2Ws4U6UUGSDaE6vwlZ0M3sVQHAA0/+8X2upXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382601; c=relaxed/simple;
	bh=mdIICzU9KMKGrDG62N4QjQo6wwR0iXVse0i1Pf1HNq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/dZCarocHkc9TMfu9sf82FTeznknS8WNL8LQaCGPfCSN+l02PH7k/ArLSX+QmqHb3SaJQ0M93VCi/o+sT6hI2ywRrJZ0Cyey4IEdNQta4xoQdjsc3zmyFXBrVQGnpdz1oZCFL+ijvKod7Cym6geg4Pgs/9KcXf53r+48Ihhm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ghgGf2f4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 897C81C0004;
	Wed, 17 Apr 2024 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713382596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7evEF4M6GPcsPmLEVtaklRbN3oddZv23iJJ5uZYo1w=;
	b=ghgGf2f45IeZTXjBpsGdPMuWd1ncRBP1tqlf2U9a+XPR5jSAhD4+4upvFNHMlyVPsCQSXS
	ZPMUAxlsZe3Poc2g1mfKVxsHZjKyzZcY/CSKtT+wx13A8fDkhPEb5OBekyEVmGq2Vi3IxQ
	HkCZ1eX5JNxCCh2Bx2gfvDdeI4XIxZrWbMKh9s1R/eoKAqhaZteRCf7jhRvpDk00wfo9fL
	ukWFfn4bFOfXq8NxS4XWkIaJFfj9dArEtefST2GeJiGv6jbjmWvlpWehVC+fM9nTM62le2
	vhXQnW/jGpc9fBEz0qUqKZHeEmP0LtHv/0qxVErouShhNPVwHO3jsflfEiWGeQ==
Date: Wed, 17 Apr 2024 21:36:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/4] rtc: convert multiple bindings into
 dtschema
Message-ID: <171338250318.37347.8193747079895691565.b4-ty@bootlin.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alexandre.belloni@bootlin.com

On Sat, 13 Apr 2024 22:22:15 +0200, Javier Carrasco wrote:
> This series converts the following bindings into dtschema, moving them
> to trivial-rtc whenever possible:
> 
> - google,goldfish-rtc: trivial-rtc, referenced in mips arch.
> - lpc32xx-rtc: trivial-rtc, referenced in arm arch.
> - maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
> - orion-rtc: trival-rtc, referenced in arm arch.
> - pxa-rtc: add missing properties and convert. Referenced in arm arch.
> - rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
> - st,spear600-rtc: trivial-rtc, referenced in arm arch.
> - stmp3xxx-rtc: add compatibles and convert, referenced in arm arch.
> - via,vt8500-rtc: trivial-rtc, referenced in arm arch.
> 
> [...]

Applied, thanks!

[3/4] dt-bindings: rtc: pxa-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/bbd3e43662d7
[4/4] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/c3a0ee85f6e3
[2/4] dt-bindings: rtc: convert trivial devices into dtschema
      https://git.kernel.org/abelloni/c/1c431b92e21b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

