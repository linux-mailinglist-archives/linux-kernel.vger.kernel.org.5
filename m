Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDF77F3A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349738AbjHQJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349595AbjHQJic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:38:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058D271F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265111; x=1723801111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0LSz0B8oVBK1TlxOqkPE8wj9FNIdkeyvIdsvtQgTFc=;
  b=CR1P/L+wTPdCFxVjiMeP1CYjxtcNM6SSy84dCXlmJuGomOMdYOXqhcfo
   WSAo064MOFhMsXbCgISw4fYBgPqPuKnt3/eiH8O3PdM88EPGiRnng4eWZ
   s4Vkuk5Z3y3rgFqSItBlAUL//J3sCon8ylAa402N1ltphVxwhmiW1+GpM
   qg5iVv5jhUCtdiqLqr46ABmOhS/OWyeXlK/9SFf9kpj6qG6CzuPwaL57B
   XQ8AcfJnuNyxqQT9bTWj4ITrLKMiofyZ8gLVWtf8EPKZRAurHR2CeyET5
   YIrIuikdE2OCLVi6m5vMwPFOZ/RaKH40lnqcw/CVyiFi5F4SvPCWJwZGy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403743825"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403743825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848825940"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848825940"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 02:38:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZSW-005WFh-36;
        Thu, 17 Aug 2023 12:38:28 +0300
Date:   Thu, 17 Aug 2023 12:38:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
Message-ID: <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
References: <20230815235934.47782-1-yury.norov@gmail.com>
 <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:37:05PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 15, 2023 at 04:59:34PM -0700, Yury Norov wrote:

...

> >  		int n = bitmap_pos_to_ord(old, oldbit, nbits);
> >  
> > +		bit = (n < 0) ? oldbit :	/* identity map */
> 
> Can't you also optimize this case?
> 
> Something like
> 
>   bitmap_xor(tmp, old, new) // maybe even better approach, dunno

>   bitmap_empty(tmp) // can be replaced by find first bit

Or reuse bitmap_weight()...

> ?

-- 
With Best Regards,
Andy Shevchenko


