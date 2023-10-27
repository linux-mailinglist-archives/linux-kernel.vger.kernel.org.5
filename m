Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2F7D9E04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjJ0QcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJ0QcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:32:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8576211B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:32:03 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93F406607323;
        Fri, 27 Oct 2023 17:32:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698424322;
        bh=cdST41zz4Xh7cdHsxvEEbk6c5k5UXnNOVUkeHyEAKjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P3vWQcsRrCviL0oMUJmcK53bzDSKtPhCZ0M/VqOKWMZl+UP5peJ+Bha8ncbvUNz/w
         89TGVnmVl4rInQPWzFpGai/Er/93bUwynpxlj9gYSROMc+SaZ46eEvOTLz2qojh+yl
         2U9Paw7jmPF7dcDtuffefm1tMFUVI8qbJWOflIUvbh+J5XxlDoM9MrqPzaZTAlZB1q
         ZfN8bntBWol7ImsK0EpcRSeL7+JwAGnvM/yFwgkNGs91GkT5/28EtJD6h/HvAWzvto
         xjQkh6qQGTDaCxqto5Cl22hx3mKB6zUoDZRGKlpYLTBKiKHYEusans3OB1K39u6jck
         3OzE8Nwcv4qaA==
Date:   Fri, 27 Oct 2023 18:31:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Message-ID: <20231027183158.2dc4cce4@collabora.com>
In-Reply-To: <8e117f9f-a01c-4242-8781-b2ed4969513b@redhat.com>
References: <20231026161431.5934-1-dakr@redhat.com>
        <20231027102516.0e4b00ef@collabora.com>
        <8e117f9f-a01c-4242-8781-b2ed4969513b@redhat.com>
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

On Fri, 27 Oct 2023 16:23:24 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> On 10/27/23 10:25, Boris Brezillon wrote:
> > Hi Danilo,
> > 
> > On Thu, 26 Oct 2023 18:13:00 +0200
> > Danilo Krummrich <dakr@redhat.com> wrote:
> >   
> >> Currently, job flow control is implemented simply by limiting the number
> >> of jobs in flight. Therefore, a scheduler is initialized with a credit
> >> limit that corresponds to the number of jobs which can be sent to the
> >> hardware.
> >>
> >> This implies that for each job, drivers need to account for the maximum
> >> job size possible in order to not overflow the ring buffer.
> >>
> >> However, there are drivers, such as Nouveau, where the job size has a
> >> rather large range. For such drivers it can easily happen that job
> >> submissions not even filling the ring by 1% can block subsequent
> >> submissions, which, in the worst case, can lead to the ring run dry.
> >>
> >> In order to overcome this issue, allow for tracking the actual job size
> >> instead of the number of jobs. Therefore, add a field to track a job's
> >> credit count, which represents the number of credits a job contributes
> >> to the scheduler's credit limit.
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> >> ---
> >> Changes in V2:
> >> ==============
> >>    - fixed up influence on scheduling fairness due to consideration of a job's
> >>      size
> >>      - If we reach a ready entity in drm_sched_select_entity() but can't actually
> >>        queue a job from it due to size limitations, just give up and go to sleep
> >>        until woken up due to a pending job finishing, rather than continue to try
> >>        other entities.
> >>    - added a callback to dynamically update a job's credits (Boris)  
> > 
> > This callback seems controversial. I'd suggest dropping it, so the
> > patch can be merged.  
> 
> I don't think we should drop it just for the sake of moving forward. If there are objections
> we'll discuss them. I've seen good reasons why the drivers you are working on require this,
> while, following the discussion, I have *not* seen any reasons to drop it. It helps simplifying
> driver code and doesn't introduce any complexity or overhead to existing drivers.

Up to you. I'm just saying, moving one step in the right direction is
better than being stuck, and it's not like adding this callback in a
follow-up patch is super complicated either. If you're confident that
we can get all parties to agree on keeping this hook, fine by me.
