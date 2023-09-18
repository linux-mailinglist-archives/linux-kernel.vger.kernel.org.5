Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F817A3EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 02:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjIRAFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 20:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjIRAEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:04:40 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B65FE
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 17:04:35 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1d66d948417so4135720fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 17:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694995474; x=1695600274;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plqiVhsHQJW/q4sf5YkInYlIVvS0lexxFRBvtsJXFDw=;
        b=hofDj4mMKTExkdxbGTK11UmgGgI05zOJSEvOwbVcGSVefRMUl6Vz9LeNj9s6wE0an2
         cuENyXODI9Tqacg/DmPQPMqUSBX/UBZLmq4mQSzH2q1NOb/PcdlWtRQGBwO+D3nBw4lE
         /2QxQDcD25Z78gccSENC2WRT7IC9B7j9HtDfjJ48hxYb4do7dX12Edn5zFO7Rl18aSEN
         XobrlpFFD0oLUsLfdcNGPWxcIsGyXqx0MIR6L47PD4eGUIeLiKDMWzTEvH02WJSy9ePT
         RSC1EAebMSV6L4LrI1IW6VcZfu0k5cBFJU5AtBLOnjJFrRZG914bgRkt63ZH2dxkBis0
         P+8A==
X-Gm-Message-State: AOJu0YyMfcKMo6aoJ1Fi9f2lg09100THMAK0TYCD/ZO84Rk5SvxEayH6
        NIoNvkm73dEhWOckBwlmdI6z6EKhvFeDd64ZDzPcZt6Pdaxv
X-Google-Smtp-Source: AGHT+IH/zkGlEDq9VbJg97gGt1EgLfqWnEVJ7h5xnIpv8Ku68gE0DF1eHR9jFI017KdKqlc7/TMCj9QpD4KDhKZQUzCLionLJESV
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7ad:b0:1d5:95fc:2a7f with SMTP id
 ed45-20020a056870b7ad00b001d595fc2a7fmr2748642oab.7.1694995474388; Sun, 17
 Sep 2023 17:04:34 -0700 (PDT)
Date:   Sun, 17 Sep 2023 17:04:34 -0700
In-Reply-To: <0000000000004f34d705ffbc2604@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000259bd8060596e33f@google.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in d_path
From:   syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, stefanb@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
Author: Jeff Layton <jlayton@kernel.org>
Date:   Mon Apr 17 16:55:51 2023 +0000

    IMA: use vfs_getattr_nosec to get the i_version

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106f7e54680000
start commit:   a747acc0b752 Merge tag 'linux-kselftest-next-6.6-rc2' of g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126f7e54680000
console output: https://syzkaller.appspot.com/x/log.txt?x=146f7e54680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1671b694680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec94d8680000

Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
