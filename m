Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234D7F87C4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjKYCIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYCID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:08:03 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDE10E2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:08:09 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5be10675134so2470159a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700878089; x=1701482889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNkBRv3dxo8+jS8LEe0BK6vmtXGRWkVZVRCHKdCvNKQ=;
        b=nvjPkAzMeOWLktL/edmsAiHyI54Eod+7mjP2kncvX6wSNke2L4Zus5+7ikTqn9bxpv
         PALsdDq84R1JryfGfyGLFpuZr//0Xo2xM6ZPrRey5H8B+JMX/sexMeajd7g/RQUMMkI1
         uZRDLfEEdJt+5vLzSUgxAhfor2EaEX12PsXoHsaEFPJzoVqOKys5atOgbc4/MK2HZWs+
         k2VIrIajvaWhBm/2KMMNgGhxSyxSL22k1lAy8+kVT5nFtkVY9XfrmHuilI5yBG9Qgwgj
         RHZ/1y+jP4uKfJ634r1jypOZPZ27l9a2Qiuhuob8Yez9ke032Opq908F3zPyapG1lbKN
         OJ9w==
X-Gm-Message-State: AOJu0YxlU/Y1KLelm9xzZqrqCSL3+2hrBwa9FXM+SZ4HdY2DTPy3vnR9
        RwecT7fdi8kOYrmv2/xFjc8jtPU6SzHj0fzqv6g33ltQ9A/W
X-Google-Smtp-Source: AGHT+IHezmfVmKgu+sXTqtsDDbIynvslt6vTpPoQdO5MRY6A1ValnCSH6ckI5vBf2Pheekdw13oh+cvOUpANaNczH9AvcSsG8WNO
MIME-Version: 1.0
X-Received: by 2002:a63:d12:0:b0:5b8:eaa4:c6d8 with SMTP id
 c18-20020a630d12000000b005b8eaa4c6d8mr713970pgl.1.1700878089010; Fri, 24 Nov
 2023 18:08:09 -0800 (PST)
Date:   Fri, 24 Nov 2023 18:08:08 -0800
In-Reply-To: <00000000000092672f06042b7711@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d4716060af08a45@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_use_block_rsv
From:   syzbot <syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a5b8a5f9f8355d27a4f8d0afa93427f16d2f3c1e
Author: Anand Jain <anand.jain@oracle.com>
Date:   Thu Sep 28 01:09:47 2023 +0000

    btrfs: support cloned-device mount capability

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1446d344e80000
start commit:   d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1646d344e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1246d344e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=10d5b62a8d7046b86d22
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431040ce80000

Reported-by: syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com
Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
