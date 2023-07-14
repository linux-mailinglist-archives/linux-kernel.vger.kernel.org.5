Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E3753B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjGNMbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjGNMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:31:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660A3595;
        Fri, 14 Jul 2023 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337877; x=1720873877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K3KESkrbsB4Xp58w394q7+mIoO/BSEM9uPhS7IO3sdU=;
  b=TM/QMTB4uejikkKE1qwG1GzApz2OX+U/tgUHyAJpREW8+z/gTmWRICV4
   Zbbpx4TdElBlzPpMaW687ntc/1tdi2ogX5SuptxIspVM0lfC2DHxN3I3S
   vZvkSHYI/cdoVsQjaApltwro/98hFvTwvNRgbsJAJ4P8GACftfGif3WKK
   W1mBKV6PM4AzENrNfXhqqkUI2u8SaEj3+BviYWl4VTmPSBT9iY3gFiAQz
   s5qKhSK2naHmrqG+b7SUZ4WA3bICjFKRqZmmvRM+vaTJiACA9irnLCBfw
   f98vt+un2P7lRVJhXfU795kfdU14FoiTIJKDr2ZLlaRCrBE+yUkowfwzs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="369011665"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="369011665"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787839238"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="787839238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 05:31:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKHx2-002eud-0a;
        Fri, 14 Jul 2023 15:31:12 +0300
Date:   Fri, 14 Jul 2023 15:31:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Ruihong Luo <colorsu1922@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
Message-ID: <ZLFAD8lblUA6/cVd@smile.fi.intel.com>
References: <20230713004235.35904-1-colorsu1922@gmail.com>
 <5fac4a28-ff70-d6e6-dcee-8cb45916789@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fac4a28-ff70-d6e6-dcee-8cb45916789@linux.intel.com>
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

On Fri, Jul 14, 2023 at 03:07:42PM +0300, Ilpo Järvinen wrote:
> On Thu, 13 Jul 2023, Ruihong Luo wrote:
> 
> > Preserve the original value of the Divisor Latch Fraction (DLF) register.
> > When the DLF register is modified without preservation, it can disrupt
> > the baudrate settings established by firmware or bootloader, leading to
> > data corruption and the generation of unreadable or distorted characters.
> > 
> > Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")

> You forgot to add:
> 
> Cc: stable@vger.kernel.org

It's there. Just not in the commit message. It's fine.

> > Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>
> 
> Other than that,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


