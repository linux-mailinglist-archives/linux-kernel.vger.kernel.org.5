Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B742A754D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 04:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGPC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPC5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 22:57:25 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DE1BE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 19:57:24 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56601c9a4feso4462821eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 19:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689476244; x=1692068244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV1p85HbsZJ9THimnEm3QDwwQ23M02O0o2ECpycPfwE=;
        b=ZokCd8HTbHZrA7FkjrOiAENG+tOPuCCgSajnhCCQjZTQLrXT2S+OsFOUjSkBJ3ZmbG
         +Dkb6Q+8m9LQNUttDLV7ksux9gn8Bpj2HeXzMqLW3OdvlbQM2CVwlQkBEQmzyeBnednr
         9fHz/RBL3n3aWwgcMFt9Lj1D+PcvP7tc5sPu1CRYvd6pj6cOE6EwQ4uhJF6SZGd9XhNP
         LfjB0VDX4A1VkogbR6bzMYp6Ml9JXCzGUi66s+cI4/sz4xJqPdeQ8qEotMLb4igCAP72
         jXT+jJSjLQwAvC4gan+JQcHP3cbfU9kk/A/aNUSlgZW1f6o/CMEeaL38vRm8Q/b1avgB
         BvYw==
X-Gm-Message-State: ABy/qLaoYjSnqO018Hp9fzNjZsh6aqkDEiwMbqfnpHmaINeg4zFYulUM
        JcXz8g8ZMEfHUmPnT9m4GPxfjRJHJd7o4459gi+T5FvLrRH6
X-Google-Smtp-Source: APBJJlHXRLig0RINXY3j+dbjr1Lw0gM/KWkDKlJRrUJRkV/EIhqOm6+gsAeWprJYorKp04zmsmZJzjX1koudKJo1771XcG86+k/s
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a5:b0:3a4:4b42:5ce1 with SMTP id
 bl37-20020a05680830a500b003a44b425ce1mr4442302oib.3.1689476243880; Sat, 15
 Jul 2023 19:57:23 -0700 (PDT)
Date:   Sat, 15 Jul 2023 19:57:23 -0700
In-Reply-To: <00000000000054bd5b06006df9c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f80ad060091d7cb@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_access_destroy
From:   syzbot <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>
To:     alex.williamson@redhat.com, iommu@lists.linux.dev, jgg@nvidia.com,
        jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        terrence.xu@intel.com, will@kernel.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 54b47585db6658a5eb898d4d45be18d1e581c1bf
Author: Nicolin Chen <nicolinc@nvidia.com>
Date:   Mon Mar 27 09:33:47 2023 +0000

    iommufd: Create access in vfio_iommufd_emulated_bind()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16549b42a80000
start commit:   b6e6cc1f78c7 Merge tag 'x86_urgent_for_6.5_rc2' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15549b42a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11549b42a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4
dashboard link: https://syzkaller.appspot.com/bug?extid=7574ebfe589049630608
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123562dca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15825e1aa80000

Reported-by: syzbot+7574ebfe589049630608@syzkaller.appspotmail.com
Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
