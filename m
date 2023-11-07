Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504647E3FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjKGNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjKGNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAFB211D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699362204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3Y8x1R2Swq3sNEDTgStfCdQJ+YQeaq0lvfyTuANVa4=;
        b=ZSvmwqajEnt3a4+F3THyUeyB2LkWrCvjnVTJnA7dS1h0QIwHF+jAtHBiR8GWZUYLEatR8h
        LB5Gv6Cw/mLufQ7YzMUEg+4De3CPKWTl0xUhOXIXuheh02kflJelc74S4gsWuducep1Dws
        +Vr/6nlepz+soF4u8cxtrcvz7v1ydig=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-K2qGwtfKNK2xiHS6dLJ2HA-1; Tue, 07 Nov 2023 08:03:20 -0500
X-MC-Unique: K2qGwtfKNK2xiHS6dLJ2HA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d216597f5fso414441966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362199; x=1699966999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3Y8x1R2Swq3sNEDTgStfCdQJ+YQeaq0lvfyTuANVa4=;
        b=PDpBBSF6jZWsbu1AyGW7w6Wo/aahjrcpE1L8+7CveTo2cmpySq4aABVh9gDSzwqPXp
         9qDXgo7q+7gw/UyN8RdxcCB70YtxJG5FnkS0H9tdCzsEFTrJVXQC5WOxmQjNXTYFrLQL
         E8XSER8BhkGrYaTjNc0BikFP+K/IIWJcN0n1D6ZJyFOe7+Iz1hYAGTwHSf9VVXV4s1o2
         q8rLF/MYtmcv+qcczLmHEETUhLWhmhbTDBxYEFrh32jwGY5bhJRCkPTsdFl73adAlKh6
         IRF+bhgNbec5mXew5ZOT6W9Qzl1UL/FOKR0aephPZXBrvLxki/iLvSZMQGwT57+TNuIQ
         fM0A==
X-Gm-Message-State: AOJu0YydiPoyInzgmlSCo6NZO1siaCQ4nOLWduBS9HF7NwMeDTuVxwqD
        t/dOKEVUYUX+aCC4R6GxKOt3Oi4HTF5cSNgYi+gE+5he5VO8dj36dwOqNSay+SDvnazeoe2zVr5
        KTlqAeHtD0iW4ds9aYwg+TS/Z
X-Received: by 2002:a17:907:ea1:b0:9dd:9d80:2d5a with SMTP id ho33-20020a1709070ea100b009dd9d802d5amr9387604ejc.61.1699362199306;
        Tue, 07 Nov 2023 05:03:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdMtNXRatjETjo2Cj4fdwdfMwVavD6owjduJ4ZV6uCMX6RvMlqNW5IDWYbe2VvVZF2iYbEaA==
X-Received: by 2002:a17:907:ea1:b0:9dd:9d80:2d5a with SMTP id ho33-20020a1709070ea100b009dd9d802d5amr9387562ejc.61.1699362198617;
        Tue, 07 Nov 2023 05:03:18 -0800 (PST)
Received: from pollux ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b0099d45ed589csm1013632eji.125.2023.11.07.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:03:14 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:03:07 +0100
From:   Danilo Krummrich <dakr@redhat.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Message-ID: <ZUo1izf2NYcQTT0O@pollux>
References: <20231027121707.414810d6@collabora.com>
 <ffb8ff87-a555-42d2-aef1-a21069282227@amd.com>
 <ZT/uPhLK7gan61Ns@pollux>
 <e9c6af32-8d2a-4f04-9c12-1170a3aa1236@amd.com>
 <ZUEW1mxwGO3bxxGM@pollux>
 <8d4a0870-f7d0-41ee-aa25-6488b6ea037a@amd.com>
 <ZUPkfKzgKqhqQhMI@pollux>
 <c91cf097-2ed3-4669-b9ae-b16b5f875b02@amd.com>
 <ed187c95-1a6d-44b6-88ab-0866167bb5cd@redhat.com>
 <29f85d25-fb9f-4474-92f1-32117101eb1d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29f85d25-fb9f-4474-92f1-32117101eb1d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:13:37AM +0100, Christian König wrote:
