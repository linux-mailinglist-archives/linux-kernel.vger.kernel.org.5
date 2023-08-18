Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E50780AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376585AbjHRLTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376622AbjHRLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:19:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F83AB4;
        Fri, 18 Aug 2023 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692357581; x=1723893581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ECNjpOhCkzTU1qIG9kKqGxSVPEjrxK8n8FSK7eqFXF4=;
  b=NYhBbPtor904mKB+Oftr/U24DQjS8Bmu0sDqymyK+Sh8/98qfeIwUbVq
   qGhqAqpSruS9oup2+0InZ1ipc4AZ2r62/zKRaR8E7u7vgFiHN4OQzA0by
   m3tMwqaz3CpvmRc5UyKCxz2ucNrd861F/spkIG2BkV6LJb0TCGuHUfyei
   lIwU1N3mr1SpExmyoFlr9vzoQOQH7W0KEW+u0whHX7WO7OqNJUjcDA6x7
   yR471ujNXanhpJQdQ2+bueRnsawXlKOvorokc8x+T2y4ocyURJB9QK/6L
   yow6ssyL0nNXG2FP5+hdWoQKgHsjmD8d0EilmT9m75kKFgLniypUfBe1A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="404061545"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="404061545"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="684871290"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="684871290"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2023 04:19:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxVx-005S6T-18;
        Fri, 18 Aug 2023 14:19:37 +0300
Date:   Fri, 18 Aug 2023 14:19:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
Message-ID: <ZN9TyGjr/pqLQUpT@smile.fi.intel.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
 <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:05:21PM +0200, Angel Iglesias wrote:
> Improve device detection in certain chip families known to have various
> chip ids.

...

> +	ret = -EINVAL;

Why do you need this...

> +	for (i = 0; i < data->chip_info->num_chip_id; i++) {
> +		if (chip_id == data->chip_info->chip_id[i]) {

> +			ret = 0;

..and this...

> +			break;
> +		}
> +	}

> +	if (ret) {

...and this?

You can simply do

	for (i = 0; i < data->chip_info->num_chip_id; i++) {
		if (chip_id == data->chip_info->chip_id[i])
			break;
	}
	if (i < data->chip_info->num_chip_id) {

...

> +		// 0x<id>, so four chars per number plus one space + ENDL
> +		size_t nbuf = 5*data->chip_info->num_chip_id*sizeof(char);

Besides lack of spaces...

> +		char *buf = kmalloc(nbuf, GFP_KERNEL);

...this at least should be kmalloc_array() and on top maybe something from
overflow.h will be needed.

> +		if (!buf)
> +			return ret;
> +
> +		for (i = 0; i < data->chip_info->num_chip_id; i++)
> +			snprintf(&buf[i*5], nbuf, "0x%x ", data->chip_info->chip_id[i]);
> +		buf[nbuf-1] = '\0';
> +
> +		dev_err(dev, "bad chip id: expected [ %s ] got 0x%x\n", buf, chip_id);
> +		kfree(buf);
> +		return ret;
>  	}

...

> -	const unsigned int chip_id;

Yeah, this const makes a little sense...

> +	const unsigned int *chip_id;

...but not this :-)

What I'm wondering is why it's int and not u8 / u16
(as it seems only a byte value there).

> +	int num_chip_id;

unsigned.

-- 
With Best Regards,
Andy Shevchenko


