Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2677999CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjIIQZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjIIQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:12:41 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6719E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 09:12:37 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5704126625aso3555022a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 09:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694275957; x=1694880757;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7nzmSUstAY9iXOgzx0SrvI4KAmIBqP4eruzpfGoWhE=;
        b=mgWofsz0BcUbNtCKH4WMbX2S8rXj/kLZkoODuVrTvoZy9zd7LJcInmXWotXpf2z59p
         EXxUZadyLML5jvBTO59TXPBUc71OFJnpoFLOHtrT64musmazXl+Fyg8GJu3KspS3BNvF
         dwSIv1xdIeGPkxWfVwMs1A/i8dHjv5DDYElIJDFrZTjJMfXIj9hKChIycIBsG2XHip6V
         2n8xdg5tnvCQ/tuMzQWabOMHgwWVOC7viLgpq9lxX1VTpRTvDopKrakO2hqOLe5/1zx0
         jD+Wly29feMpbmsTfHzDz0G8od9w0bJkRKDPzAWUO64IHSDwfKvxl381nfxKoTLGSH9f
         fm2g==
X-Gm-Message-State: AOJu0Yx1T3N7apwoqHwmwiirm6guMnjbtzyiWrY2v4IRxUNMkdrg+0Ai
        7y4p4TiXShWl2dHTvt3l/BhUHK8IlV+vMtQtuwQ3yxkOEmgp
X-Google-Smtp-Source: AGHT+IHB8tpqCVGsHysIYhKGMTC17bOoeqx6WIvtbuoYab8f/mFbkUgNQ45UMC/BR6WY4zyp3FT6rrxnhxirCoPnI1MWOUk84NMq
MIME-Version: 1.0
X-Received: by 2002:a63:2742:0:b0:577:460c:1d1f with SMTP id
 n63-20020a632742000000b00577460c1d1fmr392879pgn.7.1694275957183; Sat, 09 Sep
 2023 09:12:37 -0700 (PDT)
Date:   Sat, 09 Sep 2023 09:12:37 -0700
In-Reply-To: <000000000000d97f3c060479c4f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000945b5b0604ef5cb6@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_prog_offload_verifier_prep
From:   syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
        haoluo@google.com, hawk@kernel.org, horms@kernel.org,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, lmb@isovalent.com,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yonghong.song@linux.dev
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

syzbot has bisected this issue to:

commit 47a71c1f9af0a334c9dfa97633c41de4feda4287
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Apr 6 23:41:58 2023 +0000

    bpf: Add log_true_size output field to return necessary log buffer size

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132a4268680000
start commit:   fa09bc40b21a igb: disable virtualization features on 82580
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10aa4268680000
console output: https://syzkaller.appspot.com/x/log.txt?x=172a4268680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=291100dcb32190ec02a8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529c448680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db0248680000

Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
Fixes: 47a71c1f9af0 ("bpf: Add log_true_size output field to return necessary log buffer size")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
