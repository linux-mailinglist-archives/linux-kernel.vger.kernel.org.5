Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5687BBC26
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjJFPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjJFPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:51:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D39E;
        Fri,  6 Oct 2023 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696607469; x=1728143469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wM6CohiPQIIRlPPtGEd1udq/67O5yRJd469Kn4iE5wg=;
  b=MJmHxbfE30Be+nZPYeEjvcbQ6IkhcSZrSTpJAnvJV4AZ5s57a4NfJsSS
   wySsdOw5nWxKyjfoRGvdF6ubrrlMqlCnHAOBf1pFsnMQQRd4C/zKREMEP
   dQSNMBiV2sSkH66ODOHVUbamxm8vFvpGkQtyhWeycWRhEVJ4BkelPnxr7
   nQrUEX/h0l0X9fU2RshAa7HZkE2Pq8cdXlBKjxlzztRRVmGKuNpx8RfLr
   9JxG1OEdHJXFTWP+KCAUBE8nnqRvfYsOV72KFokxNM5Y1Cb35zHcLf4Yd
   zRulC4Bzoa8sSmOOtJtuc55xaHD0NZnuk+VG4q7qr9fEmSj/WfI5hthM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374119405"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374119405"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="868384851"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="868384851"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:51:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qon6V-00000003MWk-1Iik;
        Fri, 06 Oct 2023 18:51:03 +0300
Date:   Fri, 6 Oct 2023 18:51:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Chary <corentin.chary@gmail.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
Message-ID: <ZSAs5ocT6kEIXb0S@smile.fi.intel.com>
References: <20231006152739.3495671-1-andriy.shevchenko@linux.intel.com>
 <9ebb5ae0-2ec0-198c-3843-e44ce84493d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebb5ae0-2ec0-198c-3843-e44ce84493d2@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:32:10PM +0200, Hans de Goede wrote:
> On 10/6/23 17:27, Andy Shevchenko wrote:

> > +	id = acpi_match_device(device_ids, adev);
> > +	if (id)
> > +		data->hswc_params = (const struct hswc_params *)id->driver_data;
> >  	if (!data->hswc_params)
> >  		return 0;
> 
> Thanks, but the error checking looks a bit weird now. How about:
> 
> 	id = acpi_match_device(device_ids, adev);
> 	if (!id)
>  		return 0;
> 
> 	data->hswc_params = (const struct hswc_params *)id->driver_data;
> 
> That seems to better convey what the code's intention is.

Indeed, otherwise the hswc_params seems to stay NULL anyway (due to kzalloc()
use). I'll send a v3 with your suggestion being incorporated, thank you!

-- 
With Best Regards,
Andy Shevchenko


