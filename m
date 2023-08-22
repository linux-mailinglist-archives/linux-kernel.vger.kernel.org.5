Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A972C78457F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjHVP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjHVP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:28:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378ECE5;
        Tue, 22 Aug 2023 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692718116; x=1724254116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXVKbTtjOz/qJfqj3L9zMmXS/t80FKowJQj0k4cD2fQ=;
  b=eYfDravU3onQAc5gZ6oVtyAoCoHL/1YCVOZnmR0EigmqV44lcSmxNe+7
   pqWp9pO+KOfCd0z1gCmH18WcvEl5rBsUsg0+A7cLtLChFKkxC7ncaAV9M
   S+Cd4/Wk6Ues3B5dEToTFA22v04G+v40VWOpJ4J4sAm6Xscc5gWXo4meh
   CPqiM6MCFk4Jru2liIvcBLOZZCu6Z7+DsJgzUDN6e7bdv6kmC/CdKbIxB
   qGyUi8g6Ec/0RABnqReDe8VwCk4qePVQGLGWrosSUHFtbKL4kx+V180j9
   alQWeeG0OnOFNHvktxu7yApeZ5bAQapD5zwsvVeZaZncCVTNjR9iw5d3s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358900819"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358900819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765780409"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="765780409"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 08:28:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYTJ1-00GIG5-1l;
        Tue, 22 Aug 2023 18:28:31 +0300
Date:   Tue, 22 Aug 2023 18:28:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] HID: cp2112: make the irqchip immutable
Message-ID: <ZOTUHzKKBNcjQLRi@smile.fi.intel.com>
References: <20230822152244.214394-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822152244.214394-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:22:44PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This make the GPIO irqchip exposed by the CP2112 driver use an immutable
> irq_chip struct thus addressing the following warning on probe:
> 
>   (cp2112_gpio): not an immutable chip, please consider fixing it!

https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-next&id=3e2977c425ad2789ca18084fff913cceacae75a2

Can you test HID for-next for this hardware?

-- 
With Best Regards,
Andy Shevchenko


