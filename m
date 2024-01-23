Return-Path: <linux-kernel+bounces-34615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADACE83834D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AF028D958
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05786612EA;
	Tue, 23 Jan 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H52PV/vs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70120DF3;
	Tue, 23 Jan 2024 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974929; cv=none; b=KECcQT2llweYfHnm0rm1jtg/cuToTHNDsoZiUbJe7Z9XXJhQ3xUI+QooTbRTHM1VGtSaA97MOzQBF2PX/QmqE4xhaU/nX02gUd6uzVIlStTQRl8kfDIEu/ykgN0uN1P0EcdADEEDFQyGGuN9yejIS+IJRSrbnCgjEEHZcw1f3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974929; c=relaxed/simple;
	bh=PlMfCQXOLuiUnoNxI1m0m3HX0MZ+Lbok1A9R0kJJkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccu+2Vd5VnbZiFcn5SVIZyQ6XV2tol+1P4SmiVYq9esJuEE6zGN6YUKJobcB7Vt+9OmU/a2EetTq5DJX7/Tyuq9ZLk0mv8GDNXwWSWGUSIFgqne5onX76ypiA94prpGMGwtzevJOhO2sstQHRDIYzlk0oixwoq5lQn8w+R8U4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H52PV/vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29637C433F1;
	Tue, 23 Jan 2024 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705974928;
	bh=PlMfCQXOLuiUnoNxI1m0m3HX0MZ+Lbok1A9R0kJJkU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H52PV/vsOGBLGJju20vxT4kJSE5HpjzukyjNVqZE99c+ElcwL/a6lImQ36/ySzLZ4
	 3ibsX6zzoxiX9283SQcwd4hQJM5jwZUrvsWOYAjxnushnLd5sWMxIbSVerkFf4Xn3C
	 oDXWFA+7P3kIFG7C2Zl3AUEuGv2QiIzbukRv0ML/vCMhG/0TA7d0ybW64wCf55tv5p
	 Brd2JKuz7iy2v86ysWG4lg9DL0DlxPbEtD9807LeBJ+5nn+QkhjkEyU8/zydK9XGPC
	 54QgeNurSdnxO3JytHTUZLiUM/CB8/NkuqS5XlOZCj+c6aMyhFULDUMnUktkrHIgl6
	 anWa0eEGm7h1A==
Date: Tue, 23 Jan 2024 01:55:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	lukasz.luba@arm.com, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	conor.dooley@microchip.com, suagrfillet@gmail.com,
	ajones@ventanamicro.com, lftan@kernel.org, beata.michalska@arm.com,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v7 3/7] cpufreq/schedutil: Use a fixed reference frequency
Message-ID: <Za8cjQXptttuyb6c@finisterre.sirena.org.uk>
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
 <20231211104855.558096-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rky4jjSVNSd+SvwM"
Content-Disposition: inline
In-Reply-To: <20231211104855.558096-4-vincent.guittot@linaro.org>
X-Cookie: Two heads are more numerous than one.


--rky4jjSVNSd+SvwM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 11:48:51AM +0100, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.

So, this seems very weird but I just finished a bisection of a failure
that showed up during the merge window with the DT kselftests on
meson-gxl-s905x-libretech-cc (Libretech Le Potato) running an arm64
defconfig.  Looking at the commit this seems like a very surprising
false result but I verified that the commit before this one runs fine
and reproduced the failure, the bisect does seem to converge well also
so it appears like there's something going on.  Does this ring any bells
for anyone?

The test is timed out by the kselftest wrapper:

   kselftest: Running tests in dt
   TAP version 13
   1..1
   # timeout set to 45
   # selftests: dt: test_unprobed_devices.sh
   # TAP version 13
   #
   not ok 1 selftests: dt: test_unprobed_devices.sh # TIMEOUT 45 seconds

with no obvious effect on the system, a successful run takes less than
20 seconds so it shouldn't be that the timing is marginal.  I'm guessing
that reading the one of the files under /sys/devices hung.  No other
boards in my lab are affected and I'm not immediately seeing anything
remarkable about this board.  Full log from a bad run at:

    https://lava.sirena.org.uk/scheduler/job/493329

and a good run:

    https://lava.sirena.org.uk/scheduler/job/492453

