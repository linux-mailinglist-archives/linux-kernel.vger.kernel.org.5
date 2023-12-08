Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374C080A748
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574292AbjLHPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574152AbjLHPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:24:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D70FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:24:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106D8C433CA;
        Fri,  8 Dec 2023 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702049066;
        bh=l8nqaBJV6WKjyft6BFOzeRuXp40fNTOvNlDjW6JjKA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U9ErcLbWN0mPFHgLxZ1zxX5JdmFeCgxPuASWcJJvKdEkv9FegYso6a4v24cpLa6Vq
         Pq55N4HNozjLDnnhhZW+uXhh0FbiC8JTgx8QFOv0UarpJse5YmlZG+9hKNiLIFuMh4
         upihiVn49Qpvr5us/S9yoJEPTmnqdblhNC+X2vf8SkiQjBCK96siZPQE0ZXs3adzWL
         Pl5YW3C8qO0okIIMCHxGNUSJYjqBjkN6XmQsjNKaqbZo4OS5FSoT1R1LMF43pSA8s3
         6F4QGL6bgvTtQpAL9JibIRnfFc7OpfJf2TkH/ooeVVlncDoqruGQxn41aUCqmk1Z9y
         +U/Tf113eoMvA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso27026511fa.0;
        Fri, 08 Dec 2023 07:24:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwU0aS0w1Rulx+1iL5zkqNXJQB3DNr3oIm9agJF79gH4q/3cW7E
        og2jswd0K4nTr50TF8tr/NtK4uoZcCTrfiqsQcI=
X-Google-Smtp-Source: AGHT+IHGAJSluBqm87O1oTBi+KPFUFSGRuaj6rIagCHHs1I6Di3ao/RX/79E0bYBgQrqmDbG+z5RESlpf55Sm+TUuiU=
X-Received: by 2002:a2e:8813:0:b0:2c9:faeb:cb5d with SMTP id
 x19-20020a2e8813000000b002c9faebcb5dmr23363ljh.185.1702049064262; Fri, 08 Dec
 2023 07:24:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003dd70305e722f605@google.com>
In-Reply-To: <0000000000003dd70305e722f605@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 Dec 2023 16:24:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
Message-ID: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
To:     syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 at 13:10, syzbot
<syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=126f0865080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10039fc3080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4ebc3080000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
efivarfs-list-corruption-fix
