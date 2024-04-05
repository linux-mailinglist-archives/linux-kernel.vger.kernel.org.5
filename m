Return-Path: <linux-kernel+bounces-133548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2C89A56A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCA3B22084
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E93174EDD;
	Fri,  5 Apr 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCJ/qFeb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44016174EF8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347562; cv=none; b=P2HbSkiy5eBArJgV04KFkI56R1qS4tDhf4AclSXk+CgIS4F/UWFGqoKCZaH9+ei3dEZhpUH0WTXIshLRfLoLr3Dz9EeeIyUgxQmZXPqiRKlILyL0I2424EM/6bYghAmTS4q0JcIPJL8+gCWjUTPsfu6CZsm48KGJjxLJUbdatkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347562; c=relaxed/simple;
	bh=aZki4TfPwDkvdYS02LiKAexZWstbc7W5iiznpEznJCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnOzSfpx/nitKSzxA63fVpbh8RUYvWCJJT67qg6Zq1+pBGY93vt2SzCO61IM89epPRGyqbg/VUM8uRRBVscjA2Rpi/IgFge8tSKS1vqt+83WEOsfzb+TQKaJdwnAPGcN+Bgf5vCFtNEkP90WOeCedhAQdt4fULPSlR1XHOxD/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCJ/qFeb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712347559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LQPR8cQsAWIk8v5bAbPLYAAkL3bLLoRC33NWFZgcXWg=;
	b=MCJ/qFebxcj8P/U1ivc4NUH+4gw95H6Kh+Cgq4BzVCPcGfkbRYCwwILqcIgVINvxJiGz3U
	q5L5pBnAF20CA1rhbU/2SP5dWB0IC8d6K4AtxzLwHVytibDfn6Dw5nxuzbgI6CjleweBFn
	WECd3Pd3WqiLR9NmHlbbECmTHROZu/U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-rlGTDzS6NuWoT82UFI53aA-1; Fri, 05 Apr 2024 16:05:57 -0400
X-MC-Unique: rlGTDzS6NuWoT82UFI53aA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-699481d14ffso4762696d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 13:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347556; x=1712952356;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQPR8cQsAWIk8v5bAbPLYAAkL3bLLoRC33NWFZgcXWg=;
        b=rQU8M6EuyPG8PztOBykO77vM9eKzeq27g45tLw3HwcdsIN+BafvahgqvahZCyUoFff
         TTwjZ8cKc5w9z9WotFbDhkM122mYfLubZbIEuuCYdYefH/rPGZt4p5sK2RP/lEPrWqAg
         ZOZ4hMUuCZe1G8C6djl9cUpNviwfs49TV2K5CF64fJxA+Fn4iF43ZKoWq5GXam12XuBQ
         nkfXeMI75oLqkbZffykrxnmTTzHj1RM0hbOEcnwvRmOWFXTEeJ1FD9TjHtc4lv1nZMJa
         VoaBICYWIQxvyrNYd+mtj2aDkIVNeZXEYOC5us62x8HT6wUC4lISv2G5J4W0cgJk1ngu
         Fx0A==
X-Forwarded-Encrypted: i=1; AJvYcCUE2akAeyZICngY78vtI4SZdWNFaectpfk7FiLfTCUH+SoRdJuWA9TrG3OTWmAavTyl3QYR9FQX7Ur+B8cTtPy8qo1U1GnNmKft47dT
X-Gm-Message-State: AOJu0YwB/fbtz3IoHxwxR8S5O7SMUqhewuPbVlWi+DMhvPyfF12gzqig
	Jsg6G5fK3k+0vBsl7BGi+ejBPdR0+skh5ah2PyT9vtu4G3QHSsw7+xMMPu1SaouMXLrHzuoyOpn
	zv6C6Q0/jxJ8NI6xBP1Exob65fS8CkCl5K3KcirI2MljglsBogoLDg9QirTimVuIsuKp1rg==
X-Received: by 2002:a05:6214:19c4:b0:699:2886:edae with SMTP id j4-20020a05621419c400b006992886edaemr2886845qvc.55.1712347556536;
        Fri, 05 Apr 2024 13:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5eGch6dNEmAc8MwWgrOSCnmtpD4Hu+37ldgdM5VaOh9+abEcHU5DXNrdRIiMriqSuT1gmeg==