> Am 06.11.23 um 17:46 schrieb Danilo Krummrich:
> > On Fri, Nov 03, 2023 at 09:15:25AM +0100, Christian König wrote:
> > > Am 02.11.23 um 19:03 schrieb Danilo Krummrich:
> > > > On Thu, Nov 02, 2023 at 11:07:32AM +0100, Christian König wrote:
> > > > > Hi Danilo,
> > > > > > > Am 31.10.23 um 16:01 schrieb Danilo Krummrich:
> > > > > > On Tue, Oct 31, 2023 at 02:20:50PM +0100, Christian König wrote:
> > > > > > > [SNIP]
> > > > > > > Yeah, I see the intention here and can perfectly relate to
> > > it it's just that
> > > > > > > I have prioritize other things.
> > > > > > I don't see any work being required from your side for this.
> > > > > What I wanted to say is that I understand your intentions and
> > > can relate to
> > > > > that, but other aspects have higher priority in this discussion.
> > > > What aspects would that be?
> > > 
> > > Be defensive. As far as I can see this callback is only nice to have
> > > and not
> > > functionally mandatory.
> > 
> > I gave you quite some reasons why this is desired.
> 
> Yeah, but I need something to make it necessary. Desired is just not enough
> in this case.

You can't really say that *and*...

> 
> > And generally speaking, even if something is not functionally mandatory,
> > rejecting it *only* because of that isn't a good idea.
> 
> Completely agree.

...agree here. That is entirely contradicting.

> But what makes this at least questionable is the
> combination of not mandatory and giving drivers the opportunity to mess with
> submissions again.

We already had this below. I explained why it doesn't and you agreed.

> 
> Especially in the scheduler and dma_fence handling we had tons of patches
> which added a nice to have and seemingly harmless features which later
> turned into a complete nightmare to maintain.

That's pseudo argument, you can simply use this to randomly reject everything.

The fact is, that we need to get a single integer check right, I fail to see how
this will turn into a nightmare to maintain.

> 
> The takeaway is that we need more big red warning signs in the form of
> documentation and try to not change things just because it makes them look
> better.

Documentation would be great indeed. You might be happy to hear that this patch
actually comes with documentation on how the job-flow control of the scheduler
works and what users can expect. Once merged, this will be the best documented
part of the scheduler...

> 
> > It is better to deal with it in terms of content and consider its pros
> > and cons.
> > 
> > > 
> > > And in such cases I have to weight between complexity by adding
> > > something
> > > which might go boom and being conservative and using well known and
> > > working
> > > code paths.
> > > 
> > > > Not breaking other drivers? - The callback is optional, and
> > > besides that, as
> > > > already mentioned, the callback doesn't do anything that can't
> > > already go wrong
> > > > with the inital credit value from drm_sched_job_init().
> > > 
> > > During drm_sched_job_init() time the fence of this job isn't
> > > published yet.
> > > So when the driver specified something invalid we can easily return
> > > an error
> > > code and abort.
> > > 
> > > Inside the scheduler we can't do anything like this. E.g. what
> > > happens if
> > > the driver suddenly returns a value which is to large? We can't
> > > reject that.
> > 
> > This is all correct and I recognize that. But again, the callback is
> > optional.
> > I don't see how drivers would be affected not opting in for this feature.
> 
> I see this actually as cons argument for the change. If many drivers would
> use this then the code path would be much better tested.

It's a single integer check. Again, I'm pretty sure we can get this right. We can
even add a few test cases to validate this code path and the credit handling in
general - I'd offer that.

