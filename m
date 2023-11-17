Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248827EEE86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjKQJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjKQJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:29:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1991A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WZAsom5r4sgfe97RIp0Yh6+r03GE2Pl10AtA9l+P7s8=; b=g5ILzhCG0OX8VHokKKS25WlOQi
        12kvFAdpdnFEQJ0lWfnhOfVtzXJgbv4xBcpbhyEifnkMNDrrk9GjB8ib50IhLrDrGoWzgNlGBFVYv
        P3zWF2kwQPUDDV5/y12GOH09n5D0DfSiz1hQhLVf3wZNdnpNHT0RRSOSd0q5YELBdtFcpFp5et7FN
        PCAkrSQh/bJG79jx0aXA60RLO5F+8mvEaiz2iktCsx/qYTwal78zcEEv8wjz+zz9JoYEfks/yDRZ5
        Z2yAICISHnkPw+H+xM0aLT3/XOkpyhbmyd31an1uTpwHubKWb6dwFaEKihXV2NXk48SIBniF/KFVc
        1W5/aPSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3v8M-007B8Z-2V;
        Fri, 17 Nov 2023 09:29:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E2F7300478; Fri, 17 Nov 2023 10:27:30 +0100 (CET)
Date:   Fri, 17 Nov 2023 10:27:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>
Cc:     boqun.feng@gmail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wander@redhat.com, will@kernel.org
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
Message-ID: <20231117092730.GK8262@noisy.programming.kicks-ass.net>
References: <000000000000a25ea7060a430d3c@google.com>
 <00000000000064b787060a55354e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000064b787060a55354e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 12:49:04AM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 2d25a889601d2fbc87ec79b30ea315820f874b78
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Sun Sep 17 11:24:21 2023 +0000
> 
>     ptrace: Convert ptrace_attach() to use lock guards
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132b7d84e80000
> start commit:   f31817cbcf48 Add linux-next specific files for 20231116
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ab7d84e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=172b7d84e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
> dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d797680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b1ec67680000
> 
> Reported-by: syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com
> Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")

Hurmph, let me pull that patch from tip and go have a look. Thanks!
