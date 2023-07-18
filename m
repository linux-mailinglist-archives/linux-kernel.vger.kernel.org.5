Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D920757ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjGROA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGROAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:00:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953E1712;
        Tue, 18 Jul 2023 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688794; x=1721224794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+kHHEcpU5o8l4BnJaCTyD8glSkoJSUgomBQ3Jx+RYLY=;
  b=nShe5O8sK/w0JFLpMs5bXhKXztiXnJoZuwUw+v1D6S30F/Ykz5ZAhxzF
   823M2dQVoO1qUsvh0tZZYix5v1loaVyoYOM+AjarTzUzJp3V7dzLLXGn/
   26lMhkxEMilbkbwVYKzVbZjcuCd6YJvnKLvXJYOSsncEQu8JwHGmX/e4w
   anG/XD4oo7ycbI24MhVlQT2DDDAOhF1fTn4lZFw0yc9A1nXjuugrtAddb
   425JrwnN2WRFkOVn81VTKKKF2+dYv02rSN+mV/73EbZ4Z01e2VRM9vMxG
   Ro68vO7Cb8sG8M/76n7PgqdcOw37jFFvFEHOn3MntqZSEesHj3ulkh4fU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345804616"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345804616"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847708865"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847708865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 06:58:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlE5-00G6gR-0y;
        Tue, 18 Jul 2023 16:58:53 +0300
Date:   Tue, 18 Jul 2023 16:58:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: Re: [PATCH next] media: i2c: fix error handling in
 ub960_rxport_add_serializer()
Message-ID: <ZLaanLVc22iKg/xV@smile.fi.intel.com>
References: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:58:46AM -0700, Harshit Mogalapalli wrote:
> Smatch warns:
>  drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
>  err: 'rxport->ser.client' dereferencing possible ERR_PTR()
> 
> i2c_new_client_device() returns error pointers on failure and in
> dev_dbg statement we are dereferencing error pointer which is a bug.
> 
> Fix this by using IS_ERR() which checks for error pointers.

...

> -	if (!rxport->ser.client) {
> +	if (IS_ERR(rxport->ser.client)) {

>  		dev_err(dev, "rx%u: cannot add %s i2c device", nport,
>  			ser_info.type);
>  		return -EIO;

It should be changed to return PTR_ERR(...);

-- 
With Best Regards,
Andy Shevchenko


