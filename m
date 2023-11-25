Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB087F904B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjKYXVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 18:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKYXVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 18:21:03 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96712D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:21:07 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf9a581e0fso23372595ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700954466; x=1701559266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8irKbRQf4ulqP864AaN8Yh83B8c2j63BxzIEMPOYPM=;
        b=e+3iIF/W8NvyX1XW7hkIDEIuptkDxqXwsp3hKWmJlopJzd7JKEJxSrL4sKiKuIoDv9
         umsMebRuTxKnh/JVAomCCGH//K7Llu4YblEO225HUsr1nP+MWS8e+H+pH/3dwHzVGIKr
         eA4NjDX0Vk4dAuCbQFi9MCj7GUIhS+QBb6kjOXN2cW/rqOdMzQt1Fyu2fHeL3GpbLMj0
         kXWMyXUzdvEiYxfq35jRgkpM9HVqjIuDrmQU0uzGqfgQPTLOihemNfw7LVhNPc8g4J0s
         /C0kQFQQkCN09Tt4W9YOhWTFx7NUApNE5MUqZrYM+5e80nJv9AgbB8zR+kxxYEfJDeB6
         j7Fw==
X-Gm-Message-State: AOJu0YyWb2lpSTRL8mvK6rump7WAUy0hLwVePcYIeBqw0GzbGOqeQkhW
        nG3qaQmCZkf8LorzfXiFcGBpZvVsF4B1DKDUOOp4qv5L+BEn
X-Google-Smtp-Source: AGHT+IFetQ4Ea4jYYNu4u1E8cYyU5EKkb9XFCyMuTXo4Yo84ERnycivmlcdAMjCkdweSpyAyN58iIPW0zBpeCEXnglUtqHcV13Dm
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68e:b0:1cc:20dd:8811 with SMTP id
 l14-20020a170902f68e00b001cc20dd8811mr1631703plg.5.1700954466756; Sat, 25 Nov
 2023 15:21:06 -0800 (PST)
Date:   Sat, 25 Nov 2023 15:21:06 -0800
In-Reply-To: <000000000000459c6205ea318e35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c52fdb060b02522a@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtSearch
From:   syzbot <syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com>
To:     cuigaosheng1@huawei.com, dave.kleikamp@oracle.com,
        ghandatmanas@gmail.com, jfs-discussion@lists.sourceforge.net,
        juntong.deng@outlook.com, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a779ed754e52d582b8c0e17959df063108bd0656
Author: Dave Kleikamp <dave.kleikamp@oracle.com>
Date:   Thu Oct 5 14:16:14 2023 +0000

    jfs: define xtree root and page independently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16eb55af680000
start commit:   72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15802088480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jfs: define xtree root and page independently

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
