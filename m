Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246D4751D68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjGMJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjGMJh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:37:29 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E926A0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:37:27 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a337ddff03so932692b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241046; x=1691833046;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KWHPeqYs83RLpJCQk4X770LmbcxpeUbYJZczIbA8Zk=;
        b=CSyIY5taus/tzGSFJRwl012ZqZfQMioyn7M+tkV/KFq+z+iwFp21HrfkEQi/OhA6FF
         uhN4hlHRQ/6KghB4YemijxZpe+itVQIAI8wi7B+Ihw2Ba3JJ7/OOujjHqGyEJuNLZCh5
         H0RCepPrWi1NHN4vfE6LjTCrLTHEl2MpUdv+ikpafzU5SNO8NbpEIWFj++el8hayKXr4
         BG7G55MlBDDt8wm+z1gXovo64E7aYnoJ9MSoOzxzazFwS38TeosDXg3YWlW4D72p61jm
         1ISTVSXML0o2OBAKdeG9HhZSO9eJ0m5cUzug9loAqVFHVsKDXhbe1PASsiJgN13YGURa
         wrLg==
X-Gm-Message-State: ABy/qLbpyB6vGvrOOQiWpeRX/U73xSBbLp05gxaCqimLgsjLVlHLGn/G
        j/p2kIzDKr+dKM5omQZOOw4fx5fuT+tBMBjAuz2x1wMBx89g
X-Google-Smtp-Source: APBJJlFZ+k3bwHzCz46y/eYpJf6R6cCLa5axYPD6JDKJCB12y166+xp558SQKzwK0Dlpi5J58QXr8+KIEBjNH/wOYJLzmbq9lEL4
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1592:b0:3a3:c493:b971 with SMTP id
 t18-20020a056808159200b003a3c493b971mr1397311oiw.7.1689241046552; Thu, 13 Jul
 2023 02:37:26 -0700 (PDT)
Date:   Thu, 13 Jul 2023 02:37:26 -0700
In-Reply-To: <00000000000009408f05e977da5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085151506005b1491@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in d_flags_for_inode
From:   syzbot <syzbot+2f012b85ac8ce9be92e5@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, hverkuil-cisco@xs4all.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c43784c856483dded7956175b5786e27af6d87f1
Author: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Thu Dec 8 07:51:32 2022 +0000

    media: v4l2-mem2mem: use vb2_is_streaming()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e7d1bca80000
start commit:   4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=2f012b85ac8ce9be92e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17834f9a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10edf526880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: v4l2-mem2mem: use vb2_is_streaming()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
