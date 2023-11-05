Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFB7E1581
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjKEReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:34:11 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7263CC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:34:05 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d32826def0so3468919a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205645; x=1699810445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4FvxRKbvCfMpMcLXPYkRNT3NM+7m0oeXuj/bJJZmv8=;
        b=SB0XBv3s56YvGVvGTNTsIfBeeL5nGPnyLAmyGoSIbFUvG/2s551nZb/2lRvCgouABA
         KUV3cAvQjjTJ4zallJQ7wMv+iwTg1/p7+2sFCHMGh+3TK9tWb1G/+ni2/WN5fKeF7Sst
         GHVPAyeOuvQumNDtCKQ10+nGIw8a2LUcGaJgUuyHLbKDU0fX2pIMFvht+SPIaET47x4w
         lOtcb/hRnZtYlKzPCkp2eBjWdibhEjHHg/nnzjSYfKKNWLRIxF2kbslFv1Yp98svocr+
         IuIbx6dz3l8tj8CSfwuWJQN5wvA9l2OrLf/qBGttfJt00hhGEKGFZDZVdhvY/AF15qI7
         SegQ==
X-Gm-Message-State: AOJu0YxAr2zylkYs2zYbDuH4/mom5cDzfj9vC55GCWYXDdo+LcpC1f45
        fkYo9CA1lsc7xbztYBwSnf9D7vmbj3oKqjBbjy48Jf+O/EgR
X-Google-Smtp-Source: AGHT+IHQGKy6Mfra4sf1/Fnaf3EC/D55G0NP35y8t1SN8GFVyNI7t9d57uCYzqPBwHjaKdaF7v3yTC+yAH7PGthgD35bnMd/I7bL
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3083:b0:3ad:aeed:7eeb with SMTP id
 bl3-20020a056808308300b003adaeed7eebmr10612059oib.6.1699205645177; Sun, 05
 Nov 2023 09:34:05 -0800 (PST)
Date:   Sun, 05 Nov 2023 09:34:05 -0800
In-Reply-To: <0000000000006f759505ee84d8d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e197ef06096b2454@google.com>
Subject: Re: [syzbot] [nfc?] [net?] BUG: corrupted list in nfc_llcp_unregister_device
From:   syzbot <syzbot+81232c4a81a886e2b580@syzkaller.appspotmail.com>
To:     309386628@qq.com, davem@davemloft.net,
        dominic.coppola@gatoradeadvert.com, dvyukov@google.com,
        edumazet@google.com, hdanton@sina.com, johan.hedberg@gmail.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, linma@zju.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, zahiabdelmalak0@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b938790e70540bf4f2e653dcd74b232494d06c8f
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Sep 15 20:24:47 2023 +0000

    Bluetooth: hci_codec: Fix leaking content of local_codecs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb8f17680000
start commit:   e1c04510f521 Merge tag 'pm-6.2-rc9' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=81232c4a81a886e2b580
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e90568c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: hci_codec: Fix leaking content of local_codecs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
