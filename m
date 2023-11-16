Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E507EE25C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjKPOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKPOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:09:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB6AA7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700143758; x=1731679758;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=spRh+yF57jjoBWHvWpo/Tq4zxr8/j2rt/0b9L5ABdn0=;
  b=DXA8MTAd8QB+6AOFyjYVoPvCtpP/3GlI8as7lgFyKAszoXsc2IZSiyI5
   rh4FNaSuZnp6WAJ9ElAFYRP2kYw/YbjF5jFQkZco3C+6gs6qFnWi8BnyF
   odp7zm7fulxZn61xMVw7ifWn9gCjyrE5ZZC6Ytn1WRLyTFlKTQ0p8ERFI
   8+iEwWCXUCtgXHdu1WHmhmmVTzhhtUxK+eVKRzfJWjes4rVaUDNuqFi/D
   OSU/eLciW6vbJPiFuAFkpton4fwpKgpo7OP5b1YrSlQ09GKl/FAO8uiIp
   nA8vhy2inuW1oBx6UngJiNWb1nuE3QPJOgYlZUUFR23ComCDiW2ZCXf9v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12641895"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="12641895"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="6536734"
Received: from mcaspar-mobl1.ger.corp.intel.com (HELO [10.249.254.12]) ([10.249.254.12])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:09:14 -0800
Message-ID: <a0ba3f8c70ec939842f06127486e1e99795f7e6a.camel@linux.intel.com>
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     intel-xe@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Nov 2023 15:09:11 +0100
In-Reply-To: <c129fa94-6456-4746-9477-737a0fb61f96@redhat.com>
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
         <20231116104851.114bdb08@collabora.com>
         <0850281b667c4b88163dab60737dbc945ad742fd.camel@linux.intel.com>
         <c129fa94-6456-4746-9477-737a0fb61f96@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-16 at 15:02 +0100, Danilo Krummrich wrote:
> On 11/16/23 12:48, Thomas Hellstr=C3=B6m wrote:
>=20
> <snip>
>=20
> > > > +Locks used and locking orders
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +One of the benefits of VM_BIND is that local GEM objects share
> > > > the
> > > > gpu_vm's
> > > > +dma_resv object and hence the dma_resv lock. So even with a
> > > > huge
> > > > +number of local GEM objects, only one lock is needed to make
> > > > the
> > > > exec
> > > > +sequence atomic.
> > > > +
> > > > +The following locks and locking orders are used:
> > > > +
> > > > +* The ``gpu_vm->lock`` (optionally an rwsem). Protects how the
> > > > gpu_vm is
> > > > +=C2=A0 partitioned into gpu_vmas. It can also protect the gpu_vm's
> > > > list
> > > > of
> > > > +=C2=A0 userptr gpu_vmas. With a CPU mm analogy this would
> > > > correspond to
> > > > the
> > > > +=C2=A0 mmap_lock.
> > >=20
> > > I don't see any drm_gpuvm::lock field in Danilo's latest
> > > patchset,
> > > so,
> > > unless I missed one version, and this lock is actually provided
> > > by
> > > drm_gpuvm, I would mention this is a driver-specific lock. This
> > > comment
> > > applies to all the locks you describe here actually (mention
> > > which
> > > ones
> > > are provided by drm_gpuvm, and which ones are driver-specific).
> >=20
> > These will be needed also by gpuvm when implementing userptr vmas,
> > so I
> > can mention that drm_gpuvm is currently lacking a userptr
> > implementation, so "the locks described below are to be considered
> > driver-specific for now"
>=20
> Since Xe already implements userptr support, are you guys maybe
> interested
> in extending drm_gpuvm accordingly? :-)
>=20

I've been thinking of that but in that case that needs to happen after
the xe merge. Also we ofc need to clear it with the people who do
resource allocation on our side :)

Thanks,
Thomas

