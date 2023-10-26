Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A27D83A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjJZNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:34:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA10187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698327272; x=1729863272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wm/QjKsX2coLFHQLx9Lmre73K6QbB6YsB2skPvgcWKI=;
  b=QWwE57Ova8d62CeOhhvlISuUr9jFl74Aae1bPnUTsPTG3gsqs4Uj3IXe
   LGZ6IqN0IXvZ84pmkG+rqmYZqeYAiBOdpvaxcg66WUzTxHPTR5/oVtWPX
   KObd3hDkBGfG9Irxslg1Z85gXHEe9mgM9aZNdghlBnHW7K2b7bT7ptRch
   OzmZ5tzAgrobwGvfUq0FivrOrJW3ARGtFdb6e9UZnujko0Z2cj6MD8I0E
   +C9KqzQgkijKRKF6BJMEtv4tARm41Nn9dZOCnP0S6gpH2cdXBtx4t59cR
   6XzcX5/IR99f9wC8iINIImQjdyi8Dr5XU8xj+xFkOli20ScQ7eyUGFJ3t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="377916336"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="377916336"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 06:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="882832954"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="882832954"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 06:34:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qw0VE-00000008ruy-3jh7;
        Thu, 26 Oct 2023 16:34:24 +0300
Date:   Thu, 26 Oct 2023 16:34:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/2] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZTpq4OiUr+jzeH1q@smile.fi.intel.com>
References: <20231025083812.456916-1-glider@google.com>
 <ZTpYbCa0Qmry0HGH@smile.fi.intel.com>
 <CAG_fn=Uv+ox4a1x=-w8DTU_Pj9VPh9TYhBRcDsPh+=Kc2Jsg5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Uv+ox4a1x=-w8DTU_Pj9VPh9TYhBRcDsPh+=Kc2Jsg5w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:28:25PM +0200, Alexander Potapenko wrote:

...

> > I still didn't get the grouping you implied with this...
> 
> Given your second reply, I can disregard this one, right?

Yes.

...

> > > +     if (unlikely(!nbits || nbits > BITS_PER_LONG))
> > > +             return 0;
> >
> > ...this return in the Return section.
> >
> 
> Parameter description for @nbits actually mentions BITS_PER_LONG
> already, so would it be ok to drop the Note: and extend the Returns:
> section as follows:
> 
> + * Returns: value of nbits located at the @start bit offset within the @map
> + * memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return value
> + * is undefined.
> 
> ?

Fine to me.

> (Yury didn't want the zero return value to be part of the contract here).


-- 
With Best Regards,
Andy Shevchenko


