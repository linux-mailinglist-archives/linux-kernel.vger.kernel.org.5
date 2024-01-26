Return-Path: <linux-kernel+bounces-40264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F38083DD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF87B282082
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DC1CF92;
	Fri, 26 Jan 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLkxbsx0"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A215AD0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282639; cv=none; b=QgUzoY7Uyr5oy3qASBvd2joOp5axIco9AMyYrqs6Rir07OhmAq7cOFZN9c3tGlzRCwEpqHmh2yLwEedlOs7C1ExrXuV2uSx+gGkYTqLzaAs6eYO4D3L/1LwypxgAhNdGxOsc2Uce1qU+hnbs3+5WnUONvXpooh7IvGGphIlwKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282639; c=relaxed/simple;
	bh=ydPZ3tu4FlaDxMtV6SOM9OK/z2p8/IzKH4YoVsZ330U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqcPEx7sbhuQLuObHFynUOLypbnE8UkvhKdakMXQHyQPm5tRxonrI8qunEWrAGJXKmtkLxsYnoRSesru7RUKGYfGp7j129xsYGH/DW4dPhvl+wnJokJyuywE7wewhYLLJaSRxisiib7NhfVgIAV2Jpvqb2DPdCRtu5V3YWtayKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLkxbsx0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ddc261570cso582870b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706282638; x=1706887438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uy3R1AKMbIaUlXE1Nr9/RuFwNoQzqIu4pzJFsA3j5jw=;
        b=vLkxbsx03MC06Bfz8RTh7dCKiQYtJHKMutnW9AOzNBJYV/IoHT05IdRN8Wsa2PlAzh
         vAPdKvsdBaWDs30FzNm+wgtzAcxE/OfmpBeKIIA3ENWm/eVvo29YlGf294kN9/ORIvDV
         RMn7if9iR9uWNUEDc1anluTF6Xjp8Vgsx0SFlAoro+7SR4PoG3NpizTrYecLtYRdNRfy
         oELeEOSTPC1X+vBZKHTbNoyntUPCruS7udz1lrl/dk0h5h/fFSO2I0hYI+qdHcELPv2o
         13tWTFs27z48HDGJ6+9m5PNwU9QlXCvpg8RBYoqQ6UIfNRc9HQyJiotqCCb0vzoU49Js
         tXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282638; x=1706887438;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uy3R1AKMbIaUlXE1Nr9/RuFwNoQzqIu4pzJFsA3j5jw=;
        b=QD/sQ3RD44Pw39eEkyi7ZTIvvY6k1eVCdYEU+obCZuZptPAHoLxhSVhTSeR0TKnyqq
         u1Dye2mSjkZOKKznoVrjpttAe2FUaRp0pf6ADGGthk+JzmVJDkWeQjEsV9Hw0RKf1dkn
         Tlo/ngWYtVL/TUWhrJKhwJl8CGGQ9MyJdEcgSo7u+rsHmli4ZtEyi4qmqycAGaTIkwdG
         z5X6as52/6jpAhtsaypPRBCaws4QEfpQn0GP5/hFCgRY4xZzx8Q9Yt+/ZRny2zpIOMfI
         t8mtAD/FSkMkIBLd31RdX01WnJEzEQD5nb0PFciotl3LMUcSVhueZAt5aB+a/E06a5yL
         d1tA==
X-Gm-Message-State: AOJu0Yw7h0rVa9piHv2L8mvDcFtysTZ4cFhaQiB4JOl8mUq31PLsKLtw
	Cc0r3iLmTPfX3YPP0dxfrjvWjNRlngHH1PQAXDwp1CnIkSY2RqtenbMUG/GZwwlfDuFX0o3X/JW
	zHA==
X-Google-Smtp-Source: AGHT+IHQfxRoZeNwOqFJdXs7U9dhuzak/9AcePRZQYH58f/39D52wykb9ESAoZ9pjQpLXy9fdKdTaNW+gCM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d1d:b0:6de:622:2ebf with SMTP id
 a29-20020a056a001d1d00b006de06222ebfmr81316pfx.3.1706282637856; Fri, 26 Jan
 2024 07:23:57 -0800 (PST)
Date: Fri, 26 Jan 2024 07:23:55 -0800
In-Reply-To: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
Message-ID: <ZbPOi0760srv0rE0@google.com>
Subject: Re: [RFC] Randomness on confidential computing platforms
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024, Kirill A. Shutemov wrote:
> Problem Statement
>=20
> Currently Linux RNG uses the random inputs obtained from x86
> RDRAND/RDSEED instructions (if present) during early initialization
> stage (by mixing the obtained input into the random pool via
> _mix_pool_bytes()), as well as for seeding/reseeding ChaCha-based CRNG.
> When the calls to both RDRAND/RDSEED fail (including RDRAND internal
> retries), the timing-based fallbacks are used in the latter case, and
> during the early boot case this source of entropy input is simply
> skipped. Overall Linux RNG has many other sources of entropy that it
> uses (also depending on what HW is used), but the dominating one is
> interrupts.
>=20
> In a Confidential Computing Guest threat model, given the absence of any
> special trusted HW for the secure entropy input, RDRAND/RDSEED
> instructions is the only entropy source that is unobservable outside of
> Confidential Computing Guest TCB. However, with enough pressure on these
> instructions from multiple cores (see Intel SDM, Volume 1, Section
> 7.3.17, =E2=80=9CRandom Number Generator Instructions=E2=80=9D), they can=
 be made to
> fail on purpose and force the Confidential Computing Guest Linux RNG to
> use only Host/VMM controlled entropy sources.
>=20
> Solution options
>=20
> There are several possible solutions to this problem and the intention
> of this RFC is to initiate a joined discussion. Here are some options
> that has been considered:
>=20
> 1. Do nothing and accept the risk.
> 2. Force endless looping on RDRAND/RDSEED instructions when run in a
>    Confidential Computing Guest (this patch). This option turns the
>    attack against the quality of cryptographic randomness provided by
>    Confidential Computing Guest=E2=80=99s Linux RNG into a DoS attack aga=
inst
>    the Confidential Computing Guest itself (DoS attack is out of scope
>    for the Confidential Computing threat model).
> 3. Panic after enough re-tries of RDRAND/RDSEED instructions fail.
>    Another DoS variant against the Guest.
> 4. Exit to the host/VMM with an error indication after a Confidential
>    Computing Guest failed to obtain random input from RDRAND/RDSEED
>    instructions after reasonable number of retries. This option allows
>    host/VMM to take some correction action for cases when the load on
>    RDRAND/RDSEED instructions has been put by another actor, i.e. the
>    other guest VM. The exit to host/VMM in such cases can be made
>    transparent for the Confidential Computing Guest in the TDX case with
>    the assistance of the TDX module component.

Hell no.  Develop better hardware if you want to guarantee forward progress=
.
Don't push more complexity into the host stack for something that in all li=
kelihood
will never happen outside of buggy software or hardware.

> 5. Anything other better option?

Give the admin the option to choose between "I don't care, carry-on with le=
ss
randomness" and "I'm paranoid, panic, panic, panic!".  In other words, let =
the
admin choose between #1 and #3 at boot time.  You could probably even let t=
he
admin control the number of retries, though that's probably a bit excessive=
.

And don't tie it to CoCo VMs, e.g. if someone is relying on randomness for =
a bare
metal workload, they might prefer to panic if hardware is acting funky.

