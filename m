Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C757CC325
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjJQM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjJQM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:26:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD721BFE;
        Tue, 17 Oct 2023 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545587; x=1729081587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9BWhGFNWOFsk6cL6MXx33Ovkq7dje3MMnsDKMqNqd0=;
  b=Sj2uUgoEFhEusZ3UXDi3IE1lYwLZ0AW8M8Zl3V3NgNc/TwXd4iknoe/Z
   d0vALNh8hkXM1hiJXyyXV8ybLg8sO5Vk8R+KzeXxBmOoXD9fD2IQHaKpL
   tH195ezuTTzzqoJE5ifEqpaqTF9Lhl1ebdB6s3KWh/dDwcCU+/SBTFgEK
   ia0SoQl3BbmEV0QpRa5Gh2XnDoMYabIR/8k0mcYs4opU2RU9M+zo9IszL
   PpbgdBurQsZlHSjAF78K3FAE2D0c0a4WkrctnwNUxiitIhYLipQDB3Vtv
   9bWJdsUv+I309R2xDIDR2Z8CMcKq5HtWLnHan6gP7NBg81yAM/V7v7xIK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376134641"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="376134641"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826423425"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="826423425"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:26:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsj9R-00000006Hbp-3op4;
        Tue, 17 Oct 2023 15:26:21 +0300
Date:   Tue, 17 Oct 2023 15:26:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 32/73] pinctrl: intel: cherryview: use new pinctrl
 GPIO helpers
Message-ID: <ZS59bdywVRypp+mW@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-33-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017120431.68847-33-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:03:50PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.

Just noticed, the Subj should be
"pinctrl: cherryview: use new pinctrl GPIO helpers" (no "intel:" part).


-- 
With Best Regards,
Andy Shevchenko


