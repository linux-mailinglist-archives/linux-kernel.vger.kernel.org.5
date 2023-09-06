Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456EB79369D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjIFH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjIFH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:57:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F71CF;
        Wed,  6 Sep 2023 00:57:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A0E246600BB0;
        Wed,  6 Sep 2023 08:57:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693987053;
        bh=/d9RcHcAhFerLHxSlk7UfUC6HLZV/5OjrHGohctDWxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HoSsO4qY8l/NwKrCxNZ+I/lu1TXPNw2Njwt2pc82vU2fpSt2U07MfBWqsR5VyPIMz
         XslL5l8yauC+7/mlKCKwFBN4ReUJ9VLrQdrHnVvvxrnVy/fzcJvCzjONoQmsBQHIwa
         KI9OA37SZVV+E8qzOX7ygG0MrGrq7sRyxQMOtiW0sjSLDwBiC4AQT3k8MoqLArjRn0
         XWLwV/1dKFRgR0lWFvvlmoeDQkVQfONUN8r8h4FoTucAM6SdxVbHP6WXm8dPJBiRmN
         8/DUVYrG2hKeJ91UqGNexnEIxFcQAY5r8lk3/Z84mUZgw51PFM9rAhJxeZn8+50Xrz
         pypUJp74ghYhQ==
Date:   Wed, 6 Sep 2023 09:57:30 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 2/8] drm/panfrost: Enable cycle counter register upon
 job submission
Message-ID: <20230906095730.27cb394f@collabora.com>
In-Reply-To: <20230905184533.959171-3-adrian.larumbe@collabora.com>
References: <20230905184533.959171-1-adrian.larumbe@collabora.com>
        <20230905184533.959171-3-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Sep 2023 19:45:18 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 033f5e684707..8b1bf6ac48f8 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -297,6 +297,11 @@ int panfrost_job_push(struct panfrost_job *job)
> =20
>  	kref_get(&job->refcount); /* put by scheduler job completion */
> =20
> +	if (atomic_read(&pfdev->profile_mode)) {
> +		panfrost_cycle_counter_get(pfdev);

This one should go in panfrost_job_hw_submit() IMO, otherwise you're
enabling the cycle-counter before the job has its dependencies met, and
depending on what the job depends on, it might take some time.

> +		job->is_profiled =3D true;
> +	}
> +
>  	drm_sched_entity_push_job(&job->base);
> =20
>  	mutex_unlock(&pfdev->sched_lock);
> @@ -351,6 +356,9 @@ static void panfrost_job_free(struct drm_sched_job *s=
ched_job)
> =20
>  	drm_sched_job_cleanup(sched_job);
> =20
> +	if (job->is_profiled)
> +		panfrost_cycle_counter_put(job->pfdev);

I think I'd move this panfrost_cycle_counter_put() to
panfrost_job_handle_{err,done}(), to release the counter as soon as
we're done executing the job. We also need to make sure we release
cycle counter refs in the reset path (here [1]), to keep get/put
balanced when jobs are resubmitted.

> +
>  	panfrost_job_put(job);
>  }

[1]https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/panfrost/=
panfrost_job.c#L666
