Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936176D1B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjHBPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjHBPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:21:39 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097293AA4;
        Wed,  2 Aug 2023 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989507; x=1722525507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4x99QoiLN8BrAgqpLS2SVCvTXSrSU7F9mL186k74oA=;
  b=P8DCLwgoaZPAfMzrDWchcl1kRaALgb9aUPdmeL/jCD3C6NYT4WpSXMZM
   UKe6DLP452VUxpb8b0HfuvvOLiqZJnXV7ST8tKREI8X10tHSuvU3yTfjy
   M5xYEO0jw5wpdU+YQzbrcHnKsesc+pAW8cNj9UPZyN7pHI4TcmG8tprwt
   SV2YgrWH7ZL057gzqrWLjU5EgBWUxg24xhevDXZ8qck4KAsoCwFeqLfPz
   b21C97DiILd7PH2X6LGJy3lssbqwhMvfixVhpRiS155HFC59TrvrcV2pi
   htEjMoEJCdcO5kjkB4Gs7Ha5r9fYLK+VxHnDqGAvD5iFMVYSA4U9+YqVt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="433452764"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433452764"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706210933"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="706210933"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 08:14:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRDYp-0045bG-1l;
        Wed, 02 Aug 2023 18:14:51 +0300
Date:   Wed, 2 Aug 2023 18:14:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] of: Refactor node and property manipulation function
 locking
Message-ID: <ZMpy6x+GBKKIv1VP@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-5-b5203e3fc22f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v1-5-b5203e3fc22f@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:54:48PM -0600, Rob Herring wrote:
> All callers of __of_{add,remove,update}_property() and
> __of_{attach,detach}_node() wrap the call with the devtree_lock
> spinlock. Let's move the spinlock into the functions. This allows moving
> the sysfs update functions into those functions as well.

...

> +out:

out_unlock: ?

> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	if (!rc)
> +		__of_add_property_sysfs(np, prop);
> +
> +	return rc;

Why not

	if (rc)
		return rc;

	__of_add_property_sysfs(np, prop);
	return 0;

?

...

> +out:
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	if (!rc)
> +		__of_remove_property_sysfs(np, prop);
> +	return rc;

As per above.

-- 
With Best Regards,
Andy Shevchenko


