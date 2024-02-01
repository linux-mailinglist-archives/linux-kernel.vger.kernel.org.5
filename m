Return-Path: <linux-kernel+bounces-48668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F18845F95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129031C27AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD1484FB3;
	Thu,  1 Feb 2024 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XWjROKzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49312FB23
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810978; cv=none; b=CT4RE1CHkdDAs3CHYRYF4v+ym/ncFoFZaAWQneLS5QqCF2qWftZhUPkBQiu9pj9ERTJf+phDzRZJXq3HArB2s29BNj94jpa4A2azoKmPobI70PJ+wlBpM/62igXszuL1AJO2HuCTGJq+7oNxUGKVKXj3AiYxJgEy263ebw+IKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810978; c=relaxed/simple;
	bh=XjAesaMRPLp5QxyOh8ZLeX5dtHwXo+xamByfNTJNWZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DafdnSEh4jsv+7/wrBE/B4f51dUitvUL12xNHGvEbNpLCKmvsUu+P5d95KNll+7zfj0ONQD+TqwrbKRD7hr7svJy61LaWjFOcVoYVUqxKPRYF0K+uz/Ii7QQkYgHFa0p0w6QmzVGw3wTO0fyw7pNZpF50IC9YlUMvgLQYY7LULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XWjROKzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F10C433C7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XWjROKzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706810972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5FPzyCgS3qlpBxGuSDs3VA0uLft4F+6gNLOCZnu3Ao=;
	b=XWjROKzTtY0aX0iPy4BY8oQI7YxqZ4B6U2mkS2XMgZsduHzT2UXIQnUEeD/XD5aN1l0PJP
	y18V6HQ7m2F1u1dczNzDLqyYy6CPugk+SbeikCEPzbUqKOLbVs//B4O3Q/N+4n5cvcwwq4
	F5q4WAIsjBxx2ANA1q7wLKuq55hWTaw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67f18ffe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Thu, 1 Feb 2024 18:09:32 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e2794e5a35so240000a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:09:32 -0800 (PST)
X-Gm-Message-State: AOJu0YytMgg7uR5e6eUsMJ4zpmWx4E8qXdab+gj/NViITa/wL9SeKHP/
	65xWFNLWr+6CFQJAsWRzq0NPzS2C5iLOF85Lz8/MZlEJSSgFfpySPqZH7E6NgS8/CdErwrgIceD
	Di9nIC03MV8C6n1cmonPXKyYHxZ4=
X-Google-Smtp-Source: AGHT+IHH/xWjBAnQeRWIcaxySsGSIZkkOGMkMq5jS9NRPgQhc/dVRXjOarvdrc697ZXXsj/QVgmJEQQ8H8vw1Xe6iks=
X-Received: by 2002:a05:6358:1901:b0:178:a295:996 with SMTP id
 w1-20020a056358190100b00178a2950996mr6216795rwm.22.1706810970033; Thu, 01 Feb
 2024 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu> <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com> <20240201045710.GD2356784@mit.edu>
In-Reply-To: <20240201045710.GD2356784@mit.edu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 1 Feb 2024 19:09:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
Message-ID: <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
To: "Theodore Ts'o" <tytso@mit.edu>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted, Elena, Dave,

On Thu, Feb 1, 2024 at 5:57=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Jan 31, 2024 at 07:01:01PM +0100, Jason A. Donenfeld wrote:
> > So if this is what we're congealing around, I guess we can:
> >
> > 0) Leave RDSEED alone and focus on RDRAND.
> > 1) Add `WARN_ON_ONCE(in_early_boot);` to the failure path of RDRAND
> > (and simply hope this doesn't get exploited for guest-guest boot DoS).
> > 2) Loop forever in RDRAND on CoCo VMs, post-boot, with the comments
> > and variable naming making it clear that this is a hardware bug
> > workaround, not a "feature" added for "extra security".
> > 3) Complain loudly to Intel and get them to fix the hardware.
> >
> > Though, a large part of me would really like to skip that step (2),
> > first because it's a pretty gross bandaid that adds lots of
> > complexity, and second because it'll make (3) less poignant
>
> If we need to loop more than, say, 10 seconds in a CoCo VM, I'd just
> panic with a repeated RDRAND failure message.  This makes the point of
> (3) that much pointed, and it's better than having a CoCo VM
> mysteriously hang in the face of a DOS attack.

Yea, true. Problem is that in theory, userspace can DoS the kernel's
use of RDRAND. Of course in practice, a userspace process preempting a
kthread for >10 seconds is probably a larger problem.

