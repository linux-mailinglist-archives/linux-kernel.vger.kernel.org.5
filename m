Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B493C780C56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377053AbjHRNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377057AbjHRNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:10:47 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE113C25
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:10:42 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bbd260ca2dso13543435ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692364241; x=1692969041;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIkwbNN9kL4K3EmOVENi42yRk0RdTpQaFB+jp7VFpcY=;
        b=dnFIlWoM4avBk9a8R3V0RKFuDTZxxfZwYopsiCfzxQQi79wbQ1jZtgn0p87NUX7RhW
         w6xiYK5pfd/yYPHA6RDk8Vp8TtADlFdEJ/04zeFbHaK8mzLNSoRjgroE9msXEe4hZyVh
         BwP23PfR/fxN3dWrJ/rV/6QQRTdUXaZxjcITj6ax2fnYTqa8ryFQnNbvnp+C0PGkf7oV
         n5b6QsIBllOweICYVWAVq7wBPE+TYjXIC9qE1jjVcrVdOmbmAwasWjh9DU/Fpzam53ga
         W4z47wa4i2mqHg3MfJyFPvOfgBxQx5CRIFN41mau7SzC3hgoLRdrLKKf4VkE8l+cVLFQ
         68ow==
X-Gm-Message-State: AOJu0YwLyamqQVRGdWrhsQ8i9Wb896T6zsMMMyVvp9rq3RTuBL1JKTIs
        LKJS0p2xoHUSwVNkSS0vOdeDu1nfMRVivhzf+4BfODGsnO8H
X-Google-Smtp-Source: AGHT+IGpCXUIc9w+uvEXJYohpoa0yAG32ipeDyRzs6JO1gwVuVP5xEoJNHaWqGpnCqxtXCNeBWPfHWCROLgsoQItBYkHZ3P2CVI9
MIME-Version: 1.0
X-Received: by 2002:a17:902:f353:b0:1b5:147f:d8d1 with SMTP id
 q19-20020a170902f35300b001b5147fd8d1mr746652ple.3.1692364241770; Fri, 18 Aug
 2023 06:10:41 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:10:41 -0700
In-Reply-To: <000000000000f59fa505fe48748f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000761f5f0603324129@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in __writeback_inodes_sb_nr (6)
From:   syzbot <syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linkinjeon@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        rafael.j.wysocki@intel.com, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        wendy.wang@intel.com, yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5904de0d735bbb3b4afe9375c5b4f9748f882945
Author: Chen Yu <yu.c.chen@intel.com>
Date:   Fri Apr 14 12:10:42 2023 +0000

    PM: hibernate: Do not get block device exclusively in test_resume mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1275be4ba80000
start commit:   4853c74bd7ab Merge tag 'parisc-for-6.5-rc7' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1175be4ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1675be4ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=38d04642cea49f3a3d2e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171242cfa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17934703a80000

Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
