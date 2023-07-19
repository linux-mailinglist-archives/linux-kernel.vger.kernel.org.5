Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A9758ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGSB11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGSB1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:27:25 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30091BD7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:27:24 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39fb9cce400so10576380b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689730044; x=1692322044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfxy0CP6ni1VWU8/yfU77lINRc2kmaRCFe7LKCX8BHs=;
        b=lzwLYY0dqqVjXh7lOu1ZzIO52738PCybD1LSsXFRU2fb4I/IKVV/B1lSEg63YldZJG
         GJRsMkDipTnvBZ0f21AA5b+SqCB6qeRPykodXXHj51ESc47ErHiIsVsSekrMaMCkuNvG
         hBe/DF2Tsc3f+KYAk8sWrzKUcFhzjo/jYLj5VTtbbCqdazFjM+JZeVtlw5ft6xXcQcPV
         2ref4nRW8XzVyI1N5R8Icqg0ekkW/Erb2YMsOC/OOXe9MiBCDASbBVy1m4+NZ+aULuXo
         eWiBbddEXR8gVCxJ11KBegMj15z1X5Jd9xWMWjKOG/8BgfK+cyXiq9aVq48EXngVQKi2
         BXag==
X-Gm-Message-State: ABy/qLYkoYrFi6enhT1wspKHtOhzenACZmhHu+w58utspJwCUEkqe/JY
        UDAInHwiw8r9wS9zYBqib4UTSQ6c5DwyXOhXHTwD6ITu+s6o
X-Google-Smtp-Source: APBJJlHvSvEWJ4gshpSi+alJuPgyRolravk84YMG5BqnOgm8pVPsVWN6pdJN9s7BhvvHifJU+W2mqyC9ps8Z4ponVybWUl4qoYDH
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3081:b0:3a4:13ba:9fe with SMTP id
 bl1-20020a056808308100b003a413ba09femr8362947oib.10.1689730044035; Tue, 18
 Jul 2023 18:27:24 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:27:23 -0700
In-Reply-To: <000000000000d8352e0600c0c804@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a88cb0600ccef54@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c30417b20f4993e49406f3f6d986355c6e943aa2
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Jul 17 09:33:32 2023 +0000

    seq_file: Replace strncpy()+nul by strscpy()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17488c1aa80000
start commit:   aeba456828b4 Add linux-next specific files for 20230718
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c88c1aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c88c1aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ecf646a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476f30aa80000

Reported-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com
Fixes: c30417b20f49 ("seq_file: Replace strncpy()+nul by strscpy()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
