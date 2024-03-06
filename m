Return-Path: <linux-kernel+bounces-94274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F975873C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5581F29214
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D00137930;
	Wed,  6 Mar 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPPGaky2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275408004B;
	Wed,  6 Mar 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742843; cv=none; b=i00xuSpJN5dPxhgCYNle8CO1Sly1Wr95pQi8cm7EdeTds7uP3azVk3nC6e+XXylBMfQaKiAATgitP68M0+Ykra0uEuY3Skq/0W27HoP8iVvV1mLr36FvjSX/1y2xnH630/hp4d5PxrN9sND3HLGFTfSug4EYXmqhbf835XFJjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742843; c=relaxed/simple;
	bh=lSioC8nIHSt521EN7dyaNqxSNUctylrm/ln7Fi3z/dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoHqT1Lzg36w2UjButJq2OwFW5g7OMsCNc5QnbDE0gGGeD3iCYJzrg5DDrWoC0ltzwQTTHkROnDKuVJ3LtEDWvCKM0HOjEcuEQWptJMvZqEunfD8uBJ272/Dw5sMahuJ0jBxpHLbwUuL6Q6rCHLmktC/MJ9RxVlM0pnvDywY31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPPGaky2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23677C433F1;
	Wed,  6 Mar 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742842;
	bh=lSioC8nIHSt521EN7dyaNqxSNUctylrm/ln7Fi3z/dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jPPGaky2aij64SZE9iNaowJTd1tSwOuXvZNEmkKfdU7JEc0HQqyKDvmASpZYQG438
	 jyc4fkdggmiMALjplZcW5QOPkoVIisLb7idkYi+pittzum5w7VFSsMb/ANlYyDCmM7
	 qy417fLIJiwGZf8Zj0erri78oWnD50GI9gOHjw1VKTJGqcCXkYgTxrk3M1EMhfcFU5
	 8JoysPFsxSgJTqays8IfLr0CSTuqwQz7BDBPbwuIngbTBmvc3KrOziD4Jq7uWjoKVL
	 JrzlqFWLSRIfFa3bxjb8yLSjz9DaJ0eAz4GqOqlPCPoD/D+mYMLKfNMia1TFLsFijB
	 SFS90uX4yZBpg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Sami Tolvanen
 <samitolvanen@google.com>, Peter Zijlstra <peterz@infradead.org>, Kees
 Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 0/1] Support kCFI + BPF on riscv64
