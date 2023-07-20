Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B998A75AE74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGTMcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjGTMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:32:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F52700
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856295; x=1721392295;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PPjb1efpNVs+0C/3htOuyu3cb1OjDpfvMZWKs6Ysk/Q=;
  b=GpLUV1BOpu2nnSM78hZwY+7q2nokPgcUVdPGNFUPGY094wU/kLdqzbnv
   9fOiMw1/X3YtO320g5B3As5nwc4VKC6KrDB3GXKxQILBnkfS6GvkYLL2i
   pMSaSwriTgJ1XWt7tXo9NWel7eLaQBGC6lxN9QpJa5mNL9gJBpRjH6MVt
   ctM6r0n9fDKOhO6VdbuuWsKP3Nmvcrc27sl6F6irqDOcWZFiY7Y4Jdjzd
   rujdJY2b6vTHSbpzwCk1T6RpSsYhf2bkBAV7R9oKCXtg1PcI6RAFGehbB
   FXoHacFr5zFNZh6djTgGTRup70VffV6B2eQqymi1JaKD9jju6Hyn9f8rb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430484823"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="430484823"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848430629"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="848430629"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:31:23 -0700
Message-ID: <45d32e95-9d57-a424-63bd-b894cf0d3a2b@linux.intel.com>
Date:   Thu, 20 Jul 2023 20:31:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Content-Language: en-US
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
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

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> +static void riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain,
> +				       unsigned long iova, size_t size)
> +{
> +	unsigned long end = iova + size - 1;
> +	/*
> +	 * Given we don't know the page size used by this range, we assume the
> +	 * smallest page size to ensure all possible entries are flushed from
> +	 * the IOATC.
> +	 */
> +	size_t pgsize = PAGE_SIZE;
> +	riscv_iommu_flush_iotlb_range(iommu_domain, &iova, &end, &pgsize);
> +}

Does RISC-V IOMMU require to invalidate the TLB cache after new mappings
are created?

Best regards,
baolu
