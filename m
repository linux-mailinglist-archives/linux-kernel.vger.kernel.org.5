Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3F754704
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGOG2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOG2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:28:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189F2726;
        Fri, 14 Jul 2023 23:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689402481; x=1720938481;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4dw5jTyrhJfmTFYFax04Yvl6K/d06zT/oytzRcJ5aA=;
  b=E7CgKL41W84x7OUnZcsK5BLzZGK2jtiUrgPT7XmpD8LCbYrp4ekMvQM8
   gn42Oqz6u9iL3q5mhmfK//UYs73CY1RpZuDKiFfNotAA/eF1nFwBoD+zP
   DDmrqiPxFj86q1VmPWrUkP68YwwLw6+utfoQbJIfraP8UV22+RnfaHpip
   xgP7lh0YwCuYg5HEM+sFL4yJt+dHn79+OAl+AnMJLwXklhL+oYpvdlBnG
   qMoxHMSz6G1rmVIJGuYZIX3fM6NIfxcv0Sv/KAEJm3yGBX9smZrWgMJBB
   w3ARsi6RbmOQ7SXctUCZ1OALgq1ECrI6wLnbI5McfWGqRMzOTC6KjCjuw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345949299"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="345949299"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 23:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812680999"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="812680999"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 23:27:58 -0700
Message-ID: <db554c27-f663-0146-5e5f-b319547757c3@linux.intel.com>
Date:   Sat, 15 Jul 2023 14:26:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, opensource.kernel@vivo.com
Subject: Re: [PATCH v5] iommu: Fix an error check in tegra_smmu_debugfs_init()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20230714081320.1998-1-duminjie@vivo.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230714081320.1998-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 4:13 PM, Minjie Du wrote:
> debugfs_create_dir() function returns an error value(PTR_ERR).
> We need to evaluate the return value using IS_ERR,
> rather than checking for NULL.
> 
> Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
> Signed-off-by: Minjie Du<duminjie@vivo.com>
> ---
> V4 -> V5: debugfs needs to have error checking, so use IS_ERR() to error check.

Why?

[...]
  * NOTE: it's expected that most callers should _ignore_ the errors 
returned
  * by this function. Other debugfs functions handle the fact that the 
"dentry"
  * passed to them could be an error and they don't crash in that case.
  * Drivers should generally work fine even if debugfs fails to init anyway.
  */
struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
{
         struct dentry *dentry = start_creating(name, parent);
         struct inode *inode;

         if (IS_ERR(dentry))
                 return dentry;

[...]

Best regards,
baolu
