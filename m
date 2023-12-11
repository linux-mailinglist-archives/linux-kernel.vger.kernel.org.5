Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC380C0BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjLKFhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjLKFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:37:01 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE7EA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:37:07 -0800 (PST)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58ceea508bfso5287955eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702273027; x=1702877827;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJbhLWpc9OcAqNfWslnsCcj4qPU1N90g91QqdKjuBf8=;
        b=xEISYqOQZe7HaogqxyPsIOa23Pb4QhXXUAUbxHZcKGVxHKdKz7mq/+h9ie2aRPoIKw
         mkGJf1X3RB3UEh9MWhSpikoFtVXlru7xVqs1B601cozoKG71Te2OF6+irj9jTMY7Hgsl
         8aPlbOIBjgOaFTR6Y8pMgp8eWODB+E3fvwl/AwEbYHVqn1Dxc086eJkQhqCwZxk2186r
         yCbvG23434ssVDsggSuFTCrJYf6NQ+XplbyHI/l2NDmuui7829TLfD0ltKGrUA0r3vaI
         QuvJSFfioLcYRXDANz2HYYxYD26CYsGt3FJJH6aGpBLOl5uXNQkmWJDTM3urQtvO0wFm
         UngA==
X-Gm-Message-State: AOJu0Yz9aHf404tZ47/PwsivMN+imZ+AMP6ciDHLUeYAshKcnsDZZeJI
        XsQbIhbulKVyZvXZmevwMzhEZsMxUBSdeYi6N7AD9nRpvAYw
X-Google-Smtp-Source: AGHT+IF0QKBJHNms6LBgAbPwdjaDNpi+9qFHPWR90i5Swotv9xAtzPKQBk0NY3XZAQo+zgWzoWm3AGQ20nIPV55fiqKeJNgwSrc3
MIME-Version: 1.0
X-Received: by 2002:a4a:3146:0:b0:590:7a45:da4c with SMTP id
 v6-20020a4a3146000000b005907a45da4cmr2707681oog.1.1702273027022; Sun, 10 Dec
 2023 21:37:07 -0800 (PST)
Date:   Sun, 10 Dec 2023 21:37:06 -0800
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000162818060c3553cc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From:   syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eadavis@qq.com, hdanton@sina.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1bea2c3e6df8caf45d18384abfb707f47e9ff993
Author: Edward Adam Davis <eadavis@qq.com>
Date:   Tue Nov 7 08:00:41 2023 +0000

    ptp: fix corrupted list in ptp_open

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=145ba76ce80000
start commit:   6bc986ab839c Merge tag 'nfs-for-6.7-1' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cc14a8e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ade40f680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ptp: fix corrupted list in ptp_open

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
