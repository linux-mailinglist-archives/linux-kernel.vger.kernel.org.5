Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDEF77B850
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjHNMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjHNMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:38 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1510E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:08:27 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bbd260ca2dso84936255ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014907; x=1692619707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJNRfP8cUatIsJc6YU7EUPAo/O9QZ6sb5iejP2DNk7g=;
        b=bBK1lL9Rq/eMAw64jVsLBGQE6/STLGjYG7Wfe+v9mETF4zMrt2Qhhv1U7tvwFU/u/3
         /MwvFBHa6WF3Vlo54a8fOyAtj5mqsS8JZBDXzxjrlMnR3Y8vd+jspaM8nWWd8tHAmgoC
         nzy5ob8ICci0TxBwbVRxvMji6BulfR/N+yT0zJEFHSD2xJXID6u2LUEBDKcIT7FDE9aw
         lpESQER5zzxB4KsQ6D+Sf86Nleon+LRxTWXA628XnchWkWj0b/Qv7kjAgtKmTktVCBoD
         4vBDH5FLJG/esG51/dZihr8mMFNCnrSE9e7TA41csD3ySAd7641hUxGjyQ6V7KTJJljc
         G8XA==
X-Gm-Message-State: AOJu0YxXm6ScdZctz9Mb508JPGV/6EehoV5Q04nnv6kuMhXSNctKbtcl
        NWpZ0tZhRxO0eef/B9eF3qYgKOA1Wd38Ne+qNtpoidogAOnv
X-Google-Smtp-Source: AGHT+IGfcIkUiHrqX6S1IiQDnpfA7pI0z5lomwAUYnqquL64y/gfrx5YhhnnQ+4btgQR6c0hoTwQIEUozbHJHcQ6cTPptARUW4Gu
MIME-Version: 1.0
X-Received: by 2002:a17:902:c94b:b0:1b8:97ed:a437 with SMTP id
 i11-20020a170902c94b00b001b897eda437mr4164664pla.4.1692014907452; Mon, 14 Aug
 2023 05:08:27 -0700 (PDT)
Date:   Mon, 14 Aug 2023 05:08:27 -0700
In-Reply-To: <0000000000000e4cc105ff68937b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083735b0602e0eb7d@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name, linan122@huawei.com,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nogikh@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        trix@redhat.com
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

commit f1962207150c8b602e980616f04b37ea4e64bb9f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 4 13:37:32 2023 +0000

    module: fix init_module_from_file() error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c80763a80000
start commit:   995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12219fbf280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278c8a4a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: module: fix init_module_from_file() error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
