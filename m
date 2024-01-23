Return-Path: <linux-kernel+bounces-34820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4098387ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A85B20E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B889524D0;
	Tue, 23 Jan 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyi+vU//"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93E51C44
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994655; cv=none; b=VarVMXISLBAQrIkDnoOe8sYrwM/DI957aZpadluBKAqESPxARxGioChB5hQPJBusgNPtKyXZYuHkeu8j2tZGXLgnlZukNdMs9b1l1fryT0XeZSK96uzSFbqXmZ+XvTvQ7o61d1bj3i01BBEyeO5hbayRkWYai3V5y6DfK93LRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994655; c=relaxed/simple;
	bh=cb5z/X6vgBNCokXH2o1ttSfZ5AeljFRrlKnYcs7kc+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bux+hs/Bcfl+TkP9UozLIcn6KD1R4enYFcOidSLFIkRACID874KZLVN+DSABUwooDVJnnUkuvGZUx3AP3Hsxg5BM2WF+bevt9vHtNxQaBz7j+8xRDxSk6Fv6jQFAtiYV9XkPs+DhbaEjwtHQLAhR1ANXEF96GKnJuCm1HimVn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vyi+vU//; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dd7c5437b0so150503b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705994652; x=1706599452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+bZRTLUDZoJ2eqVY8R6JDBRomIID8vEH2x+iQzxMJbE=;
        b=Vyi+vU//dn6LzeW5ErjYmQTXT9Ab2vDwlagzFq3mM9gcNPk1pFCXd0HVx2So6bAXS8
         W5C4wE8wng2cycezW5zb03dX3isfyEIGcJzSRBf2HGqxYJcfDWlgnQtXAejPfN8V7t98
         jhuhNIgFqvndYi02GH3UEfZIUh5yJ2J9nWTStdR0eRe6AyYjwv4X76ezoew9h8ObWE47
         0bnh3m5B7fttlBQwzpqdE0I2S8zwkupG3kuLHWvrG4CEv6TGt3A/Yii0f6rl6j+PIxi8
         4f8Eco+EFFJK3hw94qt3K3js4JM5+glq/ZMGxKrvvAZONvqhf/yNwZOEf7FA2VOSvHNT
         GX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705994652; x=1706599452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bZRTLUDZoJ2eqVY8R6JDBRomIID8vEH2x+iQzxMJbE=;
        b=BORByPtTKCeDwHr3q0ej6VTG3JYhTjKH4G2wvED75mLxlT3tU3OML4kwa7AmyqUGtC
         ceuZTqA3T08RERFRMbqeiR8fqy9nxXH8pYnkgXOi+KR3CSrsJaOuVkWe9NxyDIe9fFWp
         NllA8Tgg/SZZ4HwTroevy0W3bKkxNx1q1fR25iCtlwWnVK2x39oQ112gpG5kvBYxbS09
         u4ddLrsicpLLBETJ8rfKZRu2bFZqOaxBiuuoJ5xrdQS+MTkBwoXpakMYl7qLGxSEGeSj
         WlShx1A7+4dwc7m6Zzy2xVlsi7rZoGhEPBR/QG0SAz2wazjaCdKI8yWLzj9n7/B9Gz4l
         LGPA==
X-Gm-Message-State: AOJu0YwDmkR1HIKlYHKFd7PwZST1zSGeQ0GoElP3U4Rv2eUfuFjSb6fY
	frFrZh5HES2ikuLPDl03gc2qiWZsEyKvYR4ZrH4lfo9hVrWN71UeoLZRxXctqyFDMyemy0F+j0k
	JlT7xcKYM/cIVFxbCHcfSr4vkHt3v4XejczkT9g==
X-Google-Smtp-Source: AGHT+IHVmiMt82VatuhVofaY5FVFMvPoCE3YYBhgAKdfsgL6rSGLizm5EKfBXLxrimqyx8IzR9Zonlh+yb1EWL31x7I=
X-Received: by 2002:a05:6a20:7d86:b0:19c:2f49:96d with SMTP id
 v6-20020a056a207d8600b0019c2f49096dmr4488224pzj.64.1705994651992; Mon, 22 Jan
 2024 23:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
 <20231211104855.558096-4-vincent.guittot@linaro.org> <Za8cjQXptttuyb6c@finisterre.sirena.org.uk>
In-Reply-To: <Za8cjQXptttuyb6c@finisterre.sirena.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Jan 2024 08:24:00 +0100
Message-ID: <CAKfTPtAOJpr8VbXwSY_UMTf5Y2gEHAsobjHnJXqe1K1QDGygCA@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] cpufreq/schedutil: Use a fixed reference frequency
To: Mark Brown <broonie@kernel.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com, suagrfillet@gmail.com, 
	ajones@ventanamicro.com, lftan@kernel.org, beata.michalska@arm.com, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

Could you tried this fix:
https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/

Regards,
Vincent