> 
> > 
> > And for drivers which do, they'd have the same problem (if you actually
> > want to
> > call it one) doing some driver specific workaround as well. And because
> > they'd
> > not have the correct hook likely many more.
> > 
> > > 
> > > > Keeping things simple? - The workaround PowerVR is considering instead
> > > > (returning a dma-fence in ->prepare_job()) doesn't seem to
> > > contribute to this
> > > > goal.
> > > 
> > > I don't see this as a workaround, this is essentially the desired
> > > solution.
> > > All dependencies of a job should be represented as a dma-fence if
> > > possible.
> > 
> > So, you're saying that given we have an inaccurate way of tracking
> > credits
> > (because you're rejecting the callback making it accurate), the desired
> > solution
> > would be to use an existing callback with a whole different, more
> > complicated
> > and hence more error prone approach to overcome that?
> > 
> > > 
> > > The background is that dma-fences have a very well defined semantics
> > > which
> > > through a rather elaborated hack is validated to the extend that
> > > lockdep can
> > > check if drivers behave correctly or not: https://elixir.bootlin.com/linux/latest/source/drivers/dma-buf/dma-fence.c#L194
> > 
> > I fail to see what dma-fences have to do with job-flow control of the
> > ring
> > buffer. You mention it to be a plus that there is a hack to be able to
> > validate
> > dma-fences with lockdep, but you miss the fact that the only reason we'd
> > need
> > this in the first place is that you think it is desired to do job-flow
> > control
> > with dma-fences.
> 
> Well I consider the hack better than this callback.
> 
> The hack Daniel came up with allows us to validate driver behavior. In other
> words even if things seems to work we get a warning if drivers do something
> they are not supposed to do.

You insist on this validation argument, but you ignore that we can easily
validate the credit count as well. There is absolutely no difference.

> 
> > > With this here you are actually breaking this because now drivers have
> > > influence again on when stuff is scheduled.
> > 
> > I'm not breaking anything. This flow control mechanism is already in the
> > scheduler, it's just that it's inaccurate because drivers need to
> > calculate
> > every job with the worst case credit amount. I'm just making it
> > accurate, such
> > that it becomes useful for some drivers.
> 
> Well, what's wrong with assuming the worst?

Please don't ask this question. I allege you know the answer. We had a long
discussion about it before I sent this patch.

Otherwise, it's in the commit message.

> 
> > I also do not agree that this breaks anything dma-fence related in
> > general. It
> > doesn't give drivers control of *when* stuff is scheduled. It gives the
> > scheduler an idea of *if* it can schedule a job without overflowing the
> > ring
> > buffer. The influence of when comes through the hardware finishing a
> > previous
> > job and the corresponding dma-fence callback creating the corresponding
> > space
> > in terms of credit capacity of the scheduler.
> 
> That's a really good point, but what if the driver keeps telling the
> scheduler that it can't execute the job?

Well, the driver can't tell the scheduler to simply not execute a job.

> 
> > > [SNIP]
> > > 
> > > > However, I don't see why we want to be less accurate as we could
> > > be and hence
> > > > risk issues in drivers like PowerVR that are hard to debug.
> > > > > AFAICT, whether we could potentially see a ring run dry because
> > > of this depends
> > > > on the workload pattern submitted by applications. Breaking down
> > > such observed
> > > > performance issues to the scheduler not being accurate at this
> > > point in a few
> > > > month or years would be an absurd effort. So why not just rule
> > > this out in
> > > > advance?
> > > 
> > > Because correct dma-fence signaling is more important than driver
> > > performance.
> > 
> > You mean because drivers could return more credits than the scheduler has
> > capacity and then we WARN() but are still stuck?
> 
> Yes, exactly that's my concern here.

Cool, we can easily rule this one out then. See below.

> 
> > The easy fix would be to still WARN() but set the job's credits to the
> > maximum
> > credit size the scheduler can handle.
> 
> But that has then the potential for overflowing the ring buffer.
> 
> As far as I can see when the driver does something wrong there is no way for
> the scheduler to handle that gracefully. Either we don't fulfill the
> driver's wish to have at least X credits available before executing the job
> or we ignore the fact that we need to guarantee forward progress.

Sure, but this will *always* be the case, no matter what primitive (dma-fences
or whatnot) you gonna use for handling / tracking job credits.

If the driver doesn't stick to its own bounds in this case this is and always
will be a driver bug we simply can't prevent.

We can only decide how we handle it. And the above strategy seems reasonable.
WARN about it and guarantee forward progress. If it leads to the driver
overflowing its ring buffer, that's not critical for the kernel itself and the
driver is already buggy and due to the warning we exactly know that and we know
why.

> 
> > > 
> > > Those signaling bugs are even *much* more problematic than anything the
> > > driver can come up with.
> > > 
> > > Please see here for an example why this is so problematic: https://patches.linaro.org/project/linux-media/patch/20200612070623.1778466-1-daniel.vetter@ffwll.ch/
> > > 
> > > We basically said that all dependencies the job submission is based
> > > on is
> > > expressed as a dma-fence, because dma-fences can be proven to be
> > > correct.
> > 
> > I'm pretty sure that it's also possible to prove three lines of code
> > updating
> > the job's credit count to be correct...
> > 
> > Maybe we're better off using our energy for that instead?
> 
> Yeah, those three lines inside the scheduler are indeed correct but I can't
> validate what the driver is doing.

Surely, we can validate it. We can validate whether the argument is in its
correct bounds and in case WARN about it and handle it.

We just can't control what the driver is doing. But that's always true, also
with dma-fences.

> 
> As soon as we have this callback the calculation to come up with the credits
> is outside of the scheduler.

Sure, but that's in the nature of this value? Again, you can use whatever
primitive you want, nothing will change this fact.

> 
> > > When we add something like this callback we circumvent this whole
> > > checking.
> > > 
> > > Maybe we can approach this from a completely different side.
> > > Basically we
> > > have static and dynamic dependencies for a job.
> > > 
> > > The static ones are expressed in the dependencies xarray while the
> > > dynamic
> > > ones are returned by the prepare callback.
> > > 
> > > What if we completely remove the credits or ring buffer handling
> > > from the
> > > scheduler and put it into a separate component which drivers can use a
> > > prepare callback?
> > 
> > While I honestly appreciate you making a proposal to move forward, I
> > really
> > think that this makes everything you're concerned about just worse and
> > even
> > starts me getting concerned about it.
> > 
> > 1) We'd trade the complxity of three lines of code to update the credit
> > count
> > with a whole new component.
> > 
> > 2) You mentioned that the concerns about the prepare callback were
> > proven to be
> > correct, now you propose to extend it even.
> 
> The difference is that Daniel has found a way to validate the prepare
> callback functionality.

