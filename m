Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B65768202
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjG2Vpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 17:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG2Vpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 17:45:32 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343452728
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 14:45:31 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a71ea1f049so884857b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 14:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690667130; x=1691271930;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDD7lBaUGQECpMU72tfu3mMnPARszpD6EFSI+7RFJss=;
        b=Y8ZTjw4Vtx5lhsIOjX/3LcpAXaftV3kRaFshz0P6nzDU0sYNQpK7pewA4r8dTCCjp+
         L/epCNTApTl3WQOvcMp/3QTHzQ9/S3MGOSQv14y5sWh+kKCf31KdwgXYFW+1VDBJJx4p
         2ShPydCv0QzmG9wQMOBy9sWc8ZwxAbbUunEKQGhOvDGg+BXcR8xUYfHlPvNiwWdSrlZ/
         mbBxNS6dHvd6O8x18RAcPRY3XK9d6gEBt6TWVsu/d6AGz1XNecoMssNFQll5nA1UQ6jI
         ZbUldS6n3D7QuP+5Oi+oGQFL88WTT6s+4QFlzRGtvpww4bjfgRndcPLGSn/lUqpw0lG7
         8PiA==
X-Gm-Message-State: ABy/qLa6nTO3gL6tXCiBR7cVRCvvpoasbYESSQGLB5XSyc3KF7TsDaL6
        szBSy5s8hSILKG8hrkiav4DWuw93UG/JWIbbjIgSPUX2CmP2
X-Google-Smtp-Source: APBJJlH5ZPjzXV3ZUe4Bde+i6V4hpNaN8GWgh9u6iM0hmCP80aqcYNvuigNen5gbLQx/yhE0mBObVyy2c2tw7cH4+e7cQwWRd+qP
MIME-Version: 1.0
X-Received: by 2002:a05:6808:ec3:b0:3a7:361:f50 with SMTP id
 q3-20020a0568080ec300b003a703610f50mr7325479oiv.3.1690667130455; Sat, 29 Jul
 2023 14:45:30 -0700 (PDT)
Date:   Sat, 29 Jul 2023 14:45:30 -0700
In-Reply-To: <00000000000091164305fe966bdd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be8b800601a71d81@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in emit_fiemap_extent
From:   syzbot <syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, clm@fb.com,
        dhowells@redhat.com, dsterba@suse.com, dsterba@suse.cz, hch@lst.de,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit aa3dbde878961dd333cdd3c326b93e6c84a23ed4
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 13:49:54 2023 +0000

    splice: Make splice from an O_DIRECT fd use copy_splice_read()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dc6319a80000
start commit:   40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=9992306148b06272f3bb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c65e87280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094a78b280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: splice: Make splice from an O_DIRECT fd use copy_splice_read()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
