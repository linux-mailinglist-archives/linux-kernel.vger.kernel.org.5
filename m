Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA257D7F75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJZJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:21:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F292186
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:21:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso140055ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698312094; x=1698916894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZMZ4PPqKuvaUyytZN8F6rFzjVZIuTDbX7E6WtfgOoc=;
        b=CX8ghylPN9zgN+pJroo/nXs8Oi/8BQzUEf4avEdnQJ3DUU35zrhtqVJ2hki8gv+0Qx
         TX7d6vR2736n7ItALon2KEgLi7wbgAAWli/RNoWJk6ze5diqpeQt6SenCPs5fzE9PG4j
         8XTzYsWJ5qD29xkch5ufck6bPA0xOyTFw2aZlCXkX/CedchuMHo4stoHaNGXUZRn0W/e
         Gz3BjB4xVDIwFCO+XFGK7cis/pXUwZxwt/y/OaQhA4GtqYwJ6xkvThNw04kjdKTJaJ9o
         ZTD+EFQ1HZ57U92DSnwbX17B3fufwB+9PkisRcdS1lWs9v7i44LySzUy2Mn1hdOoPRmx
         g3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698312094; x=1698916894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZMZ4PPqKuvaUyytZN8F6rFzjVZIuTDbX7E6WtfgOoc=;
        b=G1EMXrU0W6bBm6Jpq+1ZsKN6Xo0Ny8vXKGiJyv6u3bMW3koQqEsLPXL8qi434hiDGm
         w40//MCWeJ9J294EROXgy4uS+b08+mX1Ha7FUiHI+c9ys6f7sOpF1s5KUORTySeBZZag
         EbrHUu5VRdhfluQyl7pAVT9tpiWTn6k/5b0fbeCVSNd5eetOy4P8sjWOmsh79+MIKL3f
         9bS7cBaLX6oeFThiLl7iPEc4jnkgf8lnMVMtqshyAIaXR3H85p2Iuppdg5CthIEyJmpR
         fFn98ekoqyIRGgb1FMZU2UquAHST2rr7HOHgG0kI4tXHxGuAdh/S1jukhoa8sG6dEulm
         cMaA==
X-Gm-Message-State: AOJu0YxJX6UVhCXtKNTqNGIebI5cn430smodnwGdno7KX9cQ7LL3ttXj
        0jC8PjbjSXG+8Pj8dQhNp+WbEW2k/uBFHAy5I8eD2g==
X-Google-Smtp-Source: AGHT+IErCd6aP8iwtmE/F3hCl2wzy53K0Ir6Imof+twmkHwphD9ClXmtrVHybhDQN1tU8IUIk51ZAULDc4AINetRPX8=
X-Received: by 2002:a17:903:28c:b0:1c9:e229:f5ec with SMTP id
 j12-20020a170903028c00b001c9e229f5ecmr427638plr.22.1698312093726; Thu, 26 Oct
 2023 02:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000f188605ffdd9cf8@google.com> <00000000000017dd680608991d75@google.com>
In-Reply-To: <00000000000017dd680608991d75@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 26 Oct 2023 11:21:21 +0200
Message-ID: <CANp29Y4kNfuBK6LxU5nAHwA8wGqGYK9EJ-uBFef70s=AEbNP0g@mail.gmail.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
To:     syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
Cc:     arthurgrillo@riseup.net, chao@kernel.org, hdanton@sina.com,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhi.xu@windriver.com, mairacanal@riseup.net, mcanal@igalia.com,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some still unknown reason, syzbot's bisections of fs bugs
sometimes end up in drm. There've been quite a few such cases
already..

Please ignore this bot's message.


On Thu, Oct 26, 2023 at 8:59=E2=80=AFAM syzbot
<syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a0e6a017ab56936c0405fe914a793b241ed25ee0
> Author: Ma=C3=ADra Canal <mcanal@igalia.com>
> Date:   Tue May 23 12:32:08 2023 +0000
>
>     drm/vkms: Fix race-condition between the hrtimer and the atomic commi=
t
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D166c090d68=
0000
> start commit:   28f20a19294d Merge tag 'x86-urgent-2023-08-26' of git://g=
i..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D21a578092dd61=
d05
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da4976ce949df66b=
1ddf1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15a09340680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D118909eba8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: drm/vkms: Fix race-condition between the hrtimer and the atomic=
 commit
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000017dd680608991d75%40google.com.
