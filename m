Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AD785873
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjHWNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjHWNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:00:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92691E5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692795595; x=1724331595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8biZeHhJAomKADkItEQoL9mgPtVRqJ3R/W9kdQy1UZI=;
  b=VstWa3j5pZBtLGaxy3rDPirTeG+YeUPOQEHnkHVnpwYD95dL0ynXvmBG
   93UkUHedkLo+T/HybaExes/jkKItmBk/fRwN3pDR/BTgpW2m//G4Sxyiq
   xo5G+/2PoSflz16h6/IX5ahOXjrRlrzU12lNQumP1ufcdVwquD4UQ1NAS
   QYZBIgX/cnr9i0Xs01b6LG0+NTy2DR609NTFcdVjyAOrIocfN4wkTSlGz
   dklm8cBhOowbx2DC8bj0PSXSd3ZDIMrtX3CvS4/LICmWs6SPP/jc2dovf
   xE5ucut2j8EODbqE3RkSs4sxlFbXfySZ6PpA2nDmufVTsiY+45fWO2MB8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="376878836"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376878836"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 05:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="686444844"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686444844"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 05:51:53 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, ashok.raj@intel.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com, x86@kernel.org,
        qiuxu.zhuo@intel.com
Subject: Re: [patch V2 03/37] x86/microcode/intel: Move microcode functions out of cpu/intel.c
Date:   Wed, 23 Aug 2023 20:51:44 +0800
Message-Id: <20230823125144.27587-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230812195727.719202319@linutronix.de>
References: <20230812195727.719202319@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> ...
> -#define get_totalsize(mc) \
> -	(((struct microcode_intel *)mc)->hdr.datasize ? \
> -	 ((struct microcode_intel *)mc)->hdr.totalsize : \
> -	 DEFAULT_UCODE_TOTALSIZE)
> +#define DEFAULT_UCODE_DATASIZE		(2000)
>  
> ...
> +
> +static inline unsigned int get_totalsize(struct microcode_header_intel *hdr)
> +{
> +	return hdr->datasize ? : DEFAULT_UCODE_TOTALSIZE;

I tested this patch series and observed that the inline code above failed
the late microcode loading with the error message:

    [  117.100299] microcode: Error: bad microcode data file size.

According to the original get_totalsize() macro, seems like it should be:

    return hdr->datasize ? hdr->totalsize : DEFAULT_UCODE_TOTALSIZE;

With this minor change, the late microcode loading was successful, and the
expected message was displayed:

    ...
    [  150.198654] microcode: Microcode revision: 0x80000400 -> 0x80000401

-Qiuxu

> +}
> ...
