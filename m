Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5917D7C59A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjJKQzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjJKQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:55:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804B9D;
        Wed, 11 Oct 2023 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697043306; x=1728579306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZraWdjDkR3JP55NOUPdJDQ5etbz9Arzzx5/PgAMMdwg=;
  b=J+PF3dSt4W+W2hFjyt29xHqJgWmOKrgpjVawygkxq1ca9gSVSK5uhJMn
   9Z/387CerVw0yrPXHZVncJ8UKhsOdb5mOWHDPhNfiKlwTdt507okkqzQd
   2SGJb6Gl4hHsC4K3OoPZIx7kJUjKYOIQZLHE83NLwXdbFr3yzKXJZh/1E
   ri7H7ctD6mB0TLvz9y2GAgwRJNhnSsjywifzrkUp3AtL6/Rsk5pud1hEX
   Whnvw1xow+wTftP9qCNhFWskgWqOm4KX02M6px7EnjqzHx3rJk5VbDP4p
   eRT16+EjcgkWa+sRZprHXQ2koMQ955olbwTBQMgVNMvDJc5lDAUDXxHwg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="364998074"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="364998074"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870225141"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870225141"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:54:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqcU4-00000004n1h-16MO;
        Wed, 11 Oct 2023 19:54:56 +0300
Date:   Wed, 11 Oct 2023 19:54:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 31/62] pinctrl: remove pinctrl_gpio_request()
Message-ID: <ZSbTXz6aEdMxG4Y/@smile.fi.intel.com>
References: <20231011120830.49324-1-brgl@bgdev.pl>
 <20231011120830.49324-32-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011120830.49324-32-brgl@bgdev.pl>
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

On Wed, Oct 11, 2023 at 02:07:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are no more users of pinctrl_gpio_request() so remove it.

My question was and still is why can't we preserve most of the code?
It seems with changing a prototype to a new one and using a temporary variable
will reduce the diff noise quite a lot.

Another question is can we actually derive old functions from _new ones?

Like

foo_new(struct gpio_chip *gc, unsigned int offset)
{
	...real implementation...
}

foo(unsigned gpio)
{
	...something to get gpio chip and offset...
	foo_new(gc, offset);
}

?

-- 
With Best Regards,
Andy Shevchenko


