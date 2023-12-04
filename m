Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94680803522
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjLDNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjLDNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:38:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15F1985;
        Mon,  4 Dec 2023 05:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696580; x=1733232580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WoWMFgig9uBFYI9AMo/dQVD9UIUxJBVY04YdMlNiXMI=;
  b=TTu/2Mi083EJ/MyyWeuORnhiw/hRtos2vaMm11HRZfkO4UWJtVTFLDGW
   8tz7LTFbvAbDzSIRNq0+v0zpzWxKA5ixd6RtMriMGG59TAijs4O53lUvf
   xmJrVZOJnK4iigCyS0TKJaqyaZWBA1B4Y6TYMsgE49qFNoy2+77NfpF7t
   FoZpFAyZMGFtFMYbV/c1WU0MeAIzkMt1U3X8nKN+gLxJk+lC5Pg5TFtjn
   xQ/3MzA6VOprzK2hATeUYNVmAjd5lnNI+9ixKArV6xXS49GzJR4Gdh0KK
   LsErjkiV8mznDwdLxJHjh/AjosOteQXRDlhbu5fsK4UN0wpc6Mv+61Av7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="390890360"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="390890360"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="836583187"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="836583187"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:29:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA90x-00000001lAf-1yEw;
        Mon, 04 Dec 2023 15:29:35 +0200
Date:   Mon, 4 Dec 2023 15:29:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Dawei Li <dawei.li@shingroup.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, jszhang@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        set_pte_at@outlook.com, stable@kernel.org
Subject: Re: [PATCH] serial: dw8250: Make DLF feature independent of
 ADDITIONAL_FEATURE
Message-ID: <ZW3UP8hfI7_-TsVl@smile.fi.intel.com>
References: <20231204130820.2823688-1-dawei.li@shingroup.cn>
 <48f6fcce-4b5-a7c0-2fc0-989b9a2fba8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48f6fcce-4b5-a7c0-2fc0-989b9a2fba8@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:20:09PM +0200, Ilpo Järvinen wrote:
> On Mon, 4 Dec 2023, Dawei Li wrote:
> 
> > DW apb uart databook defines couples of configuration parameters of

DW_apb_uart (as it's part of file name, or spell this fully).

> > dw8250 IP, among which there are 2 of them:

DesignWare 8250 IP

...

> > The bug was hit when we are bringing up dw8250 IP on our hardware

Ditto.

> > platform, in which parameters are configured in such combination:
> > - ADDTIONAL_FEATURE disabled;
> > - FRACTIONAL_BAUD_DIVISOR_EN enabled;

...

> The very same code change is already in tty-next (from another author).

For your convenience:

d804987153e7 ("serial: 8250_dw: Decouple DLF register check from UCV")

-- 
With Best Regards,
Andy Shevchenko


