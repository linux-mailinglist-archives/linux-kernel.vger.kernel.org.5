Return-Path: <linux-kernel+bounces-150478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E18A9FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EAF1F23679
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1D16F90E;
	Thu, 18 Apr 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="nevWHjZx"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24079EA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457558; cv=none; b=tdWdSyOoHsrbyXuDOk7d67QBssxh/y8pSDdonlaBEsXI90J/OlMdUk/UdAvajHO21ZCShUKbXE7gl4zDZHsq0L/vg4XseVl180IlY586R0PGiyGrzSFZk6TIJb5kW9YvoJmmV+oggyka7M/Wb9NBtlukoesyYSARmCfRsAGrnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457558; c=relaxed/simple;
	bh=kTuE/mk31JGeVZbk/TStaK3bJMW1tMr1v8vXLPAZxBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjCsSj0XXOsW3VubV332FhmLxoYJQSW1JqwBBM96A0D4CUI9QeUv2u3FL2m8jtJJJunzFxDwJbKqEUlyvehgrLqpHYRJvN0NL0v8dP4KpFtiAInFiVtQfVM0E94jbKetz7gS0cxD08yp4SfJGB/BcbqaX0Dz+GQWyq+RGSzUs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=nevWHjZx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713457504; x=1714062304; i=efault@gmx.de;
	bh=kUFlTLVrphieOIrFU2h3QbuGYD584d/FIygp6hWnM6E=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nevWHjZxI3JzZFxXNJRXyWk9vYNLZX3JiwkDnzxejf1QUEDlJqlRyld/c5aJlJEt
	 8MhG68utM3/JNqE2qYW+pogRxVd4kqL+olEXIWBa8zWM6NmHxHaHZYhP6l+DClEec
	 69ZkY1XrcUrWccXQ2wAMoufEO4or9C3GkuP5b9htaljjYCXaKtKqx8ixP3V4jRdGW
	 oZJVbkWFzMJSUkpdS/ZMZZIwRC6TRLoi0Brcd7RUgHXQr4/cCpS0gigcDnNvi/lQY
	 nj+FOs+yZ4kbj2Dkh3czDhyAPCj8DW87ko8Iv2lGoZUgooGa2h6o8BmgptpEmKj7a
	 OkOPk/z3rL/Uj+hH+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1skpzp30fV-015Zb8; Thu, 18
 Apr 2024 18:25:04 +0200
Message-ID: <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com,  linux-kernel@vger.kernel.org
Cc: wuyun.abel@bytedance.com, tglx@linutronix.de, Chen Yu
 <yu.c.chen@intel.com>,  Oliver Sang <oliver.sang@intel.com>
Date: Thu, 18 Apr 2024 18:24:59 +0200
In-Reply-To: <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.631664251@infradead.org>
	 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
	 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
	 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
	 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ac3lcX51CWOBPPgXiL027V9zQwuPeoYKj8kNXSeqPqikv1D8ONs
 ub9+3TOKr+6By4TZzOM4rUw4IE9ltioJRTm9zbVhcypD/7OjG2Lv7avqx/S9dfFOY8/gykz
 EFqYqBK0mRiTCLIjmb43CNGTe4kieaac5MrkN7ggwAX6eqzyvwR49NDnmhXy4eMtK4S5gJs
 QUEzoOtSO31SL/fhlBzfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p38Fj4GWluY=;yF7PGIu3lEdCRwJUedh/sSD5EP5
 3Hb7FdJWS3MU9Win8neI+ZvtXhXy+pzA2YY4DK2d+NAPl0scCSEmISHRK83QWBdasyLULUfVx
 7QNJ54i/JkdQHsYxFJVgXSSkZ4fDVQAqLGWtW+mzem/mfkDutir4yj5F5uSbnWyr2VfEdl6EK
 3FHW8DkpjH0t79b6FWAX+8HyK3EdvsSVwyQFP3bp+AOZXQsvRmIPDh/fsTO35nBT80VPCAnGx
 laIUN/LqzxUlFa1cFVnmnggas5X4lyIgmbbNTu89slim6tc5lFonNjVYx0bVyBHXGTJIox6Nb
 Njgo+jsEQLePd/0PVn6rYf9HgCI0FD8/LHDTJ1Nc4ZFac5ieKG/oDoFXwpTedLqzjIstfC+zU
 Oecif4YJX0QxRh1ol2kCvaSKrZLvYyuU5gigth7zcT4h96ys+h44k4/6ZzSXdt9so7fSN4tyg
 9cw8vzQCzcnc1p0KPmjwcF1A1tgxIDEZku9UTm2cS5eizUl26h4pekiuci2vSJO7RrSDj6oZ9
 QDv7cQXnyYgapFvTdQidDRmx4jFjBYP1t8IFty+jw5d6aS+vZa8xPoce0jT/DbvFf4uTS0FVW
 9Uekyo6CBezsU9XEnUTAtw7iHUavSZlJsFq+wI/VnbY9J2fahFY5e/I4lCnHVSx9zu9tJigUn
 hR9KxyXij9QDxR3WqCz65SFJOU+OLVMKKGjpWaaorpWeLy0pIz2+mV1WpsB3e7/hU0IHIs/Gq
 VnUSIAv3RCAcx/LHU65oA99SX8f1PC8CriCcp0rlGLCxcLMncxw/iWBnGOblgOcbMTlRBXQ/l
 OlE88K4KNWobow+VBs8CzkRbJo7AdTfyMiFitZv0z9isQ=

