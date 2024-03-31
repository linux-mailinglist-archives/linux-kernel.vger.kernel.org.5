Return-Path: <linux-kernel+bounces-126182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB3893348
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27091F23802
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C0155A3C;
	Sun, 31 Mar 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ9D70uV"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F8154424;
	Sun, 31 Mar 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902520; cv=pass; b=ANXCOc1bPlPz178MXWVMfFblFkhFPxjw/U/0lRDq035znpZs6u0au1OoWJM1uM+p9FqusumNVQtutwTkBSx980ziAxoMOZr4Bi+wPzsgNy3FEKqp6N9Wlku6WPFmttKrJ1uXZGnYXrOcuCvXQSjCZr2vDYBJHtlDa0nYv8kTxWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902520; c=relaxed/simple;
	bh=+9xtEveTESmqEmgqfqi/AHy+l/CY7o7HoCu99ORDDcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoDZgRjHEf7JNyKvW74p/ALV+zVvE/820y7ObY1p5CNRieRbZ0F3aOVybsYJHbZSAyk4e0GN84L79nd28AZXmIrWES/v/aej9QgevYXpumoeUfnnrFCLYHI3psm8eer+QHkRlX2oSuK9NmUmitzI48C9WibEHpW/Oba0u36JMi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ9D70uV; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8E17A208DC;
	Sun, 31 Mar 2024 18:28:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OdgYfLKVeVlx; Sun, 31 Mar 2024 18:28:37 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AB5F1208E0;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AB5F1208E0
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 9D894800059;
	Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:31 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:59 +0000
X-sender: <netdev+bounces-83536-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAwapAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBnAAAAqIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 15383
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83536-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 226AE20199
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ9D70uV"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711852445; cv=none; b=Pj9ztFoeNFC8W8Bmk7O2Z5NF1FqYCQSQXvXHwYXp92impW8yqIqXKztodGBRpXQU5wfGBPjF30T0jKjGp+dRMIVrE9+rHt+E/sK11cG0ccYiCxhujgs6p0ewfBT+tyH81Ba1BpjFwcgtUyVZk4Fx9c+IJDc8Pbb3UqAFDp4kjvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711852445; c=relaxed/simple;
	bh=+9xtEveTESmqEmgqfqi/AHy+l/CY7o7HoCu99ORDDcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCxe4cBbfRJV3gpTvYKFbbR/6Oo8CmYNpvDoIAdyEoT+Fst6iaUXtghvq3ijq3w1+V6jl8iuUhxs26iFUlXrzTxzkigqaTs5dnoEnR/bLxwsiIwpFFcP1wwql0Rd0L+n+/bc3NcLBp7LSIEUyTq3KbDcKWe4NXrWGbBy3k5Tsu0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ9D70uV; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711852444;
	bh=+9xtEveTESmqEmgqfqi/AHy+l/CY7o7HoCu99ORDDcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PZ9D70uVOm8Q1eV7TepfO1FkN+1k1kWNkT6Ku6f/2s6iTAOV7tZxn2zhkvPsVyaFX
	 RPw7j/3dyOXbWPTqh7GDBBmESHoa0/CSjp3BgTh7gbx5KJ1tdiDym07g+AY4FzPgQS
	 DKX7tgoR9K9mHdV/+tGZPsttPaEAScJJhqA81HNprVN9Fu9EJ0XTEzkGTvbaVJb6Hx
	 Qzks5PLB5vorWVg53klblNq3phtjvnvFZqLRpBY/lb0TuCBuxS4GgeeCTYGb+VI6ok
	 zfc1qtwfOHsXCTucSL4Xb61hPPubFgtHkxN2eCV1J182QybCpwgfTt0/4sSb25g/FL
	 PUk6ZaAAFbN5g==
X-Forwarded-Encrypted: i=1; AJvYcCVDkGXqULJb0iTE30zok3Z/DcAitzYB9HUyf5pQ/qSbH7TnoDghRS696d3Z3Bc7u3vJtKOCIyp0hkqFnVKFWXLHRnz0A8czvwM7M2KtNDkdHOpr2c074bO9nltfNZLNpXSwZIksKCLZNGtZiA0bHX646SeY+kLLS+WUzjnVm4MKEuoM
X-Gm-Message-State: AOJu0YzWfQ4zDI0K2CTviHTVM/YUaXaFBBv4MmJVL07IxX6zt/sEhULv
	8wYbpd4A6ohvhE1X1s1afNGS2g9DPx2m3V/0v8z3Oa7dpCwciQaRAnkxDrAd98WqSrH+OiQMNXB
	qPMEzBdnsGuo/e1Si+icML8zVNFY=
X-Google-Smtp-Source: AGHT+IGpEQPL0v7g3+p+5E8g7HGnWQKzlMop6CryhqCRVmhK61t313PDdp5vf1ukKDWFXpyLX2tmge1Ix/vKXAwQ4u4=
X-Received: by 2002:a2e:9914:0:b0:2d4:6aba:f1a9 with SMTP id
 v20-20020a2e9914000000b002d46abaf1a9mr4254960lji.40.1711852443253; Sat, 30
 Mar 2024 19:34:03 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326144741.3094687-1-arnd@kernel.org> <20240326144741.3094687-2-arnd@kernel.org>
 <87jzlohhbc.fsf@intel.com> <cb853762-06d4-401c-a1c8-07a0c031b499@app.fastmail.com>
 <87edbwglle.fsf@intel.com> <07c604d1-6304-4ff8-844b-03c3d5c727ad@app.fastmail.com>
In-Reply-To: <07c604d1-6304-4ff8-844b-03c3d5c727ad@app.fastmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 31 Mar 2024 11:33:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmABUDDTFtp_HCqKid7=8011wk0HMgHYGHWOLunhpxXA@mail.gmail.com>
Message-ID: <CAK7LNARmABUDDTFtp_HCqKid7=8011wk0HMgHYGHWOLunhpxXA@mail.gmail.com>
Subject: Re: [PATCH 01/12] kbuild: make -Woverride-init warnings more consistent
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>, 
	linux-kbuild@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Linus Walleij <linus.walleij@linaro.org>, 
	Joel Stanley <joel@jms.id.au>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Mar 27, 2024 at 6:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Mar 27, 2024, at 08:50, Jani Nikula wrote:
> > On Tue, 26 Mar 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> On Tue, Mar 26, 2024, at 21:24, Jani Nikula wrote:
> >>> On Tue, 26 Mar 2024, Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> It works now.
> >>
> >> The original __diag_ignore_all() only did it for gcc-8 and above
> >> because that was initially needed to suppress warnings that
> >> got added in that version, but this was always a mistake.
> >>
> >> 689b097a06ba ("compiler-gcc: Suppress -Wmissing-prototypes
> >> warning for all supported GCC") made it work correctly.
> >
> > Oh, nice! Then I think we'd like to go back to __diag_ignore_all() in
> > i915 and xe.
> >
> > The diff is below. I'm fine with you squashing it to your patch, or if
> > you want me to turn it into a proper patch for you to pick up in your
> > series, that's fine too. Just let me know.
>
> I think I'd prefer to keep my patch simpler for the moment and
> get that merged through the kbuild tree, it already touches
> too many places at once.
>
> It may be better for me to just drop the drivers/gpu/ part of
> my patch so you can just just take your patch through the
> drm tree. I actually have a similar patch for the amdgpu driver
> that I can send if you like this option better.
>
>     Arnd
>



Applied to linux-kbuild/fixes.
Thanks.

--=20
Best Regards
Masahiro Yamada


