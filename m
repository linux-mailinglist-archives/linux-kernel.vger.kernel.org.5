Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5A7E1C63
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjKFIec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjKFIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:34:23 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525AB184
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:34:08 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2e7b41beaso6190712b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259647; x=1699864447;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R//xFC6MCX07YnTjEGgkyVytVcMHK0VcX9I6eFXmSn0=;
        b=MaX1gcimdpFlLxYsX7H2qI90rWZWq9UyKGWRxSBh1XGnc1AySSgxRNQQXnMXPgYbqr
         eBWr6EyONLYhjBQv/9JO0W+tZ/80YRCYxGVtQsqXacIB8rR1vXRRXc67dPlIISvp7Mwq
         cUO4bAVLyBLBTybok584eACFgSOjQiRH8EN3+fXZtW3eCIEDcFQ1qnHddmo69y4DFERk
         UpoPCNRCDd5s8BzaYObUX930Lbi+k0fcLEW8PE0ihVyZP5GJx0BxkEaAZ2rJjWyyp7Dg
         wunaltRMhmZweAqr/LZtvMdjrFLZejq+ieG3cS15wLi7UaVqUvvzEYWbaBlJLHr7tx2G
         yZcg==
X-Gm-Message-State: AOJu0Yz4vcxMYSC5rdUN9n06MDJKb0VO1l3en0vt7xotH01xMOypcsFj
        /Ms8VXqg3PCRluLzjEN9g7/qbUYL6qM71xMiOLgVvVvGdi6o
X-Google-Smtp-Source: AGHT+IGPvdUMp7cFbFWrKJV9OVBnXNdZFxJ2Ar/n96qlK/oegdaqwZk7Cnt4qpgL2n4nuLJ0ela54eQb73j/dM3UYdnpHggAwsHn
MIME-Version: 1.0
X-Received: by 2002:aca:1113:0:b0:3a3:c492:9be6 with SMTP id
 19-20020aca1113000000b003a3c4929be6mr3745348oir.2.1699259647315; Mon, 06 Nov
 2023 00:34:07 -0800 (PST)
Date:   Mon, 06 Nov 2023 00:34:07 -0800
In-Reply-To: <000000000000cfe6f305ee84ff1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8d8e7060977b741@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From:   syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri Mar 31 12:32:18 2023 +0000

    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d0b787680000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d0b787680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d0b787680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113f3717680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154985ef680000

Reported-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com
Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