Greetings,

I tossed a couple rocks at it today, and seem to have hit the little
bugger.  The root cause seems to be doing the delay dequeue business on
exiting tasks.  Hunk #1 of hacklet below seems to quell the explosions.

crash> bt -sx
PID: 21722    TASK: ffff88815710ee40  CPU: 6    COMMAND: "hackbench"
 #0 [ffff88822773bb90] machine_kexec+0x156 at ffffffff810642d6
 #1 [ffff88822773bbe0] __crash_kexec+0xd7 at ffffffff81152a07
 #2 [ffff88822773bc98] crash_kexec+0x23 at ffffffff81152eb3
 #3 [ffff88822773bca8] oops_end+0xbe at ffffffff810329be
 #4 [ffff88822773bcc8] page_fault_oops+0x81 at ffffffff81071951
 #5 [ffff88822773bd28] exc_page_fault+0x62 at ffffffff8194e9e2
 #6 [ffff88822773bd50] asm_exc_page_fault+0x22 at ffffffff81a00ba2
    [exception RIP: pick_next_task_fair+178]
    RIP: ffffffff810d8d12  RSP: ffff88822773be00  RFLAGS: 00010006
    RAX: ffff88813cb780b8  RBX: ffff88840edb0e80  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: ffff88813cb78080  RDI: ffff88840ec30f00
    RBP: ffff88813cb78000   R8: ffff88815710eec0   R9: 0000000000000001
    R10: ffff88822773bdc8  R11: 0000000000000013  R12: 0000000000030e80
    R13: ffff88815710ee40  R14: ffff88813cb78080  R15: ffff88815710ee40
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff88822773be28] __schedule+0x10d at ffffffff8195865d
 #8 [ffff88822773be98] do_task_dead+0x3e at ffffffff810cc00e
 #9 [ffff88822773beb0] do_exit+0x770 at ffffffff8108f0e0
#10 [ffff88822773bf00] do_group_exit+0x2c at ffffffff8108f64c
#11 [ffff88822773bf28] __x64_sys_exit_group+0x14 at ffffffff8108f6f4
#12 [ffff88822773bf30] do_syscall_64+0x57 at ffffffff8194ac37
#13 [ffff88822773bf50] entry_SYSCALL_64_after_hwframe+0x76 at ffffffff81a0=
012b
    RIP: 00007f4f2aa76136  RSP: 00007ffcbba84748  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f4f2aa76136
    RDX: 0000000000000000  RSI: 000000000000003c  RDI: 0000000000000000
    RBP: 00007f4f2ab86970   R8: 00000000000000e7   R9: ffffffffffffff80
    R10: 0000000000000004  R11: 0000000000000246  R12: 00007f4f2ab86970
    R13: 0000000000000001  R14: 00007f4f2ab8a328  R15: 0000000000000000
    ORIG_RAX: 00000000000000e7  CS: 0033  SS: 002b
crash> task_struct ffff88815710ee40 | grep sched_delayed
    sched_delayed =3D 1 '\001',
crash>

=2D--
 kernel/sched/fair.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5374,6 +5374,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 		update_curr(cfs_rq);

 		if (sched_feat(DELAY_DEQUEUE) && sleep &&
+		    !(entity_is_task(se) && (task_of(se)->flags & PF_EXITING)) &&
 		    !entity_eligible(cfs_rq, se)) {
 			if (cfs_rq->next =3D=3D se)
 				cfs_rq->next =3D NULL;
@@ -5495,14 +5496,14 @@ pick_next_entity(struct rq *rq, struct c
 	}

 	struct sched_entity *se =3D pick_eevdf(cfs_rq);
-	if (se->sched_delayed) {
+	while (se && se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		SCHED_WARN_ON(se->sched_delayed);
 		SCHED_WARN_ON(se->on_rq);
 		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 			se->vlag =3D 0;

-		return NULL;
+		se =3D pick_eevdf(cfs_rq);
 	}
 	return se;
 }


