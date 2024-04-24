Return-Path: <linux-kernel+bounces-156822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97128B08B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A9028162D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB515AD85;
	Wed, 24 Apr 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rfXtgngZ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FF158DDD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959640; cv=none; b=dzBMrC55KM2o0A0qbgSNadQ+JJEGI88XxKVsgkAJoGUT8i06+wFpK+BqbKKMZMO6Qbr5tuw9J8Q+yuhIpsrnMr/sbPZ8I12WM1lrzMUoKnxtv2Imbfuve/9sjOzK0VWk4H/MM08QZ7477IiXvmPnsgx9BUrbsSLa9GAHxm6s1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959640; c=relaxed/simple;
	bh=0jed1wP2STZmjYN6j6DHPKrmcSLazfieJmh1195MTn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy4MHfa0abBdQdinVLpWV8eHWSvHqNBq6REsAhadWi7xoVIT5//wRehhbv/aU9uMUAlZ6rReBnUpnuStDfoXQHkqBujh06y6MbDp9dfK1vukkxT/BKGNRoR9IeMpeUOH4dzKi4T5xxTnLoqRkztaZHcJ5CXTNEeJCGrwfPQPnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rfXtgngZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so87273491fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713959636; x=1714564436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fwVDPXlytnqZvxFwTS7dSKtSN4DOCW7zs0ZzVttwoc=;
        b=rfXtgngZ9CDSOH0e931xEaO8vnlDOOYfpe8yihljbJgXQq5nGfT69Hd0/HrG8c2Mhc
         nqm0+F5GFsSiSH7IVz9aBfWF2KBDCgX7waWhRM2MNWyBJYpjAmS6ALLoHntv26VbbPgz
         cmHB04jehtLny6msj+yi6WKyt5PXQk5IllpeFcYJKJr5VyKuD6Ci2wHlG5ghjfy72KWJ
         fPbvFB8pwYMLcobNk17rnJbDySioHkDX5QqVTgN5HC9Tx/uj4bvzHxxEc/NYZsAcQI74
         HctwwSdbGCee2tmheB6bp2h+9SWm7OnyeTF1dbT5ZDDxdNHoPak9FSmwsuARgRKgp2wT
         vesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959636; x=1714564436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fwVDPXlytnqZvxFwTS7dSKtSN4DOCW7zs0ZzVttwoc=;
        b=HK4N3gzE4GshASOYHqR0vBgBjaaSZhblqfZMfX6KB5jsL7OogaYLRu0nvbBAgx339t
         fXd7etFMLXvZzcYaGbLcab7h0vBaKp2f3KF94Q8dpPu50KkXnqNEv7qQ6SLjQ49eMT8q
         kP6LbZqtjPYB15XZvejenb4Fg84jKENyZeP0TTp/L2+qmizlCykgmWTPrkK3SEv1fovq
         Tm+GDio9zeM72gpuBpmgRutY2CccN+s+Aq1h+2X1P8xaEWbTt6ryad9eQNE0JcE8Donm
         ac3nIUOfAgkLMNpm/u31wUto1sea5z/gzPe8WBDn+m0nr/u1O97oZeGnckwZuwZbliG4
         Mv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl7ce/SLNHckIpymY7PbKt3B8crlSPDpp5MhO/Lc5aCIcMwpGBt1/i5s8Uh8BPzOohuKdo6Pa05ABdC15UTZcAn83//f2b22YDEEMD
X-Gm-Message-State: AOJu0YwaqAaP8blL0czcKXNyNM7v07Y4c6z/M7ADcu3FFFfZ2Rin2MyG
	m0Be7LAL//p0wFInrx0aCJhtLGPgsH+awPOUuWtMePZIY3B2dLV+qxEIYpprF5vPEbwv2SImo0N
	UVXPPZkfuOw4a0e8tvfMueDKcTje0e3NvHst11w==
X-Google-Smtp-Source: AGHT+IFETL2SQajzASz/jwjWTisjg/WAiG+J6faeZeNU6PfB5ASgj/DmGsMcakT+J7tVpOl+25cHrjaQO2zEsqWMijI=
X-Received: by 2002:a2e:8543:0:b0:2de:3d2c:7a5c with SMTP id
 u3-20020a2e8543000000b002de3d2c7a5cmr1347999ljj.22.1713959636358; Wed, 24 Apr
 2024 04:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com> <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
In-Reply-To: <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 13:53:45 +0200
Message-ID: <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:25=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> > On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>  s=
aid:
> >> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >>>
> >>> Any return value from gpiod_get_optional() other than a pointer to a
> >>> GPIO descriptor or a NULL-pointer is an error and the driver should
> >>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_=
qca:
> >>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> >>> power_ctrl_enabled on NULL-pointer returned by
> >>> devm_gpiod_get_optional(). Restore this behavior but bail-out on erro=
rs.
> >> Nack. This patch does fixes neither the disable/re-enable problem nor
> >> the warm boot problem.
> >>
> >> Zijun replied to this patch also with what I think is the proper
> >> reasoning for why it doesn't fix my setup.
> >>
> > Indeed, I only addressed a single issue here and not the code under the
> > default: label of the switch case. Sorry.
> >
> > Could you give the following diff a try?
>
> I am compiling a kernel the patch right now, but I did want to let you
> know that the patch got corrupted by extra line wrapping. I'm not sure
> how you're sending it, but I thought you might want to know.
>

This must be your email client wrapping lines over a certain limit.
Try and get the diff from lore[1], it should be fine.

Bart

[1] https://lore.kernel.org/lkml/CAMRc=3DMepDwUbAKrWgm0CXKObqy8=3Digtug0QDg=
o-CgwxjZCAC2Q@mail.gmail.com/

