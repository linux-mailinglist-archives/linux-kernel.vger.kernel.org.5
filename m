Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E97CB644
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjJPWLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjJPWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:11:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB92A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697494266; x=1729030266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uOSGYUIh2bCQLm9WrX2gbSaTh3qGkOYaDbBrkhXMx+E=;
  b=EsT1VTe+9GsZWYRbiU6wcAamRcTJW+jmyZBTPfpfpDs9VTSSxYW7mq+k
   /eoYpyZii0cq3+Ml/f+PSd7bzFoVfk8RkwWXIAqwqAyVZSo+ZJazkW0Ca
   eo2Gzv/UMwyDZ0YeHloTEoHYgyshWSA0PG5gz4NoE8ZBtTEwVwqrKLIa5
   H6/gn7PhOsxyiNxwNwHcGPCbkxVGM4MCleZl2AkMHDkLtLGUzRkIPXs76
   Xuc7Xgl/v304+X30yxigJ4/9324h2pir9Jkd0RYCIIxpxkSg2UC3bosPf
   NhomoR77+XH8X7L78DYz8jw5LCh8PvrG/dDO9ZbmrZo0Imofq2zXYsUWG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370723377"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="370723377"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 15:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087243992"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="1087243992"
Received: from yckhoo-mobl2.gar.corp.intel.com (HELO intel.com) ([10.215.157.119])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 15:10:54 -0700
Date:   Tue, 17 Oct 2023 00:10:49 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Badal Nilawar <badal.nilawar@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/mtl: avoid stringop-overflow warning
Message-ID: <ZS206TuYnhE3PozK@ashyti-mobl2.lan>
References: <20231016201012.1022812-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201012.1022812-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

>  static void rc6_res_reg_init(struct intel_rc6 *rc6)
>  {
> -	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));

This is a complex initialization, indeed... how about just

   memset(rc6->res_reg, 0, sizeof(rc6->res_reg));

> +	i915_reg_t res_reg[INTEL_RC6_RES_MAX] = {
> +		[0 ... INTEL_RC6_RES_MAX - 1] = INVALID_MMIO_REG,
> +	};

This is basically a

   i915_reg_t res_reg[INTEL_RC6_RES_MAX] = { };

Don't know which one is clearer.

Andi
