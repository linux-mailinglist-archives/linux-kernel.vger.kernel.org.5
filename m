Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D068B7F4986
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbjKVO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKVO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:57:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE40A1BD;
        Wed, 22 Nov 2023 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700665054; x=1732201054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QmCmsDYuWFrteOkVmVv57eZINUPD+VWxdq8C4RiZpUI=;
  b=chYHbHO8XVmBse4W7jDAiU1wyOuM4YzvymD/H823NHZUR+4QqUVcwcRB
   uhdWdYYUZCGwp3T/BrvnWk9ZYGuf+0c4oyCWdiMwgL+MPg3SnuTo1khjT
   zVwXjur1osaNgGxGqWipFPS5Qf0J2StxT8sGSeEtiRfLSLZ3VHB0tfZ+Y
   phn8apiOFKzWJMjhPvFK/ZtvjTcPtZJf/ZvmWcX+BrgZGleLddJwgheYF
   xqf6CPv3USzYKpxdISsW7TJLWu7A7hGp8GiFMIHZnFlGox2UTaaIK2AMD
   sTp2Qkh1oZzRGxwGCtAkYw6fpp0ll3VAQhwHb72xMN9qZ+kZdE+cO7OAN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="395992799"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="395992799"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 06:57:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014264579"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="1014264579"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 06:57:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5ofP-0000000G7JZ-2vwJ;
        Wed, 22 Nov 2023 16:57:27 +0200
Date:   Wed, 22 Nov 2023 16:57:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] serial: add rs485-mux-gpio dt binding and support
Message-ID: <ZV4W14KUAqTI6Seo@smile.fi.intel.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:10:53PM +0100, Rasmus Villemoes wrote:
> Some boards are wired so that they support both rs232 and rs485, with
> a gpio controlling a mux connecting the SOC's pins to the appropriate
> external circuitry. Instead of requiring the application to know about
> such details and handle the gpio appropriately, allow it to be
> described in device tree and let the serial core code handle it if
> present.
> 
> Tested on a board based on imx8mp.

Why mux framework is not (may not) used?

-- 
With Best Regards,
Andy Shevchenko


