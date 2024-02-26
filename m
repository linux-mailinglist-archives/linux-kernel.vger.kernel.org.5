Return-Path: <linux-kernel+bounces-82029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BE867DED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FB285E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899B130E2D;
	Mon, 26 Feb 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cRZGNXUg"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A929130E2E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967477; cv=none; b=DyVMchBoJy00xd6ffZ25zHWkvS7Bz9TIZM1r+MS+hutePOJ6LHu+pI3n5db5h3ic/Icr1AMj+yQkta4thURA/WRdLVolhcwMLW3H7ZoMh8mUevzrIShk6kbU6t6ZyJm3p639rCvLfccAXgk58WA44HWovsAIfKe9HHveHMBNpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967477; c=relaxed/simple;
	bh=Yt1iK6ApoRRAwYIAF8J0XZzIcb/oxLGRDCMiADPPzcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Not363+5cT5jdjwjKJTIcBIjh2jzEXThzmKhNMK60+f5SFxdd/ny4KoNtttVUuaIhL3d0wLeIzyoWRdcLrU8aSYGUyfQnfi5Fv5C8FmUCoOeEOI64Sgrxu9MM81GrBq3qBzGbg9VEtqC4Uro/oUu8xvDxjcoXyE7kD/8/QognCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cRZGNXUg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d484a58f6so467958866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708967472; x=1709572272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOKxowLRXopwaSUBXoFBP7qAPcPHaHQRznoK8vOmNBg=;
        b=cRZGNXUg7tMrDIy/Trs+pcRxxdWR4fXE549Zjdszpu1xsb1bXRsUCtbM5E7WiJL85k
         rTgwTYNeAh5fTsFM4HUvr+t45+SJUdgFfsY05PVp07ATrKKPrXCgI+2gTpuM8cszSbXv
         akWHvy7Dtc7dWU4yLBmPGT49QxCTIe9258MiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967472; x=1709572272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOKxowLRXopwaSUBXoFBP7qAPcPHaHQRznoK8vOmNBg=;
        b=OsHNsOnzIXk2NDKXK0/90M0/KvhRE6DPj8/UziDdHHS96qJc5/qvyKFoOGO8ezN17b
         9fgBVlL2JfpCxBtjKAJt6wFRvpLS3mMkMhm4X9NsPp/Ues9KRKYqcKw97KABAQDDJYeI
         A+y9S9y9VQk/xeazMSDm6cO2CrB0e3Wn6zfhRsiGT8pILkUwspeM7CatKuvgvkLKpBAf
         2pZQj6qcRI4xR50Nchk1tE1NKvMuGZMPSQeoyt7NQbJsG3cMDm4OJf7cJDXCPhju1PwY
         VSCcxvD6rOHns6dEV4p/MySAkfl7p4VGXD+5PhNzFIjlFCUjo/K+nj7e4j7iv3s7jlji
         3jXA==
X-Forwarded-Encrypted: i=1; AJvYcCX03VbLFAxDqcWWsMf6WAnyeTY6N6llUEpNWL2xGWdPlT/GIF8JDZHpu10UBKWRw2s4Gnl7M4krySifn9b3tnLDHGmv3WO+A5PpzZhh
X-Gm-Message-State: AOJu0Yxf6bKtaMmyGg2zI7ohG4jK7hwlj24YH6WgrpKPkZqJ8rO9J6PD
	3lkfpLmQU2UlP53pnr44mnKJhdwpxGq546sZ2ELHitRm2OTxjVNApoqFOsXJH7KpR2sGG28uv91
	gd9N8
X-Google-Smtp-Source: AGHT+IHRjnMoTSEwfpCKw4XbqRvUXPRR0jVnOQM6heaZf3pL4r45eP0geAmmFT/RbxwJTVACt/nWGg==
X-Received: by 2002:a17:906:1183:b0:a3e:e869:a151 with SMTP id n3-20020a170906118300b00a3ee869a151mr4924175eja.45.1708967472537;
        Mon, 26 Feb 2024 09:11:12 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id vx8-20020a170907a78800b00a432777eb77sm1650907ejc.60.2024.02.26.09.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:11:12 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so11305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:11:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmVlgyf02TSbcW4CHrSh9WWpr2F4jgm7LB80KBDZoRrnXjLqz06kSWQ0iRwZcN+ZAGHxZEv85WBjPawuU/Hpa1pNedoTnlRe4lM78e
X-Received: by 2002:a05:600c:5007:b0:412:a9ce:5f68 with SMTP id
 n7-20020a05600c500700b00412a9ce5f68mr40767wmr.2.1708967471006; Mon, 26 Feb
 2024 09:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240221210626.155534-1-adrian.ratiu@collabora.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 09:10:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
Message-ID: <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>, Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> after which it got allowed in commit 198214a7ee50 ("proc: enable
> writing to /proc/pid/mem"). Famous last words from that patch:
> "no longer a security hazard". :)
>
> Afterwards exploits appeared started causing drama like [1]. The
> /proc/*/mem exploits can be rather sophisticated like [2] which
> installed an arbitrary payload from noexec storage into a running
> process then exec'd it, which itself could include an ELF loader
> to run arbitrary code off noexec storage.
>
> As part of hardening against these types of attacks, distrbutions
> can restrict /proc/*/mem to only allow writes when they makes sense,
> like in case of debuggers which have ptrace permissions, as they
> are able to access memory anyway via PTRACE_POKEDATA and friends.
>
> Dropping the mode bits disables write access for non-root users.
> Trying to `chmod` the paths back fails as the kernel rejects it.
>
> For users with CAP_DAC_OVERRIDE (usually just root) we have to
> disable the mem_write callback to avoid bypassing the mode bits.
>
> Writes can be used to bypass permissions on memory maps, even if a
> memory region is mapped r-x (as is a program's executable pages),
> the process can open its own /proc/self/mem file and write to the
> pages directly.
>
> Even if seccomp filters block mmap/mprotect calls with W|X perms,
> they often cannot block open calls as daemons want to read/write
> their own runtime state and seccomp filters cannot check file paths.
> Write calls also can't be blocked in general via seccomp.
>
> Since the mem file is part of the dynamic /proc/<pid>/ space, we
> can't run chmod once at boot to restrict it (and trying to react
> to every process and run chmod doesn't scale, and the kernel no
> longer allows chmod on any of these paths).
>
> SELinux could be used with a rule to cover all /proc/*/mem files,
> but even then having multiple ways to deny an attack is useful in
> case on layer fails.
>
> [1] https://lwn.net/Articles/476947/
> [2] https://issues.chromium.org/issues/40089045
>
> Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mike Frysinger <vapier@chromium.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Tested on next-20240220.
>
> I would really like to avoid depending on CONFIG_MEMCG which is
> required for the struct mm_stryct "owner" pointer.
>
> Any suggestions how check the ptrace owner without MEMCG?
> ---
>  fs/proc/base.c   | 26 ++++++++++++++++++++++++--
>  security/Kconfig | 13 +++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)

Thanks for posting this! This looks reasonable to me, but I'm nowhere
near an expert on this so I won't add a Reviewed-by tag.

This feels like the kind of thing that Kees might be interested in
reviewing, so adding him to the "To" list.

