Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E27CF880
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjJSMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjJSMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:15:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00000A3;
        Thu, 19 Oct 2023 05:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717714; x=1729253714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eGhAZh4irwgENXW8a5Q3QagMwDLq7jqsgmD6X7zH0Ao=;
  b=CFVhorTzakXjrrlejHVrx2XwuNASiZn15w6F8yg5NAnh6DqhU0ckEgro
   qcSpF11DjvIFB/H7YQ5a7maDJZMYiuloYMbaQ/e9klua+KVyaX7+VFd68
   GzELkIr5xU3WQOqzPGvM5b2O0QsGDu/FrerrSy9vIRAABULxGGezgI42h
   wl94PunpWKkBroC21RwjVr4fhb76fis8qXUDnWxUW743PZAXhmGBTRImt
   VJELWUWUCObfeRTxkq0W+6MhsD3DL3iwbhUZWEDLruwfNYGIPcGbMpbNo
   oxPrq0gZ8S86VzP20MK0EqOhvRuFzLkLQ8RAkSU5y44dGAx8xX/QL5wI0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366474509"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="366474509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900717850"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="900717850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:13:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtRvh-00000006rD8-1gtM;
        Thu, 19 Oct 2023 15:15:09 +0300
Date:   Thu, 19 Oct 2023 15:15:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZTEdzVViUPdk3pk/@smile.fi.intel.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com>
 <ZS7_5VGvRnw99gzd@google.com>
 <ZS9mo4/jnRNoTE+v@smile.fi.intel.com>
 <ZTBfFIyCsl2gkp6f@google.com>
 <CACRpkdZ0cnJpYuzU=47-oW-7N_YGMo2vXpKOeXeNi5PhPY7QMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ0cnJpYuzU=47-oW-7N_YGMo2vXpKOeXeNi5PhPY7QMA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:12:57AM +0200, Linus Walleij wrote:
> On Thu, Oct 19, 2023 at 12:41 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:

...

> > Given that there are more issues in that code, maybe we should revert
> > the patch for now so Andy has a chance to convert to UUID/LABEL booting?
> 
> Yeah I reverted it, the above elaboration may apply to this patch
> too and makes me feel we are "mostly safe" in this regard anyway.

Thank you!

And on my side I'll try my best to avoid static enumerations.

-- 
With Best Regards,
Andy Shevchenko


