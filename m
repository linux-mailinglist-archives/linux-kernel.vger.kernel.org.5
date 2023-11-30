Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC07FEB55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjK3JEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjK3JEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:04:00 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6D170A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:04:05 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ad60469181so36253139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335045; x=1701939845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soy1NT2UKGDJlxht+HERBZveQG1Bg/FOkanqtNm/9DY=;
        b=vHIdHXSE0RnG+XAXQ24uO64X+4EmMUeoHVpLTuQCn9j1Psv2LXkl4d+RHHa3U4luk2
         QRXbup2EurEF7cR9lYcV/ducmiWX8eq5+9RMCK9V5ZsFK2eh8qxZ/2rgcgPN2/xcb7C6
         lOQ0fACZ4+0ztRpCy/mvboZzCjBL3gvwlpDv0akiY4gj2cV3KJ6cVm6BOriEhc6zXAj8
         uW4EPbXU5debLeo1Z63hAgyfWrq9zA8y2ytcBXXgVCXKyQfoyn7EV/8ggt12yssdFdbd
         E+XsCYq+3Oj5bnlAvYyhoxZB0EXR4E9CZfuGLJwhNUcn1rO6/d9nlHcKPiQdPZA4fLIf
         gqqg==
X-Gm-Message-State: AOJu0YznJ6eGPkNfql1MBi2WseTQ1KgkhCgf4YXn8YTBCKgL/DQPjXx3
        Nkn3ivr0cMDOQ6YM4B3DWrZbXWSeDsODOae/uYyuuqBpD/Ll14k=
X-Google-Smtp-Source: AGHT+IG5Ait6fMfTQB+UHkqXgOAU4uB3wqkzXDfyRRZGYJew/an96b9QSlQNg9qwIJt8XW0IRl/BgZ9fx3Ig8l+PKfodU0xq5fgS
MIME-Version: 1.0
X-Received: by 2002:a6b:db1a:0:b0:7b3:8b53:1547 with SMTP id
 t26-20020a6bdb1a000000b007b38b531547mr757606ioc.2.1701335044968; Thu, 30 Nov
 2023 01:04:04 -0800 (PST)
Date:   Thu, 30 Nov 2023 01:04:04 -0800
In-Reply-To: <20231130084311.2983367-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffd6de060b5aee58@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From:   syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5342 } 2662 jiffies s: 2933 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1292be28e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bf08f50e8fff9ad
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124a528ce80000

