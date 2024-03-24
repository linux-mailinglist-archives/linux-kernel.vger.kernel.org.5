Return-Path: <linux-kernel+bounces-112668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97943887CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2ED281808
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302CCA64;
	Sun, 24 Mar 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm70ENMI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D111A38DA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711283656; cv=none; b=cIlcnEWu4f6JCSZza4z2r6VIeoQb5zBtWkRckHu4z/dOp5SHjZ+ndaTgRMPyZproaFB5eOfeWYFR5Ussx9AXviHuntdlE+4Jtd6aHLxqB/m7IdB4v35qi1R2byV2kTRy2tU0sdx7ogwO87s/eBejbzplM0rhjHQ2kg5ACKnurIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711283656; c=relaxed/simple;
	bh=/NvHE/IQaQXMiwlEZHkJtFih10t6C+1BmEtYc3j69ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPbuWYKUl2kyN4XTQFQHxV+l6yVT9gP1bRz9S4HUVEhyuDMt1laabo3MGpuCBIdAo9vI3ny7IXVaarZlIAIvYfr/BuXZLufOUUPi2rwrLy2LgQHdYOyECE7tOyGSH8w2CKHLuaaXFry+zf5P8jJ1oFZA8wSxPa9ZCunNwoSptPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm70ENMI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so48650761fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711283653; x=1711888453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAqRH0G3Ngp1ydPKZ4e7ZMugl/UUw8han1hbHC2SCec=;
        b=Jm70ENMIl8n8x8gY3AhWDG5txySTAmpRa1kotIrM3/LN3wbvJdkCPZjgZUuZssYbIl
         Bco/inY8hzFs5JB2wPbE819OBm7rSFVhk7mQfssbvRj/TIGYQUmMbXxKyHRnJCcuo55O
         zaWDMbCvrjWmkcLwE+X4XmLsfc1ejprqWCCkeIYbyOA589tuyqBiAapZAW1dcJIKO85c
         4KjcmRGLBsJsQzDpXohYvtH9foG8ZOit5qZg1T6zLO7DPZsV5Wdk4DeE70Xe8WaR5jLU
         u0MmpqSZYDuk3zLK8CuPbvdjDin0sY2swGa/66Qlmk1Irfm6IpGHuQFnUwg48/0DUR3q
         er5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711283653; x=1711888453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAqRH0G3Ngp1ydPKZ4e7ZMugl/UUw8han1hbHC2SCec=;
        b=Od19j3URabk6Skbh/WBCdKmkx5VAvUyswv6uT76E5zHZpd5NAypU42pD2Pq6EyJuo8
         ND+3ZCsP8d93tr/e3t+ji+RlswsFw2efnDrBtgHcAVqyMN2/VlBVoIlfiLF+uAPfvnm5
         j/jtD0pbTdlTqjf2UljwtWLO6qowSQsPsU6XIfQCdteQSYZFG8B/Q0IORX9YBE+E2Trb
         d/FMpJsBYuYRGaOrympHS3W4rLr9r31bB+sjiNlycf1OMnlDZoi+v/w0L9D4MV/KbgCi
         WAc77sBLprzBGRkLKGZIaZYpHEPqLfWmxViAYw1f/8kqlWeegz27vrPw+mLvd98qax3p
         OfHA==
X-Forwarded-Encrypted: i=1; AJvYcCVvKVY4SKSMAxC2Jq6X+bRvAlZMSvPos9JfhI/S2wnfDHTwawrlhA8Lj2H7a5O6KGDMXfVrBgHEC2waopnSegfamDcRFp4ZDkty2GiL
X-Gm-Message-State: AOJu0YyCTviqk/Em3Fs9I+iCaqv6kCTHryLkNAJJa23SHsT3aZdjBY0g
	GKtNda9n4Otgl12weRA+RQpj1U74ohYqidA/18sBv9GONyy7gyrQ8CxuuTpwU9zc0hkGT3OIEn6
	kCOT3MDoSaFUWMV3RVGk2WZkEUw==
X-Google-Smtp-Source: AGHT+IEGtMhi/wOWzfkue74WRCySUzWA5AwZoy12blQVqzIrZLT9AQCF3I/QL7a5al04TuA+hLbZ1aq8C21kdKx+RA8=
X-Received: by 2002:a2e:9609:0:b0:2d6:ba96:b9a8 with SMTP id
 v9-20020a2e9609000000b002d6ba96b9a8mr2529100ljh.27.1711283652940; Sun, 24 Mar
 2024 05:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <Zf+PIYP4TyF6ZRVy@gmail.com> <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>
 <Zf+mjy49dG5ly9ka@gmail.com> <CAMzpN2go9mmyWRb9vsg7O1aAtSKrW=HqcZYmddkq7eZQQHuM1Q@mail.gmail.com>
 <ZgAGEcmrWZyDrO50@gmail.com>
