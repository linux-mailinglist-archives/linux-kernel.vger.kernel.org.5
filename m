Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527438110A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378199AbjLML7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjLML7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:59:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96743D5;
        Wed, 13 Dec 2023 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702468787; x=1734004787;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZPVp3ETxXIxALqF5k4Z5/m0QF1K6hbpGTk+sb7wheQ0=;
  b=FHljVL0pX72GImrS7YZAZ66m5GI1du07nvfUUJCB9+51amNjaagQ51As
   NcLSxei4QAD8xNS3zAwBkjmYIUsNiGEM0O13Hs6i9Eb98zxWmQheOCHOJ
   BJ8QKhxhkxQxtNmx4KfVcFVbTeHEdXKSWQ+7Y+lf5/BmPyq7HNqfCWMMI
   COHL3cVJXpkVqogh4y9dAplD8XWpM90gQKVSOQW29Y+SNjg3uhXNYBBDD
   8AiZ3InbGNXMbF675uC52kdrTHoTA/0AWsbe28MrpNCK8HZzkdAXE0VZK
   ht8sUfx+1aIuqJu0tR4BO1YSHAxQhxnG/CeRhLuwu97ZECcOLqZCy/Zu5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1808504"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1808504"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839837065"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="839837065"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.246]) ([10.254.212.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:59:44 -0800
Message-ID: <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
Date:   Wed, 13 Dec 2023 19:59:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
        dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/13 11:46, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register, as pciehpt_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off.

Is it possible for pciehp to disable ATS on the device before unloading
the driver? Or should the device follow some specific steps to warm
reset the device?

What happens if IOMMU issues device TLB invalidation after link down but
before pci_dev_is_disconnected() returns true?

Best regards,
baolu
