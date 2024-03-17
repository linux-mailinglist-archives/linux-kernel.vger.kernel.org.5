Return-Path: <linux-kernel+bounces-105511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478287DF8A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAE1C20A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251601EA6E;
	Sun, 17 Mar 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmh1P7pQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593991CF9A;
	Sun, 17 Mar 2024 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702791; cv=none; b=q77Co4nAeXdBmEWlQcD0oQiTogynzBOtVXV8I8YMw5Au+9e2aqheZCIO/Pg4Aef+Ax0ePZLYkq/ceicBvvLf0Cg4CCCw26xTh7r4WkpWboHYbBOCVWI/e5o+uZpl8fb/RfgZWCrwJfG+CVAYU9CKN1xQo3LVNdsFZ9qt4SGvy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702791; c=relaxed/simple;
	bh=JYKVdlCCGPEvfp7uaNFd4jaJ+73Ab9jX4gjFI8e6pV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFNbkx5yxssPioz1xFyz4G/blBmpk8gzLaJVe287Si9eTtT3A0fH3WqY+2V8oy09ZPbpPJoc6fsOB2ZRJuB0/5ea2LRYnLu9EHhAD8aSgwsAA5htmL8h5ghXOT23ewZv5OVzkgAR80Am9ULd6oWcVf6X0T2wtLnxyM+4PKWSoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmh1P7pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CFDC433C7;
	Sun, 17 Mar 2024 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710702790;
	bh=JYKVdlCCGPEvfp7uaNFd4jaJ+73Ab9jX4gjFI8e6pV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mmh1P7pQhJxUV7thKu9zR+oBA53toGIgvDRcJGZ2sB8Y+vuOsZjnTYspScBo+XKez
	 Iw7JKRZvF9JNBKAhSGIYgsM9ZrwW48Uqs9zeF4TWDYmtu/l/5AbDaNh5cH9IWRRSCo
	 4Hfs7g7bYMysQ0PlGL4xTR0bYFhVz/MXt0mfs8WoTXAIB9DxuDyOq5NNkhcxrW3VA2
	 M1dVsG4tIKHOTg7N7K0jw8J0D2MUOQlP5Ic4mKPc9uTP3IqP/FQA4VxX+USI8VML+p
	 K2Iz419DngTmZKFzsBm9mHEjR11spvrjJb5k7B4cro4TIa49E6N40TluB7IdFzNiIa
	 nNF77kBni0gIQ==
Date: Sun, 17 Mar 2024 13:13:08 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: linux-sound@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	kernel@salutedevices.com, linux-gpio@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Michael Turquette <mturquette@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 17/25] ASoC: dt-bindings: meson: axg-fifo: claim support
 of A1 SoC family
Message-ID: <171070278776.2087227.539742040417816732.robh@kernel.org>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-18-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-18-jan.dakinevich@salutedevices.com>


On Fri, 15 Mar 2024 02:21:53 +0300, Jan Dakinevich wrote:
> Add "amlogic,a1-toddr" and "amlogic,a1-frddr" compatible string aliases
> to "amlogic,sm1-toddr" and "amlogic,sm1-frddr" respectevely.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../devicetree/bindings/sound/amlogic,axg-fifo.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