In-Reply-To: <20240303170207.82201-1-puranjay12@gmail.com>
References: <20240303170207.82201-1-puranjay12@gmail.com>
Date: Wed, 06 Mar 2024 17:33:59 +0100
Message-ID: <87jzmfb9qg.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
> before each function and a check to validate the target function type
> before indirect calls:
>
>   ; type preamble
>     .word <id>
>   function:
>     ...
>   ; indirect call check
>     lw      t1, -4(a0)
>     lui     t2, <hi20>
>     addiw   t2, t2, <lo12>
>     beq     t1, t2, .Ltmp0
>     ebreak
>   .Ltmp0:
>     jarl    a0
>
> BPF JIT currently doesn't emit this preamble before BPF programs and when
> the calling fuction tries to load the type id from the preamble, it finds
> an invalid value there.
>
> This will cause CFI failures like in the following bpf selftest:
>
> root@rv-selftester:~/bpf# ./test_progs -a "rbtree_success"
>
>  CFI failure at bpf_rbtree_add_impl+0x148/0x350 (target: bpf_prog_fb8b097=
ab47d164a_less+0x0/0x42; expected type: 0x00000000)
>  WARNING: CPU: 1 PID: 278 at bpf_rbtree_add_impl+0x148/0x350
>  Modules linked in: bpf_testmod(OE) drm fuse dm_mod backlight i2c_core co=
nfigfs drm_panel_orientation_quirks ip_tables x_tables
>  CPU: 1 PID: 278 Comm: test_progs Tainted: P           OE      6.8.0-rc1 =
#1
>  Hardware name: riscv-virtio,qemu (DT)
>  epc : bpf_rbtree_add_impl+0x148/0x350
>   ra : bpf_prog_27b36e47d273751e_rbtree_first_and_remove+0x1aa/0x35e
>  epc : ffffffff805acc0c ra : ffffffff780077fa sp : ff2000000110b9d0
>   gp : ffffffff868d6218 tp : ff60000085772a40 t0 : ffffffff86849660
>   t1 : 0000000000000000 t2 : ffffffff9e4709a9 s0 : ff2000000110ba50
>   s1 : ff60000089c14958 a0 : ff60000089c14758 a1 : ff60000089c14958
>   a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
>   a5 : 0000000000000000 a6 : ff6000008aba4b30 a7 : ffffffff86849640
>   s2 : ff6000008aba4b30 s3 : ff60000089c14758 s4 : ffffffff780079f0
>   s5 : 0000000000000000 s6 : ffffffff84c01080 s7 : ff6000008aba4b30
>   s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000001
>   s11: 0000000000000000 t3 : ffffffff868499e0 t4 : ffffffff868499c0
>   t5 : ffffffff86849840 t6 : ffffffff86849860
>  status: 0000000200000100 badaddr: 0000000000000000 cause: 00000000000000=
03
>  [<ffffffff805acc0c>] bpf_rbtree_add_impl+0x148/0x350
>  [<ffffffff780077fa>] bpf_prog_27b36e47d273751e_rbtree_first_and_remove+0=
x1aa/0x35e
>  [<ffffffff8294f32c>] bpf_test_run+0x2a4/0xa3c
>  [<ffffffff8294d032>] bpf_prog_test_run_skb+0x47a/0xe52
>  [<ffffffff805083ee>] bpf_prog_test_run+0x170/0x548
>  [<ffffffff805029c8>] __sys_bpf+0x2d2/0x378
>  [<ffffffff804ff570>] __riscv_sys_bpf+0x5c/0x120
>  [<ffffffff8000e8fe>] syscall_handler+0x62/0xe4
>  [<ffffffff83362df6>] do_trap_ecall_u+0xc6/0x27c
>  [<ffffffff833822c4>] ret_from_exception+0x0/0x64
>  ---[ end trace 0000000000000000 ]---
>
> The calling function tries to load the type id hash from target_func - 4.
> If this memory address is not mapped then it can cause a page fault and
> crash the kernel.
>
> This behaviour can be seen by running the 'dummy_st_ops' selftest:
>
> root@rv-selftester:~/bpf# ./test_progs -a dummy_st_ops
>
>  Unable to handle kernel paging request at virtual address ffffffff78204f=
fc
>  Oops [#1]
>  Modules linked in: bpf_testmod(OE) drm fuse backlight i2c_core drm_panel=
_orientation_quirks dm_mod configfs ip_tables x_tables [last unloaded: bpf_=
testmod(OE)]
>  CPU: 3 PID: 356 Comm: test_progs Tainted: P           OE      6.8.0-rc1 =
#1
>  Hardware name: riscv-virtio,qemu (DT)
>  epc : bpf_struct_ops_test_run+0x28c/0x5fc
>   ra : bpf_struct_ops_test_run+0x26c/0x5fc
>  epc : ffffffff82958010 ra : ffffffff82957ff0 sp : ff200000007abc80
>   gp : ffffffff868d6218 tp : ff6000008d87b840 t0 : 000000000000000f
>   t1 : 0000000000000000 t2 : 000000002005793e s0 : ff200000007abcf0
>   s1 : ff6000008a90fee0 a0 : 0000000000000000 a1 : 0000000000000000
>   a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
>   a5 : ffffffff868dba26 a6 : 0000000000000001 a7 : 0000000052464e43
>   s2 : 00007ffffc0a95f0 s3 : ff6000008a90fe80 s4 : ff60000084c24c00
>   s5 : ffffffff78205000 s6 : ff60000088750648 s7 : ff20000000035008
>   s8 : fffffffffffffff4 s9 : ffffffff86200610 s10: 0000000000000000
>   s11: 0000000000000000 t3 : ffffffff8483dc30 t4 : ffffffff8483dc10
>   t5 : ffffffff8483dbf0 t6 : ffffffff8483dbd0
>  status: 0000000200000120 badaddr: ffffffff78204ffc cause: 00000000000000=
0d
>  [<ffffffff82958010>] bpf_struct_ops_test_run+0x28c/0x5fc
>  [<ffffffff805083ee>] bpf_prog_test_run+0x170/0x548
>  [<ffffffff805029c8>] __sys_bpf+0x2d2/0x378
>  [<ffffffff804ff570>] __riscv_sys_bpf+0x5c/0x120
>  [<ffffffff8000e8fe>] syscall_handler+0x62/0xe4
>  [<ffffffff83362df6>] do_trap_ecall_u+0xc6/0x27c
>  [<ffffffff833822c4>] ret_from_exception+0x0/0x64
>  Code: b603 0109 b683 0189 b703 0209 8493 0609 157d 8d65 (a303) ffca
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Fatal exception
>  SMP: stopping secondary CPUs
>
> This patch improves the BPF JIT for the riscv64 architecture to emit kCFI
> type id before BPF programs and struct ops trampolines.
>
> After applying this patch, the above two selftests pass without any issue=
s.
>
>  root@rv-selftester:~/bpf# ./test_progs -a "rbtree_success,dummy_st_ops"
>  #70/1    dummy_st_ops/dummy_st_ops_attach:OK
>  #70/2    dummy_st_ops/dummy_init_ret_value:OK
>  #70/3    dummy_st_ops/dummy_init_ptr_arg:OK
>  #70/4    dummy_st_ops/dummy_multiple_args:OK
>  #70/5    dummy_st_ops/dummy_sleepable:OK
>  #70/6    dummy_st_ops/test_unsupported_field_sleepable:OK
>  #70      dummy_st_ops:OK
>  #189/1   rbtree_success/rbtree_add_nodes:OK
>  #189/2   rbtree_success/rbtree_add_and_remove:OK
>  #189/3   rbtree_success/rbtree_first_and_remove:OK
>  #189/4   rbtree_success/rbtree_api_release_aliasing:OK
>  #189     rbtree_success:OK
>  Summary: 2/10 PASSED, 0 SKIPPED, 0 FAILED
>
>  root@rv-selftester:~/bpf# zcat /proc/config.gz | grep CONFIG_CFI_CLANG
>  CONFIG_CFI_CLANG=3Dy

Apologies for the slow review. Nice work!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

