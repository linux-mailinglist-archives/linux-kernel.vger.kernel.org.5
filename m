Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51437B7DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjJDLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjJDLGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:06:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6355AB0;
        Wed,  4 Oct 2023 04:06:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FC0D6607038;
        Wed,  4 Oct 2023 12:06:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696417564;
        bh=sCoRUm/yErIinRg3cxNQnIzO1owQHzL0i3WFVtdDzXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BSFw6URRG5wWAbJKZMDyBO1alEaelaRms8/qCzOc0XZ81ii5h2033ILbzJTt+JnOD
         2pqX2xlMWsQ73sthZiakVGejXXN5J5+AjVU050hoq2EppEhYV7wNTmx1JP37y82aYb
         7Ob4uY2EHpjDLembhJcjjk+xICMFXlLoHzTyeP45r3iV71tO+uqWkqC4fkmySYWE1W
         xcuEyjfolhNZ2abRNsnHPP+LUt613FisRCpbxg4Mv3kzRdThp/hB0val8ovd6J5qpA
         rn84bv6cCDI7lkMPFDXKFQgtkEGarXTJgwEvuZTyEorlOUK3WEpf9LT7+j1jAzxNvu
         wG6fWN+AzjWIQ==
Date:   Wed, 4 Oct 2023 13:06:01 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, tvrtko.ursulin@linux.intel.com
Subject: Re: [PATCH v8 0/5]  Add fdinfo support to Panfrost
Message-ID: <20231004130601.60239c7f@collabora.com>
In-Reply-To: <20230929181616.2769345-1-adrian.larumbe@collabora.com>
References: <20230929181616.2769345-1-adrian.larumbe@collabora.com>
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

On Fri, 29 Sep 2023 19:14:26 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> This patch series adds fdinfo support to the Panfrost DRM driver. It will
> display a series of key:value pairs under /proc/pid/fdinfo/fd for render
> processes that open the Panfrost DRM file.
>=20
> The pairs contain basic drm gpu engine and memory region information that
> can either be cat by a privileged user or accessed with IGT's gputop
> utility.
>=20
> Changelog:
>=20
> v1: https://lore.kernel.org/lkml/bb52b872-e41b-3894-285e-b52cfc849782@arm=
.com/T/
>=20
> v2: https://lore.kernel.org/lkml/20230901084457.5bc1ad69@collabora.com/T/
>  - Changed the way gpu cycles and engine time are calculated, using GPU
>    registers and taking into account potential resets.
>  - Split render engine values into fragment and vertex/tiler ones.
>  - Added more fine-grained calculation of RSS size for BO's.
>  - Implemente selection of drm-memory region size units.
>  - Removed locking of shrinker's mutex in GEM obj status function.
>=20
> v3: https://lore.kernel.org/lkml/20230905184533.959171-1-adrian.larumbe@c=
ollabora.com/
>  - Changed fdinfo engine names to something more descriptive.;
>  - Mentioned GPU cycle counts aren't an exact measure.
>  - Handled the case when job->priv might be NULL.
>  - Handled 32 bit overflow of cycle register.
>  - Kept fdinfo drm memory stats size unit display within 10k times the
>    previous multiplier for more accurate BO size numbers.
>  - Removed special handling of Prime imported BO RSS.
>  - Use rss_size only for heap objects.
>  - Use bo->base.madv instead of specific purgeable flag.
>  - Fixed kernel test robot warnings.
>=20
> v4: https://lore.kernel.org/lkml/20230912084044.955864-1-adrian.larumbe@c=
ollabora.com/
>  - Move cycle counter get and put to panfrost_job_hw_submit and
>    panfrost_job_handle_{err,done} for more accuracy.
>  - Make sure cycle counter refs are released in reset path
>  - Drop the model param for toggling cycle counting and do
>    leave it down to the debugfs file.
>  - Don't disable cycle counter when togglint debugfs file,
>    let refcounting logic handle it instead.
>  - Remove fdinfo data nested structure definion and 'names' field
>  - When incrementing BO RSS size in GPU MMU page fault IRQ handler, assume
>    granuality of 2MiB for every successful mapping.
>  - drm-file picks an fdinfo memory object size unit that doesn't lose pre=
cision.
>=20
> v5: https://lore.kernel.org/lkml/20230914223928.2374933-1-adrian.larumbe@=
collabora.com/
>  - Removed explicit initialisation of atomic variable for profiling mode,
>    as it's allocated with kzalloc.
>  - Pass engine utilisation structure to jobs rather than the file context=
, to avoid
>    future misusage of the latter.
>  - Remove double reading of cycle counter register and ktime in job deqeu=
eue function,
>    as the scheduler will make sure these values are read over in case of =
requeuing.
>  - Moved putting of cycle counting refcnt into panfrost job dequeue.
>    function to avoid repetition.
>=20
> v6: https://lore.kernel.org/lkml/c73ad42b-a8db-23c2-86c7-1a2939dba044@lin=
ux.intel.com/T/
>  - Fix wrong swapped-round engine time and cycle values in fdinfo
>    drm print statements.
>=20
> v7: https://lore.kernel.org/lkml/20230927213133.1651169-6-adrian.larumbe@=
collabora.com/T/
>  - Make sure an object's actual RSS size is added to the overall fdinfo's=
 purgeable
>    and active size tally when it's both resident and purgeable or active.
>  - Create a drm/panfrost.rst documentation file with meaning of fdinfo st=
rings.
>  - BUILD_BUG_ON checking the engine name array size for fdinfo.
>  - Added copyright notices for Amazon in Panfrost's new debugfs files.
>  - Discarded fdinfo memory stats unit size selection patch.
>=20
> v8:
>  - Style improvements and addressing nitpicks.        =20
>=20
> Adri=C3=A1n Larumbe (5):
>   drm/panfrost: Add cycle count GPU register definitions
>   drm/panfrost: Add fdinfo support GPU load metrics
>   drm/panfrost: Add fdinfo support for memory stats
>   drm/drm_file: Add DRM obj's RSS reporting function for fdinfo
>   drm/panfrost: Implement generic DRM object RSS reporting function

Queued to drm-misc-next.

Thanks!

Boris

>=20
>  Documentation/gpu/drm-usage-stats.rst       |  1 +
>  Documentation/gpu/panfrost.rst              | 38 +++++++++++++
>  drivers/gpu/drm/drm_file.c                  |  8 +--
>  drivers/gpu/drm/panfrost/Makefile           |  2 +
>  drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ++++++++
>  drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 +++++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c |  8 +++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 ++
>  drivers/gpu/drm/panfrost/panfrost_device.c  |  2 +
>  drivers/gpu/drm/panfrost/panfrost_device.h  | 13 +++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c     | 60 ++++++++++++++++++++-
>  drivers/gpu/drm/panfrost/panfrost_gem.c     | 30 +++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gem.h     |  5 ++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c     | 41 ++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h     |  4 ++
>  drivers/gpu/drm/panfrost/panfrost_job.c     | 24 +++++++++
>  drivers/gpu/drm/panfrost/panfrost_job.h     |  5 ++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     |  1 +
>  drivers/gpu/drm/panfrost/panfrost_regs.h    |  5 ++
>  include/drm/drm_gem.h                       |  9 ++++
>  20 files changed, 290 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/gpu/panfrost.rst
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
>=20
>=20
> base-commit: f45acf7acf75921c0409d452f0165f51a19a74fd

