Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355F7E0049
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKCIIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjKCIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:08:11 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8E1A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:08:05 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-581e2c9197bso2059791eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998884; x=1699603684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vzpiNs11OCFyo86okXzyCcFWMl5sk1XqF/aGmxiItI=;
        b=haRwfpw081HcATtKAvLgl2K2v7o4P7AUnYPRCNYEt9t17BgwKnXSvJZoH9aGwMuJo4
         yZvTsVxS9hhPxXl+KiCcBdtE250dwi5TxZn5mOE9U0B4J4Y/Zcyl/+FgCePyVKuNWJXn
         IzUU7on/zn/X0fzAbhTQY3jOKAHLYXwAzBVTdB5A+vwzh2PiOzjGDkNoKIthqSX/nC+s
         1Jv0C4yqAkQAyu34TQF+FxtI/SHBZwJP2h7p3hH5ys81MNY7l2zJiPbKZdU9+3Zm8lg+
         WJEFIizzJyanPWmFkSRCg/LsLxRZM4P8SBTI95Z5/ecpd2GWCT675Im+bEKRxNx3CTv0
         WvLQ==
X-Gm-Message-State: AOJu0YwnAetZOPOGIvuT15a4tqOw86xJtRUwWCkPOmJL7NK/qpUU2snH
        OYPwSlE2z8D5Y0E9Pmat8ZjoW6uIncTxfMqdE0YsQljkSzWuwr4=
X-Google-Smtp-Source: AGHT+IHDoeC9Z4hr+t02tHEIkfzUhcpmMx69a/RKt6dd82yYqG/wTRGtVNwWcl8D/mkjZnEP5RY1JnN8OQWy0gTHsGzHn48BDB7L
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6193:b0:1e9:7407:b4cd with SMTP id
 a19-20020a056870619300b001e97407b4cdmr9737964oah.4.1698998884193; Fri, 03 Nov
 2023 01:08:04 -0700 (PDT)
Date:   Fri, 03 Nov 2023 01:08:04 -0700
In-Reply-To: <20231103075800.3488232-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f75b0c06093b006d@google.com>
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/stddef.h:8:14: error: incompatible types when assigning to type 'struct iommufd_object' from type 'void *'


Tested on:

commit:         2af9b20d Merge tag 'x86-urgent-2023-10-28' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb98fe061049a6e4
dashboard link: https://syzkaller.appspot.com/bug?extid=d31adfb277377ef8fcba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178165a0e80000

