Return-Path: <linux-kernel+bounces-8564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80881B973
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D151F22295
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C286D6F2;
	Thu, 21 Dec 2023 14:20:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049676D6D7;
	Thu, 21 Dec 2023 14:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE203C433C8;
	Thu, 21 Dec 2023 14:20:46 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:21:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing / synthetic: Disable events after testing in
 synth_event_gen_test_init()
Message-ID: <20231221092149.74ef39e9@gandalf.local.home>
In-Reply-To: <e2655687-38ba-4e5b-9573-32eb12fb0583@amazon.com>
References: <20231220111525.2f0f49b0@gandalf.local.home>
	<e2655687-38ba-4e5b-9573-32eb12fb0583@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 11:06:38 +0100
Alexander Graf <graf@amazon.com> wrote:

> Thanks a bunch for the super quick turnaround time for the fix! I can=20
> confirm that I'm no longer seeing the warning :)
>=20
> Tested-by: Alexander Graf <graf@amazon.com>

Thanks Alex,

>=20
>=20
> Do we need another similar patch for the kprobe self tests? The below is=
=20
> with 55cb5f43689d7 plus an unrelated initrd patch plus this patch and=20
> the following .config: http://csgraf.de/tmp2/config-ftrace.xz

Sure, now you tell me ;-)

I just finished all my tests and will be sending Linus a pull request soon.

I'll let Masami handle this one, as it's under his department.

-- Steve

>=20
> [=C2=A0 919.717134] Testing all events: OK
> [=C2=A0 924.418194] Testing ftrace filter: OK
> [=C2=A0 924.418887] trace_kprobe: Testing kprobe tracing:
> [=C2=A0 924.424244] ------------[ cut here ]------------
> [=C2=A0 924.424952] WARNING: CPU: 2 PID: 1 at=20
> kernel/trace/trace_kprobe.c:2073 kprobe_trace_self_tests_init+0x192/0x540
> [=C2=A0 924.425659] Modules linked in:
> [=C2=A0 924.425886] CPU: 2 PID: 1 Comm: swapper/0 Not tainted=20
> 6.7.0-rc6-00024-gc10698ad3c9a #298
> [=C2=A0 924.426448] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), B=
IOS=20
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [=C2=A0 924.427230] RIP: 0010:kprobe_trace_self_tests_init+0x192/0x540
> [=C2=A0 924.427639] Code: 7e 10 74 3b 48 8b 36 48 39 d6 75 f2 0f 0b 48 c7=
 c7=20
> 58 71 79 a5 e8 ee 3e 5a fe 48 c7 c7 20 38 b7 a5 e8 a2 51 68 fe 85 c0 74=20
> 33 <0f> 0b 48 c7 c7 38 73 79 a5 e8 d0 3e 5a fe e8 4b 64 62 fe eb 23 48
> [=C2=A0 924.428922] RSP: 0000:ffffab508001be58 EFLAGS: 00010286
> [=C2=A0 924.429288] RAX: 00000000fffffff0 RBX: 000000000000005a RCX:=20
> 0000000000000202
> [=C2=A0 924.429800] RDX: 0000000000000000 RSI: 000000000002e970 RDI:=20
> ffffffffa5b708a0
> [=C2=A0 924.430295] RBP: 0000000000000000 R08: 0000000000000001 R09:=20
> ffffffffa4855a90
> [=C2=A0 924.430794] R10: 0000000000000007 R11: 000000000000028a R12:=20
> 0000000000000001
> [=C2=A0 924.431286] R13: ffffffffa5cc9a00 R14: ffff8cec81bebe00 R15:=20
> ffffffffa619f0f0
> [=C2=A0 924.431785] FS:=C2=A0 0000000000000000(0000) GS:ffff8cecf9100000(=
0000)=20
> knlGS:0000000000000000
> [=C2=A0 924.432346] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [=C2=A0 924.432748] CR2: 0000000000000000 CR3: 000000004883e001 CR4:=20
> 00000000003706f0
> [=C2=A0 924.433246] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=20
> 0000000000000000
> [=C2=A0 924.433739] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=20
> 0000000000000400
> [=C2=A0 924.434233] Call Trace:
> [=C2=A0 924.434418]=C2=A0 <TASK>
> [=C2=A0 924.434569]=C2=A0 ? __warn+0x7d/0x140
> [=C2=A0 924.434807]=C2=A0 ? kprobe_trace_self_tests_init+0x192/0x540
> [=C2=A0 924.435172]=C2=A0 ? report_bug+0xf8/0x1e0
> [=C2=A0 924.435430]=C2=A0 ? handle_bug+0x3f/0x70
> [=C2=A0 924.435677]=C2=A0 ? exc_invalid_op+0x13/0x60
> [=C2=A0 924.435954]=C2=A0 ? asm_exc_invalid_op+0x16/0x20
> [=C2=A0 924.436249]=C2=A0 ? rdinit_setup+0x40/0x40
> [=C2=A0 924.436509]=C2=A0 ? trace_kprobe_release+0x70/0xb0
> [=C2=A0 924.436822]=C2=A0 ? kprobe_trace_self_tests_init+0x192/0x540
> [=C2=A0 924.437189]=C2=A0 ? kprobe_trace_self_tests_init+0x421/0x540
> [=C2=A0 924.437551]=C2=A0 ? init_kprobe_trace+0x1b0/0x1b0
> [=C2=A0 924.437855]=C2=A0 do_one_initcall+0x44/0x200
> [=C2=A0 924.438131]=C2=A0 kernel_init_freeable+0x1e8/0x330
> [=C2=A0 924.438439]=C2=A0 ? rest_init+0xd0/0xd0
> [=C2=A0 924.438682]=C2=A0 kernel_init+0x16/0x130
> [=C2=A0 924.438943]=C2=A0 ret_from_fork+0x30/0x50
> [=C2=A0 924.439202]=C2=A0 ? rest_init+0xd0/0xd0
> [=C2=A0 924.439445]=C2=A0 ret_from_fork_asm+0x11/0x20
> [=C2=A0 924.439734]=C2=A0 </TASK>
> [=C2=A0 924.439893] ---[ end trace 0000000000000000 ]---
> [=C2=A0 924.440217] trace_kprobe: error on cleaning up probes.
> [=C2=A0 924.440575] NG: Some tests are failed. Please check them.


