Return-Path: <linux-kernel+bounces-167318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E658BA7C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B11F21E23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C7139CF1;
	Fri,  3 May 2024 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWCxnhYi"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73078146D54
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721336; cv=none; b=blecJSvBVmlWS2YvJLS0YBN1zNhzqTCqaJt59qYV/X19S5HLpKkf7NYFbjakakXJSA5r4wwk/EFj/ZHo2wfHEH4ja4pz7n91YkENR+HK0g3URq/iK6amjaaHG9QbMI4rymi8EGzwaN+rH6pmRVjZWd5VkM6S7kkBfnKbE2L7jD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721336; c=relaxed/simple;
	bh=Hn+kibtNuVGY16LR1Tui4J9dCha04H++GGopC0OUDOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBDTDnV7wydIBAyLY/vv/PTS5Nu8zK8hfBR/zo6nDd8RhgCrkYclI5YPtO98jAfljAV6biiMvOPOCggZqKe4U21x74nYnD4ywA3vQEbynYdw6RFyPOUHCFkXGBZkJpNpfbIGwfS1aaNFZQ7UkxUGHgaFqIUHOHYWITXu57Ymv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bWCxnhYi; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de462f3d992so9345733276.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714721332; x=1715326132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn+kibtNuVGY16LR1Tui4J9dCha04H++GGopC0OUDOA=;
        b=bWCxnhYi1vzW7akPHe39Sq0l65OBVtnxZfGzJmGAVxFKRT8QpSInC5K9T8Uj1at039
         JNC5tHoPar9bSAoQasXba6ZWaFA9NKZFei2ThX655NfNkUxBqRo1igwSDyoJsEsoyjFV
         k4BxBmx+7gPWX5RoJo4C469uIC2EGbWstwzYaDrXFJT6l3KF8jNyV0JLskKyl1BBAJNI
         wqw/qFCgXY6lJkVAKmB7s5CQcHtVOD8qkU5yVCDaSmaTHog9/lPfCJ+e+7ty0YFKXdty
         MWJFFvkhHtfmmivbA+WqevsBGzrXpbmQiBBOXsU4EpCnz2trDDM/Vc5ahIlvuYchXD/S
         b3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721332; x=1715326132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn+kibtNuVGY16LR1Tui4J9dCha04H++GGopC0OUDOA=;
        b=sxKo8eACwybxTPbCjXfH6aJNb/Uu4jVg9O1QvUeJYQ253Rz3ZttYG2yfWgG8dyKSkB
         /eEhwGm7lC472+ZqTXJHVOKijQ1zVu3Di4ZH1F2GBL0pFutClQJ0vQrOWXQ3rdZxsSY+
         oauawM3/Wxxb3Ji3WOdyUcapDCKuh0uS40zm3KTnJXLfdmQPjuFDQkLB+7jW03xxloPa
         9Xrvg3LgHC09Ba/becmea8CBeeRs2MMI1k6mf6ZQHM7wEit3UBfHE28o7inFLtRs3s4O
         Qd+k7+EXzKbVqGsXWgsED+fjP17wZC8Q1Pj3LRHrnza1GiFTpx854dvTIIvEnLAmJiDC
         gIPw==
X-Forwarded-Encrypted: i=1; AJvYcCXO3vlQT1XKe9Fvlx7TJvkEE7+7Pafm+95sNFNQV5fMXjiyPBGEgI1hYru0TyP90B6sFKfym+5CH+6zXuisvXTxgAkO4oDTOx68ePcp
X-Gm-Message-State: AOJu0Yx68AlsShtQgpZDVRiJpKA0I1nbENt/u9mcPbhy3teanyC1S92C
	TfMnX7ZkzAhU7IEMZWM/GBKtJHUCjeFUOIp1/8Po8kxbSdbXKectu8O5+CzOb2aKypoeXN7zFLC
	zaKFmk28HvcAVd/FNL44eD9Jp0wGJjv4DAqTGmA==
X-Google-Smtp-Source: AGHT+IF0xjlVgsvZVFX4uIc9xGkdM4zN5rBjDCjVF5rIBWnC2grAED83RKEyEUanO8Zm+9uvlUebxitXHnTav2HLKug=
X-Received: by 2002:a25:dc08:0:b0:de6:723:3035 with SMTP id
 y8-20020a25dc08000000b00de607233035mr2121144ybe.13.1714721332503; Fri, 03 May
 2024 00:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
In-Reply-To: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 09:28:41 +0200
Message-ID: <CACRpkdYw8jzFH5n377G76iMqri70Tf-1Vc=P5D6ESU_U0qRXWQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain support
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Brian Norris <computersforpeace@gmail.com>, 
	Jaiganesh Narayanan <njaigane@codeaurora.org>, Johan Hovold <johan@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:46=E2=80=AFAM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:

> When a GPIO is configured as OPEN_DRAIN gpiolib will in
> gpiod_direction_output() attempt to configure the open-drain property of
> the hardware and if this fails fall back to software emulation of this
> state.
>
> The TLMM block in most Qualcomm platform does not implement such
> functionality, so this call would be expected to fail. But due to lack
> of checks for this condition, the zero-initialized od_bit will cause
> this request to silently corrupt the lowest bit in the config register
> (which typically is part of the bias configuration) and happily continue
> on.
>
> Fix this by checking if the od_bit value is unspecified and if so fail
> the request to avoid the unexpected state, and to make sure the software
> fallback actually kicks in.
>
> It is assumed for now that no implementation will come into existence
> with BIT(0) being the open-drain bit, simply for convenience sake.
>
> Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

I tried to follow the discussion but couldn't get to a verdict on this patc=
h,
should it be applied or not, and if it should be applied, should the Fixes:
tag be dropped or left and considered a nonurgent fix as it does not
affect current behaviour?

Yours,
Linus Walleij

