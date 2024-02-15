Return-Path: <linux-kernel+bounces-67838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0D8571AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B517B2822BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C54145B03;
	Thu, 15 Feb 2024 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ2LCX9M"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D292134A9;
	Thu, 15 Feb 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040289; cv=none; b=CCkAqWbEa2ZXuFGsVBqHvG71jZE7gQP+Yt3HwTis9kQ/i29kmwjnhOmF/VUSBEom6QkVu8lgzFDIKJ31kVC6FUb1lStQVcZYMKmSRELDL+8IN1z79eCGpbuNnNs09XocOLoaebDTheeDK0VFaBLyk8Sz1ObLoA31hPfEVgMJEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040289; c=relaxed/simple;
	bh=lAwbLH+YuLyNu83haT3aFfF56WV6stZvfsGcAp1CSAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT+oijRiJKgPUfVsclW6MEjiZf5xpE37UfDiL3GgN3rhykzxup1k5ZioCVtvAd0yZ1qbS4O73AnX2+kmmMYL6oktz5hvjbdFz0bHe9Gp3Eptt/sbTbKI59/nZ3gA2eGCnTB03Dcj4Edew8/aEtfgM68PLnO5mW+U0tJvRdLQMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ2LCX9M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33adec41b55so659897f8f.0;
        Thu, 15 Feb 2024 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040285; x=1708645085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ1UpqZjcTjdMt5iJXgrg3IRkY7u54tAu2yazi8L+wk=;
        b=BJ2LCX9MEsXusA3GT2jnqR0gTJjnpHLi9G/bzgMTbBI055bJgC7CH7lmaTqNyVULq6
         lK7EEHDwWe+JCZFf1I8LlpAx50pKNPsWFHiNslZ8o+SrIac4hCoXvGTDALVE9ekhZz7o
         4adduUQEfc+Xu1i7jrU2IglRO57nBEP/qLrZmbZHAXJLnZuhq71iRnlKDkmK8mrYry3u
         rHgliMJUOS/YzMgnpSAiLbnQpr9gvnqtkbatxtIGx7cXOikzfdcadn0SESpc5Gn1VDvJ
         Nhqw+o6YmdpKhYt+BLivqXxWHvbgpLnnAf5HE+rxbHJ/LiFvUGrwwKvZT3OkoxtZy26a
         XaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040285; x=1708645085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ1UpqZjcTjdMt5iJXgrg3IRkY7u54tAu2yazi8L+wk=;
        b=A0OBdMIZNC2u6jsD+JqxwWBYNkvhbPABkuCvCDTkdfncZhy8yKoGtq294zqi9b86fx
         DcQqk4D6kV17JPsPukxQEJTBpfPqHTQGtwAYcv3mX/mJoYOW9jrAe1LMhZWLb2nwV2db
         s/zhU/RpN65lnOQSwcAyS/aadSIbUvlCHTSahgcd5quCAX7Xbz0oVZxY1lxDLelK7Wc+
         NMZik6Ra9NksFVuDw3IJn5dOCm80htrnGflDbZ8vpYSZ4lJPta9OWjNlS4pjCkPXCPR3
         mllzFDmnqfi3TLeVJAqcRznoSXEO+plVTpCBMhhIpdUbFDhDC3h7Fc43n1726cukORSJ
         09Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVtHvywUgSSu9E+kxePPExtKx9BnRrV+K9+vZuFlMptTH9M4WkWEk3fvTFX1H6iHQzZxABGQ2o1TjAfPTzjfMP0Ie6n/F6Fr4fud8EGXFM3Z4wBXCkZV0nzU0RkSWOfqgMrUbdr+cTN
X-Gm-Message-State: AOJu0YyaI0t2PKR7NIXMPdH4Z2mi9Ftxz5NhKyop0VEt9HHM2VRsXdkx
	kmymhDzFGjxEeh1EegQhCz+vtCYMJl/20WF1/12NSAuCd6F5wXZnRaaRG6YWjf6k4SGQfbqZYsF
	1CAP/6yBZSOtiJbPlMK2OGEGTAYo=
X-Google-Smtp-Source: AGHT+IFP0211wjcLzhB2cXm9hv99S7cAT3vssfXQ7IfNuojJGF9sjftBD6nm0tvm5wXMbxFXZNPoeVSwe/Eri072H4Q=
X-Received: by 2002:adf:f591:0:b0:33b:51a0:4dd3 with SMTP id
 f17-20020adff591000000b0033b51a04dd3mr2432157wro.17.1708040285619; Thu, 15
 Feb 2024 15:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848C52B871DA67455F0B2F2994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848C52B871DA67455F0B2F2994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 16 Feb 2024 00:37:54 +0100
Message-ID: <CA+fCnZeo3dksyFgM5w=gz7Z_djG-ddesDQ4dfhqAwosNy5+1Hw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, kasan-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:17=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch adds CONFIG_KASAN_EXTRA_INFO introduction information to
> KASAN documentation.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> V1 -> V2: Fix run-on sentence.
>
>  Documentation/dev-tools/kasan.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index a5a6dbe9029f..d7de44f5339d 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -277,6 +277,27 @@ traces point to places in code that interacted with =
the object but that are not
>  directly present in the bad access stack trace. Currently, this includes
>  call_rcu() and workqueue queuing.
>
> +CONFIG_KASAN_EXTRA_INFO
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Enabling CONFIG_KASAN_EXTRA_INFO allows KASAN to record and report more
> +information. The extra information currently supported is the CPU number=
 and
> +timestamp at allocation and free. More information can help find the cau=
se of
> +the bug and correlate the error with other system events, at the cost of=
 using
> +extra memory to record more information (more cost details in the help t=
ext of
> +CONFIG_KASAN_EXTRA_INFO).
> +
> +Here is the report with CONFIG_KASAN_EXTRA_INFO enabled (only the
> +different parts are shown)::
> +
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    ...
> +    Allocated by task 134 on cpu 5 at 229.133855s:
> +    ...
> +    Freed by task 136 on cpu 3 at 230.199335s:
> +    ...
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
>  Implementation details
>  ----------------------
>
> --
> 2.39.2
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

