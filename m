Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350BD7C85D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjJMMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJMMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:33:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D2A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697200409; x=1728736409;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k/rvVq8q+IqqsoyhqIOvlrS0FNUPIZSTYcQ/RlXyHLA=;
  b=SnIAzZ53GJ7WfWF/3ECUsrEYsbcpdM4RV90fhadDSpgVQiYijJzJs6qa
   e0Yrrjea1rueWBivq5WlOuOEnTQBkOkQHPkHZm3L9jHhUalSEbwD5qgnu
   qZbDrV/ZfdQIP7rMQq2PD7qLlNOUBjDLVED4rekrfKQPeynwVa8hEjNBm
   /slWffgcgkQFsbDkjVILvgrJzTmL7HSfU0Yj++0m4A7vP+glIWh61jIct
   90yi41q1p8HU55MClLaLOs6Dvf6ItgqlTNIC4o8+9spgGoAyRHzBzUdsy
   B0uekjjHxHtBGkP7kWBQkIukjxauj/CRfp0ULsB8yApfZ2ZUGlkxQy0to
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370235109"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="370235109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:33:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="871064746"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="871064746"
Received: from dstacken-mobl1.ger.corp.intel.com (HELO [10.249.254.172]) ([10.249.254.172])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:33:25 -0700
Message-ID: <612d1b7e7ebb01cb8a975d68a8f9b763187610eb.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next v6 3/6] drm/gpuvm: add an abstraction for
 a VM / BO combination
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 14:33:23 +0200
In-Reply-To: <20231008233212.13815-4-dakr@redhat.com>
References: <20231008233212.13815-1-dakr@redhat.com>
         <20231008233212.13815-4-dakr@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-09 at 01:32 +0200, Danilo Krummrich wrote:
> Add an abstraction layer between the drm_gpuva mappings of a
> particular
> drm_gem_object and this GEM object itself. The abstraction represents
> a
> combination of a drm_gem_object and drm_gpuvm. The drm_gem_object
> holds
> a list of drm_gpuvm_bo structures (the structure representing this
> abstraction), while each drm_gpuvm_bo contains list of mappings of
> this
> GEM object.
>=20
> This has multiple advantages:
>=20
> 1) We can use the drm_gpuvm_bo structure to attach it to various
> lists
> =C2=A0=C2=A0 of the drm_gpuvm. This is useful for tracking external and e=
victed
> =C2=A0=C2=A0 objects per VM, which is introduced in subsequent patches.
>=20
> 2) Finding mappings of a certain drm_gem_object mapped in a certain
> =C2=A0=C2=A0 drm_gpuvm becomes much cheaper.
>=20
> 3) Drivers can derive and extend the structure to easily represent
> =C2=A0=C2=A0 driver specific states of a BO for a certain GPUVM.
>=20
> The idea of this abstraction was taken from amdgpu, hence the credit
> for
> this idea goes to the developers of amdgpu.
>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
> =C2=A0drivers/gpu/drm/drm_gpuvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 332 +++++++++++++++++++++--
> --
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c |=C2=A0 64 +++--
> =C2=A0include/drm/drm_gem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +--
> =C2=A0include/drm/drm_gpuvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 177 ++++++++++++-
> =C2=A04 files changed, 521 insertions(+), 84 deletions(-)

Forgot to mention, there are a couple of checkpatch.pl --strict issues
with this patch that might need looking at.

Thanks,
Thomas

