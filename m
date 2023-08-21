Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB308782774
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjHUK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHUK6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195DDF;
        Mon, 21 Aug 2023 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692615484; x=1724151484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3QFrkyIBcGfHmYLB5qUxzNQFbRu59hUeFvAnJoj2Ydc=;
  b=ma9UOyBTgACcWZLywwZ5Y1AegbjDyE1Y5DD2Z/8dhRugeBCiui7+FRZi
   vEdvdTXj6NqSk/WumJrAkq4nZzp2yOdBtwIaMpGPnhesU0Ho6OPgWh7T4
   PBM9XUHd2B/VpqRpjXftd644mNanZa5k1Q60Yy3Mt4n80Ux3fjtooXR3u
   EodFdmCTbqcG2zkcDkDIAzupnGk2nq3LWgJzgfCW7j0G9GX+DaSgumBQu
   zCvAiWF+pE49zrseOPEeeZxf4Mz0Z6STBe56Ce4G0uX3rkMSn9Ncbb/cT
   OUxZm23PBbY5s6w1AmHzxh9x1oJsTkr5C6j9apSQAKlnlAmO3SG54SWod
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373529610"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373529610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="805886493"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="805886493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 03:57:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2bd-00AjSr-02;
        Mon, 21 Aug 2023 13:57:57 +0300
Date:   Mon, 21 Aug 2023 13:57:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk, arnd@arndb.de,
        linus.walleij@linaro.org, jeremy.kerr@canonical.com,
        isaacmanjarres@google.com, hdegoede@redhat.com,
        ulf.hansson@linaro.org, rafael@kernel.org,
        grant.likely@secretlab.ca, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/2] amba: bus: fix refcount leak
Message-ID: <ZONDNOMJ0h7c/jbC@smile.fi.intel.com>
References: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:39:27AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> commit 5de1540b7bc4 ("drivers/amba: create devices from device tree")
> increases the refcount of of_node, but not releases it in
> amba_device_release, so there is refcount leak. By using of_node_put
> to avoid refcount leak.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


