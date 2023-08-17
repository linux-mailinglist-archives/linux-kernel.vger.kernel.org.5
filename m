Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1677EFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 06:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347999AbjHQETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 00:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbjHQETo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:19:44 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2970272D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:19:42 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26d1f0d9b3fso257409a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692245982; x=1692850782;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5174e1lhoEtAOJSx6OzZg8YIf4r3sHHxcBtCy/AqYyo=;
        b=S+dI6AqSytXQGH4sc4ZZaCzxkIEI0wLPzGKAveeDOQ4j30tSgvHI+/v5SwYm7GZuVD
         YKbg9FEfQ4VEZjKbCWikP71Gtoh8mnWUqtHiRWxl16pUCxzeFVVghtlTlTQCx2VSJo7e
         zSfxrXdo61EyzFpXB0Nv2fIGtx+rnYjGYQj7ZITGKTAJ4tuz9QEZkv9WrqP3GIVn0khh
         hqLKRrhaJZTMKZ23spMfNVxXBtUcbAMiutrKSECrv0zYegKLhiKnU3L3eawbjUi/L3CK
         clbnYKLXwpw1iZcHHfp/uLIxDnvW5dfe2zI7trWARxD0KBZj2bhEvy3aB6PIXhIuHjLn
         i1SA==
X-Gm-Message-State: AOJu0YxK2BQH5A6N6rCgVectq8DHGMr1bfZwDsPNpwIKrAqfIkyjh3+q
        KHqbASqqAV9/B7eCcJVc+KjbV7tSyosSUNjRrw+4lUAqmTRV
X-Google-Smtp-Source: AGHT+IEZTSdaa9kcYRvTXFZpDfiX5p9rZQWqGwpWUOdqE4TBv2CeMoaYVGf46u3LVELNCiS2dd8ME/kduWdrJuI3NqGAvxNOuL9V
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c901:b0:26b:5182:d042 with SMTP id
 v1-20020a17090ac90100b0026b5182d042mr837650pjt.2.1692245982314; Wed, 16 Aug
 2023 21:19:42 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:19:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a60932060316b8f1@google.com>
Subject: [syzbot] [net?] WARNING in dev_index_reserve
From:   syzbot <syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
        john.fastabend@gmail.com, kuba@kernel.org, leonro@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 956db0a13b47df7f3d6d624394e602e8bf9b057e
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Mon Aug 14 20:56:25 2023 +0000

    net: warn about attempts to register negative ifindex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f68f03a80000
start commit:   950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e8f03a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=100e8f03a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ba06978f34abb058571
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be0117a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14950727a80000

Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Fixes: 956db0a13b47 ("net: warn about attempts to register negative ifindex")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
