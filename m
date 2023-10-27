Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31207D8F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJ0HSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjJ0HSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:18:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F61BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:18:00 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1EB066072FC;
        Fri, 27 Oct 2023 08:17:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698391079;
        bh=w/e9oob7hOM84wZctGqMXlvAjyoXB4ZayuMpg1DFtoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iYXmJ00v795Yr+zDHJDGbHzhx2cS3to1OcLA4ajP8OjGJia2t36WLicmzsOY9p5Ki
         c4FwassYWQTyjXskC82OSEDK8xt6l4/fAbJX/6K8klh8vvSQ0+fV8sLD8tJpbuo8Wu
         JmXD4xnw/9ZOJmgrUyow6JTLDWwTcd+aOSSPmSUSUB87xm9CZrwfRVwUTrazg9TXkc
         MxGXHnG3mobJzWqN4nUd68XGJlMOM+Ty5rI9YBol5/BQC5UhYTj/PYoV2rOpFFKLZa
         Ef0ROodFZJb4+CC35AvtD2cL+0B8R5W3gbKd1h0aYO/VpxTcsHGEGEAwLcZLBH2m2D
         tS7n10mQNpzmw==
Date:   Fri, 27 Oct 2023 09:17:55 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Message-ID: <20231027091755.3635be36@collabora.com>
In-Reply-To: <20231026161431.5934-1-dakr@redhat.com>
References: <20231026161431.5934-1-dakr@redhat.com>
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

On Thu, 26 Oct 2023 18:13:00 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> +
> +	/**
> +	 * @update_job_credits: Called once the scheduler is considering this
> +	 * job for execution.
> +	 *
> +	 * Drivers may use this to update the job's submission credits, which is
> +	 * useful to e.g. deduct the number of native fences which have been
> +	 * signaled meanwhile.
> +	 *
> +	 * The callback must either return the new number of submission credits
> +	 * for the given job, or zero if no update is required.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	u32 (*update_job_credits)(struct drm_sched_job *sched_job);

I'm copying my late reply to v2 here so it doesn't get lost:

I keep thinking it'd be simpler to make this a void function that
updates s_job->submission_credits directly. I also don't see the
problem with doing a sanity check on job->submission_credits. I mean,
if the driver is doing something silly, you can't do much to prevent it
anyway, except warn the user that something wrong has happened. If you
want to

	WARN_ON(job->submission_credits == 0 ||
		job->submission_credits > job_old_submission_credits);

that's fine. But none of this sanity checking has to do with the
function prototype/semantics, and I'm still not comfortable with this 0
=> no-change. If there's no change, we should just leave  
job->submission_credits unchanged (or return job->submission_credits)
instead of inventing a new special case.

Regards,

Boris
