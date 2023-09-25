Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F047AD74C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjIYLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:55:34 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBADDA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:55:27 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ae214a02a6so12244854b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642926; x=1696247726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJysYUBTudzCJaC5ycCUZJm2e0YF/I5kcWtF15e4Fdc=;
        b=HNFK61kkWKQIx33Vhpjk9n300yKnXt9FUGA2RW4qdrMR2WIrLhiQF8IqhOUVpGLgfX
         RU5b0UKdBJ1f7lfvwftTKreHeKZHYNJyOW7bOuYf4+CZGj3vfq6f95VIHc+NriCJ/8jK
         ShdpM/1FqguiRE387p+GF4s9L96PjqPqLjAgLqo/tPldc03EKSrLhQtdUK2oAr5Iajz5
         wnMQPowgj45TkFv2ENr3lj3gT0qKq8KpKPcXA7bvBsyQzmi0VPqIMoqqzCmh/d9T5VXH
         w9nQ7/siz/GFB7Zwpy2shxJjnk46lBVBB4ymCMqMH0Z3I+DF+466e6LCyyWey52nyluW
         oN3g==
X-Gm-Message-State: AOJu0YxEGdiwucCIeI4f4Vl20P4imKIrie2XjF25T+ka9Fif8EiQUwqK
        Cg2kzLxOqnRiVm/33Qupxdhx16mGeBxbuhRmKNhP8jeOqrmx
X-Google-Smtp-Source: AGHT+IFAcAn45kItchAUgSWnxHagzXzt3p5LJ66zKO8Mh4B2rhrC/tnR+O9EXoGAIhW/7FdiZUGHPECMYUufV71m7IQn1sjj2jDB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2199:b0:3ae:c95:ad2c with SMTP id
 be25-20020a056808219900b003ae0c95ad2cmr3860207oib.0.1695642926434; Mon, 25
 Sep 2023 04:55:26 -0700 (PDT)
Date:   Mon, 25 Sep 2023 04:55:26 -0700
In-Reply-To: <00000000000035aab005ec690a00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bd00c06062da279@google.com>
Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     daniel.starke@siemens.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
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

commit 01aecd917114577c423f07cec0d186ad007d76fc
Author: Daniel Starke <daniel.starke@siemens.com>
Date:   Fri Jul 1 06:16:45 2022 +0000

    tty: n_gsm: fix tty registration before control channel open

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d431ea680000
start commit:   a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d431ea680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d431ea680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b1ca83880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1023c5e3880000

Reported-by: syzbot+893c55305230e719a203@syzkaller.appspotmail.com
Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
