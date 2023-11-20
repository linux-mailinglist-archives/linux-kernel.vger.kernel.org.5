Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51A7F211D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjKTXBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTXBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:01:10 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9BC4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:01:06 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6b5cac99d3dso7642803b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521266; x=1701126066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHvZqUtxIelqOkhWJ/rNyIb+FyfEgnajsCDcd1770s=;
        b=lSvGVybGW35Z+lQSL3HCdVVd/qO0zfQ1HbIsd9vygLZ//ztoP2EcPRSKe35Xia5eLL
         t1VW6iHeO/uB3tl6Vz08RZK7C2Cmi30QdPYW61TjwyaCtBBDNtPvVamLF5M9KiwB+njq
         ZzyTaRnrxmLAteOhOGppLSHQJpQUqwbSbaA/j3idYyWPltHO+2X9BFzw7c09IbjVj64z
         p3Y8cQpkC7NiIPJpk6kdIEKjk/KBigsGH6T7Y6M6iV4DuKTUzh6LKgpyBzcX36oZC3OY
         TMBWK6uoHjP5LntkWOuA/rm/KFCWm+BWqbUXjK6oo+OAycuqG2bsuT+42WKykTZi3Bm7
         ABdg==
X-Gm-Message-State: AOJu0YwvSRiR+ZFi7ewskTEz5NtuatY5Gqwm9PT0pmqHIXMqhM/bH95H
        O4crWqQkxsPWWnysRwn6068Bv0B8BhB1UDHgaDX5snlPp8P5
X-Google-Smtp-Source: AGHT+IFsaThVJyrbPxGaoq/F9sa+Xu+ULx9VWg5KB5Glx02QEN86inWnAmqiO01cPY08/Uhz2336VuPkShrD6jBlKUSQfiVxsIQf
MIME-Version: 1.0
X-Received: by 2002:aa7:8115:0:b0:693:3851:bd82 with SMTP id
 b21-20020aa78115000000b006933851bd82mr2186063pfi.2.1700521266007; Mon, 20 Nov
 2023 15:01:06 -0800 (PST)
Date:   Mon, 20 Nov 2023 15:01:05 -0800
In-Reply-To: <00000000000040e14205ffbf333f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe54ea060a9d752c@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (2)
From:   syzbot <syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4ad5c924df6cd6d85708fa23f9d9a2b78a2e428e
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 22 10:07:59 2023 +0000

    fs/ntfs3: Allow repeated call to ntfs3_put_sbi

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15283368e80000
start commit:   dd72f9c7e512 Merge tag 'spi-fix-v6-6-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4471dbb58008c9f2
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2f934f08ab03d473ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15665425680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1618cd9d680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Allow repeated call to ntfs3_put_sbi

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
