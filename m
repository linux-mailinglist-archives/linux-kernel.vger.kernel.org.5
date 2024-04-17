Return-Path: <linux-kernel+bounces-148046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8CE8A7D06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CA91C20FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7306A8D0;
	Wed, 17 Apr 2024 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyjiaxXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD986A339
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338777; cv=none; b=UIcTDEbxIX9eEUaDWW1z705DuA4rve8TI2k8xjlgcMhuQv7Veb5bUt0jw5J06x6rI08qDmQbugpsVptw9RciYjelVdh3EGzvH8tIBM5JCSmDJk8cqLPGSa2PC6+khql1gGYG6bdgmvxw8FPfmP/nfnDyq5suUxzvIuGYHOqhhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338777; c=relaxed/simple;
	bh=NRb6yN6BiffLT8J6ikAQwA7PmQ1nwOOaImZKibq+JPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UekuNP/nWYnRei4SQwg7bXM+K3mg7SCLmAdZkyndhPuI1ypP6bzpdLaEfxJIPlNppKdneu74i7BgVEJtMYurbIIypNPKSdJL6OIODEGaeyyU3h91s++GUIFrSWRzpswnKKfGA3lHe/yptTTk18QWTP068H6praSwWAPyYD/SxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyjiaxXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC43C072AA;
	Wed, 17 Apr 2024 07:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713338776;
	bh=NRb6yN6BiffLT8J6ikAQwA7PmQ1nwOOaImZKibq+JPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oyjiaxXxi5PF3OhNR21u6QRUxmfn5vjVAVgkcfxbd+VINZDJc8tqAuABrtKNHrJEQ
	 7LnOMAkoy+IHfKiXWOh0zonVbEZ1XBJKw3bf4Z/dKU1sk2gXjgVLlL8sJ3p/MZ/drC
	 uEWjISNBLhdxY9We6mOvruIRJoRGyopeGStmcKQBZXY+rZ5WJSl2FZPp2vJSvv4Lvj
	 3tqE9XGsw94wJBZvvt57iu5AJsw1Paz64So+RHVjBMTAJIASWZxzeQ87jLgyAV02MZ
	 U3g3pz1h9+IDpgASKP32CagUHqQesmbsXtdxbHerJuVJw27ctS4leqv6+KaenBDEtg
	 BC4g5MCxI9SsA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: takakura@valinux.co.jp, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, apatel@ventanamicro.com, bmeng.cn@gmail.com,
 atishp@rivosinc.com, daniel.thompson@linaro.org, arnd@arndb.de,
 sfr@canb.auug.org.au, akpm@linux-foundation.org,
 conor.dooley@microchip.com, samuel.holland@sifive.com
Cc: taka@valinux.co.jp, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ryo Takakura <takakura@valinux.co.jp>
Subject: Re: [PATCH] RISC-V: Enable IPI CPU Backtrace
In-Reply-To: <20240417050711.41930-1-takakura@valinux.co.jp>
References: <20240417050711.41930-1-takakura@valinux.co.jp>
Date: Wed, 17 Apr 2024 09:26:13 +0200
Message-ID: <87bk68fo16.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

takakura@valinux.co.jp writes:

> From: Ryo Takakura <takakura@valinux.co.jp>
>
> Add CPU backtrace feature using IPI on riscv.
> Currently, riscv doesn't yet support the feature while other
> architectures do. As IPI multiplexing allows to handle=20
> multiple IPIs, I think this feature can also be enabled=20
> on riscv by adding IPI.
>
> This patch defines arch_trigger_all_cpu_backtrace() which triggers
> the IPI for CPU backtrace.
> It will be triggered in the events of oops/panic when options
> (oops_all_cpu_backtrace/panic_print) are set accordingly.
>
> Below is the case of oops with the oops_all_cpu_backtrace=20
> enabled.
>
> $ sysctl kernel.oops_all_cpu_backtrace=3D1
>
> triggering oops shows:
> [  435.716754] NMI backtrace for cpu 3
> [  435.716893] CPU: 3 PID: 621 Comm: in:imklog Tainted: G           OE   =
   6.9.0-rc4 #1
> [  435.717086] Hardware name: riscv-virtio,qemu (DT)
> [  435.717182] epc : fallback_scalar_usercopy+0x8/0xdc
> [  435.717300]  ra : _copy_to_user+0x32/0x58
> [  435.717391] epc : ffffffff80c33d88 ra : ffffffff80598e3c sp : ff200000=
00e83b50
> [  435.717544]  gp : ffffffff82066bf0 tp : ff60000091fd7000 t0 : 33633038=
66660000
> [  435.717711]  t1 : 000000000000005b t2 : 3363303866666666 s0 : ff200000=
00e83b60
> [  435.717874]  s1 : 00000000000001af a0 : 00007ff74d3df74f a1 : ff600000=
82cdc800
> [  435.718040]  a2 : 000000000000003c a3 : 0000000000000000 a4 : 00000000=
00000000
> [  435.718196]  a5 : 00ffffffffffffc4 a6 : 0000000000000000 a7 : 00000000=
00000010
> [  435.718333]  s2 : ff60000082cdc800 s3 : ffffffff82066910 s4 : 00000000=
00001df1
> [  435.718475]  s5 : ffffffff8206a5b8 s6 : 00007ff74d3df74f s7 : ffffffff=
8206a5b0
> [  435.718616]  s8 : ff60000082cdc800 s9 : ffffffff81e26208 s10: 00000000=
0000003c
> [  435.718760]  s11: ffffffff8206a5ad t3 : ff60000082cdc812 t4 : ff600000=
82cdc812
> [  435.718909]  t5 : ff60000082cdc818 t6 : 0000000000040000
> [  435.719019] status: 0000000000040120 badaddr: 0000000000000000 cause: =
8000000000000001
> [  435.719191] [<ffffffff80c33d88>] fallback_scalar_usercopy+0x8/0xdc
> [  435.719330] [<ffffffff80094eee>] syslog_print+0x1f4/0x2b2
> [  435.719446] [<ffffffff80095e10>] do_syslog.part.0+0xb0/0x326
> [  435.719594] [<ffffffff8009692e>] do_syslog+0x66/0x88
> [  435.719816] [<ffffffff803a1a80>] kmsg_read+0x44/0x5c
> [  435.720017] [<ffffffff8038ea92>] proc_reg_read+0x7a/0xa8
> [  435.720251] [<ffffffff802fae20>] vfs_read+0x94/0x264
> [  435.720478] [<ffffffff802fb906>] ksys_read+0x64/0xe4
> [  435.720709] [<ffffffff802fb9a6>] __riscv_sys_read+0x20/0x2c
> [  435.720880] [<ffffffff80c43ea2>] do_trap_ecall_u+0x60/0x1d4
> [  435.721236] [<ffffffff80c4f74c>] ret_from_exception+0x0/0x64
>
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

