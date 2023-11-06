Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F397E2A39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjKFQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:47:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA4C0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699289187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQ6sOyrHXMjfTSNTAyAuADXa/CCm3U6T8vjQLNBe/qc=;
        b=IfmSqHjLcbJjfj7924Iz54HfMubOdWFEKekQyK8QTdnetmrm6VnVQB4Adv9Qah9NE52L9w
        yY+qPGuV7bfOXve5TM/P56tef2o6rwsCg6dJJcA1Pnprj/Rm0+ogyDCnBnP0fM4tEzNQdd
        9+nDCQZndvN6o/zx8LDCYgzIQmR0KH8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Vnba4OdcO-C64IbB_qXjSA-1; Mon, 06 Nov 2023 11:46:26 -0500
X-MC-Unique: Vnba4OdcO-C64IbB_qXjSA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9dd489c98e7so207063566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289185; x=1699893985;
        h=content-transfer-encoding:in-reply-to:organization:cc
         :content-language:references:to:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ6sOyrHXMjfTSNTAyAuADXa/CCm3U6T8vjQLNBe/qc=;
        b=JkUH+wQWMKnMGAvEK9sJpM+kdSK/HQcxVWhAhHzYGHuMRLAjYTYYyaMvbIq/rN9e1H
         OvZFQvvyRC3aOmBRghLD4bTloABmVaGKpbj03qit/SDmLxugvrj0bNJC8LjROFwBCr2l
         9m0EptXWR0WHuZNPffp0Xlf5bKNQ63bVGWHIQ7DPe/JbR4L4A3X8ORjjIXOEG0aXjX/T
         ULUpNLGXSvdxVcrukHeFaOtRCCinx3jaHs5/9A0/nv5feyfD7xso8A05oDWZom30GS/O
         nvRMgoFlpPB+qqsizBZt4lQ7Zo1P15S2B4hL5g1vPo9PQVmwNhb/5idcIcWvVpHKrjEH
         Kfig==
X-Gm-Message-State: AOJu0Ywy/26p76PGmK1pqFLJ8JsuSEUbXnJXjs42IwI9T8LQJlSBUPTn
        2dXROhQXmETBSf1+kt7TsQq5m5/vr7hD7nzvd2NcuoqIKbRRaDZBdCUJa1pu/psVcgGhWBWrcY1
        UIdtYID4/Pc3KggNaZrrQ/YLp
X-Received: by 2002:a17:907:9706:b0:9d3:8d1e:cef with SMTP id jg6-20020a170907970600b009d38d1e0cefmr14024192ejc.59.1699289184785;
        Mon, 06 Nov 2023 08:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhHf39BFB5ghq+9+spWcCIMWl3PPUagTs7NjqV5e+u/YkFAlEhJ1VT/KcamFBNOGYGjhAz6g==
X-Received: by 2002:a17:907:9706:b0:9d3:8d1e:cef with SMTP id jg6-20020a170907970600b009d38d1e0cefmr14024174ejc.59.1699289184331;
        Mon, 06 Nov 2023 08:46:24 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906164b00b009cb2fd85371sm32576ejd.8.2023.11.06.08.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:46:23 -0800 (PST)
Message-ID: <ed187c95-1a6d-44b6-88ab-0866167bb5cd@redhat.com>
Date:   Mon, 6 Nov 2023 17:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231027102237.0cdb85af@collabora.com>
 <190e3ab7-6440-4d41-a79f-5dd4b7d3ca52@amd.com>
 <20231027121707.414810d6@collabora.com>
 <ffb8ff87-a555-42d2-aef1-a21069282227@amd.com> <ZT/uPhLK7gan61Ns@pollux>
 <e9c6af32-8d2a-4f04-9c12-1170a3aa1236@amd.com> <ZUEW1mxwGO3bxxGM@pollux>
 <8d4a0870-f7d0-41ee-aa25-6488b6ea037a@amd.com> <ZUPkfKzgKqhqQhMI@pollux>
 <c91cf097-2ed3-4669-b9ae-b16b5f875b02@amd.com>
Content-Language: en-US
Cc:     Boris Brezillon <boris.brezillon@collabora.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Organization: RedHat
In-Reply-To: <c91cf097-2ed3-4669-b9ae-b16b5f875b02@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 09:15:25AM +0100, Christian König wrote:
> Am 02.11.23 um 19:03 schrieb Danilo Krummrich:
> > On Thu, Nov 02, 2023 at 11:07:32AM +0100, Christian König wrote:
> > > Hi Danilo,
> > > 
> > > Am 31.10.23 um 16:01 schrieb Danilo Krummrich:
> > > > On Tue, Oct 31, 2023 at 02:20:50PM +0100, Christian König wrote:
> > > > > [SNIP]
> > > > > Yeah, I see the intention here and can perfectly relate to it it's just that
> > > > > I have prioritize other things.
> > > > I don't see any work being required from your side for this.
> > > What I wanted to say is that I understand your intentions and can relate to
> > > that, but other aspects have higher priority in this discussion.
> > What aspects would that be?
> 
> Be defensive. As far as I can see this callback is only nice to have and not
> functionally mandatory.

