Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C07EDDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjKPJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjKPJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:51:13 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E4C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:51:10 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be3799791fso749368a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128269; x=1700733069;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiNHOjfzTCRSZhLxgg5CyThWc28KBQzyvt0Gk1pd2sA=;
        b=N3kcFYbYEcC/SUTe9OJvPZ+lZhW2HjCXkQrqF3fTI/789tnA65dQwkCZACqCAzMYYN
         fX/h2enbOA5dEZT2T+0Zzn2/3WcG24giNrsoygxpT5l4R+XdOkoNxuizqb00vIqe7BMD
         a7LesY3tW5D5CieUaya2AY4ofes6VV4R0XUICLvN9PQtxa4KmAvyjxMWZAxSKtduHlpr
         GwP9NH4B9FU27ZjyM6dZiP7jB5cHN9kR2NCtrNJD5jRcI79sVJ4DMtKMWpWu+zPaA2ta
         67lk/28TbLIxuxoUaLh6TiIG/uOcLpBdROiPpnGgDWK3M6Odmhq2BwfmrGLedURUPEh8
         UPaA==
X-Gm-Message-State: AOJu0Yx7xXo72Tun2vTAGkLChBsPhjxCDfs9nBCqi17oPFIsjWs9jHyP
        ArJ2p6+AdpZPN16mb7nsAoLQyrrnsZX9yirRKdvRI1H3UAOd
X-Google-Smtp-Source: AGHT+IGFkiPFsgApk8aUnzxiA3nQo2YGU1aJ7rbgvlaLBurc6k5+bkMItSzH20RLWujRkf0/mfiX8H+dDfidMqvoyI7pX9pP4ert
MIME-Version: 1.0
X-Received: by 2002:a63:dd4a:0:b0:5c1:589d:b3e5 with SMTP id
 g10-20020a63dd4a000000b005c1589db3e5mr253325pgj.2.1700128269720; Thu, 16 Nov
 2023 01:51:09 -0800 (PST)
Date:   Thu, 16 Nov 2023 01:51:09 -0800
In-Reply-To: <000000000000ae5995060a125650@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096e7d5060a41f594@google.com>
Subject: Re: [syzbot] [autofs?] general protection fault in autofs_fill_super
From:   syzbot <syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com>
To:     autofs@vger.kernel.org, billodo@redhat.com, bodonnel@redhat.com,
        brauner@kernel.org, eadavis@qq.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e6ec453bd0f03a60a80f00f95ae2eaa260faa3c2
Author: Ian Kent <raven@themaw.net>
Date:   Fri Sep 22 04:12:14 2023 +0000

    autofs: convert autofs to use the new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d04220e80000
start commit:   4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d04220e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d04220e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=662f87a8ef490f45fa64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14384a7b680000

Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Fixes: e6ec453bd0f0 ("autofs: convert autofs to use the new mount api")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
