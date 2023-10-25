Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37A27D6A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjJYLxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjJYLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:53:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4812A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698234829; x=1729770829;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WGLwc5iTwr+p0DGCwq0HmPdYYtDkR3qB+ype1OEIfNA=;
  b=h4b9o338cxZdqEWP6IuEeryAbMhWehqhjR9mNTZIJFvOZMp1r5GHzQR/
   dtueqXz+4+qUeuUacyIOfT4W5ncfA13PxiC/tXth5J42gJbEHd/AH3EnC
   rU7yvH1fH3FZPPF/3k2oYFEfcmEyHA9L8cYz8MbE+2KolWvevWvaevJ/Z
   FcH2cYuniJ9x7ollfxxswVu0woPsetkhDQhZ+zFDmH21xeJ1yZ3tg9syU
   O3L4/2L6a2inN2zDkjTcgwiPxvtc6Xa2/eBn9ZScyHEiJKMA9FPfaZx9T
   UtYJg0bGzebpDxFmvPliybFVfGkbcUhnrJlBbExPbuV8H0o5UdNLRQMKE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377656073"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377656073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="788100608"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="788100608"
Received: from dtorrice-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.33.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:53:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Badal Nilawar <badal.nilawar@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Roper <matthew.d.roper@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH] drm/i915/mtl: avoid stringop-overflow warning
In-Reply-To: <20231024174153.byeq7ctssvxuwa4z@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231016201012.1022812-1-arnd@kernel.org>
 <87edhlbj16.fsf@intel.com>
 <20231024174153.byeq7ctssvxuwa4z@zenone.zhora.eu>
Date:   Wed, 25 Oct 2023 14:53:38 +0300
Message-ID: <87o7gm9av1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Andi Shyti <andi.shyti@kernel.org> wrote:
> Hi Jani,
>
>> >  static void rc6_res_reg_init(struct intel_rc6 *rc6)
>> >  {
>> > -	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
>> 
>> That's just bollocks. memset() is byte granularity, while
>> INVALID_MMIO_REG.reg is u32. If the value was anything other than 0,
>> this would break.
>
> Actually it's:
>
>    void *memset(void *s, int c, size_t count)

And? It still sets each byte in s to (the lowest 8 bits of) c.

>
>> And you're not supposed to look at the guts of i915_reg_t to begin with,
>> that's why it's a typedef. Basically any code that accesses the members
>> of i915_reg_t outside of its implementation are doing it wrong.
>> 
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> in any case, I agree with your argument, but why can't we simply
> do:
>
>    memset(rc6->res_reg, 0, sizeof(rc6->res_reg));
>
> ?

We can simply do a lot of things in C, but IMO that's semantically
wrong. i915_reg_t is supposed to be an opaque type. We're not supposed
to know what it contains, and what values are valid or invalid for it.
That's one of the reasons we have i915_reg_t in the first place (type
safety being the primary one).

Basically you should be able to do

-#define INVALID_MMIO_REG _MMIO(0)
+#define INVALID_MMIO_REG _MMIO(0xdeadbeef)

and expect everything to still work.

BR,
Jani.

>
> The patch looks to me like it's being more complex that it
> should.
>
> Andi

-- 
Jani Nikula, Intel
