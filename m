Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21A7B8CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbjJDTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245001AbjJDTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:06:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66BA26B;
        Wed,  4 Oct 2023 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696446044; x=1727982044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+7Kuxlc0687hSqhXVR358o6+jlXhpr+b6WxOI4qYX08=;
  b=Pbzo5QaBpQQU2HWem31b1l7Kr+1k1Riepx0VrrZ6c8J9a9nkcCN97Rdi
   jI2tJZfVMbDh5kpDW77jIStXGP1rdl1vkx6ypcfsmqu9oFAqZNZKf0Tla
   JuMmlgo5/S0R6IGLaGiI8HPGr9VwzSkNT6G55eqfdsAhFBbtiWFmzBc1R
   UG+90I11wTu7v5zUTWrCXrvTB0m0cE0dCi3nGYT7IXznYrpuORGX7uSIG
   Htecpx+VXcg7SRSYeslaE3CpiqIM+MhK0zKzXK5/ISXifadbrUQShcVd0
   mIYU2y9OYlZenW0OYdY6ZSUlPIcy9jN04NpMiJY0mOkMcs3ZHK+Hpt4uK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383175704"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383175704"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 12:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="751445426"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="751445426"
Received: from mfmousa-mobl1.amr.corp.intel.com (HELO [10.212.98.56]) ([10.212.98.56])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 12:00:41 -0700
Message-ID: <bf4ee895-293f-4bc3-ac4b-30df6361e973@linux.intel.com>
Date:   Wed, 4 Oct 2023 15:00:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
 <2023100452-craziness-unpopular-7d97@gregkh>
 <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
 <d648c3d1-53ac-4021-ac7f-6a81f1a72dd3@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d648c3d1-53ac-4021-ac7f-6a81f1a72dd3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 11:40, Mark Brown wrote:
> On Wed, Oct 04, 2023 at 11:16:09AM -0400, Pierre-Louis Bossart wrote:
> 
>>> matching the name is fine (if you are matching it against an existing
>>> name) but expecting the name to be anything specific is not going to
>>> work as the name is dynamic and can/will change each boot.
> 
>> Not following, sorry.
> 
>> In the SoundWire context, the device name directly follows the ACPI or
>> Device Tree information, I don't really see how its name could change on
>> each boot (assuming no DSDT override or overlays of course). The
>> platform descriptors are pretty much fixed, aren't they?
> 
>> Intel and AMD make such assumptions on names for pretty much all machine
>> drivers, it's not really something new - probably 15+ years? Adding Mark
>> Brown in CC: to make sure he's aware of this thread.
> 
> FWIW DT is much less affected here since all the inter-device references
> are explicit in the DT (modulo needing to work around breakage) so we're
> not hard coding in the way ACPI so unfortunately requires.

Isn't there a contradiction between making "all inter-device references
explicit in the DT" and having a device name use an IDA, which cannot
possibly known ahead of time?

I think we keep circling on the differences between "Controller" and
"link" (aka bus). A Controller can have one or more links. A system can
have one or more controllers.

Intel platforms have one controller and 4 or more links.
QCOM platforms have one or more controllers with one link each.

I am not sure how this IDA-generated bus_id helps deal with these two
cases, since we can't really make any assumptions on how
controllers/links will be started and probed.

What we are missing is a hierarchical controller/link definition, IOW a
controller_id should be given to the master by a higher level instead of
using an IDA.