X-Received: by 2002:a05:6214:19c4:b0:699:2886:edae with SMTP id j4-20020a05621419c400b006992886edaemr2886833qvc.55.1712347556278;
        Fri, 05 Apr 2024 13:05:56 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::789? ([2600:4040:5c6c:a300::789])
        by smtp.gmail.com with ESMTPSA id du12-20020a05621409ac00b006967ba7f1adsm882394qvb.96.2024.04.05.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:05:55 -0700 (PDT)
Message-ID: <11096e558e67f2fea2aee976c70a19af1b7c212b.camel@redhat.com>
Subject: Re: [PATCH] drm: nv04: Add check to avoid out of bounds access
From: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@redhat.com>, Mikhail Kobuk <m.kobuk@ispras.ru>, 
	Karol Herbst <kherbst@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Francisco Jerez <currojerez@riseup.net>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>, Alexey
 Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 05 Apr 2024 16:05:54 -0400
In-Reply-To: <c3253f8a-e654-4016-b0c6-d92703107c48@redhat.com>
References: <20240331064552.6112-1-m.kobuk@ispras.ru>
	 <c3253f8a-e654-4016-b0c6-d92703107c48@redhat.com>
Autocrypt: addr=lyude@redhat.com; prefer-encrypt=mutual; keydata=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
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 17:53 +0200, Danilo Krummrich wrote:
> On 3/31/24 08:45, Mikhail Kobuk wrote:
> > Output Resource (dcb->or) value is not guaranteed to be non-zero
> > (i.e.
> > in drivers/gpu/drm/nouveau/nouveau_bios.c, in
> > 'fabricate_dcb_encoder_table()'
> > 'dcb->or' is assigned value '0' in call to
> > 'fabricate_dcb_output()').
>=20
> I don't really know much about the semantics of this code.
>=20
> Looking at fabricate_dcb_output() though I wonder if the intention
> was to assign
> BIT(or) to entry->or.
>=20
> @Lyude, can you help here?

This code is definitely a bit before my time as well - but I think
you're completely correct. Especially considering this bit I found in
nouveau_bios.h:

enum nouveau_or {
	DCB_OUTPUT_A =3D (1 << 0),
	DCB_OUTPUT_B =3D (1 << 1),
	DCB_OUTPUT_C =3D (1 << 2)
};


>=20
> Otherwise, for parsing the DCB entries, it seems that the bound
> checks are
> happening in olddcb_outp_foreach() [1].
>=20
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/no=
uveau_bios.c#L1331
>=20
> >=20
> > Add check to validate 'dcb->or' before it's used.
> >=20
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >=20
> > Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for
> > iMac G4")
> > Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> > ---
> > =C2=A0 drivers/gpu/drm/nouveau/dispnv04/dac.c | 4 ++--
> > =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/dac.c
> > b/drivers/gpu/drm/nouveau/dispnv04/dac.c
> > index d6b8e0cce2ac..0c8d4fc95ff3 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/dac.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/dac.c
> > @@ -428,7 +428,7 @@ void nv04_dac_update_dacclk(struct drm_encoder
> > *encoder, bool enable)
> > =C2=A0=C2=A0	struct drm_device *dev =3D encoder->dev;
> > =C2=A0=C2=A0	struct dcb_output *dcb =3D nouveau_encoder(encoder)->dcb;
> > =C2=A0=20
> > -	if (nv_gf4_disp_arch(dev)) {
> > +	if (nv_gf4_disp_arch(dev) && ffs(dcb->or)) {
> > =C2=A0=C2=A0		uint32_t *dac_users =3D &nv04_display(dev)-
> > >dac_users[ffs(dcb->or) - 1];
> > =C2=A0=C2=A0		int dacclk_off =3D NV_PRAMDAC_DACCLK +
> > nv04_dac_output_offset(encoder);
> > =C2=A0=C2=A0		uint32_t dacclk =3D NVReadRAMDAC(dev, 0,
> > dacclk_off);
> > @@ -453,7 +453,7 @@ bool nv04_dac_in_use(struct drm_encoder
> > *encoder)
> > =C2=A0=C2=A0	struct drm_device *dev =3D encoder->dev;
> > =C2=A0=C2=A0	struct dcb_output *dcb =3D nouveau_encoder(encoder)->dcb;
> > =C2=A0=20
> > -	return nv_gf4_disp_arch(encoder->dev) &&
> > +	return nv_gf4_disp_arch(encoder->dev) && ffs(dcb->or) &&
> > =C2=A0=C2=A0		(nv04_display(dev)->dac_users[ffs(dcb->or) - 1] &
> > ~(1 << dcb->index));
> > =C2=A0 }
> > =C2=A0=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


