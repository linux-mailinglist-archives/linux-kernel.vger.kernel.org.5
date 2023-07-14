Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35CE753E83
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjGNPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjGNPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:11:33 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BB30D8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:11:32 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b86c0d3b5eso3248290a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689347492; x=1691939492;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCLOxUsPk9gij7lrd4gl3ju7/pLr9suuyXvJ5OtLAUQ=;
        b=VnWPTfNAYcuYIr8jm6puOP13zh0IaQZPqfvKEn4OZSUm8HGksxrt7E2M2PN7y5jmK7
         5leDQBl2DDt3y/kRyWG0mzQH8q4kafqYRQ0kkaE3Hu3CwneynzKNMojEMvw/0Atz0N1c
         FFIGzXsqFQ+23ajpDYf0P8s+NQWwfEHBNPwpDGCGhbT3QcJ2X8ySLrzOY6EhGeDba35w
         nS5qvr/ZlsgyLLTqikPAOaGI1Ssr8OABqG5zgqdJD0YSdLAAsI3Hf4s1cArIliOjtjtj
         Wpqs877FO1YKW1MWhsLde4Tg8XsdW/CAR3fFCrnslmRxJ1stk5z8sV+jOy96uiQX+ivT
         aQQw==
X-Gm-Message-State: ABy/qLY7fTc2xn9+vQFuflBUWfvlMXy6gQ3sov51HgIbIcXpvYHJsbOu
        yuowFOB6wnrVXwnpPSDIAgnojnuL+ZZYkZB9M3L5Fm3ubdpm
X-Google-Smtp-Source: APBJJlE6TyCcdhAUrsmWbb8fvxPE8mWG/ukHNruZoQLsPGdacASBBgg9EA/N2Q99G1L6A2y+bsP1WGM7Wx8B6uHLvOQRaJVtfrE4
MIME-Version: 1.0
X-Received: by 2002:a9d:7488:0:b0:6b8:8894:e4ac with SMTP id
 t8-20020a9d7488000000b006b88894e4acmr4268213otk.3.1689347492003; Fri, 14 Jul
 2023 08:11:32 -0700 (PDT)
Date:   Fri, 14 Jul 2023 08:11:31 -0700
In-Reply-To: <0000000000005921ef05ffddc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029c576060073dd62@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5eda1ad1aaffdfebdecf7a164e586060a210f74f
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Wed Jun 28 08:00:56 2023 +0000

    f2fs: fix deadlock in i_xattr_sem and inode page lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1177322aa80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1377322aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1577322aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336f364a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130a365aa80000

Reported-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
Fixes: 5eda1ad1aaff ("f2fs: fix deadlock in i_xattr_sem and inode page lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
