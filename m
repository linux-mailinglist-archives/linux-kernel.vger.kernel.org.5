Return-Path: <linux-kernel+bounces-13786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA1820E61
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425ED1C2095E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA89BE47;
	Sun, 31 Dec 2023 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/BGgOp4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CEBA3F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC09FC433CB
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704057025;
	bh=ADVGoneIdstsKr16ibvhATBX2Jiv5nuTwiT5ZmAB7uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N/BGgOp4vDBtl27a9MFf6vjYvackawX9UlBVzXl3vwd1QN11AGKDCuHGmXLOKieRn
	 74VnzoVMBf/PnMD7ihBGeqqSNVQ1y/ylz0gQjlVB3ewREmn0iG11g1OYRGljxKqdxm
	 RaVSfODio6dKCw/krph7VRIwBZQM3KuAZIOEU5bO25DuQcGFYFsyEdUzp4LAhxKb6Y
	 +kPCflFBjflxbfe4TEr4umM/gH+0cMvkPPU8KJ3d/CoCCZkQ5uyp6VQ/QOa/sFdNVU
	 E270JNpdb8/1hktYU6K6/hLXFIKufZwxcvBTDFNFPsV/1zisy2iXmJwMK+L8cSoC5s
	 qnZHsQPycTJgg==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6808c3938afso19440496d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 13:10:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyvZKPCi+dygGdWNiXguH2ANtdarwwWx6NpS5iZ7AS3EPyuocdP
	Fo0p9XG4Mb1lHAjwEHa+uCX41HRY8TUXy73Rp6lp5M/9bgD1
X-Google-Smtp-Source: AGHT+IFE+RuDfp0wNzIxM7ulzxdLkwtysZpnvjF5g2Rdw2duSR/L0bQDW47w7X+fmx+mIfbo4pFi/FYf4uHacQVW2Sw=
X-Received: by 2002:a05:620a:22d:b0:781:e26:a513 with SMTP id
 u13-20020a05620a022d00b007810e26a513mr17770518qkm.14.1704057004460; Sun, 31
 Dec 2023 13:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231170721.3381-1-maimon.sagi@gmail.com>
In-Reply-To: <20231231170721.3381-1-maimon.sagi@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 31 Dec 2023 13:09:52 -0800
X-Gmail-Original-Message-ID: <CALCETrUd=16gAYvx93EsyMaaSJ-6mLvSru8Gie48Y+_dXq5FGA@mail.gmail.com>
Message-ID: <CALCETrUd=16gAYvx93EsyMaaSJ-6mLvSru8Gie48Y+_dXq5FGA@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: add multi_clock_gettime system call
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, datglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, 
	hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com, 
	nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org, 
	legion@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 9:07=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.com>=
 wrote:
>
> Some user space applications need to read some clocks.
> Each read requires moving from user space to kernel space.
> The syscall overhead causes unpredictable delay between N clocks reads
> Removing this delay causes better synchronization between N clocks.
>
> Introduce a new system call multi_clock_gettime, which can be used to mea=
sure
> the offset between multiple clocks, from variety of types: PHC, virtual P=
HC
> and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> The offset includes the total time that the driver needs to read the cloc=
k
> timestamp.

Knowing this offset sounds quite nice, but...

>
> New system call allows the reading of a list of clocks - up to PTP_MAX_CL=
OCKS.
> Supported clocks IDs: PHC, virtual PHC and various system clocks.
> Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
> The system call returns n_clocks timestamps for each measurement:
> - clock 0 timestamp
> - ...
> - clock n timestamp

Could this instead be arranged to read the actual, exact offset?

> +       kernel_tp =3D kernel_tp_base;
> +       for (j =3D 0; j < n_samples; j++) {
> +               for (i =3D 0; i < n_clocks; i++) {
> +                       if (put_timespec64(kernel_tp++, (struct __kernel_=
timespec __user *)
> +                                       &ptp_multi_clk_get->ts[j][i])) {
> +                               error =3D -EFAULT;
> +                               goto out;
> +                       }
> +               }
> +       }

There are several pairs of clocks that tick at precisely same rate
(and use the same underlying hardware clock), and the offset could be
computed exactly instead of doing this noisy loop that is merely
somewhat less bad than what user code could do all by itself.

