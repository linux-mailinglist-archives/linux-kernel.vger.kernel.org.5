Return-Path: <linux-kernel+bounces-158381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42718B1F06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9E1F21275
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F186641;
	Thu, 25 Apr 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ox8ZjBmf"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758586ADE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040422; cv=none; b=dK22WitWTtdZkB0mG+y/3f8NUtuxNzIKDAMuPWt8yvxF/5GfMSHk/1yQ2k+aUiJRSpqRyXpyp6AQFCn5rPQedgxr8F5xJZQyQZfxEv7qXSDgCGCKl2YCKLMu/4GgtDXA8XG4weU1dVfdQ5lBTmmty9YZzpd7aHP2wXpN8h+DscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040422; c=relaxed/simple;
	bh=coFlk6vpPoKDKE/eIhdn/SGcytlX8UEWgALPdd7bzSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhMqaPc8NJ9l9KJw9R75Pl7Ziu8SMKSxWVAQ5yKnvj7l0df7AhgOJ2p8Gsl/xmdIodPnRv1BL2MC94agmoCDE9uimJDHAjDkijtRukyRcXZgncI4DdsUbN54qwvs/9yRbcF7C5ubZ2M5dN4HRnV83Tx6GXCj0wrnlL4ZmTecB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ox8ZjBmf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a9ec68784cso487774eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714040420; x=1714645220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRSofvBWjZnGCZ5wbNW26krjGAh8HH8TfOlAU+v/yzI=;
        b=ox8ZjBmfO9AOovTLTWvrjxlwhgBGPybbXZNvExFbbjE+a375pKjhEViUTzvodj0WMA
         H2lDOAQyGJQIRi68ZlOONtnGVVFaiZm2/T+0er1Vf2YGkS+C2AP4wSWRYYgzB/+8hTOQ
         LsXwyG8gn5a7PrXC1k6OXjdUXcZlV89cqEsz8wM/d/Jiqgdw8z2eFVrLF8P9cBJoSOFu
         334DsL+H5moQo5MU32uxpGI2wgWrGKSBnWB9ryC2UgSpoWl6qYwUiBuhbL4UA2zqjeWg
         Zhbz2W3K5sC0q+DqF/0iVW+G1aqFQtXpVeJ2WHFtsWoilsOBIQx+GTRh6DXhC7GJJWIF
         mY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040420; x=1714645220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRSofvBWjZnGCZ5wbNW26krjGAh8HH8TfOlAU+v/yzI=;
        b=joSWWzxtUiCg/xcojdZul7YhHf/ZSqc/0FmOcrsHZVNnRqpe4tG8Zpb6OixfTWm6KR
         SBvYMTJWpwvMkAxawx+8z4LsBKSFNxjheOY3GCnVI5mvqlko7zB88+Y1hQRqfmTO09yQ
         nIxy7VRc+UJ1h/TcfSL6HYSAK+LaU9znsc4pYTKBUAgv/cWgehgPttj23wed1PiflPBr
         db3Yw/9GrX/aJ35hyhcwOqyWh1gARrAvy6XKEOzznepB4DB4isfMr27leW5Zh4WV6BVq
         igDrh9mmr5rKLDETNRRrqa9fjYP0o+wadhEB9/KaGzwkiDUZYvqFUAkaaxCFLQ9T8Z/C
         7/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQobnGRUn5qHaLWSofA/PmD46i/SMhsGkulfMU/CEfve4kskWcyuuhNjkUREw1/OdirhbhTE+mQVM5TQ80q5dGpfrl+RGbbJOjjvv0
X-Gm-Message-State: AOJu0YznX0e64M4cfS9yPw7/AnNZKDvfxg57OEEVwRvWeBa4+M2r7JfC
	IY0uMdTp6N2fgwhg9OU9EaESsC3iCLnbwS0HwSYwzgdbxN6z9AIbRHmMvP0Ui9wh5d6qJ8mdyo9
	nsFMhoO/ppzdu+Lavm6puOre7A+991Usog4lQKg==
X-Google-Smtp-Source: AGHT+IGzXdN9jQkTN93JYhF62J2Q05oiVeNPbJR1v4bCLwPIyAnVTqlzGOk52nsCy6ZOkF0HDDyk+nkA/ctDRVoz/ms=
X-Received: by 2002:a4a:98c9:0:b0:5a4:aea7:8066 with SMTP id
 b9-20020a4a98c9000000b005a4aea78066mr6630741ooj.5.1714040420650; Thu, 25 Apr
 2024 03:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org> <20240423-usb-dwc3-gs101-v1-1-2f331f88203f@linaro.org>
In-Reply-To: <20240423-usb-dwc3-gs101-v1-1-2f331f88203f@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 25 Apr 2024 11:20:06 +0100
Message-ID: <CADrjBPofpRiYc9hqOmBWXRKC7G7LYpLZfdDC4PRw9hmgV3in2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: samsung,exynos-dwc3: add gs101 compatible
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 21:19, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> The Exynos-based Google Tensor gs101 SoC has a DWC3 compatible USB
> controller and can reuse the existing Exynos glue. Update the dt schema
> to include the google,gs101-dwusb3 compatible for it.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

