Return-Path: <linux-kernel+bounces-59908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F484FD36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38491C246B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F984A56;
	Fri,  9 Feb 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nSzQKepy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98E8287F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508405; cv=none; b=ZbMqFoPR72x0e63joqLeTjlEfHhl2Zxhx2Sscns1l3LdVjTH3Tnzqx457mNep6K3PD9iP8TeKzq4AYAE9p7hgosOFfKGwdIDHJgXes2VwzHQ3YgYDJptJP7cvetI0KCPEVnDmf86QFnAKXbUX61+pEScpyTchlYYJZCkXbIiuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508405; c=relaxed/simple;
	bh=LJIFwC8k9S1XsGgVeDvZlU1w3z5QzGRmOgRDGw9A1bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIfQRCbVrmgH9c5ZWl/ifWm+J5bXN1hJlrhfjJYORStoscezjhN7HktlkdB00QYT3KNW3lC00PViRCc4pVgDXQfyR4KjSNlJII6G/ByLDGIXoIXAM43eM4HbuG5u/7wLvIVTgkHAwYYvAjIplXRYzOOaSIIfTfb45Dc5H9LnUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nSzQKepy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D350C43390
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nSzQKepy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707508401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvzf8anF/xolUSyJeFvlIlkwZn341uHj6NRh1hIQN2U=;
	b=nSzQKepyd1UwZ0OU4oEVJ2oi143l6wdsN/YmS4u6fnGNT/DQwMg4agRt218nzCyJWUn3el
	FH4sIUmOjnq9oft/HW8haSb7mD05Mw8gBoMjtp2Swtpc/XPcj3nln+bk8Yr/GHaIYNWJZ/
	AxHmkQG+xIozdJmtThA2TGC08DvyjHw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 017d3912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Fri, 9 Feb 2024 19:53:21 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6049ffb9cedso15743597b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:53:20 -0800 (PST)
X-Gm-Message-State: AOJu0YywJX8GaOYg0K3Al9BouiRy192jEl3rTEMGQaAHc9Y5kVd0E5Aj
	6no9CyUHgtp+DXxGDsJspps3Kdc+z6bTVVjh9i9TjnEM3jMChnNmGK/A8JhPfY8Zk0t5CXbXuX8
	/hxrtClENU2w5894tMkdiJXHYOKs=
X-Google-Smtp-Source: AGHT+IGep7MreGa1qNSxjgy79NorsGSpOFmd0e/BRU1HXP/yciy0w6ccd/i5a+ExBWXD3SJb4Up/c4p2ygaSEpQu8M0=
X-Received: by 2002:a0d:e543:0:b0:604:96c8:652a with SMTP id
 o64-20020a0de543000000b0060496c8652amr237052ywe.24.1707508399446; Fri, 09 Feb
 2024 11:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu> <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu> <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu> <Zb4RlTzq_LV7AzsH@zx2c4.com>
In-Reply-To: <Zb4RlTzq_LV7AzsH@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 9 Feb 2024 20:53:07 +0100
X-Gmail-Original-Message-ID: <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
Message-ID: <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Sat, Feb 3, 2024 at 11:12=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> Yea, actually, I had a pretty similar idea for something like that
> that's very non-invasive, where none of this even touches the RDRAND
> core code, much less random.c. Specifically, we consider "adding some
> extra RDRAND to the pool" like any other driver that wants to add some
> of its own seeds to the pool, with add_device_randomness(), a call that
> lives in various driver code, doesn't influence any entropy readiness
> aspects of random.c, and can safely be sprinkled in any device or
> platform driver.
>
> Specifically what I'm thinking about is something like:
>
> void coco_main_boottime_init_function_somewhere_deep_in_arch_code(void)
> {
>   // [...]
>   // bring up primary CoCo nuts
>   // [...]
>
>   /* CoCo requires an explicit RDRAND seed, because the host can make the
>    * rest of the system deterministic.
>    */
>   unsigned long seed[32 / sizeof(long)];
>   size_t i, longs;
>   for (i =3D 0; i < ARRAY_SIZE(seed); i +=3D longs) {
>     longs =3D arch_get_random_longs(&seed[i], ARRAY_SIZE(seed) - i);
>     /* If RDRAND is being DoS'd, panic, because we can't ensure
>      * confidentiality.
>      */
>     BUG_ON(!longs);
>   }
>   add_device_randomness(seed, sizeof(seed));
>   memzero_explicit(seed, sizeof(seed));
>
>   // [...]
>   // do other CoCo things
>   // [...]
> }
>
> I would have no objection to the CoCo people adding something like this
> and would give it my Ack, but more importantly, my Ack for that doesn't
> even matter, because add_device_randomness() is pretty innocuous.
>
> So Kirill, if nobody else here objects to that approach, and you want to
> implement it in some super minimal way like that, that would be fine
> with me. Or maybe we want to wait for that internal inquiry at Intel to
> return some answers first. But either way, this might be an easy
> approach that doesn't add too much complexity.

I went ahead and implemented this just to have something concrete out there=
:
https://lore.kernel.org/all/20240209164946.4164052-1-Jason@zx2c4.com/

I probably screwed up some x86 platform conventions/details, but
that's the general idea I had in mind.

Jason

