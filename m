Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F837C7CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJME0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJME0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:26:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4943B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697171197; x=1728707197;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mZ+2rpTM3/mzvP3ekfm+ZTaIUCQECAeFuhaWR/OeRYk=;
  b=Jm44ktN0k9mv4hlMbw3lRB7ltVgDYdeNgc+OCgqgf+YLM8hp1d2NUZKO
   DylaZKKbdj8EfkpffXDrPq+oRphnCtUGCbAjhjR/358jongiVFwSbUaiE
   oPzzCDsiBqabVGP50p/WWmiotjY9X1Z7CIrspBb2nuLREVkS2iEZPQ5Ik
   K3K3e8FzNqyam5Bmnju3pw1SqX1WodsUf41Y6OOSQ7hsJ0t8XSRJxRB4S
   Nlmyapc/fU2wXKneIrOvIOMtii9TMX+wXuEOENErKMe7QfcHluOYRXjRK
   6Nz68a029TenUK5iH0148lzn0Vn1wc2gdTgoDm6R7ib0GZ4Q+w3OPCyT4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387956829"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="387956829"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 21:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878390076"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="878390076"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2023 21:26:34 -0700
Message-ID: <5baa8c11-806c-4937-819d-a3b99a07c690@linux.intel.com>
Date:   Fri, 13 Oct 2023 12:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATH v4 0/3] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Content-Language: en-US
To:     Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
        Tian Kevin <kevin.tian@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20231011083915.36706-1-Jingqi.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231011083915.36706-1-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 4:39 PM, Jingqi Liu wrote:
> The original debugfs only dumps all IOMMU page tables without pasid 
> supported. It traverses all devices on the pci bus, then dumps all page 
> tables based on device domains. This traversal is from software 
> perspective. This series dumps page tables whose mappings are created 
> and destroyed by the iommu_map/unmap() interfaces, by traversing root 
> tables, context tables, pasid directories and pasid tables from hardware 
> perspective. It supports dumping a specified page table in legacy mode 
> or scalable mode with or without a specified pasid. It adds a debugfs 
> directory per pair of {device, pasid} when attaching device with pasid, 
> i.e. /sys/kernel/debug/iommu/intel/<device source id>/<pasid>. And 
> create a debugfs file in the directory for users to dump the page table 
> corresponding to {device, pasid}. e.g. 
> /sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct. 
> For the default domain without pasid, it creates a debugfs file in the 
> debugfs device directory for users to dump its page table. e.g. 
> /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct. 
> Remove the corresponding debugfs directory and file when detaching or 
> releasing a device. For legacy mode, according to bus number and DEVFN, 
> traverse the root table and context table to get the pointer of page 
> table in the context table entry, then dump the specified page table. 
> For scalable mode, according to bus number, DEVFN and pasid, traverse 
> the root table, context table, pasid directory and pasid table to get 
> the pointer of page table in the pasid table entry, then dump the 
> specified page table. Examples are as follows: 1) Dump the page table of 
> device "0000:00:01.0" that only supports legacy mode. $ sudo cat 
> /sys/kernel/debug/iommu/intel/0000:00:01.0/domain_translation_struct 2) 
> Dump the page table of device "0000:00:02.0" with PASID "1" that 
> supports scalable mode. $ sudo cat 
> /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct

This series doesn't apply to v6.6-rc5. Can you please rebase and send a
new version?

Best regards,
baolu
