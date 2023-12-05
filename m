Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C2805BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjLEQ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbjLEPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:25:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94DF9B;
        Tue,  5 Dec 2023 07:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701789940; x=1733325940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xukjuGan3FvwHjC1u8CeuWNpwvGB/cEkfZb7z28+Ess=;
  b=DaaLgCubx2mNY3Rcl2VEbsmXrmYNia9uXH/K1h7ik9UVjhhYUgJOuicI
   gyN/irf5Z6w2Fie8jZvkftsV+ZEVAXNWf9uGUQmIsEllyKF2AY+KH42is
   lDICrfKbp3AuWPZW7ycjpPmULFdJHLRhWmj9q0q5rtIBpvYjkUE+eez6D
   Nrs2icG3w/bUphEiF8H0W+ScSOW/M6+pAdaONBI0S1tgShYR7W8Ld7xuK
   XCOmy6jnVZqDIkVnbbusBOsYA5eWNv/b48d90ln+/o51yIjk73qGtfAiz
   cReBKpc39gmUxZ45aXZTvien6qDI+fRdjEfKDCC8UfGyVC6vsSK13XcRx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12626114"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12626114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="888975313"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="888975313"
Received: from mbapna-mobl1.amr.corp.intel.com (HELO [10.212.151.198]) ([10.212.151.198])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:25:37 -0800
Message-ID: <72bb44a8-dbe6-4fdd-921a-b9fcf798fe3c@linux.intel.com>
Date:   Tue, 5 Dec 2023 09:22:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a speaker
 widget
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20231205135001.2506070-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231205135001.2506070-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 07:50, Richard Fitzgerald wrote:
> Hookup the CS35L56 DAPM_OUTPUT widgets to a DAPM_SPK widget so
> that there is a complete logical path to a speaker.
> 
> There is no particular reason to use multiple speaker widgets.
> The CS35L56 are designed to work together as a set so they have
> all been connected to a single speaker widget.
> 
> Instead of a hardcoded list of codec widget names, the code walks
> through all the codecs on the dailink and for every cs35l56 it uses
> its name prefix to construct the source end of the route. This adds
> a small amount of overhead during probe but has the benefit that it
> isn't dependent on every system using the same prefixes.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We should probably do the same thing for sof_sdw_rt_map.c, there's no
good reason to encode rt1316-2 SPOL and rt1318-2 SPOR
