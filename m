Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13B77B42D9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjI3R5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjI3R5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:57:31 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704EE3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:57:29 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1dc580ed1e4so31739458fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696096648; x=1696701448;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Gp6kmS+fykC4M2bQvmNXWwpBIaXxl++sWiM3iH1lM=;
        b=tRvsISwj9dStJQKuPnqqLfCbF6MMZJcx62X5PZzxPqOFFP713pMxtzQUo+F2A23AaB
         Lx7PvpvaEkJoFuTxJdRk327U64dmp1odeaBudHyqGsdYvCJDgFWu+ZLGRrgUhleCo/b4
         G4TLJAgdVKLsdOmDflf1zSgBVzVRfDMCleEDtJdA/GlwUtGMOldR+AYsGFOnvzfiPpGq
         SQwHYYrYG1EfpZnteUhoU6g5WImc2TJZuXc5dBGA6ggE1iLDcPO5JBqSn/qQO0tX4iLV
         6iqL04N/5BhHYkceMr5UDxRwuYqtnf0sseojVApZOIQAT4ICN3VkpkBg8cYkKOTp/G4j
         dD5w==
X-Gm-Message-State: AOJu0Yw22Uq6kdEpqT6y+BW5s660fLZIRb19dAWcWlqYkU9q3/i6T28G
        ZbPU8172GyZM7AgJqIArVnKpqfpD+ibuligNEIim2Q66sdMt
X-Google-Smtp-Source: AGHT+IE18cqh4JXNl6uQxBP/a23swgy+FwpamgscMAObJ9M7l5hmBxY2Rxui2X8zH1T9Z/3YkdWmpxVHSllM5OftvTuZR+eXBiKI
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c342:b0:1d5:a24a:c33 with SMTP id
 e2-20020a056870c34200b001d5a24a0c33mr2785411oak.8.1696096648433; Sat, 30 Sep
 2023 10:57:28 -0700 (PDT)
Date:   Sat, 30 Sep 2023 10:57:28 -0700
In-Reply-To: <0000000000001c8edb05fe518644@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c16100606974653@google.com>
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in xfs_attr3_leaf_add_work
From:   syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>
To:     chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
        ebiggers@kernel.org, hch@lst.de, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, mukattreyee@gmail.com,
        syzkaller-bugs@googlegroups.com
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

commit a49bbce58ea90b14d4cb1d00681023a8606955f2
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Mon Jul 10 16:12:20 2023 +0000

    xfs: convert flex-array declarations in xfs attr leaf blocks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12eef28a680000
start commit:   f8566aa4f176 Merge tag 'x86-urgent-2023-07-01' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=510dcbdc6befa1e6b2f6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1652938f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c10c40a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: convert flex-array declarations in xfs attr leaf blocks

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
