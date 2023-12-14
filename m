Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD881242A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjLNA6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNA6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:58:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE511DB;
        Wed, 13 Dec 2023 16:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702515536; x=1734051536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w4CvfAEx5Otr1z8ctNIsiiCXmkHh9thOmbmC19YRFYY=;
  b=izM2IfdXp1DUVRrlv+F/kBhdfqewhqTf7XFzrisG6VALGpmxyAwrOelh
   4D7SQeYWxbVKNfLctQz1ZZ2ttBOuO2XPno389RVKCxMecdgARZZSpy4N3
   fYYULyhChYkSC+qjvqW5a8ncYZIlGCOTxe4mM+dVi/NffJeMU9EjUxqvG
   LdW7uMEyBLy40A0ea1piY5N5P765eZyNjfKBd+okJBg7/r31dutlHVVCC
   B2gGyKjn/hR4mlsAGJOZRgAiLP8tYpGbP94A18CWpfBW1lhpLcziXeNxE
   7P4wd1MMAMQ253vlG+Zoz+ZudxdqnrLZrtILNeAECwexcBUA91oUokYzt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481246314"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="481246314"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750326235"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750326235"
Received: from jiqing1x-mobl1.ccr.corp.intel.com (HELO [10.254.210.186]) ([10.254.210.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:58:53 -0800
Message-ID: <31bd82b6-6f7e-4dc4-8cbb-46fa806d699f@linux.intel.com>
Date:   Thu, 14 Dec 2023 08:58:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public for
 other drivers
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
        will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
 <20231213104930.GB31964@wunner.de>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231213104930.GB31964@wunner.de>
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


On 12/13/2023 6:49 PM, Lukas Wunner wrote:
> On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
>> move pci_dev_is_disconnected() from driver/pci/pci.h to public
>> include/linux/pci.h for other driver's reference.
>> no function change.
> That's merely a prose description of the code.  A reader can already
> see from the code what it's doing.  You need to explain the *reason*
> for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
> so that it can be called from $DRIVER to speed up hot removal
> handling which may otherwise take seconds because of $REASONS."

Yup, why I made it public. then how about

"

Make pci_dev_is_disconnected() public so that it can be called from
Intel vt-d driver to check the device's hotplug removal state when
issue devTLB flush request."



Thanks,

Ethan

>
> Thanks,
>
> Lukas
