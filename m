Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF17A48A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjIRLm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbjIRLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:42:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FEECE6;
        Mon, 18 Sep 2023 04:42:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4911FB;
        Mon, 18 Sep 2023 04:42:43 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.35.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6827D3F67D;
        Mon, 18 Sep 2023 04:42:03 -0700 (PDT)
Date:   Mon, 18 Sep 2023 12:41:44 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <ZQg3eKYNe7hjFTds@e126311.manchester.arm.com>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917010516.54dgcmms44wyfrvx@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 17, 2023 at 02:05:16AM +0100, Qais Yousef wrote:
> Hi Kajetan
> 
> On 07/18/23 14:24, Qais Yousef wrote:
> 
> > These patches are in GKI. So we'll if there are uncaught problems I guess :)
> > 
> > No appetite for a knob, but the very low value for littles did strike me and
> > thought I better ask at least. Today's littles are too tiny for their own good
> > and it seemed the threshold could end up being too aggressive especially in low
> > activity state. You effectively are saying that if we have few 100us of
> > activity, normal TEO predictions based on timers are no good and better to stay
> > shallower anyway.
> > 
> > Note that due to NOHZ, if we go to idle for an extended period the util value
> > might not decay for a while and miss some opportunities. Especially that when
> > it next wakes up, it's enough for this wake up to run for few 100s us to block
> > a deeper state before going back to sleep for extended period of time.
> > 
> > But we shall see. I got the answer I was looking for for now.
> 
> Unfortunately not too long after the patches got merged I got regression report
> of worse power. As you know on Android things are not as mainline, so I need to
> untangle this to make sure it's not a red herring. But if you want to take my
> word for it, I think the chances of it being a true regression is high. I had
> to introduce knobs to allow controlling the thresholds for now, so the good
> news they do help and it's not a total revert. I don't have a lot of info to
> share, but it's the low activity use cases that seem to got impacted. Like
> video playback for instance.

Ah that's pretty unfortunate indeed. I definitely see how that could
happen, especially given that as you said it seems to be tied to
low activity use cases. When I was testing it out with UI benchmarks
(e.g. jankbench) the power numbers usually came out better. I suppose
video playback could be falling just over the currently set threshold
where it does not benefit from it in the same way as other workloads.

> Generally, I'm trying to remove some hardcoded values from the scheduler that
> enforces a behavior that is not universally desired on all systems/workloads.
> And I think the way the util awareness threshold are done today fall into the
> same category.
> 
> As I tried to highlight before, it is easy to trick the threshold by a task
> that runs for a short time then goes back to sleep for a long time.

I do agree, the way I view this topic is just that using util as a proxy
for idle correctness gives us another dimension that cpuidle otherwise
does not have. I'm not very invested in the hardcoded threshold, it was
giving reasonable results in my testing so I stuck with it to not
overcomplicate the patchset but I see it more as "step 1" rather than
the end goal. There's definitely improvements to be had there and a
better way to do this, I'm just not sure what it is at the moment.

> And when the system runs full throttle for a while, it'll take around 150+ms
> for the util to decay to the threshold value. That's a long time to block
> entering deeper idle states for. I'm not sure how NOHZ and blocked averaged
> updates can make this potentially worse.
> 
> In my view, the absolute comparison against util can be misleading. Even when
> util is 512 for example, we still have 50% of idle time. How this time is
> distributed can't be known from util alone. It could be one task waking up and
> sleeping. It could be multiple tasks at many combination of patterns all
> leading to the same outcome of CPU util being 512.

> IIUC the idea is that if we have even small activity, then erring on the
> shallow side is better. But given that target-residency is usually in few ms
> range, do we really need to be that quite? With a target-residency of 3ms for
> example, even at util of 900 there can be opportunities to enter it.
 
It could be misleading, the question then is which scenario happens more
often - the one where we have enough time for deeper idle but are
missing it because of the util or the one where the wakeups are erratic
enough that the util check saves us from incorrectly entering deep idle.
In most workloads I saw it was the latter hence the improvements but I
imagine the actual answer is very workload dependent so I'm not very
surprised that some cases go the other way.

> Can't we instead sample util at entry to idle loop and see if it is on a rising
> or falling trend? When rising it makes sense to say there's demand, let's block
> deeper idle state. But if it is falling, then if the decay time is longer than
> target-residency we can say it's okay to permit the deeper idle states?

Sounds like a pretty good idea to explore - I've not tried it myself at
this point so I have no idea how it'd work in practice but at least
conceptually this could make sense imo.

> I need to think more about this; but I think it's worth trying to make these
> thresholds more deterministic and quantifiable. There are too many workloads
> and system variations. I'm not sure if a knob to control these thresholds is
> good for anything but a workaround like I had to do. These hardcoded values
> can be improved IMHO. Happy to help to find alternatives.

Yes very much agreed on this part, they definitely can be improved. I'm
currently exploring some other approaches to this issue as well but
that's more of a long-term thing so it'll likely take a couple of months
to see whether they're workable or not.

The role I think the util bits are supposed to play here is mainly to
give us a view from a bit higher up than the metrics themselves do
because of how quickly those decay. Another way to do it would be some
way to make the threshold self-adjusting in the same way the metrics
are, e.g. increase the threshold if we're suddenly hitting too many too
shallow sleeps and decrease when we're hitting too many deep sleeps as a
result of the util checks. This would take care of the edge cases
currently falling through the cracks of their util being right around the
threshold, the mechanism would adjust within a few seconds of a workload
like video playback running. Could be a step in the right direction at least.

> 
> Cheers
> 
> --
> Qais Yousef
