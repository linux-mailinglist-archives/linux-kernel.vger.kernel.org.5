Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CD774FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHIAb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHIAb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:31:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FA1995
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691541085; x=1723077085;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AywbTO27cVNl/fazmIprghWONbtmeCSn9y1uvPUIl/k=;
  b=CrWvs1/DGrBYu4jtZoVVJBdoWIF5hvF66q9K7uR9/5dbpfwMdNZarQ39
   xReqgL5E2X2OkhxtNiD+ovW/inAimwIw/MueV3t99p6oH0bhlp1Rqc5ai
   rye0REj0oq9oumzUodKqPRa1ZxSQcR54N6B87mBiyhjWRBfQLc6yb/eVZ
   iFxnw2s5kuVA95ONiEHxhlWrjJt8LZk0CTleDtctoG8JczecQQ5eseO2w
   PdYgY70nLAFw6jsMqSDKOjxB5KBaJF2vmAQ0QS9dm2iHOyvIUvEiwLG7X
   D9IA4QMc+/h9Cyo2PxTMA9T63CLcQTK9Ta0eGe6OrS0kSwzjOp2/R/RQG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437353070"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="437353070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725156738"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="725156738"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.46]) ([10.249.169.46])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:31:23 -0700
Message-ID: <8ed60665-fb1c-cf94-ea24-5f43ce8c9903@linux.intel.com>
Date:   Wed, 9 Aug 2023 08:31:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com> <ZNJY/9pwRxIkFEjD@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNJY/9pwRxIkFEjD@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 23:02, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 03:49:40PM +0800, Tina Zhang wrote:
>> mm_get_pasid() is for getting mm pasid value.
>>
>> The motivation is to replace mm->pasid with an iommu private data
>> structure that is introduced in a later patch.
> Maybe we should start out by calling it what it actually is:
> 
> 'mm_get_enqcmd_pasid()'
> 
> We can't actually have multiple SVA domains with different PASIDs
> until the places wrongly calling this are removed :\
> 
> eg, I would expect this series to also come with removing
> 'pasid_private' from the Intel driver.
> 
> The mmu_notifier should be placed in the singular iommu_domain that is
> the SVA domain for the mm. Drivers should not attempt to de-duplicate
> this, the core code will do it like you are showing in this series.

The two tasks mentioned above are part of our plan. They will be
conducted in stages, which is more conducive to review and testing.
This series is just the beginning.

Best regards,
baolu
