Return-Path: <linux-kernel+bounces-108407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC56880A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A5128367C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23611712;
	Wed, 20 Mar 2024 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRwI6tkW"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C010A16;
	Wed, 20 Mar 2024 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710905084; cv=none; b=pFcBKjCT7ueRMEF1MgVFw0OvEhCMWoF1IQBrl80IjN2Drw355rSIMIWJCxgOEswDxWmywJWJh4e7AGGoo7Yer9v3HaZdomKcmceNH25NMz7Tx53v4RzD8dIH5e6wSUGSe+wLMTEJSCUEVeX2WGiTYspxgeoElEiEqnoeYRJUMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710905084; c=relaxed/simple;
	bh=D59GAJ1AzXtD/GLR6ElupUyZeEpxDaSeHjQxCdY5gds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6zeoPwk1oVvTk4HJ2CaH2h8rVucg5mXf5DKFd0KQ4l/UvZc24od0saz1OnNOt9GGDSZ6dCoQEZyh1elgoFWBo1NzLoNY4/cvaxkHPcVqSyOQ0pgRJ/N/3l70mR6aC5SyILdm0VeqlfPIk+/3h8g4K1SngotKMuJvEjILr4hZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRwI6tkW; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-476614cb2e7so1551121137.3;
        Tue, 19 Mar 2024 20:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710905081; x=1711509881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idlCMFXNuFejWR75EH4o3Jd4D0X2eAgD74wYscMMvK0=;
        b=nRwI6tkWIwX8xKlSGnFQqnuvD0O1zgk4PaBs52r4QEruDsgscy0olZGmDCuha7L14H
         FMJEZJHBu1jhYYuHSmhCuwrP28RSkD89AM/7y5XVkO0KJaPCybbY6hBve8+q85HPmRmz
         rkdhusK2hY7G2Z0TZeCgLxy3C/jW7/OJEmBfxTghqIPRDOgoyMMMGICj/sIsxOHlGQWa
         bYu7b7xla+J6vIzWF6p8D5a/7SXeL8E6a6OW5fMP+dubyxZHrV4dbACUW7C9DFgGg5ru
         9vP4DAZNHzOE6LS7/ZCNTF87K+A+5uHlXbOfxwdjiEsEx75o+qPmkfDJVM3ZZTT1QHAB
         PCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710905081; x=1711509881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idlCMFXNuFejWR75EH4o3Jd4D0X2eAgD74wYscMMvK0=;
        b=jI2sAaSxUYPT+K8R4MABKoy5sehCThigWybA6m9z1iy47xKRBbwbZRv2TdJdqjHkBc
         1ESo4o4NzbQMCI5g6J8KI73AjvF1ZrxNHGiqVNTDrZiajINtdhs1q9pWZPGPqPTv5J1D
         tWDcqdQ+yQAHfvNjlxxQ/jN64uvE5pLKkMGbgQ4Qp1b4gZXhHAJGhnVodTxuDPx/WJmq
         dNA69tdBQYCPPmgIqBJNrz4HAPzMZPB8wE7ezfBsKqL0TqUjxV3I/OdA31gUYpN0RbQQ
         VDVL46usuKyzH1ml95PRXL3lG2XlU6f0Xr8e70lo9UFJxsCfH0RspgwWcQ1OrHir2F3P
         cLDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsRoEkbIyqQSDODP5Nav36hEi6CYDESzvCrZ7138wb5xi1PWSfaRl2U8v42IK5868fB/usPK+Lhe4DEBpTeaoJqvP19hjUPtZJZaCbUzTzf5Qo6KwF/8L6i8SDfVi0dLdM6xLN+YIQUnQ3gjWYwxXa6aHL61/MV4etcZVAgdqRZhRo
X-Gm-Message-State: AOJu0YynH0p4oRwipqLL3ws21v8K5gFSDN6Jwc/mgOTuoLKJrXNh99Oj
	dBPv90YaVD9H3ONbX1HNWYPFs9jgtk5N0+AkXO5EOBuTzIGaJnJZN5LCmL2hs9N+xc9rHjhOgac
	5lczDpU6LMmcY8raq3Zm1PsM4mvA=
X-Google-Smtp-Source: AGHT+IE54XPM+6CxDfMBnxGZUoNyUrjedX/RbgulELe30gfXn4v78uLTA+JeCHO7O0BLIb7UMT9ZC3ky0pzAoskt0c0=
X-Received: by 2002:a05:6102:82f:b0:474:d154:223a with SMTP id
 k15-20020a056102082f00b00474d154223amr13828456vsb.33.1710905081590; Tue, 19
 Mar 2024 20:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320001656.10075-1-21cnbao@gmail.com> <20240320124207.0c127947@canb.auug.org.au>
In-Reply-To: <20240320124207.0c127947@canb.auug.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 20 Mar 2024 16:24:30 +1300
Message-ID: <CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,
Thanks for reviewing.

On Wed, Mar 20, 2024 at 2:42=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi Barry,
>
> On Wed, 20 Mar 2024 13:16:56 +1300 Barry Song <21cnbao@gmail.com> wrote:
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/pro=
cess/coding-style.rst
> > index 9c7cf7347394..8065747fddff 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed=
 in a do - while block:
> >                               do_this(b, c);          \
> >               } while (0)
> >
> > +Function-like macros should evaluate their parameters, for unused para=
meters,
> > +cast them to void:
> > +
> > +.. code-block:: c
> > +
> > +     #define macrofun(a) do { (void) (a); } while (0)
> > +
>
> Maybe add some comment about using a static inline function for these
> simple versions instead, if at all possible, (it is suggested just
> above this section) since that will still type check arguments.

right, what about adding the below section together with the above (void) c=
ast?

+Another approach could involve utilizing a static inline function to repla=
ce
+the macro.:
+
+.. code-block:: c
+
+       static inline void fun(struct foo *foo)
+       {
+       }
+

>
> --
> Cheers,
> Stephen Rothwell

Thanks
Barry

