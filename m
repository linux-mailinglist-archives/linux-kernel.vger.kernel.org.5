Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7B75AC86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGTLDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGTLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:03:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EBE47
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:03:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40371070eb7so212721cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689850998; x=1690455798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzcwBdpl5HMwpTM9mefFIItUNXhQS0KltK5Lg011ksc=;
        b=4tZREZnAIjkaPmELhwa7GOxSPkiv+kcJZSanIMCXnuIQ9FZ1S/99ZmpWTIaCK9d4fQ
         zK/CBWo+q1iFRHrROrfPP/5LbehlOXjk3quhivoTorZbJtq1aJyAqEl9cOBPa4HgrErM
         P7JlRPutwH8pdJwSLhhStgDuZNVI3ECVnDDrNMcaIzTLsesYfvjj9AA5R5YU09h+ncbn
         HeQKyEltjir/+gR0lT+70Del5tt2SAnwblOEK86H6+ZAjgm9Ih1WbYb2cVbXwWRsUfjc
         yxhLXtgq6OaP0qnjMH7smvCV0VmPxZ9KjQYDQH7YXj1Ad3pvHpTripJngA+e5ujsxqKC
         oqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689850998; x=1690455798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzcwBdpl5HMwpTM9mefFIItUNXhQS0KltK5Lg011ksc=;
        b=KyMhPsyDYGB/QlioI6yprTB/Kxq+euy7aky9w1bKomBX4xxVpVlqkOYJQI1M8+nrC2
         IireHlZqhhH1lphbIv5rxd73KDRuxpjFutK9SjRPofCsi73briXdn0Ey41paFj7hUESd
         0Kd/YhSE/7ja5I08m5jnd0pCFyZcA4cTwGJRLSTsXHvgUkH52uNl7D+s4plKIK6c54k0
         ELMYt4qwivAD4XccYVSEEDHU+MQbRMGL/zDmWgCU1j5l8r8ww8pbS5ruHO069Esawf1y
         PtbsRuIDDhQa0Zdn9EQ+A1yjO/4ZIBGFY3iMQnYLnBIa2cb/g3IW57Bu1CEznF7XB2Yy
         Nnog==
X-Gm-Message-State: ABy/qLa9GnqqenBVMxFboAWmP8Amacnj8tpVVhA5WLcK1QsVgamBhEWq
        sN5DG9cO85i5fUwHbdQEGIt2Qw4rhU86MeEB8b0kkA==
X-Google-Smtp-Source: APBJJlEXzLKpxJoSaeiXhEasRXIB0BhPor99GDzanoYUTD3lDhrNIQ2/UvlIauTce2k7fwT9od8WgX+wkufJhbIX8Ho=
X-Received: by 2002:a05:622a:24c:b0:3f8:5b2:aef5 with SMTP id
 c12-20020a05622a024c00b003f805b2aef5mr179959qtx.29.1689850997521; Thu, 20 Jul
 2023 04:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <yt9dedl2rgoo.fsf@linux.ibm.com>
In-Reply-To: <yt9dedl2rgoo.fsf@linux.ibm.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jul 2023 13:03:06 +0200
Message-ID: <CANn89iKEc0+FXeu2u1zySr=T+sB4+BXy6v494_n7vxBLzb-dQA@mail.gmail.com>
Subject: Re: AF_UNIX crash in bind() triggered by strace test
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 1:00=E2=80=AFPM Sven Schnelle <svens@linux.ibm.com>=
 wrote:
>
> Hi,
>
> the following crash was reported in our CI on s390x with
> debug_defconfig, which enables FORTIFY_SOURCE:
>
> detected buffer overflow in __fortify_strlen
> ------------[ cut here ]------------
> kernel BUG at lib/string_helpers.c:1031!
> monitor event: 0040 ilc:2 [#1] PREEMPT SMP
> Modules linked in: [..]
> CPU: 0 PID: 243755 Comm: net-accept-conn Not tainted 6.5.0-20230719.rc2.g=
it1.f1311c9e1695.300.fc38.s390x+debug #1
> Call Trace:
>  [<000000003465b7a2>] fortify_panic+0x2a/0x30
> ([<000000003465b79e>] fortify_panic+0x26/0x30)
>  [<0000000034a3a77e>] unix_bind_bsd+0x86/0x390
>  [<00000000348839d0>] __sys_bind+0xe0/0xe8
>  [<0000000034926270>] __do_compat_sys_socketcall+0x260/0x4d0
>  [<0000000034be3b66>] __do_syscall+0x1de/0x208
>  [<0000000034bfaf38>] system_call+0x70/0x98
> INFO: lockdep is turned off.
> Last Breaking-Event-Address:
>  [<0000000034774880>] __s390_indirect_jump_r14+0x0/0x10
> Kernel panic - not syncing: Fatal exception: panic_on_oops
>
> This is caused by a test case who sends an unterminated sun_path
> to the kernel in a bind() system call from the strace test suite.
> As a test i made the following quick fix, which "fixed" the issue:
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 123b35ddfd71..c505edd74d8c 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1206,11 +1206,13 @@ static int unix_bind_bsd(struct sock *sk, struct =
sockaddr_un *sunaddr,
>         struct unix_address *addr;
>         struct dentry *dentry;
>         struct path parent;
> -       int err;
> +       int pathlen, err;
>
>         unix_mkname_bsd(sunaddr, addr_len);
> -       addr_len =3D strlen(sunaddr->sun_path) +
> -               offsetof(struct sockaddr_un, sun_path) + 1;
> +       pathlen =3D strnlen(sunaddr->sun_path, UNIX_PATH_MAX);
> +       if (pathlen =3D=3D UNIX_PATH_MAX)
> +               return -EINVAL;
> +       addr_len =3D pathlen + offsetof(struct sockaddr_un, sun_path) + 1=
;
>
>         addr =3D unix_create_addr(sunaddr, addr_len);
>         if (!addr)
>
> However, unix(7) says "The pathname in sun_path *should* be
> null-terminated." So this change might break userspace. I'm not sure
> whether we should return -EINVAL, or just truncate the name to
> UNIX_PATH_MAX. From a quick read, it looks like connect() would trigger
> the same problem. Any thoughts?

https://patchwork.kernel.org/project/netdevbpf/patch/20230720004410.87588-2=
-kuniyu@amazon.com/
