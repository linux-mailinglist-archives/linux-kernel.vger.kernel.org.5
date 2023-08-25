Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEA7887A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjHYMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244907AbjHYMir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:38:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCCED3;
        Fri, 25 Aug 2023 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692967125; x=1724503125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzsv+TPApbcbC97ZdaQexaDo1qTJfnRyaSbczlKPtfM=;
  b=XlYKVKAhNkMbY3zMpjnmPY/SII/6Ej8k2XQtqBMeb8w68joFyo4tkpYw
   FH6TU99lWE3VNapnTscxP17frVGLLZnYqAcjQanDfQ1DWZZyohya8cZhQ
   hokI5AsspNhJLBj9bvmYE2+FDh0lBiopxNkpwueNHUE7OooHMuU65PzX2
   YftPxfkvkkm9EvLCnLproRar7Bm4A3cB6PJxHEFCAgbkvKc8VyRh7ujmm
   d8hFrfc+WWxnidErE8piF0LAeXQO08dtY3ppd7FrU8nxid6hQKxM7xXve
   6FP9+9p7vo3uV6Wqt/nbq8NrtnNXH5D9u7SnF4iW0vtZ8WuutYi/uuTM1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="377443812"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377443812"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="861076556"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="861076556"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 25 Aug 2023 05:38:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qZW5J-00HW7e-2A;
        Fri, 25 Aug 2023 15:38:41 +0300
Date:   Fri, 25 Aug 2023 15:38:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 2/2] crypto: qat - add pm_status debugfs file
Message-ID: <ZOig0RNTKs+P91V0@smile.fi.intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-3-lucas.segarra.fernandez@intel.com>
 <ZOiE6GMY5Qb2S53A@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOiE6GMY5Qb2S53A@gondor.apana.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:39:36PM +0800, Herbert Xu wrote:
> On Fri, Aug 18, 2023 at 12:23:09PM +0200, Lucas Segarra Fernandez wrote:

> >  #include <linux/bitfield.h>
> > +#include <linux/bits.h>
> 
> This is redundant if you include linux/kernel.

Why?!
Can we avoid using kernel.h, please?

> > +#include <linux/dma-mapping.h>
> > +#include <linux/fs.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/kstrtox.h>
> > +#include <linux/slab.h>
> > +#include <linux/stddef.h>
> 
> So is this.

Ditto.

-- 
With Best Regards,
Andy Shevchenko


