Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20D5759CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGSR5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:57:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB631FD9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:56:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so7595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689789414; x=1692381414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD1IusQWRz6p2k0vZ6mCPvoLmaSeWQRMjCUQkOWqtZ4=;
        b=tokZw9dfLqWCkA//xRWaD3/62VJCQvQV+NksrMsFB3gANBGXmcp0kknUxUY88Ja52d
         otMnaSRZyF0woIeqeePP9qQM7+7RxUCU0Hdaqq14PmVZzBVoY4EI5pz5tzaJj1UAFdud
         2NfcmFmW99tltTR6vU3ux+cnaAhdPEnNGa1vad8CwhiE0pM2UyKQlp4dr+wS4jQpA7bx
         uLakX3lCdxTDhkbwwVFfogIcAuDkY7ebx6HVutkOKNmLhW7/Vl30UzLarBnLCzXnR51v
         ls4NF1NRyc7kIsHAckEFx72s9UO15Ygztw90IMhfSekugKUEy86jP+gMGASY8Z1HbIJK
         XpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789414; x=1692381414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD1IusQWRz6p2k0vZ6mCPvoLmaSeWQRMjCUQkOWqtZ4=;
        b=JHP+pT1VeRO5sIguE47a+4t9feDWBggx/LPilAu5aV/0rzhUQOsSjUJY8Y7l1q/qM9
         RU1w3isUX4Hy6I7Y1/T+ssL3bJGERYC+2GlyvvzqdAAghSSqgCSm0ZsRAUycjCHcybhL
         WRr4LXSOT+cAenOaOAhiknVJBQuvl+l7yTPsyCr52A3V4GG1peOXlVvBJp7sYgmOqEec
         NMuuPCTjGZq6Z5bsVw4oG3eypsmEARHxYUhwt6BzrtZbSnxfO5zLWApbihGbbsvWCMyG
         DhALcR+kihN90pJJYJ1pwcQRRY2Oqfx2kc2RfkLbquLMB3+UqoNlBS1HWea09wrKUBjk
         uzbA==
X-Gm-Message-State: ABy/qLa03txGm/rdRtO917AJiKVWesjYH26W6N3aTKdBRIEo2B05BYS7
        DljwcQKX+3E63K30Bc2Lu0u2S8+qajlHrN4GsoQ+Yg==
X-Google-Smtp-Source: APBJJlG5bTRD5YkszX4iw8+wglBuRr66CaZUTcAakzDmbxj2WKqLn2P0+Qoo7JohL/GOWrxSJZrgc4+E+BQi5RXNWfo=
X-Received: by 2002:a05:600c:4754:b0:3f6:f4b:d4a6 with SMTP id
 w20-20020a05600c475400b003f60f4bd4a6mr4947wmo.7.1689789413718; Wed, 19 Jul
 2023 10:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ada87505fe7cf809@google.com> <0000000000002361ee0600da8ec5@google.com>
In-Reply-To: <0000000000002361ee0600da8ec5@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 19 Jul 2023 19:56:42 +0200
Message-ID: <CANp29Y6QHom7Db6y3azXS0MACKSW6hUQzypZs7qrB-3TtxO1zA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
To:     syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
Cc:     Jiadong.Zhu@amd.com, alexander.deucher@amd.com,
        davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 7:42=E2=80=AFPM syzbot
<syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1dbcf770cc2d15baf8a1e8174d6fd014a68b45ca
> Author: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Date:   Wed May 24 03:42:19 2023 +0000
>
>     drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1622cafaa8=
0000
> start commit:   9a94d764e9bc Merge tag 'mlx5-updates-2023-06-16' of git:/=
/..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da4a7d74e6a7c3=
211
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D88f4b1e6cf88da1=
1f5cd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1152c4ff280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1307cbcf28000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, that's unrelated.

>
> #syz fix: drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
