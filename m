Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13AE7A8FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjITWyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjITWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:54:52 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B377DE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:54:46 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ac97b9577cso426722b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250485; x=1695855285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g79bcICkCCHdQM90cMC4akmu6VrqB/gBv3hd+fNQRM=;
        b=Lb5VWJSeZP7P+raJKO7peFEK/SgSGiCx1MUH5Sfa88v5hAEXbdRxJxJNQtDnBViaXY
         s1s8YeEcR7L2v0vvH4JbFwIa4nIWoCv83TAQPZ9AhwaWfNOmOaSzzZbbNh0tnQ0NO5LE
         vTSCaSyMeDumNTW0X2iMd+J4qslodt376qNRVYm2eMeFwsmR6EUcJ8COSp/PKXG8Bq8v
         Yt32yGfj+R4Fgc8s2Jl6Zt9IoVkeBgMEsEG/0bokXx8Znc3fI7Dt3ekpy5zVa5uHEBaJ
         0LVk5ixEcRHH5uLUdh8UYycFyliKmgyfe5IdYI3OCBYmXoRV5miFtXQME64ZuGRHJquW
         n3Ag==
X-Gm-Message-State: AOJu0YwAod+PXqy/tJ+TJxBMXEvUxtMM4pmzisxHzNgURqU3nZQGRSwn
        WJdy1iFZzaI7VnI8dgYjAEqG9KudvGtReq6aCOJImsivy5H1
X-Google-Smtp-Source: AGHT+IEikjJmvx8UO8IMdN6a+9RMgVvnMxyC7pr1mrFDzf2WyUEBC1kduMH0LqlxWiVKOiNJ+Pk+swZS+bvkmRPzA6YhkYbkeqDB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1e:b0:3a7:9a19:332b with SMTP id
 bk30-20020a0568081a1e00b003a79a19332bmr1845061oib.7.1695250485411; Wed, 20
 Sep 2023 15:54:45 -0700 (PDT)
Date:   Wed, 20 Sep 2023 15:54:45 -0700
In-Reply-To: <000000000000a91cfe05fe5161f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd0b980605d242ed@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in __hci_cmd_sync_sk
From:   syzbot <syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        iulia.tanasescu@nxp.com, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 2e846cd83f6285f4fee49389954b1b1215f5e504
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15636364680000
start commit:   1f6ce8392d6f Add linux-next specific files for 20230613
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17636364680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13636364680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=c715e1bd8dfbcb1ab176
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11287563280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14395963280000

Reported-by: syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com
Fixes: 2e846cd83f62 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
