Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797187DE804
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjKAWVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjKAWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:21:11 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4E119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:21:04 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e9adea7a4cso576958fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877264; x=1699482064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWNK5rAhhP9EKmlHOfAbxlqIxZE8TUcPdTdYmSWehRY=;
        b=YHVofEsFK7WjdX+foIvYMRzXUNr2YMSI5m6vCA5VsAF4APDvZ7SIiI+b4JwqsoOGNu
         b5zxO93J6fKr6vAwJ3j25hL05s6udf8YpyHWL5O9+ZYSNQ1ZKuuwelXBllXVB5Avj8tR
         HN6OZ+cyOFPBF5cD0zPJfgO/D3sPL06cSj3AQE+lGdxLOqjCdcz/COOsl8PmydSaH7Oh
         EqGnd7MsKkMsvmrg7+n+Du3MPv0PdLEUBfrGy04JOAN4G5BYfHfkV5+lochn8nf5g4T1
         qOA4E1e7jtz7ce+972S9gM5G/inNit5zRTMfOdJkSVh/UW7vI5Hoq9VzS2NAPQoOKG7s
         SFFw==
X-Gm-Message-State: AOJu0YxeaCGZFUgVGpifd535oQPeKAvYIR/1zxjH5qR6MyThN9wHTaE/
        M+7wYdHzNQuJJveYs247dOn2kNm45dxG1L172l4uzNM8aJu6
X-Google-Smtp-Source: AGHT+IH2wTJ4HmzhxXTucKEBfV2iL5v7+phh6V0Xl9g/QR6TCjYT6jQ72RdDgWQhYCmbN3tQSngqCbQMM4C6fsGDTe/sHHuIiyTL
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8094:b0:1ef:9ee0:3378 with SMTP id
 q20-20020a056870809400b001ef9ee03378mr6285788oab.0.1698877263989; Wed, 01 Nov
 2023 15:21:03 -0700 (PDT)
Date:   Wed, 01 Nov 2023 15:21:03 -0700
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6502306091eafb8@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From:   syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
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

commit 8f5de6fb245326704f37d91780b9a10253a8a100
Author: Xabier Marquiegui <reibax@gmail.com>
Date:   Wed Oct 11 22:39:55 2023 +0000

    ptp: support multiple timestamp event readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1019f36f680000
start commit:   89ed67ef126c Merge tag 'net-next-6.7' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1219f36f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1419f36f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e3b1d98cf5a2cca
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd173b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce0840e80000

Reported-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
