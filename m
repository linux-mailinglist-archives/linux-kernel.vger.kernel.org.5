Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E439778B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjHKKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHKKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:09:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84F3C0E;
        Fri, 11 Aug 2023 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691748541; x=1723284541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3TyPERQgCXiavt1l/KErY+uJ/EFwbbRdQVVtcfN+4cE=;
  b=miRbBGkiDp0R/KM8oNCLGGslh9S9G2cDcbhpIigsQSqJ3TFF7jujGuxt
   qQ7/EoVs+IzPBx9+rD6b2T251UyHTg2rpbpsqF+XwdMMgI5cXcu1raRZu
   KSQ+8VywmrMobVQ7CdJTQN3VEWoTP217hc7TaaR9Zowhpfz4IJGxQrtQV
   fh3KboAdkfnVAfXE8SgXrlhcIuoXQwgXrMBNXZw1t6t8wBMzmzxEIpWiv
   /c2OATbuF8o56e1Lc2uzj7wYn4o53D3GQG7vfgIVXIuekb9IWOZoWLxPR
   gAzXBofwS35Potprnh6dkEI12N7xaRqsa2eVKNbS/VUmNi2LhqxLsWxJD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435539486"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="435539486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1063272569"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="1063272569"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 03:08:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUP4j-009vcS-0B;
        Fri, 11 Aug 2023 13:08:57 +0300
Date:   Fri, 11 Aug 2023 13:08:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZNYIuBjIHItnsyJL@smile.fi.intel.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
 <8fb74f21bda4949a862bcb4bb1ed4f0acb135948.1691607526.git.mehdi.djait.k@gmail.com>
 <ZNYDa+Un5bl5y9vT@smile.fi.intel.com>
 <CAFukWp2w2KwE+Obt1DWTcT81DbN7FdMNVo2Q7MSvjNi=_0uBRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFukWp2w2KwE+Obt1DWTcT81DbN7FdMNVo2Q7MSvjNi=_0uBRA@mail.gmail.com>
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

On Fri, Aug 11, 2023 at 12:01:23PM +0200, Mehdi Djait wrote:
> On Fri, Aug 11, 2023 at 11:46 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Aug 09, 2023 at 09:11:36PM +0200, Mehdi Djait wrote:

...

> > > +     val = min_t(unsigned int, data->chip_info->fifo_length, val);
> >
> > min_t() is a beast. Please, use min() if no special requirement for
> > min_t() here, otherwise explain why.
> 
> No actual reason, you suggested min_t or min for a previous version

After the minmax series (see discussion in LKML) I am pretty sure min_t()
shouldn't be used at all or with very minimum cases where people know what
they are doing.

...

> > > +     data->fifo_buffer = kmalloc(data->chip_info->fifo_length *
> > > +                                 KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> >
> > kmalloc_array()
> 
> Should I send another version for this ?

Sure.

> The usage of kmalloc is quite straightforward and easy to understand here.

Yes, and prone to errors. Multiplication theoretically may overflow and
your code doesn't aware of that, kmalloc_array() does it.

-- 
With Best Regards,
Andy Shevchenko


