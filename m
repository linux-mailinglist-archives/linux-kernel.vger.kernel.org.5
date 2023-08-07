Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D32C7719D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjHGGBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHGGBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:01:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849710F6;
        Sun,  6 Aug 2023 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691388070; x=1722924070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwXGk7MRC64IN226GiP0tz9lx55iiVvTRXLYQddOkbk=;
  b=eVO/eF3LjRuB3dareuqbuuo7jYmy7a2zhcQrcdxmbmApEioV+4pTA63r
   C+OgpVBqebhIa2lL3hUBVLCna1ixyI60klvy7U53hDva8kUSCaVBUAeyx
   ETVmSfjXozPExEF/wROmZtnocEu5p7KzTyVhanFpjoYQI2r/25rRjuzh6
   7Jl2fmAIUCYejyaTm6BAO6P8f3PijUnAnuKgFR5xVhkDwDBKU7CzCR2j/
   3dHxuEF2tA99tZwi+yg70CXxeFyoCWtFXVmBU/lM+bjmEaXGIJ0PNVP9U
   X4N4zHn9ghLtBfmd4PPbOvC1JFrwFVgQUFXZVMSrckKwx6fjiLgArvWt1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="374132691"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="374132691"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 23:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="977300981"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="977300981"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.212])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 23:01:07 -0700
Message-ID: <2da6c39d-cfc0-3a93-7968-ec4c1eaef52d@intel.com>
Date:   Mon, 7 Aug 2023 09:01:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Add support for QEMU
To:     jeuk20.kim@samsung.com, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
 <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/08/23 04:37, Jeuk Kim wrote:
> To ensure that the pci based QEMU ufs device properly works with linux,
> register the device id (0x0013) and vendor id (0x1b36) of QEMU ufs device.
> 
> QEMU UFS will enable testing of the UFS driver inside a virtual machine
> on systems without UFS host controller. It can also be used to preemptively
> implement and test new features before the real device is created.
> 
> The new qemu ufs device can be found at
> https://lore.kernel.org/qemu-devel/20230727155239.GA979354@fedora
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you!

> ---
> 
> Since v1:
> - Based on Adrian's comment, I modified the commit message to be
>   more detailed.
> 
> ---
>  drivers/ufs/host/ufshcd-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
> index cf3987773051..29d322931427 100644
> --- a/drivers/ufs/host/ufshcd-pci.c
> +++ b/drivers/ufs/host/ufshcd-pci.c
> @@ -590,6 +590,7 @@ static const struct dev_pm_ops ufshcd_pci_pm_ops = {
>  };
>  
>  static const struct pci_device_id ufshcd_pci_tbl[] = {
> +	{ PCI_VENDOR_ID_REDHAT, 0x0013, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xC00C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VDEVICE(INTEL, 0x9DFA), (kernel_ulong_t)&ufs_intel_cnl_hba_vops },
>  	{ PCI_VDEVICE(INTEL, 0x4B41), (kernel_ulong_t)&ufs_intel_ehl_hba_vops },

