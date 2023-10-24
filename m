Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6C7D59DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjJXRmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbjJXRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:42:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618A310D1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:41:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306E8C433C8;
        Tue, 24 Oct 2023 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698169318;
        bh=TTksDceA+wO0GuVnCGF4HeG429ffyHr6vIFC99gELqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kole9idDyEzsBcVajRjH1HVLnr/wnud0s0YxQCybAGeygnTutgBzTIMy0OuiSvaiK
         FbTxTnHY+bNlvyoALqlF2Yu0jtADBLv3k7LLYpuEegPKbxpeN9J8Hbm4E5TvKPJ4Pc
         9bvwII1J2QQM2QX6brHuCxqwz0zskj/Dq6Oo7V0vOPOGkAIB/+5Mwugwg1uzoTlB2b
         /X/p0Re7GXFBzcNPZSIGCv/KTK9gKj43ua97Jv6TamormI91WSX3nYL4xYxGh94379
         XI+5lKMBAFwGU2qzI018uhOdQDyKXwwWgeTQYjeA0bHvbZSBdEbiTQ/tSmcOEOKEuR
         /IZtV4r7AIVJw==
Date:   Tue, 24 Oct 2023 19:41:53 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
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
Message-ID: <20231024174153.byeq7ctssvxuwa4z@zenone.zhora.eu>
References: <20231016201012.1022812-1-arnd@kernel.org>
 <87edhlbj16.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edhlbj16.fsf@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

> >  static void rc6_res_reg_init(struct intel_rc6 *rc6)
> >  {
> > -	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
> 
> That's just bollocks. memset() is byte granularity, while
> INVALID_MMIO_REG.reg is u32. If the value was anything other than 0,
> this would break.

Actually it's:

   void *memset(void *s, int c, size_t count)

> And you're not supposed to look at the guts of i915_reg_t to begin with,
> that's why it's a typedef. Basically any code that accesses the members
> of i915_reg_t outside of its implementation are doing it wrong.
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

in any case, I agree with your argument, but why can't we simply
do:

   memset(rc6->res_reg, 0, sizeof(rc6->res_reg));

?

The patch looks to me like it's being more complex that it
should.

Andi
