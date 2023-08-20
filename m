Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC88C781F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHTSl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjHTSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 14:41:53 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440391BC1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 11:41:24 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5637a108d02so2754288a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 11:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692556884; x=1693161684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/n5kjMvYzdRUXwH8feZ+4YEm3skk2x5QaWimKw+DCM=;
        b=CMQVGVKKQRdv6jyxE7TW5LSyDNIjQagknnkgBcpJyjQvWtbGIPD0ORYvGUyNYffUp1
         DWzpHHfae33Z146Az5TMe1zHo5stKO5yWZK3IA99+txCEhYh/PHVPa1QBwNve4VVTmP3
         XHuvY+qZquLEyhvHbhdNd+aUAlapQ4JNEn/zVeNUP5tVljZTDgqUIOHpPrCLGvOpw8LG
         XOc9E3LWpz0aHhDpc7V3m4p/NkTI09pVdfdPaL7gvcGkXC9mEq6lOgOACkrqONjlrnVG
         LBK9ecIoPOKgvx3QgmjuqcArpsIBUitoBHNQIFVSCJchGX2NCxcztTsIwfd6yz5++n7w
         sJZQ==
X-Gm-Message-State: AOJu0YwuCj6mqSLb8KDPk8/hHMjhEI13nC1cGDmQ9T2XcXJSb6vBuwvB
        yhsx5Y+FXjpThjE6sHxjO2SGWU/aqBElt47o4Hiqgrxu7WZD
X-Google-Smtp-Source: AGHT+IG3eaeUAH2EW45k/+HZjIXX99Q9piV7GARJu71AM1i236ME0RtbJCZz+N43b2fgb4vOTwTGQxFuzEj7n5oY0lhEjCqFkOik
MIME-Version: 1.0
X-Received: by 2002:a17:902:c449:b0:1bb:b74c:88fa with SMTP id
 m9-20020a170902c44900b001bbb74c88famr1918271plm.6.1692556883825; Sun, 20 Aug
 2023 11:41:23 -0700 (PDT)
Date:   Sun, 20 Aug 2023 11:41:23 -0700
In-Reply-To: <000000000000dc83d605f0c70a11@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d299b406035f1bbd@google.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in folio_end_writeback
From:   syzbot <syzbot+7e5cf1d80677ec185e63@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org,
        konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 92c5d1b860e9581d64baca76779576c0ab0d943d
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri May 26 02:13:32 2023 +0000

    nilfs2: reject devices with insufficient block count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170c6337a80000
start commit:   929ed21dfdb6 Merge tag '6.4-rc4-smb3-client-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3da6c5d3e0a6c932
dashboard link: https://syzkaller.appspot.com/bug?extid=7e5cf1d80677ec185e63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb3b69280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f34201280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: nilfs2: reject devices with insufficient block count

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
