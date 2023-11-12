Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A477E8ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjKLGbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:31:07 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057AC2D46
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:31:05 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc335bcb47so32347495ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699770664; x=1700375464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohd64TJwZ272sXkxDwRrfkuD6hbu0WY7FGw+sQbfq4Q=;
        b=At1pD1hZZ/2/5yM1c1mjMseWVveRTVVBXYe9+ud2nk9W8xDhy2XJLV2dGeM5ghi2sr
         83W8BqJJwOxwsKNa0fzWPV4eSPN4mEeblNJDsJtDktpIXVL+LLsQjGy0jAcoWBrfxCiG
         p+rOJJ/P3jlcMO7FaCgvcoT5lR0P3K5p5KoM9LyICz0t32GFPXK/U0F789+S+cwzGJaV
         U/sbD8x64nJb1zsOXgGveYrcyvQFxzIJtW2pK9i5qgXbgxifyG/UTBbNVZTqBUBOtNpn
         haIgr+NDJv0IBkOlL3BSmarZAN4V49vTu68OG8qZQ4cyxiT75L4C2wEH9RrvIAZHBwvD
         KZWQ==
X-Gm-Message-State: AOJu0YxcbnFzNJg5+9z7kUqGVWso9dybnZXyHuBJ/2bDxC2ugiSeC7H1
        PzZh2UAYJIQh9ah7PHEyccUFNDm4mZA77xbJ2IUJWz6T/t2h
X-Google-Smtp-Source: AGHT+IH1uMH7F1Lrt1xAtJv5tyAmVrbVtdYv6/LqFJxiPDjeYSWVJM+Wjsktxa1CGDYfEDl+eSqOmpq2u6mvEjb8RQwmVGC8CGRC
MIME-Version: 1.0
X-Received: by 2002:a17:903:2602:b0:1ca:6b41:2a37 with SMTP id
 jd2-20020a170903260200b001ca6b412a37mr1045468plb.5.1699770664531; Sat, 11 Nov
 2023 22:31:04 -0800 (PST)
Date:   Sat, 11 Nov 2023 22:31:04 -0800
In-Reply-To: <tencent_1750B76AF77E86D833648366297A43AD4405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8bf240609eeb2f1@google.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From:   syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/overlayfs/params.c:533:9: error: 'ctr' undeclared (first use in this function); did you mean 'ctx'?


Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1723dc70e80000

