Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520C802711
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjLCTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjLCTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:38:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C218A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:37:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E697C433C8;
        Sun,  3 Dec 2023 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701632268;
        bh=zpmUNVwx3eN/sMGL2XuHjExRiDp+GF7SBd2lpzktD3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5KWV1kB8aQPhXpkQtSa2PKnVrkqiemTIiCSUaLmtURKjxX2D8lOeaa55ItuqOmHw
         khmxJIWzIw8Z6tewelPOqzOzL2NxBBjXSmVg3+eC7Q+eKJXijxq1xxP4AVNenxm0aM
         yZjF1BgbM6qoMKYhEv0xEk5wD7chUM1PQPqZiwUslc/PTxieAOKyd/AcdnDluGFuZL
         2opSKM6pkP4MrClouQD2AoFgsmkCn5kP91slgWr1S0qE5HtESM7rWR5TF9ztU/47fy
         zH/h1upJeGpZOxPyaNm0cECPBknF62noMnsYIBD+uBEATPQWD+UdrM/cySgP5NHMRT
         FtShUmuCqvVbg==
From:   SeongJae Park <sj@kernel.org>
To:     cuiyangpei <cuiyangpei@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date:   Sun,  3 Dec 2023 19:37:45 +0000
Message-Id: <20231203193745.57035-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203054313.GA14316@cuiyangpei>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > Hi Cuiyangpei,
> > 
> > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > Hi Cuiyangpei,
> > > > 
> > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > 
> > > > > Hi SeongJae,
> > > > > 
> > > > > We also investigated the operation schemes you mentioned, but we don't
> > > > > think it can fit our needs.
> > > > > 
> > > > > On android, user will open many apps and switch between these apps as
> > > > > needs. We hope to monitor apps' memory access only when they are on
> > > > > foreground and record the memory access pattern when they are switched
> > > > > to the background. 
> > > > > 
> > > > > When avaliable memory reaches a threshold, we will use these access
> > > > > patterns with some strategies to recognize those memory that will have
> > > > > little impact on user experience and to reclaim them proactively.  
> > > > > 
> > > > > I'm not sure I have clarified it clearly, if you still have questions
> > > > > on this, please let us know.
> > > > 
> > > > So, to my understanding, you expect applications may keep similar access
> > > > pattern when they are in foreground, but have a different, less aggressive
> > > > access pattern in background, and therefore reclaim memory based on the
> > > > foreground-access pattern, right?
> > > >
> > > 
> > > Different apps may have different access pattern. On android, the apps will
> > > join in freeze cgroup and be frozen after switch to the background. So we 
> > > monitor apps' memory access only when they are in foreground.
> > 
> > Thank you for this enlightening me :)
> > 
> > > > Very interesting idea, thank you for sharing!
> > > > 
> > > > Then, yes, I agree current DAMOS might not that helpful for the situation, and
> > > > this record feature could be useful for your case.
> > > > 
> > > > That said, do you really need full recording of the monitoring results?  If
> > > > not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> > > > monitoring results snapshot that include both frequency and recency of all
> > > > regions in an efficient way.  If single snapshot is not having enough
> > > > information for you, you could collect multiple snapshots.
> > > > 
> > > > You mentioned absence of Python on Android as a blocker of DAMOS use on the
> > > > previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> > > > or Python.
> > > > 
> > > > Of course, I think you might already surveyed it but found some problems.
> > > > Could you please share that in detail if so?
> > > > 
> > > DAMOS tried regions feature you mentioned is not fully applicable. It needs to
> > > apply schemes on regions. There is no available scheme we can use for our use
> > > case. What we need is to return regions with access frequency and recency to
> > > userspace for later use.
> > 
> > 
> > Thank you for the answer, I understand your concern.  One of the available
> > DAMOS action is 'stat'[1], which does nothing but just count the statistic.
> > Using DAMOS scheme for any access pattern with 'stat' action, you can extract
> > the access pattern via DAMOS tried regions feature of DAMON sysfs interface,
> > without making any unnecessary impact to the workload.
> > 
> > Quote from [2]:
> > 
> >     The expected usage of this directory is investigations of schemes' behaviors,
> >     and query-like efficient data access monitoring results retrievals. For the
> >     latter use case, in particular, users can set the action as stat and set the
> >     access pattern as their interested pattern that they want to query.
> > 
> > For example, you could
> > 
> > # cd /sys/kernel/mm/damon/admin
> > #
> > # # populate directories
> > # echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
> > # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
> > # cd kdamonds/0/contexts/0/schemes/0
> > #
> > # # set the access pattern for any case (max as 2**64 - 1), and action as stat
> > # echo 0 > access_pattern/sz/min
> > # echo 18446744073709551615 > access_pattern/sz/max
> > # echo 0 > access_pattern/nr_accesses/min
> > # echo 18446744073709551615 > access_pattern/nr_accesses/max
> > # echo 0 > access_pattern/age/min
> > # echo 18446744073709551615 > access_pattern/age/max
> > # echo stat > action
> > 
> > And this is how DAMON user-space tool is getting the snapshot with 'damo show'
> > command[3].
> > 
> > Could this be used for your case?  Please ask any question if you have :)
> > 
> > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n
> > [2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions,
> > [3] https://github.com/awslabs/damo/blob/next/USAGE.md#damo-show
> 
> Thank you for your detailed response, it is very helpful to us. We will look into it
> and contact you if we have any questions.

So glad to hear this.  Please let me know if you have any questions or need any
help :)


Thanks,
SJ

> 
> > 
> > 
> > Thanks,
> > SJ
> > 
> > > > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> > > > [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> > > > 
> > > > 
> > > > Thanks,
> > > > SJ
> > > > 
> > > > > 
> > > > > Thanks.
