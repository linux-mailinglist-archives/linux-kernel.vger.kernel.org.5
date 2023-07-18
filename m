Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C475836D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjGRR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjGRRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:25:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7126BE;
        Tue, 18 Jul 2023 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689701157; x=1721237157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c2mlWNa1d/FZEIiXwHOg+EoY8yT+5U1KLwWZO6gycOs=;
  b=gpeL3kTRGl0gXRN8kQaVGgwTQYH/RBtLmqysM6XSqNLBn2SB8wpiJja+
   HCY/gmrs//IoHWWyXwgUASuAf9fAAjYXI4hQV38vnkMO/SEa5NR+oDpws
   sLdS9BsBP4yXHxGwD5Vxbh94GhdQtsvrrFBJQEJJGYuXVNRweUORUILCf
   DOaSO5pZMD+P0yJITwsvzWqgf7eQq/RaROzrp1HOp0E9PvuI6n8MqYg+A
   tB/tfg1WrmIzgLMWAmFxiVUd9H97Q6ag6BijwzdueWWZDhADZ2jL6U8Po
   TQTFIvMRxW0iW4EhH+LNi23uRRWc66jkx3yUe/cjVPoBhIqmrV0q2ndsK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397111492"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="397111492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674004131"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="674004131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2023 10:25:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLoSP-005hx6-30;
        Tue, 18 Jul 2023 20:25:53 +0300
Date:   Tue, 18 Jul 2023 20:25:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Milan Zamazal <mzamazal@redhat.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2] iio: core: Prevent invalid memory access when there
 is no parent
Message-ID: <ZLbLISs1WopHBadA@smile.fi.intel.com>
References: <20230718152917.435962-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718152917.435962-1-mzamazal@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:29:17PM +0200, Milan Zamazal wrote:
> Commit 813665564b3d ("iio: core: Convert to use firmware node handle
> instead of OF node") switched the kind of nodes to use for label
> retrieval in device registration.  Probably an unwanted change in that
> commit was that if the device has no parent then NULL pointer is
> accessed.  This is what happens in the stock IIO dummy driver when a
> new entry is created in configfs:

>   # mkdir /sys/kernel/config/iio/devices/dummy/foo
>   BUG: kernel NULL pointer dereference, address: ...
>   ...
>   Call Trace:
>   ...
>   asm_exc_page_fault
>   container_offline
>   __iio_device_register
>   krealloc
>   iio_device_attach_buffer
>   iio_simple_dummy_configure_buffer
>   iio_triggered_buffer_setup_ext
>   iio_dummy_probe
>   iio_sw_device_create
>   device_make_group
>   configfs_mkdir

Please, remove more unrelated lines in this backtrace. Ideally it should come
to ~4-5. For example, you posted a command line, it's obvious that you run
configfs, so the last (two) line(s) of the backtrace are redundant.
Then drop basic stuff, like:

   asm_exc_page_fault
   container_offline
   krealloc

Then remove unrelated IIO internals.

> Since there seems to be no reason to make a parent device of an IIO
> dummy device mandatory, let’s prevent the invalid memory access in
> __iio_device_register when the parent device is NULL.  With this
> change, the IIO dummy driver works fine with configfs.

The code wise it's okay now, so after addressing above
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


