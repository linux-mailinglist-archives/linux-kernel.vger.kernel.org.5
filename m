Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127E7D960C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjJ0LLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0LLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:11:09 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EEF187
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:11:07 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9c2c00182so2281112fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698405066; x=1699009866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHYFRDDqX2abVHCDP7I6KtrsG2bKXGwCJSHzhmv7Wxo=;
        b=dDiY3/n6BEifcziaQXTBglDXx/oAUKLpIJctfzSL7mfuvG2wm4w8g2tLJZRfFjtveK
         2dwrmAHM7JKXN4qEYNR45lr1/zjxcLmcF1XrfjwJmQEPOx6H+HjzfYAggqycrTmHaVqH
         1wJXEraXlwV49D1kLDdSmPib+dnLrTvzbbHB5241RCPiI8C726lHy7gfGt9TN+gOK86q
         zJ2D5Z/KuNLltMWBt3HML8ZbcnBS4pffBawMVuzurGmABf5a5CZOdMvFbJf5wgr8sah+
         4DTtJ/h/27Bf1C5yIendDwCQnVD8wOxH8l6D2i6HZUA0aYn+X76WWgJdkvtMMZCyUyMb
         1OaQ==
X-Gm-Message-State: AOJu0YyS48JSjY4Fkta0X1TG1v0u+/qr6y5OysEpjbNxchaxypdAPCMn
        Rhzq6LtthQj/t099KuzWSsKn2FfOgIi7ITjIXGOY0/QwafHu
X-Google-Smtp-Source: AGHT+IErGGl8I9pZs0z5jYPnq5+PZghKlSw97pW/dZhAu9GU7YV8AuOLdJZErMMTBB9u98SHBxYwC4JDQv90suiNnnWoqaDZ+BeF
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3645:b0:1e9:dbd8:b0bd with SMTP id
 v5-20020a056870364500b001e9dbd8b0bdmr1101923oak.10.1698405066271; Fri, 27 Oct
 2023 04:11:06 -0700 (PDT)
Date:   Fri, 27 Oct 2023 04:11:06 -0700
In-Reply-To: <0000000000006cb13705ee3184f9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f4b30608b0be9c@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in create_pending_snapshot
From:   syzbot <syzbot+d56e0d33caf7d1a02821@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit df9f278239046719c91aeb59ec0afb1a99ee8b2b
Author: Filipe Manana <fdmanana@suse.com>
Date:   Tue Jun 13 15:42:16 2023 +0000

    btrfs: do not BUG_ON on failure to get dir index for new snapshot

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1584c385680000
start commit:   0136d86b7852 Merge tag 'block-6.2-2023-02-03' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ea620bd01d9130d
dashboard link: https://syzkaller.appspot.com/bug?extid=d56e0d33caf7d1a02821
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14657573480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd145d480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: do not BUG_ON on failure to get dir index for new snapshot

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