I gave you quite some reasons why this is desired.

And generally speaking, even if something is not functionally mandatory,
rejecting it *only* because of that isn't a good idea.

It is better to deal with it in terms of content and consider its pros and cons.

> 
> And in such cases I have to weight between complexity by adding something
> which might go boom and being conservative and using well known and working
> code paths.
> 
> > Not breaking other drivers? - The callback is optional, and besides that, as
> > already mentioned, the callback doesn't do anything that can't already go wrong
> > with the inital credit value from drm_sched_job_init().
> 
> During drm_sched_job_init() time the fence of this job isn't published yet.
> So when the driver specified something invalid we can easily return an error
> code and abort.
> 
> Inside the scheduler we can't do anything like this. E.g. what happens if
> the driver suddenly returns a value which is to large? We can't reject that.

This is all correct and I recognize that. But again, the callback is optional.
I don't see how drivers would be affected not opting in for this feature.

And for drivers which do, they'd have the same problem (if you actually want to
call it one) doing some driver specific workaround as well. And because they'd
not have the correct hook likely many more.

> 
> > Keeping things simple? - The workaround PowerVR is considering instead
> > (returning a dma-fence in ->prepare_job()) doesn't seem to contribute to this
> > goal.
> 
> I don't see this as a workaround, this is essentially the desired solution.
> All dependencies of a job should be represented as a dma-fence if possible.

So, you're saying that given we have an inaccurate way of tracking credits
(because you're rejecting the callback making it accurate), the desired solution
would be to use an existing callback with a whole different, more complicated
and hence more error prone approach to overcome that?

> 
> The background is that dma-fences have a very well defined semantics which
> through a rather elaborated hack is validated to the extend that lockdep can
> check if drivers behave correctly or not: https://elixir.bootlin.com/linux/latest/source/drivers/dma-buf/dma-fence.c#L194

I fail to see what dma-fences have to do with job-flow control of the ring
buffer. You mention it to be a plus that there is a hack to be able to validate
dma-fences with lockdep, but you miss the fact that the only reason we'd need
this in the first place is that you think it is desired to do job-flow control
with dma-fences.

> 
> With this here you are actually breaking this because now drivers have
> influence again on when stuff is scheduled.

I'm not breaking anything. This flow control mechanism is already in the
scheduler, it's just that it's inaccurate because drivers need to calculate
every job with the worst case credit amount. I'm just making it accurate, such
that it becomes useful for some drivers.

I also do not agree that this breaks anything dma-fence related in general. It
doesn't give drivers control of *when* stuff is scheduled. It gives the
scheduler an idea of *if* it can schedule a job without overflowing the ring
buffer. The influence of when comes through the hardware finishing a previous
job and the corresponding dma-fence callback creating the corresponding space
in terms of credit capacity of the scheduler.

> 
> > > > > Adding this callback allows for the driver to influence the job submission
> > > > > and while this might seems useful now I'm just to much of a burned child to
> > > > > do stuff like this without having a really good reason for it.
> > > > It does influence the job submission in the exact same way as the initial credit
> > > > count set through drm_sched_job_init() does. There is absolutely nothing with
> > > > this callback a driver couldn't mess up in the exact same way with the initial
> > > > credit count set through drm_sched_job_init(). Following this logic we'd need to
> > > > abandon the whole patch.
> > > Well what I thought you would be doing is to replace the fixed one credit
> > > per job with N credits per job.
> > That's exactly what the patch does. Plus, with the help of the
> > update_job_credits() callback, keep this job credit count accurate and up to
> > date.
> > 
> > My point is that you're concerned about the logic of a callback that just
> > repeats the exact same logic that's applied on initialization already.
> 
> As I wrote above the difference is that during initialization time we can
> just return an error code.
> 
> As soon as we have entered the scheduler we are doomed to execute it. When
> the driver now does nonsense we can't handle that situation gracefully any
> more.
> 
> Daniel was already rather concerned when I came up with the prepare callback
> and that concern was proven to be correct. This here adds another callback
> drivers can stumble over.
> 
> > > > Hence, I don't really understand why you're so focused on this callback.
> > > > Especially, since it's an optional one.
> > > It's seems unnecessary to me. As long as it's just to fill up the ring
> > > buffer more than necessary it is pretty much just a perfect example of
> > > over-engineering
> > Boris explained multiple times why it is needed for PowerVR. There might be
> > cases where it doesn't matter to over-account credits for a job. And clearly
> > it's even most of them, that's what I agree on.
> 
> I probably need to re-read what Boris wrote, but my impression is that this
> is only optional for him.
> 
> > However, I don't see why we want to be less accurate as we could be and hence
> > risk issues in drivers like PowerVR that are hard to debug.
> > 
> > AFAICT, whether we could potentially see a ring run dry because of this depends
> > on the workload pattern submitted by applications. Breaking down such observed
> > performance issues to the scheduler not being accurate at this point in a few
> > month or years would be an absurd effort. So why not just rule this out in
> > advance?
> 
> Because correct dma-fence signaling is more important than driver
> performance.

You mean because drivers could return more credits than the scheduler has
capacity and then we WARN() but are still stuck?

The easy fix would be to still WARN() but set the job's credits to the maximum
credit size the scheduler can handle.

> 
> Those signaling bugs are even *much* more problematic than anything the
> driver can come up with.
> 
> Please see here for an example why this is so problematic: https://patches.linaro.org/project/linux-media/patch/20200612070623.1778466-1-daniel.vetter@ffwll.ch/
> 
> We basically said that all dependencies the job submission is based on is
> expressed as a dma-fence, because dma-fences can be proven to be correct.

I'm pretty sure that it's also possible to prove three lines of code updating
the job's credit count to be correct...

Maybe we're better off using our energy for that instead?

> 
> When we add something like this callback we circumvent this whole checking.
> 
> Maybe we can approach this from a completely different side. Basically we
> have static and dynamic dependencies for a job.
> 
> The static ones are expressed in the dependencies xarray while the dynamic
> ones are returned by the prepare callback.
> 
> What if we completely remove the credits or ring buffer handling from the
> scheduler and put it into a separate component which drivers can use a
> prepare callback?

While I honestly appreciate you making a proposal to move forward, I really
think that this makes everything you're concerned about just worse and even
starts me getting concerned about it.

1) We'd trade the complxity of three lines of code to update the credit count
with a whole new component.

