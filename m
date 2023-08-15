Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C377CDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjHON6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjHON60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:58:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929D19A1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692107895; x=1723643895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMwlw5rr1xM9LnWBVlGLBOruP5s9VUwls2zs+mXeGDo=;
  b=O9Itv/dgdOHv2eCAyl0pdJ4dEBPw1a8QuxnqavR93JHEoMB56zkqH+DL
   ij2UF18Kmweeke9MZPp69ZX7IGQIqBeMgUuiMVCnslcsLyPhM0jkQ/Es/
   oPQJpzOLWZ0xiZRmxVrOXotyQYyf2CkKa+N9u9gx8ci5xcdWOEL2Wx36i
   POp2mgsffopWibLmGD9LXy9rxPmtGSR7Rjlv8EyXjCQRjAhGazXmSBMPn
   THaIhq2pp5Y0G4q11lZK75Aoc5v/k7eYCmvKcUFwNBqbK06s5iBVRTbBP
   fv9JpjT1qzQe792xRbnT4XRlFPk0EsKYLrjTgMjfF6NnhfBz48s/BFH22
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375050874"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375050874"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683660599"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683660599"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 06:58:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qVuYd-004Act-0n;
        Tue, 15 Aug 2023 16:58:03 +0300
Date:   Tue, 15 Aug 2023 16:58:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/25] ASoC: mediatek: Convert to generic PCM copy ops
Message-ID: <ZNuEajC4gqoqniEw@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-20-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-20-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:55:17PM +0200, Takashi Iwai wrote:
> This patch converts the mediatek BT SCO driver code to use the new
> unified PCM copy callback.  It's a straightforward conversion from
> *_user() to *_iter() variants.  As copy_form/to_iter() updates the
> internal offset at each read/write, we can drop the cur_*_idx counter
> in the loop, too.
> 
> Note that copy_from/to_iter() returns the copied bytes, hence the
> error condition is inverted from copy_from/to_user().

...

> +		if (!copy_to_iter(bt->rx_packet_buf + cur_read_idx,

!= read_size ?

> +				  read_size, buf)) {
>  			dev_warn(bt->dev, "%s(), copy_to_user fail\n",

Forgot to fix the message.

>  				 __func__);
>  			return -EFAULT;

...

> +		if (!copy_from_iter(bt->tx_packet_buf + cur_write_idx,
> +				    write_size, buf)) {
>  			dev_warn(bt->dev, "%s(), copy_from_user fail\n",
>  				 __func__);
>  			return -EFAULT;

As per above.

-- 
With Best Regards,
Andy Shevchenko


