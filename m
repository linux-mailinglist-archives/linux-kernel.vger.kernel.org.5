Return-Path: <linux-kernel+bounces-75187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9085E46A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61011B21590
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762C83CA1;
	Wed, 21 Feb 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J9luFRKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0E33F7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535999; cv=none; b=deALYakqR48UqofXNOH9vyo7ASteJitNW8LO8f0M2bLORMg5OXHmJ1Zf//661LOLJF9W5vJJ0M4pNArZbhRcx3tEIROu/VbekH7hj3xlIK4CilvH51qO9dO+a/qzIumZrK6YzJ1IfrScMPJtquD5G0xkpq0+jO0SJH/TG43x2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535999; c=relaxed/simple;
	bh=mohUC8yf/GvhUgtVjjHOvP3YR1w8wLsVqsCFCBn5yXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SksRUkGQ0NLz25ePe/lS1xPRB7sP3wOmTtQ03akzGspRPwEpuYRWxUw5GjogVemi7G+wn16RzkPiwvttbsIBjlVHhxbbGLeM8SEwVoG4uM0c97oB1H10X8I3C1moW+SGS14/6of+MBmegsww12veyhEdPk9FdHA7PJJNFAO2V5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=J9luFRKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4262CC433A6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J9luFRKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708535995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OG+ecKsQYxVgvbBvL/TtgozTpt4MGBiORcM4WnZxHk=;
	b=J9luFRKbMsBggAKjcd6FoCQCFqK3url7Sdh3XZYJSr4mA1puXzkyaxHqj6pupLqSCWKODQ
	RNvHBA3KLaP2mjI97rQQtGZkGNkiNYfLecKiKSTRd4TZSrptHSQxNdrKhTN+qZxCisxLkS
	ewB8VipIPkj8LHt2k6mBzw1NRSS9BQk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5f056f35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Wed, 21 Feb 2024 17:19:55 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60884277a6dso8161497b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:19:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNaN9GuYeloOIGuCg6uRXWFDvU5D/qLf23R3OZ9SljR1wGAJsr2gRwqNH0P44L1xP6k0UvfWSIPo/hIGenbxAG4P1m5zqA6Ph+VYb9
X-Gm-Message-State: AOJu0Ywq339mDingVJklGc/aQ+4khCutQTWT/UEM/g9uzxEcz0h5GAQv
	vMmDy2xkKaGR9ZnJ6X3PLK/tHOj8C7Og59+G/E2q0Bs/HrKijoy446Hu+E1RVBLSGoyXz2a4YIq
	T+VF/RSy9FdfxUIRczDUySAghYK0=
X-Google-Smtp-Source: AGHT+IFiRSo8oJLeIG6A89DqtzR4YnG0l7JPRWlYtBL46DIFRZVdsbWf6zNNIK8u00F1s0mkvbKIVpuC66RE/4PkDno=
X-Received: by 2002:a0d:e250:0:b0:608:94b5:3e2 with SMTP id
 l77-20020a0de250000000b0060894b503e2mr418397ywe.4.1708535993716; Wed, 21 Feb
 2024 09:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221123248.25570-1-Jason@zx2c4.com> <eada8acd-9341-401b-b6c9-a05848eb91d6@intel.com>
In-Reply-To: <eada8acd-9341-401b-b6c9-a05848eb91d6@intel.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2024 18:19:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9o75KzsfMRDtr2K0+N-UM-MX7MWL4AZhy27CedZRNd2Tg@mail.gmail.com>
Message-ID: <CAHmME9o75KzsfMRDtr2K0+N-UM-MX7MWL4AZhy27CedZRNd2Tg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo systems
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:55=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/21/24 04:32, Jason A. Donenfeld wrote:
> > +__init void cc_random_init(void)
> > +{
> > +     unsigned long rng_seed[32 / sizeof(long)];
>
> My only nit with this is the magic "32".
>
> Why not 16?  Or 64?

32 bytes =3D 256-bits =3D what we're targeting. Very normal thing to see
places in the RNG, used all over random.c and lots of platform
drivers. Pretty obvious and straightforward to anyone familiar with
this kind of code. Not the kind of thing you'd want to replace with
some abstracted constant that makes you search.

