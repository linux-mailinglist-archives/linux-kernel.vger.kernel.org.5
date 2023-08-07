Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D22772E16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjHGSom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHGSok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E752171C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEDD762123
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FF8C433B9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691433878;
        bh=zcobmAFSDfSYyAGTuIrS1z2tk0Tfj/OjYcY8FpzEp9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b4Z8QheX/wKVn3rObb0aygAdPMglIgGILREvYyzTWAPpWmz9sQUWwdMR0Kv1D6KC5
         XB4WbuY446ee3OEJJ4S12r+9AKRgbWuBRU23H0BKzCRjTNdI1xQXzl5UlHTcnEDlC5
         yfTL42W1EgvT6dW5ZM02QxKk+SvMsxnsCedjWVacDrf5Am0CzMrokfhwc+Eqj3dKFW
         BptQEXv9li8P0zqq5hz02/W7uQ7nXR776y3TDHDTd0wkuKXb6pbn6vXQYbc+IwBypq
         +BvSKJE09Mcw8ILRLsBkkL21kAz26Qg5pVqtNY8t3oLuGXh5AgIUXKo3kdmPmthh8o
         Qg8YXSsvST6Mg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56cc3453e31so3170574eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:44:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw9e6rDZzy9vMNQFWDQXcGUUtlNgl1Xj05mKOa0b35ErGEj+G+H
        RUec8Xyh1gvTHZmDr4q/ex+Wsj7fSQd9DwxBjV4=
X-Google-Smtp-Source: AGHT+IEnr9g6cMRHUfWZzxSBbYYbZhHoFnKV5kxBZuTJawdcrsOATSyuCSBg9MnnLK5yZ8YfuQnLFtO4q+FnwbhrlPo=
X-Received: by 2002:a4a:d20d:0:b0:566:ffa7:fd00 with SMTP id
 c13-20020a4ad20d000000b00566ffa7fd00mr8344397oos.6.1691433877368; Mon, 07 Aug
 2023 11:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230623145358.568971-1-yesshedi@gmail.com> <20230623145358.568971-9-yesshedi@gmail.com>
 <CAK7LNARnuaOi-GwW0qnFgH5styuUTtmjSNWV92PEO6VgpqNvQg@mail.gmail.com> <c98ffcdc-1e2f-4496-99a3-3b590002e5b1@gmail.com>
In-Reply-To: <c98ffcdc-1e2f-4496-99a3-3b590002e5b1@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Aug 2023 03:44:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASR1fCXG8M-3=Zb-_i2mFFt-cHpREzeWkw1Fe-Zuz_XSw@mail.gmail.com>
Message-ID: <CAK7LNASR1fCXG8M-3=Zb-_i2mFFt-cHpREzeWkw1Fe-Zuz_XSw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 5:08=E2=80=AFPM Shreenidhi Shedi <yesshedi@gmail.com=
> wrote:
>
> On 07/08/23 01:02, Masahiro Yamada wrote:
> > On Fri, Jun 23, 2023 at 11:54=E2=80=AFPM Shreenidhi Shedi <yesshedi@gma=
il.com> wrote:
> >>
> >> Currently Makefile.modinst does three tasks on each module built:
> >> - Install modules
> >> - Sign modules
> >> - Compress modules
> >>
> >> All the above tasks happen from a single place.
> >>
> >> This patch divides this task further and uses a different makefile for
> >> each task.
> >> Signing module logic is completely refactored and everything happens
> >> from a shell script now.
> >>
> >> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> >
> >
> > This patch is bad in multiple ways.
> >
> > 1. Break "make modules_sign"
>
> Correct, somehow I missed it. I will fix it.
> I'm using below command to test sign only option. Please let me know if
> I should use something else.
>
> make modules_sign modules_sign_only=3D1 INSTALL_MOD_PATH=3D$PWD/tmp -j8
>
> > 2.   Serialize the installation steps, that is, works less efficiently
>
> Even in the existing system it happens in serially.

The existing code runs in parallel.

 1.  Copy the module "foo.ko" to the destination
 2.  Sign the module "bar.ko"
 3.  Compress the module "baz.ko"

Those three have no dependency among them, so
should be able to run in parallel.

Your code serializes 1 -> 2 -> 3



> And the existing
> method takes more time than the proposed version.
>
> root@ph5dev:~/linux-6.3.5 # ./test.sh orig
>
> real    0m14.699s
> user    0m55.519s
> sys     0m9.036s
>
> root@ph5dev:~/linux-6.3.5 # ./test.sh new
>
> real    0m13.327s
> user    0m46.885s
> sys     0m6.770s
>
> Here is my test script.
> ```
> #!/bin/bash
>
> set -e
>
> if [ "$1" !=3D "new" ] && [ "$1" !=3D "orig" ]; then
>    echo "invalid arg, ($0 [orig|new])" >&2
>    exit 1
> fi
>
> rm -rf $PWD/tmp
>
> s=3D"scripts/sign-file.c"
> m=3D"scripts/Makefile.modinst"
> fns=3D($s $m)
>
> for f in ${fns[@]}; do
>      cp $f.$1 $f
> done
>
> cd scripts
> gcc -o sign-file sign-file.c -lcrypto
> cd -
>
> time make modules_install INSTALL_MOD_PATH=3D$PWD/tmp -s -j$(nproc)
> ```
>
> > 3.   Increase code without adding any benefits.
> >Agree with increased code but this change is one step closer to Unix
> philosophy, do one thing well wrt modules_install.


I do not understand why "closer to Unix philosophy"?

You are adding extra/unnecessary complexity.

Currently, the parallel job is managed by Make's job server.

You are introducing another way of parallel execution
in scripts/signfile.sh
(and you completely ignored  -j <jobs> option to Make,
and always spawned $(nproc) threads).


Leave the parallel execution GNU Make.
That is how Kbuild works _properly_.




> > There is no good reason to do these chang >I hope the data I provided a=
bove to your 2nd point provides evidence
> that this fix is improving existing system. Please take a look again.


I saw it.   I re-confirmed this is not an improvement.  Thanks for the data=
.

As I replied to the other thread, my measurement did not show an
attractive result.
https://lore.kernel.org/lkml/CAK7LNATNRchNoj0Y6sdb+_81xwV3kAX57-w5q2zew-q8R=
yzJVg@mail.gmail.com/T/#m8234fc76e631363fbe6bdfb6e45ef6727fc48e80


>
> > NACK.
>
> Hi Masahiro Yamada,
>
> Replies inline above.
>
> Please correct me if my understanding is wrong. Thanks a lot for your
> time and patience. Have a nice time ahead.


I must let you know you are misunderstanding
the meaning of NACK.


NACK means:
 "I do not like it. Please do not submit it any more".



--
Best Regards
Masahiro Yamada
