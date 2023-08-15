Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167F777C943
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjHOITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjHOIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:18:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94A10C0;
        Tue, 15 Aug 2023 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692087498; x=1723623498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3dYXn6E9NAUNNi42+ayfswlDFcST6ltjtF9/c5VvXpA=;
  b=a3ouxw1VHoZNRiUCyx7W0dY6pY+0BDTP7mAgItlZMWGY942ybcL22S+4
   O9BzxtxCj9+qnBT3EPJdUcJZpG5z9os3yrz9G63KA5/yz5nnE3ZBq3yAy
   g2ek+XKhjZHj7KZnPrwV/2Vb/DTgaAZv+5Hu2ponPQZrD8o3eQLU8iOMw
   m/fRDN1QTNM6ipIzF9OdT4TMgGjA1+1fw/WsU08M2aGIhzxGYaXL9pRMK
   oAq9j/btbvzrtOgLho+rIZ3FmvvtMltWLGTa9lgCJ0d6vVP7mBHd4WTyf
   wB7TVtHgidP/aOabmkVp0/OckwvZCYV45Bg0pED9tJUtcIy0c/s9oVTrH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372227408"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372227408"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 01:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877276113"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 15 Aug 2023 01:18:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Aug 2023 11:18:14 +0300
Date:   Tue, 15 Aug 2023 11:18:14 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: bus: verify partner exists in
 typec_altmode_attention
Message-ID: <ZNs0xhqPHvmzrvlF@kuha.fi.intel.com>
References: <20230814180559.923475-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814180559.923475-1-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 06:05:59PM +0000, RD Babiera wrote:
> Some usb hubs will negotiate DisplayPort Alt mode with the device
> but will then negotiate a data role swap after entering the alt
> mode. The data role swap causes the device to unregister all alt
> modes, however the usb hub will still send Attention messages
> even after failing to reregister the Alt Mode. type_altmode_attention
> currently does not verify whether or not a device's altmode partner
> exists, which results in a NULL pointer error when dereferencing
> the typec_altmode and typec_altmode_ops belonging to the altmode
> partner.
> 
> Verify the presence of a device's altmode partner before sending
> the Attention message to the Alt Mode driver.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> * Only assigns pdev if altmode partner exists in typec_altmode_attention
> * Removed error return in typec_altmode_attention if Alt Mode does
>   not implement Attention messages.
> * Changed tcpm_log message to indicate that altmode partner does not exist,
>   as it only logs in that case.
> ---
> Changes since v2:
> * Changed tcpm_log message to accurately reflect error
> * Revised commit message
> ---
> Changes since v3:
> * Fixed nits
> ---
>  drivers/usb/typec/bus.c           | 12 ++++++++++--
>  drivers/usb/typec/tcpm/tcpm.c     |  3 ++-
>  include/linux/usb/typec_altmode.h |  2 +-
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index fe5b9a2e61f5..e95ec7e382bb 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
>   *
>   * Notifies the partner of @adev about Attention command.
>   */
> -void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
> +int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
>  {
> -	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
> +	struct altmode *partner = to_altmode(adev)->partner;
> +	struct typec_altmode *pdev;
> +
> +	if (!partner)
> +		return -ENODEV;
> +
> +	pdev = &partner->adev;
>  
>  	if (pdev->ops && pdev->ops->attention)
>  		pdev->ops->attention(pdev, vdo);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(typec_altmode_attention);
>  
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5a7d8cc04628..77fe16190766 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1877,7 +1877,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			}
>  			break;
>  		case ADEV_ATTENTION:
> -			typec_altmode_attention(adev, p[1]);
> +			if (typec_altmode_attention(adev, p[1]))
> +				tcpm_log(port, "typec_altmode_attention no port partner altmode");
>  			break;
>  		}
>  	}
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 350d49012659..28aeef8f9e7b 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -67,7 +67,7 @@ struct typec_altmode_ops {
>  
>  int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
>  int typec_altmode_exit(struct typec_altmode *altmode);
> -void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
> +int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
>  int typec_altmode_vdm(struct typec_altmode *altmode,
>  		      const u32 header, const u32 *vdo, int count);
>  int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
> 
> base-commit: f176638af476c6d46257cc3303f5c7cf47d5967d
> -- 
> 2.41.0.694.ge786442a9b-goog

-- 
heikki