2) You mentioned that the concerns about the prepare callback were proven to be
correct, now you propose to extend it even.

The update_job_credits() has a very limited scope and hence is way easier to
validate for correctness. The only thing we really need to do is to guarantee
forward progress, meaning we just don't allow the job's credits to exceed the
schedulers credit capacity. And that should be it.

3) You seem to imply that you want to use dma-fences to do job-flow control,
which as I mentioned above has way more complexity (separately allocated object,
locking restrictions, etc.) and hence is more error prone.

4) Why would we remove something from the scheduler which can be considered to
be one of its core responsibilities?

> 
> Regards,
> Christian.
> 
> > 
> > Again, if this callback would introduce any complexity or tradeoffs for existing
> > drivers, I'd vote to wait until we actually see issues as well. But this simply
> > isn't the case. And if you think otherwise, please show me the complexity it
> > introduces that is concerning and the tradeoffs for existing drivers.
> > 
> > > > > > > If this here has some measurable positive effect then yeah we should
> > > > > > > probably do it, but as long as it's only nice to have I have some objections
> > > > > > > to that.
> > > > > > Can't answer this, since Nouveau doesn't support native fence waits. However, I
> > > > > > guess it depends on how many native fences a job carries. So, if we'd have two
> > > > > > jobs with each of them carrying a lot of native fences, but not a lot of actual
> > > > > > work, I can very well imagine that over-accounting can have a measureable
> > > > > > impact.
> > > > > What I can imagine as well is things like the hardware or firmware is
> > > > > looking at the fullness of the ring buffer to predict how much pending work
> > > > > there is.
> > > > > 
> > > > > > I just wonder if we really want to ask for real measurements given that the
> > > > > > optimization is rather trivial and cheap and we already have enough evidence
> > > > > > that it makes sense conceptually.
> > > > > Well that's the point I disagree on, this callback isn't trivial. If (for
> > > > > example) the driver returns a value larger than initially estimated for the
> > > > > job we can run into an endless loop.
> > > > I agree it doesn't make sense to increase, but it wouldn't break anything,
> > > > unless the job size starts exceeding the capacity of the ring. And this case is
> > > > handled anyway.
> > > > 
> > > > > It's just one more thing which can go boom. At bare minimum we should check
> > > > > that the value is always decreasing.
> > > > Considering the above I still agree, such a check makes sense - gonna add one.
> > > Please don't send anything out until we have solved this.
> > I did, but don't worry about this, it helped me to finalize the rest of the
> > patch. We can keep discussing this in this thread either way.
> > 
> > > So far I haven't seen any argument which would not let me reject this and I
> > > don't want to waste your time.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > - Danilo
> > > > 
> > > > > Christian.
> > > > > 
> > > > > > - Danilo
> > > > > > 
> > > > > > > Regards,
> > > > > > > Christian.
> > > > > > > 
> > > > > > > > Regards,
> > > > > > > > 
> > > > > > > > Boris

