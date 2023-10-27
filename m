Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00D37D900C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbjJ0Hjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0Hju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:39:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7700194
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:39:48 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0152666071F1;
        Fri, 27 Oct 2023 08:39:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698392387;
        bh=j45biqkfxRiKG00fpgi7uRwnU46+FHWSLAeTKnn0EII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VcHWNHOXH+xh8+ZPNn4nQ3e2lFSd1AAuIZeXgZv4WMZVx/R1JOdoAB9PsQMtESjju
         wxwaSWYeCYciC0jijwlw98b7551TGzfOC07JpyqfHSMoBNqi55pzBfpf8er5ge+2NJ
         7PBGMRsJztf5fmUoJFFM28rNGCfOUELnLt0/3ygXbfksf2JmZF8FSQY+zGicvoYh3r
         DrNa5Tmz4hQDh0oCVEftINMYQwxMH2bs0SBQd2iSpJ7LSFQYMYH1GTuSx4E+W2urTX
         sr+qiIo6SfVvb0a/pPoYKtEW5v8OboTv4LCZKpJSkvVPj/NlvGVmdgUfWc9cGNpym8
         yKeAjgAVANyQQ==
Date:   Fri, 27 Oct 2023 09:39:43 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Message-ID: <20231027093943.3f0ae992@collabora.com>
In-Reply-To: <ff389793-1226-49fd-b599-07dbda0b97be@amd.com>
References: <20231026161431.5934-1-dakr@redhat.com>
        <0bc79ae3-04fe-4e85-9fd0-e8b281148390@amd.com>
        <20231027093238.2ff8172e@collabora.com>
        <ff389793-1226-49fd-b599-07dbda0b97be@amd.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 09:35:01 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 27.10.23 um 09:32 schrieb Boris Brezillon:
> > On Fri, 27 Oct 2023 09:22:12 +0200
> > Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> > =20
> >>> +
> >>> +	/**
> >>> +	 * @update_job_credits: Called once the scheduler is considering th=
is
> >>> +	 * job for execution.
> >>> +	 *
> >>> +	 * Drivers may use this to update the job's submission credits, whi=
ch is
> >>> +	 * useful to e.g. deduct the number of native fences which have been
> >>> +	 * signaled meanwhile.
> >>> +	 *
> >>> +	 * The callback must either return the new number of submission cre=
dits
> >>> +	 * for the given job, or zero if no update is required.
> >>> +	 *
> >>> +	 * This callback is optional.
> >>> +	 */
> >>> +	u32 (*update_job_credits)(struct drm_sched_job *sched_job); =20
> >> Why do we need an extra callback for this?
> >>
> >> Just document that prepare_job() is allowed to reduce the number of
> >> credits the job might need.
> > ->prepare_job() is called only once if the returned fence is NULL, but =
=20
> > we need this credit-update to happen every time a job is considered for
> > execution by the scheduler. =20
>=20
> But the job is only considered for execution once. How do you see that=20
> this is called multiple times?

Nope, it's not. If drm_sched_can_queue() returns false, the scheduler
will go look for another entity that has a job ready for execution, and
get back to this entity later, and test drm_sched_can_queue() again.
Basically, any time drm_sched_can_queue() is called, the job credits
update should happen, so we have an accurate view of how many credits
this job needs.
