Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585197ABF10
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjIWI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjIWI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:58:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9E194;
        Sat, 23 Sep 2023 01:58:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22F9C433C8;
        Sat, 23 Sep 2023 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459522;
        bh=O8EiSLhEdCxqqFSOJYtTaig/d7zFufVU+L6LPLjr9m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqEcSHEZ+l6vTmxiwq8AHSQFIC2Sh/9sXbMCfWkWLaXXX57fk5NVdF18/clTMpwoT
         J0r6lxieBB7Ke4qKFEcFWk9Z8GIB+6zt3hoVnCLZLZTjKasDeTlbmrpJzz6NpFJ5J2
         r8RvD3Bqb+qEtjyqqSUXapGVesxUOwuHIg0ToI3oKwFDOak7mmxgU1bFJ41sbygkYb
         bf0JVA+7IqsUwG9w6Ow/ZyNPEpdnfAZX7ngTmL+u3HMimCfMm5VxkhO6h9rw3s5j5T
         QCXXdan51VuR3mKi0BP+OAKkP0I1eLcJ2yVWcg1csw6JASbE/hGbgBEXotA87XRhnq
         I1VlPogaVVBgQ==
Date:   Sat, 23 Sep 2023 10:59:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with
 __counted_by
Message-ID: <ZQ8Zf0ckEeRwGr/X@work>
References: <20230922175319.work.096-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175319.work.096-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:53:19AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/cxl/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1c559879dcc..40d055560e52 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -14,7 +14,7 @@
>  
>  struct cxl_cxims_data {
>  	int nr_maps;
> -	u64 xormaps[];
> +	u64 xormaps[] __counted_by(nr_maps);
>  };
>  
>  /*
> @@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
>  			      GFP_KERNEL);
>  	if (!cximsd)
>  		return -ENOMEM;
> +	cximsd->nr_maps = nr_maps;
>  	memcpy(cximsd->xormaps, cxims->xormap_list,
>  	       nr_maps * sizeof(*cximsd->xormaps));
> -	cximsd->nr_maps = nr_maps;
>  	cxlrd->platform_data = cximsd;
>  
>  	return 0;
> -- 
> 2.34.1
> 
> 
