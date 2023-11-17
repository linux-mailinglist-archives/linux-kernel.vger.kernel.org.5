Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8687EF736
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjKQRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjKQRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:44:09 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E20710D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:44:06 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2803ea89cefso2892643a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700243045; x=1700847845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBNIQ0OyWnUUYf+IOMPIqQdftw554+6MI/vYVRG86Dc=;
        b=fl5mfSmUtKBGyaz7MNySsMK2wfUuoGA/g3bkZWOc0tBvGW3rwk8/inmn3dHgnd7bLf
         AvKkMtiP2rC3aW2uRY2ky6WHkdfs5eWEzxmgC5M1XiITs/viSBH/ON1vh0LHlZQrvmrl
         /Krzjucg2r/qHfhXQjUfFIxQX9FPiRkEAsU4JveGmy/5S5ge7H2VXplF9o10eaKc2EGh
         Av2EG6PslJuFgC7jU60UJsaiXHmnIIrwVkrmITCHeFIGhActHzxlGy5QcUo9mHTUM5Ol
         Qy+aBOQYiwGhLlB8gYzy75f2TOWhTcSaR7zta8tpDx0EL/+C6/4Yul/Ul2Wl2HQxGEly
         9eOQ==
X-Gm-Message-State: AOJu0Yy0dTlPQN1MzsFdPsPFpD4sKFG2+ZhhnVMrJhf+aPjhO8GCh4rD
        frVs1X2a3GXCeePutpEsmoEweciu04pox222cgUw3TizXIL2
X-Google-Smtp-Source: AGHT+IEGvinZzZUXWT8Abzqsa0MheB9XXEtJaQ6LA8XenYwwcXM2fxrpX1ls5/LOD52S1ncv/pPluiYNAaA8RLBBOot8+6XLgCqU
MIME-Version: 1.0
X-Received: by 2002:a17:90a:be03:b0:27c:f438:70a4 with SMTP id
 a3-20020a17090abe0300b0027cf43870a4mr26773pjs.5.1700243045768; Fri, 17 Nov
 2023 09:44:05 -0800 (PST)
Date:   Fri, 17 Nov 2023 09:44:05 -0800
In-Reply-To: <0000000000009cd5bc060a430d80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c667ce060a5cae75@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in __lock_task_sighand
From:   syzbot <syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, longman@redhat.com,
        martin.lau@linux.dev, mhiramat@kernel.org,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        oleg@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wander@redhat.com, will@kernel.org,
        yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 2d25a889601d2fbc87ec79b30ea315820f874b78
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sun Sep 17 11:24:21 2023 +0000

    ptrace: Convert ptrace_attach() to use lock guards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144ac400e80000
start commit:   f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164ac400e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=124ac400e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf93299f5a30fb4c3829
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125ac3c0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c4d797680000

Reported-by: syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com
Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
