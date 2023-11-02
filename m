Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986F7DE938
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjKBAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjKBAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:14:10 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02960119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:14:04 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b5665e00b6so627635b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884043; x=1699488843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o8M4olUhxGuYhfUSjcCSpJU5SY7A9yJ4TSgZavfZUU=;
        b=txw5qokwXrkTl+V6yjOCmndyPJTgQ00UxM228V7SR4a885CCOtkQCdc+WzRT//peUO
         Hx7aPpGWrSWD/UBVNe7MXK/iQpE2+aruV2wBYBaGrqAEAa7SZKGDA0f8NBrzF9qIJyzd
         807oeiMO2gsDS/84asJWOECDIv6QIlfIvfQa/o2JkDN0gwuRL4PwP+0h3B7bgZWVKYRx
         l0/k14UQ8yEPcqY0M175ggnwpw/lxsdJWtoNDyf5WPOLm+AcxipkEkH2pdDnF8M2jEZK
         ONS29fc0KUiaBsCxyRjJOEi2nHjI91odKxYoDpoclir6SSgSGWPmmLDHsj/z4ThPn7Jy
         i5QA==
X-Gm-Message-State: AOJu0YwJt2Zd4jBZipBE7A6lLJxZG/7aK0vgxvsSS/fQICZysy1WIMt9
        9m2FPN39hSrUEF2q8JgC8hcQoRbN+GwD05VqqtFIqMPeIDqR
X-Google-Smtp-Source: AGHT+IGXujbYdoaOwMiOFafFIW9sSBBYTm1Pp7ERXnBxyhbhAcfk6UQLTv/cxWX2Xmxo1xLz6z1fbF2B0KrsJKybb/11d1grAeua
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1304:b0:3ae:15b6:3292 with SMTP id
 y4-20020a056808130400b003ae15b63292mr6713187oiv.4.1698884043406; Wed, 01 Nov
 2023 17:14:03 -0700 (PDT)
Date:   Wed, 01 Nov 2023 17:14:03 -0700
In-Reply-To: <0000000000003495bf060724994a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec03e20609204362@google.com>
Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in worker_thread (9)
From:   syzbot <syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com>
To:     admini@syzkaller.appspotmail.com, bpf@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, horms@kernel.org,
        jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1758e1e3680000
start commit:   1c8b86a3799f Merge tag 'xsa441-6.6-tag' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d8e1e3680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d8e1e3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155614de680000

Reported-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
