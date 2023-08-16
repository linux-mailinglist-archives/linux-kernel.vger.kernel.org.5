Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3780677D729
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbjHPAn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbjHPAn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:43:57 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0467199B;
        Tue, 15 Aug 2023 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=p7r3uREoQh2baDnpVSadnAlYXwW8BFeYAnWiNEnk194=; b=fH7FUKI3yL1QXeZHZyf70tvtyb
        rdSNCIJCCtaFl1qKxWGADDgz1WE3vjmcNhhsv0L4ajhQST6t7Cox9kGoq/4OpfSpd3SX4pIpNCbt5
        253G9qLd721Lw2on8F/+SyLNtpQXd/aJZxb8wUqa387LXQRl68a5qeubFZCN9GRXyz9VfHX2G3bKk
        SBlSi7dhQpcj9IzIKeANCGNCTZPOyWoa/WKQg4QraHXrYX0bKS4swuRZX7RTmsTTcrdFdBmnl1ECK
        8RRtAKc0N2ifAvEMqN0LGIWWR/zVKXR4YJQAIn9SQXJyISilCxX1kQjtZHQ7oM0qjx+eqiJdwq2jx
        emUB2bAg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qW4dd-0079SV-B5; Wed, 16 Aug 2023 00:43:53 +0000
Date:   Wed, 16 Aug 2023 00:43:53 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Carlos Carvalho <carlos@fisica.ufpr.br>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNwbyTLdcnVHL+Vy@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <ZNvCJAclBEJf7uUA@fisica.ufpr.br>
 <ZNvJZIXIHJERRtwP@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZNvJZIXIHJERRtwP@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 00:43:19 up 40 days, 10:14,  2 users,  load average: 0.01, 0.00,
 0.00
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

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> * Carlos Carvalho (carlos@fisica.ufpr.br) wrote:
> > Dr. David Alan Gilbert (dave@treblig.org) wrote on Mon, Aug 14, 2023 at 06:02:53PM -03:
> > >   I'm seeing a few hangs on a fs after upgrading to fedora 39's bleeding
> > > edge; which is running kernel 6.5.0-0.rc5.20230808git14f9643dc90a.37.fc39.x86_64
> > > It was always solid prior to that.  It seems to trigger on heavy IO
> > > on this fs.
> > 
> > Good news! No, I didn't forget the smiley... Maybe now the problem has become
> > sufficiently bad to be visible/solvable...
> > 
> > 6.4.* also doesn't run in one of our machines, which has heavy I/O load. The
> > first symptom is that rsync downloads hang and abort with timeout. 1 or 2
> > days later the amount of modified pages waiting to go to disk reaches several
> > GB, as reported by /proc/meminfo, but disks remain idle. Finally reading from
> > the arrays collapses.
> 
> I'm not sure this is a related fault - I mean it might be, but my
> failure is much more deterministic; it seems solid on 6.4.x to me, but
> just fails reliably somewhere in 6.5.

Actually, you know your description smells a lot closer to the one
Rishabh has just posted today:
   https://lore.kernel.org/lkml/153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com/

Dave

> Dave
> 
> > This is just the worst case. Since early 5.* I/O performance has dropped
> > absurdly. In all our disk servers this is easy to see: just generate lots of
> > writes quickly (for example expanding a kernel tarball). Using top I see that
> > kworker starts using 100% cpu but disks stay idle (as seen by dstat or sar). If
> > you do a sync or umount it takes looooong to reach ~0 modified pages for the
> > sync or umount to return.
> > 
> > In the server I mentioned above where 6.4.* don't stand the load, which is one
> > of the largest free software mirrors of the world, even sometimes 6.1
> > collapses: I/O becomes so slow that service (apache) stops.
> > 
> > The problem gets progressively worse with time after booting. It's hardly
> > noticeable in the first hour after boot, and easily seen after ~3-4 days of
> > uptime. The higher the (write) I/O load the faster it appears.
> > 
> > All this is with ext4 and raid6 with >~ 14 disks in the arrays.
> > 
> > I don't have debug info because these are production machines and I only
> > compile in the kernel the bare minimum essential for operation. It's always
> > pure kernel.org releases; gcc versions vary, for 6.4* it's gcc-13, for 6.1*
> > gcc-12 is used, on Debian unstable updated more than 4 times/week.
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
