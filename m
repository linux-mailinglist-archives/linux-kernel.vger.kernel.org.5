Return-Path: <linux-kernel+bounces-98710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D87877E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F611F21020
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A1374CF;
	Mon, 11 Mar 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFrVxs9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FD36AEF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153806; cv=none; b=EiJ5EJk/7TBBiyovyFdPRgIMEx5wwK2Ayqn2jr581PTljFerJTmKISjkSGyVUa8OqEwI6s8xGHDMJULPbUEsCwElgHR23cp15FegB3yC46Ip7nn9YiLl4H0Fkn9+jEPZg+y4LmXs827BhioRclRxZqOsdRUFcJsWG8kndj7y1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153806; c=relaxed/simple;
	bh=4kFkDZiXk38/U8SEmehYB/3ANFg066o8CqRYUPISa3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfL/xSsmu/k+CysAFmgOKCK2rpqRg4/OrEZ407tS7jvr0R70y25yhJ8w6lxHau/3vI4d6waGqGYD8VYXBlb+I5YA0sknKzLBqlp/ZOq9Cj9EQa4nE60hlsBV3BqInjr0jxYkieLV7piQJ+X32+lSftglIbX3bgm1TeoSTRlo3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFrVxs9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327B3C433A6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710153806;
	bh=4kFkDZiXk38/U8SEmehYB/3ANFg066o8CqRYUPISa3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XFrVxs9lG9ca2zvTIEdg5+MWWhH1WkGcfBj/wmXXaOlKn/xp5VSKvTyswsnDVnSWV
	 DrxX4esbbnvE+hqM/82yQB/lOLoJ3JdPK/EyYb+ynvFzepyZtjcEIlnA6oymoZPvwh
	 9RqZPhvSWsJaGuuXmHC+fU5gxN82UrmiTv7l0Ebt7c73uviRCRjbgP2kXWMRoivJKp
	 /J4n5/rbN4hD5NlOdYjomRozPK+cUBXMNAvENcJsz8WMpM3JWbKf/vWzkSbTNuD1UK
	 NJzndQs5kw33trklS3acKG6HjD/v/isBORhXdKZztsNXsdPV6BZ+BNe6oPiW72mFBr
	 Bv+cVd4q4cpvw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513a81b717cso914789e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:43:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrQtzyv59x5P61F8165nJ0FJ7LIHdt2QzdS1b1Pr5jXrbwL/cuy/1voXzLA1TzCG1NcNQ7wQW3SpctndYT6jTUmL+d2I6cLR5Qq+oQ
X-Gm-Message-State: AOJu0Yw09ikUrxtMwdl+ewgtiisFtqPsPQpU1qeoB5kWjla7fk7yUtpp
	7SUPVtVg5w+dad/aPrMW8mqKt2Uzy+JxG8lEgR+NPWd7KFrsqV9F0zMoxI0sZQ8vNPu32kTHqkg
	Bu0NdumhelEIpbhPcBac301gepT4=
X-Google-Smtp-Source: AGHT+IEHFZOT5Uoi6TJviWnX9qVI6iYvLR9LWZsEO9MbOLjiOJGvdNr+vf95PcyR0GrDOpzjtGYtWJIbRjMaMkiByKE=
X-Received: by 2002:ac2:4652:0:b0:512:b3a3:4adc with SMTP id
 s18-20020ac24652000000b00512b3a34adcmr3148425lfo.0.1710153804388; Mon, 11 Mar
 2024 03:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
 <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local> <CAMj1kXFe48dUtNkCDG0PcmeGhYfvr5HJ8sucuNGwCJ1XDKw03Q@mail.gmail.com>
 <CAGdbjmKC+tTBHLPZ6bqCXvu45Gbout+0QrNemDqxY-nKAo_3gg@mail.gmail.com>
In-Reply-To: <CAGdbjmKC+tTBHLPZ6bqCXvu45Gbout+0QrNemDqxY-nKAo_3gg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 11 Mar 2024 11:43:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGisJjijwo5JOknWtUTECC9pzkd9qpRhsGCSoGT8Jic6g@mail.gmail.com>
Message-ID: <CAMj1kXGisJjijwo5JOknWtUTECC9pzkd9qpRhsGCSoGT8Jic6g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Borislav Petkov <bp@alien8.de>, acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, bhe@redhat.com, brijesh.singh@amd.com, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	linux-kernel@vger.kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	peterz@infradead.org, pgonda@google.com, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 10 Mar 2024 at 18:12, Kevin Loughlin <kevinloughlin@google.com> wro=
te:
>
> On Fri, Mar 8, 2024 at 3:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Fri, 8 Mar 2024 at 12:01, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Mar 08, 2024 at 11:30:50AM +0100, Ard Biesheuvel wrote:
> > > > Agree with the analysis and the conclusion. However, this will need=
 to
> > > > be split into generic and x86 specific changes, given that the DMI
> > > > code is shared between all architectures, and explicitly checking f=
or
> > > > SEV-SNP support in generic code is not appropriate.
> > > >
> > > > So what we will need is:
> > >
> > > I was actually thinking of:
> > >
> > >         x86_init.resources.probe_roms =3D snp_probe_roms;
> > >
> > > and snp_probe_roms() is an empty stub.
> > >
> > > Problem solved without ugly sprinkling of checks everywhere.
> > >
> >
> > Indeed. Setting the override could be done in
> > init_hypervisor_platform(), which is called right before from
> > setup_arch().
>
> The call to init_hypervisor_platform() has a comment saying it must
> come after dmi_setup() (i.e., init_hypervisor_platform() would *not*
> work for doing a dmi_setup() override), so I'm currently planning to
> do the overrides at the end of snp_init() in arch/x86/kernel/sev.c
> instead (which comes before both). This would be somewhat similar to
> how there are early setup functions for specific platforms that
> perform init overrides for different reasons (example:
> x86_ce4100_early_setup()). Open to other locations of course.

snp_init() is one of those routines that executes from the 1:1 early
mapping of memory.

Setting a global function pointer will therefore involve special
tricks to ensure that taking the address of this function will produce
an address that uses the correct translation.

So if we can, it would be better to put it somewhere else.

