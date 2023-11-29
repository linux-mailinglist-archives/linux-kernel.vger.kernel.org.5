Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BB7FE0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjK2UYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2UYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:24:02 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FAAD67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:24:09 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id B5BDB14B27C; Wed, 29 Nov 2023 15:24:06 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Luben Tuikov <ltuikov89@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>
Subject: Re: Radeon regression in 6.6 kernel
In-Reply-To: <05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net>
 <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com>
 <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <05007cb0-871e-4dc7-af58-1351f4ba43e2@gmail.com>
Date:   Wed, 29 Nov 2023 15:24:06 -0500
Message-ID: <87wmu0ux3t.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov <ltuikov89@gmail.com> writes:

> I remember that the problem was really that amdgpu called drm_sched_entity_init(),
> in amdgpu_ttm_set_buffer_funcs_status() without actually having initialized the scheduler
> used therein. For instance, the code before commit b70438004a14f4, looked like this:
>

<snip>

> 		sched = &ring->sched;                             <-- LT: No one has initialized this scheduler
>	        r = drm_sched_entity_init(&adev->mman.entity,     <-- Oopses, now that sched->sched_rq is not

<snip>

> Before commit 56e449603f0ac5, amdgpu was getting away with this, because the sched->sched_rq
> was a static array.
>
> Ideally, amdgpu code would be fixed.

This sounds like an initilization problem that resulted in an OOPS at
boot time, but I don't remember seeing that.  I just get a failure on
system suspend.
