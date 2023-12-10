Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE180BD60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjLJVh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:37:58 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B56CF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:38:04 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d336d8f91so4461320eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702244284; x=1702849084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxbULe4PoOvzjabcg4fEcKZ0w6jpN2DX8HCoWUa20UI=;
        b=Qe/v0+9k4QScHznsJ+radntrlZZBoGJfjjgynCMsr7p1aiQHMF1/49g/w3p57Ppl2N
         U7em6T8FGIG2vRzLKUgeCcAfS1DGPiW3D1pqe9PnfZg8tnBLjIMZmh04ypwZAxFFcDyw
         WTDevmbvCSdQ+J17c35AyLvD2EO1GCIgkz0fstHjEz92r3Z7n8c0Oi6XwKRpkPapvsZp
         4iFrBy7rU1oybrpM5dH+W6lvLmGIB/jQpTbEXtPFkbrWt6EK4r0ytUIs4LoZJh3JKDp/
         a+gYnmeE7h7Gwlc5jlTaRDwfjARxFVuiBaiXUhRLqN0HZ9CLvc6lkgAEt6ZGLzT10Qvu
         0dWA==
X-Gm-Message-State: AOJu0YxFFWBo4Ap1OUAxAqzxOHMQ+yaC+t0bSq8afEo8GH/H+abGaRTy
        WeK/TtXsTPnfOAxhIsC/2ua6dL5/RKNq2jLnC1DJ+qkL7p0Y
X-Google-Smtp-Source: AGHT+IG9DQLdvnLT0V8GX0PFxpAMf98FGEWIzJmw6MJpQyI9/LylpQvIZnjj43QjmR+t8LtI3LBVYY4Lf7uVAvGv+6QcNI9rEgwO
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4105:b0:6d9:e284:81c5 with SMTP id
 w5-20020a056830410500b006d9e28481c5mr3333431ott.2.1702244284139; Sun, 10 Dec
 2023 13:38:04 -0800 (PST)
Date:   Sun, 10 Dec 2023 13:38:04 -0800
In-Reply-To: <0000000000002e8d4a06085267f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e08cbb060c2ea1ca@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_read
From:   syzbot <syzbot+9704e6f099d952508943@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eadavis@qq.com, eadavis@sina.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com,
        wojciech.drewek@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b714ca2ccf6a90733f6ceb14abb6ce914f8832c3
Author: Edward Adam Davis <eadavis@qq.com>
Date:   Tue Nov 7 08:00:40 2023 +0000

    ptp: ptp_read should not release queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10477d6ce80000
start commit:   4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=9704e6f099d952508943
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17233388e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a3f898e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ptp: ptp_read should not release queue

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
