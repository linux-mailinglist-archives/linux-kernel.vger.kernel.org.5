Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815E57859A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjHWNoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHWNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45619A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692798198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eq0j4wOflrCZJLCdrYDb6ppBDzMOqnUcGqRqF9KXxH4=;
        b=I+N7KgSnLzasSP0L5im+5MUctQX2RjzqWccoOhp5FlVTmDDJ0DOIx5ViO62Jja/E3OxTEr
        g97vVtldS4Ta6luUiqUikClKsAR38vePhJNROj0hKzw1UfRyzz/ghzmobM+5lbz9/+0V9k
        TMgLdX5Kex8+59aUm17xvarOx5F4nWk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-VyDnsyq2PNeivpy3hhBGMQ-1; Wed, 23 Aug 2023 09:43:17 -0400
X-MC-Unique: VyDnsyq2PNeivpy3hhBGMQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68a54f8888aso3606743b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798196; x=1693402996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq0j4wOflrCZJLCdrYDb6ppBDzMOqnUcGqRqF9KXxH4=;
        b=X/PDckPUOwf+mpK/k19lCmMmp5EqkTnqhCf1u6ksRynSImRo/a0Hxnavyd2DbpVMpI
         e6zFh+S4tjkhLT71PacoxfadmY3eHUAfoM/E07eP5tNmIJ7lT+gkyuQzFicLCCf4W/z3
         3cFfJEh+tS6WK3CtqpGQYTMWwXWogpIdixeahb21FBlOYKXeAYpkdZeqH3j38/U7aH05
         +xaVjZzUAg77/QjNBntCLkTXdg0bFCYS/oMwKQBUDAxGDUCg9m7kXMLngru+8qfK4o3j
         Lz199i3hHs1k6K0jabgYZrXhKx4I/4CfqqCxu8tpLxlE6Lo2DOTs9ntlfrSZwZWMK4sT
         e1GQ==
X-Gm-Message-State: AOJu0YwSQHGuAszDRfZ0HIfSjXURIkEdltziithEO/cR/FY2nR6TeSxv
        ecDiEvttP/0ldc+a7+BjH6T+1KeyS7FxaF9xlnr3YYCSQWKPGbIJV11DBLu/Vn+JiXpq1K3Vf0q
        MXSNWnqiewihgPmrjU8NMB+5VpXRtXtjhlmtoEa8I
X-Received: by 2002:a05:6a21:7881:b0:13a:52ce:13cc with SMTP id bf1-20020a056a21788100b0013a52ce13ccmr12599446pzc.51.1692798196365;
        Wed, 23 Aug 2023 06:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbbEZb/tHcDh2oL5DUw0SEIptHT0y8VNk2A+rz1XdOpuf4lBhfFtPNpbtRHOZbn7hJE0N3sBqTqVMPP99QfPg=
X-Received: by 2002:a05:6a21:7881:b0:13a:52ce:13cc with SMTP id
 bf1-20020a056a21788100b0013a52ce13ccmr12599426pzc.51.1692798195948; Wed, 23
 Aug 2023 06:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b5e2405f14e860f@google.com> <20230127051009.3881703-1-eadavis@sina.com>
 <6561085e-d4c9-bd04-d59b-eb39cfbaa3e7@redhat.com>
In-Reply-To: <6561085e-d4c9-bd04-d59b-eb39cfbaa3e7@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 23 Aug 2023 15:43:04 +0200
Message-ID: <CAHc6FU5Zk6drhr_mC36hCMrq=ZmpDeBQsS9AZOT-NdsiXb1qVg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix uaf for qda in gfs2_quota_sync
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     eadavis@sina.com,
        syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 9:32=E2=80=AFPM Bob Peterson <rpeterso@redhat.com> =
