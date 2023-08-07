Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9F77180F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHGBtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHGBtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:49:33 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC8171A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:49:28 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6bb0ba5fbcaso6370926a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 18:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691372968; x=1691977768;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ0pnqzDcUYoJOrL/uiOZ85FySJF+QGIBXsYVVe/1Qo=;
        b=CK3uvKCJHGfVqnGNUoc/mmFEqb117qQIGAtT/YJCUB4lUMcozLFaIt5V9hURWt7RCt
         ty+sCvPHfpnvvLkNIrOdJqcJghbr0JLHeeWtgIy82MZ5/rqZ06nZMJ5PBQ/QAfTZzYl2
         2Ff56CkESWqDKsrvpY5IAO2hSkCzYAKSHv/55/q73S9Dt34v2hnvor9Y86TGD4Swjejx
         66wlyILa7c7iDbgJ8ofgFMpZRcILg70KWjUit2YvLmyocsIs8Vw7S5cY4j6gCTdqxuHI
         0PEN5Svi/zIIl6unQ6I4j1C2JeGbcG5f5ZVLMGUyJPTYJzBzgjwWvTviygKPA9nmbGc+
         Nv/A==
X-Gm-Message-State: AOJu0YxKIZJyqsesCkrlu2B5W50eGX3doeizv8u34sYfooTV3LjmO58h
        pIspKshbdkW3FLn8sr26PJX9njHfY3X+v6wnE/n93kjAzyeX
X-Google-Smtp-Source: AGHT+IHPB6j1gS7ZPuauj+jY7eqo2smBRGv2p7/QM7lS3P3/wVO8DJ5saVf5WHlBYO96FUG1SZ+2dgol/OQ/dgXrDZk5EWr9oDra
MIME-Version: 1.0
X-Received: by 2002:a9d:6d06:0:b0:6af:9f8b:c606 with SMTP id
 o6-20020a9d6d06000000b006af9f8bc606mr8593349otp.0.1691372967933; Sun, 06 Aug
 2023 18:49:27 -0700 (PDT)
Date:   Sun, 06 Aug 2023 18:49:27 -0700
In-Reply-To: <000000000000b35ea205ffc35fe1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efbc2306024b74cf@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in validate_mm (2)
From:   syzbot <syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luca@z3ntu.xyz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ef513aa7aa5038d2f53e9f2932af5006f37ed0b6
Author: Luca Weiss <luca@z3ntu.xyz>
Date:   Thu Apr 13 23:17:49 2023 +0000

    dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11aeb085a80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e1158c5b2f83bb
dashboard link: https://syzkaller.appspot.com/bug?extid=70b97abe3e253d1c3f8e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511d490a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130e5cfb280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
