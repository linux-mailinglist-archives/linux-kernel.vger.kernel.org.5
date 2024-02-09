Return-Path: <linux-kernel+bounces-59866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C041884FCBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FA31C24150
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599283CC4;
	Fri,  9 Feb 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYfBzN/N"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FC83CAF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506480; cv=none; b=MnhxK/AuR4CisCV9K7enm9wqvRHxxWFU+q7nO0QAu+tEUc7W+Kq8LY8ujwIKzPuDPfmChQ5KQ1yEAqWTf5LmnKGuhyl0F7BTc9gXVfSy1w7j4F4nGD7Bib+z0TTooYhfZMSFFgWHNsLmyzW7pXve3ZqcwZNOEJhJlJAwKgKfqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506480; c=relaxed/simple;
	bh=E6a9ixcZrxGRvss5/Txm/O8evpszDprhqAu8iB6sktA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRaSCVpWEgHjXHsXa6voIPRJrbRXX28PuifsnSSgKossdk+aogh2XH3MRW+XSbZ/P7czvgZ8rH+nrVGP4WHtxlW+hJk29HETwcVifV0ZcKgIV4jclFJmWJ/bsfbUCOkG8yqyFWSR3pYNZgcNx78Rgt6GKJK9ZJKPdfpDcIE0fPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYfBzN/N; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so31422a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707506477; x=1708111277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJg4bfYXPwPiy0JMSmR/4Rr2jZhjgTgFupJ/GtQoC/8=;
        b=EYfBzN/NC7TWEZRkGl7MDzJIx0/Y8cUK+wqnjQLysn1kxeKCUeJcwpzi5CjwowO0JM
         q4t5+WBAX4VRrikLMKl/Iy7s/kWG1yqT0sCFAgQRdUK2u6F5HY14QZKyP/EYdUe1sM/w
         /L0j5Sex5isTDGUmUFoem3whztlc7l+k2kkKxUz5Pq/gL1TbwY6v5945BWgWdZ5C8ORP
         Oc2DuX5XQoVZ9mALC5ShPsQiAUMlfoK8Eq2L+vJn0qUYPhuPEM3w2rq1SwRpwRy72E+R
         cAylqIJfkNjgMSatx/g2cBIBwKzI7Fee7b3UAPi+sya0Ctss1IPslN11x4TfVo1rxiyc
         2cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506477; x=1708111277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJg4bfYXPwPiy0JMSmR/4Rr2jZhjgTgFupJ/GtQoC/8=;
        b=dN4n/gQdle8dj4YTfwV5lihMN0eqije9B9OdGr4gYL43tZ26b78zNQTPBtRTyHhULz
         ms16LnRPV3aYRDiBDTJhefbl38P403Qct2edmCAUvl20AGTT5d5AGcTQ9ftuOfHXGdG5
         x1GEUzmMqr6zk4Ge6MZtIAg7NxwFxu+5x2wqUGlCmBO5bf/R0+nq9pVwFVnwSBpofF9k
         JeBnV0HgHVTEKbJ03FrY846kZhioElt/U30+SCTRWWTneGMbRvxIcUWBIE0ViR10rOhA
         /OEhAyH8IbPGcH6pVF/19gpH5zuIXe3vpb7daLrK/yA6Er0zKFVLipUnO9Td6Fw9AlIl
         ZSww==
X-Gm-Message-State: AOJu0YzsQSyeL0Emvcu5Wzh+MbDVbo8vB/1yr97nqQ1V+NCxjeSazF1+
	GpsWM4FyAiW2dZ7bVQFGBl80ym9HTdOi/Rz/JkFjlolWxWCElBheXqy/vB2pHuP/syX2N0Q/ClU
	QBkrl9Dh3OteWG5C+SAO8wznqICLzW+8IK7mI
X-Google-Smtp-Source: AGHT+IG2kLziXtT/fk8qRx78CTjdcYczJaScUJk2tdb/AFoc/wMV/qamdUzmXKVQr5Y1iRQN8ZDUfXbgw3AE34wXsro=
X-Received: by 2002:a50:bb0d:0:b0:560:f37e:2d5d with SMTP id
 y13-20020a50bb0d000000b00560f37e2d5dmr212187ede.5.1707506476110; Fri, 09 Feb
 2024 11:21:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
 <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru> <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
 <d602ebc3-f0e7-171c-7d76-e2f9bb4c2db6@basealt.ru>
