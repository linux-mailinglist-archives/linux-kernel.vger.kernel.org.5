Return-Path: <linux-kernel+bounces-159407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864F8B2E39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57432B2340C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27E1878;
	Fri, 26 Apr 2024 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XvVYalsQ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A617CD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093741; cv=none; b=uRZJbh3V+kgPWKJfUTH0f+TG7oWhAA7rCTmm31ojUEeHl/NbO5i9jzGd/ZuwGluBElAaT7cTvtm6APB3qOP7C5x5z2AGZLdtMyHs6UQEEd5eR4lTdeUfJb/eMvu8tF8GD77t/n6hDFCgQHsADCwnRfC/aH98hoG5krGlIE7VlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093741; c=relaxed/simple;
	bh=mD85VhI3w15gmvfp3YL8kqnwEiMwGThbedZmJ+FmX40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzr3HtWYGO9DsZbDeRfqFQxbGzJMXhRuoHXopkl3l0c+dQaEqNhper2eF6yZl/lDMfz0RQHmpOn9jAKfTSHZxbMt82WNqhiwW6/8bNPJ+lmSB2FiMfcp6fTUSexAWbfsPnfe353IgOCxfy4sYByMlWvnu/dlclOaO05cbBVhswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XvVYalsQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572511ae0c2so442336a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714093738; x=1714698538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD85VhI3w15gmvfp3YL8kqnwEiMwGThbedZmJ+FmX40=;
        b=XvVYalsQ/fKnSwsJURMvjMYcTHJTNy5tNeqQvkAntsJhd07ABwPWeX+bR8ICii317l
         +m/hvaOv/y1Ud9N+6JIo9RhAyoSx9/Tg97QhvyI6S7bNcuIHrMltRPXtD4RXuyqHEWas
         ZmZDVJTy56nXSr/7IneMlxs/z9eaIdwPSWQ5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714093738; x=1714698538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD85VhI3w15gmvfp3YL8kqnwEiMwGThbedZmJ+FmX40=;
        b=JQ25NBw7bRGGDH1YHrJUQV27wv14PxZ0JvJdK9x0m1cGoKW63zPAOVYHR6tbB3gAYp
         IvhcqXQZLRP2u04AJr3Ethl21xuRwUb+7U1eqTYVFrZJR/pSLEyzlpXNDZIIZAC89ns1
         kcDd/g4WIIRCqm0VYlK1cI8DzF6B67wORNClWWMtIwjBgZibs59XCnNVPAqUNklbh2iN
         UEFEo+hck+BfsU6w0SwXBhm+H+OkK1B8rJPeO2ZDtjefix29lLgyQjoq0lNXnOqBBTxA
         lAUohR20hFWB9UBcq1GPNNEpoz+zFXKyqyttLSdEaNEdvbptdBsass2I9XNM67EG6RAH
         DrHA==
X-Forwarded-Encrypted: i=1; AJvYcCUrt1Rs2u2yznCfxNCOCStgj9csCzzLeTEzoVazAW1G+qZ4ZEcwTLBHscIQeXvbRhbd1fNIUnS/p3ToSGSqKWv5XqzGcf1R37eyNGi4
X-Gm-Message-State: AOJu0YznxiALQA4TgjY9lO035kSOpMo3hZNjr8twCeJeiCOWQnRHyOdt
	+Ylcb9TVdxK3s1ydEcU57dDobHRSvMWGVHxY6mfJoB2+5N/FGG3U9rguOyaZ/p4ebcu5BGr7MsI
	9dA==
X-Google-Smtp-Source: AGHT+IGxp7muZ1jrwazjVL9ObwzKOu3hZx9yotordbGcenhDoV/TadU64++4+VVtDoYV+7rOTBjW9A==
X-Received: by 2002:a50:f609:0:b0:56b:b6a2:2048 with SMTP id c9-20020a50f609000000b0056bb6a22048mr759259edn.24.1714093738056;
        Thu, 25 Apr 2024 18:08:58 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b0056c24df7a78sm9539016edb.5.2024.04.25.18.08.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 18:08:57 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55ab922260so221378966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:08:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzrffHUlp2aWT2jpNAjR+vzmcGW0IWey1EVqo6FIe7qbGu7FVnPibAzW2Vb7YF5j6t3lCEXmii2G5EcXEErBX/7lExokdNEGzbd528
