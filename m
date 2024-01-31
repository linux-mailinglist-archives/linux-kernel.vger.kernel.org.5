Return-Path: <linux-kernel+bounces-47384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2E9844D20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9F41F2A8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805053CF59;
	Wed, 31 Jan 2024 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdyFr3d+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E63A8D5;
	Wed, 31 Jan 2024 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744075; cv=none; b=cQB1iwc0oHe/ThV2D8PqqPKXPWpiRS4QsP2JlcDfkH2ewDhn8b+MU1prmK6AtrlG6kpY4ueeEq3Fx8y4nKMLXX1YAMUrdqm5R7PGKMZMnLtQexb0KQ7WPABKu9tV/InzUf7y+9dTYPFuX42qRN/xCDI2fnfVkhAtcGyxhMbQjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744075; c=relaxed/simple;
	bh=qfht1C6NSBw92JVrsp/o2tHHimy/202Geo/YeJ4z3r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFeD6JmIxNX7sDcyuirBfoiX2bnGu2htRxCvMhw4h7+0PybiZ1ifthkY0yholmxHJgTDK0O2V/OjiCL2mpwy39A86zP1eqlqu5VgBLBHpzVfZ3Nj4n4PxBHtJjdwqxsrlnJ8AODnQ7Arf93LkM/NBOMm3w3dBcjiof9g3LTyQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdyFr3d+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso359634e87.2;
        Wed, 31 Jan 2024 15:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706744071; x=1707348871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxjSro3Runrd4nhOZ0rX84YSrCsjDrDSEl79olWjpJI=;
        b=KdyFr3d+kaiMRI6bM8U2ll04k3mP8OY/9IyX+XDO8eUYmD0awiGdqDldSoYE3Rrf3+
         NTRfhp5ZZu4aQzd976xd8oLcw2l43K8XsWVe2Sur/6zob3umV8X0IolFbl5KXqUrLG6i
         AoqXvgfqMZXvIXX5oDemkZEuJ/XlscZGEX3T/jl/t6uFi6qtS6HnP/drSMtJzrAlny7D
         0A0T+7zH57B/kJ1ejJAe0HLqdoMGaQyRH7fL2vlg1CmgBB1fMb0fnt9H27SGZ/8wxLsJ
         RA6g1+0LZ4FS1Ib6BHgoXSEFtWpJcV6FvyYHbXzbdmnZt6b0B5VODldAIdMvxDkj+pdy
         gK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744071; x=1707348871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxjSro3Runrd4nhOZ0rX84YSrCsjDrDSEl79olWjpJI=;
        b=LGcU8vfFSQ5vdhnATDB/giDch5Y6RuNLHhmoAux7+cfJMC8iSPeAno9wUpmf6rtxYl
         niPPe8VxHq6RQWTtXCGvu1a88TphG5/cvKGY3GPDLrWGZQFwXASj+nO5flvPZTFA6+iB
         /c/SL4Yv9fjLChpVlGBhD4Y9+Qf4oBLpH7xOG6y9vB1S7oE3g01jRyo3k6de2cREJBac
         279vm2HcfPTFGGyTFdM4yLHNPxgKXtkY5J1VtXiQPCB5ZYXpzHIUZEhwePaUfPN1KDo4
         /I0bNCuMOzr6oE8Jz18CDHc/CUt4fqsfbJd1HkJwbHx8py85Q5sHhLnO18DkxszXrsV4
         /EWA==
X-Gm-Message-State: AOJu0YwvUNcagqYcw0BxDYLnFCQBrMwDEdGfH1SHjhfek+VAti6Hmh3V
	xmJtyBqwTjd8E/eiVo4ZnFYYOLZJx4q2Ju4/E+UjUJX0T1V+sR45DShrCzfopw6RgzeP/HLVTyg
	munQz2ksA9Y6Bg5S3dNyABS4w/tg=
