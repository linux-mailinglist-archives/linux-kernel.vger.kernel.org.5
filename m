Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57437A15BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjIOFtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjIOFtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:49:33 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07552710
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:49:27 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3aa17bcf306so2309779b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756967; x=1695361767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXDLU6GhPRgxvgHhWczS2W48hUEzfbdQ+kiAI/fzXHg=;
        b=QXqGWRaBytulVHHAudvrhY5Jzw8SEAKIwZxS/2BPmS2/lq4m69MA7rp3BlMdPcoFOB
         NY++G/TR0BYrGLxW3aSdfvHgmEUwQRsBgZsGT9vxJ/LCSEr+OwWbJqoJP6kL8YX9K973
         /hq97NDB2BpaiSI1Y8dWxRXeTx/vBdvf/XpN0FGEdpbdSBqHh7M2iZCjTej2cgddhf/d
         AGl/1wwaEV8boVVT32AlZ6RM94NmaFpsFQ8uLd4F/KExxwEnJyjsayHvY3C9M5JxPZ/G
         m+GhVlfLjAe6FWfXeFiMpOrrh73xlA+f6AKrI6AAOinaDokOC4lnC/HwHQPxmSkR1vGD
         6WJw==
X-Gm-Message-State: AOJu0Yxlt9sdJsbIoEVtWAvvXPRPlptsOhjfxI0OKGoz/tvL2Mwm4lVo
        yIv6zzHZLx6Et7Z6G6DPyH6uVr/6zAu5XiLdxzRJjvy6C1jx
X-Google-Smtp-Source: AGHT+IEK2iRnTBP7FWvcpup3PZIp5C/uidyAVstqvSMHqPBS3p8eOnCe7wZYxiiKDvJ4/y6F7OlBJBSHymT20OCuq70KuwKnRc0U
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2115:b0:3ab:81e4:4d78 with SMTP id
 r21-20020a056808211500b003ab81e44d78mr311949oiw.8.1694756967306; Thu, 14 Sep
 2023 22:49:27 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:49:27 -0700
In-Reply-To: <0000000000000534da05faa4d3d4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000045d4d06055f5bff@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_write_single_data_page
From:   syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 5079e1c0c879311668b77075de3e701869804adf
Author: Chao Yu <chao@kernel.org>
Date:   Fri Jun 2 08:36:05 2023 +0000

    f2fs: avoid dead loop in f2fs_issue_checkpoint()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15aae552680000
start commit:   c8c655c34e33 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13130a1c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d919f8280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: f2fs: avoid dead loop in f2fs_issue_checkpoint()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
