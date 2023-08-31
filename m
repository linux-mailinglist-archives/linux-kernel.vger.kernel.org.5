Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE978E4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbjHaCGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjHaCGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:06:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CFA83
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693447610; x=1724983610;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l68MXTZpDoORzO6V1cBKJfBxtTQt3jnhWIQZc2YuyFU=;
  b=bRBYLTOBnVWjnNmk8KTNcLO2HTB5cM0I73uWUo6bMeAbQMMVfS4spDyR
   Uf770OByMqMsmGXhTkEWLTNGLq1d0Yci0V3s1kUOlPh1EPQ4jrzjWLphQ
   nSbVi+BKYdv6uAzIMhnZwN6vFqSbiG+2kQnpYp8HIE5mdzn76T1tGynue
   p3DeBeZghYnudXxniX9J8XkOLXVem9wTnCZBTPrvU/yRIftEKCHl50e2V
   Cb81GcRmc3yGxxWaNtpARm/xrCFXPuKmI2nZV73xsuSg7KVsqco0N3h5d
   eUfWdIog3e1JmDAut7zv7AclFXtiQzXPjIWTo71/UicL1Keebsu8HVpzk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360781317"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="360781317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="913033711"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="913033711"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:06:48 -0700
Message-ID: <e16f2963-9748-7461-ca8e-d0b46a34330c@linux.intel.com>
Date:   Thu, 31 Aug 2023 10:06:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iommu: Add mm_get_enqcmd_pasid() helper function
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-2-tina.zhang@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-2-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/27 16:43, Tina Zhang wrote:
> mm_get_enqcmd_pasid() is for getting enqcmd pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.
> 
> v2: change mm_get_pasid() to mm_get_enqcmd_pasid()

The change log should be moved under the tear line.

> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   arch/x86/kernel/traps.c | 2 +-
>   include/linux/iommu.h   | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
