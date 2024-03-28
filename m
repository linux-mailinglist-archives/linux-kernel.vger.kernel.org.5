Return-Path: <linux-kernel+bounces-122397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001988F64C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D7DB23B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4A38389;
	Thu, 28 Mar 2024 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IojfJj1P"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA81CFB6;
	Thu, 28 Mar 2024 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711599748; cv=none; b=DNI/4qMgVmaYndZdjpQ4EHUSzuae6XevRamDk4ekSMlZFeSVsLom8sgAYOt3l5sf/Vrsl8taQbMNYsB1mADdKqu0LnSD37+VHLx6/R7Zkc0HpeG6GfRJiCjSdIz9GjvWfjmUGM9EtN4Llcky9u/iUQclkoaoVWgys9MI3O4ZHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711599748; c=relaxed/simple;
	bh=VrgOkQEO/xXHi0VxwHtrFcorWv5kNZWIJwBfQjY/Fnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr9qSdTFU0JqIAJ2fI9p+n4iQ7/GboKPmADj4H7C2ab/Eqz1CbVs66AYcZvEtRCMdG/Fyc+yLn+YFqmcRmlFORlRqZJ4+G65XFs3aDZg8IPBy3v8LmZAdNmzwBFm8oawRgUPIXzeWttiZW+JJhSXgxHcoNJj6d1F+8Eln+5E+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IojfJj1P; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7dec16fc4b2so124379241.3;
        Wed, 27 Mar 2024 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711599745; x=1712204545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0+XG9kxnjTaWBVgFwj0PcuoUonk1b0BDImgIwR/heI=;
        b=IojfJj1PEiZhppq39Ql6DQlqYJ/CemE6bQp9+S7OAUSRrCWiip8ulUiTp154FyHbBO
         CRDrlWzIgnSOMaw+MNCeodn7Cx2Z1zRnuy32edj949BK7OA4UsaTpwQfjbntV+iklkY3
         Vt06cli2glkkqcwY+ZL8aIkc9mer+5UW3WE44cfG/r4WVN4GQB0kvxAQVpUKETzi5aW4
         tiMATaWcrCD/ZEEsBL1sFihobFOSQ5fvPGjc4KKHeLvwEcc7cXASQvFZm4/UalhjrrQW
         UWRGhDhE8ezgfCMikG+izLBqn3EqvFwFUkHZwrv24yUbk9DxQvYrzU4Q+0D4ipcWes4i
         RF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711599745; x=1712204545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0+XG9kxnjTaWBVgFwj0PcuoUonk1b0BDImgIwR/heI=;
        b=mTZFwkIlf0WJYRcjg3EztWi3+F2xrUEgkiz9+FEVs+2O4k7LKXiwx1gew+lEcoH/Wi
         iYuEPebvryTtB/PuA6IrfjQGWOg73pZhnbJFIgtP1bG4/TsRvotw5xxW/3Rkulfo4gS2
         y8Z3GxOLPVRo044m43giXe6Gy3gqI5RLkRewhHBEdnr3l/MAlMGR4quWbQb/+Dd50oF4
         VvgrGfWPbetkzzWjagavNp7XmuqklMfmMYscxjR+86J9kiU/9WtsUwESwuH2A203MGhM
         Gf368rZBrAZC+765/16zT42aVFrnXeMjpOUMpfv1M/t2O1cR1KzoPDY2RV9HudaFrlOw
         zzpA==
X-Forwarded-Encrypted: i=1; AJvYcCXHgBd4n0IMLvJ3yyvG73NNsEfClS02EF3oZGNQN9UlMXVHMYLyrp9QLbjKYaowoPAcT+sqfzQjmSSJ7wpqXIuW1b+/JVUPoZI2uqvt8zdYMViUniJjFMPcOTkOSl5piuYhiEh1lsoYOKATfhgrbfazBEo9lyyPFBWz3QEOCBu+z33D
X-Gm-Message-State: AOJu0YzrZrvOjsP3okQUuNq5cq52OwvVBkO4MeFuvwDDZxCjdI8aFhku
	8oyZmMTsI7Kqt2DAWkxtUqch8oKdZ4PmickgjCNmNBW2vrxQdopvaRLn/NijhAqY6j+X0iTtaeZ
	BggSMjYIxlxK5Ig+i9pNWs7oKYLk=
X-Google-Smtp-Source: AGHT+IG4I5xGnn2HQK2Ql506Ah/ABIDM5elyySVqw4MLU7VfWrcRa+tcfFuSim+wQiS7/K7PuRtrj+DHclwaqD0nrbM=
X-Received: by 2002:a05:6102:464f:b0:478:2503:4071 with SMTP id
 jt15-20020a056102464f00b0047825034071mr2059462vsb.3.1711599745441; Wed, 27
 Mar 2024 21:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328022136.5789-1-21cnbao@gmail.com>
In-Reply-To: <20240328022136.5789-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 28 Mar 2024 17:22:14 +1300
Message-ID: <CAGsJ_4xfCL3kVDDRNCba2f3+EvOMTGpBW8hkS71ZcvB5UeWZwA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] codingstyle: avoid unused parameters for a
 function-like macro
To: akpm@linux-foundation.org, mac.xxn@outlook.com
Cc: apw@canonical.com, broonie@kernel.org, chenhuacai@loongson.cn, 
	chris@zankel.net, corbet@lwn.net, dwaipayanray1@gmail.com, 
	herbert@gondor.apana.org.au, joe@perches.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lukas.bulwahn@gmail.com, sfr@canb.auug.org.au, 
	v-songbaohua@oppo.com, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:21=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> -v4:
>  * fix Xining's email address, s/ma.xxn@outlook.com/mac.xxn@outlook.com/g

Hi Andrew,

Apologies for the oversight. Could you please apply these two patches to re=
place
the ones in the mm-nonmm-unstable branch? We need to correct Xining's email
address regardless.

>  * fix some false positives of checkpatch.pl
>  * downgrade from ERROR to WARN in checkpatch.pl
>
>  Thanks for Joe's comments!
>
> -v3:
>  https://lore.kernel.org/all/20240322084937.66018-1-21cnbao@gmail.com/
>
> A function-like macro could result in build warnings such as
> "unused variable." This patchset updates the guidance to
> recommend always using a static inline function instead
> and also provides checkpatch support for this new rule.
>
> Barry Song (1):
>   Documentation: coding-style: ask function-like macros to evaluate
>     parameters
>
> Xining Xu (1):
>   scripts: checkpatch: check unused parameters for function-like macro
>
>  Documentation/process/coding-style.rst | 16 ++++++++++++++
>  scripts/checkpatch.pl                  | 30 ++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> --
> 2.34.1
>

Thanks
Barry

