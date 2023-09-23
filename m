Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404627ABF1A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjIWJBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjIWJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:01:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F29196
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 02:01:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47033C433C7;
        Sat, 23 Sep 2023 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459663;
        bh=Ph0YP5DcW/CkJHTyGd1Be/WwWTvyOrrGqJl4wtXJD3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB8e5nSvvBiJq8VhkGefgcb25VbcHO1iGHcMp2qDARNG/vnMcRpkf1kYddrCrpYWB
         qNWC/pMJRFLTGSIES0iYLTBnONTJgImkeer8e8zBL8rz981TPYJ608vCSVR9p6EFwr
         KvLVsC/rejjgcfLT69qHEJLYCErQO1sOMqzstnWTcHbePkfBLELetOPTV0ldRSqAgH
         6EnqEO+sa0WtMBF9NR846+7w2qFgYzdWUSBeknPMrUF5XuLYdxpqcuAMdl9M0ynMYr
         DlBg5Rv/T32L6j78jMBzWZijWjJh7V/6+3K6Y/Q39IKEzsB9g+Lgy7vn4F1PtW/GtS
         bflAvqWfqyyQg==
Date:   Sat, 23 Sep 2023 11:02:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: Annotate struct nd_region with __counted_by
Message-ID: <ZQ8aDS3PUvidk9VV@work>
References: <20230922175238.work.116-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175238.work.116-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:52:39AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nd_region.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: nvdimm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/nvdimm/nd.h          | 2 +-
>  drivers/nvdimm/region_devs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index e8b9d27dbb3c..ae2078eb6a62 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -422,7 +422,7 @@ struct nd_region {
>  	struct nd_interleave_set *nd_set;
>  	struct nd_percpu_lane __percpu *lane;
>  	int (*flush)(struct nd_region *nd_region, struct bio *bio);
> -	struct nd_mapping mapping[];
> +	struct nd_mapping mapping[] __counted_by(ndr_mappings);
>  };
>  
>  static inline bool nsl_validate_nlabel(struct nd_region *nd_region,
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 0a81f87f6f6c..5be65fce85cf 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1028,6 +1028,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  
>  	if (!nd_region)
>  		return NULL;
> +	nd_region->ndr_mappings = ndr_desc->num_mappings;
>  	/* CXL pre-assigns memregion ids before creating nvdimm regions */
>  	if (test_bit(ND_REGION_CXL, &ndr_desc->flags)) {
>  		nd_region->id = ndr_desc->memregion;
> @@ -1062,7 +1063,6 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  
>  		get_device(&nvdimm->dev);
>  	}
> -	nd_region->ndr_mappings = ndr_desc->num_mappings;
>  	nd_region->provider_data = ndr_desc->provider_data;
>  	nd_region->nd_set = ndr_desc->nd_set;
>  	nd_region->num_lanes = ndr_desc->num_lanes;
> -- 
> 2.34.1
> 
> 
