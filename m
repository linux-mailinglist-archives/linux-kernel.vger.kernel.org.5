Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DA7EF44C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjKQOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjKQOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:18:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC520D4E;
        Fri, 17 Nov 2023 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700230697; x=1731766697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n8a3frJ+c4ycX1Uta+3lEgUlnjIE1SdkmtkrM452bKc=;
  b=oIymag3HLU+u/isl/AOAdSdWiWUXE3NJnqjb9e6tPZOxxgh9R8AgcN5l
   B/cMtUCDexEPiv5cmQiYY6aQyLMnRBHi44JIfXD7kqJVrNUGUs2TMGj2s
   6GuIWc3ZdwJauikePIqqTH8Q6I2ab70F/sCoaLUSyoCCaQkZqN0Y8z9DD
   MhWs6gzTA93vZ40GE8MDNLc3cZWwADfa7cru5DN+Aq1nLS8Mu3+piua6T
   nKvPuwmWGVhvPGD/4nWK4TxArQCXygSZRKrVApQnqfogBNNZERgOj3RxD
   RMmwlq4fnvxXU4tbxFvugxxP/R8QEOfpIBAJ61BQzHxcYAHe/kLYvNWEO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="394154592"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="394154592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 06:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939159997"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="939159997"
Received: from unknown (HELO [10.237.72.75]) ([10.237.72.75])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2023 06:18:14 -0800
Message-ID: <a6df86e7-e7e9-4acb-b6f2-0dde55884433@linux.intel.com>
Date:   Fri, 17 Nov 2023 16:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/25] i2c: designware: Unify terminator in device ID
 tables
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-11-andriy.shevchenko@linux.intel.com>
 <382a9f86-f907-4432-9580-3a1b1b449121@amd.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <382a9f86-f907-4432-9580-3a1b1b449121@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 21:38, Mario Limonciello wrote:
> On 11/10/2023 12:11, Andy Shevchenko wrote:
>> Make the terminator entry look the same in all device ID tables.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Sorry replying twice, wanted to make sure Mario's tag is noted.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

