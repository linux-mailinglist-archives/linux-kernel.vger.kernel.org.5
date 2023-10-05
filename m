Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EA7BA1B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjJEOm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjJEOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A508A60;
        Thu,  5 Oct 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514613; x=1728050613;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Q31/LRmUHPnliZEY/I/TLopH3gR0VgvYKU2xCR9wHdI=;
  b=lHxgyD75DyxfxW/IPUBZwq1e8wyGDpb5Nkd+TXjwWlDsFq+RqmeK2F3l
   PqpY45fys0ZcNX9kYesXh2XgLcjqrI0dwhV4Y74fZP3YvTreKwQNwdR+c
   60ENcGGsA0SQ6Ax/EHpEzVMrZC6qEn+DwYaG+FJWJMWXWwduaYbMYMVjK
   yy/iC0HC4fG1rk4WZ8D2DsEh8zrx7iVLk6SdUpcEJBGI1SrCKRzfLIKTa
   jXmE/fzjlvLmeUpwfN9su19KDjSglFbO8y6S+PPs62IrfrAKJtcgaRQaa
   BHq9lyj5NTxe7qd/lCcX44Bhs/A7XTHPFWVTieJv5+M3oSk526yIxiVqw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="382347791"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382347791"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="822089057"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822089057"
Received: from akesselm-mobl.amr.corp.intel.com (HELO [10.212.122.181]) ([10.212.122.181])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:24:40 -0700
Message-ID: <c7fb4ead-13af-438b-a199-c52105545047@linux.intel.com>
Date:   Thu, 5 Oct 2023 08:24:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
 <2023100452-craziness-unpopular-7d97@gregkh>
 <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
 <d648c3d1-53ac-4021-ac7f-6a81f1a72dd3@sirena.org.uk>
 <bf4ee895-293f-4bc3-ac4b-30df6361e973@linux.intel.com>
Content-Language: en-US
In-Reply-To: <bf4ee895-293f-4bc3-ac4b-30df6361e973@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> I think we keep circling on the differences between "Controller" and
> "link" (aka bus). A Controller can have one or more links. A system can
> have one or more controllers.
> 
> Intel platforms have one controller and 4 or more links.
> QCOM platforms have one or more controllers with one link each.
> 
> I am not sure how this IDA-generated bus_id helps deal with these two
> cases, since we can't really make any assumptions on how
> controllers/links will be started and probed.
> 
> What we are missing is a hierarchical controller/link definition, IOW a
> controller_id should be given to the master by a higher level instead of
> using an IDA.

Tentative patches to introduce a 'controller_id' that's not an IDA are
here: https://github.com/thesofproject/linux/pull/4616

Initial results are positive for Intel devices. it *should* work for
other devices but I can't test. If folks at Linaro/Qualcomm and AMD can
give it a try, that would be much appreciated.

Thanks.
