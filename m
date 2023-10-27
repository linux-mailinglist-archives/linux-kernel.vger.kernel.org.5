Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A967D9DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjJ0Q0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0Q0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:26:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C72CA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:26:32 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EFFC66057B6;
        Fri, 27 Oct 2023 17:26:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698423990;
        bh=u+eAf6rUCUuBCgDmtSeis3dGhHGrPfqHsI8UHI18qzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bxRbOJOR2f2422kVHtPRdKtBgP+LoV6GIDY/zNs0Uhkv27evlIXRqFX/GWhnDH2bP
         CpIW9V8dWcfTWlBd80jxrcxAf0usHJbHUP24n1fEoK9txrmrqeOO2SowOyUjplYb6t
         IyAcj6WSBim//d1IVbktIDEcYZ2keR+LuAsLNgLoRv7Xju1QbzpkxFII4iAwrBaDf7
         UryAPELFSixktvMTX/yKIIstzgzjRzjnI0W9tddXnEX5aw4Webv3nLtTp/r4P+XKwv
         BF85tBVxZDBrvLPfYhioBuHRsVwSPgfx4Do3bxOarqRd2iz/Ky+gIHR95UuWD+ZMbz
         r7sLa+smBUIdg==
Date:   Fri, 27 Oct 2023 18:26:26 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Message-ID: <20231027182626.6a8ba090@collabora.com>
In-Reply-To: <794f9b45-db0d-4261-aefe-7da2ad0ed3b7@redhat.com>
References: <20231026161431.5934-1-dakr@redhat.com>
        <20231027091755.3635be36@collabora.com>
        <794f9b45-db0d-4261-aefe-7da2ad0ed3b7@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 16:34:26 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> On 10/27/23 09:17, Boris Brezillon wrote:
> > Hi Danilo,
> > 
> > On Thu, 26 Oct 2023 18:13:00 +0200
> > Danilo Krummrich <dakr@redhat.com> wrote:
> >   
> >> +
> >> +	/**
> >> +	 * @update_job_credits: Called once the scheduler is considering this
> >> +	 * job for execution.
> >> +	 *
> >> +	 * Drivers may use this to update the job's submission credits, which is
> >> +	 * useful to e.g. deduct the number of native fences which have been
> >> +	 * signaled meanwhile.
> >> +	 *
> >> +	 * The callback must either return the new number of submission credits
> >> +	 * for the given job, or zero if no update is required.
> >> +	 *
> >> +	 * This callback is optional.
> >> +	 */
> >> +	u32 (*update_job_credits)(struct drm_sched_job *sched_job);  
> > 
> > I'm copying my late reply to v2 here so it doesn't get lost:
> > 
> > I keep thinking it'd be simpler to make this a void function that
> > updates s_job->submission_credits directly. I also don't see the
> > problem with doing a sanity check on job->submission_credits. I mean,
> > if the driver is doing something silly, you can't do much to prevent it
> > anyway, except warn the user that something wrong has happened. If you
> > want to
> > 
> > 	WARN_ON(job->submission_credits == 0 ||
> > 		job->submission_credits > job_old_submission_credits);
> > 
> > that's fine. But none of this sanity checking has to do with the
> > function prototype/semantics, and I'm still not comfortable with this 0  
> > => no-change. If there's no change, we should just leave  
> > job->submission_credits unchanged (or return job->submission_credits)
> > instead of inventing a new special case.  
> 
> If we can avoid letting drivers change fields of generic structures directly
> without any drawbacks I think we should avoid it. Currently, drivers shouldn't
> have the need to mess with job->credits directly. The initial value is set
> through drm_sched_job_init() and is updated through the return value of
> update_job_credits().

Fair enough. I do agree that keeping internal fields out of driver
hands is a good thing in general, it's just that it's already
free-for-all in so many places in drm_sched (like the fact drivers
iterate the pending list in their stop-queue handling) that I didn't
really see it as an issue. Note that's there's always the option of
providing drm_sched_job_{update,get}_credits() helpers, with the update
helper making sure the new credits value is consistent (smaller or
equal to the old one, and not zero).

> 
> I'm fine getting rid of the 0 => no-change semantics though. Instead we can just
> WARN() on 0.

Yeah, I think that's preferable. It's pretty easy to return the old
value if the driver has a way to detect when nothing changed (with a
get helper if you don't want drivers to touch the credits field).

> However, if we do that I'd also want to change it for
> drm_sched_job_init() (where 0 currently defaults to 1) such that we accept 0, but
> WARN() accordingly.

Sure. You update all drivers anyway, so passing 1 instead of 0 is not a
big deal, I would say.

> 
> I think it's consequent to either consistently give 0 a different meaning or just
> accept it but WARN() on it.

Using default as a default value makes sense when you're passing
zero-initialized objects that are later extended with new fields, but
here you update the function prototype and all the call sites, so we're
better off considering 0 as an invalid value, IMHO.
