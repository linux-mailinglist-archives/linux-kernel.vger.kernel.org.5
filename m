Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C878C670
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjH2Nsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjH2NsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:48:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC24CE8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:48:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcce32ccd4so16233181fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1693316887; x=1693921687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTFpH+tPN6fRS5ps0ggd0sHJSF5U3bOMN6MYvOwDdro=;
        b=hQau5sKma7igMNRj+sONY4RccjMjgQbfry5aCoRoH5RKjjcoqFPq0R0wviaX/5dseA
         CmvkolnIZQNJzK1PCSkRFT0pwhfbLYG/hRN7gbPQhKqJBVpWUtx0anvi6zT3sht9DrcM
         kOJkAkY8HS7KiAyMAsOSxSkGscVocqdcwiNN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693316887; x=1693921687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTFpH+tPN6fRS5ps0ggd0sHJSF5U3bOMN6MYvOwDdro=;
        b=SeymYI0JKSuTSabEmxzJe1FOkuJ0b7LgQNGjgJ3efIFBl+U00CP6OwO75tYkf9xUON
         ZzQ8WB+yHm7FkGrqQYImt0vnwfCYne5vEQxAiO0DUfoLuhdsPN/KikaMa1QT4jG0oBNP
         mCjR2m8AkXrjoDPiq+PSb1YPginKZZ6VRm3UAJ1OH8IzHKiyRzkbHy0SEhmUIUVGZk1K
         we20G5BsPE6Xnx97nX8NWwOv//B0EFlw9mNlMHPJX7Se0gVxCI+kWuKm7Yoj+C1/c6Ag
         tsFv9Ij/jv2MxxjTlMolaXpZcWFTQGvsogLuDjAIGErMQnhqDg8ow1J27iDje2MhjXV4
         BY2g==
X-Gm-Message-State: AOJu0YwA1EPCImj8MpSclC5qT/tibw3Jydv38bhG7sopEi/+MPgZRSGT
        90XoTB0xe+LFZnGGVbWaP397jCkKdtt5sa1/z3vREA==
X-Google-Smtp-Source: AGHT+IETQlqCI9cp5f0SRdp69H8dlulsvy8kF9bvN+xEcCMAj1pWWrmos+5hn//qoDG05pY/itt+GE8B8tv1BlCOiZM=
X-Received: by 2002:ac2:5329:0:b0:500:7fc1:3875 with SMTP id
 f9-20020ac25329000000b005007fc13875mr15406545lfh.5.1693316158221; Tue, 29 Aug
 2023 06:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner> <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
In-Reply-To: <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Tue, 29 Aug 2023 15:35:46 +0200
Message-ID: <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de, paul@paul-moore.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:11=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 15, 2023 at 10:59:22AM +0200, Christian Brauner wrote:
> > On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Wei=C3=9F wrote:
> > > Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> > > which allows to set a cgroup device program to be a device guard.
> >
> > Currently we block access to devices unconditionally in may_open_dev().
> > Anything that's mounted by an unprivileged containers will get
> > SB_I_NODEV set in s_i_flags.
> >
> > Then we currently mediate device access in:
> >
> > * inode_permission()
> >   -> devcgroup_inode_permission()
> > * vfs_mknod()
> >   -> devcgroup_inode_mknod()
> > * blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block dev=
ices and friends
> >   -> devcgroup_check_permission()
> > * drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info =
afaict
> >   -> devcgroup_check_permission()
> >
> > All your new flag does is to bypass that SB_I_NODEV check afaict and le=
t
> > it proceed to the devcgroup_*() checks for the vfs layer.
> >
> > But I don't get the semantics yet.
> > Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
> > is that a flag on random bpf programs? It looks like it would be the
> > latter but design-wise I would expect this to be a property of the
> > device program itself.
>
> Looks like patch 4 attemps to bypass usual permission checks with:
> @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inod=
e *dir,
>         if (error)
>                 return error;
>
> -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> -           !capable(CAP_MKNOD))
> -               return -EPERM;
> +       /*
> +        * In case of a device cgroup restirction allow mknod in user
> +        * namespace. Otherwise just check global capability; thus,
> +        * mknod is also disabled for user namespace other than the
> +        * initial one.
> +        */
> +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
> +               if (devcgroup_task_is_guarded(current)) {
> +                       if (!ns_capable(current_user_ns(), CAP_MKNOD))
> +                               return -EPERM;
> +               } else if (!capable(CAP_MKNOD))
> +                       return -EPERM;
> +       }
>

Dear colleagues,

> which pretty much sounds like authoritative LSM that was brought up in th=
e past
> and LSM folks didn't like it.

Thanks for pointing this out, Alexei!
I've searched through the LKML archives and found a thread about this:
https://lore.kernel.org/all/CAEf4BzaBt0W3sWh_L4RRXEFYdBotzVEnQdqC7BO+PNWtD7=
eSUA@mail.gmail.com/

As far as I understand, disagreement here is about a practice of
skipping kernel-built capability checks based
on LSM hooks, right?

+CC Paul Moore <paul@paul-moore.com>

>
> If vfs folks are ok with this special bypass of permissions in vfs_mknod(=
)
> we can talk about kernel->bpf api details.
> The way it's done with BPF_F_CGROUP_DEVICE_GUARD flag is definitely no go=
,
> but no point going into bpf details now until agreement on bypass is made=
.

+CC Miklos Szeredi <miklos@szeredi.hu>
+CC Amir Goldstein <amir73il@gmail.com>

Kind regards,
Alex
