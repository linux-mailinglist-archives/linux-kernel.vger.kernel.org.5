Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CF75FBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGXQYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGXQYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:24:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B58E4F;
        Mon, 24 Jul 2023 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215874; x=1721751874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UrlDO9w/AnWLaZUBmhVjpnmqS7Elf1R30ZuiU+UuJds=;
  b=UGIL84FIHpqWCh4QivC02xai2GREWppVtJ3YC/OOmQotjoze6PAHxsN3
   mbWsCuHO52U+EGGQwnStqPq4p/nhu6iO0P6QTLSxydON31ewnf6hoCWll
   W8f0KedSuTkpAd2KlWdAjJjVlmKx6FHhYyjplFX15Keuf1APfsZav89GZ
   tqPXx0XX3eBSUPYV4UIU7wfqQAKDd7Wl6ia1EKI1KtgYFiliv5qRmhCcs
   Yd8Xp435zbe5Rr5UeElFWYLFEr1IRYJ5s7cBtWmJZZI1LEeyVC9orpjK/
   5Dd4oDGSRtxbLDBkcSwS3UU/VaOLAKvdQ3X7NJKpLlJcUOkeZmCLhipb/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347093718"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347093718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="755362747"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="755362747"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.34.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:24:27 -0700
Date:   Mon, 24 Jul 2023 18:24:24 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix an error handling path in
 igt_write_huge()
Message-ID: <ZL6luGRLCEQs0HKG@ashyti-mobl2.lan>
References: <7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, Jul 17, 2023 at 08:49:31PM +0200, Christophe JAILLET wrote:
> All error handling paths go to 'out', except this one. Be consistent and
> also branch to 'out' here.
> 
> Fixes: c10a652e239e ("drm/i915/selftests: Rework context handling in hugepages selftests")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\ Speculative /!\
> 
>    This patch is based on analysis of the surrounding code and should be
>    reviewed with care !
> 
>    If the patch is wrong, maybe a comment in the code could explain why.
> 
> /!\ Speculative /!\
> ---
>  drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> index df6c9a84252c..6b9f6cf50bf6 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> @@ -1246,8 +1246,10 @@ static int igt_write_huge(struct drm_i915_private *i915,
>  	 * times in succession a possibility by enlarging the permutation array.
>  	 */
>  	order = i915_random_order(count * count, &prng);
> -	if (!order)
> -		return -ENOMEM;
> +	if (!order) {
> +		err = -ENOMEM;
> +		goto out;
> +	}

Looks good:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks,
Andi
