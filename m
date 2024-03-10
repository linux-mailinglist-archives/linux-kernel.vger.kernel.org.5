Return-Path: <linux-kernel+bounces-98272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C38777B2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0209D1F21696
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B666376E5;
	Sun, 10 Mar 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTrsAev+"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606D10EB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710090766; cv=none; b=sb/moXy2j7xpXJ4Nl+F9BPPRu4/YovFSMJlWl+cVbYHtFbiM6E/PRPiB7Ni0Va+LxhsXxOPNCcFPXshe/ulnduxo+8bEB3Uv4dgIGH/xgPadz6RcWNWVsFUk/3F9S2ko7x0oQ3r4BSmi13nKIufHv5rkH2rqAigfBDgN+FYjNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710090766; c=relaxed/simple;
	bh=GvvHLwc+BXWQnptpXvsBcJKrD43F0EoxW/Nt3khI8Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuLEuwSSZErxsUjtb41WxO7RJxiS4RsomW2imvGp7IOCcCO49khuN03yzHNhfXpRMx5ph2t00lyGrQgdkjejrLA+6kk0z8j4cxPWEdr0HnHspBwyEvFvmYBMjCVXDTJtEwucu+IBjeNI13px6V79hPywJUG0pgzMGBMd4oL5oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTrsAev+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddf26eba3cso2810401a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710090764; x=1710695564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLDFBpE9g7B2rHNzujysZLg4IwIC9TaXs9R31Os7xQs=;
        b=bTrsAev+lwcaGROviY7q/ZR9yeeiCxZBDJTsJFKfXSrWlRGzlMDbP+8W23xXYI2U7G
         DSegd2QUPLBceq9iQW06Q4cEhrNWtyaib5uJfMz6lylzCm25xdXEYgg7M6psL9GnD7kN
         UJMLfD8TV3k4qCLuB6F0JicbCuyd5DFvLbp5YMy1f+C1whhR+g0bJUgzlaJJkSyvj0ca
         iBZxfYJL5tgVs/Hqf3UtHzSu7uqOi/o2sAqfgMF2yX8u8hucW5kQt7Sr54VDfqzqgR/4
         VooGFMY7q4zcINkph1XnEZUPz02ujALyb55ztYnL0rjHLycuAnqOt1WuNmFt0tCBsJKX
         yEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710090764; x=1710695564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLDFBpE9g7B2rHNzujysZLg4IwIC9TaXs9R31Os7xQs=;
        b=jAUNxxPnDowfV9vpzaXqgFS17nV7Lko5bmZBaveshqidoQRynuShdM/fbk/+PWARVW
         BtlpEIU2YZMXiMjZBn/ZZ/C9Ccrl+s7RtXadZTda3HZtaKmIzodXJcNRVcPXS9YU4k16
         v6GgdZ+fArUsvW0vEHOjaGOTiulfbqHdGxTYmeSLcvbUQDIG8gClVxMlq+UMnrN+bZ/t
         DTScwq6odVVkFRAK1GaehGIDi2r2zHhpIppU/P3A58Kr9/3auoqtF+58l68m/T6xXcna
         i0R1pY6xBiMBf1iV4JlZhm/ROA9m8pQuQWCOxJqrMqlKCcfindXt7hiGKzENVbWWtrSX
         dYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbTVyDyFfpDqlKxVusmORzws547AR0HC/+N0WhTbDK98R+A8A7lWlstO6OT/fhJiNHSiNYAX5CYU1WRB2w3NhA1AQUBYt+WB+pB6Bg
X-Gm-Message-State: AOJu0Yy5Xci/724hMRid8NSuT0m8tJ1AjEsbohKQ+OF54NTX8GAVCj7O
	+to0/j7lAl2N2l8DJqZO5AyWCmPinFHCpN8jFuoOjfJuMbH+mCQ3eXH4wHY02RicW3ZUNdJwfJY
	8jnrNg5WM4fHlbW9V0k8OibrigXU99lJURv7Q
X-Google-Smtp-Source: AGHT+IG0PSdkGjK42DSA7kdGjkF6UWHQ39d31Q9DmHNsq4FyJQOhXVJ4Sa5htBItt5EQbltndjRfT/RM/9CYILqVs6g=
X-Received: by 2002:a05:6830:3101:b0:6e4:e675:a92c with SMTP id
 b1-20020a056830310100b006e4e675a92cmr7240903ots.16.1710090764101; Sun, 10 Mar
 2024 10:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
 <20240308110043.GEZerv21Qj10Q7-8p5@fat_crate.local> <CAMj1kXFe48dUtNkCDG0PcmeGhYfvr5HJ8sucuNGwCJ1XDKw03Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFe48dUtNkCDG0PcmeGhYfvr5HJ8sucuNGwCJ1XDKw03Q@mail.gmail.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Sun, 10 Mar 2024 10:12:32 -0700
Message-ID: <CAGdbjmKC+tTBHLPZ6bqCXvu45Gbout+0QrNemDqxY-nKAo_3gg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Ard Biesheuvel <ardb@kernel.org>
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

On Fri, Mar 8, 2024 at 3:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 8 Mar 2024 at 12:01, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Mar 08, 2024 at 11:30:50AM +0100, Ard Biesheuvel wrote:
> > > Agree with the analysis and the conclusion. However, this will need t=
o
> > > be split into generic and x86 specific changes, given that the DMI
> > > code is shared between all architectures, and explicitly checking for
> > > SEV-SNP support in generic code is not appropriate.
> > >
> > > So what we will need is:
> >
> > I was actually thinking of:
> >
> >         x86_init.resources.probe_roms =3D snp_probe_roms;
> >
> > and snp_probe_roms() is an empty stub.
> >
> > Problem solved without ugly sprinkling of checks everywhere.
> >
>
> Indeed. Setting the override could be done in
> init_hypervisor_platform(), which is called right before from
> setup_arch().

The call to init_hypervisor_platform() has a comment saying it must
come after dmi_setup() (i.e., init_hypervisor_platform() would *not*
work for doing a dmi_setup() override), so I'm currently planning to
do the overrides at the end of snp_init() in arch/x86/kernel/sev.c
instead (which comes before both). This would be somewhat similar to
how there are early setup functions for specific platforms that
perform init overrides for different reasons (example:
x86_ce4100_early_setup()). Open to other locations of course.

