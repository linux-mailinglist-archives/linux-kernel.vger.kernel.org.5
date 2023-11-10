Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3995F7E7EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjKJRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjKJRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AEC5260;
        Thu,  9 Nov 2023 22:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699596866; x=1731132866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ii54i8l9M6cKrlgX+mjJdtwVkIC1gfwZhndVsG7a0/A=;
  b=HMkNK9yiNe5UXNwY4QS79BhdAUg2cYuvZIHGUDCx+J4Eu/+wrtaDdFkD
   mxgJOJXVH0HqDio70qFlm69C7CmsvT5HMSvaWOUJa3iQL5DQy6seSKlnc
   YQsHXhd2lLx6noykKtzLlMMI0/B/v9/Ppui0cE500hxQYRaUqqNu/+n+t
   MX+R2UVmjXegAfxARz82E6+gR/3R5WsoHMVwvTef6+83AgJgPuVBjIeS8
   e9HvhYLoyK5YnyxPxYJzZlOIcmacd5oVrtkW7q5MJ5s2Xojiqc43XRKDJ
   gv61ijEpB2HOe1CxNxMQ5I1M1T1MkhcBGrc0w4ImChe6J8TeNJPlssQXk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="394044710"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="394044710"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:14:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1095109933"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1095109933"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 Nov 2023 22:14:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 239D614F; Fri, 10 Nov 2023 08:14:22 +0200 (EET)
Date:   Fri, 10 Nov 2023 08:14:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/17] pinctrl: intel: Use NOIRQ PM helper
Message-ID: <20231110061422.GI17433@black.fi.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Oct 30, 2023 at 02:07:17PM +0200, Andy Shevchenko wrote:
> Intel pin control drivers use NOIRQ variant of the PM callbacks.
> To make them smaller and less error prone against different
> kernel configurations (with possible defined but not used variables)
> switch to use NOIRQ PM helper.
> 
> Changelog v3:
> - dropped applied patches
> - dropped MediaTek patch for now
> - split Intel patch to the series using suggection by Paul
> 
> Changelog v2:
> - rewritten commit message in patch 1 (Rafael)
> - converted non-Intel pin control drivers as well
> - added couple of kinda related patches to use pm_ptr()
> 
> Andy Shevchenko (17):
>   pinctrl: intel: Provide Intel pin control wide PM ops structure
>   pinctrl: alderlake: Switch to use Intel pin control PM ops
>   pinctrl: broxton: Switch to use Intel pin control PM ops
>   pinctrl: cannonlake: Switch to use Intel pin control PM ops
>   pinctrl: cedarfork: Switch to use Intel pin control PM ops
>   pinctrl: denverton: Switch to use Intel pin control PM ops
>   pinctrl: elkhartlake: Switch to use Intel pin control PM ops
>   pinctrl: emmitsburg: Switch to use Intel pin control PM ops
>   pinctrl: geminilake: Switch to use Intel pin control PM ops
>   pinctrl: icelake: Switch to use Intel pin control PM ops
>   pinctrl: jasperlake: Switch to use Intel pin control PM ops
>   pinctrl: lakefield: Switch to use Intel pin control PM ops
>   pinctrl: lewisburg: Switch to use Intel pin control PM ops
>   pinctrl: meteorlake: Switch to use Intel pin control PM ops
>   pinctrl: sunrisepoint: Switch to use Intel pin control PM ops
>   pinctrl: tigerlake: Switch to use Intel pin control PM ops
>   pinctrl: intel: Make PM ops functions static
> 
>  drivers/pinctrl/intel/pinctrl-alderlake.c    |  5 ++---
>  drivers/pinctrl/intel/pinctrl-broxton.c      |  5 ++---
>  drivers/pinctrl/intel/pinctrl-cannonlake.c   |  5 ++---
>  drivers/pinctrl/intel/pinctrl-cedarfork.c    |  5 ++---
>  drivers/pinctrl/intel/pinctrl-denverton.c    |  5 ++---
>  drivers/pinctrl/intel/pinctrl-elkhartlake.c  |  5 ++---
>  drivers/pinctrl/intel/pinctrl-emmitsburg.c   |  5 ++---
>  drivers/pinctrl/intel/pinctrl-geminilake.c   |  5 ++---
>  drivers/pinctrl/intel/pinctrl-icelake.c      |  5 ++---
>  drivers/pinctrl/intel/pinctrl-intel.c        | 14 +++++++-------
>  drivers/pinctrl/intel/pinctrl-intel.h        | 11 +----------
>  drivers/pinctrl/intel/pinctrl-jasperlake.c   |  5 ++---
>  drivers/pinctrl/intel/pinctrl-lakefield.c    |  5 ++---
>  drivers/pinctrl/intel/pinctrl-lewisburg.c    |  5 ++---
>  drivers/pinctrl/intel/pinctrl-meteorlake.c   |  5 ++---
>  drivers/pinctrl/intel/pinctrl-sunrisepoint.c |  5 ++---
>  drivers/pinctrl/intel/pinctrl-tigerlake.c    |  5 ++---
>  17 files changed, 38 insertions(+), 62 deletions(-)

Nice! For the series,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
