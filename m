Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49D757B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGRMLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGRMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:11:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D471726;
        Tue, 18 Jul 2023 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689682256; x=1721218256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g861e9x38BavCkoCdJAt5TnAFAkblB6XYSxbGTOkjLc=;
  b=C0J9iJz5jOukZ/NJX4ZBN+vuCSuAp2uTOOQk3i1hcOy5CUOSHUQch8WO
   +AlJNxEFfzRApdIPOOu2StxfV/p9VRYplpiKFnNvBum3hdYS8hUHzbQH1
   7zOK8dUDNBPWtpnkuKsaHqmDvWcoUW04prY3LcBCM2AfxERHoA2T09fFm
   Dg+YuCWXK7mRb+ILu2STxAzAR9iYlL6HzMYbVZ4PRUXjPhBf6EU/7Dxmp
   rJs8TluLg7cSLNCKoKP8GI1dFSkS7N+0Bp0/SDEwlkLBPR0Uk0XtQRas8
   Xhlf5ZyNXVxzzAUZr/kLvNdoy+CAS1LIMxYsMo6dwvDJKgCTEhr4b6Kp9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366230092"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366230092"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 05:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793605769"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="793605769"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.19.167]) ([10.213.19.167])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 05:10:48 -0700
Message-ID: <e1dafe04-0375-08a0-dca0-707d68ea5bd5@intel.com>
Date:   Tue, 18 Jul 2023 14:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix an error handling path in
 igt_write_huge()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2023 20:49, Christophe JAILLET wrote:
> All error handling paths go to 'out', except this one. Be consistent and
> also branch to 'out' here.
> 
> Fixes: c10a652e239e ("drm/i915/selftests: Rework context handling in hugepages selftests")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


For me seems correct.

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej


> ---
> /!\ Speculative /!\
> 
>     This patch is based on analysis of the surrounding code and should be
>     reviewed with care !
> 
>     If the patch is wrong, maybe a comment in the code could explain why.
> 
> /!\ Speculative /!\
> ---
>   drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> index df6c9a84252c..6b9f6cf50bf6 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> @@ -1246,8 +1246,10 @@ static int igt_write_huge(struct drm_i915_private *i915,
>   	 * times in succession a possibility by enlarging the permutation array.
>   	 */
>   	order = i915_random_order(count * count, &prng);
> -	if (!order)
> -		return -ENOMEM;
> +	if (!order) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>   
>   	max_page_size = rounddown_pow_of_two(obj->mm.page_sizes.sg);
>   	max = div_u64(max - size, max_page_size);

