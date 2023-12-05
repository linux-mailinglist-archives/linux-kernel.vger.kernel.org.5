Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D6F805BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346379AbjLEPzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjLEPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:55:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDDBA;
        Tue,  5 Dec 2023 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701791753; x=1733327753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cjRwytJeG5TG/a1uu/+8HD2/PFh3IJgfHgcnXENi5L4=;
  b=Zi/EE8zE7wIrMMRuoTqGM8QHnI520S3SS4Uobg8JvU69nvxkW/xovV8p
   MjBHoWmsmVFDwWkGzzyO4pKoBLDLd+FDoogxwsJ2UZAiAUOgmPnuWIakr
   Dzirc0MELP9gxe9r7oMFc7qnGFL+F9ncsqsI+uAdCE9AcTLFxpg/85YFd
   4kIgso5mOGEUoFfAoe4C4f8u5Ru8DJmIftRLzYBbk2WAnNZfNo6VKFbHQ
   eAtfxCoiuGoQo4f1fJbedvC+7WD0aHXng5w0JWwwDoE7x4JRh5safvC98
   Dkj7x1nHeY5M2nQbrYzdpjTLh3fikC2k9dnGDD8e/qwCsWXS7G+WI5hoj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7259414"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7259414"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="861786429"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="861786429"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:55:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rAXly-000000024rT-06ck;
        Tue, 05 Dec 2023 17:55:46 +0200
Date:   Tue, 5 Dec 2023 17:55:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dawei Li <dawei.li@shingroup.cn>
Cc:     Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, jszhang@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        set_pte_at@outlook.com, stable@kernel.org
Subject: Re: [PATCH] serial: dw8250: Make DLF feature independent of
 ADDITIONAL_FEATURE
Message-ID: <ZW9IASqCQi_Qi4UB@smile.fi.intel.com>
References: <20231204130820.2823688-1-dawei.li@shingroup.cn>
 <48f6fcce-4b5-a7c0-2fc0-989b9a2fba8@linux.intel.com>
 <ZW3UP8hfI7_-TsVl@smile.fi.intel.com>
 <6863B74199951BD2+ZW6DIO1n0phYBjg9@centos8>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6863B74199951BD2+ZW6DIO1n0phYBjg9@centos8>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:55:44AM +0800, Dawei Li wrote:
> On Mon, Dec 04, 2023 at 03:29:35PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 04, 2023 at 03:20:09PM +0200, Ilpo Järvinen wrote:
> > > On Mon, 4 Dec 2023, Dawei Li wrote:

...

> > > The very same code change is already in tty-next (from another author).
> > 
> > For your convenience:
> > 
> > d804987153e7 ("serial: 8250_dw: Decouple DLF register check from UCV")
> 
> [sigh]
> 
> Apparently I thought tty/for-linus is the "bug fixing" branch for tty by
> mistake, and didn't realize the same fix patch has been landed in tty-next
> for a while.
> 
> Thanks for the update.
> 
> Anyway, I believe the fixing patch should cc stable and be getting backported?
> I hit the bug on 5.10.x, it's possible the bug has been there before that.

When that commit meets upstream you can always resend it for stable. The process
is documented.

-- 
With Best Regards,
Andy Shevchenko