X-Google-Smtp-Source: AGHT+IFKaFQTkLSLrUeuA89DDrnX1NNDob7TLm+Odb3MD4aaiIY7kg2LUFkAmCqGjvrfZBHsJ7CtW5yg553/kNEvR/0=
X-Received: by 2002:a05:6512:5cd:b0:510:b5d:ec0b with SMTP id
 o13-20020a05651205cd00b005100b5dec0bmr684679lfo.66.1706744071100; Wed, 31 Jan
 2024 15:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131121401.3898735-1-zhaoyang.huang@unisoc.com>
 <ZbpCo+90OsXJwFWV@x1-carbon> <ZbpGDFUGQoaRQWHq@x1-carbon>
In-Reply-To: <ZbpGDFUGQoaRQWHq@x1-carbon>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 1 Feb 2024 07:34:19 +0800
Message-ID: <CAGWkznGOjsA3eGRt4i-1XAt=39ce7vaN7=zciimLJOMg=HD7Zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: print warning when invalid domain set to ioprio
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"steve.kang@unisoc.com" <steve.kang@unisoc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:07=E2=80=AFPM Niklas Cassel <Niklas.Cassel@wdc.co=
m> wrote:
>
> On Wed, Jan 31, 2024 at 01:52:51PM +0100, Niklas Cassel wrote:
> > On Wed, Jan 31, 2024 at 08:14:01PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Since few caller check IOPRIO_PRIO_VALUE's return value and bio_set_p=
rio
> > > is a open macro to set bio->ioprio directly.It is confused for the de=
veloper
> > > who run across kernel panic[1] but can find nothing in previous kerne=
l log.
> > > Add a pr_err here to dump the information.
> > >
> > > [1]
> > > Here is the kernel panic I run across which caused by a out of bounds=
 check
