Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19107F4776
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbjKVNO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbjKVNOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:14:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691719D;
        Wed, 22 Nov 2023 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700658891; x=1732194891;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ytXM2Pyec8Qp9LaXAdCOR2oRjgWxjhxu7pHl5+cR+4w=;
  b=gWDJrgxg80wFyJAk7gJGbfT82zmjo81huAQZm5G/euUldKp1KN5uBeha
   Hx5Th8g/7mj3eQrPgGdbEDqz600AGAFfQIasm14Dppa9qtw2iGbmLMJ4A
   qAPq0HkdlDw7lbuJ8/aJ4DjbSHJd6ALMT4CnXcKwZ/glhgzatAoX5jUQh
   Ke2Ortwcefv6o5qLbZ1PzF2gjai1IPoN9SlF11HYhTchSl1EPR9uDxj5w
   MVV7VaSmDpkYvbPGxUjzt/CbniyKK5l8TbXUJ4QBs2dNOBhkJdwOFn+LE
   wdZDZwYYKH3nJEixOHTi5/eZf2J78CiAO+VuRy1LB9C+ygccCywXdmN7A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="390908483"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="390908483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 05:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857728170"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="857728170"
Received: from johannes-ivm.ger.corp.intel.com ([10.249.47.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 05:14:44 -0800
Date:   Wed, 22 Nov 2023 15:14:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v11 3/5] PCI: Move pci_clear_and_set_dword() helper to
 PCI header
In-Reply-To: <20231121013400.18367-4-xueshuai@linux.alibaba.com>
Message-ID: <f2a31d7f-3acc-fbe8-2684-c61f355f1036@linux.intel.com>
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com> <20231121013400.18367-4-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Shuai Xue wrote:

> The clear and set pattern is commonly used for accessing PCI config,
> move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
> In addition, rename to pci_clear_and_set_config_dword() to retain the
> "config" information and match the other accessors.
> 
> No functional change intended.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/pci/access.c    | 12 ++++++++
>  drivers/pci/pcie/aspm.c | 65 +++++++++++++++++++----------------------
>  include/linux/pci.h     |  2 ++
>  3 files changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 6554a2e89d36..6449056b57dd 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_dword);
> +
> +void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> +				    u32 clear, u32 set)

Just noting that annoyingly the ordering within the name is inconsistent 
between:
  pci_clear_and_set_config_dword()
and
  pcie_capability_clear_and_set_dword()

And if changed, it would be again annoyingly inconsistent with 
pci_read/write_config_*(), oh well... And renaming pci_read/write_config_* 
into the hierarchical pci_config_read/write_*() form for would touch only 
~6k lines... ;-D

> +		pci_clear_and_set_config_dword(child,
> +					       child->l1ss + PCI_L1SS_CTL1, 0,
> +					       cl1_2_enables);

Adding clear and set only variants into the header like there are for 
pcie_capability_*() would remove the need to add those 0 parameters.
IMO, it improves code readability considerably.


-- 
 i.

