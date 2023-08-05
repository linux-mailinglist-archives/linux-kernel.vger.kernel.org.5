Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC9770C94
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 02:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHEAJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHEAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:09:29 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7FE4EDE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:09:27 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a7292a2ad5so4628777b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 17:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691194167; x=1691798967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoY/PwFD0Rg65vVH6VJq/xffUWgs1OqWSy1dP4FgMIQ=;
        b=NlicRU3MZiciHOmoU97+8dBOvzzhWqnhYUwMh1A8ri/LJz4lc+C9ncXyq6JCxkW9K1
         Ww4utt3Geo2snxB12YGDAOd/5jFTdXCI7yq8y4tZnwCLpcV0X4m9iLai5xWSYVmLCNVe
         RN4xEQii4vtYwB/8lKTOE/1BW/3ZveyA2/YbTsH0cpGaeInhqb6DSJvXauAKTqcJjue6
         kdE6FB5H/KoGGGiJ7y8uyyuRA/l1mlfLMCJVAb7frGquqyJz51sf51uV+FGuuc6IcVEg
         KaEHEyAPrfy07N8QJYL7bDm/7aZA+PmKkooWdnQYjiJllbG7PasBjoCgHWq9MWshZ6vV
         M9Cg==
X-Gm-Message-State: AOJu0YwmS5+xSEDnGF9zSMYQDFTe6TZ23eJv2YhGMMu/FYwpnvraU4Bt
        vPSwhK62ihybrDx35hgjkMDIM3NEBbQTmRKn9JAa2RkaNZ67
X-Google-Smtp-Source: AGHT+IHzZpeBgcO6v7s1Q4yu3YWAWP/RE2nVc5pSgc2PsDu2FLAxNAV7Vpa/NM77hMlzGvEouqMcspaw7MDkHJ5NQYnjtdSJZ8F2
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1812:b0:39c:a74b:81d6 with SMTP id
 bh18-20020a056808181200b0039ca74b81d6mr4782033oib.7.1691194167195; Fri, 04
 Aug 2023 17:09:27 -0700 (PDT)
Date:   Fri, 04 Aug 2023 17:09:27 -0700
In-Reply-To: <000000000000f1a26f05e9a72f57@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094fcb0060221d31a@google.com>
Subject: Re: [syzbot] [fs?] WARNING in brelse
From:   syzbot <syzbot+2a0fbd1cb355de983130@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit f6e2c20ca7604e6a267c93a511d19dda72573be1
Author: Liu Shixin <liushixin2@huawei.com>
Date:   Fri Apr 29 21:38:04 2022 +0000

    fs: sysv: check sbi->s_firstdatazone in complete_read_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e8976da80000
start commit:   77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e8976da80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e8976da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f967143badd2fa39
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0fbd1cb355de983130
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11393ab3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a2a99d880000

Reported-by: syzbot+2a0fbd1cb355de983130@syzkaller.appspotmail.com
Fixes: f6e2c20ca760 ("fs: sysv: check sbi->s_firstdatazone in complete_read_super")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
