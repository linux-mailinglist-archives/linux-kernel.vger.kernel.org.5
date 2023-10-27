Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D57D8F87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjJ0HRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjJ0HRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:17:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214619A0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:16:47 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0929A66071F1;
        Fri, 27 Oct 2023 08:16:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698391004;
        bh=cpBdTYW8vHHYaVRuft26NXdFNW0X6taMn5s0dkeghr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XV7EOtiCj+jXbWgQuAIqK7tQkPkfD/wcbgCuaGN+A4N81pwivLmkZhO6vt9Tg84zX
         2Yb1tlz9FrK+wkyGh8LvxUcsfBudWa5zaC8ECo5K3o2wofveD5wttcfhExd5b1St2p
         59DC/fdsVtTAc5f35vV1Pz+/sPSjUTxUTPEZ0+UKURX7SFS5aYo5e9XwqTH6AU5ki+
         nQkxA6S8RU+OltsBSOxS7rP5FKiwO+NVMYTipi0o0yR8ng7u8FnB9WwHuiaSg6BN9p
         R8O+BGcUKxaUTeIf+su1bh+w7gZ3eC2K0p6zlueCx8nmwaW8kgkyGAl+4fKsFSAQsj
         hSWlF8uXZ9b4A==
Date:   Fri, 27 Oct 2023 09:16:40 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v2] drm/sched: implement dynamic job-flow
 control
Message-ID: <20231027091640.50d68251@collabora.com>
In-Reply-To: <ZTb6azSfTV+LRGYu@pollux>
References: <20231009223554.11846-1-dakr@redhat.com>
        <20231010094151.4c116058@collabora.com>
        <ZTb6azSfTV+LRGYu@pollux>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Tue, 24 Oct 2023 00:57:47 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> > > +
> > > +	/**
> > > +	 * @update_job_credits: Called once the scheduler is considering this
> > > +	 * job for execution.
> > > +	 *
> > > +	 * Drivers may use this to update the job's submission credits, which is
> > > +	 * useful to e.g. deduct the number of native fences which have been
> > > +	 * signaled meanwhile.
> > > +	 *
> > > +	 * The callback must either return the new number of submission credits
> > > +	 * for the given job, or zero if no update is required.  
> > 
> > Any reason for having this special zero-means-no-update case? I mean,
> > drivers could just return sched_job->submission_credits if nothing
> > changed, and that would simplify the semantics IMHO. Another option, if  
> 
> I think I just did this because I thought it's a clever way to get rid of the
> need to deal with zero-sized jobs, which do not make much sense. In
> drm_sched_job_init() passing a zero job size defaults to one, which I think is
> reasonable. Doing the same thing here is more likely to hide a bug. However, the
> same is probably true for 'zero means no update' though. Maybe we should just
> WARN() in such a case.
> 
> > we want to avoid the sched_job->submission_credits assignment when
> > nothing changes would be to make it a void function and let it update
> > the sched_job->submission_credits directly.  
> 
> Sure, that's an option as well. However, I'd probably prefer the new job size to
> be the return value. Having to sanity check job->submission_credits afterwards
> isn't that nice either.

Uh, sorry for the late reply, I see you've sent a v3 already :-/. I keep
thinking it'd be simpler to make this a void function that updates
s_job->submission_credits directly. I also don't see the problem with
doing a sanity check on job->submission_credits. I mean, if the driver
is doing something silly, you can't do much to prevent it anyway,
except warn the user that something wrong has happened. If you want to

	WARN_ON(job->submission_credits == 0 ||
		job->submission_credits > job_old_submission_credits);

that's fine. But none of this sanity checking has to do with the
function prototype/semantics, and I'm still not comfortable with this 0
=> no-change. If there's no change, we should just leave
job->submission_credits unchanged (or return job->submission_credits)
instead of inventing a new special case.

Regards,

Boris
