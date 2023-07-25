Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89461762759
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGYXcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGYXcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:32:32 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8F19BA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:32:30 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-560c7abdbdcso9728623eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327950; x=1690932750;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAib9FhsF/p+ZXO7Hu3qYWPzTDSVp9gbYDlcfRv4tfU=;
        b=L10osn/f/Kq/PqCI4+4pHEGbDw5lnNfFZjeFY/a6to4JCR9e22AqIF2DSppv6/Q9/a
         0XXDijgBQsh39Ih9VHY+vWx1lgagqZj73ZzvYu3kcuAtYrGric20ULy2mBP/iJWY9dDk
         hZ2RaW7MpH+Bc/4qXycKJYoRpdmC9YFbgs3pg82t0qi2JjlQMJMFFxxALjznBZ0r/I4P
         yyMstTa6lGAKHZT077vJcMY9Ucus21tDgHWDiG1aKMkKAE8Clh2wFVbYfTJ3ZEqPTHRu
         5vVzgqq4jQWvmO9+G48HoJoFTKKFmzUGNMfbKeyMZMCQOaJNBx/OvTSVFJJeqXwRjC9k
         RwYA==
X-Gm-Message-State: ABy/qLZbtgergmX9KeEwyMF6F5d3qa5/olAYeCz4QXznatRB4iDOwb5Y
        StmYfY9hCAvK//DhI1qMM2nDt80JRdS0EwV1K+3s4uTYpoyT
X-Google-Smtp-Source: APBJJlFEYk/bqYGyuJAaHAL1JEWuUOwkkcZpbbHJ/FVewEDv5hVdmh7chgIV5DaFhIO4BzQtyA3NJlRpkIZDZVk0K+a5hwacR/az
MIME-Version: 1.0
X-Received: by 2002:a4a:4f8b:0:b0:569:d5ae:eb6e with SMTP id
 c133-20020a4a4f8b000000b00569d5aeeb6emr495681oob.0.1690327949950; Tue, 25 Jul
 2023 16:32:29 -0700 (PDT)
Date:   Tue, 25 Jul 2023 16:32:29 -0700
In-Reply-To: <0000000000000ced8905fecceeba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002c74d0601582595@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
From:   syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
To:     alexander.deucher@amd.com, davem@davemloft.net,
        dhowells@redhat.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122e2c31a80000
start commit:   [unknown] 
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc501b7bf9e1bc09958
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f71275280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11081055280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/amd: Disallow s0ix without BIOS support again

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
