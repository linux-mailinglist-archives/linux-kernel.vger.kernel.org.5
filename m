Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414A77C7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjHOGdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjHOGdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:33:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF3E13E;
        Mon, 14 Aug 2023 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692080462; x=1723616462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pm2/JTgk01VjsV74yulkiEQJr2mi35KIhpGzr41SnaU=;
  b=DFQVa5/7P6oCsrK2BYrrnJqXBa7beFYE8X38z/8q2KMCYDKv++1Q+P/t
   51genohud00/WdPniQ4zpupUTrUjzv0cuulgfuNCpdERZU0MvgPap6iYK
   okaEsWL7/Y8U5EiI8+RLBDCHyu0FOIKaPC0EFmrf6UjgNQE8TLdxT+Ve+
   uKMS8SKre/S2jq6IylhMKb8/H3YSs8XxaX0pQT3v+fIIadejHjjaJ/tf9
   j1YIADqgvrl2e3+XhBqDjx3Lx53HDNxGQZxY3XkrYvIzWUlQUdetEJ2r1
   x5JtgnR0ivm9AxQ9IEfktZvjtzzWzIHIFuOXDt3vKfRVyIwBBs0ciQohz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352536255"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="352536255"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823729702"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="823729702"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.51])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:20:59 -0700
Message-ID: <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com>
Date:   Tue, 15 Aug 2023 09:20:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH V2 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230815014057.13589-1-wenchao.chen@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/23 04:40, Wenchao Chen wrote:
> Change in v2:
> - add mmc_sd_switch() and mmc_send_status() to the header file
> - split up core changes from host driver changes
> - Use pr_debug instead of dev_info and dev_dbg
> - Optimize the best sampled value algorithm

What about hooking ->set_ios() as Ulf suggested?

> 
> Wenchao Chen (2):
>   mmc: core: Add host specific tuning support for SD HS mode
>   mmc: sdhci-sprd: Add SD HS mode online tuning
> 
>  drivers/mmc/core/sd.c         |  12 +++
>  drivers/mmc/core/sd_ops.c     |   1 +
>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h      |   8 ++
>  4 files changed, 173 insertions(+)
> 

