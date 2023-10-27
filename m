Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C587D8FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjJ0Hcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0Hcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:32:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A8194
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:32:43 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 665FF66071F1;
        Fri, 27 Oct 2023 08:32:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698391962;
        bh=wGt/lbRhILEM/Rjvh2nvIQRBqSqGnGIxsj9ivcKhlzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nYJxY9WejYkwmG4ZvP0Zn13pCis9iFzrc8E0HpRbXL+qP+u2lSvyT62zywoc4+wtf
         rJCdpJ571jfrrMkpMeH9TUPEuTF2QOYKTHjgK4ZzZbJYwtf8xSB85WOs+jgguzFLSl
         pxLSVSoFe6uDGukJsC1W/gqpzpByVLKzf5HDk5ghilAwt7u9eEn6J909tHzf1p9DQZ
         OTjH2agoeT4dwy6fQ5P14szKlKreBHjI0YBtOb8aU/9ZqMRmFFgq5YOppRmKcN5QTr
         0pDTCvE317JIZcyoPZx+FZgtSRrThrvenTk8rCh3Z7vX2rYg0rXlZ8twcHh/cvTClQ
         D/UifR+slyAag==
Date:   Fri, 27 Oct 2023 09:32:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Message-ID: <20231027093238.2ff8172e@collabora.com>
In-Reply-To: <0bc79ae3-04fe-4e85-9fd0-e8b281148390@amd.com>
References: <20231026161431.5934-1-dakr@redhat.com>
        <0bc79ae3-04fe-4e85-9fd0-e8b281148390@amd.com>
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

On Fri, 27 Oct 2023 09:22:12 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> > +
> > +	/**
> > +	 * @update_job_credits: Called once the scheduler is considering this
> > +	 * job for execution.
> > +	 *
> > +	 * Drivers may use this to update the job's submission credits, which=
 is
> > +	 * useful to e.g. deduct the number of native fences which have been
> > +	 * signaled meanwhile.
> > +	 *
> > +	 * The callback must either return the new number of submission credi=
ts
> > +	 * for the given job, or zero if no update is required.
> > +	 *
> > +	 * This callback is optional.
> > +	 */
> > +	u32 (*update_job_credits)(struct drm_sched_job *sched_job); =20
>=20
> Why do we need an extra callback for this?
>=20
> Just document that prepare_job() is allowed to reduce the number of=20
> credits the job might need.

->prepare_job() is called only once if the returned fence is NULL, but
we need this credit-update to happen every time a job is considered for
execution by the scheduler. If you're saying this control-flow should
be implemented with a dma_fence that's signaled when enough space is
available, I fear Danilo's work won't be that useful to the PowerVR
driver, unfortunately.
