Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1378D269
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjH3DRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjH3DQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:16:53 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67BA6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:16:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so112541cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693365410; x=1693970210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsbp1MTEU+V1uOgThW4ZCQMBGCH501XSWX0uFO9d4wk=;
        b=GKFskmJC3Usb6QiGv+3yx0kgppdm44yW/f8dC2G6LBI2VHgUM8eobmnwgDBN4MXmpc
         0SfxbVKTzwjl5Cc0zhTdquN+YYPDR5Xjj/+ADs6faqFiF7lyMxOLSmYrSHOewPgOaldE
         zBx1vBozNn0tUpEoUFGfksMHZC3a5ZAjTKaZiVVZQXxgS1bsLnh7glj+Xx9cO568AEBC
         qCmS8y8nW3+tgUYl0yzA7loqSnnZKjrC2KpbCtXWhFxt9NAM6xDC+2j4b1TZll4axyxL
         6FsPWNYGEBDD0xZ88dPgT/B15vfWJOmlSM1qUK2R9vPtY9xCZ89Uq2pptxsBebZLXr8s
         I3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693365410; x=1693970210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsbp1MTEU+V1uOgThW4ZCQMBGCH501XSWX0uFO9d4wk=;
        b=Vekk4iREqLJc2oT8Q67RvaxE3ue0JW6LN1Q5h7pbsEruPBAHx8oxpNR4KVxh5mpbTh
         trWQRs2XW6U2JW7oV513mdAOwsQ02EIVHcS+aroWlh8JN19RMpHjpCm/uDoQx2teScca
         6xrjIOO2lXjLb32b+XOKH5wZA+h9hf79i0ZCVlD8Hdu9dUBCSLT7Cr5RoFJwCk5yVCQm
         mQMeV20cU0dQgTIyeR7J0itk62qx42QS9OWVGpz0T53sZrwFjVS5p8BvPH6wqpCJHX2Q
         pM70zs1rf6h2fwG13pIiTyZg7pgRVpGAzp154FoO5C1GZfzs0EjvfUv/eA53n9qFtNuK
         ChJg==
X-Gm-Message-State: AOJu0YxqCDF6/VO3SvK1FY6COYSxqu3cDwN2/Rccw8v4QtoQyu9jGzxm
        2mq/chPE5Cmn0Z4aH4ijz0xo1tSN+PhGG/3x7xt3zA==
X-Google-Smtp-Source: AGHT+IF74n41/IyZQfm4cGgTZ3BY5g18F983kAFuueLTtIFcKMZXThCPPHh/XvC4DdWCgr9yJ12Qbcdr/jIjAsCG0/M=
X-Received: by 2002:a05:622a:1910:b0:403:aa88:cf7e with SMTP id
 w16-20020a05622a191000b00403aa88cf7emr323298qtc.29.1693365409601; Tue, 29 Aug
 2023 20:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000017ad3f06040bf394@google.com> <0000000000000c97a4060417bcaf@google.com>
In-Reply-To: <0000000000000c97a4060417bcaf@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Aug 2023 05:16:38 +0200
Message-ID: <CANn89iKB_fnWYT6UH3SsjArRT2424gVo2FjLoMyDrpixts+m2Q@mail.gmail.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_close (5)
To:     syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, davem@davemloft.net, eric.dumazet@gmail.com,
        gautamramk@gmail.com, hdanton@sina.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, lesliemonis@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mohitbhasi1998@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, sdp.sachin@gmail.com,
        syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in,
        viro@zeniv.linux.org.uk, vsaicharan1998@gmail.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:57=E2=80=AFAM syzbot
<syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
> Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
> Date:   Wed Jan 22 18:22:33 2020 +0000
>
>     net: sched: add Flow Queue PIE packet scheduler
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D101bb71868=
0000
> start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.=
k..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D121bb71868=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D141bb71868000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45047a5b8c295=
201
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De46fbd528936346=
4bc13
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14780797a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17c1fc9fa8000=
0
>
> Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Yeah, I figured that out, and sent :

https://patchwork.kernel.org/project/netdevbpf/patch/20230829123541.3745013=
-1-edumazet@google.com/
