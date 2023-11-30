Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE07FEE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjK3MIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbjK3MIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:08:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837ABC1;
        Thu, 30 Nov 2023 04:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701346085; x=1732882085;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xdWDkwrDB0IYLW/+HFAQKJXubCc58VNH21RSj30e8Os=;
  b=KIdWC80AG1xuGoEGie/5B/qZqxR+P6DSHISGugRVi0An9oP7HmFjJqIk
   ZPSkS6HW5e69F3XVz/cd7xK4FQVnJFjUkrcLaF4H7m5poxlT0XGpcchEz
   O80YoHqVD2KC87pNhomg3OhYml9GbctfHYWKV5fPgZBL6Oz6TvLWsjpgD
   8wBDMWbrSSvNP6caevmOKwx7qTCBk3NSQY0lXqIcVh3E2rVOfKek6T7oR
   FyZInnVr2wOS7jebikkQoGfnmSdJfbss2nVvQcGhmXlwffWzNQiuLPwur
   /nCqQYm5d6HJbtgRVcuQ51OSUqxrlrS8ePsB9VgtZsFObvmqeOBiKfF89
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="479516026"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="479516026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="913175906"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="913175906"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:08:03 -0800
Date:   Thu, 30 Nov 2023 14:08:01 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] platform/x86/intel/tpmi: Modify external interface
 to get read/write state
In-Reply-To: <20231128185605.3027653-4-srinivas.pandruvada@linux.intel.com>
Message-ID: <e81e79a9-48d1-81ce-eb72-24a9baa02ce7@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com> <20231128185605.3027653-4-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-682876541-1701346084=:1808"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-682876541-1701346084=:1808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:

> Modify the external interface tpmi_get_feature_status() to get read
> and write blocked instead of locked and disabled. Since auxiliary device
> is not created when disabled, no use of returning disabled state. Also
> locked state is not useful as feature driver can't use locked state
> in a meaningful way.
> 
> Using read and write state, feature driver can decide which operations
> to restrict for that feature.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/tpmi.c | 8 ++++----
>  include/linux/intel_tpmi.h        | 5 ++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index 4edaa182db04..44773c210324 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -351,8 +351,8 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
>  	return ret;
>  }
>  
> -int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
> -			    int *locked, int *disabled)
> +int tpmi_get_feature_status(struct auxiliary_device *auxdev,
> +			    int feature_id, int *read_blocked, int *write_blocked)

Noting down there's logical reversion of the parameters here as to me
locked sound similar to write_blocked and disabled likewise to 
read_blocked but since there are no users for this function so far
I suppose it's fine.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-682876541-1701346084=:1808--
