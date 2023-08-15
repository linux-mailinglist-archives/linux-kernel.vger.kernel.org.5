Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2C77D283
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjHOSyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjHOSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:54:20 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD49C2123;
        Tue, 15 Aug 2023 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=//toRj/PKXJjaN9Lb1xLslhcEFyKob0fP3zRV2NepOY=; b=mCWSJQ3+0FPdTBBgkanltHH+rS
        rX61emmsNMIugv+6Tk4t48w3LC91RVFaSll2gmoJs0D7Hw25uL6zETFZQ/EzE4M4Iqotd6iVbK0dj
        ISvu1aPpkqNBzPnBilvnU1ofAUfLY7+pJeg4r8fyS69t6EdyoG9zMqyCbtGZYmaam8XtCxQMNZIYK
        wQGsTgw9y5pYdQd1L9XuvkqpTLhW8mf5K905JwJScL4prcbhGOaQ3GVNxgp73kHK75In9ag/LeAZi
        xUu89BGEG3Mv1T6Xrb6W6v2j7NACUQXHy6BJlpz+tdicBAERNe+Z0v70wLzZI5A6uIE/GLKq/UN3l
        7Jy0OXCA==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qVz9Q-0076hZ-EE; Tue, 15 Aug 2023 18:52:20 +0000
Date:   Tue, 15 Aug 2023 18:52:20 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Carlos Carvalho <carlos@fisica.ufpr.br>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNvJZIXIHJERRtwP@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <ZNvCJAclBEJf7uUA@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZNvCJAclBEJf7uUA@fisica.ufpr.br>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 18:49:52 up 40 days,  4:21,  1 user,  load average: 0.02, 0.03, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Carvalho (carlos@fisica.ufpr.br) wrote:
> Dr. David Alan Gilbert (dave@treblig.org) wrote on Mon, Aug 14, 2023 at 06:02:53PM -03:
> >   I'm seeing a few hangs on a fs after upgrading to fedora 39's bleeding
> > edge; which is running kernel 6.5.0-0.rc5.20230808git14f9643dc90a.37.fc39.x86_64
> > It was always solid prior to that.  It seems to trigger on heavy IO
> > on this fs.
> 
> Good news! No, I didn't forget the smiley... Maybe now the problem has become
> sufficiently bad to be visible/solvable...
> 
> 6.4.* also doesn't run in one of our machines, which has heavy I/O load. The
> first symptom is that rsync downloads hang and abort with timeout. 1 or 2
> days later the amount of modified pages waiting to go to disk reaches several
> GB, as reported by /proc/meminfo, but disks remain idle. Finally reading from
> the arrays collapses.

I'm not sure this is a related fault - I mean it might be, but my
failure is much more deterministic; it seems solid on 6.4.x to me, but
just fails reliably somewhere in 6.5.

Dave

> This is just the worst case. Since early 5.* I/O performance has dropped
> absurdly. In all our disk servers this is easy to see: just generate lots of
> writes quickly (for example expanding a kernel tarball). Using top I see that
> kworker starts using 100% cpu but disks stay idle (as seen by dstat or sar). If
> you do a sync or umount it takes looooong to reach ~0 modified pages for the
> sync or umount to return.
> 
> In the server I mentioned above where 6.4.* don't stand the load, which is one
> of the largest free software mirrors of the world, even sometimes 6.1
> collapses: I/O becomes so slow that service (apache) stops.
> 
> The problem gets progressively worse with time after booting. It's hardly
> noticeable in the first hour after boot, and easily seen after ~3-4 days of
> uptime. The higher the (write) I/O load the faster it appears.
> 
> All this is with ext4 and raid6 with >~ 14 disks in the arrays.
> 
> I don't have debug info because these are production machines and I only
> compile in the kernel the bare minimum essential for operation. It's always
> pure kernel.org releases; gcc versions vary, for 6.4* it's gcc-13, for 6.1*
> gcc-12 is used, on Debian unstable updated more than 4 times/week.
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
