Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E32809DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjLHIRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjLHIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:17:00 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD281712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:17:06 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9eddb1371so243183b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702023426; x=1702628226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PgEJMGDi3cpV27vZsqRwJMl7xaj2Z2QHI1Ax2HDDM8=;
        b=mEyl9HS3cdlQNdn88Rd+D0cFXeWzyqQqjOnsOSvdc6QVjSzCL3fJP6L7G0jXKOWbPA
         mUooRGmf6uD5B+bSUmvja3srcmc6+tzlGbnHgrlNpmQeVNmXzw0FNKMxd+meAFN8eP6c
         JemMggT6abyF7/o2QQNY8DQcsk6Uii8tLKR89Pfsh1nqz6TYCuLQRAquQWPVBdDptAVj
         qng0SeHj+NCrqYOQhsEhRAM2w+MbmekSVIT1BHSzOak7EY9mOzGJZUnVGGQCFL2tJOsA
         aSfQ8059sVXcsyrUU5kQ+9EXC2iQvh0IjT4seC+7WDaMa0AhYIqsl3GA2TTLrIl5+cFW
         VwcA==
X-Gm-Message-State: AOJu0YxxJ0N2pDnpONs+QWIxRE4+68lcpEZN4RS2yZfQ5j7meZXQSoTr
        4EWSVHUhaTnV/EWHEBp2AgpMQBNpgUBNBRzs/uBjphXG0hkW7T8=
X-Google-Smtp-Source: AGHT+IE2vSBuct/jIVtXbEuMdstqxRz3SGsSGjAz1GH5LpafmKzD3CBhkbGoGpbzvMBc1284L5L9cJ7oEq1r3sdrwhGe/voE/ix8
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23d1:b0:3ac:b428:844d with SMTP id
 bq17-20020a05680823d100b003acb428844dmr4139712oib.8.1702023426060; Fri, 08
 Dec 2023 00:17:06 -0800 (PST)
Date:   Fri, 08 Dec 2023 00:17:05 -0800
In-Reply-To: <20231208074438.4102005-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5b714060bfb35fd@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

lib/radix-tree.c:591:17: error: implicit declaration of function 'node_tag_set'; did you mean 'root_tag_set'? [-Werror=implicit-function-declaration]
lib/radix-tree.c:594:25: error: implicit declaration of function 'node_tag_clear'; did you mean 'root_tag_clear'? [-Werror=implicit-function-declaration]
lib/radix-tree.c:596:9: error: implicit declaration of function 'replace_slot'; did you mean 'replace_fops'? [-Werror=implicit-function-declaration]
lib/radix-tree.c:843:13: error: static declaration of 'replace_slot' follows non-static declaration
lib/radix-tree.c:958:13: error: static declaration of 'node_tag_set' follows non-static declaration
lib/radix-tree.c:1015:13: error: static declaration of 'node_tag_clear' follows non-static declaration


Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178c2ed4e80000

