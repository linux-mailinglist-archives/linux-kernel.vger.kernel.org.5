Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA780A790
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574362AbjLHPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574346AbjLHPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:38:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C4FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:38:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E480C433C7;
        Fri,  8 Dec 2023 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702049914;
        bh=UzwffuBK1Uf1+t2jPlhxP2kBQ7ODitP5Un61cVXZRjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e8GYGqgqZupeI+U2efyaCzVFaYwm3TZV8//6IMNDEeTmlmmMPBWIBLFTRDDgE7Qqr
         n7uxGgW4cInZTj9nAliyHnkUamL3D+QeayelBMJJCsyI9ioq1MxnMlHZ+wjLS/TQKO
         U6JXmPAF0cjh48Ea3tdx5s7mjoalJjvapRdc27ld7/1VFixpnsCT802Lw4EP+Xm+2S
         iUNS5IySjrtN17wsi4eKQPIjcw88fKJS5mqzJ9aOw63JmKzrYUK7WfAOE2d9iUft0P
         A54Tw4UR7t0YA2rm8nkS00+fiw+isXtYQe/dDjwom53KA1EEfDHpT/L8+gJMUCDrPo
         awBEb2lIeeSQA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so31934621fa.3;
        Fri, 08 Dec 2023 07:38:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yz0JcKeVb3wqnXL6gp6WD0r85n3CfQp6Dd34e5Y/xMa7FL36gps
        OOEKsYhRUKW2eIW0G/JE2P8sI9x+buA4LLtzj+I=
X-Google-Smtp-Source: AGHT+IG+fQumReFmH36mfVgBVk/QaevtEOE1j9zU2uc/l9PPdmnMN4nTRobAKvpukIME/5w4kVwNxx4WZV8N7g4bSBI=
X-Received: by 2002:a2e:3a09:0:b0:2c9:ed9f:9e03 with SMTP id
 h9-20020a2e3a09000000b002c9ed9f9e03mr52284lja.37.1702049912610; Fri, 08 Dec
 2023 07:38:32 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003dd70305e722f605@google.com>
In-Reply-To: <0000000000003dd70305e722f605@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 Dec 2023 16:38:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFBa2z3FKaEzRyJ1ugZy7P3VfS18hheDs8-+pZ+Gch4pQ@mail.gmail.com>
Message-ID: <CAMj1kXFBa2z3FKaEzRyJ1ugZy7P3VfS18hheDs8-+pZ+Gch4pQ@mail.gmail.com>
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
>

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
ecbfc830fd039
