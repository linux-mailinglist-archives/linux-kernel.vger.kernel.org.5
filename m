Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615AC756009
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGQKEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGQKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:04:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC12699;
        Mon, 17 Jul 2023 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689588195; x=1721124195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rDw2VpnJC+wEtUvjAwZJO48TE28zxHwL7wMChehepkY=;
  b=gbeuXgphOkso8/+htsS0hGFZ9SEVV80XkD2g+N2qHMbWY8IEe15HYslH
   pUFPo+uSTMXN4o7LgXUs3Nbwf/vSFiFiVbcUx6lmYFAscS3A3LEFzjEh/
   Fg6dMOAB+mjASntN0k583cJpW9zwbQJv02WTOf+TdpEfK4sST5A+HudkH
   URi+OxGIif2f6toMfu23g/krW5s8+Bu4Tw2aqwP10Af+tf4Jt8eHc/J7H
   vT+UsxeQuX7NpCs8wlkstJgUvDhnizvKB1fXFJlAEipuW6zY8tiiVdWqn
   QOhPqaj1/40HX8sQllKfq/P36hbinJgZG1D9r2i1GYyQPgdW4vFlQendP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="355829593"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355829593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866689991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 03:02:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLL3p-008a1g-0r;
        Mon, 17 Jul 2023 13:02:33 +0300
Date:   Mon, 17 Jul 2023 13:02:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steve French <stfrench@microsoft.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v1 1/1] smb: client: Rework memcpy() to avoid compilation
 error
Message-ID: <ZLURuRvO3Wai//KD@smile.fi.intel.com>
References: <20230717100003.11824-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717100003.11824-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:00:03PM +0300, Andy Shevchenko wrote:
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘CIFS_open’ at fs/smb/client/cifssmb.c:1249:3:
> include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Instead of memcpy() use member-by-member copy. Let compiler do its job
> on optimisation.

It seems there are more similar errors, feel free to apply this one, and/or
address the rest and consider this as a build bug report (for `make W=1`).

-- 
With Best Regards,
Andy Shevchenko