Anyway, I want to lay out the various potential solutions discussed.
As they all have some drawback, it's worth enumerating them.

=3D=3D

Solution A) WARN_ON_ONCE(is_early_boot)/BUG_ON(is_early_boot) in the
RDRAND failure path (> 10 retries).

The biggest advantage here is that this is super simple and isn't
CoCo-specific. The premise is that if RDRAND fails 10 times in a row
before userspace has started, it's most definitely a hardware problem.
Systems-wise, the drawback is that, in a VM, it alternatively might be
a guest-guest DoS attack on RDRAND, or in the CoCo case, a host-guest
DoS attack (which is presumably easier because the host controls
scheduling). In the CoCo case, not booting is better than losing
confidentiality. In the non-CoCo case, that seems like theoretically a
DoS we might not want. RNG-wise, the drawback is that this doesn't
help deal with secure reseeding later in time, which is a RNG property
that we otherwise enjoy.

Solution B) BUG_ON(is_early_boot && is_coco_system) in the RDRAND
failure path (> 10 retries).

This is slightly less simple than A, because we have to plumb
CoCo-detection through to the RDRAND helper. [Side note: I feel
ridiculous typing 'CoCo'.] Systems-wise, I don't see drawbacks.
RNG-wise, the drawback is that this doesn't help deal with secure
reseeding later in time, which is a RNG property that we otherwise
enjoy.

Solution C) WARN_ONCE()/BUG() in the RDRAND failure path (> 10 retries).

The advantage here is also simplicity, and the fact that it "ensures"
we'll be able to securely reseed later on. Systems-wise, the drawback
is that userspace can in theory DoS the kernel's RDRAND and cause a
crash.

Solution D) BUG_ON(is_coco_system) in the RDRAND failure path (> 10 retries=
).

This is slightly less simple than A, because we have to plumb
CoCo-detection through to the RDRAND helper, but it "ensures" we'll be
able to securely reseed later on. Systems-wise, the drawback is that
userspace can in theory DoS the kernel's RDRAND and cause a crash.

Solution E) BUG() in a new time-based RDRAND failure path on CoCo
systems (> 10 seconds).

This adds a lot of complexity, and we'd need some alternative code
path for CoCo with an infinite loop that breaks on a jiffies
comparison. But it at least makes it harder for userspace to DoS the
kernel's use of RDRAND, because it seems hard for a user thread to
preempt a kthread for that long, though maybe somebody has some nasty
scheduler tricks here that would break that hope.

Solution F) Loop forever in RDRAND on CoCo systems.

This makes debugging harder because of lockups (though I suppose we
could WARN after some amount of time), but at least it's somewhat
"sound".

=3D=3D

I am currently leaning toward (B) as being the lightest touch that has
the least potential to break anything. (F) is also tempting because it
doesn't have the RNG-drawback. The others seem complex or incomplete
or otherwise annoying somehow.

There is also "Solution G" -- do nothing and raise a fuss and let
security researchers go to town and hope Intel gets their act
together. Given that the CoCo thing seems kind of
imaginary/aspirational anyway at this point, I'm very attracted by
this. I don't mean to say that I intend to mount a large argument that
we *should* do nothing, but it's just sort of sitting there in the
back of my mind as an appealing possibility.

Also, I wanted to enumerate currently open questions:

=3D=3D

Question i) Just how deterministic can these CoCo VMs be? Elena
pointed to some TDX code regarding RDTSC that seemed fairly damning,
but I also wonder what gotchas a motivated researcher might run into
and how those could help us (or not).

Question ii) Just how DoS-able is RDRAND? From host to guest, where
the host controls scheduling, that seems easier, but how much so, and
what's the granularity of these operations, and could retries still
help, or not at all? What about from guest to guest, where the
scheduling is out of control; in that case is there a value of N for
which N retries makes it actually impossible to DoS? What about from
userspace to kernelspace; good value of N?

Question iii) How likely is Intel to actually fix this in a
satisfactory way (see "specifying this is an interesting question" in
[1])? And if they would, what would the timeline even be?

=3D=3D

Anyway, that's about where I'm at. I figure I'll wait to see if the
internal inquiry within Intel yields anything interesting, and then
maybe we can move forward with solutions (B) or (F) or (G) or a
different Roald Dahl novel instead.

Jason

[1] https://lore.kernel.org/all/CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=3D-UxxGFb=
Ax_RrxSHoA@mail.gmail.com/

