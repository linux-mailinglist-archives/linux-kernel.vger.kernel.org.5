Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6976927D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGaJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjGaJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:56:40 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F95E44
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690797375; x=1722333375;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1oL+ZoSZBkg9yYNkBmf41Emceg10dKGbAKKXHudy5G0=;
  b=HA7RNsa4+cpAwdBwl5KSk2NcfuzUiMZO1Glt9tRWqSInz1vfVddwyyTo
   Fc/pZ5761mtapXXHmljG9SsBvNWbN8F0q1u9wAy7u8hBWtA3fwc1nW223
   6hctjVAD94oqgNudjbaeoxQz8yb5ZGvkjKrTz59y9WUKgywkndjX8BuZn
   u1qeKe2+KTd10eLgdbJkvPU3Vb7ZWfvTi2YUqV9gHAFOVWsmqTgWEQ63e
   ZkkPvUKs2OX+HQ1LhFdyrLWxc57XntCuUJbM3KNY5GZ+TQFXLu4EhtAOL
   spYLX/Z+Rq8F0WE3WCi8gMl6fL1ahfe3+weAgHBuz2TFE0dlY69Bpsusz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="366456225"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="366456225"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="974815497"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="974815497"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO localhost) ([10.252.36.230])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:56:08 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     sunran001@208suo.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: fix application of sizeof to pointer
In-Reply-To: <442918910b90b9a8e2e5f8a3874fdb44@208suo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230720073355.3196-1-xujianghui@cdjrlc.com>
 <442918910b90b9a8e2e5f8a3874fdb44@208suo.com>
Date:   Mon, 31 Jul 2023 12:56:05 +0300
Message-ID: <87leewxv4a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023, sunran001@208suo.com wrote:
> The coccinelle check report:
> ./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application
> of sizeof to pointer

Please don't just assume coccinelle is right, and send "fixes" based on
the cocci reports alone. You need to read and understand the code you're
changing.


BR,
Jani.

>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/i915/i915_syncmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_syncmap.c 
> b/drivers/gpu/drm/i915/i915_syncmap.c
> index 60404dbb2e9f..4eeaf12be72d 100644
> --- a/drivers/gpu/drm/i915/i915_syncmap.c
> +++ b/drivers/gpu/drm/i915/i915_syncmap.c
> @@ -282,7 +282,7 @@ static noinline int __sync_set(struct i915_syncmap 
> **root, u64 id, u32 seqno)
>   			unsigned int above;
>
>   			/* Insert a join above the current layer */
> -			next = kzalloc(sizeof(*next) + KSYNCMAP * sizeof(next),
> +			next = kzalloc(sizeof(*next) + KSYNCMAP * sizeof(*next),
>   				       GFP_KERNEL);
>   			if (unlikely(!next))
>   				return -ENOMEM;

-- 
Jani Nikula, Intel Open Source Graphics Center
