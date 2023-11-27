Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E57F9ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjK0HNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjK0HM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:12:58 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47185134
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:13:05 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cf9dded6fbso45662065ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701069185; x=1701673985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbhetaEmHDXsErRVxv8JP9G/LWBw8d7TWXbXFegje8Y=;
        b=IlCKo9om/v5VbbPkfGrNQaezLz3i7emngaoqHfnWmNjx+BvP0b0bhEOXoNwpuVsDNX
         41BNZHTTneg/wTy/syjFgYXBUS7UO0GNUTS+y4Gh6GN287A3KRRbZKOO6SpJEHhSPoyn
         5ii7rZRSDLrb/I7TyLzrw/ttYHDu+3rWngfAlhR6z376PVDQZjQHne1USNvpSVJnFeb8
         5yByG+0sUZcklVCQ00l6n63zwTTZW1iIjNLch6vrLqiQxfto2qduJksig9LD0HR7V7Lv
         u/32usCnihVtYD0+Jxh0SJyfZf0twrMNF414eIQTF6eoShwFWKZ22mNHV7r5WC73rxrI
         9P3g==
X-Gm-Message-State: AOJu0Yx6LGXbOVpXibDG85WBniSwgLbmF3Z0yg+LM8QFrTF78N3COhxI
        fMWpWVSonAiYqslypwgdqnrufN4g3/qPKCvQHvaa/TCS/K8v
X-Google-Smtp-Source: AGHT+IFNEfof+Dn0EQCh3xoFE/GYY7yEj0K6LHERwW0gKqb6aQluaZTSa9z+QLSO/78XIHCyzPsL9nqq78gmkq4CLWqD4Dtpx1LN
MIME-Version: 1.0
X-Received: by 2002:a17:902:ce8a:b0:1cf:935b:96e1 with SMTP id
 f10-20020a170902ce8a00b001cf935b96e1mr2751808plg.0.1701069184815; Sun, 26 Nov
 2023 23:13:04 -0800 (PST)
Date:   Sun, 26 Nov 2023 23:13:04 -0800
In-Reply-To: <0000000000007f826b06044878ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fd73e060b1d08ec@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eadavis@sina.com, edumazet@google.com,
        hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        pav@iki.fi, syzkaller-bugs@googlegroups.com,
        william.xuanziyang@huawei.com
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

syzbot suspects this issue was fixed by commit:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140ffa0ce80000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145586a8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bf8dffa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Make handle of hci_conn be unique

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
