Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350317D4E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjJXK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjJXK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:57:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676810CE;
        Tue, 24 Oct 2023 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698145071; x=1729681071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rGtYObcuetOYR9kP/9TpGIdMtWpvP56ffO2o63DEo7o=;
  b=lnf6reSfBpGc/epMkdnfLkcFl4qMDmkP8tthQUnLWIzFH2vKLHc47cvr
   AUjhNrezJHhp8lmqFFTy7nFQOQUr2zBNHIGhSndh+ammmgkNzWBy7pDUD
   hyhiGIeZJS19MiS+G4hT6r+4i/tc7Tuk3ZmbjF6QNmR9a3kTI4ujLR26m
   2+7cBZC4wl9EjqqiDhYY3FLNYVSgWDebrVXedHMwEwlehyU573NvnMDHO
   PujqNBh9akwUOBLDosLMjvevYSGFUuIY1Z9cM/CYaFm2xWQfbDprsdjFe
   //E2jNKu+1WsLyLSUJpIx9kY6z57HkntoNm0Fjr34UPY/0rfT9d1vAl2i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="453490635"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="453490635"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089803002"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089803002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:57:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvF6V-00000008BmT-0LUH;
        Tue, 24 Oct 2023 13:57:43 +0300
Date:   Tue, 24 Oct 2023 13:57:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
        len.brown@intel.com, robert.moore@intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 1/6] ACPI: utils: Introduce acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTejJo6io91n7e4H@smile.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024062018.23839-2-raag.jadav@intel.com>
 <20231024092839.GE3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024092839.GE3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:28:39PM +0300, Mika Westerberg wrote:
> On Tue, Oct 24, 2023 at 11:50:13AM +0530, Raag Jadav wrote:

...

> > + * Returns:
> > + *  - %true if matches.
> > + *  - %false otherwise.
> 
> Nit: these actually do not get formatted like above so you can just
> write it as
> 
> Returns: %true in case UIDs match, %false otherwise.
> 
> If it is even needed, I think it is pretty obvious from the function
> name what it returns.

kernel-doc complains if there is no Return: section in the text.

-- 
With Best Regards,
Andy Shevchenko


