Return-Path: <linux-kernel+bounces-45176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2BC842C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759D9B22630
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDF7AE51;
	Tue, 30 Jan 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O8Jl/AK7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC187AE4E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642197; cv=none; b=QuN3tSkbyFfXr6Q14kgjDu9GqtmQw6+sRQBs8UrUxWe4eg8NCrRXqib0wFXIcACDh4eOLTOe/+/dAjfuqlgLMZQAQbEYlrfQvlNWbmfYnBznWHJzmpIKXUiYhVl3Scjgz2JWL1I1F5rChTv1Ds0FgJMvFc9FFyXCwGjtX9wQPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642197; c=relaxed/simple;
	bh=FOGTgz8QyzT/ZF/Z5hhIwI5EdOmk9zDiwfNKjfkeYko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDjEB8gqKfW0f01GeI4hYNNIy7Kcocq2myfhdPV/U8iQ3969BmHeaGIX/HsvC7IfV63yfkL7CN+ls2wDE7J5ae6l0WVCDv3xMP/erl1jCmZ9qVj8GxJeFdyjw71P6rnSl0sACkIw6L11TbR0Uly3qOEL3f4B5xyN5+a9bgNVKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=O8Jl/AK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C6C433F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:16:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O8Jl/AK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706642194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOGTgz8QyzT/ZF/Z5hhIwI5EdOmk9zDiwfNKjfkeYko=;
	b=O8Jl/AK71u43fIHtRXabN02FyvK28GDp5NHnbg4eCl9plX6aNgmSACa2ZgLUhrcyyaIzTy
	3wOoIYp5k3RqcW8QDAcp9/r9N9BINxD9/VkTeiYp5ELh3Lh0RCLzoH2WqmGGD/QDCo2nwM
	sru9NONxcP2xKTSnCjtCaPafJHHF8bA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5e5bfacf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 19:16:33 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so4666737276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:16:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxAfEeS+yJUYlZVwrVfnI3D/7OCVN5R4j1QO2x0LMcFuLnDDb4f
	u/EJCcKQy6suGfsPdONznOp1lmNzTfO82jVNuKte1BByL2VGju1DcRb9AkjDGNAxdmNkvYdr9Bs
	6rCCwAJe5B/EGw2OGcJ5AHfYJo0w=
X-Google-Smtp-Source: AGHT+IFKROBZjHRa9s5PTu3r1D0HpehKbjeDA7mAVb/D5WsyVsnKN3orzZkfHYEeBLOaCMFtEebHMUmR9wcb8Qxx0bg=
X-Received: by 2002:a05:6902:1022:b0:dc2:3f75:1f79 with SMTP id
 x2-20020a056902102200b00dc23f751f79mr6364693ybt.23.1706642191426; Tue, 30 Jan
 2024 11:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com> <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 20:16:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
Message-ID: <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
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

Hi Elena,

On Tue, Jan 30, 2024 at 8:06=E2=80=AFPM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> Yes, sorry, I am just behind answering this thread and it is getting late=
 here.
> This is exactly what I would like to have an open discussion about
> with inputs from everyone.
> We have to remember that it is not only about host 'producing'
> a fully deterministic environment, but also about host being able to
> *observe* the entropy input. So the more precise question to ask is
> how much can a host observe?

Right, observation is just as relevant.

> My personal understanding is that host can
> observe all guest interrupts and their timings, including APIC timer inte=
rrupts
> (and IPIs), so what is actually left for the guest as unobservable entrop=
y
> input?

Check out try_to_generate_entropy() and random_get_entropy(), for
example. How observable is RDTSC? Other HPTs?

> > > I imagine the attestation part of CoCo means these VMs need to run on
> > > real Intel silicon and so it can't be single stepped in TCG or
> > > something, right?
>
> Yes, there is an attestation of a confidential VM and some protections in=
 place
> that helps against single-stepping attacks. But I am not sure how this is=
 relevant
> for this, could you please clarify?

I was just thinking that if this didn't require genuine Intel hardware
with prebaked keys in it that you could emulate a CPU and all its
peripherals and ram with defined latencies and such, and run the VM in
a very straightforwardly deterministic environment, because nothing
would be real. But if this does have to hit metal somewhere, then
there's some possibility you at least interact with some hard-to-model
physical hardware.

Jason

