Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75037D898C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjJZUOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJZUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:14:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842E129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698351274; x=1729887274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BbSlSDPQtBqXoyAjsGOiZ+4E4cSGC6fmCboPLYplzk4=;
  b=EnoFok3eR4zzc3RVSATgyh+VXQXG6O/6CkkJJd6gV+OlVoILlRVJlCoo
   +S9Q5jkZTHs4c3OiH3Z2CFLw2uSzxUl5/gibVT1R/ncJerbURWtyXcCrq
   SNwWdPHPCqoDlqqxfVObeLdIVmHm+DyEDKT0RcNCeBjwBcNVaVk5lFypl
   CEMTgl3HJWBQMrSapleqBpoi2myHyn8u4STZ1esgrOvxpPsE3VEO/UjdR
   qg5LyyUW7Psd7tmEvFaxYAvnTfNCcNfehwSNR/82qCYRfLOPKwrTflequ
   HN0kRwJBeM/fF9war2Zzt2mvKb10Yz0sqPreIFGvTmSmYP5kk0aELyKcI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9183726"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="9183726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709195251"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="709195251"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:14:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qw6kL-00000008x65-1rXc;
        Thu, 26 Oct 2023 23:14:25 +0300
Date:   Thu, 26 Oct 2023 23:14:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 1/2] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZTrIoaFE+c5XQXFs@smile.fi.intel.com>
References: <20231026135912.1214302-1-glider@google.com>
 <ZTp2oLST3nR9AZk4@smile.fi.intel.com>
 <CAG_fn=VSYNk=k1kqKo1vQ7Bd87x9evy6GQBfjdNatOp51x8DZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VSYNk=k1kqKo1vQ7Bd87x9evy6GQBfjdNatOp51x8DZQ@mail.gmail.com>
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

On Thu, Oct 26, 2023 at 04:48:46PM +0200, Alexander Potapenko wrote:

...

> > > +static inline void bitmap_write(unsigned long *map,
> > > +                             unsigned long value,
> > > +                             unsigned long start, unsigned long nbits)
> >
> > While noticing strange indentation (you have space for the parameter on
> > the previous line,
> 
> I believe I do not, maybe that's something on your side?
> There are tabs in the source, and in the original email.

I meant that you can use 2 lines instead of 3:

static inline void bitmap_write(unsigned long *map, unsigned long value,
				unsigned long start, unsigned long nbits)

> > I realized that this is a counter-intuitive interface.
> > Can you actually make value the last parameter?
> 
> It is consistent with bitmap_set_value8(map, value, start), and in all
> the functions above @nbits is the last parameter.

Oh, then I leave this to Yury.

-- 
With Best Regards,
Andy Shevchenko


