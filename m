Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33237809BED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573180AbjLHFwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:52:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD9171F;
        Thu,  7 Dec 2023 21:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702014737; x=1733550737;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2CgvhfqEe7oPS8iAqYFe0ARHhvX5HhGtxuEy7yZmrms=;
  b=FJ9pODvJGSndZ85yMXUM1yZHYqKCRB3XjCOIEfQxtwLF3hYD6WBDkech
   oUtZqtPO3FQeh2d5stT7K8o0qhS2OfwWgTIq+OEfVZBbIBJEGsPEHmkQ1
   d814zGM3ddUKV56qt/Wmuo5/YAOMCQV2lNfLGCf9lma9aNM2Rrf3Hr6c0
   eX2BtLgXoHAUvq2OT4sfO50tO7dARDVOskqJKkxTVvLdHSCPSP2Q10Vwq
   BFVdr7Bl4ZjWiJVay1mYRcDWCUvM3LV7bBmKYOsmX3Hxh6iwCOrKtlfwT
   5QLTdRZy1zHAqqBnUp4IpJYFySXQf77PGrhrfILyClXJKTDGXhrMnNc47
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7685672"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7685672"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="838016425"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="838016425"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2023 21:52:12 -0800
Message-ID: <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
Date:   Fri, 8 Dec 2023 13:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
 <20231207171742.GU1489931@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231207171742.GU1489931@ziepe.ca>
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

On 12/8/23 1:17 AM, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
>>> @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
>>>   	WARN_ON(!list_empty(&fault->deliver));
>>>   	WARN_ON(!list_empty(&fault->response));
>>>   
>>> +	fput(fault->fault_file);
>>> +	put_unused_fd(fault->fault_fd);
>> I have resolved this in a naive way by just not calling the
>> put_unused_fd function.
> That is correct.
> 
> put_unused_fd() should only be called on error paths prior to the
> syscall return.
> 
> The design of a FD must follow this pattern
> 
>   syscall():
>     fdno = get_unused_fd_flags(O_CLOEXEC);
>     filep = [..]
>   
>     // syscall MUST succeed after this statement:
>     fd_install(fdno, filep);
>     return 0;
> 
>    err:
>      put_unused_fd(fdno)
>      return -ERRNO

Yes. Agreed.

> 
> Also the refcounting looks a little strange, the filep reference is
> consumed by fd_install, so what is that fput pairing with in fault_free?

fput() pairs with get_unused_fd_flags()? fd_install() does not seem to
increase any reference.

Best regards,
baolu
