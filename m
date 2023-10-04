Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0632D7B85A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbjJDQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjJDQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:45:42 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6FBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:45:38 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af64a4c931so59437b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437938; x=1697042738;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxK2RXD2bOgzxh1BIYIHwF4FqtGpBF80iTPbZHI2mEs=;
        b=kwd+co2mHnhH8TtBfGke2wh0+vhU6t4rX4/+LNZSJmTfYO0HdasSzl0Z/+SB/sjOco
         oe7/kRLx4KCoMCP/TAdQzPkkhE4pLTpb+QlRy2z96mLFEaHSKLz3KZfFlQAKTBLDsWbJ
         SL3i7mGjsIq2c2mCZCfwziAAoaIXYtCJZbnHP86AB9rdK3mndmhC2gtdOGRbjbeXx1Mg
         EJnzda9fwCdOO7ju8rdcrMRFHpDRFDVm1MxDAxSXChBji2paG3G81roT0TsMT/wjwhrb
         b8menSoOdF/9oVEUuFQm0NXpB+edaBj8ACF288QoT7Hdfxxl3O6FOv9gvtwyTeBIgGrJ
         CACQ==
X-Gm-Message-State: AOJu0Yz42aSbNJHT3TMtE9+Oyf3XYq2JDFVsjGl+Aevkxw8ZEmFsp/Ac
        S5SCnd3QIjZt5yseC26rH/3gYhH+LRJNeZ3F6fdvDhX7slvt
X-Google-Smtp-Source: AGHT+IH9LBqUAa3Czu2Ikd6so6wJCoEmqsI3B4Xy7BXDcw+NDdCsxu/Ij5v71RF5EfonX4kuJiuXe/Pq4wMLTbsrWqQGUZ97gxGX
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8e:b0:3ae:17ed:fdc9 with SMTP id
 o14-20020a0568080f8e00b003ae17edfdc9mr1421317oiw.9.1696437937945; Wed, 04 Oct
 2023 09:45:37 -0700 (PDT)
Date:   Wed, 04 Oct 2023 09:45:37 -0700
In-Reply-To: <00000000000067d24205c4d0e599@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000accfd30606e6bcd0@google.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzbot@syzkalhler.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 708fa01597fa002599756bf56a96d0de1677375c
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon Apr 12 10:00:37 2021 +0000

    ovl: allow upperdir inside lowerdir

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ad11b2680000
start commit:   3aba70aed91f Merge tag 'gpio-fixes-for-v6.6-rc3' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146d11b2680000
console output: https://syzkaller.appspot.com/x/log.txt?x=106d11b2680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1304fba6680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cec0dc680000

Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
Fixes: 708fa01597fa ("ovl: allow upperdir inside lowerdir")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
