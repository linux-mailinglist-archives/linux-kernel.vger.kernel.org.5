Return-Path: <linux-kernel+bounces-25001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41382C5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BE01C22012
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF015E94;
	Fri, 12 Jan 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZYsGi9Am"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E015AF4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso1433268766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705087999; x=1705692799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j27coH7dN6dynLCy7PqLOH/19550Y5l0cyL43P460HQ=;
        b=ZYsGi9Am9A7adgJH4KSFtl9k0mLsRRcjreeWX5h9avWgT6cvn551yk5wFIXz3gUVLx
         37nLQK2fmvUfZWC+JbRKPh7pQvBI6yzblNaIMC8knqnBWuhDdnJ1W7hqrusgXi2f+LdZ
         tbaO+pEL4ZTB83yDtD5IKxVTv8t3ZMsB37yBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705087999; x=1705692799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j27coH7dN6dynLCy7PqLOH/19550Y5l0cyL43P460HQ=;
        b=C2W8/RFjJ7xrCelGsFhRsLV2MyXiXlQcypqKNRZ9ohzdDUt187DiO6xMg//tgrUhTl
         PxN+k1+BY6FaHVkyNbshklKp/xqvEffc0oDhX2hLPlgTiqXvrfz7zIfizKL+i6jKYjOp
         dSH8ToAy7/FO9Enh3m0AasPVa0hM4mzZiD9z1YzAsTN4FG+iwN9wL5iMxL61oD1dH5jn
         9fh8q3YA2E1GIER2E+4n1ay26rDAmyuYcKo0IuN2w/kTmc56oQ83ihfInqd9PRvb3mcj
         8EcxG9xkc7H5TxK+PGZWJ4YbaFPZY4ssusHR4Ye/GAl1FtQemb4Jk2qb25hzsCjdpE86
         /8eQ==
X-Gm-Message-State: AOJu0Yy0OzNcz/KTi28iSBR322W4HuYvNhtj35DY25Aw8Q8ygDWGkxa5
	hHK+59YzrL7mEAUPyHrESZJ64P03E3DjnMkzeDVXh/UYArEiHwVs
X-Google-Smtp-Source: AGHT+IF/ItaLHPAO22Pgp5K7YEGRFWGjuCjKQzvtr4DoLZuombXbNVX3xHAM7KAVs0uLJTsMO/i4kg==
X-Received: by 2002:a17:907:7891:b0:a27:d309:b6b8 with SMTP id ku17-20020a170907789100b00a27d309b6b8mr1775465ejc.35.1705087998774;
        Fri, 12 Jan 2024 11:33:18 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b00a26ac037ff3sm2080418ejc.132.2024.01.12.11.33.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 11:33:18 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28bf46ea11so1194703366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:33:18 -0800 (PST)
X-Received: by 2002:a17:906:4307:b0:a23:1b07:5c1b with SMTP id
 j7-20020a170906430700b00a231b075c1bmr1933545ejm.10.1705087997668; Fri, 12 Jan
 2024 11:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
In-Reply-To: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 11:33:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPJttFz8yrdpPTN-ypMmDXHOKw9yi1nZSEq+7+tGftZA@mail.gmail.com>
Message-ID: <CAHk-=wgPJttFz8yrdpPTN-ypMmDXHOKw9yi1nZSEq+7+tGftZA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.8
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 at 11:49, Dave Airlie <airlied@gmail.com> wrote:
>
> Let me know if there are any issues,

Your testing is seriously lacking.

This doesn't even build. The reason seems to be that commit
b49e894c3fd8 ("drm/i915: Replace custom intel runtime_pm tracker with
ref_tracker library") changed the 'intel_wakeref_t' type from a
'depot_stack_handle_t' to 'unsigned long', and as a result did this:

-       drm_dbg(&i915->drm, "async_put_wakeref %u\n",
+       drm_dbg(&i915->drm, "async_put_wakeref %lu\n",
                power_domains->async_put_wakeref);

meanwhile, the Xe driver has this:

  drivers/gpu/drm/xe/compat-i915-headers/intel_wakeref.h:
        typedef bool intel_wakeref_t;

which has never been valid, but now the build fails with

  drivers/gpu/drm/i915/display/intel_display_power.c: In function
=E2=80=98print_async_put_domains_state=E2=80=99:
  drivers/gpu/drm/i915/display/intel_display_power.c:408:29: error:
format =E2=80=98%lu=E2=80=99 expects argument of type =E2=80=98long unsigne=
d int=E2=80=99, but
argument 5 has type =E2=80=98int=E2=80=99 [-Werror=3Dformat=3D]

because the drm header files have this disgusting thing where a
*header* file includes a *C* file:

  In file included from ./include/drm/drm_mm.h:51,
                 from drivers/gpu/drm/xe/xe_bo_types.h:11,
                 from drivers/gpu/drm/xe/xe_bo.h:11,
                 from
/drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11,
                 from ./drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:1=
5,
                 from drivers/gpu/drm/i915/display/intel_display_power.c:8:

nasty.

I made it build by fixing that broken Xe compat header file, but this
is definitely *NOT* how things should have worked. How did this ever
get to me without any kind of build testing?

And why the %^!@$% does a header file include a C file? That's wrong
regardless of this bug.

                   Linus

