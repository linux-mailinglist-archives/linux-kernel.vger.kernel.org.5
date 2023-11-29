Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60AE7FE22B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjK2Vl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2Vl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:41:58 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A18F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:42:05 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so281885a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294124; x=1701898924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NbCxHxoX/8oZaN5a+Csa1q9zeATXJUOImFIfAeLV9A=;
        b=LuGvJXn8LEUhAdhDsikn9ixmqk4GHfXbgAV84TibzR5WiWGqyyoDvx0vgjeffT6nIg
         hw2K+Nz8UYNlmka3Cv2t+zUHolkLR8WqvZa+exptcO+y7hh9Thulp6EdodRjaBevQHKR
         L7SZAobIaCaSq+1Y3zp6UVbxVzcJoDo4+lEckpcXKTjMwqYpvitv8IM4ok3ZWK/ypsai
         B2TN+QjXh+86OAjqpc8XUMSk27o47X3X41NAfLMu+U7xPT+V4JK/MUcwKC47o4G9aLmS
         TMWRRi6nqW+7l5Iy2zWVLF/4BHSjK9aL/fZerD0aA7zRMtXlRYeO57Vr2Mz4McgR2ltl
         TG2Q==
X-Gm-Message-State: AOJu0Yxcuuzjliqa4xDkhAP2v6ms5j4iaxUDelILivoUPFD07QWHe5Ec
        1eEnUpWctau1Lqs25edP4n65Bmcmg12wXpyTdHVXfFHNDL/Q
X-Google-Smtp-Source: AGHT+IETi66dWW6/8wkIKVCpieF7K0d2+NGao1l0CjphPq9lMagnrVVW0dwnje+k6Qh7AN7/WuIPFTQPMEGbEwJR1N4giQSK5hhd
MIME-Version: 1.0
X-Received: by 2002:a63:1009:0:b0:5b9:6677:b8d with SMTP id
 f9-20020a631009000000b005b966770b8dmr3298317pgl.6.1701294124632; Wed, 29 Nov
 2023 13:42:04 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:42:04 -0800
In-Reply-To: <000000000000db858c05f06f30b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5144d060b5167d8@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From:   syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, namjae.jeon@samsung.com,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
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

commit 907fa893258ba6076f5fff32900a461decb9e8c5
Author: Namjae Jeon <namjae.jeon@samsung.com>
Date:   Thu May 21 23:10:10 2020 +0000

    exfat: add the dummy mount options to be backward compatible with staging/exfat

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138aca9ae80000
start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104aca9ae80000
console output: https://syzkaller.appspot.com/x/log.txt?x=178aca9ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d6fe00480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d2fc63880000

Reported-by: syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com
Fixes: 907fa893258b ("exfat: add the dummy mount options to be backward compatible with staging/exfat")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
