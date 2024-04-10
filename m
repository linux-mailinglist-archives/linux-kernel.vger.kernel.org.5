Return-Path: <linux-kernel+bounces-139027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12989FDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A443F282CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80CA17F384;
	Wed, 10 Apr 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCJdMayQ"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A817F36C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768551; cv=none; b=Mpe4PuKks53+mfPtbf1MGBvHVzXQJPJAGbl41gQOFAVOZjOjIZn3cqZqn0LUoMdeaDogWhE+aK8Bv8XVwuzZJv4CXDV86oLQs7DlegRPunHpFx9vG0gb9Ti3pzUrcBCf9d+atZvXq43P4gyFuiWUe8HyQhCHw6jjo/7UypZSrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768551; c=relaxed/simple;
	bh=Ro3xK5q4IrY0T9S12NVIoXoa4EqFPVxp3QMVafHPnmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiEUKGUWz7lazirvMCkNtg/hQEGNdN4MhnM44bV4vJ2ECUlJKev/DV0cVgQZkjQuyJ4EJItqRxUAmMOXA8aijF3eN2jvrAQOJft8AEcP/B6aRUU7uLxaaGT3JYs/pkGxPyuQQ6ZP50J2Pyl7TxIS5iIFSWGZSBq9WnW8sVHprZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCJdMayQ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c60019ee02so483642b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712768548; x=1713373348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMoPP11thXk4/7UbTWGCDNVZtlBCq9YfZi08dxGpwkM=;
        b=gCJdMayQNcptgjdyj0XaPYS/CKWxiizmrKkPOZNY0BJquD+IwfqjDWiRiNpCUs33P7
         +YVtVAie+wmxlztmBDbeqrmxb/AN5GmAoISgmi9wEM3M7BQBgROwPk9vcIy+DEtsYsi1
         S+HtUFuuH4cYepRdrbjYd3Sib1mPdNt+lgDkERubGTY/9qmT8+re7qk6sx9vYgGqeMvW
         0Rte4kJkErC8SJggf/EXJasb0QhCZP/hJwyukXcOa9Neb7BJjdyxiA3ZJpPAbhjk01Kl
         Ud9klQBZNxFct+Qj+nPL2xlmiR+eUnAgnrD6+Ey0tGebf3ydWAJ31bKorzKk8VvMsfZ7
         1Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768548; x=1713373348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMoPP11thXk4/7UbTWGCDNVZtlBCq9YfZi08dxGpwkM=;
        b=WBV10rg6p53Wt+1nsmg02YqEJWdEGJUreHPlujB59FX8o7ryIBWldKRyDRgD9XJb03
         tE+9SNjBip9Abej0oL53NP8fGo+ONHfG9Zi1ppQQH8ki/BgYVOZ5saGjTzN8SDhVayiN
         MDgEk5oh/9reU9qa8llTw064ICwzyAF4tQP79HSxDA9rw/0ZmKyXpfn6uAuJ6QkEjj5b
         Pz7a8KLzSNEgcoVxx1VscKMtE3rPMq/y97Z7fChhmLyd4I9SwsTku9TcpgFqMsTh1oe6
         tDsZQnbuBeWdTgWTqaq3KNPNh33AOn/K1v52aIW1chRcdm5UQ+cA7Jqn6aUu8yXUEbm+
         bZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYBx6CmcPnVsmaN+Ac3OY1qyG9NguESpOWFjy/PHzX+MqqpPztcGGfHwJoW3hic/iYzDAr3/7nGJWfXeJXaSSJLWsEkaianN9PZU12
X-Gm-Message-State: AOJu0Yx+0x5GtrhRqbQmPTtpuwet//Dw29espOmATG7Xmg7Fb31uA5vG
	PyMtMS7xQmK7+rcxnxVp2aFcQqTIOD2aZ2WiasrpetPnxHOdcAZt28RqVYakv8UjkLaWsG5Wgj7
	X89Qh7qxDI+hR+ct8N+aafAPyDyYuaG54zNQQ5g==
X-Google-Smtp-Source: AGHT+IFNF1nhZXvybXgcJEFh8M4RKpKSYief0sXA9TsDfyic6FFts1F5HiYeJTzbEnw67nBhXnq5gM9nLeSrRUK3LkY=
X-Received: by 2002:a05:6808:20a3:b0:3c5:f831:5f33 with SMTP id
 s35-20020a05680820a300b003c5f8315f33mr3792446oiw.16.1712768548028; Wed, 10
 Apr 2024 10:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410153212.127477-1-adrian.hunter@intel.com>
In-Reply-To: <20240410153212.127477-1-adrian.hunter@intel.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 22:32:16 +0530
Message-ID: <CA+G9fYsZcOv+tE09K20b7G=4s9D=HxAYwMV_zx0oWa1r2mqdrg@mail.gmail.com>
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 21:02, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> BUG() does not return, and arch implementations of BUG() use unreachable(=
)
> or other non-returning code. However with !CONFIG_BUG, the default
> implementation is often used instead, and that does not do that. x86 alwa=
ys
> uses its own implementation, but powerpc with !CONFIG_BUG gives a build
> error:
>
>   kernel/time/timekeeping.c: In function =E2=80=98timekeeping_debug_get_n=
s=E2=80=99:
>   kernel/time/timekeeping.c:286:1: error: no return statement in function
>   returning non-void [-Werror=3Dreturn-type]
>
> Add unreachable() to default !CONFIG_BUG BUG() implementation.
>
> Fixes: e8e9d21a5df6 ("timekeeping: Refactor timekeeping helpers")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYvjdZCW=3D7ZGxS6A_3bysjQ56YF7S-=
+PNLQ_8a4DKh1Bhg@mail.gmail.com/
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This patch applied on top of today's Linux next-20240410 tag and
build test pass.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
>  include/asm-generic/bug.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

--
Linaro LKFT
https://lkft.linaro.org

