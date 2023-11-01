Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8EB7DDE82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjKAJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:35:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5299DA;
        Wed,  1 Nov 2023 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698831303; x=1730367303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j6Z+/BFFUr6BsaZp6yLVq3KbJXpgzXJVepF6hPcGotI=;
  b=fqHYLaeVqSul0BxdzHTjfPrvnzTfZEUIKpZCr2sZv/jlIM46jSf2NI3Q
   Jf3a3PjqfxJdEk+6UtZKYkK8Q8dP/i+4xa4tOscYJrhZL/QcBWB2XzzjM
   YhQwPgXyvt6HkIbUluCflQ9xu9nyNwbowoh4ZwG/qCNBK3OG7I3dvWDQT
   1FOf11iffPv5QzNE4ZSON7BO/a5XxFK9hZ5vkQ9RvpfwuocK6GobfU2xj
   qMHwzVT6+as2pT69PZw2pbTlUei57P5dcktMK/SSdQqrk3iRmKR+6JJyc
   D8lvyBiYnrhp+CpQTIC8HOUQ1eQpQ3oCQXVTPiPo/AvmqJj7YWWTyyqZa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="392326053"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="392326053"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1092295088"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1092295088"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:35:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qy7cp-0000000APPm-0y8d;
        Wed, 01 Nov 2023 11:34:59 +0200
Date:   Wed, 1 Nov 2023 11:34:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <ZUIbwtXmmTCHO9lf@smile.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
 <20231101063520.GC17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101063520.GC17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 08:35:20AM +0200, Mika Westerberg wrote:
> On Mon, Oct 30, 2023 at 05:53:40PM +0200, Andy Shevchenko wrote:

...

> > +		case 1: /* Set default strength value in case none is given */
> 
> The comment is good but I think would it make sense to have constant for
> this instead?

If so, it makes sense to get it via entire GPIO library, and not locally for
Intel stuff. That said, I prefer to do that separately. Do you agree?

-- 
With Best Regards,
Andy Shevchenko


