Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE58791463
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349726AbjIDJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjIDJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:09:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF870184;
        Mon,  4 Sep 2023 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693818570; x=1725354570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=81lrnUmgkZAYZA/5THlO36WxWV5tUfKEk7n96vU7h6U=;
  b=Wfv6ojo0D//8lwAdAii9uI9bzLrcoqOYqMgQ/mQo1tZU6UJd7Ur3RVK9
   0qy/y7ZTcl4k/J3mUBUSZYC4H4d1z7j3x7t/e5/74W0bNC/fZlkYYEMjX
   ykL0dUwFKJ/Kd/7CGhH4aRh7fVkOD8klSDnFilnGkvSBTJeNOpgMKXjsb
   oBRI6So/T+k5yY3wgrq9wtRjjB9BIoO4Y/nN7+iWor3aHylW+WL5KtSM/
   P1wqA1RsPbt+F0eRvUNns+NS34imRV0iFqCDiXzTJHK0GMEsi/34qtdJA
   NLdXuXZFqdCKNOh73Pt1Kenc47vvllRGL+bxa/PXbG7O+RJpDQQx5R7sB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376487120"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="376487120"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="830833407"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="830833407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:09:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5aH-006Njd-2W;
        Mon, 04 Sep 2023 12:09:25 +0300
Date:   Mon, 4 Sep 2023 12:09:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mcp23s08: Extend match support for OF tables
Message-ID: <ZPWexXwTHfG9yFlM@smile.fi.intel.com>
References: <20230902090937.32195-1-biju.das.jz@bp.renesas.com>
 <20230902090937.32195-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902090937.32195-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 10:09:36AM +0100, Biju Das wrote:
> The driver has OF match table, still it uses ID lookup table for
> retrieving match data. Currently the driver is working on the
> assumption that a I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using of_device_match_data() if the devices are registered via OF.

...

> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct device *dev = &client->dev;
> -	unsigned int type = id->driver_data;

> +	unsigned int type;


Now it's shorter than below line, so move it further.

>  	struct mcp23s08 *mcp;
>  	int ret;

-- 
With Best Regards,
Andy Shevchenko


