Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2B7B68F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjJCM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjJCM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:29:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F5683;
        Tue,  3 Oct 2023 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696336150; x=1727872150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pc75A29Qr+v2GGHyvOoeOlvXcO2Uz5k6FAnU6RIw6NA=;
  b=g3E/kbMJHIUl+pMuL/VQqKMr+TFXnkHK7GRrnuTwlsP6bQ3YJliajHmh
   nT3Cew9/+0tJj+SXejxTG14RQzW2foilfX7S/tTu2ZY6lSN3y48+IJilG
   GgkrWfytiprAaczHMEeBiLID5RHCla13vwd33GAI2h9E4zh3jKYLmUfoj
   Uj1Ts82bEc5Q8Sq13XjgC9YxxseziXIYnZUnfWZ+HTby93E0Vv5QsvS8S
   tUWjIGv+UIh7U27MBhcLNatwuivZfFmBM8DBtXeRJXH4Lx/8ekkddlxN9
   so3Rh1cpzQkUai5hfqOAj4OlBdbzH47g2fMoqTfcsELn+noU/VHEURMhZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381741729"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381741729"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="750908596"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="750908596"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2023 05:29:08 -0700
Message-ID: <164ea72d-9d73-5751-a67a-bcf40c351743@linux.intel.com>
Date:   Tue, 3 Oct 2023 15:30:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v1 03/10] xhci: dbc: Use sysfs_emit() to instead of
 scnprintf()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231002161610.2648818-3-andriy.shevchenko@linux.intel.com>
 <202310030150.M1SfrYmG-lkp@intel.com> <ZRvVyN7A/AWoZLj5@smile.fi.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ZRvVyN7A/AWoZLj5@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.10.2023 11.50, Andy Shevchenko wrote:
> On Tue, Oct 03, 2023 at 02:03:53AM +0800, kernel test robot wrote:
> 
> 
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/usb/host/xhci-dbgcap.c: In function 'dbc_show':
>>>> drivers/usb/host/xhci-dbgcap.c:926:34: warning: unused variable 'p' [-Wunused-variable]
>>       926 |         const char              *p;
>>           |                                  ^
> 
> Indeed, forgot to remove it...
> 
> Mathias, tell me if you want a v2 of this patch or the entire series.
> 

No need, I can fix this while applying

Thanks
Mathias
