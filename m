Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCF7B2A60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjI2CqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjI2CqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:46:19 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA6199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:46:16 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-573b8245f9bso25024950eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955575; x=1696560375;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf0tg4B6gTsy7B5C3/7G/qTxuD3nPwZk033E7oRAoMQ=;
        b=TykQtyuMdRoxD9pwDLTxM9Ax9QMDMTqMxe1eQsrCsK43GzIy6211jdhW+jUjiV0Y3U
         n1Xq6uXQH5mSGa9rcnKr9CHeL5X3E34ODloVc9ogwpEkH9iefrqvyc4m8Hiu97FS6Mu8
         SmUfXlZ0kGN9We3ZM1xNcm4kvbF1jD5IEwepNal3bFo2IDNadpPM4nquEZTsLXm0gief
         U/u9UbJlTcE2JrrLBUF3UZ2pzusj6LxjO6ORvSLrH/Nu8zMq1Q1AhQGNWwYOqt2AM1h8
         xTuf/HHcf2HL5GK66Ljky3N3fs4Q3aD/0/TXZ5J7RE8u0CTuHki+5DG8cBwM31JM6QO/
         xuqQ==
X-Gm-Message-State: AOJu0YyrY01K+p2Xg2DYQ0zS/P/Pp21VUxUYInVr5AbIueUkOWmcYPBs
        a5mDa8V/6GrRtG9Sd5070EpTgNg1WJBjKEN06fFKXjT3COw7
X-Google-Smtp-Source: AGHT+IEQeTrF4AbuXTCWyeZYTYVyh4xbRCNYCDVmJLyslhEx7cvAez/6SbhpOgULPamF0pFnaZXr577T62hWbpUevOw2l3uVYJdT
MIME-Version: 1.0
X-Received: by 2002:a4a:2cd0:0:b0:57b:3840:4c85 with SMTP id
 o199-20020a4a2cd0000000b0057b38404c85mr832728ooo.1.1695955575400; Thu, 28 Sep
 2023 19:46:15 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:46:15 -0700
In-Reply-To: <0000000000006452210601115981@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0708b0606766d7b@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in drain_vmap_area_work
From:   syzbot <syzbot+fc9127d4bfa8ef129f7d@syzkaller.appspotmail.com>
To:     bp@alien8.de, brauner@kernel.org, dave.hansen@linux.intel.com,
        edumazet@google.com, hdanton@sina.com, hpa@zytor.com,
        jhs@mojatatu.com, linux-kernel@vger.kernel.org,
        michal.kubiak@intel.com, mingo@redhat.com, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 8c21ab1bae945686c602c5bfa4e3f3352c2452c5
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Aug 29 12:35:41 2023 +0000

    net/sched: fq_pie: avoid stalls in fq_pie_timer()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111ab276680000
start commit:   fdf0eaf11452 Linux 6.5-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=fc9127d4bfa8ef129f7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103a7aaaa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177aa662a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fq_pie: avoid stalls in fq_pie_timer()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
