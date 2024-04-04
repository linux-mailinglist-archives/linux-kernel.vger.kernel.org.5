Return-Path: <linux-kernel+bounces-131093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E15898304
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E147228205F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590B6BFA2;
	Thu,  4 Apr 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQe8ddn8"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F135EE76
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218723; cv=none; b=PNRXmKQk0gcKz56W8nf7RVqDri9B72ASVw4GqgI2kcifry3rxXagY2wlyW8t4B/ZS0bjQv1lOsb5RVBeVWYsQBfJDxDHU5EPAkDNGyVZ08OLh/CPxg6P3pYeJmzFhy22Zs17m/FYRUpCk2C0p9qM9swYTlhWTuIxy2YllB8VGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218723; c=relaxed/simple;
	bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpFbWsX0vtZzMOTz6ln5Bc6nZCjKz2qigecO8hGR11FivK2C3Q/8FEBtJejFeu5gSfArrbKlOp6rhN5cbDktdopbcz5UDk8XW4tnzLQd71kwMfjZsjwQu+fqOBC4pYSAABXrUrjO5YxHilwNJZtiKD35oGKS+iWJbTrSVrDPs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQe8ddn8; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so841658276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712218721; x=1712823521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=MQe8ddn8hPCohkddiIdfjpxUkDgJfFcLgz578s90FL1abBGWq05W/lle5UAnhJLadA
         EfqU4JIiFXsKnpC9HVNB227hiL69Yne4IdbsawEmjvi80kZuAtpopTdIccmEHVcXq+zD
         Xz56eU0Wd1xhiuampa6zSfTZruO6Q+ePOgzKMeBqKYd90Ya1ygSjImtBE4Xud0KFnvpP
         7WcL4GgiXD+SPPaH4OGUK9cdbdbMFFO9t1kK2UO2Hmp1gju0ScVA177lRivKSOCTlbl6
         UTDva2eOtgb84bZJsHelg52wi5cOf7hiYaqx4E7SRGlWv405pZZEhby72I/YMxkfeWFQ
         tauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218721; x=1712823521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=l+Mz++DvWMNFOlu13mSVOzjn8AWA8Ze4FXYGfWSWmj16OwFe8OfGRRR/WwOHCAEIoo
         fPPbUMGGMAL9Sjk1/vBP7MoKaQCaCKekNH3mHWnF0CbPj8hnMrwOR26QKc0TqzKSQZuu
         sCsvosAniVPJD+EYEVJtqnvmD1+SUx8YN7E9p/tQeELNmFruW4QRVg7kNH5yZUPdmHYG
         HqILtHp7oGpp8BfPa8hOfbxYgXPEm5gr+/Jqnil3oGsxPCDtSmg8ACqyspBqPQfQxVQx
         wM1CE6hkyHZmFX/xSFEOQQC4oq86vrhyCcxKLP67yVC29KVKK7RlGiJQNaYerMNWn9jh
         qkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+6YKS3nJeCuh3MDH6plDNqWQrQX/ApsCOqyceIf87boUcPCekfWSuR4no8qh6v3CbvagLs2xfreFKkSAPbYvQ2rsoo/mFzzRJF3Ev
X-Gm-Message-State: AOJu0Yx4xyGTzcyXgHb8RfdNiqXGePgorEIa57NfJvX3SgMMQoTWDxq+
	m5cQxM/mzULFBHGCEEruQJ2UVd4QAqrNVVHEh3FfhHf8b6h0nHoNQPyFQhbhstg3RnLxAim53UD
	NHFzr1y40mWaxgZyD8a1hmRE05WTgqcZJN4n/3w==
X-Google-Smtp-Source: AGHT+IF10RS0Ghp5cgYZUvg6PBzUDvxfLN9KgcqveP0TSNC3zgxigAL30JAOcgZTHb+RkMpEFaPK7ZHMMNnVTswBtzY=
X-Received: by 2002:a5b:d06:0:b0:dd0:6f7:bc3b with SMTP id y6-20020a5b0d06000000b00dd006f7bc3bmr1651889ybp.10.1712218721029;
 Thu, 04 Apr 2024 01:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org> <20240326-module-owner-amba-v1-15-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-15-4517b091385b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 10:18:30 +0200
Message-ID: <CACRpkdZa7mszi45M72qKPM=NJtou1A5DjVVUFzChFtZwzwVZyA@mail.gmail.com>
Subject: Re: [PATCH 15/19] hwrng: nomadik: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Amba bus core already sets owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

