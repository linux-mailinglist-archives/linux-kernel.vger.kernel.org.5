Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD87C7894
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442911AbjJLVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbjJLVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:25:35 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A3CA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:25:30 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3af5b5d7ecbso2209931b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145930; x=1697750730;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3QvOYTxISpyAN6lBZKnAumWUoCDT9rshpzEVP85mU0=;
        b=WqDRGiKLtzjqy6Be5V5hXdK09NjORbx23aYfhoaboCoeg44PRTN9RKNyOIJk/93VhY
         WbS3E8UhBQ32vr4HUxhFdM51ppZr8wflGa3MKksGiZTD3rSQYh5QIoxmaDqxkqwFkyfX
         buCo0lYc0xtanNobYmQ8Cob6E35KTWkglo+2QztB9wQzGNFvK8xz0vu3d0VbValrir4n
         kbMTr/Eh3xRgTE3jbnwZ4amAK0T5EhjIVxUyzg4sFZcmnmxrIf0wt3eAjuKgBCH7dH+c
         P4x8C7uU+4yCt+IWdOS2G04sSHIvCFOl4wAvvyK9y++UGdKle1yyXdEKvfPCvTCc0o19
         HilQ==
X-Gm-Message-State: AOJu0YwiXMysv76kR2gRkxvbLLTJtJEaea9dtarodYCFSEoAlhAc4bPz
        wY/6NF5Nq8/dIplvaiawjK6A+7nDvM1v3cU4FvO0XRBKK5O0
X-Google-Smtp-Source: AGHT+IHr9VDIw51thCNfY4Z/TaWoINBr61iwfFvvmuyI7d/MHpnu5HUkhyeevkB5Mp+bdpbYs9dP9oQ7BgdXZ0/HorlKMMmV8cNc
MIME-Version: 1.0
X-Received: by 2002:a05:6808:308e:b0:3ad:fc2e:fbc6 with SMTP id
 bl14-20020a056808308e00b003adfc2efbc6mr13661508oib.10.1697145930065; Thu, 12
 Oct 2023 14:25:30 -0700 (PDT)
Date:   Thu, 12 Oct 2023 14:25:30 -0700
In-Reply-To: <00000000000006e7be05bda1c084@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b2b3d06078b94b0@google.com>
Subject: Re: [syzbot] [net] [crypto] general protection fault in
 scatterwalk_copychunks (4)
From:   syzbot <syzbot+66e3ea42c4b176748b9c@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, bp@alien8.de,
        daniel@iogearbox.net, davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        liujian56@huawei.com, mingo@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vfedorenko@novek.ru, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit cfaa80c91f6f99b9342b6557f0f0e1143e434066
Author: Liu Jian <liujian56@huawei.com>
Date:   Sat Sep 9 08:14:34 2023 +0000

    net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17338965680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=66e3ea42c4b176748b9c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10160198680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15feabc0680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
