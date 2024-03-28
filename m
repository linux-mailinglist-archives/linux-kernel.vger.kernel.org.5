Return-Path: <linux-kernel+bounces-123674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868C890C77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB580292167
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F881725;
	Thu, 28 Mar 2024 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1yOaccN"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568541A80;
	Thu, 28 Mar 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661058; cv=none; b=JFNG1uXQix7OLp5fS7me8U5KdD+wta1YNAmfNqhtvcs/JT8WY8dh9/ibu96k1pziRgzl8VlzsJT69ODV0gjvplqJKJLsIjg1pixNf8fDlM8oyGnYFk5DSbVsjCC/zKQtRphbLE3oErPHWWreUusZfwRAcdoeExsGTMQPKruH5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661058; c=relaxed/simple;
	bh=kfkZvWjF9vS6giOrKTL+yJfHs6neOrDFR/i/hESEEHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCCVaSbeV1T46MQyVFnMTvll0EYUlTvIWM6d8vZoSV57CQB89m7DVpeBWNQe1Q/L3VxFXzzIbMXOEBD2Xb7iroSxzWcnSc3D8NROpqVSGO+haklKnFAa/Znn7wfGOhO2Dzt+lTUQqw+/wafZ9THEFIfCUfPw6Agm0kwhTrw7L54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1yOaccN; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d8c5cc6d58so284116e0c.3;
        Thu, 28 Mar 2024 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711661055; x=1712265855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FDBCSehTgYY3B2vfvWYcnP5cnNaGJ+D90cjGDdfwFA=;
        b=Q1yOaccNq5N0dIatm9i/in3Bev5+CB3FwSApRtGGjBq6jDqGGh4usoCvgTZuxLE0Wx
         0yW1BmvfkCH7p4Bx9arnmYd2DwaQVsp7jKK0Cz6jtkZRCXIBRv7fhZhX30h5ydfEOnio
         vEyLEA76XKjXAreXBj6bROyaGtel8ON5Zvq1wgVeSllUhM7IThgCCHOyOKxp43btTAP6
         49NtVsWzN/RxABxdge9EPAkbxfozOO4hbsU+YHbLepBz+G9JpEy6tnXo3eDS1SluoaDA
         9ny6gXaHGtNobTy/KVk1mqxd4p7aOof+8R5SSEGcAJUpIujFKGlmZnmUssUOi25jsuiQ
         M3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711661055; x=1712265855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FDBCSehTgYY3B2vfvWYcnP5cnNaGJ+D90cjGDdfwFA=;
        b=e6XH+dCg4HdcdphoWaOtUiwygNlU2wH7y71ocg49Ce4y7s9ohUgw/0CiR1RyaAtlJo
         6Jiy5fH7+YgxSzqc3BX2Y05XRV4QzS38Wxl0KXdrPtdUCiM7GP9bICAnQsSLI2t/O/U9
         4DuKcoGMd0xPxF8HufRgihAfy/KprfctNC25F2TQYcDVsi/W9TTiCTV8ZYALNBJ1WjVy
         V8cP9BfYg4fVyQWA7eshcSNm8W2t6Cp3pmKBvS7s4163LL3oA+BG/db6+9LFt3hitMoh
         iAVXw3fIJK0RH8A8eUWlCGL7Bh++6HPk6lz5INmuSISgYkt8SiYqyl3lWGzGH592VMxk
         z3xA==
X-Forwarded-Encrypted: i=1; AJvYcCVh+ZZbB7ep6yixv4ta5BMjaQZbsbPoeGwfTio9MPNxAYjPvSIPWaWef4RHkKPsIroq/5iJE8RtekKOYsh0L7JNVhm0WetaZbInBVG3RUlj208nTwsTTTsE6QCb/o1iV+8gAr3ytxx8Z+iUdJUbC8lEcNX1A3NALDWuJWH08VjkRgly
X-Gm-Message-State: AOJu0Yw/LmCEeA0vmkILTp2BvKlVjYQNUic4GY+xpmLmOjfe5hKp9160
	6bL3JIEY0ztKKiuY/3Z7uBA5K7RUmk7ZJsRg5vMGuCxmkCNgnMpPhyrwUjfsKVjTWTp8ovpb2k7
	xoorKUYykzn/znGhvsDD4meaLsMM=
X-Google-Smtp-Source: AGHT+IHI9LPrHISpciJu/XlMdQvlSNBZDSu7uaIpD9fPoUAzVQaNERNBJHyC/9jYZxDonlPN16YfLYb+mIXvXQMoJZQ=
X-Received: by 2002:a05:6122:499a:b0:4d3:b326:5ae8 with SMTP id
 ex26-20020a056122499a00b004d3b3265ae8mr568500vkb.14.1711661055324; Thu, 28
 Mar 2024 14:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328022136.5789-1-21cnbao@gmail.com> <20240328022136.5789-3-21cnbao@gmail.com>
 <09fe8f18-7f68-4d5d-89e4-68c1e5487b05@quicinc.com>
In-Reply-To: <09fe8f18-7f68-4d5d-89e4-68c1e5487b05@quicinc.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Mar 2024 10:24:03 +1300
Message-ID: <CAGsJ_4wb+koAGiK0FnW-ChO3E7iuzvjKXiF_6V_tkopaZ5D_qA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: akpm@linux-foundation.org, linux-doc@vger.kernel.org, apw@canonical.com, 
	broonie@kernel.org, chenhuacai@loongson.cn, chris@zankel.net, corbet@lwn.net, 
	dwaipayanray1@gmail.com, herbert@gondor.apana.org.au, joe@perches.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, lukas.bulwahn@gmail.com, 
	mac.xxn@outlook.com, sfr@canb.auug.org.au, v-songbaohua@oppo.com, 
	workflows@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:01=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
com> wrote:
>
> On 3/27/2024 7:21 PM, Barry Song wrote:
> > From: Xining Xu <mac.xxn@outlook.com>
> >
> > If function-like macros do not utilize a parameter, it might result in =
a
> > build warning.  In our coding style guidelines, we advocate for utilizi=
ng
> > static inline functions to replace such macros.  This patch verifies
> > compliance with the new rule.
> >
> > For a macro such as the one below,
> >
> >  #define test(a) do { } while (0)
> >
> > The test result is as follows.
> >
> >  ERROR: Parameter 'a' is not used in function-like macro, please use st=
atic
> >  inline instead
> >  #21: FILE: mm/init-mm.c:20:
> >  +#define test(a) do { } while (0)
> >
> >  total: 1 errors, 0 warnings, 8 lines checked
> >
> > Signed-off-by: Xining Xu <mac.xxn@outlook.com>
>
> if you are re-posting somebody else's work you need to add your own Signe=
d-off-by

Ok. Jeff, I will do it in the new version and obviously Joe still has
some remaining
comments to be addressed by Xining.

>
> > Tested-by: Barry Song <v-songbaohua@oppo.com>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
>