In-Reply-To: <ZgAGEcmrWZyDrO50@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 24 Mar 2024 08:34:01 -0400
Message-ID: <CAMzpN2j1B99FSXVQ=S5a3G+XQf2Cq5rtx=fR77VHW8RDn7WKAQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	David.Laight@aculab.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 6:53=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > On Sun, Mar 24, 2024 at 12:05=E2=80=AFAM Ingo Molnar <mingo@kernel.org>=
 wrote:
> > >
> > >
> > > * Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > > On Sat, Mar 23, 2024 at 10:25=E2=80=AFPM Ingo Molnar <mingo@kernel.=
org> wrote:
> > > > >
> > > > >
> > > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > > >
> > > > > > On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > Currently, x86-64 uses an unusual percpu layout, where the pe=
rcpu section
> > > > > > > is linked at absolute address 0.  The reason behind this is t=
hat older GCC
> > > > > > > versions placed the stack protector (if enabled) at a fixed o=
ffset from the
> > > > > > > GS segment base.  Since the GS segement is also used for perc=
pu variables,
> > > > > > > this forced the current layout.
> > > > > > >
> > > > > > > GCC since version 8.1 supports a configurable location for th=
e stack
> > > > > > > protector value, which allows removal of the restriction on h=
ow the percpu
> > > > > > > section is linked.  This allows the percpu section to be link=
ed normally,
> > > > > > > like other architectures.  In turn, this allows removal of co=
de that was
> > > > > > > needed to support the zero-based percpu section.
> > > > > >
> > > > > > The number of simplifications throughout the code, enabled by t=
his
> > > > > > patch set, is really impressive, and it reflects the number of
> > > > > > workarounds to enable the feature that was originally not desig=
ned for
> > > > > > the kernel usage. As noted above, this issue was recognized in =
the GCC
> > > > > > compiler and the stack protector support was generalized by add=
ing
> > > > > > configurable location for the stack protector value [1,2].
> > > > > >
> > > > > > The improved stack protector support was implemented in gcc-8.1=
,
> > > > > > released on May 2, 2018, when linux 4.17 was in development. In=
 light
> > > > > > of this fact, and 5 (soon 6) GCC major releases later, I'd like=
 to ask
> > > > > > if the objtool support to fixup earlier compilers is really nec=
essary.
> > > > > > Please note that years ago x86_32 simply dropped stack protecto=
r
> > > > > > support with earlier compilers and IMO, we should follow this e=
xample
> > > > > > also with x86_64, because:
> > > > >
> > > > > Ack on raising the minimum version requirement for x86-64
> > > > > stackprotector to 8.1 or so - this causes no real pain on the dis=
tro
> > > > > side: when *this* new kernel of ours is picked by a distro, it al=
most
> > > > > always goes hand in hand with a compiler version upgrade.
> > > > >
> > > > > We should be careful with fixes marked for -stable backport, but =
other
> > > > > than that, new improvements like Brian's series are a fair game t=
o
> > > > > tweak compiler version requirements.
> > > > >
> > > > > But please emit a (single) prominent build-time warning if a feat=
ure is
> > > > > disabled though, even if there are no functional side-effects, su=
ch as
> > > > > for hardening features.
> > > >
> > > > Disabled for any reason or only if the compiler lacks support?
> > >
> > > Only if the user desires to have it enabled, but it's not possible du=
e
> > > to compiler (or other build environment) reasons. Ie. if something
> > > unexpected happens from the user's perspective.
> > >
> > > The .config option is preserved even if the compiler doesn't support
> > > it, right?
> > >
> > > I suspect this should also cover features that get select-ed by a
> > > feature that the user enables. (Not sure about architecture level
> > > select-ed options.)
> > >
> > > Thanks,
> > >
> > >         Ingo
> >
> > I could add something like:
> >
> > comment "Stack protector is not supported by the architecture or compil=
er"
> >        depends on !HAVE_STACKPROTECTOR
> >
> > But, "make oldconfig" will still silently disable stack protector if
> > the compiler doesn't support the new options.  It does put the
> > comment into the .config file though, so that may be enough.
>
> So I was thinking more along the lines of emitting an actual warning to
> the build log, every time the compiler check is executed and fails to
> detect [certain] essential or good-to-have compiler features.
>
> A bit like the red '[ OFF ]' build lines during the perf build:
>
> Auto-detecting system features:
>
> ...                                   dwarf: [ on  ]
> ...                      dwarf_getlocations: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                      libdw-dwarf-unwind: [ on  ]
> ...                             libcapstone: [ OFF ]  <=3D=3D=3D=3D=3D=3D=
=3D=3D
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
>
> ... or something like that.
>
> Thanks,
>
>         Ingo

That list comes from the perf tool itself
(tools/perf/builtin-version.c), not the kernel config or build system.
Something like that could be added to the main kernel build.  But it
should be a separate patch series as it will likely need a lot of
design iteration.

Brian Gerst

