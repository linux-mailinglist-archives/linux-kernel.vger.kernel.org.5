Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1378D7789A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjHKJZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHKJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:25:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4160D110
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745905; x=1723281905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7+g1Aj2s3oekL8UZ266x+/kF0AjGwNP5Y2Fk4NBKlg=;
  b=e4Z90DCB7Nb9NR9aF4oZxp97DPH1nrvHGRFFmKR5ZBOCxFHDN8NMySR0
   5hSIPRv72TNzHzxyZf5CUIOjsnKwsHT+Nv6acftCdSHuFydAoCh0NolQj
   OUFcw8XZuVUN1bg4TwiMMMPCQUsb7r23yhz/6ca7X9+X9LQKBfX+Ql+1z
   jzjCwQjtzTF5rIfB71oTcjbM+oezK5Q6Ss9j7DEWVUH3hkZ3idz0wqpZG
   DivW/ksB6eUinlLarwISb/q3C1TTWBSzJHz51dktODPkWVHjvzFzUZ5L3
   Kh14RmhAV+kexBsKrQ+pjtuk7e1I/2IIX3beTgtadrzHWOO6ip5JljKau
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437976353"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="437976353"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682481215"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="682481215"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 02:25:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOOE-008Qg4-1k;
        Fri, 11 Aug 2023 12:25:02 +0300
Date:   Fri, 11 Aug 2023 12:25:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Message-ID: <ZNX+bponlicM3AFL@smile.fi.intel.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811005732.107718-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:57:28PM -0700, Yury Norov wrote:
> _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.

...

>  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
>  {
> +	unsigned int nbits = pos + BIT(order);

Shouldn't this be unsigned long?
As the prototype of the used later unsigned long find_next_bit().

>  	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
>  		return -EBUSY;
> -	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
> +	bitmap_set(bitmap, pos, nbits);
> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


