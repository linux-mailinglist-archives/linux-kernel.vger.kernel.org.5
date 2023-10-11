Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E057C4CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJKIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJKIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:22:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818092
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012547; x=1728548547;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rop2SO3ybzEk4DVuIiU1MtKYn2SMe0Tm8G/1drFuF44=;
  b=RjwKArkKyoJataX/EgLYTvxKNkeUV1+J/hMRIYPKflfIEtVokXqLfPix
   eAfaD/SIxUE6z6xk1jfH9RgKaFEQQkMFu/IRsVjwY52PM31H9R8Ms5M9W
   AwGBeo626AOSUHd1hS18FuBNH4mXNuUPo069nK96OIN4APf6DPayKrkzT
   9stAlks8olT47OE3LYn7jQmcUInO2mgfeoTCbpRRsrh4+1gYkRVKnw9EA
   Yf5L9Iy+NmlDHc0T2AKSw1P4EMldSLEN4c2JBT03qqhwAHjoTAhYPbjtD
   SsLjxN0YQs6sAleHE4X/slBw02JLXRKEv6/s18WdlUB1nuk2L2U+Ti4mX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448810097"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="448810097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877580799"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877580799"
Received: from clanggaa-mobl.ger.corp.intel.com (HELO [10.249.254.169]) ([10.249.254.169])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:22:22 -0700
Message-ID: <925e4c2d15161ce8115409b6af97dab9a2996bf7.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next 2/3] drm/gpuva_mgr: generalize
 dma_resv/extobj handling and GEM validation
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Dave Airlie <airlied@gmail.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= "(Intel)" 
        <thomas_os@shipmail.org>
Cc:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Wed, 11 Oct 2023 10:22:20 +0200
In-Reply-To: <CAPM=9tz3o-m+8VJJ6hxWhykat0kpp1UE7dBJE3X91aHHo1Y2VA@mail.gmail.com>
References: <20230820215320.4187-1-dakr@redhat.com>
         <20230820215320.4187-3-dakr@redhat.com>
         <0c50ff22-0f11-1e27-c32e-694ce2b1e6c5@shipmail.org>
         <ZO864yp3UyVEfEjz@pollux>
         <88c45fe6-0942-707c-9ea7-8486c177fcd7@shipmail.org>
         <ZO9Zq2RhbX8EeHrn@pollux>
         <736b6b6d-9e04-a27d-7d60-0c45d696b304@shipmail.org>
         <ZPB26A0/oLHTmyqk@cassiopeiae>
         <a8f28d62-daec-927a-a33d-5be3eec6a1ed@shipmail.org>
         <ZPDk/lao1JlBNGoJ@cassiopeiae>
         <8a8253ae-0b85-df90-b480-64eeebfafc6d@shipmail.org>
         <CAPM=9tz3o-m+8VJJ6hxWhykat0kpp1UE7dBJE3X91aHHo1Y2VA@mail.gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-11 at 06:23 +1000, Dave Airlie wrote:
> > I think we're then optimizing for different scenarios. Our compute
> > driver will use mostly external objects only, and if shared, I
> > don't
> > forsee them bound to many VMs. What saves us currently here is that
> > in
> > compute mode we only really traverse the extobj list after a
> > preempt
> > fence wait, or when a vm is using a new context for the first time.
> > So
> > vm's extobj list is pretty large. Each bo's vma list will typically
> > be
> > pretty small.
>=20
> Can I ask why we are optimising for this userspace, this seems
> incredibly broken.

First Judging from the discussion with Christian this is not really
uncommon. There *are* ways that we can play tricks in KMD of assorted
cleverness to reduce the extobj list size, but doing that in KMD that
wouldn't be much different than accepting a large extobj list size and
do what we can to reduce overhead of iterating over it.

Second the discussion here really was about whether we should be using
a lower level lock to allow for async state updates, with a rather
complex mechanism with weak reference counting and a requirement to
drop the locks within the loop to avoid locking inversion. If that were
a simplification with little or no overhead all fine, but IMO it's not
a simplification?

>=20
> We've has this sort of problem in the past with Intel letting the
> tail
> wag the horse, does anyone remember optimising relocations for a
> userspace that didn't actually need to use relocations?

>=20
> We need to ask why this userspace is doing this, can we get some
> pointers to it? compute driver should have no reason to use mostly
> external objects, the OpenCL and level0 APIs should be good enough to
> figure this out.

TBH for the compute UMD case, I'd be prepared to drop the *performance*
argument of fine-grained locking the extobj list since it's really only
traversed on new contexts and preemption. But as Christian mentions
there might be other cases. We should perhaps figure those out and
document?

/Thoams


>=20
> Dave.

