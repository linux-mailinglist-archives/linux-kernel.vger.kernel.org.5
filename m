Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3917679D004
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjILLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjILLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:32:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1910C9;
        Tue, 12 Sep 2023 04:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694518323; x=1726054323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JG4GmfnpXv90VCpDbO3rQysAp8JtiQPJgT+rVgDM8H8=;
  b=bZPYQPBqm4xexx4GcWM3uSmowIDfjHVEYsPIbXrStsyJVNn0uq170BT/
   eQY8TOQ3sMQzGnWnm51y1+Pmkq/8HX+Yas8pi5Dr3Xg8peFxUY+t21K6Y
   lFTD9IJEvdGzQ4aszprSeOtE1Ont6a+p/RoU08uZfGInjXp3ivGoK82SZ
   wRDr5GajExUx5RhW9sVFrPJYA1xsy/qOv/DaKHkol6OoBNCF6FsIxRKXq
   M09kSnp+ygQ7oLdguVJejwBHLcScvVJxmDEzbmR29N0EWIT57b1E9V7WY
   WLDLmGWI6cRTeAERgeduHgra0Wg94cUjER/Kb7E8fIlGt1NZZg4HzajQk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464716678"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464716678"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772963220"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="772963220"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2023 04:32:00 -0700
Message-ID: <7c388791-e4cd-28da-3d98-5cc233bec165@linux.intel.com>
Date:   Tue, 12 Sep 2023 14:33:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: xhci: xhci-ring: Use sysdev for mapping bounce
 buffer
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, stable@vger.kernel.org
References: <20230911234122.1408-1-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20230911234122.1408-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.9.2023 2.41, Wesley Cheng wrote:
> As mentioned in:
>    commit 474ed23a6257 ("xhci: align the last trb before link if it is
> easily splittable.")
> 
> A bounce buffer is utilized for ensuring that transfers that span across
> ring segments are aligned to the EP's max packet size.  However, the device
> that is used to map the DMA buffer to is currently using the XHCI HCD,
> which does not carry any DMA operations in certain configrations.
> Migration to using the sysdev entry was introduced for DWC3 based
> implementations where the IOMMU operations are present.
> 
> Replace the reference to the controller device to sysdev instead.  This
> allows the bounce buffer to be properly mapped to any implementations that
> have an IOMMU involved.
> 
> cc: <stable@vger.kernel.org>
> Fixes: 4c39d4b949d3 ("usb: xhci: use bus->sysdev for DMA configuration")
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

Thanks, adding to queue

-Mathias



