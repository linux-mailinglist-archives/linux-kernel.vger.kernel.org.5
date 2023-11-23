Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBD7F62B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbjKWPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbjKWPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:24:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721410C4;
        Thu, 23 Nov 2023 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700753060; x=1732289060;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Gdj3IGAs2hjIQ1Amnl+R7syRNk6HRK2epPtT62bfX/8=;
  b=DFDMxy4XELpGl+FrKLJAc/7ovu8SNDauPIOg95NUlSszQEHmtdLzn/29
   4Vvu4R8PlMU9gUjv24qs82wD3phBZUphGPxtOffczmnZPfglrS6QwFM91
   MCyDVdFX48XiA/zatm/U13oHnKwQ+ej+ARlEnfdZNp/KMgUYc8x2xn0H0
   sdSGVjEnUQXnFxvvV4O11RuO+7DPWzpCrfsekdmqeQ8IHYR77EGlZF+YY
   UaDkDMLNgHbTfw3wImBLcT8NPUov5uWnU5pCd08aU/sbHxRQ9BoExKE8s
   MO/Hjcc5/cIwaePKQN6gBcmQvPqsRitZm0nkMw+XQCSCWgOWiSigA8mNt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13836876"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="13836876"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:24:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833448254"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="833448254"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:24:17 -0800
Date:   Thu, 23 Nov 2023 17:24:10 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V5 06/20] platform/x86/intel/vsec: Add
 intel_vsec_register
In-Reply-To: <20231123040355.82139-7-david.e.box@linux.intel.com>
Message-ID: <7efeca6-6164-99e2-52d2-2b247d2698d4@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-7-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, David E. Box wrote:

> From: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> 
> Add and export intel_vsec_register() to allow the registration of Intel
> extended capabilities from other drivers. Add check to look for memory
> conflicts before registering a new capability. Add a parent field to
> intel_vsec_platform_info to allow specifying the parent device for
> device managed cleanup.

Please also explain here why the usual parent relationships are not enough
in this case and you need to store it.

> diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
> index 8b9fad170503..bb8b6452df70 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -69,6 +69,7 @@ enum intel_vsec_quirks {
>  
>  /* Platform specific data */
>  struct intel_vsec_platform_info {
> +	struct device *parent;
>  	struct intel_vsec_header **headers;
>  	unsigned long caps;
>  	unsigned long quirks;

-- 
 i.

