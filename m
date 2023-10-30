Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FBE7DB58F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjJ3I7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3I7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:59:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E594
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698656369; x=1730192369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R89fHrH0vTzIahQagBTYg9QO944K4Vt7HCsfbwzD2Tg=;
  b=Wubh3Y/tmjB5VWQh4CFiz+bpm0rL5xyjE6/sRkD+ApvkzP6n1jgXA64K
   BqrN36xm3CHKzWhmwvCvzDe8YB40iRJMX+w8GlQNyV3fZIBK1O+S1i3Ty
   BRskIgVhtzCmJ2xt+KjHcB9VMPTE98QuiqR/NQN68oaShEqGy7DIDkCke
   s6/aDruTxOlkeB1gui2yEi5zcibW9j6QZBmvcqOuUW/Xosoqi4MzGPini
   0SdsDknd85u0TE6a5Mho35xbab564IxRbeJ+s0PLijMxBANqxhmxhqg0E
   Uas/wfYroHV/5ZhdjcnjtBvVpiiibkub64il0PVHBvMCsbdSGAeUvLxt5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="474271553"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="474271553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="903925373"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="903925373"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:59:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxO7I-00000009mf1-1ZTG;
        Mon, 30 Oct 2023 10:59:24 +0200
Date:   Mon, 30 Oct 2023 10:59:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: uninline simple_strntoull(), reorder arguments
Message-ID: <ZT9wbLC9Nl+mKes3@smile.fi.intel.com>
References: <82a2af6e-9b6c-4a09-89d7-ca90cc1cdad1@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a2af6e-9b6c-4a09-89d7-ca90cc1cdad1@p183>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:13:58PM +0300, Alexey Dobriyan wrote:
> * uninline simple_strntoull(),
>   gcc overinlines and this function is not performance critical
> 
> * reorder arguments, so that appending INT_MAX as 4th argument
>   generates very efficient tail call
> 
> Space savings:
> 
> 	add/remove: 1/0 grow/shrink: 0/3 up/down: 27/-179 (-152)
> 	Function                            old     new   delta
> 	simple_strntoll                       -      27     +27
> 	simple_strtoull                      15      10      -5
> 	simple_strtoll                       41       7     -34
> 	vsscanf                            1930    1790    -140


Makes sense to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  		if (is_sign)
> -			val.s = simple_strntoll(str,
> -						field_width >= 0 ? field_width : INT_MAX,
> -						&next, base);
> +			val.s = simple_strntoll(str, &next, base,
> +						field_width >= 0 ? field_width : INT_MAX);
>  		else
> -			val.u = simple_strntoull(str,
> -						 field_width >= 0 ? field_width : INT_MAX,
> -						 &next, base);
> +			val.u = simple_strntoull(str, &next, base,
> +						 field_width >= 0 ? field_width : INT_MAX);

Looking at these, why do we even care about signedness? field_witdh IIRC is 16-bit or less
and if size_t is to big it's still fine. No?

-- 
With Best Regards,
Andy Shevchenko


