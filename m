Return-Path: <linux-kernel+bounces-44740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FD8426C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442221F28F06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641A6DD06;
	Tue, 30 Jan 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ASLGWzVV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35B6DCFD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624511; cv=none; b=oEVW1bq9x9v4QLDCd4BVJfY60R7zEQahHR3hLcB0zaS3A79aqd5qrHfFlHaayGanAhx6qScgEAJQZUeGY4N7bj4wSYljGWb3yvwUk/rmizAed/MYP/RRC95CKoAuu6gXndGlRP9L8K8YC8AQhFJ5QeU/0WWJ6JfSYjOOf4TurK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624511; c=relaxed/simple;
	bh=iifEdyBkoeN6gHOB3ij71Qr/fQ1oSrL2kWDHJSYyho4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tolrhxtzV0lieM/tCH4gY/mNxdABNJwv3EcWAuCg817mzs4YcXRKFIcry7NGsPA9E0/r3dq9gQXiqRjYJouius+EcUWTfZftaoxPfKJYmQd1BJaohaFvH2mAu+/20iX8U6FkiCdm9O83MFzl0/Utn4EiAhb48YINxIjVbXdwkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ASLGWzVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A203C43390
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ASLGWzVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706624507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iifEdyBkoeN6gHOB3ij71Qr/fQ1oSrL2kWDHJSYyho4=;
	b=ASLGWzVVd4eo14mT6IQZ6iXdA4CNZbF5flQRUoNCWbXfmBL3ar+MBRNCz9NdQVSvhjWtdZ
	E0CY9Lr44unCOXBgZeABtALgqRbxJWY0B36ZBhb55VFiOrVFP0OU4TzstMr8moM0hY5f0f
	y3MtqwRFf4OmAoSOIM+qSass5ShRu5s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cee126d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 14:21:46 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff821b9acfso38150547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:21:46 -0800 (PST)
X-Gm-Message-State: AOJu0YzAUORFAwp+iYNYGVO9OkHup+fZZ7B/fbNVS9kSZfYgT+3Jjvjh
	LhnwX8+t9V5Vh8G1EKlrRkS2tRRvlBWoX2KesX0qmdfqshUuS7eLpuWT9zakCUN03eTflZyYMAV
	47ZDa5yhYO1y5lL2ZI0gs+1EZWbc=
X-Google-Smtp-Source: AGHT+IGd74BfrxlFkGzfmhnUEfgPF97lQH+UYzmcIyQ916N8eCF2PZXTRYcIB6FeAn8u7Xf2y2NKvZFX2Ktwb79FSf0=
X-Received: by 2002:a81:ac60:0:b0:600:367a:f99f with SMTP id
 z32-20020a81ac60000000b00600367af99fmr5446557ywj.4.1706624505457; Tue, 30 Jan
 2024 06:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 15:21:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9odqcxdak3HK-XD6-H0SjYmecnTsxzDhYy+-0shhTFygQ@mail.gmail.com>
Message-ID: <CAHmME9odqcxdak3HK-XD6-H0SjYmecnTsxzDhYy+-0shhTFygQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 2:45=E2=80=AFPM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> No, this is not the case per Intel SDM. I think we can live under a simpl=
e
> assumption that both of these instructions can fail not just due to broke=
n
> HW, but also due to enough pressure put into the whole DRBG construction
> that supplies random numbers via RDRAND/RDSEED.

Yea, thought so.

> I guess your concern about DoS here is for the case when we don=E2=80=99t
> trust the host/VMM *and* assume malicious userspace, correct?
> Because in non-confidential computing case, the Linux RNG in such
> case will just use non-RDRAND fallbacks, no DoS will happen and we
> should have enough entropy that is outside of userspace control.

Don't think about the RNG for just one second. The basic principle is
simpler: if you have a
`WARN_ON(unprivd_userspace_triggerable_condition)`, that's usually
considered a DoS - panic_on_warn and such.

> >
> > And if the DoS thing _is_ a concern, and the use case for this WARN_ON
> > in the first place is the trusted computing scenario, so we basically
> > only care about early boot, then one addendum would be to only warn if
> > we're in early boot, which would work because seeding via RDRAND is
> > attempted pretty early on in init.c.
>
> I don=E2=80=99t think we are only concerned with initial early boot and i=
nitial seeding.
> What about periodic reseeding of ChaCha CSPRNG? If you don=E2=80=99t get
> RDRAND/RDSEED output during this step, don=E2=80=99t we formally loose th=
e forward
> prediction resistance property of Linux RNG assuming this is the only sou=
rce
> of entropy that is outside of attacker control?

If you never add new material, and you have the initial seed, then
it's deterministic. But you still mostly can't backtrack if the state
leaks at some future point in time.

Jason

