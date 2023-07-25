Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45076190C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjGYM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGYM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:57:25 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A921AA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:57:22 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a5ab2d29bbso5428002b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289842; x=1690894642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOw8M5MEfuKWRaEOU1htxwvLHkFjQE/8NWsGwEPUhhQ=;
        b=jZdqbqQtW4ksfwcuw3d2TQSSt4Om7QoDtwLLMo3Gst03DvSZZ4KXHHZpbuEwUgmlMU
         lFx9fJ1mi0l6b/t749ZEHynSpOBsYilw7qxJAFT1fR6u7tQWgZ8IWopqrY9OvpfrR+Si
         Yv8lmp3F0DZwE1ukEQ7ee88dESmG0te8Q3wtCdJlyjlnT9wjYuJsNa+YqSN82Bfo28nI
         w4ws3DtTUWcjJ7rbSd5IEMInPpOjmE4a327FONay4TGCdMnd5P32szg8BlEEhydCWjj7
         eEcDIqSGIGphbXkQqoHmYxU8p3f2h1Lh9A2HFpJYkaKr23gA73g5xqHEpUvtHsfz6fID
         STow==
X-Gm-Message-State: ABy/qLZX23RyeC48OH7m/ZDm0c9suJSmtwi5o/4TJFUZoLGsQWg/BykC
        0ugezW2UWkpNLzDMAHZA2KDb59iQ2Oh7egq1TqivS4lFhIZq
X-Google-Smtp-Source: APBJJlGT5ZLlw0oGMTwCLMxeRVwuZL4LAuQ2BEQbUtmWWbEDKq21tCrSij87dhru4aCbHfthAYp+54z2UOiiNwEt9tNqBfQ6biJk
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13cf:b0:3a5:a925:80a0 with SMTP id
 d15-20020a05680813cf00b003a5a92580a0mr18099491oiw.2.1690289842333; Tue, 25
 Jul 2023 05:57:22 -0700 (PDT)
Date:   Tue, 25 Jul 2023 05:57:22 -0700
In-Reply-To: <0000000000000cb2c305fdeb8e30@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009eae2406014f451d@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
From:   syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
To:     alexander.deucher@amd.com, davem@davemloft.net,
        dhowells@redhat.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 30c3d3b70aba2464ee8c91025e91428f92464077
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Tue May 30 16:57:59 2023 +0000

    drm/amd: Disallow s0ix without BIOS support again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ad506ea80000
start commit:   ded5c1a16ec6 Merge branch 'tools-ynl-gen-code-gen-improvem..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=e79818f5c12416aba9de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c6193b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c7a795280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/amd: Disallow s0ix without BIOS support again

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
