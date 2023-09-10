Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D779A08E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 00:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjIJWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjIJWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 18:43:44 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DCF187
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 15:43:39 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-273fa168866so1126695a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 15:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694385819; x=1694990619;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLIZAbSCvNytHhevI9ZG78CMGs02CUAu94VDRUFUCTg=;
        b=uYW886rgcbMb5EhJ/paVdzBwyQPAFtLd9ADXdPF57U0uq74bxcOJ5kkJdwWCnLMiPg
         GojtvtLetAIRVTHVDodm/SYBTmG4RiIF7kCCO59dYpZWF4PAXqtBHDHyfVusAyG0EFli
         Eq2t9XqdtvxbJloDTt+4HpD5wtvqwWME2H/WKSUfXZom7XQHVRmtBwxTqk28F1QWoDoE
         slQCT6eG1mtR3Ns695SZ+rGXjGPNena96nyOZXmMz4lya6EZKYemc3uVBog3oW4T0ky8
         wQpYPLWy0UCAJIEivO5j6MiMn3h9mpfvhAXPnz4IWEMje+wqA4NySSklZI24ZTtTXXtV
         dbqA==
X-Gm-Message-State: AOJu0Yx3ODn+POXDnMt6dBqYyohP04Q7A4pWaMuhxHOOmMhn1lctaZnt
        aadrdzGWAU2NqBLxl0hUFMbc9yPhqo4pkU0vX7RTwJCTknpN
X-Google-Smtp-Source: AGHT+IHjJSd9mSFaTvjCMHXTpXZtE1Fh0uCicpy5IzNHyNzZiWSElSHzGQX36i2ikxjDzfXOuEKtESL43gSz23rexVlYXvxVz3kR
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c28f:b0:262:de4e:3967 with SMTP id
 f15-20020a17090ac28f00b00262de4e3967mr2253607pjt.0.1694385819076; Sun, 10 Sep
 2023 15:43:39 -0700 (PDT)
Date:   Sun, 10 Sep 2023 15:43:38 -0700
In-Reply-To: <0000000000007f826b06044878ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbd624060508f001@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To:     eadavis@sina.com, hdanton@sina.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, pav@iki.fi, syzkaller-bugs@googlegroups.com
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

commit 94d9ba9f9888b748d4abd2aa1547af56ae85f772
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124d6578680000
start commit:   99d99825fc07 Merge tag 'nfs-for-6.6-1' of git://git.linux-..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114d6578680000
console output: https://syzkaller.appspot.com/x/log.txt?x=164d6578680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=988789167afa40d5
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e9ba2fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111affcba80000

Reported-by: syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com
Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
