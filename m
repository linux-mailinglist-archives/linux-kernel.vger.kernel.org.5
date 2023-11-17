Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA27EF3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjKQNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjKQNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:51:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A728D5C;
        Fri, 17 Nov 2023 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700229114; x=1731765114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pEsKlmnkqCWZpqFrSXX4D1/w32UW8X9e4STEAxDy0aE=;
  b=jLqcGZ+aYkel1ue9rrosOwZewUvZ/InwohZQTMF73NryTYBtj2bkF/vT
   X+G0xQc9hcAAqP9s8FgfwJ4QVv+sbWY8Exd3ZBuxlHPWpUtrL80NR82wy
   9LNPrMNcm9QIY1wmbrp3VNcEVnDrpROsyQhlWmmCYoH8PmBg8C8DOotYH
   H63s1JyEtWE5Q3ZTBBWhpohjzBK4RjArAVfoXCvw9FSQ6GvQjbRO41j57
   xpyX1R97tW8XnZ1j9BIEbSmzI7e4A0Huf2kTsb9xwoM30IlkjFWey1DCk
   eGHCcC/hNZeePNTxwtzzxjFPcqlWbZ6YMjNrerkKur9huNygcxcUe0NjY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12849772"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12849772"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="769226515"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769226515"
Received: from unknown (HELO [10.237.72.75]) ([10.237.72.75])
  by fmsmga007.fm.intel.com with ESMTP; 17 Nov 2023 05:51:50 -0800
Message-ID: <37222b67-ae8e-4b97-aa5e-5783c30dbf95@linux.intel.com>
Date:   Fri, 17 Nov 2023 15:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/25] i2c: designware: Replace a while-loop by
 for-loop
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-7-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20231110182304.3894319-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 20:11, Andy Shevchenko wrote:
> Replace a while-loop by for-loop in i2c_dw_probe_lock_support() to
> save a few lines of code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
