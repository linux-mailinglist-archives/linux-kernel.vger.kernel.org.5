Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A347EEED6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbjKQJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjKQJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81673C4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700213981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zFpOQ5yGviDFGUEyfb/cWN5zEo2Xx0/MmoU64MafAg=;
        b=IppIzM2LoP2HbumGRB4CpFUzKFD04aNO4PNoogDpt+1vexxLnLZIBqZ2DUSZKmbwtZGvSL
        BsUwm32VpN2HB3JJFBjQxA2M6ROmSXVTeWxFdA6/wus2h3EWHkPk5xsuQKTkl9/H/PAdqP
        XHntqBUy9dcuNiLGUQuZXGSdILKbzcg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-9uxd4RXwP-uLazsTzPwv_g-1; Fri,
 17 Nov 2023 04:39:38 -0500
X-MC-Unique: 9uxd4RXwP-uLazsTzPwv_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF83728237C5;
        Fri, 17 Nov 2023 09:39:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 993A240C6EB9;
        Fri, 17 Nov 2023 09:39:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 17 Nov 2023 10:38:34 +0100 (CET)
Date:   Fri, 17 Nov 2023 10:38:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>,
        boqun.feng@gmail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wander@redhat.com, will@kernel.org
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
Message-ID: <20231117093829.GA32151@redhat.com>
References: <000000000000a25ea7060a430d3c@google.com>
 <00000000000064b787060a55354e@google.com>
 <20231117092730.GK8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117092730.GK8262@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17, Peter Zijlstra wrote:
>
> On Fri, Nov 17, 2023 at 12:49:04AM -0800, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 2d25a889601d2fbc87ec79b30ea315820f874b78
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Sun Sep 17 11:24:21 2023 +0000
> >
> >     ptrace: Convert ptrace_attach() to use lock guards
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132b7d84e80000
> > start commit:   f31817cbcf48 Add linux-next specific files for 20231116
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ab7d84e80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=172b7d84e80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d797680000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b1ec67680000
> >
> > Reported-by: syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com
> > Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")
>
> Hurmph, let me pull that patch from tip and go have a look. Thanks!

I guess

	scoped_guard (write_lock, &tasklist_lock)

is not right... this needs write_lock_irq().

I didn't notice this when I reviewed this patch.

Oleg.

