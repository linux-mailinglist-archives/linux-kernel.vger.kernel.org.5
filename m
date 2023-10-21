Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE237D1F45
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjJUUDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJUUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:03:38 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D71A8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:03:32 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9a82ec471so3279657fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697918611; x=1698523411;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAzTyFISqHdjSyvCMXj3Ko54bxjdlHu7tjC7EE4Bclk=;
        b=GYuQ5ZGfwgmjP+u7XRxG8ghvhsgnGGP8qzvRraPGGhdDo/+NzFuGqc3Yft8lNhi4vR
         D2BaWNvDSYf8bjj55ZDuqLvLEwjex0dyOdW8ifULjP0hIjsQaQJ0Gv0ZlQ+tMghAq5YE
         bBWsSavLAWNR60p8wqAzStUFLPeeOdQzQgil7HIgn+NU2qSXc7CmgQ4PuSkXCe3BbADd
         iK8Hzkw4nRDwfmNmwhAEJE17ESPGi5Iw/JppITLnNEUe9GQE3SkqkIDVL3UAeMBoix+R
         3HBaGhgtP2uAkFh6M8AoTPR2l+jM5cvjca4XIo8bYbeRjJrPU1TCUoMcpcZAjNyZCvZU
         mNIA==
X-Gm-Message-State: AOJu0Yyqyp2iBXznuvVCLl5S6Vqnyvs+hvOeg+XQ0wCZNu1ZLVBXuiTJ
        Yw/SvDUoJlLc2DtrH0sGWCjzm7PlKt7AAQ6GnFzBIF91eRW8
X-Google-Smtp-Source: AGHT+IGp54TDvOaC30bVb/2e7+ssX1s1YmK9GXb8Z+InCir5Vag8UcafHsFUhYKPux1Sx6Z9mt/2BVsltYo1xzUr9MU+BK0yKHjl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:f205:b0:1ea:2dd6:6a86 with SMTP id
 t5-20020a056870f20500b001ea2dd66a86mr2577551oao.9.1697918611301; Sat, 21 Oct
 2023 13:03:31 -0700 (PDT)
Date:   Sat, 21 Oct 2023 13:03:31 -0700
In-Reply-To: <0000000000008f824606052a2d9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af2dbf06083f7baf@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in wpan_phy_register
From:   syzbot <syzbot+b8bf7edf9f83071ea0a9@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Aug 28 14:58:24 2023 +0000

    driver core: return an error when dev_set_name() hasn't happened

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea2e89680000
start commit:   ac28b1ec6135 net: ipv4: fix one memleak in __inet_del_ifa()
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bf7edf9f83071ea0a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14871d58680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ace678680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
