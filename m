Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62A80EBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbjLLM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346561AbjLLMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:25:57 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8583FD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:26:03 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5905109ccb0so6776042eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383963; x=1702988763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB8C7XyMYQp9js6I3u3+HREkfx35O/WPhq62642Tn6U=;
        b=dV0CMqspB11hX/PRAHGE/f5wFUKiAjleRwJPh94H9B5DLUsdB9zVVPk4MaoWmQDLqh
         wybfxxQITRVw2alL0ZpAgtwSnZgc6KXCBQkAcCQIhvI46XVuElscqsxxBdXlB0X3uRLc
         3XTtbwgX62CffV0/G/GxQv35Bw/Q9wP2GYronDPEW7NukzaWyADj//enLi+SSOv8VbNm
         tedD5mZvuyhqiw7VZ94PvRl72oKp6yyFAqY2IbIRPpj+GxGhBbNTGvHOZAT6vPzjObDk
         F9t6wXm50DojldelQ2PcLZ+e5ls59g8vb5mYH/iTfXAcJX2+Rqmuzs0Dlwe7hlR/RqDO
         ceHw==
X-Gm-Message-State: AOJu0YxzROySvYPLTC0THARxJiNPBvq0/7tsFidOP+LKD34ylZam+Pic
        KnMmgByUMbnO59sOexBvRTlLgE5DjYFKcqsoiz62DMXRZMqd
X-Google-Smtp-Source: AGHT+IGFW5g3e6mA+LgWx2H/a9Cj4ZanQsFcd4iCXcghjcM04EBeoSn1GE5TRIxUvox8ZXjQik4AEtVZhFon/5TqCSJsXq9c+Xd+
MIME-Version: 1.0
X-Received: by 2002:a4a:3149:0:b0:58e:2832:83d5 with SMTP id
 v9-20020a4a3149000000b0058e283283d5mr2236155oog.1.1702383962863; Tue, 12 Dec
 2023 04:26:02 -0800 (PST)
Date:   Tue, 12 Dec 2023 04:26:02 -0800
In-Reply-To: <000000000000e7765006072e9591@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060c000060c4f2747@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
From:   syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brauner@kernel.org, daniel@iogearbox.net, elic@nvidia.com,
        haoluo@google.com, jasowang@redhat.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        mst@redhat.com, netdev@vger.kernel.org, parav@nvidia.com,
        rostedt@goodmis.org, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yonghong.song@linux.dev
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

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c0b21ee80000
start commit:   2ebe81c81435 net, xdp: Allow metadata > 32
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c0b21ee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c0b21ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b2632e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aae88ee80000

Reported-by: syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
