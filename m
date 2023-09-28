Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03557B161B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjI1IeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:34:16 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA5B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:34:13 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c4e17f37acso20037534a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890053; x=1696494853;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gnCChu3OPSULseuxsND/OC3A1/+wMaTTBp9NGU091g=;
        b=nyj3nQ+BuxOG75Uj82dHP1yEKPuPqPJOkoPIS+MM+1pyWgJqM6x/3zUShoHiO6z6/I
         yuw13oC8p6pNWoX29gJw4pj5huK9AqlapD+dTgWPP66jYBK/5YQedl/InETeYZ3Ig3zs
         fIXGF9uXWv/bUUXAylmXQsFTaw0Hf0ztMDtKxlq5Gr7+v+etIK72vOhQJ3iTUTdGtZTB
         eutmADYN/+AQLMk12EpykyTKh//L/FXdfq09maPkpFMSL//BgZK3O+OjOOvvE0QPK5Hk
         v5Ilq25YrhEazhPWy/cTMNQKZ6E+KMUjva5NVQRdnJ64cjrsIK3C7Y9nrQoYeM3LrXsg
         m7Nw==
X-Gm-Message-State: AOJu0YzulUKHNWNQLaUu9iHWF+CfQcDuTcZbY69rMSRx8to8yyxi6vov
        dkjfzjZYet8JV3NJ93/7AXxBW9pzTaeQlp1+WhRaiTJZn0WP
X-Google-Smtp-Source: AGHT+IF9KchoAbdBn8cAF3kwm11v8WwkvIJGdTzNT7wPWDxuCnjFJvdAMeVTMBnzh5aDQ1IM6YlCQX0DcmnNmkK7BVifFzdxX4Sb
MIME-Version: 1.0
X-Received: by 2002:a05:6830:22d2:b0:6bd:b74:2dab with SMTP id
 q18-20020a05683022d200b006bd0b742dabmr137988otc.2.1695890053216; Thu, 28 Sep
 2023 01:34:13 -0700 (PDT)
Date:   Thu, 28 Sep 2023 01:34:13 -0700
In-Reply-To: <0000000000003dcc9306031affdd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003341ba0606672c7a@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in
 sys_clock_nanosleep (5)
From:   syzbot <syzbot+43cc00d616820666f675@syzkaller.appspotmail.com>
To:     edumazet@google.com, hdanton@sina.com, jhs@mojatatu.com,
        linux-kernel@vger.kernel.org, michal.kubiak@intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12958976680000
start commit:   6709d4b7bc2e net: nfc: Fix use-after-free caused by nfc_ll..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=43cc00d616820666f675
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10858fc0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14781270a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fq_pie: avoid stalls in fq_pie_timer()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
