Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90B775DAA3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGVHi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGVHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:38:25 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6066D2709
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 00:38:24 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a41b765478so6430938b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 00:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690011503; x=1690616303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BFg2LH8Kt+Y3c9UeEmRjI3v36opiod0X7a7OqprL1w=;
        b=VhfxBg7TWkksLKhZu7OiZOpQdzyumHGpJhclGasYzGQgrkjqjAWqx4PvMZ+Zl7B1d4
         shMZnULzo/4Ps/Uexvup7IsycAdxe+WmVCfO9eTKNNXcUL6WV0R8fyN5ALau0q6kw6Wp
         9FynDt3z2dtB3iw6IrKeIluL6yxe8FI2QckulLo0C2CMhrtf01H4VhWk3k8ogDj7i/8E
         VM7MByiYkcK2+EmpOCUpjFbZb14qrujprSTMKfazsQy1CGbGanEYkRUNG4rkF4Z38MDw
         /Sdi1P4ZLd2G2EfAttu0XKPZcecJhfjbVGnlnysj/vAg7tdTltZaZ4zXmkJQFYgGGWFm
         bPwA==
X-Gm-Message-State: ABy/qLYXN0JmnQJhryc5rYiWRPAi6SAA1I7bBqTdvqXOZHDAfnb+javd
        PmzfALFI7WNwuv0geynkGiw0D4xO56B7ZR6vSYpMz0OBiP+u
X-Google-Smtp-Source: APBJJlFeQ9rTgJVx5HyLmSJpNlRbWCk+M1T+morzZu/Q46jYvl0lP3UogNHWfrcfn3SNh8HkfE4neXOsFzAXAlas+4IBfWvkE0lB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3097:b0:3a4:8ecb:1878 with SMTP id
 bl23-20020a056808309700b003a48ecb1878mr9381158oib.1.1690011503647; Sat, 22
 Jul 2023 00:38:23 -0700 (PDT)
Date:   Sat, 22 Jul 2023 00:38:23 -0700
In-Reply-To: <0000000000004386940600eca80d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057611806010e77fa@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in ingress_destroy
From:   syzbot <syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1568abf4a80000
start commit:   03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1768abf4a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1368abf4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=bdcf141f362ef83335cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bf2bf4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12741e9aa80000

Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
