Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A175B97A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGTVXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGTVXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:23:36 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34BB26AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:23:34 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a426e70577so2612962b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888214; x=1690493014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7KWzfTm0PGl9M6f8vdarv2h59an/fU44lp1Ve8prEo=;
        b=D2CvAUsx3xkjOM7dK84YtjsD1P5AKDSVFxjq10PDJ+HYXMjqqdTzDYihmZav8g1XfP
         xqqeGrqL9TyGErNhlDWFtjrpZXFKiTB5s1bPDZtWwHEvisObCBaPch3PL2GoZC/CDEd3
         TmmmcP2iyB6yXDe49/N/lhPZNueENPSP1wC2ABAxHL2pqZEy4HKfwIrVUSARwAbTXV7H
         z58n8m02kFq27eRtyPuPQIJuiajbySpPZcSj1LDQUF2uH6AP7vjCSwFStzj85HlmOBSI
         b7LvxIq3Lnrci2n1PJBe4qmpv1AAebVRFI+Rk4YPu5OP0Y9aN+FDYgG2FgAJjs/XZWzu
         av6A==
X-Gm-Message-State: ABy/qLYAPFKgEYBZAvU3pMe8bV1vlUL3IJMfDl/TifCEkR59TKCQi62m
        eINIMMIbDkxXfHYGpeewGDevjy0a0Eo6EzA6BtzYQBC048Qv
X-Google-Smtp-Source: APBJJlGHzbDOfITCcrazhMrBDL0FHHT9WhSmJ+/AhhtZeN8BLt+YJtpO7j2pEEsEzEmOk5iQQdWIwFqCs47N01yTHFwM18ZTC47y
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1590:b0:3a3:8cf6:5edf with SMTP id
 t16-20020a056808159000b003a38cf65edfmr153990oiw.9.1689888214048; Thu, 20 Jul
 2023 14:23:34 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:23:33 -0700
In-Reply-To: <94eb2c059ce01f643c0569a228ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b566c50600f1c206@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __netif_receive_skb_core
From:   syzbot <syzbot+b202b7208664142954fa@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alaaemadhossney.ae@gmail.com,
        ast@kernel.org, bp@alien8.de, bpoirier@suse.com,
        daniel@iogearbox.net, dave.hansen@linux.intel.com,
        davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
        elena.reshetova@intel.com, glider@google.com, hpa@zytor.com,
        ishkamiel@gmail.com, keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        makita.toshiaki@lab.ntt.co.jp, maloney@google.com,
        mingo@redhat.com, netdev@vger.kernel.org, rami.rosen@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tonymarislogistics@yandex.com, willemb@google.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13dfaae6a80000
start commit:   03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=103faae6a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17dfaae6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=b202b7208664142954fa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cc32e6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aace14a80000

Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
