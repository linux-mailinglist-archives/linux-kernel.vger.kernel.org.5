Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471017B6C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjJCOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJCOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:48:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E15A1;
        Tue,  3 Oct 2023 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696344514; x=1727880514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xOPb2YJyo9DElC9cdF/qeqFy+J/BPVzboCD+C8033Ew=;
  b=NSLJGu4t1WYTjPlkdiY6X/HD37BTeM5NXeZAyvdKuPqSuSgsomLqtpCj
   vmk/S1sasq3E7404CuoYgp1ERKlBGr07Lt9tEDOPmcu0RsHWj4EoSV1rI
   AevcCsUQsnQm78FHhh7JY/m/LElFsOc9077WlULZzmvgYRTB8piqQ6cHH
   Yr6aq4JzIDWpdyuiTzJhX5R6cGTdIXKVoRtsESzLtGWgPhtvlFtd+KrHm
   Aja+bJloboy2xB6AyfBWiCKVSYZLLGEFnPOfvtO3xrzIQA5w8zfXWf1S0
   I0pkTH+2JvZgsmfXXqklMrOwDjgiWPiv/kxIrD9NMnZBuz9eo93pGPzs5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385718306"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="385718306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821277035"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="821277035"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:48:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnghJ-00000002VwI-1pU0;
        Tue, 03 Oct 2023 17:48:29 +0300
Date:   Tue, 3 Oct 2023 17:48:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm7271: Use
 devm_clk_get_optional_enabled()
Message-ID: <ZRwpvYn9xSm3+F/T@smile.fi.intel.com>
References: <20231003141241.3071687-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003141241.3071687-1-andriy.shevchenko@linux.intel.com>
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

On Tue, Oct 03, 2023 at 05:12:41PM +0300, Andy Shevchenko wrote:

Seems the old version had been sent...

...

> +	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");

Here should be

	ret = PTR_ERR_OR_ZERO(baud_mux_clk);

> +	if (IS_ERR(baud_mux_clk))

	if (ret)

> +		goto release_dma;


...I'll send a v2 later on. Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


