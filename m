Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807ED7FC201
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbjK1OCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbjK1OCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:02:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67885B5;
        Tue, 28 Nov 2023 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kbo+RHlcbyYyBRrrc3whU0Ok1x+trIWNBYTilsW1XuI=; b=WgmwKxv9CoPrJNaMGZ0b0cipit
        1Dn8osLTNJw+PM7fRkJSHUnm8YFQE0eP566+F9DNMA31UbmW46JjaqhPe1c6A/qyBQ2/X3RYmO7nP
        bHA0iXTXxcNP7FYVb+NyAnLisit8kmbieBp+1G92bgHC59jJGDgGSVnuk+TcL/xPnmqAsl2Ul1Z6+
        9qJgpI0XzYQA/FCON0ITa20ltlhaiJDOcpBrVLRb46FzAhU/T5ZTX/W8YnDNWHbhUXBkW7b6w7GT9
        ReXjB4GHT39ck5dC7am0UAwRNdrUFQvxFmmkMrHuI0vxK/29bBTRNETziKPoAZp5okldMW+Bh8K5K
        cpqdS1Vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7yfT-00CPkR-Dz; Tue, 28 Nov 2023 14:02:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D8A83003F0; Tue, 28 Nov 2023 15:02:25 +0100 (CET)
Date:   Tue, 28 Nov 2023 15:02:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramses VdP <ramses@well-founded.dev>,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
Message-ID: <20231128140225.GS8262@noisy.programming.kicks-ass.net>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:22:27PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I come across an interesting bug report on Bugzilla [1]. The reporter
> wrote:

Thanks for forwarding, what happend in bugzilla staysi in bugzilla etc..

Did you perchance Cc the reporter?

> > I am running an intel alder lake system (Core i7-1260P), with a mix
> > of P and E cores.
> > 
> > Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems
> > to have a strong preference for the E cores, and single threaded
> > workloads are consistently scheduled on one of the E cores.
> > 
> > With Linux 6.4 and before, when I ran a single threaded CPU-bound
> > process, it was scheduled on a P core. With 6.5, it seems that the
> > choice of P or E seemed rather random.
> > 
> > I tested these by running "stress" with different amounts of
> > threads. With a single thread on Linux 6.6 and 6.7, I always have an
> > E core at 100% and no load on the P cores. Starting from 3 threads I
> > get some load on the P cores as well, but the E cores stay more
> > heavily loaded.  With "taskset" I can force a process to run on a P
> > core, but clearly it's not very practical to have to do CPU
> > scheduling manually.
> > 
> > This severely affects single-threaded performance of my CPU since
> > the E cores are considerably slower. Several of my workflows are now
> > a lot slower due to them being single-threaded and heavily CPU-bound
> > and being scheduled on E cores whereas they would run on P cores
> > before.
> > 
> > I am not sure what the exact desired behaviour is here, to balance
> > power consumption and performance, but currently my P cores are
> > barely used for single-threaded workloads.
> > 
> > Is this intended behaviour or is this indeed a regression? Or is
> > there perhaps any configuration that I should have done from my
> > side? Is there any further info that I can provide to help you
> > figure out what's going on?
> 
> PM and scheduler people, is this a regression or works as intended?

AFAIK that is supposed to be steered by the ITMT muck and I don't think
we changed that.

Ricardo?

> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218195
> 
> -- 
> An old man doll... just what I always wanted! - Clara
