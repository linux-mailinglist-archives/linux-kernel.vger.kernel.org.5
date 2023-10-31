Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86E7DCBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjJaLZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjJaLZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:25:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE297
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698751535; x=1730287535;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CZ7/qD/Tv5Z4oH0wiTqiipmN3iPWBat7xPpjhvQgcJA=;
  b=WBOyWUeHxy13G7GNWkAQ5rW0k3NW4T/dLl571hD+sog2yAiLfvNasuir
   enK/xmOrs7yQwkj+1+hwLlOrFlmHT1UV7Rj/zpnD99dxBjPvj8KJ5t+hx
   g5WWZPwOouVQlZNeGSvinmmnCOyCTxkNexsQFBldxoccgXdIWGh+dcJpF
   t4bGxOy8ctg1nfiv8Gj+A0MwJy5jr0cCz++dk75crYdyHtUHMi80xZKcI
   +DBePlriUIpzdQ4WdUyqEVazrwydEyM8vTz4xdVlHQ2QMY02gUjp3Mben
   sojyZSe+E7B5OmoWzVMZpIDdD6rgnB5AiRTCCZj4SbjNXrtFS09T1jKu2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388091130"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388091130"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 04:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="754110635"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="754110635"
Received: from olindum-mobl1.ger.corp.intel.com (HELO [10.249.254.59]) ([10.249.254.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 04:25:31 -0700
Message-ID: <4a51c1cd9e2435332e033f9426bac8fae1c21c60.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next v7 4/7] drm/gpuvm: add an abstraction for
 a VM / BO combination
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Oct 2023 12:25:29 +0100
In-Reply-To: <20231023201659.25332-5-dakr@redhat.com>
References: <20231023201659.25332-1-dakr@redhat.com>
         <20231023201659.25332-5-dakr@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
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
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 335 +++++++++++++++++++++--
> --
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c |=C2=A0 64 +++--
> =C2=A0include/drm/drm_gem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +--
> =C2=A0include/drm/drm_gpuvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 188 +++++++++++++-
> =C2=A04 files changed, 533 insertions(+), 86 deletions(-)

That checkpatch.pl error still remains as well.

Thanks,
Thomas

