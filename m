Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAD37ACD86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjIYBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjIYBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:15:38 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FECCA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:15:32 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57b94b850f7so7041220eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695604529; x=1696209329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mXWJ2scKUEqPcEEGulmmGomgjLYP4kOCRMwILx6WjM=;
        b=bDfBG5z/VLMCtfCoxszMyckwKH2/FOmtjyX9Z6ShJOKKXX8H9bHGmOMD/o894EqXPk
         ygfhjlYU0PAvJ2GdyBRevnooB23cuxUHvHKyuM5o+oeRwiWPLcSq5EsSO4NjleJJqrs4
         8ZNw+HniAjl5dQKfEAmHsZBEK1u2m9oyZGQ5jVPvXUbrGh8fgYBl7bUThTeKYR7ZEhua
         yo/gok/AOKd6ESpKUS+59YQ57ArElwOZatD9erbgdRMOYJI3g+lEl2hls7ap5f4XvVFw
         QgE22q8AEdcoEF72En7neBeFBJDPc0/fFHPwMMWsWlo+m8og4wxdJ8oeq6FFMgtqwhPH
         DFzQ==
X-Gm-Message-State: AOJu0YxYqOsRAUY8e5WHlSE3EaO0CNU1Pwm1tX+Hln71iFBOOEeKfiT3
        oq+ReMkDEijr51+VCNSNV45TUutO6hDIRMBIbDwUqu9TaUgv
X-Google-Smtp-Source: AGHT+IF6nxODDAWNMD07YfAui7+hnaCMUlIRnLJLybEVpTbxyqHjKCZhNlNu46gm9+8ZaK3c7DNMoMAxqe1/vdlWNrzEyOcoatqc
MIME-Version: 1.0
X-Received: by 2002:a05:6870:64a1:b0:1dd:69a:665d with SMTP id
 cz33-20020a05687064a100b001dd069a665dmr1574583oab.3.1695604529067; Sun, 24
 Sep 2023 18:15:29 -0700 (PDT)
Date:   Sun, 24 Sep 2023 18:15:29 -0700
In-Reply-To: <000000000000b782b505c2847180@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a27dcc060624b16e@google.com>
Subject: Re: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_test_inode
From:   syzbot <syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, brauner@kernel.org, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux@roeck-us.net,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 78a06688a4d40d9bb6138e2b9ad3353d7bf0157a
Author: Christian Brauner <brauner@kernel.org>
Date:   Thu Sep 7 16:03:40 2023 +0000

    ntfs3: drop inode references in ntfs_put_super()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674a5c1680000
start commit:   3aba70aed91f Merge tag 'gpio-fixes-for-v6.6-rc3' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1574a5c1680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1174a5c1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b4412680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aec0dc680000

Reported-by: syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com
Fixes: 78a06688a4d4 ("ntfs3: drop inode references in ntfs_put_super()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