X-Received: by 2002:a17:906:2718:b0:a52:65bd:a19a with SMTP id
 z24-20020a170906271800b00a5265bda19amr753070ejc.57.1714093737062; Thu, 25 Apr
 2024 18:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org> <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com> <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org> <PA4PR04MB9638670FD6768AD8A69F5125D1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638670FD6768AD8A69F5125D1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 25 Apr 2024 18:08:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNhkHi47=d-TMkjy3oebsK_NvWuC9CQtEEQYN-nHHbx-g@mail.gmail.com>
Message-ID: <CA+ASDXNhkHi47=d-TMkjy3oebsK_NvWuC9CQtEEQYN-nHHbx-g@mail.gmail.com>
Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host mlme
To: David Lin <yu-hao.lin@nxp.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, 
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>, "rafael.beims" <rafael.beims@toradex.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, Apr 24, 2024 at 7:40=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Marcel Holtmann <marcel@holtmann.org>
> >
> > Hi David,
> >
> > > Johannes agreed that cfg80211 is the correct way for the development
> > > of mwifiex
> > > (mac80211 can't offload association process to driver/FW).
> >
> > that was never my question here.
> >
>
> This is previous topic discussed with Johannes to confirm cfg80211 is cor=
rect decision for NXP FW.

To be clear: external_auth() is a cfg80211 feature. So this part of
your response still isn't very relevant.

> > > This patch is used to fully leverage SME of wpa_supplicant and hostap=
d
> > which can complete the missing WPA3 feature of mwifiex.
> > > The patch series had been reviewed and discussed. It looks like there=
 is no
> > more comments for patch v10.
> > > I wonder can patch v10 be accepted by you?
> >
> > If your hardware is a FullMac hardware then what is the point in now
> > separating auth/assoc out. Is this done just for WPA3 or also for WPA2/=
WPA1.
>
> Yes. Our FW can's support WPA3, so this patch is used to hook separating =
auth/assoc to
> leverage SME of wpa_supplicant and hostapd. WPA2 is also handled by SME o=
f
> wpa_supplicant and hostapd.
>
> > Are you no longer a FullMac hardware?
>
> You can check previous discussion with Johannes, FW still needs to involv=
e association
> process, so mac80211 is not suitable for NXP FW.

For the record, that's the v9 thread, around here:

https://lore.kernel.org/all/7a08dbcaded25ec0d32865647d571afbd66062fe.camel@=
sipsolutions.net/

> > You keep saying that you just want to support WPA3 and if previously th=
e HW
> > worked as FullMac hardware, then external_auth should be the way to go =
for
> > having SAE handled by wpa_supplicant (or iwd for that matter).
>
> Although external_auth is one way to support SAE, but we think hook separ=
ating auth/assoc will
> be the better way to resolve this issue. In this way, offloading SME to w=
pa_supplicant/hostpad will
> let any future changes be easy to support (we only need to check if there=
 is anything that we should
> do when converting association request to the association command support=
ed by FW).

Perhaps I'm missing something (very likely), but I don't immediately
see much difference (with respect to your FW API, and future
extensibility) between external_auth() and your current solution (of
intercepting auth()/assoc() and constructing your own AUTH frames). It
mostly just means the AUTH mgmt frames will be coming in via
NL80211_CMD_FRAME instead of being manually constructed within your
auth() hook. The external_auth() approach actually looks *more*
natural than your current solution.

How exactly does your solution make "future changes [easier] to
support [than with external_auth]"? Do you not trust that
wpa_supplicant will provide exactly the right NL80211_CMD_FRAME
content you're looking for, and you need to tweak it to make your
firmware happy? You're talking in extreme generality, which doesn't
make it easy for me (and presumably Marcel) to understand why you're
choosing one solution and rejecting another preexisting one.

> > Now if you are fully embracing to auth/assoc and we can remove the supp=
ort
> > for the connect ops, then lets do it. However I don=E2=80=99t see anyth=
ing properly
> > described in the commit message. You keep saying WPA3 support and nothi=
ng
> > else explain what the new Key V2 API of the firmware would do.
>
> We give a flag to let user to decide to use connect ops or separating aut=
h/assoc. We will remove
> connect ops for our new nxpwifi driver. New key V2 API supports more key =
solutions.

To add to this: AFAIK, you don't even have "v2 API" firmware published
for all chips that mwifiex currently supports, so even if we wanted to
completely convert this driver, we can't do that today.


Brian

