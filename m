Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8A803404
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjLDNJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjLDNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:09:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72828D45;
        Mon,  4 Dec 2023 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701695363; x=1733231363;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4q8sIrDSIwqjWK+DiPqyfA+yiSDchtuZxyCuf8fsg2o=;
  b=BOqSbqF/Dhrpoal3CXUr5lQjNzeJN3sZ7rv0gZdvLH6pTkuYAYOdwOkX
   ZYb3tCX8LIjdKDWPj4c+++XoIK4RWWqx7qBNzs2PdVI/NhBa4MxzQoQr2
   IwDTNJspYqRlQLYw6yNYiV/72lyMP9oU6mNDQKxjVh6yeGqxAA4ktZL3Z
   cp42SIiAQT2xdXdNvz+qmn667aTC2c5aSvsoBeDSGJkgK3wwa/4JRTPMn
   kaxtLk2dFM/db2CKRsrFWU4q+CEADp0FYuzbhkfm0w7dXQSUsxtGNHTKN
   Hbnldc5va/Eo88NDMBeLd6BSOvWWMfsHA2mbEp8eQjyqq7932j+D7Qfqb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="384132455"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="384132455"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1017844609"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="1017844609"
Received: from malladhi-mobl.gar.corp.intel.com ([10.249.34.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:09:20 -0800
Date:   Mon, 4 Dec 2023 15:09:18 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     David Thompson <davthompson@nvidia.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        vadimp@nvidia.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kblaiech@nvidia.com
Subject: Re: [PATCH v3] mlxbf-bootctl: correctly identify secure boot with
 development keys
In-Reply-To: <20231130183515.17214-1-davthompson@nvidia.com>
Message-ID: <c1be334-ed14-29f-e6-2f5d4f743b3@linux.intel.com>
References: <20231130183515.17214-1-davthompson@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1232564795-1701695362=:3149"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1232564795-1701695362=:3149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2023, David Thompson wrote:

> The secure boot state of the BlueField SoC is represented by two bits:
>                 0 = production state
>                 1 = secure boot enabled
>                 2 = non-secure (secure boot disabled)
>                 3 = RMA state
> There is also a single bit to indicate whether production keys or
> development keys are being used when secure boot is enabled.
> This single bit (specified by MLXBF_BOOTCTL_SB_DEV_MASK) only has
> meaning if secure boot state equals 1 (secure boot enabled).
> 
> The secure boot states are as follows:
> - “GA secured” is when secure boot is enabled with official production keys.
> - “Secured (development)” is when secure boot is enabled with development keys.
> 
> Without this fix “GA Secured” is displayed on development cards which is
> misleading. This patch updates the logic in "lifecycle_state_show()" to
> handle the case where the SoC is configured for secure boot and is using
> development keys.
> 
> Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---

> +	} else if ((use_dev_key) &&
> +		   (lc_state == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE)) {
> +		return sprintf(buf, "Secured (development)\n");
>  	}

Thanks for the update. Applied to review-ilpo and will propagate into 
fixes once LKP has built it.

I removed the unnecessary parenthesis around that use_dev_key while 
applying the patch.


-- 
 i.

--8323329-1232564795-1701695362=:3149--