Bisect log (the skipped commits didn't build):

git bisect start
# status: waiting for both good and bad commits
# bad: [4fbbed7872677b0a28ba8237169968171a61efbd] Merge tag 'timers-core-2024-01-21' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 4fbbed7872677b0a28ba8237169968171a61efbd
# status: waiting for good commit(s), bad commit known
# good: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect good 0dd3ee31125508cd67f7e7172247f05b7fd1753a
# bad: [ba5afb9a84df2e6b26a1b6389b98849cd16ea757] fs: rework listmount() implementation
git bisect bad ba5afb9a84df2e6b26a1b6389b98849cd16ea757
# bad: [de927f6c0b07d9e698416c5b287c521b07694cac] Merge tag 's390-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad de927f6c0b07d9e698416c5b287c521b07694cac
# bad: [35f11a3710cdcbbc5090d14017a6295454e0cc73] Merge tag 'mtd/for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect bad 35f11a3710cdcbbc5090d14017a6295454e0cc73
# bad: [d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9] Merge tag 'slab-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect bad d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9
# skip: [968b80332432172dbbb773e749a43bdc846d1a13] Merge tag 'powerpc-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect skip 968b80332432172dbbb773e749a43bdc846d1a13
# good: [372a34e66fb7f95124fadae9c600b231c35696a7] fs: replace f_rcuhead with f_task_work
git bisect good 372a34e66fb7f95124fadae9c600b231c35696a7
# good: [ae24db43b3b427eb290b58d55179c32f0a7539d1] powerpc/ftrace: Remove nops after the call to ftrace_stub
git bisect good ae24db43b3b427eb290b58d55179c32f0a7539d1
# skip: [3cf1d6a5fbf3f724d12b01635319924239d42c00] Merge tag 'm68k-for-v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect skip 3cf1d6a5fbf3f724d12b01635319924239d42c00
# good: [2a33e2ddc6ebf9b5468091aded8a38f57de9a580] splice: remove permission hook from do_splice_direct()
git bisect good 2a33e2ddc6ebf9b5468091aded8a38f57de9a580
# good: [9b7e9e2f5d5c3d079ec46bc71b114012e362ea6e] fs: factor out backing_file_splice_{read,write}() helpers
git bisect good 9b7e9e2f5d5c3d079ec46bc71b114012e362ea6e
# good: [12c1b632d970c0138b4c5c65a1065e7d0604d272] fs: reformat idmapped mounts entry
git bisect good 12c1b632d970c0138b4c5c65a1065e7d0604d272
# good: [d23627a7688fabff0096a7beaff1a93de76afaad] EDAC/igen6: Add Intel Raptor Lake-P SoCs support
git bisect good d23627a7688fabff0096a7beaff1a93de76afaad
# skip: [ab5f3fcb7c72094684760e0cd8954d8d570b5e83] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect skip ab5f3fcb7c72094684760e0cd8954d8d570b5e83
# good: [eb183b2cd0a6549992eca3c4ada0b1bc1d9340f5] Revert "perf/arm_dmc620: Remove duplicate format attribute #defines"
git bisect good eb183b2cd0a6549992eca3c4ada0b1bc1d9340f5
# good: [1ab33c03145d0f6c345823fc2da935d9a1a9e9fc] asm-generic: make sparse happy with odd-sized put_unaligned_*()
git bisect good 1ab33c03145d0f6c345823fc2da935d9a1a9e9fc
# good: [794c68b20408bb6899f90314e36e256924cc85a1] x86/CPU/AMD: Get rid of amd_erratum_1485[]
git bisect good 794c68b20408bb6899f90314e36e256924cc85a1
# bad: [11137d384996bb05cf33c8163db271e1bac3f4bf] sched/fair: Simplify util_est
git bisect bad 11137d384996bb05cf33c8163db271e1bac3f4bf
# good: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d] sched/cpufreq: Rework schedutil governor performance estimation
git bisect good 9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d
# good: [599457ba15403037b489fe536266a3d5f9efaed7] cpufreq: Use the fixed and coherent frequency for scaling capacity
git bisect good 599457ba15403037b489fe536266a3d5f9efaed7
# bad: [50b813b147e9eb6546a1fc49d4e703e6d23691f2] cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()
git bisect bad 50b813b147e9eb6546a1fc49d4e703e6d23691f2
# bad: [15cbbd1d317e07b4e5c6aca5d4c5579539a82784] energy_model: Use a fixed reference frequency
git bisect bad 15cbbd1d317e07b4e5c6aca5d4c5579539a82784
# bad: [b3edde44e5d4504c23a176819865cd603fd16d6c] cpufreq/schedutil: Use a fixed reference frequency
git bisect bad b3edde44e5d4504c23a176819865cd603fd16d6c
# first bad commit: [b3edde44e5d4504c23a176819865cd603fd16d6c] cpufreq/schedutil: Use a fixed reference frequency

--rky4jjSVNSd+SvwM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvHIwACgkQJNaLcl1U
h9BKeAf+IFKGcFk0BJUojgKhxZlLR+EoeCrr+qKvkf4MJnUJL08q61JYwLMM819p
6VM9aQxyVMZV4odlJ1iquxKsIWhGNsGjZoUN+75nVoNvC33xq3bWyi4hQuwuI5pD
QdMDesukSV+dxpIGQ99rMt5DvYPUx17pGYP12O169bX5CH5KSxY/9Ct/tjgxs6tH
zw+2s7IATJ1b2ShOFKgrhpk30UoaB0kHl/ojFa6+5AoAJtNXcXA2V0ho2I3ochZV
F/NwOGdv0N0keLAuXoatUutq+MUfM8gRSitwO6Vg9VJ1EozUI8LFBeHsO9M98X7K
Ey0zu/yA6e8muzklAjcX3c0cFCMVHw==
=pMbb
-----END PGP SIGNATURE-----

--rky4jjSVNSd+SvwM--

