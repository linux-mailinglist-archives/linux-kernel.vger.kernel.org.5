Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997AA7FD66F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjK2MRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjK2MRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:17:06 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB3D7E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:17:05 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be3799791fso8486961a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260225; x=1701865025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm0iiEEDW67QXAU5hmtno74YGdHPjqHpci2ImvBkZog=;
        b=BEvBrynnCnzl5IzHugNJTo3Ix7FtsWA/Y4hib/A5Bjzc0gqHh2v1VqZBV8beQ6suYq
         aScmkF1oNCSNz4LGaTEqlE0rpE7LyVc6TgP0EAqqFbQ7AQ3Sh9I7QuaqzzIzGX5nB6FK
         Cyo9F0qnIMqu1Fp6DW385geCr18eOicBbvxckivv52ukkPia/rJ2qnnBjOMOpOD4I7YE
         CP7eurzAK3fSk+AmYq8vcDYRLMhSpftSgc3d1xXqHquBydgaqpmW9ugHUUOF3zYKrrBA
         eNOTUqIcri4a8JozikerHXywLYFLeo4Xd+JM54agY3B1bpuZ6xisVBlk6CSK6wEueoOx
         yekw==
X-Gm-Message-State: AOJu0YwRAS4EOcG7XuE+qEbj73YAIe7ZWT6iBCKxxfvBFInme9Y0tjHW
        VZkADVGcdcImNEQJ5aYTR+AnplY+qVyb7whIC9rSgDlBAvJ7
X-Google-Smtp-Source: AGHT+IHm5egSj7drq/h6+tM2rakLRXVKiS/fewy4S6Rq3VCjTdYJQzjNbgFLIYLHh4HPavMnmoOq+9UCKki4IZlbNFEDmoS03isK
MIME-Version: 1.0
X-Received: by 2002:a17:90a:2b86:b0:27d:e40a:96d3 with SMTP id
 u6-20020a17090a2b8600b0027de40a96d3mr3758871pjd.2.1701260225232; Wed, 29 Nov
 2023 04:17:05 -0800 (PST)
Date:   Wed, 29 Nov 2023 04:17:05 -0800
In-Reply-To: <000000000000d9483d060901f460@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006547d3060b498385@google.com>
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
From:   syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
To:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a71ef31485bb51b846e8db8b3a35e432cc15afb5
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Oct 24 09:42:21 2023 +0000

    perf/core: Fix potential NULL deref

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17172162e80000
start commit:   6808918343a8 net: bridge: fill in MODULE_DESCRIPTION()
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=429fa76d04cf393c
dashboard link: https://syzkaller.appspot.com/bug?extid=756fe9affda890e892ae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12db572b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10839a1b680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: perf/core: Fix potential NULL deref

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
