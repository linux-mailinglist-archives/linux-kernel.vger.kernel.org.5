Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED82D7BB543
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJFKbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJFKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:30:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52AEA;
        Fri,  6 Oct 2023 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588257; x=1728124257;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XqzqC3u6ICreoTyLjbtbD1a0rx/MReQVULfRZwZtusQ=;
  b=g1YCK6eMZA37ztaP5c3yELVv08veGzfUnCySKqvhBL8utPLitrK9mXvr
   JQejtunm6t7AVcoicymHRTDexJY4rcdwH7b4mJPWRbDBcXDZjn69MSqtq
   OqHoK+VSQ8uBBKqFiuS0ofD17CIRnicABUG10ejoIFito2GyX6kLVzYFL
   z/r2P9UasTfcE11SbHRI5xyps2udnTznZiRiH23gBVlKfr5g4cS0Pdl81
   tgsElbCO2AlPHA2HbvWQlt0Fb6gmhE0uBzrQF2ME+27MWgrT2FyoLOMO0
   XenvPKo3V+iEOjnVMaYy0OEwJrLaWZLdiY3JimOeDzZc1yRQLThH+ddEv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469993915"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469993915"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822459341"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822459341"
Received: from srab-mobl1.ger.corp.intel.com ([10.252.43.69])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:30:37 -0700
Date:   Fri, 6 Oct 2023 13:30:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v4 9/9] platform/x86/intel/ifs: ARRAY BIST for Sierra
 Forest
In-Reply-To: <20231005195137.3117166-10-jithu.joseph@intel.com>
Message-ID: <34d7c827-4437-93c6-4c72-8b9b0c5f988@linux.intel.com>
References: <20230929202436.2850388-1-jithu.joseph@intel.com> <20231005195137.3117166-1-jithu.joseph@intel.com> <20231005195137.3117166-10-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023, Jithu Joseph wrote:

> Array BIST MSR addresses, bit definition and semantics are different for
> Sierra Forest. Branch into a separate Array BIST flow on Sierra Forest
> when user invokes Array Test.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  7 +++++
>  drivers/platform/x86/intel/ifs/core.c    | 15 +++++-----
>  drivers/platform/x86/intel/ifs/runtest.c | 37 +++++++++++++++++++++++-
>  3 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index f0dd849b3400..2dd5e3406dac 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -137,6 +137,8 @@
>  #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
>  #define MSR_ACTIVATE_SCAN			0x000002c6
>  #define MSR_SCAN_STATUS				0x000002c7
> +#define MSR_ARRAY_TRIGGER			0x000002d6
> +#define MSR_ARRAY_STATUS			0x000002d7
>  #define MSR_SAF_CTRL				0x000004f0
>  
>  #define SCAN_NOT_TESTED				0
> @@ -146,6 +148,9 @@
>  #define IFS_TYPE_SAF			0
>  #define IFS_TYPE_ARRAY_BIST		1
>  
> +#define ARRAY_GEN_0			0
> +#define ARRAY_GEN_1			1

Thank you for your contribution. I've applied this series to my local 
review-ilpo branch.

I ended up renaming these defines ARRAY_GEN_* -> ARRAY_GEN* to make
them more consistent.

-- 
 i.

