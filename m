Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8C7F8A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjKYLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYLx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:53:57 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56D10E2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:54:04 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf66d578easo33268725ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700913244; x=1701518044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KRHX69P+c/HonL20U6p52M6bOssV1LeZSiVOwq9udg=;
        b=s5sCRWd7rra+hdI+wDWnwqP2xuqcuoNlCKT4pejupQDd0Du3iRJxHHWyJCcUreIrp3
         adNkUFkinde9u/y3D5dJJyPSGzPQqrFK3SfLBgL2ddEYtAde3ceNkanfbzS7fY5IAl77
         rN9dvnmcn8wP97W6jInaK4tMM5xdcsTinuDToSuR4gXVMrf8o8x1i6jJPY2uzFkHPinx
         G4Lh/fO6q7wm1C/BfqtWhxyL28PjFQzg6z+ORxCras/WH35MPkXpF7n5T8ZITiU6JEEP
         RAdJiXwvIvByqtd2lhoAMGAh2G0tqnhUowu8IRy5QNg8Ocpd5WSzspQVrHJJXI63/MGC
         fDYQ==
X-Gm-Message-State: AOJu0YzphqkdrmQkT4UGrcKZ6tCogfpaR4LIJC822XUZS3BaLg9KnXbQ
        YvJePS0pd1nxEwOoCPyoJtDL6I0LjD+m5BXgGPe9jebTZk5y
X-Google-Smtp-Source: AGHT+IHy5N+EUzhnu1BqL7Tre6DLYWnMI3bWa4fghmRRJW5x6mn1VxPp8iENwnRyZhLbrcEvUJ7+Wd0weLI92G6ARV1U74tRU3FD
MIME-Version: 1.0
X-Received: by 2002:a17:903:4282:b0:1cc:1e05:e0e7 with SMTP id
 ju2-20020a170903428200b001cc1e05e0e7mr1181364plb.2.1700913243801; Sat, 25 Nov
 2023 03:54:03 -0800 (PST)
Date:   Sat, 25 Nov 2023 03:54:03 -0800
In-Reply-To: <000000000000d40c3c05fdc05cd1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0cfb7060af8b9e1@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From:   syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de, jack@suse.com, jack@suse.cz,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 36273e5b4e3a934c6d346c8f0b16b97e018094af
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Nov 13 16:29:02 2022 +0000

    udf: remove ->writepage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d71cece80000
start commit:   123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d71cece80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d71cece80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be1190a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d4666aa80000

Reported-by: syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com
Fixes: 36273e5b4e3a ("udf: remove ->writepage")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
