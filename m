Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEA7F9276
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 12:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKZLPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 06:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 06:14:59 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F0101
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 03:15:05 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cf904825c2so47807155ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 03:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700997305; x=1701602105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHaxLzHaMrVuEynKFwAXmqb1IBUV1cZFLGQCi6lgPdg=;
        b=F+gTf1SfnjtY9tG9c+FeKSW8kAt5BKK48nHyuMcJD4IuCLsBn3AEzOdod8Kbzm9GX1
         vhsOU2O1AkjJSACWgTUlTCyq0w501BzkIIYdI7yHZDFiCrGSweHH4MXjIWS+uBwuiKcp
         G8JoAq02O5vY09k93s/twlxdn8MMrmmxXwK3c6Ig54FRU6tWnAYop/Cgh4YVcYsOHsS3
         3DL/9eLGFjA0f8xd2OBgyD6s1FQubHFfj/vuM35b6VytOs4gJSHgtXMx+M/blOgLQw0x
         98G4sC6Mvx3ZJUjizzbHftjcCpKw3R9SAUidIkq7jvBD0YgPJcpEoNEbCaQRHqJZgGBe
         NQhw==
X-Gm-Message-State: AOJu0YxuvQ1NqQpzlEE2d8vAWnJheU7Su0V9QpaGgKzOp0HT77Q9Wlir
        reY6sKA1qH8Gi0iCfXBNMHyLxzk12y9aeQr0ZOLr/kveJZY8
X-Google-Smtp-Source: AGHT+IE0WR/9nta+zaUgKm7UCxRX3Ot8aDCrNULWGKAS247az7Z4XU/pN/NfDGZq7w8qAr1qX/4xDp1eaWge8tvxtmAFd5e2n1Vh
MIME-Version: 1.0
X-Received: by 2002:a17:902:9883:b0:1cf:9f36:d983 with SMTP id
 s3-20020a170902988300b001cf9f36d983mr1599271plp.8.1700997305280; Sun, 26 Nov
 2023 03:15:05 -0800 (PST)
Date:   Sun, 26 Nov 2023 03:15:05 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000252e5e060b0c4ccc@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From:   syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
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

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1345177ce80000
start commit:   8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c5177ce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1745177ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000

Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com
Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
