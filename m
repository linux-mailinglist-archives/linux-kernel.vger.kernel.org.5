Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCB7915A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbjIDKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIDKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:20:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A0BD;
        Mon,  4 Sep 2023 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822816; x=1725358816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/k79Bk4sZ2+AIgN8Yvpf6kLcT4tQnIjde6o4gjoUXc=;
  b=C6Vw6TCNtHKseUNRPGAcJBtcpNEaHaQ15HD8s4maQsZCauTfqxuVAP66
   qUMMHp2XyrQNeQ9mJp6Aar0O0OxTU3MICUkoZd+zW2hly0y+Mrk5buArP
   ZqLSMgdxnmoLx0I4uDdUmmB4Ce0APS0MakMkA4UWawe2YaTJRAijgTwx/
   SM1oSnr6yONTa6l0dkTgn3G1Zd2tz9vybTgAoPAOrPXrGyJLG7hMa4BeR
   9sFu4Rafnam5101gVMbS+n97IfPlFsRbtoMVGsnOiJHeQCKnZwMc3pfO9
   RlIH0R6S32z/5TBKSCxrcqDDV+jL4vPqdQVFr608OBeUV+cdQ73FQqrMI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="361589800"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="361589800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="864292438"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="864292438"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:20:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6gl-006OjR-2n;
        Mon, 04 Sep 2023 13:20:11 +0300
Date:   Mon, 4 Sep 2023 13:20:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPWvWwMd6HqZQqES@smile.fi.intel.com>
References: <20230903191748.12535-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903191748.12535-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 09:17:48PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We access internals of struct gpio_device and struct gpio_desc because
> it's easier but it can actually be avoided and we're working towards a
> better encapsulation of GPIO data structures across the kernel so let's
> start at home.
> 
> Instead of checking gpio_desc flags, let's just track the requests of
> GPIOs in the driver. We also already store the information about
> direction of simulated lines.
> 
> For kobjects needed by sysfs callbacks: we can leverage the fact that
> once created for a software node, struct device is accessible from that
> fwnode_handle. We don't need to dereference gpio_device.
> 
> While at it: fix one line break and remove the untrue part about
> configfs callbacks using dev_get_drvdata() from a comment.

> ---
> v1 -> v2:
> - use get_dev_from_fwnode() instead of dereferencing fwnode directly

Still no.

-- 
With Best Regards,
Andy Shevchenko


