Return-Path: <linux-kernel+bounces-38677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD183C3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90695294BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEE58115;
	Thu, 25 Jan 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rug8Utf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888056756;
	Thu, 25 Jan 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190305; cv=none; b=iIB1B4rqSzVRmdXRDVSotCccsLNJtpt7w40sPNA1yRQ2icPpJ0VK9fBdhXa6aZG9sKvAE+oACR5h4qTlmt287ZulLNm3mGFMtRZlPQsb7dpWTcMAXf1nP+PsKqSeQ2wZzLVohk/sVBR9mVybcR82d0k1rSuI1XcxcBMBN6MlQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190305; c=relaxed/simple;
	bh=NkGyl0Jo0whrkxO3b7LKj7C4yJ2z5Q7jS9gPgnwH+To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWirHiRsF9x9BInlPJbR89htS3CHJ5XVKCxw4p0Pv5No6e9DNHJCliUgEpVfd6hRH3rFDGHxiFtuuLmeQ85Gzz5pg7xMlOZmXUhxVLXGi4nSg8XWrQKvlnZ44LbBe8K8o5iQSb4NNMj6nUUw118zO84LXIrVvAI9pR5k5grbBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rug8Utf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59646C433C7;
	Thu, 25 Jan 2024 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706190304;
	bh=NkGyl0Jo0whrkxO3b7LKj7C4yJ2z5Q7jS9gPgnwH+To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rug8Utf/w3dEQerx0wbHVZ/SWWLm4O7sohG0zDLffqrmWy1HvAKou2t+boHVJO82r
	 +wpGR6eKbO4rXTPaejfNyYwS8RxD5FSOnymemR/CviaMKn1H6ZhtKt9RVJyexJs+MW
	 DcK9n4RlsioLM/MRILqegUMF79BdrWHlfGqtQ2X8cBcNXjrCSfgrrrImI3ueuCg/8h
	 iHXb0JHwoTtGos5SeeD/EylC6Yq+7hTRzfWURDCmZRRT67R7ib026siLqXYVvzH4/N
	 PZzt51NLWtfLNpaBoE52UJui1OwWm1uMSJM9wCfXzRJERo6qQvyRr7eehDSvc/XuDY
	 gudz9vm89sPpA==
Date: Thu, 25 Jan 2024 13:44:58 +0000
From: Lee Jones <lee@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] leds: ktd2692: move ExpressWire code to library
Message-ID: <20240125134458.GK74950@google.com>
References: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
 <20240122-ktd2801-v4-1-33c986a3eb68@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-ktd2801-v4-1-33c986a3eb68@skole.hr>

On Mon, 22 Jan 2024, Duje Mihanović wrote:

> The ExpressWire protocol is shared between at least KTD2692 and KTD2801
> with slight differences such as timings and the former not having a
> defined set of pulses for enabling the protocol (possibly because it
> does not support PWM unlike KTD2801). Despite these differences the
> ExpressWire handling code can be shared between the two, so move it into
> a library in preparation for adding KTD2801 support.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  MAINTAINERS                       |   7 +++
>  drivers/leds/Kconfig              |   4 ++
>  drivers/leds/Makefile             |   3 +
>  drivers/leds/flash/Kconfig        |   2 +-
>  drivers/leds/flash/leds-ktd2692.c | 116 +++++++++-----------------------------

>  drivers/leds/leds-expresswire.c   |  68 ++++++++++++++++++++++
>  include/linux/leds-expresswire.h  |  36 ++++++++++++

Please can you separate the Expresswire addition into its own patch?

>  7 files changed, 146 insertions(+), 90 deletions(-)

-- 
Lee Jones [李琼斯]

