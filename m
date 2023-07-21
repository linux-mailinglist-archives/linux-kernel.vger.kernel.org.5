Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4175D089
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjGURWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGURWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:22:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF85113;
        Fri, 21 Jul 2023 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689960159; x=1721496159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=us9CRrn80BeO09+83BBkmkXoBKksmGaBRjQFHkDWvhw=;
  b=QnROFwH2hmPaY6l0lpYWBLBg5PxPqBbfXVK/U8JMQZSOfJC4Q8tGMnOT
   GCrBtIUniNOnPpKgcl5uLXeoi/t9E1fffjrEToWJKNZRSVkH4BLk6TmS2
   468snSWk0tp5lAfO3Hy7QZD+yDRqpCjQpD9NE9t/X5qXCh4gSnzPkISkm
   +RgBk2f3xIklDDQNIypySj2bgGjjuQNdTTGu2aJPCrnDJma04WQmDaiFx
   /LB7CGWmVJIaiVbXRX3af/ptfq2I80LibzbN3k8ao6KYzL9IzC3FKd4Ki
   CHCmo5cnvwaCI9ecSisAmA5ITkWqpZKBYzusNRcOqw6HgdeIJXyMgTM9+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="397968049"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="397968049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="898774970"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="898774970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 10:22:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMtpr-00ELGI-1d;
        Fri, 21 Jul 2023 20:22:35 +0300
Date:   Fri, 21 Jul 2023 20:22:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/8] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <ZLq+2+9q6To3uAkf@smile.fi.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721170022.3461-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:00:15PM +0300, Andy Shevchenko wrote:
> Introduce opaque_struct_size() helper, which may be moved
> to overflow.h in the future, and use it in the IIO core.

...

> +#define opaque_struct_size(p, a, s)	({		\
> +	size_t _psize = sizeof(*(p));			\
> +	size_t _asize = ALIGN(_psize, (a));		\
> +	size_t _ssize = s;				\
> +	_ssize ? size_add(_asize, _ssize) : _psize;	\
> +})
> +
> +#define opaque_struct_data(p, a)			\
> +	((void *)(p) + ALIGN(sizeof(*(p)), (a)))

Hmm... This can potentially evaluate p twice.

Perhaps this variant is better:

#define opaque_struct_data(p, a)	ALIGN((p) + 1, (a)))

Besides, I don't think we should worry about @s evaluation in the main macro
which may be simplified to

#define opaque_struct_size(p, a, s)					\
	((s) ? size_add(ALIGN(sizeof(*(p)), (a)), (s)) : sizeof(*(p)))

Thoughts?

-- 
With Best Regards,
Andy Shevchenko