wrote:
> On 1/26/23 11:10 PM, eadavis@sina.com wrote:
> > From: Edward Adam Davis <eadavis@sina.com>
> >
> > [   81.372851][ T5532] CPU: 1 PID: 5532 Comm: syz-executor.0 Not tainte=
d 6.2.0-rc1-syzkaller-dirty #0
> > [   81.382080][ T5532] Hardware name: Google Google Compute Engine/Goog=
le Compute Engine, BIOS Google 01/12/2023
> > [   81.392343][ T5532] Call Trace:
> > [   81.395654][ T5532]  <TASK>
> > [   81.398603][ T5532]  dump_stack_lvl+0x1b1/0x290
> > [   81.418421][ T5532]  gfs2_assert_warn_i+0x19a/0x2e0
> > [   81.423480][ T5532]  gfs2_quota_cleanup+0x4c6/0x6b0
> > [   81.428611][ T5532]  gfs2_make_fs_ro+0x517/0x610
> > [   81.457802][ T5532]  gfs2_withdraw+0x609/0x1540
> > [   81.481452][ T5532]  gfs2_inode_refresh+0xb2d/0xf60
> > [   81.506658][ T5532]  gfs2_instantiate+0x15e/0x220
> > [   81.511504][ T5532]  gfs2_glock_wait+0x1d9/0x2a0
> > [   81.516352][ T5532]  do_sync+0x485/0xc80
> > [   81.554943][ T5532]  gfs2_quota_sync+0x3da/0x8b0
> > [   81.559738][ T5532]  gfs2_sync_fs+0x49/0xb0
> > [   81.564063][ T5532]  sync_filesystem+0xe8/0x220
> > [   81.568740][ T5532]  generic_shutdown_super+0x6b/0x310
> > [   81.574112][ T5532]  kill_block_super+0x79/0xd0
> > [   81.578779][ T5532]  deactivate_locked_super+0xa7/0xf0
> > [   81.584064][ T5532]  cleanup_mnt+0x494/0x520
> > [   81.593753][ T5532]  task_work_run+0x243/0x300
> > [   81.608837][ T5532]  exit_to_user_mode_loop+0x124/0x150
> > [   81.614232][ T5532]  exit_to_user_mode_prepare+0xb2/0x140
> > [   81.619820][ T5532]  syscall_exit_to_user_mode+0x26/0x60
> > [   81.625287][ T5532]  do_syscall_64+0x49/0xb0
> > [   81.629710][ T5532]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [   81.636292][ T5532] RIP: 0033:0x7efdd688d517
> > [   81.640728][ T5532] Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 =
0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 =
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 4=
8
> > [   81.660550][ T5532] RSP: 002b:00007fff34520ce8 EFLAGS: 00000246 ORIG=
_RAX: 00000000000000a6
> > [   81.669413][ T5532] RAX: 0000000000000000 RBX: 0000000000000000 RCX:=
 00007efdd688d517
> > [   81.677403][ T5532] RDX: 00007fff34520db9 RSI: 000000000000000a RDI:=
 00007fff34520db0
> > [   81.685388][ T5532] RBP: 00007fff34520db0 R08: 00000000ffffffff R09:=
 00007fff34520b80
> > [   81.695973][ T5532] R10: 0000555555ca38b3 R11: 0000000000000246 R12:=
 00007efdd68e6b24
> > [   81.704152][ T5532] R13: 00007fff34521e70 R14: 0000555555ca3810 R15:=
 00007fff34521eb0
> > [   81.712868][ T5532]  </TASK>
> >
> > The function "gfs2_quota_cleanup()" may be called in the function "do_s=
ync()",
> > This will cause the qda obtained in the function "qd_check_sync" to be =
released, resulting in the occurrence of uaf.
> > In order to avoid this uaf, we can increase the judgment of "sdp->sd_qu=
ota_bitmap" released in the function
> > "gfs2_quota_cleanup" to confirm that "sdp->sd_quota_list" has been rele=
ased.
> >
> > Link: https://lore.kernel.org/all/0000000000002b5e2405f14e860f@google.c=
om
> > Reported-and-tested-by: syzbot+3f6a670108ce43356017@syzkaller.appspotma=
il.com
> > Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> > ---
> >   fs/gfs2/quota.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > index 1ed1722..4cf66bd 100644
> > --- a/fs/gfs2/quota.c
> > +++ b/fs/gfs2/quota.c
> > @@ -1321,6 +1321,9 @@ int gfs2_quota_sync(struct super_block *sb, int t=
ype)
> >                                       qda[x]->qd_sync_gen =3D
> >                                               sdp->sd_quota_sync_gen;
> >
> > +                     if (!sdp->sd_quota_bitmap)
> > +                             break;
> > +
> >                       for (x =3D 0; x < num_qd; x++)
> >                               qd_unlock(qda[x]);
> >               }
>
> Hi Edward,
>
> Can you try to recreate this problem on a newer version of the gfs2 code?

The problem is that gfs2_quota_sync() is holding references to
gfs2_quota_data objects when the filesystem decides to withdraw. The
withdraw code calls gfs2_quota_cleanup(), which wipes away the
gfs2_quota_data objects that gfs2_quota_sync() is still referencing.
So that reference counting needs to be fixed. Alternatively, if we
could delay the withdraw until the end of gfs2_quota_sync(), we would
be fine as well, but we don't have that kind of mechanism.

> In the linux-gfs2 repository I've got a branch called "bobquota" that
> has a bunch of patches related to quota syncing. I don't know if these
> will fix your problem, but it's worth trying.

That branch doesn't change the reference counting. It doesn't address this =
bug.

> The thing is, the qda array should have been populated by previous
> calls, like qd_fish and such, and should be okay to release by
> quota_cleanup.
>
> I can tell you this:
>
> In the call trace above, function do_sync tried to lock an inode glock,
> which tried to instantiate it, and that caused a withdraw.
> The thing is, the only inode glock used by do_sync is for the system
> quota inode. If it had a problem instantiating that, your file system is
> corrupt and needs to be run through fsck.gfs2. It could indicate a
> hardware problem reading the system quota dinode from the storage media.
>
> If possible I'd like to know how you cause this problem to occur. What
> were you doing to get this to happen? And how can I recreate it?

It's one of those syzbot bugs, so filesystem fuzzing.

> GFS2 might have a problem with withdrawing during this sequence, but I
> don't think it has much to do with the sd_quota_bitmap.

Yes, I agree.

> Regards,
>
> Bob Peterson
> GFS2 File System

Thanks,
Andreas

