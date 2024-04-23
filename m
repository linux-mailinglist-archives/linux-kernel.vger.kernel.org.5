Return-Path: <linux-kernel+bounces-155918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E668AF8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BA28F381
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ABA143C48;
	Tue, 23 Apr 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdPKYIgJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAD143861;
	Tue, 23 Apr 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907242; cv=none; b=CKj8eBbxwwVMsikZU+tcrP5UioqW4fsSubLjFBfYcdEX8+8ySNPiLoiFWSLz9e0+9sbX43vK0kaNv9hILHPtjNGjTZq9oPIpHJ4s+qrKelMhF+1+jaZVZaJS97CfpoAP8uKtNjLRfjyRLAz/yB6badTewOe1ZM2L8AnCUXirspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907242; c=relaxed/simple;
	bh=97ZTIW7xF1irMdbgCbC0Wpk0brqcDpP2/ByuB8zk5CM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U0N3MM39T9uMPbuYva/gk3XHoOw+uQzSTB9YdCK41tgHrv2ykgZxDddgym8dlocFDHe98AbId/o9hAsHyGtOo1b2Qen/fi1lNtRc+bJFrS/URKeS3go9lCjuvRB1yAqL8CSswvuO6WErRFg7EN2YS+hglcX7dU9QHHhVbf2zeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdPKYIgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE77C3277B;
	Tue, 23 Apr 2024 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713907242;
	bh=97ZTIW7xF1irMdbgCbC0Wpk0brqcDpP2/ByuB8zk5CM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gdPKYIgJ5vbsp9f+vqX1msqBs4s9IAqWW1ZddKHuCcyIlOUqxZSSDMZ0E1x/5WRxl
	 YMeCnqC14ErS1CvL7XZyV7GGyJTSRiVi9wW+C8euJw8cn7HPZPZZK+RtuJTB5gypeu
	 tzBYR/HFJ5Lf/eczttipl2gdAWXyygRhb/dmBavqVCI2oPfKWqqxn4/sDfPoEmT4jL
	 lKOUq7VbRiVsp5ZE/IeLHcBSMjI09LYhPIykOrzhiEg4EP860PkWndZXvU0kCuWR5o
	 FoyntU/VEeBGmO2/QRntJoDYx32wITt5TfVCkt9wVrf190HqGzdd7tWyEthpG7TUUG
	 IvoOgx6frbc1Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 00:20:38 +0300
Message-Id: <D0RTERZQPM45.27KIQKUSFWXRS@kernel.org>
Cc: <reinette.chatre@intel.com>, =?utf-8?b?5YiY5Y+MKOi9qeWxuSk=?=
 <ls123674@antgroup.com>
Subject: Re: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's
 ioctl() to avoid softlockup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 =?utf-8?b?5pyx5Lyv5ZCbKOadsOmTrSk=?= <zhubojun.zbj@antgroup.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
 <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
 <D0RT6W3IGBRL.34KQMBWUO1Z23@kernel.org>
In-Reply-To: <D0RT6W3IGBRL.34KQMBWUO1Z23@kernel.org>

On Wed Apr 24, 2024 at 12:10 AM EEST, Jarkko Sakkinen wrote:
> On Tue Apr 23, 2024 at 12:25 PM EEST, =3D?UTF-8?B?5pyx5Lyv5ZCbKOadsOmTrSk=
=3D?=3D wrote:
> > EDMM's ioctl()s support batch operations, which may be
> > time-consuming. Try to explicitly give up the CPU at
> > the every end of "for loop" in
> > sgx_enclave_{ modify_types | restrict_permissions | remove_pages}
> > to give other tasks a chance to run, and avoid softlockup warning.
> >
> > The following has been observed on Linux v6.9-rc5 with kernel
> > preemptions disabled(by configuring "PREEMPT_NONE=3Dy"), when kernel
> > is requested to restrict page permissions of a large number of EPC page=
s.
> >
> >     ------------[ cut here ]------------
> >     watchdog: BUG: soft lockup - CPU#45 stuck for 22s! [occlum-run:3905=
]
> >     ...
> >     CPU: 45 PID: 3905 Comm: occlum-run Not tainted 6.9.0-rc5 #7
> >     ...
> >     RIP: 0010:sgx_enclave_restrict_permissions+0xba/0x1f0
> >     Code: 48 c1 e6 05 48 89 d1 48 8d 5c 24 40 b8 0e 00 00 00 48 2b 8e 7=
0 8e f5 93 48 c1 e9 05 48 c1 e1 0c 48 03 8e 68 8e f5 93 0f 01 cf <a9> 00 00=
 00 40 0f 85 b2 00 00 00 85 c0 0f 85 db 00 00 00 4c 89 ef
