Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B487645FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjG0FqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjG0FqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:46:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F12D42
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690436718; x=1721972718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HwAWVBPhPifYPtR9YPCU/MvGfTwewwbPzIRftArYbaE=;
  b=J7cndJ4vdedkaO/skkHXNBkbCWxZM8wxvsChy1EJP8/nnIQIRaKEFee9
   +KWTEjSNycCmqDoiq03To9JRDvtm9qrEFE2fsTXsBvmy2DVP5PRRbol77
   K0vZyE6uwJj/U44ymu3mIxRUr0XbrC7IIdPK4GP/PhR62qTIdPIDUcfMN
   yPkChF4sFMLD5sUzl/aiQoKDmgza2s6QDcjZNqeKmIDQG8JzsaMTQuO1c
   RHuYtrh081FRUHBE5ZOFTrupUN66SE+sGes3doPbkK4uNJoAYEGBVyqju
   eIhWVaN7W95h4DauP/ZZgsKZFjhfqov+RKtzq71haN3wd1Td0GqkXLWvI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371821131"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="371821131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756522634"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="756522634"
Received: from mseillie-mobl.ger.corp.intel.com (HELO [10.249.37.247]) ([10.249.37.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:41:55 -0700
Message-ID: <bbf9baf1-d55b-b846-740f-1ed8976b82b4@linux.intel.com>
Date:   Thu, 27 Jul 2023 07:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
To:     "Liao, Bard" <yung-chuan.liao@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
 <ff55e63f-1c17-12ef-57e6-144a5bea4480@linux.intel.com>
 <CY5PR11MB6257FF6D92D524D389B734C19701A@CY5PR11MB6257.namprd11.prod.outlook.com>
 <c1aadbcf-78ab-0566-84e5-8eaa7b418d50@linux.intel.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c1aadbcf-78ab-0566-84e5-8eaa7b418d50@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 5:21 AM, Liao, Bard wrote:
> 
> On 7/27/2023 10:14 AM, Lu, Brent wrote:
>>>
>>> max_98390_components[] and max_98390_4spk_components[] are still used
>>>
>>> by sof_rt5682.c, we should remove them in the same patch.
>>>
>>> Maybe combine the 2 patches together?
>>>
>>>
>> I've got your point but these two patches are doing two things: one is 
>> refactor the
>> code and add a detection feature, the other one is removing the quirk. 
>> Not sure if
>> it's proper to merge them.
> 
> The point is that if you remove them and they are still used somewhere,
> 
> you will break the build. i.e. Kernel will not compile if we apply the
> 
> first patch only.

IOW git bisect is broken and that's a big no-no.

