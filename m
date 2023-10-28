Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051397DA82C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 19:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJ1RFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjJ1RFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 13:05:10 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C9126
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 10:05:06 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9e17b3269so3966000fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698512705; x=1699117505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTo/MYGjU98OZVhpt1voIWuh+FHLPG7oyJBS1qD9LfQ=;
        b=QJUJAlsdW5JpKHK3kfMsiTSXv8kxTlt5BT4d9kTcVEeWZo4aiEY5AUep1DpRgGfdNO
         jCFrNKhs1wQexOk/uQjRaq1n9XPTE3/ubzV2huLmv5xoqWkKYExHYdwbZrsJ6s3/jqF/
         3jEDrS67IWiWkIRXaThUUNRFoiyizQPAtcZrBJImpPPvwETVPZsB+/I4lZ0bt3l9T9an
         QBFbyv/ncdqNvK5s662GwfkF++suiC6C8cmxFp0LSLbpGuot+8/qFIyhu4tXXHRPbOma
         FvWAH4fD77wkDqj047XnMxZ9KfRNvCAnUMKDGRFDRslGUO3cUoRGWp2aUPqGg8mbO6a6
         wkWQ==
X-Gm-Message-State: AOJu0YyDN0oLgS2/VTqTtM8R3kU441WnWbV6PjIeztjVf55lXXeAT3AW
        pGYNMobGDu6FFt2x3Xo0Ier7ewDdKuIOiVQ/kyaoxTUKysqB
X-Google-Smtp-Source: AGHT+IHDWbVpcRZW17s+E9mZT2p3NLImbd1EcjPq+4ECelqP51WUu/Fg5z00UTleUxVPQ3pE/XOUb6xGMgZ4y7h8sYPMfUlG8x9+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:30d:b0:1e1:3367:1429 with SMTP id
 m13-20020a056870030d00b001e133671429mr2675836oaf.10.1698512705435; Sat, 28
 Oct 2023 10:05:05 -0700 (PDT)
Date:   Sat, 28 Oct 2023 10:05:05 -0700
In-Reply-To: <0000000000003ba9f506013b0aed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000743d980608c9ce33@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in ntfs_read_folio (2)
From:   syzbot <syzbot+913093197c71922e8375@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit bfbe5b31caa74ab97f1784fe9ade5f45e0d3de91
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:22:53 2023 +0000

    fs/ntfs3: fix deadlock in mark_as_free_ex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14006f67680000
start commit:   bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=913093197c71922e8375
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b8869ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e6072a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: fix deadlock in mark_as_free_ex

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
