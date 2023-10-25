Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECF7D607B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjJYDVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjJYDVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:21:48 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8836B4;
        Tue, 24 Oct 2023 20:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RRWPW0Tmq4BzTIASOKohK9MzMNeD1MHxe0hCDD+OqzY=; b=rTMO44lfv+UT8zAn1Sn3VS4Cvg
        XP/KZED5YQE7FrOjeO3RBhq8BKSMKQ9f6uxzVP3XSmI6EzLYSuSMh4mWgrGPNRbGSVntIIawlc4mV
        Xq0vUK7HrEF7go3wKOhv9Ak16IcxzaLFuZBXPIWBtstumyYDwb1Y1uWwjt6/YxVFIRH5Nk3Y4u6dY
        eAf1h2nmD3fkWBuhGK4Y8YFPtqkBhrNIHC+G9srXlAdhNYW/UcwYmc5bNTZBHQU6Y6lL4GWKUXpOT
        1dw6dJe6ymRoPfeTTURKnSKNZTYoWA6N46Q2EGhqwxIbB96RmCDWS8t7YSJdVE7ccJmNEyFeNbmSO
        BycaglqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qvUSb-005F6T-0J;
        Wed, 25 Oct 2023 03:21:33 +0000
Date:   Wed, 25 Oct 2023 04:21:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
Message-ID: <20231025032133.GA1247614@ZenIV>
References: <0000000000000c44b0060760bd00@google.com>
 <000000000000c92c0d06082091ee@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c92c0d06082091ee@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:10:38AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 0abd1557e21c617bd13fc18f7725fc6363c05913
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Mon Oct 2 02:33:44 2023 +0000
> 
>     gfs2: fix an oops in gfs2_permission
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b21c33680000
> start commit:   2dac75696c6d Add linux-next specific files for 20231018
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b21c33680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b21c33680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
> dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c8d09680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a07475680000
> 
> Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
> Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Complaints about rcu_dereference() outside of rcu_read_lock().

We could replace that line with
	if (mask & MAY_NOT_BLOCK)
		gl = rcu_dereference(ip->i_gl);
	else
		gl = ip->i_gl;
or by any equivalent way to tell lockdep it ought to STFU.
BTW, the amount of rcu_dereference_protected(..., true) is somewhat depressing...

Probably need to turn
                ip->i_gl = NULL;
in the end of gfs2_evict_inode() into rcu_assign_pointer(ip->i_gl, NULL);
and transpose it with the previous line -
                gfs2_glock_put_eventually(ip->i_gl);

I don't think it really matters in this case, though - destruction of the object
it used to point to is delayed in all cases.  Matter of taste (and lockdep
false positives)...
