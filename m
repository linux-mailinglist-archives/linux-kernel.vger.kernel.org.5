Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157F7AD69B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjIYLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIYLEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:04:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B616AB;
        Mon, 25 Sep 2023 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695639838; x=1727175838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w8jzm9ukgkRaSpCF3iWY59UBd1VY/ShRBJdRFVOKN0U=;
  b=nUPOnuwIAwesCAhKDUbmf6PpjAvOkASj6KngY/wkEQNebW97J4Dc9t3w
   v5l8uRoqMXcyBa7Cd4bIx2vmb2yZ2583CVomUGCMXaZNF2wOK7KcnQQjl
   QLcnvxFUEM+ZJkbgSjkwG+mqWoMMnhoSC+ii0GSI+Dk90qAZnB4S9ViYs
   rLjnefSm4D/LehMrNFpoqZE/HGAu3Ho3KdSyZulmAcbWt7uZoP2Bkmkyq
   vBDhmRrIOrnQO1QN335xNWX3QB7sx8Osn4YWoCqFpSsKx9meCV/Ks07ah
   aoMICmlh+5Ew/rC52XewfzWOKG98D/BfuC9CIH/x3JeUP9/VbM+51Isxs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412153494"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="412153494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 04:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="921936202"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="921936202"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 04:03:54 -0700
Date:   Mon, 25 Sep 2023 13:03:52 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] accel/ivpu: Annotate struct ivpu_job with __counted_by
Message-ID: <20230925110352.GB846747@linux.intel.com>
References: <20230922175416.work.272-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175416.work.272-kees@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:54:17AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ivpu_job.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Please apply the patch via whatever tree is appropriate. Or if I have
to take it via drm-misc, please let me know.

Regards
Stanislaw

> ---
>  drivers/accel/ivpu/ivpu_job.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
> index aa1f0b9479b0..5514c2d8a609 100644
> --- a/drivers/accel/ivpu/ivpu_job.h
> +++ b/drivers/accel/ivpu/ivpu_job.h
> @@ -51,7 +51,7 @@ struct ivpu_job {
>  	u32 job_id;
>  	u32 engine_idx;
>  	size_t bo_count;
> -	struct ivpu_bo *bos[];
> +	struct ivpu_bo *bos[] __counted_by(bo_count);
>  };
>  
>  int ivpu_submit_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
> -- 
> 2.34.1
> 
