Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7A755FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGQKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGQKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:01:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA7FE47;
        Mon, 17 Jul 2023 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689588076; x=1721124076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMM3xupH1hI/uzcIq/Bseq5hzkwtbNzgO0JZ+lTjb3Y=;
  b=nqK3vjFvF2mVa4e+xjlfGCSgek3bi+ryc70yKdgMec+KXf5+JQ0Ey46b
   u0O78HVdb3LogH4LlVsON8GWdQFipNq5gaYvMHuuFca0LFreuzBjbXRcc
   gcq6SWM+fiPJPfW6jMaTGs8ulShK6BZb1kFgio7eVOmYs6xF7puvbWo1N
   dKk+VuIlO6xn2GMa3jW9Z34ZPMxP5/kxkrLTMCRElsg81WfmEEqCY7TOX
   /fOwRGXb/iWy3o0P/Sgvj/ou/matjiqwdtTAr9bBxOWCS4h2H9h2+9PcS
   enhugN8hjl2aoEQlMa8PWt/Ek60HOvH44ICMrYUKFMY86C5tyXb3akqKu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="364767201"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="364767201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="673491098"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673491098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 03:01:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLL2T-008WsP-2y;
        Mon, 17 Jul 2023 13:01:09 +0300
Date:   Mon, 17 Jul 2023 13:01:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1 0/3] iio: adc: meson: tune init sequence
Message-ID: <ZLURZWPkmP6aKDOZ@smile.fi.intel.com>
References: <20230715110654.6035-1-gnstark@sberdevices.ru>
 <20230716171134.43d05c45@jic23-huawei>
 <a172c764-1eef-835f-f237-8f78b4c6e877@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a172c764-1eef-835f-f237-8f78b4c6e877@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:41:29PM +0300, George Stark wrote:
> On 7/16/23 19:11, Jonathan Cameron wrote:
> > On Sat, 15 Jul 2023 14:05:57 +0300
> > George Stark <gnstark@sberdevices.ru> wrote:

...

> > These look fine to me, but I'd like them to sit on list a little while
> > on off chance anyone else has feedback on them.
> 
> I understand. I'd resend the patches in a week or more if there's no
> feedback.

There is no need to resend as long as they are available via lore.kernel.org
mail archives.

-- 
With Best Regards,
Andy Shevchenko


