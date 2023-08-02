Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFC76DA05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjHBV4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHBV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:56:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2A1712;
        Wed,  2 Aug 2023 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691013366; x=1722549366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPnjyCol6mSkqe/I6LFj5Fg8Cfw99iZMAfmBzpyn1Jk=;
  b=G0QgTXAQ7nTn7ZFIpI83wZXWnhnMyzft00d0xQ55rrgJU8U4+SbPyfQz
   xPUGHX+EQL5gk14fDBTrGMAiXSYNvcSjK11gni2E6jk27qncJ/ooCodlj
   iAjdRBhdURasO3rkLRqjM/fMG94QMDaGMdZN4zovLFofbXAUqJfnGNtD7
   MQQ6oH9xWlN90sHg8IKjIuwWcBL/9lx0xqt/+1r4dBMSPRaOEcL7NJSm8
   5xPl2mRYta4jTiMULLhaBZTZljC/O0lsp6IhKfYxBdjGNXlv80JvrVii9
   H1NIFWIBh8W6xWv4PJ/H/617stm4TnmU5dfxFyGzSOwA3ytKeul3nCdMx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354624661"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="354624661"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="758890861"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="758890861"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2023 14:56:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRJp3-0008cb-0q;
        Thu, 03 Aug 2023 00:56:01 +0300
Date:   Thu, 3 Aug 2023 00:56:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_dw: fall back to poll if there's no
 interrupt
Message-ID: <ZMrQ8IXyqGqTKR79@smile.fi.intel.com>
References: <20230802150545.3742-1-jszhang@kernel.org>
 <20230802150545.3742-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802150545.3742-3-jszhang@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:05:45PM +0800, Jisheng Zhang wrote:
> When there's no irq(this can be due to various reasons, for example,
> no irq from HW support, or we just want to use poll solution, and so
> on), falling back to poll is still better than no support at all.

...

>  	irq = platform_get_irq(pdev, 0);

You will still have an error message. Perhaps you need to replace it with

	irq = platform_get_irq_optional(pdev, 0);

> -	if (irq < 0)
> -		return irq;
> +	if (irq < 0) {
> +		if (irq != -ENXIO)
> +			return irq;
> +		/* no interrupt -> fall back to polling */
> +		irq = 0;
> +	}

This can be slightly modified:

	/* no interrupt -> fall back to polling */
	if (irq == -ENXIO)
		irq = 0;
	if (irq < 0)
		return irq;

-- 
With Best Regards,
Andy Shevchenko


