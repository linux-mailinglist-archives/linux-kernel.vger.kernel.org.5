Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5680BA1A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjLJKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLJKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:10:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35AF1;
        Sun, 10 Dec 2023 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702203011; x=1733739011;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5FnYIJIbR+wsxAQWvfQ77OzwqLrChyDizMkLcyyll9A=;
  b=Q31NgcN20hkOofpjbnhNl2dC7wPfr432SIuT8GV0SazKaE/DBm+WOqbQ
   7VEtmP3FOjenLbFOlf15iaU4QzyRy9xJ5/v5rQ3gP241CGau8ibhBTiMT
   hnlXQyAf/b40q6CM8klg17me5qTdfYeTK2M7X9fxQxHsoDA1ilpKM1dPU
   jYi70s4yNOMI57JJZ02nPmlfBfGm4mpdt/olcg07Bt0rbTTltWYRRy/WF
   /Z6TL91ROtk8if/vIF6RfqPJm9tS9C2wHT30pSszkycf9FceNXUEfEL2s
   cfsv7eSp/Tu4jsQQI08QunVadKdr+It95+FDEs8zKMdQAoaX1A/+AyEH9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="384957266"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="384957266"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 02:10:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="722391237"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="722391237"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.251.181.21]) ([10.251.181.21])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 02:10:06 -0800
Message-ID: <b75fb89e-2016-49fa-912f-6121976c294b@linux.intel.com>
Date:   Sun, 10 Dec 2023 12:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v4 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW &
 FIELD_GET() instead of custom defines/code
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-kernel@vger.kernel.org
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2023 14:34, Ilpo Järvinen wrote:
> e1000e has own copy of PCI Negotiated Link Width field defines. Use the
> ones from include/uapi/linux/pci_regs.h instead of the custom ones and
> remove the custom ones and convert to FIELD_GET().
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/net/ethernet/intel/e1000e/defines.h | 2 --
>   drivers/net/ethernet/intel/e1000e/mac.c     | 7 ++++---
>   2 files changed, 4 insertions(+), 5 deletions(-)


Tested-by: Naama Meir <naamax.meir@linux.intel.com>
