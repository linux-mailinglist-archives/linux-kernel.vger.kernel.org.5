Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D63752FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjGNC54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjGNC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:57:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344542D61;
        Thu, 13 Jul 2023 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689303473; x=1720839473;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tkvgh+OdvlZ0aXoaPxIcbLqEf8O6M8/JMk2iz07gXdU=;
  b=JlwmdNv6xDQoOrsFPvj6d6W4eET3fgu4bf70+KmSQ8CNKvOrz6/C2jpr
   xP7W4dgvnn6VAFDEdF2Kn6RzPl3ALmtgdR9k5HSaQ4A6Z22NGCGUpPQ32
   CD+gZxTselkUuveATPNu2kBk2wP9e1w9lE5HMCdaTiEYYOTmZMUPfRgj4
   EVVTo06hbJUa4UG61WIxRlJmisfHEUrb2yrklLWboTZK41rAsv17miaFp
   kFlpKvFmCBG0Y3xsqGWSTPzAWUdfr4+V6wlot040bB1BPA+WJv4N92iul
   G3aD6l1DrcfWxCUm7n3Y0v+110fL+hs7nEMcVKBL6oA0thxewCrgv/aDq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368927127"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368927127"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846303604"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="846303604"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 19:57:45 -0700
Message-ID: <362e4343-dcf1-58fc-7ac9-756c65bb0df6@linux.intel.com>
Date:   Fri, 14 Jul 2023 10:57:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, opensource.kernel@vivo.com,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v4] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
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
References: <20230713072825.10348-1-duminjie@vivo.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230713072825.10348-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 15:28, Minjie Du wrote:
> debugfs_create_file() will return early if smmu->debugfs is an error
> pointer, so an extra error check is not needed.
> 
> Signed-off-by: Minjie Du<duminjie@vivo.com>
> Acked-by: Thierry Reding<treding@nvidia.com>

Greg keeps reminding that no error branch for debugfs, so

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