> >     RSP: 0018:ffffb55a6591fa80 EFLAGS: 00000202
> >     RAX: 0000000000000000 RBX: ffffb55a6591fac0 RCX: ffffb581e7384000
> >     RDX: ffffb59a9e4e8080 RSI: 0000000000000020 RDI: ffff91d69e8cc000
> >     RBP: ffffb55a6591fb70 R08: 0000000000000002 R09: ffff91d646e12be0
> >     R10: 000000000000006e R11: 0000000000000002 R12: 000000072052d000
> >     R13: ffff91d69e8cc000 R14: ffffb55a6591fbd8 R15: ffff91d69e8cc020
> >     FS:  00007fe10dbda740(0000) GS:ffff92163e480000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 00007fc041811000 CR3: 00000040d95c8005 CR4: 0000000000770ef0
> >     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >     DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> >     PKRU: 55555554
> >     Call Trace:
> >      <IRQ>
> >      ? show_regs+0x67/0x70
> >      ? watchdog_timer_fn+0x1f3/0x280
> >      ? __pfx_watchdog_timer_fn+0x10/0x10
> >      ? __hrtimer_run_queues+0xc8/0x220
> >      ? hrtimer_interrupt+0x10c/0x250
> >      ? __sysvec_apic_timer_interrupt+0x53/0x130
> >      ? sysvec_apic_timer_interrupt+0x7b/0x90
> >      </IRQ>
> >      <TASK>
> >      ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> >      ? sgx_enclave_restrict_permissions+0xba/0x1f0
> >      ? __pte_offset_map_lock+0x94/0x110
> >      ? sgx_encl_test_and_clear_young_cb+0x40/0x60
> >      sgx_ioctl+0x1ab/0x900
> >      ? do_syscall_64+0x79/0x110
> >      ? apply_to_page_range+0x14/0x20
> >      ? sgx_encl_test_and_clear_young+0x6c/0x80
> >      ? sgx_vma_fault+0x132/0x4f0
> >      __x64_sys_ioctl+0x95/0xd0
> >      x64_sys_call+0x1209/0x20c0
> >      do_syscall_64+0x6d/0x110
> >      ? do_syscall_64+0x79/0x110
> >      ? do_pte_missing+0x2e8/0xcc0
> >      ? __pte_offset_map+0x1c/0x190
> >      ? __handle_mm_fault+0x7b9/0xe60
> >      ? __count_memcg_events+0x70/0x100
> >      ? handle_mm_fault+0x256/0x360
> >      ? do_user_addr_fault+0x3c1/0x860
> >      ? irqentry_exit_to_user_mode+0x67/0x190
> >      ? irqentry_exit+0x3b/0x50
> >      ? exc_page_fault+0x89/0x180
> >      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >     RIP: 0033:0x7fe10e2ee5cb
> >     Code: 0f 1e fa 48 8b 05 c5 78 0d 00 64 c7 00 26 00 00 00 48 c7 c0 f=
f ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 8b 0d 95 78 0d 00 f7 d8 64 89 01 48
> >     RSP: 002b:00007fffb2c75518 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010
> >     RAX: ffffffffffffffda RBX: 0000000780000000 RCX: 00007fe10e2ee5cb
> >     RDX: 00007fffb2c75520 RSI: 00000000c028a405 RDI: 0000000000000005
> >     RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fffb2c75594
> >     R10: 00007fffb2c755c8 R11: 0000000000000246 R12: 00000000c028a405
> >     R13: 00007fffb2c75520 R14: 0000000780000000 R15: 00007fe10e1a7980
> >      </TASK>
> >      ------------[ end trace ]------------
> >
> > Signed-off-by: Bojun Zhu <zhubojun.zbj@antgroup.com>
>
> Can you also fixup this as your "firstname lastname" in your emails
> from field? This matters so that author field in git log matches your
> sob.
>
> > ---
> >  arch/x86/kernel/cpu/sgx/ioctl.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/=
ioctl.c
> > index b65ab214bdf5..2340a82fa796 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -806,6 +806,9 @@ sgx_enclave_restrict_permissions(struct sgx_encl *e=
ncl,
> >  		}
> > =20
> >  		mutex_unlock(&encl->lock);
> > +
> > +		if (need_resched())
> > +			cond_resched();
> >  	}
> > =20
> >  	ret =3D 0;
> > @@ -1010,6 +1013,9 @@ static long sgx_enclave_modify_types(struct sgx_e=
ncl *encl,
> >  		entry->type =3D page_type;
> > =20
> >  		mutex_unlock(&encl->lock);
> > +
> > +		if (need_resched())
> > +			cond_resched();
> >  	}
> > =20
> >  	ret =3D 0;
> > @@ -1156,6 +1162,9 @@ static long sgx_encl_remove_pages(struct sgx_encl=
 *encl,
> >  		kfree(entry);
> > =20
> >  		mutex_unlock(&encl->lock);
> > +
> > +		if (need_resched())
> > +			cond_resched();
> >  	}
> > =20
> >  	ret =3D 0;
>
> Makes sense to me but maybe this should be a prefix op instead of
> postfix op given how things are laid out in sgx_ioc_enclave_add_pages()
>
> https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/cpu/sgx/io=
ctl.c#L443

It would make sense also check pending signals, and since these
add up perhaps a helper would make sense to encapsulate all the
shenanigans:

/*
 * Check signals and invoke scheduler. Return true for a pending signal.
 */
static bool sgx_resched(void)
{
	if (signal_pending(current))
		return true;

	if (need_resched())
		cond_resched();

	return false;
}

BR, Jarkko

