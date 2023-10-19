Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E763B7CF271
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjJSIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjJSIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:23:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40470196;
        Thu, 19 Oct 2023 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697703822; x=1729239822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2MAyMgwN/G69lLL1g6/v1UJJ3TximyIFM4Z4LTNraxE=;
  b=DdcHIQin5T7tpFmMTCNCwk6MxJaIU8bEwrzaeyJOvpf1cnyeTGbD3KdO
   2OlCwen+WUkJ8k7PtEiPppQCl+G0wKkgbrLayb3n9bJZhNvHmv4BPe2Q5
   W7ZZ7rK5Cdpvc6VO5UTlIzhAoI9muCDIvrFJ5h1o1yJaCeQRrCCIiO4mb
   rTlI6rSBsAzk0mps7pGoPO9uS1o/EHFhQajRMsEXdpQ3aiDtipkuayqAT
   6pn5OZzY1cHScddLDbqxeSk39elJuSVo8A3kUORKjsnRpXPIcxzD+7oe+
   fwVAU0Oe+EXSUXkNEHe/eNb+UeomHA+S4LO2e1NRiirpW53xRp5QN64kq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452668937"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452668937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930523829"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="930523829"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga005.jf.intel.com with SMTP; 19 Oct 2023 01:23:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Oct 2023 11:23:33 +0300
Date:   Thu, 19 Oct 2023 11:23:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Fix NULL pointer dereference in
 tcpm_pd_svdm()
Message-ID: <ZTDnhbYDq7kq8vBj@kuha.fi.intel.com>
References: <20231019060616.1988631-1-hhhuuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019060616.1988631-1-hhhuuu@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 06:06:16AM +0000, Jimmy Hu wrote:
> It is possible that typec_register_partner() returns ERR_PTR on failure.
> When port->partner is an error, a NULL pointer dereference may occur as
> shown below.
> 
> [91222.095236][  T319] typec port0: failed to register partner (-17)
> ...
> [91225.061491][  T319] Unable to handle kernel NULL pointer dereference
> at virtual address 000000000000039f
> [91225.274642][  T319] pc : tcpm_pd_data_request+0x310/0x13fc
> [91225.274646][  T319] lr : tcpm_pd_data_request+0x298/0x13fc
> [91225.308067][  T319] Call trace:
> [91225.308070][  T319]  tcpm_pd_data_request+0x310/0x13fc
> [91225.308073][  T319]  tcpm_pd_rx_handler+0x100/0x9e8
> [91225.355900][  T319]  kthread_worker_fn+0x178/0x58c
> [91225.355902][  T319]  kthread+0x150/0x200
> [91225.355905][  T319]  ret_from_fork+0x10/0x30
> 
> Add a check for port->partner to avoid dereferencing a NULL pointer.
> 
> Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>

No CC stable...?

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 6e843c511b85..792ec4ac7d8d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1625,6 +1625,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (PD_VDO_VID(p[0]) != USB_SID_PD)
>  				break;
>  
> +			if (IS_ERR_OR_NULL(port->partner))
> +				break;
> +
>  			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
>  				typec_partner_set_svdm_version(port->partner,
>  							       PD_VDO_SVDM_VER(p[0]));

-- 
heikki