That's not a difference, we can validate an integer as well. See above.

> 
> When the driver gives us a fence which never signals we get a warning, when
> the driver allocates a new fence we get a warning etc...

And when the integer is outside of its bounds we get a warning too. Again, where
is the difference?

> 
> We have found tons of bugs around this inside the drivers which ranges from
> allocating memory to taking locks in incorrect order. And we haven't even
> fixed all of them yet, I can still point you to code where amdgpu for
> example is still broken. It's just that this source path isn't exercised
> this often so we can live with it for now.

None of those bugs are relevant for what I'm doing, nor are they even possible
with what I'm doing.

> 
> I really don't want to repeat that stunt with this callback again. At least
> not for something which is only nice to have.

I recognize that. But saying that the type of callback was the problem here is
nonreflective and simplified.

The truth is that the problem with prepare_job() was the exploding complexity
that was mainly contributed by combining it with dma-fences, which by their
nature carry a lot of complexity themselfes.

If update_job_credits() would have been there before prepare_job() you'd never
had any of those issues. And even if there were an issue it would have been
trivial to fix. As a result you wouldn't blame the type of callback.

> 
> > The update_job_credits() has a very limited scope and hence is way
> > easier to
> > validate for correctness. The only thing we really need to do is to
> > guarantee
> > forward progress, meaning we just don't allow the job's credits to
> > exceed the
> > schedulers credit capacity. And that should be it.
> > 
> > 3) You seem to imply that you want to use dma-fences to do job-flow
> > control,
> > which as I mentioned above has way more complexity (separately allocated
> > object,
> > locking restrictions, etc.) and hence is more error prone.
> > 
> > 4) Why would we remove something from the scheduler which can be
> > considered to
> > be one of its core responsibilities?
> 
> Yeah, good points. I wanted to at least throw out some ideas how to solve
> this instead of just bluntly rejecting it.

