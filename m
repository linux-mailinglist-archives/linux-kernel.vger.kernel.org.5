Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2764880A792
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574371AbjLHPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574346AbjLHPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:38:32 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5357FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:38:38 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9f111c18dso358977b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049918; x=1702654718;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahIWnqlLG7o2GvCS3sSEr4BJBQZlUuM+Rx7DCDWofl0=;
        b=DgiyvKUmH7HJEdswR6WnUVPnO6gthz5dulwawKCt/t5/Zi+ux5VjrTkdO1n8vV4sKy
         6kPI5ufvnsZOlXpm6wgkTvrX8+hUZEAvcGJsKtYd7PvS+RDikEf++2VIIPCTWj96emY5
         z71Ex45oND6tdirIrXHsC8vvw8BACZG//T3ijpnn2RYEdXQLWgJNyn/uo/089EzU6M3x
         gnTIZ5nrRNX4pG5Fh9xhTT4VTVicGRhhMePn7XuXovP8n7lcWGjxcIp+QjyezNwW1CjE
         4fHXfo1Iplv/4WYUUbYwg75of5q1VaCwER1T2Olz7r+YUQgoWSvwqXhqj34MgDF7l3CH
         XOGw==
X-Gm-Message-State: AOJu0YxhMI/ZnkVthsgfxQPZO2ACp+CH+qxuaWv73SgrqGJmEF99MbHL
        gfS4RvlV5akgY5F/xk7n/9t3pM2sZtrmRfVbNejP8F5LaMDy
X-Google-Smtp-Source: AGHT+IHOLAlnD/04ddOH1uufUFXo9s24hIBEAnNH7j41Fr4mr8Igody3/IJiBE0UC3p5YBKjvsGu9nur80cbbsvG6kDgSmnfun12
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3082:b0:3b9:ef48:de85 with SMTP id
 bl2-20020a056808308200b003b9ef48de85mr151647oib.2.1702049918089; Fri, 08 Dec
 2023 07:38:38 -0800 (PST)
Date:   Fri, 08 Dec 2023 07:38:38 -0800
In-Reply-To: <CAMj1kXFBa2z3FKaEzRyJ1ugZy7P3VfS18hheDs8-+pZ+Gch4pQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2015d060c016027@google.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To:     ardb@kernel.org
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
>>
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

want either no args or 2 args (repo, branch), got 1

> ecbfc830fd039
