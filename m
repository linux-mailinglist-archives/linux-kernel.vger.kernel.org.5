Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6877CD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHONvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjHONve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:51:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA06138
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692107493; x=1723643493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEWWWn6PnBw0uP74Ou/fHMCn6RcO7ifuOGqpIrzxB3I=;
  b=DAggYLvtfo6mIIIodp/ospEMVhPXeLsiMjUkOV9htqA6ShThY/okoTkM
   CrGsCufeEnrz7pBADHv6FGRGqOwgbskSAOQzYYvJ0zO6ldLL/zYbVp8NU
   J8vOCAdwu5z/UOV6K3OCSDOiWAwCV9OzprXA7flu8X31ao6I5eBr6eY8i
   jVwJVRDjojD7T7+I/A5N+bv+0rn3hO+q9nJ4uju3g3vWO19TqoFDaXekl
   hTSdc79O2w+qYhpM0tvIWVoLEZZl+9CkhszEHkQ4jgR5ATSG0+/pYT8Qh
   7+oMwMm9KQmfnP3ge3an3vCONb//Xj+8iaC4RXcYGSg+3QUd6uJmynK9/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371188863"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="371188863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803827030"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803827030"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 06:51:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qVuSI-003wZW-1S;
        Tue, 15 Aug 2023 16:51:30 +0300
Date:   Tue, 15 Aug 2023 16:51:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/25] ALSA: core: Add memory copy helpers between
 iov_iter and iomem
Message-ID: <ZNuC4qKYOR4piQQU@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-4-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-4-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:55:01PM +0200, Takashi Iwai wrote:
> Add two more helpers for copying memory between iov_iter and iomem,
> which will be used by the new PCM copy ops in a few drivers.
> The existing helpers became wrappers of those now.
> 
> Note that copy_from/to_iter() returns the copied bytes, hence the
> error condition is inverted from copy_from/to_user().

...

> -	return copy_to_user(dst, (const void __force*)src, count) ? -EFAULT : 0;
> +	return !copy_to_iter((const void __force *)src, count, dst) ? -EFAULT : 0;

Inverted means, I believe, this

	return copy_to_iter((const void __force *)src, count, dst) == count ? 0 : -EFAULT;

as far as I understand the idea behind the copy_to_user() return value.

Ditto for other cases.

-- 
With Best Regards,
Andy Shevchenko


