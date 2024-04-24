Return-Path: <linux-kernel+bounces-156991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B028B0B51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC6C282D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CB15E1E3;
	Wed, 24 Apr 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="puQY9Tlv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679015D5B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966010; cv=none; b=gDzDFsytIq+SD8K03SXBxmRUjaxjleMticrPcEh9ij1ka1t+rfwnRwWSmnqV+/4hMll7Ktjk7MqNExLxp+ZokqQsCYb+3H4zanUrNAl+7PK7fnT5xlkzpSeR05eK9sAPVSRNCQblKh8xRldkGdBRuvbaFHw9Qh37krpJXJVRHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966010; c=relaxed/simple;
	bh=w4HFcqQhyWQncW/qT2xZrccfLMoMcxU2Zf6fU/4A86k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HX803tJ7AOkwQ3Bi5g/OICbGGdtEQiUY3xUM+9KGBPllo9kSElSnATrb7mZFPYRNoVPPO41Gw/xoxeAepV2vn3IK6VftUEONgphyuMHhMr8Bnfmb9gnNV7YZaqyJokPnxcJY/dSupp/c/372PToT+5AIyALyOGcL5QzzvtxcwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=puQY9Tlv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51abf1a9332so7305782e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713966006; x=1714570806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4HFcqQhyWQncW/qT2xZrccfLMoMcxU2Zf6fU/4A86k=;
        b=puQY9TlvO9EY7+VTeUN7AGkV8AYCbogcOkYqOY8CiBoO52pKH9rGKpbHDX2f+A8zcV
         M0tHdsy+FQlE6Xu6nOcohni11mJm/Q3myhPEESSx5AbyRb+ZyMFMaGVesOEEJEVSGfWW
         Ghl8kh6lU0ncM0Fn4hZ4fYQh3wCCUH6SwlMoTgPYHbXPrwRaWt+nQFpCtscqYFFU6IWP
         UnIWZqJb1DzmG4dQy7q81v7v/MRu29Dbics0jdrASKOW1AqUzy3prrWJae9Jmi3qugy8
         AN4dMnm+usDwr8FPkALGOldVTZEUsCzm+We0Dfd8urhjRv1uDzF0F3JHFdnEyfNiWNMc
         gD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966006; x=1714570806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4HFcqQhyWQncW/qT2xZrccfLMoMcxU2Zf6fU/4A86k=;
        b=rRxS4mo7JurELQRFY/qdE16JbpCwS8lv+F6b4FIFHk1C9xop7S9unW38Cq2SIfB+2o
         g+ox4TSxB0Rx19SJcpxI8EnJkWbmUdk8bFSJLe8GhyRhFo/y4fAkRjzvDqwSph0iJHWI
         U8eI31tl4XzilsM3BB0MD/wZJiPnyqTPDl7hpHoNAbPGSE2x7OeTxEGFVg3sKKxlxYgY
         l4HLa7feJZeR57EYEhoGbscnfYEaaCmdccj+9TAjnD20ByH0V2D2EEOk/Ohh1a5o3HOX
         l62TtildX1LHDcub/NUP4rgcMJ9pSE4AlA4WDPJr0GVixVArbvODcjpO2WCdQPN3Yanw
         DaPg==
X-Forwarded-Encrypted: i=1; AJvYcCU/tRyUiqj/m1sMrsdpadAtiu/RCThdrvmy7oL+jxM7EXZ+fl1pvssb8AYcGjHfKyvioSdwUGPpGWg2kBotuFifP9qez2dn8I68W7RG
X-Gm-Message-State: AOJu0YwborVaFCUUcnrY0JYEU66lfbtJwPD/nvdDQiI8YoLd2p0Cwf84
	5W1KQ1H7xP5fQOEi6OpCDeOAToBOUtCuZeuKP0MIps/kA+Tyfvmy9PowtSAzDjuN6OFcr5enhmd
	sJrSUzahpXjNF0mkeNlgNXbM89920A3WevvfPMA==
X-Google-Smtp-Source: AGHT+IGCc9LpHF0GH7iMkeOurEKKTBpOYbN8ZfZ2sxdbqQmT/hxe+kIOMk4aMoiBnq7eB4dsRGZ80wCNp0zoQwvJID8=
X-Received: by 2002:a05:6512:3454:b0:516:d1af:bd84 with SMTP id
 j20-20020a056512345400b00516d1afbd84mr1645686lfr.14.1713966006516; Wed, 24
 Apr 2024 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
 <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
 <0e6bc9af-71f2-46b5-8b92-5da674b44ad7@quicinc.com> <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
In-Reply-To: <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 15:39:55 +0200
Message-ID: <CAMRc=MfJ1v3pAB+Wvu1ahJAUvDfk3OsN5nieA-EYgTXPwMzqyg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:31=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 4/24/24 6:22 AM, quic_zijuhu wrote:
> > On 4/24/2024 9:18 PM, Bartosz Golaszewski wrote:
> >> On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
> >>>
> >>> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >>>>
> >>>> Any return value from gpiod_get_optional() other than a pointer to a
> >>>> GPIO descriptor or a NULL-pointer is an error and the driver should
> >>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci=
_qca:
> >>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer set=
s
> >>>> power_ctrl_enabled on NULL-pointer returned by
> >>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on err=
ors.
> >>>> While at it: also bail-out on error returned when trying to get the
> >>>> "swctrl" GPIO.
> >>>>
> >>>> Reported-by: Wren Turkal<wt@penguintechs.org>
> >>>> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
> >>>> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-gi=
t-send-email-quic_zijuhu@quicinc.com/
> >>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()=
 with gpiod_get_optional()")
> >>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> >>>> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >>>
> >>> Tested-by: "Wren Turkal" <wt@penguintechs.org>
> >>>
> >>>
> >>> Like this?
> >>
> >> Yes, awesome, thanks.
> >>
> >> This is how reviewing works too in the kernel, look at what Krzysztof
> >> did under v1, he just wrote:
> >>
> >> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> >>
> > v1 have obvious something wrong as i pointed and verified.
> > so i think it is not suitable to attach v1's review-by tag to v2 anyway=
.
>
> @Zijun, your concern is that current DTs may not define the gpio and
> this will cause the bluetooth not to work?
>

This is simply not true. If the GPIO is not specified,
gpiod_get_optional() will return NULL and GPIO APIs will work just
fine.

That being said: the contract for whether a GPIO is needed or not is
not in the driver C code or released DT sources. It's in the bindings
documents under Documentation/devicetree/bindings/. This is the source
of truth. So if the binding for a given model has always said
"required: enable-gpios" then we're absolutely in our rights to fix
the driver to conform to that even if previously omitted. If you think
otherwise - relax the bindings first.

Bart

> Would that not more appropriately be fixed by machine-specific fixups
> for the DT?
>
> >
> >> And mailing list tools will pick it up.
> >>
> >> Bartosz
> >
>
> --
> You're more amazing than you think!

