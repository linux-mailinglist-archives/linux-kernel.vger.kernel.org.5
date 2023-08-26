Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D004778986C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjHZRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHZRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:33:45 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872BCA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:33:42 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68a628f923dso1859827b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693071221; x=1693676021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjVLdoMeoNBHxjD3Hv96x2He0s6aP5eRpCyA9UAuyOA=;
        b=HIkqhfxFhYrOAQ5LUjNQH1cqvJDk7Az9KjglRBZYD9z28HREDyO9TU0kItg0L/G5ZN
         9oa4BN6tRvtSrJZQ4aP5EBzTROH8tgXDoeOvL9ltexnD82ctIQxjWeQ+JU94K/vP9Giu
         WkcRS+fvSsH0gYXU7cFgaj7O6mBYPWgcP+UjjgSew9Ec+ObGm5lA13JywGUTck03hM3f
         DOOb0KKeux1w2Y2Y0hJMM0Y0YeQAlAYFylGLqJAWDu7epVTc5xyucY7rSZYmZ9g8KZK2
         9q2CMhp++ZUtYV8DX4u7OJUv2bpXLyC31S6r0fJvfYbnxifF9MRWw1OFTdNCkDTCwWNe
         e5aQ==
X-Gm-Message-State: AOJu0YwuhpH4wTiRGhRMTHqqirkAK4V6Jstxxezxa7dN5+MJxaOONUuR
        JrNULfyoLpPSIyjfp3QDp3ZOuYV3rxZP4QA6BCJKbLsHd4wJ
X-Google-Smtp-Source: AGHT+IFbNWDB+fYq/8p8IgoA/y3rlCahJG5okiucNxPC45l2dX3idUNq0eHY5+396R3r6YwmxazDDn3aFXq4W//XIGNxCTUnI1nt
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:178f:b0:68a:ce39:32b4 with SMTP id
 s15-20020a056a00178f00b0068ace3932b4mr4343740pfg.0.1693071221348; Sat, 26 Aug
 2023 10:33:41 -0700 (PDT)
Date:   Sat, 26 Aug 2023 10:33:41 -0700
In-Reply-To: <000000000000de4c2c0600c02b28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba5da70603d6dc04@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_show_options
From:   syzbot <syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c30417b20f4993e49406f3f6d986355c6e943aa2
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Jul 17 09:33:32 2023 +0000

    seq_file: Replace strncpy()+nul by strscpy()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1009eda7a80000
start commit:   aeba456828b4 Add linux-next specific files for 20230718
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1209eda7a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1409eda7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=155274e882dcbf9885df
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136fa2aaa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16629fe4a80000

Reported-by: syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com
Fixes: c30417b20f49 ("seq_file: Replace strncpy()+nul by strscpy()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
