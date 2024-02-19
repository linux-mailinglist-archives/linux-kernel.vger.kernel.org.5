Return-Path: <linux-kernel+bounces-70900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29F859DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AC91F232AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80225629;
	Mon, 19 Feb 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VVl8JQpi"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3A24A1C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329431; cv=none; b=l+NlLIsRJvBaerZaLTJo5umXX3aucPEL7A0n4Hw0rJTbEQ6leya6hM8mCvZAEztJ35HrY6Lho2+NWMqcd1skFdxeIi0qIoDRENrqhVbOf5QnkIn1aHeHO5ACDO03V19WKPuKjkpWuFYa3y74VOSmZuA94nEbzOrXEsRE13E513c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329431; c=relaxed/simple;
	bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj3wAcZOPwGktE0u98fmDjZtntCgze0OiDJ7i+CFdxVek2mLXRpLvWGsxpiL0DgsdQiemFPrbIE5IrTU2iOL1DWJ0XF1VAb3TIj7CcXanRBDsnyOEHfKK5LdjWiX2xnL8PUwVFFoAiIYrUrf8Ec8c9Eepp0yCLSzNo038yyPCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VVl8JQpi; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47043f539e4so61966137.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708329428; x=1708934228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=VVl8JQpietD6ymCw8P666kr9JYEJOP/6jeXxWYk9wcv7MiDlOZHDq7j78X8ip5RtIL
         oGOg9zYfQV0Sd4wVp+AvOhyd1zR/usG2RKVc8dc9MV8tXFrH2CeZQ0YWWa9evUyQJQ/s
         drcPWv7qhkki+1T1yyXOIwpaLakGZoChRSfvzccCuQY3XjVtz7jCXViDDBb1vrPa2K8Y
         +EcJXvaxSF6pM2Uk9/oetGyr/zPuk4PGPok/1+mdFuioVNYGLnilS9zjbbOY1YFcZHCB
         B15hP2Ev/V3gsUF7j4dhNYeKiiKrTNge27kTORfRqqI7x30iJgnGqpsogtpL9MH66rbC
         tBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329428; x=1708934228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=My/wlchPrh2smhrmowBpkjlJU5f+nNuhSBwFta8VVlv1Ww1TdmytQAgUSF59ahmokB
         YE2oKDzpFDZVRBki71ImULW7ndTO7XKhzbTyG3IMyLYwiCpsfT/C8ByvyTejBQJx7gUL
         V3uWsnVeMXz4Pn9Q4cN9FEy8wzuKj8V0f0abQCMWUDcDPXgqk6/Cl7y3vyiefv7yVDMP
         ZMBcl2e0sLK+Wo9y2/nw5nQmRSuaNjM2x7/LTbVyHR19HUjTBIt/TsT2u/qD9bgkWFtB
         tVQpCSRMmoBAsmRGoS58Q8GNs529bVy3QsxlY3y6P23rrDbVWIk6OWwHYL8vCNBaLi76
         9xsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcM+PmbPFgltGkjKLmfedvk68sCroE/aYapNxmxzmnzp0rb9VCgqvo6niz8leVzuEy3Dom8BsKXpgqdYrWrJmab8jlsgTmt1P1IBih
X-Gm-Message-State: AOJu0YztoexZXhroJvoHS80dgRs86CHpJZmdkCCTuYeh+cMlQqO5nb1X
	Y6O3Sm4+TjaTfm0AwjYIj8S2EQKsaIX2GtwNnepm4Z+mFr4tjYrEhYO/tM95Wjd8P+hdEh8SBg1
	AfxIiAMG8bF7aV54oTonUFLDAPmLbFCf3EoSDNg==
X-Google-Smtp-Source: AGHT+IGkQijUvXHSNfPb2HxhHlZq4HKDdG92W7zvsTAzBpVd1PSmvpJBFeiTOYN7sqVAKs/Q5f+Y2wj1Qp78qPvhlpQ=
X-Received: by 2002:a05:6102:409:b0:470:4cfa:c814 with SMTP id
 d9-20020a056102040900b004704cfac814mr2022895vsq.24.1708329428140; Sun, 18 Feb
 2024 23:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-3-brgl@bgdev.pl>
 <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
In-Reply-To: <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 08:56:57 +0100
Message-ID: <CAMRc=Md1PzoZFDWHWRufktmMiBE0Dp7eYhecpwuaS3AW-Y_g=w@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] arm64: defconfig: enable ath12k as a module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2024 21:31, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Build the ath12k driver as a module for arm64 default config.
>
> This we see from the diff. Please tell us "why", e.g. "Board foo with
> Qualcomm baz uses it."
>
> Also this should not be in these series. It only makes the
> power-sequencing patchset bigger, without any real reason.
>
>
> Best regards,
> Krzysztof
>

Got it, I will resend it separately.

Bart