In-Reply-To: <d602ebc3-f0e7-171c-7d76-e2f9bb4c2db6@basealt.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 9 Feb 2024 20:21:02 +0100
Message-ID: <CANn89iJ4hVyRHiZXWTiW9ftyN8PFDaWiZnzE7GVAzu1dT78Daw@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 7:16=E2=80=AFPM <kovalev@altlinux.org> wrote:
>
> Hi,
>
> 24.01.2024 14:52, Eric Dumazet wrote:
> > On Wed, Jan 24, 2024 at 12:20=E2=80=AFPM <kovalev@altlinux.org> wrote:
> >> 24.01.2024 13:57, Eric Dumazet wrote:
> >>> Oh wait, this is a 5.10 kernel ?
> >> Yes, but the bug is reproduced on the latest stable kernels.
> >>> Please generate a stack trace using a recent tree, it is possible the
> >>> bug has been fixed already.
> >> See [PATCH 0/1] above, there's a stack for the 6.6.13 kernel at the
> >> bottom of the message.
> > Ah, ok. Not sure why you sent a cover letter for a single patch...
> >
> > Setting a boolean, in a module that can disappear will not prevent the
> > module from disappearing.
> >
> > This work around might work, or might not work, depending on timing,
> > preemptions, ....
> >
> > Thanks.
>
> I tested running the reproducer [1] on the 6.8-rc3 kernel, the crash
> occurs in less than 10 seconds and the qemu VM restarts:
>
> dmesg -w:
>
> [  106.941736] gtp: GTP module unloaded
> [  106.962548] gtp: GTP module loaded (pdp ctx size 104 bytes)
> [  107.014691] gtp: GTP module unloaded
> [  107.041554] gtp: GTP module loaded (pdp ctx size 104 bytes)
> [  107.082283] gtp: GTP module unloaded
> [  107.123268] general protection fault, probably for non-canonical
> address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [  107.124050] KASAN: null-ptr-deref in range
> [0x0000000000000010-0x0000000000000017]
> [  107.124339] CPU: 1 PID: 5826 Comm: gtp Not tainted
> 6.8.0-rc3-std-def-alt1 #1
> [  107.124604] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.0-alt1 04/01/2014
> [  107.124916] RIP: 0010:gtp_genl_dump_pdp+0x1be/0x800 [gtp]
> [  107.125141] Code: c6 89 c6 e8 64 e9 86 df 58 45 85 f6 0f 85 4e 04 00
> 00 e8 c5 ee 86 df 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea
> 03 <80> 3c 02 00 0f 85 de 05 00 00 48 8b 44 24 18 4c 8b 30 4c 39 f0 74
> [  107.125960] RSP: 0018:ffff888014107220 EFLAGS: 00010202
> [  107.126164] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  107.126434] RDX: 0000000000000002 RSI: 0000000000000000 RDI:
> 0000000000000000
> [  107.126707] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> [  107.126976] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [  107.127245] R13: ffff88800fcda588 R14: 0000000000000001 R15:
> 0000000000000000
> [  107.127515] FS:  00007f1be4eb05c0(0000) GS:ffff88806ce80000(0000)
> knlGS:0000000000000000
> [  107.127955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  107.128177] CR2: 00007f1be4e766cf CR3: 000000000c33e000 CR4:
> 0000000000750ef0
> [  107.128450] PKRU: 55555554
> [  107.128577] Call Trace:
> [  107.128699]  <TASK>
> [  107.128790]  ? show_regs+0x90/0xa0
> [  107.128935]  ? die_addr+0x50/0xd0
> [  107.129075]  ? exc_general_protection+0x148/0x220
> [  107.129267]  ? asm_exc_general_protection+0x22/0x30
> [  107.129469]  ? gtp_genl_dump_pdp+0x1be/0x800 [gtp]
> [  107.129677]  ? __alloc_skb+0x1dd/0x350
> [  107.129831]  ? __pfx___alloc_skb+0x10/0x10
> [  107.129999]  genl_dumpit+0x11d/0x230
> [  107.130150]  netlink_dump+0x5b9/0xce0
> [  107.130301]  ? lockdep_hardirqs_on_prepare+0x253/0x430
> [  107.130503]  ? __pfx_netlink_dump+0x10/0x10
> [  107.130686]  ? kasan_save_track+0x10/0x40
> [  107.130849]  ? __kasan_kmalloc+0x9b/0xa0
> [  107.131009]  ? genl_start+0x675/0x970
> [  107.131162]  __netlink_dump_start+0x6fc/0x9f0
> [  107.131341]  genl_family_rcv_msg_dumpit+0x1bb/0x2d0
> [  107.131538]  ? __pfx_genl_family_rcv_msg_dumpit+0x10/0x10
> [  107.131754]  ? genl_op_from_small+0x2a/0x440
> [  107.131972]  ? cap_capable+0x1d0/0x240
> [  107.132127]  ? __pfx_genl_start+0x10/0x10
> [  107.132292]  ? __pfx_genl_dumpit+0x10/0x10
> [  107.132461]  ? __pfx_genl_done+0x10/0x10
> [  107.132645]  ? security_capable+0x9d/0xe0
>
> With the proposed patch applied, such a crash is not observed during
> long-term testing.

Maybe, but the patch is not good, I think I and Pablo gave feedback on this=
 ?

Please trace __netlink_dump_start() content of control->module

gtp_genl_family.module should be set, and we should get it.

Otherwise, if the bug is in the core, we would need a dozen of 'work
arounds because it is better than nothing'

Thank you.

