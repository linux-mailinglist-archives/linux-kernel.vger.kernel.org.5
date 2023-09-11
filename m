Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1E79A1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjIKDVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIKDVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:21:46 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1C1704
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:21:20 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c1fe87fc29so54584465ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694402433; x=1695007233;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4OuRM609g3eq/BDoCt6DMvpmlD2v3iorytoEJhcHX0=;
        b=Bh5UPGlF2PDfmwWXesBj/zrREeO/uNYn6rrA4xX5yN4bNGo6zEW8xWPgResLVYhLOA
         JxUtG90+yZawbVHFfqYyJX29Hiyyrez3rQynlSRZarn5eQLApeBVRgm2F4l1OuO1dEoO
         jkFKSdS18Mg6adILJr1vilzAUrL0np/bp3o5Pf9p1j4d/tn3lzNfX/6/070/gaMZ/vfQ
         IhuTSM6Atal3wmFvYgR83dcoHafLOOdqjjizJ+XTBH/41Y9zuc2Dk3XQlbgwa4JDbLMu
         vyVLKGOBSLqY6qjHYoBS9sB4XvutY9Z3LKPjOPRIdI0TJv5uM1+RT4gbUwEe5dcds9AS
         5/JA==
X-Gm-Message-State: AOJu0YxIL8mTF+XHj6q4n/KwcnfqKx/qSMDaq+hfLudKVOyuIb4wKdyE
        zdZJDaCGIr9Z2Scr2XxYQW3orpwFfCmhiOqQBey7Qab8yw7x
X-Google-Smtp-Source: AGHT+IHRUg35zIadDvCGBfPKRpdkW+2NPxInxnjs8b/1veDjIPayc7a6JbpKwwlfG/YfzHv403RD5PEtNAhY/bmS7JZHagSLkQT6
MIME-Version: 1.0
X-Received: by 2002:a17:903:1c7:b0:1b8:3c5e:2289 with SMTP id
 e7-20020a17090301c700b001b83c5e2289mr3472447plh.2.1694402433630; Sun, 10 Sep
 2023 20:20:33 -0700 (PDT)
Date:   Sun, 10 Sep 2023 20:20:33 -0700
In-Reply-To: <000000000000fcf6d705ee1d8947@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029cdd406050ccfff@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in do_chunk_alloc
From:   syzbot <syzbot+88247ec7a18c953867d5@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit cd361199ff23776481c37023a55d855d5ad5c0f5
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Jul 31 20:28:43 2023 +0000

    btrfs: wait on uncached block groups on every allocation loop

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1582bf14680000
start commit:   eb7081409f94 Linux 6.1-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=88247ec7a18c953867d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b80ab1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dd6d45880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: wait on uncached block groups on every allocation loop

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
