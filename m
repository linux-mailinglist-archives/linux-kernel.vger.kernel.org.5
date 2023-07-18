Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42B757FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjGROmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGROmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:42:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE9EEC;
        Tue, 18 Jul 2023 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689691329; x=1721227329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WozK0FLM9qmME1gbk1x85asqParkBU93wFxvIidHN9A=;
  b=bc860qFMg2B0KCy6SsJjargd6KIhyVs9+d+v9hw/fNzSDlKHJZFIt3hb
   cGpmGQzXMVhzDHXwF4t1Kq4KCXw0z6knRXVDddj9OZw1NcVf1+yL6CywJ
   bG3J70UYsOyNjY1RGheumRicExrqHtI+wJHFZ/kP+JbFu/dBXeiOjncX7
   r2XS78gueyX9UzG7yaC+kzGzowcRAjv6c1c83WTnxp5XLL2j2raWMgrA0
   2OV+6IBSZ+k59Lv8E41VFON/VpqedBkx7pcT5KMeR51SMzHnbpKGjDTwa
   D47L+tc9mdFl69xvbgyyW1zOzoJ5Wvl2FD18VTaJLIE+T02O/qlzSgd82
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432405303"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432405303"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723653191"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="723653191"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 07:42:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLltu-0000UD-0X;
        Tue, 18 Jul 2023 17:42:06 +0300
Date:   Tue, 18 Jul 2023 17:42:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Milan Zamazal <mzamazal@redhat.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: core: Prevent invalid memory access when there is
 no parent
Message-ID: <ZLakvcT21cF35bRK@smile.fi.intel.com>
References: <20230718120700.132579-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718120700.132579-1-mzamazal@redhat.com>
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

On Tue, Jul 18, 2023 at 02:07:00PM +0200, Milan Zamazal wrote:
> Commit 813665564b3d ("iio: core: Convert to use firmware node handle
> instead of OF node") switched the kind of nodes to use for label
> retrieval in device registration.  Probably an unwanted change in that
> commit was that if the device has no parent then NULL pointer is
> accessed.  This is what happens in the stock IIO dummy driver when a
> new entry is created in configfs:

>   # mkdir /sys/kernel/config/iio/devices/dummy/foo
>   BUG: kernel NULL pointer dereference, address: 0000000000000278
>   ...
>   ? asm_exc_page_fault+0x22/0x30
>   ? container_offline+0x20/0x20
>   __iio_device_register+0x45/0xc10
>   ? krealloc+0x73/0xa0
>   ? iio_device_attach_buffer+0x31/0xc0
>   ? iio_simple_dummy_configure_buffer+0x20/0x20
>   ? iio_triggered_buffer_setup_ext+0xb4/0x100
>   iio_dummy_probe+0x112/0x190
>   iio_sw_device_create+0xa8/0xd0
>   device_make_group+0xe/0x40
>   configfs_mkdir+0x1a6/0x440

Read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and amend the commit message accordingly.

> Since there seems to be no reason to make a parent device of an IIO
> dummy device mandatory, let’s prevent the invalid memory access in
> __iio_device_register when the parent device is NULL.  With this
> change, the IIO dummy driver works fine with configfs.

...

>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *fwnode = NULL;
>  	int ret;
>  
>  	if (!indio_dev->info)

>  	/* If the calling driver did not initialize firmware node, do it here */
>  	if (dev_fwnode(&indio_dev->dev))
>  		fwnode = dev_fwnode(&indio_dev->dev);
> -	else
> +	else if (indio_dev->dev.parent != NULL)
>  		fwnode = dev_fwnode(indio_dev->dev.parent);

This part of the change is okay with dropped " != NULL".

> -	device_set_node(&indio_dev->dev, fwnode);
> -
> -	fwnode_property_read_string(fwnode, "label", &indio_dev->label);
> +	if (fwnode != NULL) {
> +		device_set_node(&indio_dev->dev, fwnode);
> +		fwnode_property_read_string(fwnode, "label", &indio_dev->label);
> +	}

This part of the change is not needed.

-- 
With Best Regards,
Andy Shevchenko