And I honestly appreciate that.

Now, since none of the arguments against this seem to hold, can we go ahead?

To summarize.

- it serves a purpose
- it's very simple (not a lot of code and not much complexity)
- we can validate it (detecting and warning about driver bugs)
- we can guarantee forward progress (don't void fencing rules)
- we can even test it (I offer to write the corresponding tests)
- it comes with proper documentation

All of those points got a proper explanation behind them throughout this mail
thread, hence should you disagree, please answer at the corresponding location
in the mail thread. Please abstain from re-starting the discussion here.

> 
> Regards,
> Christian.
> 
> > 
> > 
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > > Again, if this callback would introduce any complexity or
> > > tradeoffs for existing
> > > > drivers, I'd vote to wait until we actually see issues as well.
> > > But this simply
> > > > isn't the case. And if you think otherwise, please show me the
> > > complexity it
> > > > introduces that is concerning and the tradeoffs for existing drivers.
> > > > > > > > > > If this here has some measurable positive effect then
> > > yeah we should
> > > > > > > > > probably do it, but as long as it's only nice to have I
> > > have some objections
> > > > > > > > > to that.
> > > > > > > > Can't answer this, since Nouveau doesn't support native
> > > fence waits. However, I
> > > > > > > > guess it depends on how many native fences a job carries.
> > > So, if we'd have two
> > > > > > > > jobs with each of them carrying a lot of native fences,
> > > but not a lot of actual
> > > > > > > > work, I can very well imagine that over-accounting can
> > > have a measureable
> > > > > > > > impact.
> > > > > > > What I can imagine as well is things like the hardware or
> > > firmware is
> > > > > > > looking at the fullness of the ring buffer to predict how
> > > much pending work
> > > > > > > there is.
> > > > > > > > > > > > I just wonder if we really want to ask for real
> > > measurements given that the
> > > > > > > > optimization is rather trivial and cheap and we already
> > > have enough evidence
> > > > > > > > that it makes sense conceptually.
> > > > > > > Well that's the point I disagree on, this callback isn't
> > > trivial. If (for
> > > > > > > example) the driver returns a value larger than initially
> > > estimated for the
> > > > > > > job we can run into an endless loop.
> > > > > > I agree it doesn't make sense to increase, but it wouldn't
> > > break anything,
> > > > > > unless the job size starts exceeding the capacity of the ring.
> > > And this case is
> > > > > > handled anyway.
> > > > > > > > > > It's just one more thing which can go boom. At bare
> > > minimum we should check
> > > > > > > that the value is always decreasing.
> > > > > > Considering the above I still agree, such a check makes sense
> > > - gonna add one.
> > > > > Please don't send anything out until we have solved this.
> > > > I did, but don't worry about this, it helped me to finalize the
> > > rest of the
> > > > patch. We can keep discussing this in this thread either way.
> > > > > > So far I haven't seen any argument which would not let me
> > > reject this and I
> > > > > don't want to waste your time.
> > > > > > > Regards,
> > > > > Christian.
> > > > > > > > - Danilo
> > > > > > > > > > Christian.
> > > > > > > > > > > > - Danilo
> > > > > > > > > > > > > > Regards,
> > > > > > > > > Christian.
> > > > > > > > > > > > > > > > Regards,
> > > > > > > > > > > > > > > > > Boris
> > 
> 

