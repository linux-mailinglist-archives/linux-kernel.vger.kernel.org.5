Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C003F75349C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGNIHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGNIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:06:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C630E2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689321866; x=1720857866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KTVhij6S6J9wOQxsZ93AjKzVSRhtji3qCHsu2XYKIW4=;
  b=DhdZMwbqv7IRuuGiRAGwu861ByE21NxaY/GuJXakML8PCuhFYP6ivrf4
   JpcE0fd+rBrgS6W4F/NYpQRb0INejH9XIeCkt8OIssQz+YYWiA5QxKzGA
   5SFjUbXRPHSQ/cyD8oSvRYf36T/AkN4UBF2PuvybYqx+D7Tv+hMBpdKaH
   XnSDDH2NxxUeCI2Jeox8g2PgiPIKy289T7BZ8H7jc0bsoCPoryBoF5IRL
   DplvsAdTGmAB6nOtBU5+bev2BmNT5TpPAP6dW807pUwLmuw5xW9Vnswb5
   A8QIxgXpcarnUZJWw7EptpnkDPdAi9dz3yqOezJX3/r5uuvwoO+igvLA1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355355613"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="355355613"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052976605"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="1052976605"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 01:04:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKDmi-002b9e-2r;
        Fri, 14 Jul 2023 11:04:16 +0300
Date:   Fri, 14 Jul 2023 11:04:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
Message-ID: <ZLEBgGSsmOPs4Zu5@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-2-glider@google.com>
 <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
 <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
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

On Thu, Jul 13, 2023 at 08:05:34PM +0200, Alexander Potapenko wrote:
> On Thu, Jul 13, 2023 at 7:29 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > +Cc: William
> >
> > On Thu, Jul 13, 2023 at 02:57:01PM +0200, Alexander Potapenko wrote:
> > > The two new functions allow setting/getting values of length up to
> > > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > A couple of years (?) ago it was a series to achieve something like this with
> > better (?) code. Why not resurrect that one?
> >
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2195426.html
> 
> It looks more compact thanks to GENMASK, I can cook something based on
> the proposed bitmap_{set,get}_value (and change the names if you
> prefer the shorter ones).
> But I'd better avoid pulling in the rest of that series without a strong need.

William, what do you think on this?

I'm personally prefer William's version as not only it was published first
it was carefully designed and got a lot of review already. We just hadn't had
the user for it that time.

-- 
With Best Regards,
Andy Shevchenko


