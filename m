Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85080A74A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574303AbjLHPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574281AbjLHPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:24:21 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C320FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:24:28 -0800 (PST)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d9e382c6a3so1688951a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049067; x=1702653867;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1HT6KdMEtZzB/+LWM0YZABVs05WlLcsC/jFOBBJO7c=;
        b=AHwyKp/9ThT62hWy2OKQpvq6DNHHRYW3Gje00/c5qT1B1THeMRA70tydIgwc2H0QHf
         2L1cmGKklxO8jwoLLr0i1Dewnj0W9fHPQt0ezDuVQFurUbdAexaDkIU1aMry1iRUopGQ
         4SthiToNUVx0/oOsSTh2lcp3SbAh1B5UoFKzHIhCsZkGzePwBucu9HiG00vE5i8e/kn7
         xvyAjxTlHDzCBcRR+01VWBZTnBDZ5k/ANCIVP93dSVwPqp0Ob10eQm9VttJX9YoM+9t2
         6nWCNzpvbB5XL8UaMptpQN2vKYVnLBhjhT9X7i8dj2ycwpls5Grdr40Ke1EqTQKefBvJ
         +wag==
X-Gm-Message-State: AOJu0Yxg4/2auvCgacmwc4o53tmvCrmX7gJQo4kM1eqaUkOtV218kiKf
        cyWSqgOOPxn9p/30SlfGPsfhC6igkaXJz7Rusw7/IWqXLN+s
X-Google-Smtp-Source: AGHT+IH3zWKK4v1FlR7+V+9DN7EhFjDbW/pgByFdpA0Zp8hdex+2ghQB/Uf7uJziE44YsPhRqi4uZ5QO68h5TOCl/nj8xzQVnNYy
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b01a:b0:1fa:e0c9:56e9 with SMTP id
 y26-20020a056870b01a00b001fae0c956e9mr186218oae.6.1702049067564; Fri, 08 Dec
 2023 07:24:27 -0800 (PST)
Date:   Fri, 08 Dec 2023 07:24:27 -0800
In-Reply-To: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010057c060c012e63@google.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To:     ardb@kernel.org
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 26 Aug 2022 at 13:10, syzbot
> <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=126f0865080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10039fc3080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4ebc3080000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

want either no args or 2 args (repo, branch), got 1

> efivarfs-list-corruption-fix
