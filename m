Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1E7EC13F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbjKOL01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjKOL00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:26:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F48E6;
        Wed, 15 Nov 2023 03:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700047583; x=1731583583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z2E5AcoTrvSa5rjaVB/BAkawLEL0OlmMAZPvBPVZRio=;
  b=MQc/HJHbXr9jy46bbxu7oQ1o6JglXWWHgSrPyQ57z6ZhkfNKDlhA2mWg
   sibJWOHEYvuBQ6ZjcDvv01cPiTIT9dwj/llI1WyaAlruuTjhHo3BguiTb
   Ib96o51B1z7NZWR+7b5PTaEDS639obKAPCU1Z1MG7pBucp6nEDi0S7wtw
   4Ohq2gpb2UC9wXKOEV3KmsbeJElfTt69M1APVguP9GqS4l7W/ERM173m2
   i1Z98Ycc33sxQQyLDeEqcDDmOkz245rVPGrhEipvMo6MS3k5Ll4itvtgb
   tSW7CxdEPQmwstykUec83dBX25+hEu25jh1O9xrEuLJKnI0IL0FNUrccP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394775441"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394775441"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="855620600"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="855620600"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2023 03:26:19 -0800
Message-ID: <723e37cd-0083-4548-b3ed-c2ae67b9f945@linux.intel.com>
Date:   Wed, 15 Nov 2023 13:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/25] i2c: designware: Fix reset call order in
 dw_i2c_plat_probe()
Content-Language: en-US
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
 <20231110182304.3894319-4-andriy.shevchenko@linux.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20231110182304.3894319-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 20:11, Andy Shevchenko wrote:
> We should not mix managed calls with non-managed. This will break
> the calls order at the error path and ->remove() stages. Fix this
> by wrapping reset control to become managed one.
> 
> With that start checking the rerurn code from reset_control_deassert()
> as it may fail and calling assertion in that scenario is not always
> a good idea.
> 
> Fixes: ab809fd81fde ("i2c: designware: add reset interface")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Again, was above commit so broken that this patch qualifies a Fixes tag?
