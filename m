Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DFA7DB463
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjJ3HeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjJ3HeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:34:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEEBA7;
        Mon, 30 Oct 2023 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698651240; x=1730187240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNuA/zgIziBiLAcaxX+JeavImVsEewi4l5yzenjLCTQ=;
  b=RIQGv5/2uB96ddQKHd9VlSjVa44pAnpwUJxak30LOt99ETxwB1o3MQJ2
   jg2Az1966AB/bB7vGIDxSGSX5FGozKrJhsEyCtUWGvUZydR4vunGHBnpL
   NVjpjjIK757UFZ/Sj/Ps18yE2JESIge7OeOYbeGqSen+e9YBfrS/ptTx3
   1pQgTbrGXKi4EZi3++xxeK/QEPyK4p82rdu6wNMbT3DvXSTsO3Skdu8Vg
   LqD1j7AEU8CF4D5zl1pXXU2TyoYOwVfPyjkrKjZnaxb1czDbNZ5K0D4wc
   Bw17PSDmx86wlolI3eRY5BHX4VHVyoLz9yidxn5unJ9cbuWc6fYUS3MFg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6660082"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="6660082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 00:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="903906729"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="903906729"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2023 00:33:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 30 Oct 2023 09:33:55 +0200
Date:   Mon, 30 Oct 2023 09:33:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Fix NULL pointer dereference in
 tcpm_pd_svdm()
Message-ID: <ZT9b2FDESlJSsXsj@kuha.fi.intel.com>
References: <20231020012132.100960-1-hhhuuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020012132.100960-1-hhhuuu@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 01:21:32AM +0000, Jimmy Hu wrote:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
