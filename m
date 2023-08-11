Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9843778BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjHKKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjHKKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:16:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73866120;
        Fri, 11 Aug 2023 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691749010; x=1723285010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tVPd6gUd2vGL79XhejO82av1TVq9COxvYKVND28mf4o=;
  b=Zr4y6MHorEu6IF8qKP2rtxWZQxuJWyNjhMyfqxLpAq+/XkMywBO1nW0P
   3hO+lCnwc0fzPT8ZTYW0ypAE75OyCmwaAp8nrKtdvl+WEw7GcwBvgdEEg
   BhrfvbvybQkrEA1ymMhqdGnvvDxixDOAtK4YzQmN06bV4oN8m7SM31JQ0
   Ekmosck+yPMjBHtKu91sZqKSSukT+nj+4vDiN2ru5dpnNNAu5mmJR+bb0
   ByZifc1AtcKVhBWOepeLmn4FNaB2FpA5sRiuzzjnP6wqZBb2OeSAjM81Z
   5iLaePssKrcCPZi/peNqN+5OXlykOvkMnjHafVX8wzJdhwoTe0ZMNTe8M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375359578"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="375359578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709486859"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709486859"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2023 03:16:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUPCI-00ACFD-2p;
        Fri, 11 Aug 2023 13:16:46 +0300
Date:   Fri, 11 Aug 2023 13:16:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: regression from commit b0ce9ce408b6 ("gpiolib: Do not unexport
 GPIO on freeing")
Message-ID: <ZNYKjnPjIRWIYVot@smile.fi.intel.com>
References: <20230808102828.4a9eac09@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808102828.4a9eac09@dellmb>
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

On Tue, Aug 08, 2023 at 10:28:28AM +0200, Marek Behún wrote:
> Hi,
> 
> the commit b0ce9ce408b6 ("gpiolib: Do not unexport GPIO on freeing")
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0ce9ce408b6
> 
> causes a regression on my mvebu arm board (haven't tested on other
> systems), wherein if I export a GPIO to sysfs and then unexport it, it
> does not disasppear from the /sys/class/gpio directory, and subsequent
> writes to the export and unexport files for the gpio fail.
> 
>   $ cd /sys/class/gpio
>   $ ls
>   export       gpiochip0    gpiochip32   gpiochip512  unexport
>   $ echo 43 >export
>   $ ls
>   export       gpio43       gpiochip0    gpiochip32   gpiochip512
>   unexport
>   $ cat gpio43/value
>   1
>   $ echo 43 >unexport
>   $ ls
>   export       gpio43       gpiochip0    gpiochip32   gpiochip512
>   unexport
>   $ echo 43 >unexport
>   ash: write error: Invalid argument
>   $ echo 43 >export
>   ash: write error: Operation not permitted

Can you test the following change (I'll submit a formal patch if it works)?

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 530dfd19d7b5..b10a9b5598b2 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -515,8 +515,9 @@ static ssize_t unexport_store(const struct class *class,
 	 * they may be undone on its behalf too.
 	 */
 	if (test_and_clear_bit(FLAG_SYSFS, &desc->flags)) {
+		gpiod_unexport(desc);
+		gpiod_free(desc);
 		status = 0;
-		gpiod_free(desc);
 	}
 done:
 	if (status)

-- 
With Best Regards,
Andy Shevchenko


