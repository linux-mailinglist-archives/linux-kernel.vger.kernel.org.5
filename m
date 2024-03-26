Return-Path: <linux-kernel+bounces-118258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA388B6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8604B2C807F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF992137F;
	Tue, 26 Mar 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itgmM2iL"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9182D80
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416984; cv=none; b=DZs0v2pIG20I6EqnFMEh/4XvmnTe67rz3UF5AKDm57Z1bc2PDqBgd11oAW/a/zWG5Uy644PbdRPpLw1vbgsZU6RosgtoTZEjnni7a7OW87BDNRDZj8MsMNfXu1BjQKGMWMPsXeTT3KJs3+9IgMGPehVvLSINfJyWBSTN/61xkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416984; c=relaxed/simple;
	bh=tCQybncCyylSiSFwYBDS7DYwZwG92wpYUyt99WynvKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVoHyNUglJ7Hd1KvhkyTArnKRXDuabtx0Xs01X/mU3bRnTAPlMm3UZYGQnVlBE0XXUBGxCXc7rZ9c9+rA356GCTUo0tqNFs2KG6jOin49DPqEXXM8yNdCKT+G2ShKwgQugvwWrb7hV9b05pVLiNGNiCkjBT3Kp2ZFgon87g/WyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itgmM2iL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-431347c6c99so79601cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711416982; x=1712021782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCQybncCyylSiSFwYBDS7DYwZwG92wpYUyt99WynvKY=;
        b=itgmM2iLNPYvoW6KnTo8S9KwMp+TjeQvrTiwrnJoVZYEpy9xF9TT5pzionq/1BuMqC
         SSFGc7E0Z11e3qNfUwb4VKcAKIpUN31ScGWGrJQMp4hr/AoIMHkB1Fi9l9gHmhc2cQ3A
         ehjNVqUyj6cf+fiCQdNCRoDBsnvSz3mXyLc0g561WUI1riNrGfUMKa26kRpEqDUpJ+vg
         cN0lMWPy3wkI5ERMJ7zy86ldJ+/+dHtzccXGA/wjTnHXcxbEUO7PzhljkYNX31E96iPr
         z1mBEEsBQM5u08Z2Q4PRxYnRsnYwg2FpBQTkOAImg62wsy3OIRfehYAMPMTdaLx4N8UO
         6ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711416982; x=1712021782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCQybncCyylSiSFwYBDS7DYwZwG92wpYUyt99WynvKY=;
        b=kMjo79caX83I4uhGLsSYILIDsdBqI/fdNekhXBBGtkgYGvPI1PgbtM9E8XM0QJE3qJ
         jtoinZ4pju5/N8pIkDMR5pvtIcjp/q/0QYsnTRN5SjBT6O/z1CtHXanjv4d0X9iWRQDR
         mGd1HhpAZeLdMEBKnzU3M51EZ2pJRWFMW0N0suC6wsDSPpZiHymCIp3aDOtINw1w506S
         R7UcXFmEjlcoUNJYsNowFTKGfffQBOZz6yPKmLM/FRkJqZvH6x7ms++br2/D0hFKZR6f
         Ca2VkcnGmZHcYzwMZU89jaWkidabzrrlTmIhSbxwZ8t0FqtMA9op0rjsm/z7X31UJOQH
         dU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpokKfxUZrQB3qFgSCaK8bISBW8+4+nbzf7Aioz1Khm9K8Xikx9cADGGo1aseAz4aIhhhv0AF2nf12pfMfvQga9TWlfBJ0HO5pIGO5
X-Gm-Message-State: AOJu0Yyf5yx7wUkt1hUpNJ4ryj+oFDKFHVV/2LF3Rm+XkiuqcB4eA3rn
	XlEk0gMh/YuGMjUJQTlShEMSiMX+p4h93tX6UubwzbwoaHb0iPvt401POo7xLwXAlLaSur5bv3u
	e9l+1x/HO61/O+ND30u2+/gPqkQEZDvFoaBpK
X-Google-Smtp-Source: AGHT+IGgGcwcgUzMgkYI2jlgeKoVTTvtP5lEBpDOK5cAEiTTvk606224kG1I/0QlbKwNkYXw5EAYik7Rk5X48MvaFqk=
X-Received: by 2002:a05:622a:6114:b0:431:3d4d:92ed with SMTP id
 hg20-20020a05622a611400b004313d4d92edmr29488qtb.9.1711416982092; Mon, 25 Mar
 2024 18:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com>
 <ZfvN5jDrftG-YRG4@titan> <CAGETcx8+vw0Vr0NWzjOAvxAZ07M4U7BWPAgO9avCngW0-9e_kA@mail.gmail.com>
 <Zf7I65PiOR2wX1Uo@titan> <CAGETcx_=MmfgDajM16iJ4Of9Yr2Sy6ZpU=MyhYgnmOJFUTD_oA@mail.gmail.com>
 <ZgIZ4LmFOqdiDJBH@titan>
In-Reply-To: <ZgIZ4LmFOqdiDJBH@titan>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 25 Mar 2024 18:35:45 -0700
Message-ID: <CAGETcx-Emvu41nB3UDnb4Gh2aJEKu_hFcHX89uWnBTnaqvpN8g@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: John Watts <contact@jookia.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:42=E2=80=AFPM John Watts <contact@jookia.org> wro=
te:
>
> Hello there,
>
> On Mon, Mar 25, 2024 at 03:49:44PM -0700, Saravana Kannan wrote:
> > Ok, I think I understand now what's going on. fw_devlink does not know
> > that "sound" device will not populate "multi" as a child device.
> > Typically in such situations, "sound" would probe as a device and add
> > its child DT nodes devices. At that point, the cycle is only between
> > "multi" and "test_codec" and fw_devlink will detect that and not
> > enforce any ordering. However, in this case, "sound" doesn't have any
> > child devices and just depends on the remote endpoints directly.
> >
> > We already have "ports", "in-ports" and "out-ports". Is there a reason
> > none of them will work for your use case and it has to be "multi"?
> > When you use one of those 3 recognized node names, things are handled
> > correctly.
>
> audio-graph-card2 uses 'multi' to define DAI links that have multiple
> endpoints. It also suports codec2codec and dpcm.
>
> > I think the right fix is the use of post-init-providers. Because even
> > if you do the above, all it does is let fw_devlink see that there's a
> > cyclic dependency in DT. And it'll stop enforcing the probe and
> > suspend/resume ordering. Ideally we want to enforce a specific order
> > here. test_codec first and then sound.
>
> Is there a way to do this automatically so all the existing audio-graph-c=
ard2
> device trees aren't broken? As it stands it seems like this driver is now
> broken due to this change.

Ok, I have a solution. Have the audio-graph-card2 find the fwnode of
"multi" and mark it as "not a device" by doing something like this in
the driver. That should help fw_devlink handle this correctly.

fwnode.flags |=3D FWNODE_FLAG_NOT_DEVICE;

>
> > Maybe. But the logs would be more helpful.
>
> If you have a way for me to get more logs please tell me.
>
> > > > post-init-provider =3D <&multi>;
> >
> > Did you try this? Did it help?
> >
> > -Saravana
>
> No I haven't tried this yet. I shall try it soon. But I wouldn't consider
> this a useful fix as it requires upgrading existing device trees.

Definitely do this though as a forward looking improvement. It'll help
make the suspend/resume more deterministic and will eventually let
things happen in an async manner.


-Saravana

