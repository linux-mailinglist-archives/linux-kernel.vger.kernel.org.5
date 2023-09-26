Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C807AF682
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjIZW7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjIZW5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:57:51 -0400
Received: from mail-oi1-x246.google.com (mail-oi1-x246.google.com [IPv6:2607:f8b0:4864:20::246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A917EB6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:38:29 -0700 (PDT)
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-3ae4cefe17dso10016492b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764307; x=1696369107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrujW9fuUJnGCukcO08Sc48BocArkHwApSrdDVAkMsU=;
        b=EHJuNeuTkfvCm4HKCRnY2Lxm4BpYvx+0OT6toVkS6bFk6QJfVZFMl9QAWmfe/ZSadc
         ZTIRoyuZA5a2l/Mtf6f+QwISKPLzoUZMPnfhzsmcMxmiPDgz89sRBcLVbtOGJDJNTlnV
         HiNLwhW9cVvkG+Pr0943C1QvdB2VsPVdBRlSexWs3EY83vd+xaImIri1ZE3uYiBI3iJb
         2KbI9PHZpyY/4xlfwJhAE0CteKpfV4VxZBp1x811HDH3MAT7DyMmqoC4EBt45JPSwXLa
         PnRFWAq3iIf9N9NfoYBoThKHWrrgAaA1YYPVQp7iFt8Qg0R5BaZ1gI0TXVr3Vtj1onGi
         kMXg==
X-Gm-Message-State: AOJu0YxxeWIR2hFfM7b45OuQJShQXScO2BvNOSxH14lG9gGtT4D4K+j2
        N8tgWfh6SK1KWcv4Yk1T4U6bimggYl9ppMU85TAWzzX9QHXV
X-Google-Smtp-Source: AGHT+IHqUNvgj8r/sXHE/1psfIuTkefZXsSeZ3RVACSIBoFlYFfchd4gvfMw4G4oZMJnX1y+ZSBluLCG4GwUpEjncSbmx9hI9CeO
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2018:b0:3ae:1e08:41e7 with SMTP id
 q24-20020a056808201800b003ae1e0841e7mr90974oiw.9.1695764306911; Tue, 26 Sep
 2023 14:38:26 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:38:26 -0700
In-Reply-To: <0000000000002c6cf80606492f14@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022eedd060649e522@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_mprog_pos_before
From:   syzbot <syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116ab4b6680000
start commit:   a59addacf899 drivers/net: process the result of hdlc_open(..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136ab4b6680000
console output: https://syzkaller.appspot.com/x/log.txt?x=156ab4b6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=b97d20ed568ce0951a06
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc3946680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107f4e1e680000

Reported-by: syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
