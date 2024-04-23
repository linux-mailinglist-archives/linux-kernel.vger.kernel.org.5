Return-Path: <linux-kernel+bounces-155817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97188AF787
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1881C2212F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AB1420C6;
	Tue, 23 Apr 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdu2aV+M"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83F3EA76;
	Tue, 23 Apr 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901753; cv=none; b=YTOQDW1lxCbcCuh7X2BBNactgysKXcJvbhnAHetpMjeUV/qVaTUMt4c6vhm2Qn8fIO8j+UjMdtb0vDAXWifWR/0JMzSnBXA9qNJDgK8uHAGhq4/LPXSstSIHLV5bBmfQNEK4XnwiJ55frS1hRA3+WB6GpvyVmM9j5b0LYAT8JOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901753; c=relaxed/simple;
	bh=R1ZURLb495Du3AxkRPzx1pKVdtAWJPLJaeRFU5Giv8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNB6VwLAx9MR5prNtxu4JG5+MJENblyNjpgPrvrU3fFzKb9+yyoz8J63LRywYaL+puBDqWpZtJgsJVjCWbL6hfDhPH/0gOgjyHhfjHLu0jnKoarWbMzqmRYyO7mUzUs0SNzZpFHcGjosyyQ9DJElQRd3wWxEAJNCs6DEut7icgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdu2aV+M; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617d411a6b3so51822637b3.3;
        Tue, 23 Apr 2024 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713901751; x=1714506551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3IjpaYkptTljaPwPSsoUcmzfDh/fWSuLG2EX75WmRI=;
        b=Vdu2aV+MQ69lsaQxT0vfeQYbaH5JFPpd6j7zMFUmLBJtGkDFM8pLVpmxCPNP1scfXr
         FBQu+qe5UQW68bW7FEWusXUJRM2YA9buIxM1EuD1ePrXvWXmM2rvSNwTXGBwpqE/3zJg
         ftmUljAsobXRXzkDYAXb6pTX1+GOUUxypA4kL3jJ6Bvl5Guv4hpkTmjoTLxoPn2RA1VU
         OMncDGNxEiDrVvkn0rDNnGnYUMxtSAZGvCccC51yr4RWRre5mzy1sqeJxXBbQh1kPkHk
         OEM1rST83/KrS5nijBF6EkZmet26CvnPsHBJ33iTv/r9i1YHZyYslC+2I5D5fQJ5KeNB
         gTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901751; x=1714506551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3IjpaYkptTljaPwPSsoUcmzfDh/fWSuLG2EX75WmRI=;
        b=lsXAokmgKL8J+qwAhLlCrwcg9uIzYEVTGTfNY96rTTWSufmYW+bzXYhVFYzeKQX4DX
         V+jhpI03EIawnGSADjCoRDlAB6VwfVHRXFkNo7RmCjy+8hBAiWD8AfA/prQwnrBuHK54
         L5DXJPxMhl63wgrF9xnYft+L29v7qTAUA5yzqfkUFIBWzdhZ/tnU1Hxd6A6ODzSODr+9
         bYIkQMKtlXn8PV7rIS/0qB4vbsXM5mTkrG/URKXbqHiix93OjmKvK9irKCjk2CVoi2OK
         lVCzO09hyIn6Jm58Itr8mzrtHmbQF24MJ3W09Gogsx1lz8dMUEJSXZbday5RdLZ+gFO8
         OQfg==
X-Forwarded-Encrypted: i=1; AJvYcCXzmQgV57IPD5+qJ7yXvLwtdnyGljgeZG+uBmVTK5tIqkxlLAfc+Lm0THtvPyfZhsGlE6Dw2MJuTXftZq2whO8I8nIi9egmNWDmap+aYW3xq0EL5At0xNwXCWxGqOOutqPro4ONZFBCZw==
X-Gm-Message-State: AOJu0YzAj5W8LeK8Gltz+62ARAJJBHzFofo2+aFn62sichg6fqYXGxWC
	lyF3Xxf2BJOybbMUszhG0R01KtB5z611X0JqE1m4nQ/nshEUXBjefU/L6cKPUeCicEIZm+NoNq6
	rE+cnNnkwptCoZy79UrSoX5/uYyI=
X-Google-Smtp-Source: AGHT+IGapHT2J7yyfuG3DOtiPCDkiau57zJ2A3tToGUgURvaGTDd0iESNWmcwul6kB7LIQG45tpfY5VV/PITEgtr1TI=
X-Received: by 2002:a25:bfc3:0:b0:de5:4a91:11c4 with SMTP id
 q3-20020a25bfc3000000b00de54a9111c4mr638758ybm.44.1713901750572; Tue, 23 Apr
 2024 12:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328191205.82295-1-robertcnelson@gmail.com> <1a5e719f-efa0-4c60-8add-ef7c0464d1ce@ti.com>
In-Reply-To: <1a5e719f-efa0-4c60-8add-ef7c0464d1ce@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 23 Apr 2024 14:48:44 -0500
Message-ID: <CAOCHtYjHhH2M_+7md-e2vh_d_3H2r66OhXEp2acd0D+6O+uwcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
To: Andrew Davis <afd@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:57=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 3/28/24 2:12 PM, Robert Nelson wrote:
> > This board is based on ti,j722s
> >
> > https://beagley-ai.org/
> > https://openbeagle.org/beagley-ai/beagley-ai
> >
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > CC: Rob Herring <robh@kernel.org>
> > CC: Nishanth Menon <nm@ti.com>
> > CC: Jared McArthur <j-mcarthur@ti.com>
> > CC: Jason Kridner <jkridner@beagleboard.org>
> > CC: Deepak Khatri <lorforlinux@beagleboard.org>
> > ---
> >   Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documen=
tation/devicetree/bindings/arm/ti/k3.yaml
> > index 52b51fd7044e..ca23b7e6a35e 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -134,6 +134,7 @@ properties:
> >         - description: K3 J722S SoC and Boards
> >           items:
> >             - enum:
> > +              - beagle,j722s-beagley-ai
>
> Recommend "beagle,am67-beagley-ai". The "J722s" is the family
> name, the part used on this board is the AM67. We do the same
> for the SK boards, for example, the SK-AM69 uses the AM69
> part from the J784s4 family, so it is called k3-am69-sk.dts
> with compatible =3D "ti,am69-sk", "ti,j784s4";
>
> This would otherwise be the first board with a specific part
> attached but uses the SoC family name instead of that specific
> part name in the DT file/name. Only the EVMs should have the
> family name since we sell versions of those with all the different
> parts swapped onto it. I don't imagine you will be selling
> BeagleY's with TDA4VEN, TDA4AEN, DRA82x, etc.. All your
> docs and other collateral use "AM67", using the same here
> would help avoid confusion.
>
> Andrew

Andrew, would you like us to model this just like the AM69-SK? and
also rename the device tree? or just the bindings..

k3-j722s-beagley-ai.dtb -> k3-am67-beagley-ai.dtb or even the am67a
k3-am67a-beagley-ai.dtb ?

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

