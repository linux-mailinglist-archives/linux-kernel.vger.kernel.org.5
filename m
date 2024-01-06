Return-Path: <linux-kernel+bounces-18433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDEF825D5B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514381F246CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A01637;
	Sat,  6 Jan 2024 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JoDncbd1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C84139C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso195792566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 16:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704500342; x=1705105142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KkrCdBNLcmk3x1SV45s/V/SWlteI2qUXSQc1BGercgY=;
        b=JoDncbd1Tbv9C/kmQsmHN+w/Jx7jpqimbyH7N0Lke8bDaVXWD+WNOGSzqTY5dHKF+P
         B1s6LUgWrSva2oxyHFh7VZoyGRVPwHO176JQvkmSXdCb62yzLYYrW4nYtuPV6Rd+ZHVL
         huQ2qJr8PXf1MzwhJG4m/ow+4MYDQqnrd96HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704500342; x=1705105142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkrCdBNLcmk3x1SV45s/V/SWlteI2qUXSQc1BGercgY=;
        b=JdfFtp2NUdIZzqtkpJ2eNZ2L1giQCIlXeRf8fhbpGMBsp3419hjTU1y2fCPQUuHt6Q
         SJCHFB1MIdLKu0PEwPr/d5A7J6R/XX/pXvvMqGNYBMVby9Mj2X+mFpGCs01v1Mgw0XlA
         4EyBNwDO4Oisuz+uK2gbuXaLi0NTF2r/fruWXhA1miVbXGBh0GZYUlMkWs9uTIHaNOxs
         ifUwophEhbkmq2w3jr2w6flT9m3lt4HSyCgG8UwYz0WqQkAvTu0/VquEzrdUfDOqeR1h
         0J92db06hOSJeS7Hsp0MGqO+wRsaoZIX5rwoAk8mdhxWXKG47NC936Lwzxbyz3kovBfj
         iGhg==
X-Gm-Message-State: AOJu0YxNyBWqObBrKo6zKIDEPR+eLlA6yzOImOxZPKG+zVg4reJ2f/WG
	uCzYQf+ryrh82IX7n+NEDNd8dnBgd6IFkOijO8RJ1rMQT+gg8aAw
X-Google-Smtp-Source: AGHT+IHD2sEyWWLptpevZazz0L+GxU9gt7VrV7Ylb91nkujXNDP5lTcJwUhGi2/4HNtkD4Vv86prJw==
X-Received: by 2002:a17:907:9449:b0:a29:b898:93cc with SMTP id dl9-20020a170907944900b00a29b89893ccmr694880ejc.28.1704500341879;
        Fri, 05 Jan 2024 16:19:01 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id mf5-20020a1709071a4500b00a2534aebc21sm1377578ejc.40.2024.01.05.16.19.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 16:19:01 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28ee72913aso193430266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 16:19:01 -0800 (PST)
X-Received: by 2002:a17:906:fe05:b0:a23:5939:759e with SMTP id
 wy5-20020a170906fe0500b00a235939759emr344150ejb.26.1704500340786; Fri, 05 Jan
 2024 16:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
 <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
 <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
 <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com> <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
 <204bf145e6ad47219c005e9a4407ebdc@AcuMS.aculab.com>
In-Reply-To: <204bf145e6ad47219c005e9a4407ebdc@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jan 2024 16:18:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGaH6oA47WkphTweMiy15Zjfuk-aVcXSasMX=aX9rFLQ@mail.gmail.com>
Message-ID: <CAHk-=wjGaH6oA47WkphTweMiy15Zjfuk-aVcXSasMX=aX9rFLQ@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To: David Laight <David.Laight@aculab.com>
Cc: Noah Goldstein <goldstein.w.n@gmail.com>, kernel test robot <lkp@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 15:53, David Laight <David.Laight@aculab.com> wrote:
>
> I'd have to fix his benchmark code first :-)
> You can't use the TSC unless you lock the cpu frequency.
> The longer the test runs for the faster the cpu will run.

They'll stabilize, it has soem cycle result aging code.

But yes, set the CPU policy to 'performance' or do performance
counters if you care deeply.

> On a related point, do you remember what the 'killer app'
> was for doing the checksum in copy_to/from_user?

No. It's a long time ago, and many things have changed since.

It's possible the copy-and-csum it's not worth it any more, simply
because all modern network cards will do the csum for us, and I think
loopback sets a flag saying "no need to checksum" too.

But I do have a strong memory of it being a big deal back when. A
_loong_ time ago.

          Linus