On Tue, 23 Jan 2024 at 02:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Dec 11, 2023 at 11:48:51AM +0100, Vincent Guittot wrote:
> > cpuinfo.max_freq can change at runtime because of boost as an example. This
> > implies that the value could be different than the one that has been
> > used when computing the capacity of a CPU.
>
> So, this seems very weird but I just finished a bisection of a failure
> that showed up during the merge window with the DT kselftests on
> meson-gxl-s905x-libretech-cc (Libretech Le Potato) running an arm64
> defconfig.  Looking at the commit this seems like a very surprising
> false result but I verified that the commit before this one runs fine
> and reproduced the failure, the bisect does seem to converge well also
> so it appears like there's something going on.  Does this ring any bells
> for anyone?
>
> The test is timed out by the kselftest wrapper:
>
>    kselftest: Running tests in dt
>    TAP version 13
>    1..1
>    # timeout set to 45
>    # selftests: dt: test_unprobed_devices.sh
>    # TAP version 13
>    #
>    not ok 1 selftests: dt: test_unprobed_devices.sh # TIMEOUT 45 seconds
>
> with no obvious effect on the system, a successful run takes less than
> 20 seconds so it shouldn't be that the timing is marginal.  I'm guessing
> that reading the one of the files under /sys/devices hung.  No other
> boards in my lab are affected and I'm not immediately seeing anything
> remarkable about this board.  Full log from a bad run at:
>
>     https://lava.sirena.org.uk/scheduler/job/493329
>
> and a good run:
>
>     https://lava.sirena.org.uk/scheduler/job/492453
>
> Bisect log (the skipped commits didn't build):
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [4fbbed7872677b0a28ba8237169968171a61efbd] Merge tag 'timers-core-2024-01-21' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 4fbbed7872677b0a28ba8237169968171a61efbd
> # status: waiting for good commit(s), bad commit known
> # good: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
> git bisect good 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> # bad: [ba5afb9a84df2e6b26a1b6389b98849cd16ea757] fs: rework listmount() implementation
> git bisect bad ba5afb9a84df2e6b26a1b6389b98849cd16ea757
> # bad: [de927f6c0b07d9e698416c5b287c521b07694cac] Merge tag 's390-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect bad de927f6c0b07d9e698416c5b287c521b07694cac
> # bad: [35f11a3710cdcbbc5090d14017a6295454e0cc73] Merge tag 'mtd/for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> git bisect bad 35f11a3710cdcbbc5090d14017a6295454e0cc73
> # bad: [d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9] Merge tag 'slab-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
> git bisect bad d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9
> # skip: [968b80332432172dbbb773e749a43bdc846d1a13] Merge tag 'powerpc-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect skip 968b80332432172dbbb773e749a43bdc846d1a13
> # good: [372a34e66fb7f95124fadae9c600b231c35696a7] fs: replace f_rcuhead with f_task_work
> git bisect good 372a34e66fb7f95124fadae9c600b231c35696a7
> # good: [ae24db43b3b427eb290b58d55179c32f0a7539d1] powerpc/ftrace: Remove nops after the call to ftrace_stub
> git bisect good ae24db43b3b427eb290b58d55179c32f0a7539d1
> # skip: [3cf1d6a5fbf3f724d12b01635319924239d42c00] Merge tag 'm68k-for-v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
> git bisect skip 3cf1d6a5fbf3f724d12b01635319924239d42c00
> # good: [2a33e2ddc6ebf9b5468091aded8a38f57de9a580] splice: remove permission hook from do_splice_direct()
> git bisect good 2a33e2ddc6ebf9b5468091aded8a38f57de9a580
> # good: [9b7e9e2f5d5c3d079ec46bc71b114012e362ea6e] fs: factor out backing_file_splice_{read,write}() helpers
> git bisect good 9b7e9e2f5d5c3d079ec46bc71b114012e362ea6e
> # good: [12c1b632d970c0138b4c5c65a1065e7d0604d272] fs: reformat idmapped mounts entry
> git bisect good 12c1b632d970c0138b4c5c65a1065e7d0604d272
> # good: [d23627a7688fabff0096a7beaff1a93de76afaad] EDAC/igen6: Add Intel Raptor Lake-P SoCs support
> git bisect good d23627a7688fabff0096a7beaff1a93de76afaad
> # skip: [ab5f3fcb7c72094684760e0cd8954d8d570b5e83] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect skip ab5f3fcb7c72094684760e0cd8954d8d570b5e83
> # good: [eb183b2cd0a6549992eca3c4ada0b1bc1d9340f5] Revert "perf/arm_dmc620: Remove duplicate format attribute #defines"
> git bisect good eb183b2cd0a6549992eca3c4ada0b1bc1d9340f5
> # good: [1ab33c03145d0f6c345823fc2da935d9a1a9e9fc] asm-generic: make sparse happy with odd-sized put_unaligned_*()
> git bisect good 1ab33c03145d0f6c345823fc2da935d9a1a9e9fc
> # good: [794c68b20408bb6899f90314e36e256924cc85a1] x86/CPU/AMD: Get rid of amd_erratum_1485[]
> git bisect good 794c68b20408bb6899f90314e36e256924cc85a1
> # bad: [11137d384996bb05cf33c8163db271e1bac3f4bf] sched/fair: Simplify util_est
> git bisect bad 11137d384996bb05cf33c8163db271e1bac3f4bf
> # good: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d] sched/cpufreq: Rework schedutil governor performance estimation
> git bisect good 9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d
> # good: [599457ba15403037b489fe536266a3d5f9efaed7] cpufreq: Use the fixed and coherent frequency for scaling capacity
> git bisect good 599457ba15403037b489fe536266a3d5f9efaed7
> # bad: [50b813b147e9eb6546a1fc49d4e703e6d23691f2] cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()
> git bisect bad 50b813b147e9eb6546a1fc49d4e703e6d23691f2
> # bad: [15cbbd1d317e07b4e5c6aca5d4c5579539a82784] energy_model: Use a fixed reference frequency
> git bisect bad 15cbbd1d317e07b4e5c6aca5d4c5579539a82784
> # bad: [b3edde44e5d4504c23a176819865cd603fd16d6c] cpufreq/schedutil: Use a fixed reference frequency
> git bisect bad b3edde44e5d4504c23a176819865cd603fd16d6c
> # first bad commit: [b3edde44e5d4504c23a176819865cd603fd16d6c] cpufreq/schedutil: Use a fixed reference frequency

