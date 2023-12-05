Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E38805356
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442196AbjLELsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347020AbjLELsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:48:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5AC6;
        Tue,  5 Dec 2023 03:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701776917; x=1733312917;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tu9aT/t0BHn27WrDh0oV0hR16aqvtEcIOAzFAbAEk18=;
  b=WFxZb0/7j0ipKoqi71O51T+ND3wxxQy6fd6gVKbkwfQTzXJ1N/VKARpM
   02eyF21XTxmleTypMBzDCZ7YIqK/nz9yzaGG6KUYUIgcG/0Z+62kTXOxW
   wOlt3ICqtmwPET8irRJ2/7Pe3f5K3wP37I3buLkXULnfildAgV/QAoNb+
   TcJqAOe2wHHlwpG8nz8XOPFOzEti/FU/E8RBsrmO+JKQ7EqOmByllfMPw
   APdqjdJKIK3SOWoI84Yhy1MmpxGm9LfksHUriKul55xvwoTUx9P0Z4iOC
   ZQxWO+C8Bp1XegiJk9A9p55G+7Sc3tQVcjvzzpJSuiOuH2CgBtsTMngaX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="393616365"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="393616365"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:48:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944237154"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="944237154"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.68]) ([10.255.31.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:48:25 -0800
Message-ID: <20602544-5b69-48be-bfa2-d08a21803d84@linux.intel.com>
Date:   Tue, 5 Dec 2023 19:48:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/12] iommu/arm-smmu-v3: Remove unrecoverable faults
 reporting
To:     Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-3-baolu.lu@linux.intel.com>
 <4593a682-b33b-4284-b94c-7f7fd9351171@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4593a682-b33b-4284-b94c-7f7fd9351171@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/4 18:54, Yi Liu wrote:
> On 2023/11/15 11:02, Lu Baolu wrote:
>> No device driver registers fault handler to handle the reported
>> unrecoveraable faults. Remove it to avoid dead code.
> 
> I noticed only ARM code is removed. So intel iommu driver does not have
> code that tries to report unrecoveraable faults?

Yes.

Best regards,
baolu
