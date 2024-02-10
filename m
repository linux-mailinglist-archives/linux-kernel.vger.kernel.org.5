Return-Path: <linux-kernel+bounces-60531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB0F850627
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14AF284C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAE5F85D;
	Sat, 10 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mXx4L30f"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF25F47C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707594030; cv=none; b=G5rSOWJRiA9Wng2pvDPgoyBx19Qm0R0j0Rg2dNIwsbINgsJB25FspDExj1poAUPP49p4+u96wtC2m7tzt7TC3otfzoy3YW1utHt+XqMjuw03JuW3FlMKvFgfO7CQx5ESxLiHv+OyMLXxSNil/dUFwG5pAoh4FUXAokBTxxwU3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707594030; c=relaxed/simple;
	bh=r5wrUd3um7uKkGJHnNNGznYfB7o1Ys8ms184CE0FLBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvN0zXXKLrKVc+I2XdYad1AH02r1qtK+NQzf9BLv3S0BiMkDiyJY24gf0bD94emqhLAQaqXaeJqvdcScKVEooi1zLWEcFYqrzgDNhiDhYUPqXtB/9oAIkRdiASG11r6KFDFoQjq6Uv5rf33T66fby1kSQ5vYEuP6m/CNRiNkFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXx4L30f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93b982761so669045ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707594027; x=1708198827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzcidhCo+F6gBLxwDgBelCvN5KH6EoPstq5oHIcbBjc=;
        b=mXx4L30fVuIttR+MUym3IODTtq46W/9Lw0IayjuaD3L3pTcJUQoyOBCct3ssixBUKK
         HWB9mW+5m6w+QjSJCx9YURQDXUVgMJMn0A0MqsiZOVTPjpl4S9Aq3TBbPuE0ZfeexAlC
         tJFk+L5dHcDg1BOmkMebyJpGAeQICFEqpWGfpcyZPpNHUwIL2f2FsoHc12TBdSZ5xHtJ
         tIYfD3o/E26s+FPj/SqTWTnBvow7qj33CdKQLmaqBVE6r/yr+M/m/tu6EME0xRicWxHh
         BAEzva6t58CcjDcENG3stwFhpjyvCtjBjUcipWUEZe7viLGmzA5z5doZp1CgUzNZjyIr
         0ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707594027; x=1708198827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzcidhCo+F6gBLxwDgBelCvN5KH6EoPstq5oHIcbBjc=;
        b=VPqcQemSInEuFcu+Mt9cTiL5ZhMoA+WBONIyavGSq7g2I2M60MznO6q8iW1ObewGEj
         o0UOZNAPokKpL+Qi8Tpjd3YK/5T3JtxviUcU4unwz8utBIVbB7yiyG2UsRegnnVEtmZi
         tLuJwoAczfFTRDU+SEzWClLQAaljZ8I/Y5UGwIzJ0MFqIOSI+Ou9hPxMevpcB5t2rC/U
         W1CRBZ+IUBwkThDKBq7mrjVegIOpmoaOqOhdRTTN2XqakaqFRZt4Gd2fHCNdx27xGGDk
         jeF/cJJ9VPZ1dqbSnGzK2I0NfSj0rtpRt77FcLtkaO/Yh2KueDqmELaI6rNlO6gMPYIE
         9t8w==
X-Forwarded-Encrypted: i=1; AJvYcCX3RnslRvmKZ+nQQQwVhyIcoE204k0Jz/hEIQEO8tiSE+Dyc39oqMhjuorjZO07xWEqd0KmJ7vblhMUZtuogdQgt2AmxDlS806FWdhz
X-Gm-Message-State: AOJu0Ywiq0lV83pY8X3NSwr0noL/sRMSKlT1z8lyOTn2jnjdzvvk91gm
	r5qDuNwpK7bGOK7FxvxJO5zbODqLxx3RMr7vHBi9h8ElqhLqOBhB8l8+LA5HKCfCb3DGRdEUFvh
	W7FoUgRrzqeB1Vc0N/eoG0DJ+UOqCfAQ/syvb
X-Google-Smtp-Source: AGHT+IFZ4C4xgGhqwC1b1miGoFAeYDo6i0L6CdiMbluMyqeXV7IszQAynLz5F/Dd0JbjeLEjLloiOr0bc5aw4FCeeNs=
X-Received: by 2002:a17:902:b194:b0:1d8:eac9:bbfc with SMTP id
 s20-20020a170902b19400b001d8eac9bbfcmr66589plr.15.1707594027047; Sat, 10 Feb
 2024 11:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205104049.48900-1-christianshewitt@gmail.com>
 <CANEJEGuVPfdteBfY_LyQ+D=t4HGHLvDut-Vj2xFjRM4e8kgh=Q@mail.gmail.com> <D050DF05-8745-42E8-8ED1-890A4DC0380B@gmail.com>
In-Reply-To: <D050DF05-8745-42E8-8ED1-890A4DC0380B@gmail.com>
From: Grant Grundler <grundler@google.com>
Date: Sat, 10 Feb 2024 11:40:13 -0800
Message-ID: <CANEJEGtidrEyS9UvmgmBVJRG6hVqJ4ha-evzHoeoAKMn7omGTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: asix: add 0b95:1790 to AX88179A device list
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Grant Grundler <grundler@chromium.org>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 11:11=E2=80=AFAM Christian Hewitt
<christianshewitt@gmail.com> wrote:
..
> > 1) The USB output is telling you this device is a AX88179A : the
> > changes most likely should be in ax88179_178a.c using the
> > ax881798_info:
> >   https://elixir.bootlin.com/linux/latest/source/drivers/net/usb/ax8817=
9_178a.c#L1690
>
> Yup, having sent the patch some git grep=E2=80=99ing showed me the newer =
driver
> already has the ID for the card included.
>
> > 2) What Andrew Lunn said. I'll add the asix driver should not be
> > probing (or claiming) this device - or at least be quiet about it when
> > it does.
>
> So the problem now is .. I have both drivers enabled in kernel config:
>
> https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/RPi/device=
s/RPi5/linux/linux.aarch64.conf#L2324-L2325


You have:
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_AX88179_178A=3Dm
 CONFIG_NET_VENDOR_ASIX=3Dy

and
   CONFIG_INPUT_MOUSEDEV=3Dy

But also loads of other modules ("=3Dm").

> And This is a Linux 6.6.10 kernel boot (without this patch):
> https://paste.libreelec.tv/oriented-mastodon.log
>
> The card is visible on the USB bus but why isn=E2=80=99t the correct (new=
er)
> driver probing? =C2=AF\_(=E3=83=84)_/=C2=AF

I'm a bit confused too since the original email showed both asix and
ax88179_178a drivers getting invoked. You should have seen the same
previous failure with "Failed to read reg index 0x0040: -32". But
since the kernel timestamps were clipped in that email, I'm now
assuming the two messages were not printed at boot time (but rather
much later). Perhaps someone forgot to load the ax88179_178a driver
module after rebooting to their latest kernel build?

My guess is the root file system (linux distro?) doesn't include udev
at the moment. Normally, udev (user space) will "discover" the USB
device and load the appropriate device driver *module* (based on
device IDs listed in e.g. "modinfo ax88179_178a")

Note that asix driver is built-in. If CONFIG_USB_NET_AX88179_178A=3Dy
were used instead, the system won't depend on udev.

If my guess is correct, you might want to review the entire list of
CONFIG...=3Dm entries and determine which ones udev can help
automatically load (I would not assume all of them) and which ones
should always be loaded anyway (make them "=3Dy").

cheers,
grant

>
> Christian
>