> > > introduced by CONFIG_FOTIFY_SOURCE.
> > >
> > > [exception_serialno]:
> > > [exception_kernel_version]:
> > > [exception_reboot_reason]: kernel_crash
> > > [exception_panic_reason]: UBSAN: array index out of bounds: Fatal exc=
eption
> > > [exception_time]: 1970-01-01_08-00-23
> > > [exception_file_info]: not-bugon
> > > [exception_task_id]: 409
> > > [exception_task_family]: [f2fs_ckpt-254:4, 409][kthreadd, 2]
> > > [exception_pc_symbol]: [<ffffffc080736974>] dd_request_merge+0x100/0x=
110
> > > [exception_stack_info]: [<ffffffc07a27e274>] get_exception_stack_info=
+0x124/0x2d8 [sysdump]gc
> > > [<ffffffc07a27e670>] prepare_exception_info+0x158/0x1d4 [sysdump]gc
> > > [<ffffffc07a280128>] sysdump_panic_event+0x5d8/0x748 [sysdump]gc
> > > [<ffffffc08016a508>] notifier_call_chain+0x98/0x17cgc
> > > [<ffffffc08016a9b4>] atomic_notifier_call_chain+0x44/0x68gc
> > > [<ffffffc0810f0eb4>] panic+0x194/0x37cgc
> > > [<ffffffc0800a638c>] die+0x300/0x310gc
> > > [<ffffffc0800a77e8>] ubsan_handler+0x34/0x4cgc
> > > [<ffffffc0800960a8>] brk_handler+0x9c/0x11cgc
> > > [<ffffffc0800bf998>] do_debug_exception+0xb0/0x140gc
> > > [<ffffffc0810f8bf0>] el1_dbg+0x58/0x74gc
> > > [<ffffffc0810f89f4>] el1h_64_sync_handler+0x3c/0x90gc
> > > [<ffffffc080091298>] el1h_64_sync+0x68/0x6cgc
> > > [<ffffffc080736974>] dd_request_merge+0x100/0x110gc   //out of bound
> > > here caused by the value of class transferred from ioprio
> > > [<ffffffc080707f28>] elv_merge+0x248/0x270gc
> > > [<ffffffc0807146e8>] blk_mq_sched_try_merge+0x4c/0x20cgc
> > > [<ffffffc080736824>] dd_bio_merge+0x64/0xb4gc
> > > [<ffffffc080723e3c>] blk_mq_sched_bio_merge+0x68/0x144gc
> > > [<ffffffc08071b944>] blk_mq_submit_bio+0x2e8/0x6c0gc
> > > [<ffffffc08070dd3c>] __submit_bio+0xbc/0x1b0gc
> > > [<ffffffc08070c440>] submit_bio_noacct_nocheck+0xe4/0x2f0gc
> > > [<ffffffc08070c8e4>] submit_bio_noacct+0x298/0x3d8gc
> > > [<ffffffc08070caf8>] submit_bio+0xd4/0xf0gc
> > > [<ffffffc080642644>] f2fs_submit_write_bio+0xcc/0x49cgc
> > > [<ffffffc0806442d4>] __submit_merged_bio+0x48/0x13cgc
> > > [<ffffffc080641de4>] __submit_merged_write_cond+0x18c/0x1f8gc
> > > [<ffffffc080641c4c>] f2fs_submit_merged_write+0x2c/0x38
> > > [<ffffffc080655724>] f2fs_sync_node_pages+0x6e0/0x740gc
> > > [<ffffffc08063946c>] f2fs_write_checkpoint+0x4c0/0x97cgc
> > > [<ffffffc08063b37c>] __checkpoint_and_complete_reqs+0x88/0x248gc
> > > [<ffffffc08063ad70>] issue_checkpoint_thread+0x94/0xf4gc
> > > [<ffffffc080167c20>] kthread+0x110/0x1b8gc
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  include/uapi/linux/ioprio.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.=
h
> > > index bee2bdb0eedb..73c420a0df72 100644
> > > --- a/include/uapi/linux/ioprio.h
> > > +++ b/include/uapi/linux/ioprio.h
> > > @@ -112,8 +112,11 @@ static __always_inline __u16 ioprio_value(int pr=
ioclass, int priolevel,
> > >  {
> > >     if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
> > >         IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> > > -       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
> > > +       IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS)) {
> > > +           pr_err("%s: get a invalid domain in class %d, level %d, h=
int %d\n",
> > > +                   __func__, prioclass, priolevel, priohint);
> > >             return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> > > +   }
> > >
> > >     return (prioclass << IOPRIO_CLASS_SHIFT) |
> > >             (priohint << IOPRIO_HINT_SHIFT) | priolevel;
> > > --
> > > 2.25.1
> > >
> >
> > Adding linux-block to CC.
> >
> > pr_err() is a kernel function for printing.
> > ioprio_value() is a function in a uapi header, so this function will be
> > used by user space programs.
> >
> > There is a reason:
> > $ git grep pr_err include/uapi/
> >
> > Gives no results.
> >
> >
> >
> > I think you should fix mq-deadline instead.
> > It looks like the problem comes from:
> > ioprio_value() will set class to IOPRIO_CLASS_INVALID (value 7),
> > if the user specified an class/level/hint that was invalid.
> >
> > ioprio_class_to_prio[] array in mq-deadline.c does currently not have a=
n
> > entry in to translate IOPRIO_CLASS_INVALID (7) to a valid DD_*_PRIO val=
ue.
> >
> > Although, why does this I/O even reach the scheduler, shouldn't this I/=
O
> > get rejected even earlier?
> >
> > Both io_uring and libaio will call ioprio_check_cap(), which should fai=
l
> > the I/O before it reaches the I/O scheduler, but in your case, you are
> > submitting the I/O from the filesystem.
> >
> > Should we perhaps add a call to ioprio_check_cap() or similar in some
> > path used to submit I/O by filesystems?
>
> On second thought, how can the FS have a ioprio class stored that would
> have been rejected at I/O submission time by the user?
>
> This sound like either a bug in the FS or by some of your local changes
> that you did for your other patch (ioprio based on activity).
Yes. That's why I would like to suggest adding some information here
to help developers find the clue quickly.
>
>
> Kind regards,
> Niklas

