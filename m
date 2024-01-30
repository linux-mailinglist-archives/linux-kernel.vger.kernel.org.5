Return-Path: <linux-kernel+bounces-45117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45893842BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00011F20585
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299278B53;
	Tue, 30 Jan 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BakQh+UC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7469E05
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639753; cv=none; b=PSl7+f5ekkfNV7gjg6ApWB4jGkHcmZq2BmXIPXCHVJ99sttq9vggyB8RJd2HFHcg9MK5GMFKd8AktoQ7Oi4nSjcdpZn8hIFNGK2ib4YzDUQ24AANu9BpXYK6NTlcOaTkSMh7v0n+OSst/YLFnElqU+EYB1fz+ydSQ49j5o/Rj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639753; c=relaxed/simple;
	bh=NuMYWAxwqeNbqERKu7z/ZwgR5K09xc1UznlMLRamtZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCPsPElGjc6URaBRs6iagbKd14IEWIhWLQ9IFd5YlzQ1apu22NwfUT8ROO0jCgiYHERJaL/hFfdL9sx8VdLbkZmU7JPLS7zxNLlgqhoROE4/I9ddukXjF6uo3wPZzCASATYfGGWazClQau6DmFJP1dXIygTvbx1P8Wm0bjpvzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BakQh+UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919F5C43394
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BakQh+UC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706639749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuMYWAxwqeNbqERKu7z/ZwgR5K09xc1UznlMLRamtZo=;
	b=BakQh+UCfaj1zpm4b5gUspdyrLDHcS/dcFK8tGb6OSAu/ygcaX9PR1brtswGOOu0IBd8MI
	mycaWwEMdBZaHrg53Rc1orNFGGfhFCZ16TwAICdym9Bmk1N75O92OBXC3AyCvjs35h4IM/
	s8C3UFxOwhPA9BaX0ILVzCWmMb0o8u0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 66b1406b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 18:35:48 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-602c714bdbeso847467b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:35:48 -0800 (PST)
X-Gm-Message-State: AOJu0Ywtg9I2uYs7IKT2KSiEBCyANr65BygB+yJOwRghnD++qL9rnM3c
	b6m+Oofb9i0d/PDjwldV2w3OOSG5eYTQXDCP+YvOQnSg0BgOyYtqkbhbz/mmKNndv07QvfNL+53
	/+CzbDIKrzo33xtSy1oAVQgOY0LA=
X-Google-Smtp-Source: AGHT+IHMdn33Y7X7wOCyIM6bq/75Q3LozeaSggSqml0kxX+dPbbqD2gOU75ezhMfyw3lAYvr0JMTiKonEZ20IXLI3lE=
X-Received: by 2002:a81:84cc:0:b0:5ff:9390:26d9 with SMTP id
 u195-20020a8184cc000000b005ff939026d9mr1435511ywf.20.1706639747037; Tue, 30
 Jan 2024 10:35:47 -0800 (PST)
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
In-Reply-To: <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 19:35:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
Message-ID: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
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

Elena,

On Tue, Jan 30, 2024 at 3:06=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> 2) Can a malicious host *actually* create a fully deterministic
> environment? One that'll produce the same timing for the jitter
> entropy creation, and all the other timers and interrupts and things?
> I imagine the attestation part of CoCo means these VMs need to run on
> real Intel silicon and so it can't be single stepped in TCG or
> something, right? So is this problem actually a real one? And to what
> degree? Any good experimental research on this?

I'd like to re-up this question. It seems like assessing the reality
of the concern would be worthwhile.

Jason

