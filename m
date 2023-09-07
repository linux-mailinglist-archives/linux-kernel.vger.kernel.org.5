Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E557879763D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjIGQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjIGQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:04:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8F6A76;
        Thu,  7 Sep 2023 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102023; x=1725638023;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4Zc2NSQczgzpNCTjAeZ+vgoDDV24z7zZmEzSqmTWoV8=;
  b=UdfaggH2VB5SmzXi54f6JDs0yVt0a/jKfSP4xHqye9vADx4Kr3u8pl4e
   2s3kgggxgOE9fiEerRwc/BjSXHuvhgvg+h71NJKRD6jpIR7bkzi7QymOp
   jfqlPN/rn57HrUVze4IQDcGiFuNopiowLupxs8uV8FQDWGVHJdi4Snvu6
   gbwVQ+f7nkW1HpaoZ3mM2ViWukJZq6GrjhLuyv90WrFiSEg+wDDJaQ1WM
   +yCPNGZaZqlC7A+kTSTKR67A6fp7aU5yoB+y0jLmFoySzrqD2cbbkcZ32
   FkFQZQpPe59/A0o0/FiFfUi5NXd1tp7AJ60NvGjlE5oYIs+cQJh94ZWhm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="356825430"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="356825430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691782245"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="691782245"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:16:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Donald Robson <Donald.Robson@imgtec.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sarah Walker <Sarah.Walker@imgtec.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "luben.tuikov@amd.com" <luben.tuikov@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "afd@ti.com" <afd@ti.com>, "hns@goldelico.com" <hns@goldelico.com>,
        Matt Coster <Matt.Coster@imgtec.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dakr@redhat.com" <dakr@redhat.com>,
        "faith.ekstrand@collabora.com" <faith.ekstrand@collabora.com>
Subject: Re: [PATCH v6 02/20] drm/gpuva_mgr: Helper to get range of unmap
 from a remap op.
In-Reply-To: <5b7f431f26eea296193d9e49ea85e0377e6ebcf0.camel@imgtec.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230906095542.3280699-1-sarah.walker@imgtec.com>
 <20230906095542.3280699-3-sarah.walker@imgtec.com>
 <87a5tygoyx.fsf@intel.com>
 <5b7f431f26eea296193d9e49ea85e0377e6ebcf0.camel@imgtec.com>
Date:   Thu, 07 Sep 2023 16:15:57 +0300
Message-ID: <877cp2gm42.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023, Donald Robson <Donald.Robson@imgtec.com> wrote:
> On Thu, 2023-09-07 at 15:14 +0300, Jani Nikula wrote:
>> On Wed, 06 Sep 2023, Sarah Walker <sarah.walker@imgtec.com> wrote:
>> > From: Donald Robson <donald.robson@imgtec.com>
>> > 
>> > Signed-off-by: Donald Robson <donald.robson@imgtec.com>
>> > ---
>> >  include/drm/drm_gpuva_mgr.h | 27 +++++++++++++++++++++++++++
>> >  1 file changed, 27 insertions(+)
>> > 
>> > diff --git a/include/drm/drm_gpuva_mgr.h b/include/drm/drm_gpuva_mgr.h
>> > index ed8d50200cc3..be7b3a6d7e67 100644
>> > --- a/include/drm/drm_gpuva_mgr.h
>> > +++ b/include/drm/drm_gpuva_mgr.h
>> > @@ -703,4 +703,31 @@ void drm_gpuva_remap(struct drm_gpuva *prev,
>> >  
>> >  void drm_gpuva_unmap(struct drm_gpuva_op_unmap *op);
>> >  
>> > +/**
>> > + * drm_gpuva_op_remap_get_unmap_range() - Helper to get the start and range of
>> > + * the unmap stage of a remap op.
>> > + * @op: Remap op.
>> > + * @start_addr: Output pointer for the start of the required unmap.
>> > + * @range: Output pointer for the length of the required unmap.
>> > + *
>> > + * These parameters can then be used by the caller to unmap memory pages that
>> > + * are no longer required.
>> > + */
>> > +static __always_inline void
>> 
>> IMO __always_inline *always* requires a justification in the commit
>> message.
>> 
>> BR,
>> Jani.
>
> Hi Jani,
> I went with __always_inline because I can't see this being used more than once per driver.
> I can add that to the commit message, but is that suitable justification? I could move
> it to the source file or make it a macro if you prefer.

My personal opinion is that static inlines in general should always have
a performance justification. If there isn't one, it should be a regular
function. Static inlines leak the abstractions and often make the header
dependencies worse.

Not everyone agrees, of course.

More than anything I was looking for justification on __always_inline
rather than just inline, though.


BR,
Jani.



> Thanks,
> Donald
>> 
>> 
>> > +drm_gpuva_op_remap_get_unmap_range(const struct drm_gpuva_op_remap *op,
>> > +				   u64 *start_addr, u64 *range)
>> > +{
>> > +	const u64 va_start = op->prev ?
>> > +			     op->prev->va.addr + op->prev->va.range :
>> > +			     op->unmap->va->va.addr;
>> > +	const u64 va_end = op->next ?
>> > +			   op->next->va.addr :
>> > +			   op->unmap->va->va.addr + op->unmap->va->va.range;
>> > +
>> > +	if (start_addr)
>> > +		*start_addr = va_start;
>> > +	if (range)
>> > +		*range = va_end - va_start;
>> > +}
>> > +
>> >  #endif /* __DRM_GPUVA_MGR_H__ */

-- 
Jani Nikula, Intel Open Source Graphics Center
