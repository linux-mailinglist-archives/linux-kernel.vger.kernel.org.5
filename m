Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB267F3B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbjKVBzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjKVBzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:55:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E5DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700618149; x=1732154149;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gxF+z61IXTXTtbMXeR8K2hgpRdKrIDL/R0Zmx7ml8xo=;
  b=TT+BlEENgD0SzVS4ktzW158MedCkUnx8wPmjlci3Fe4rPVIW7TsiawMi
   xpUnW7c1QwJ9iBxkiMAonM05u+IGwqXj8JAL4tiELbyGhXUPUjqzcx9N8
   gwXdEUVTM0RWXafR2kXlobnaBipviW6eM7TFWPDjJ7U6UNcw/Z4AVpVoR
   YbO0U7v7eBk1ERhslx5ogS67JYqcV7LIFX69TLV8Wp5lx++TNtEyDWGex
   g7ujvavWfXztpoNkTwNyA/fJxSwSTGaFoRdhPd8+VZ+O98Wb1f9ObvzBI
   ZIqXqexIBCDVNlFwm16RBoAGG5xbBTWifi1QgwfKkR5OKzcacSDT3/JEo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458459149"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="458459149"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 17:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098231951"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="1098231951"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2023 17:55:46 -0800
Message-ID: <719ab0c1-e2a8-4446-8b3f-ba751db0ce27@linux.intel.com>
Date:   Wed, 22 Nov 2023 09:51:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: [PATCH v6 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1700589539.git.robin.murphy@arm.com>
 <6c7313009aae0e39ae2855920990ebf85af4662f.1700589539.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6c7313009aae0e39ae2855920990ebf85af4662f.1700589539.git.robin.murphy@arm.com>
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

On 11/22/23 2:04 AM, Robin Murphy wrote:
> As the final remaining piece of bus-dependent API, iommu_domain_alloc()
> can now take responsibility for the "one iommu_ops per bus" rule for
> itself. It turns out we can't safely make the internal allocation call
> any more group-based or device-based yet - that will have to wait until
> the external callers can pass the right thing - but we can at least get
> as far as deriving "bus ops" based on which driver is actually managing
> devices on the given bus, rather than whichever driver won the race to
> register first.
> 
> This will then leave us able to convert the last of the core internals
> over to the IOMMU-instance model, allow multiple drivers to register and
> actually coexist (modulo the above limitation for unmanaged domain users
> in the short term), and start trying to solve the long-standing
> iommu_probe_device() mess.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Jerry Snitselaar<jsnitsel@redhat.com>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> 
> ---
> 
> v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
>      as the existing code.
> ---
>   drivers/iommu/iommu.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
