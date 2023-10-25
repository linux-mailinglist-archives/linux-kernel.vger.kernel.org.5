Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C667D6167
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJYGCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:02:34 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7AAC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:02:32 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e98a9dd333so6534998fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213751; x=1698818551;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wii8E7zHSEDik3+/ZAl9Uy7hVmIz0evyew93pf3levg=;
        b=JdS4SgCG6m/yo21E0aB+lghcSFjhr1nk6Gq6KVLoygzNfmOR+9oH/bjpW1mD6DutVF
         m+eZ9HNMR7N++KsXNDkcIVINNQ8N5xE+oN6N/Z9qAA7o4X74pkWUZucKG5afFZH32bG4
         8+gJzZlPrt6172sZsEfrWxoDZxVMtlaqBZXlFr5p8/4nZu6gqdPqf+x7ECmFyKlxjRZe
         /SwJDi6yszyeMJ+Uw/MsO3ottNPrtH54XgBOkbjzJZc7nenj3W2bcEPXIQtNQtbXquA/
         gq+xAJ4q+On3/Ul0Qfr3pFG7Eow6eh/D0gLgYDx5z2ejR1B+NT2wp+d2WWg1kc5FDkSa
         i/Nw==
X-Gm-Message-State: AOJu0YxU45n6+rLmgklLFKpddZvoitAzf9jHV3Ve/Yxu0wJKvh86tvcm
        FatF500ICQA5ZlQxt3hB3RaFMlx/J9lWlzpAOqYadjCVTMWy
X-Google-Smtp-Source: AGHT+IHssJml8McZlRux6ZXt3VOeHacpOyLeRKgWH6j9CJmj9sveOQS0uWJF+F3U2CxWMMjmBub9b2Hx+0PMCfEE4WJkoUN7Sz2i
MIME-Version: 1.0
X-Received: by 2002:a05:6870:472c:b0:1e5:7978:9ce4 with SMTP id
 b44-20020a056870472c00b001e579789ce4mr6743294oaq.11.1698213751574; Tue, 24
 Oct 2023 23:02:31 -0700 (PDT)
Date:   Tue, 24 Oct 2023 23:02:31 -0700
In-Reply-To: <000000000000e8364c05ceefa4cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a55890608843368@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From:   syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 259bdba27e32368b4404f69d613b1c1014c07cbf
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Wed Mar 9 12:04:16 2022 +0000

    vxcan: enable local echo for sent CAN frames

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a2e55d680000
start commit:   84186fcb834e Merge tag 'urgent/nolibc.2023.10.16a' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a2e55d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a2e55d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c6300d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6935d680000

Reported-by: syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com
Fixes: 259bdba27e32 ("vxcan: enable local echo for sent CAN frames")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
