Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4137E5193
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKHIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjKHIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:03:07 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E59F0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:03:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2f2b9a028so9022693b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430584; x=1700035384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLxkoJ0J2bDcVFhjdD1ByIlE66SDaLG2rCYjwFdMcfw=;
        b=ZPVFk+jvLKBSEh1t+wsyvrI6arte9gQkfBU2+iWcTcvB7NHUGPIcmGWXjokCv/pXuU
         uJPLCb1jr710vR3VAFsTeXDi4qle9yC1r6PibfePPcCezqtkdjDCjY2Wss5RAUJeoTCK
         Rm4afEU+hGqKiJL0JAU39YOWf94v/NGCCmfpfUHIwFMiB/1zgfyOdUE9x8+tF75wSwOR
         bpd6OBBbn2Gcgu8UxQFQZrzEUc+Xpnqh2zTwHJyuOIDV998uteLJceC9R7+K4W628SFO
         7kQIhSGeqQ+B9TPZzhNGR33a1B204NmM/969Zs0LHmhGYC3D5xme8SHr9CdDCw3ZuOWG
         c7EA==
X-Gm-Message-State: AOJu0YyFq0kL0t2Fzgr/C07dxPaEQ6+9XOC8VQOapAYZR+5wVZ0KeQFf
        gIK/o66CjRMpXnLn0TcOEsQpGqyY1uGM/gdE0BB97lyj/0O+
X-Google-Smtp-Source: AGHT+IFaX5LC4+c28UiyOy/nAi3zs6InloFZr1OolB/cB0NXkbGGJtuSl1zjrihF1453Xy0W+gcaNotbRS9cwtvEwE4TbRPga8XM
MIME-Version: 1.0
X-Received: by 2002:a05:6808:201d:b0:3ae:61f:335e with SMTP id
 q29-20020a056808201d00b003ae061f335emr581414oiw.5.1699430584749; Wed, 08 Nov
 2023 00:03:04 -0800 (PST)
Date:   Wed, 08 Nov 2023 00:03:04 -0800
In-Reply-To: <0000000000009e122006088a2b8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053135d06099f84a3@google.com>
Subject: Re: [syzbot] [dccp?] general protection fault in dccp_write_xmit (2)
From:   syzbot <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, davem@davemloft.net,
        dccp@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 419ce133ab928ab5efd7b50b2ef36ddfd4eadbd2
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Wed Oct 11 07:20:55 2023 +0000

    tcp: allow again tcp_disconnect() when threads are waiting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142a647b680000
start commit:   ff269e2cd5ad Merge tag 'net-next-6.7-followup' of git://gi..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162a647b680000
console output: https://syzkaller.appspot.com/x/log.txt?x=122a647b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53cdcbf124ea14aa
dashboard link: https://syzkaller.appspot.com/bug?extid=c71bc336c5061153b502
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142bff40e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1559f190e80000

Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
