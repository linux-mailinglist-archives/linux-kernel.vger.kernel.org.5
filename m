Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1D769433
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjGaLGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjGaLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:06:10 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7D12A;
        Mon, 31 Jul 2023 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690801569; x=1722337569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ms8UFtG4oh1EAp/tG2dT3wGuSxTU49wwvkM/j/HRWIo=;
  b=eMVoQIbNWc+KUOxSRUxk8jw3Fz6upLzQFw5BL/wSpsZyFYh9HG0dMPSj
   /3M5LtdLj2AlOrSGnM2ROgv/tYo6oiVK+lmyALRtw2YfvKxpOBhB6ds60
   s8vwQ0yocw4V+84UFE94tZL0XDqLe2JULZcid7m+ar1in0qoxVfAel8tw
   fSjgfD/Lir5WY9Z/7XQ3mQ7YDRyNibnI9sV8m5AnGyPRlEP0gbAewFBWE
   G0OiVcBUk2SE0HAUw+0b0apKCIidcLn7uNObu8K4LV9WpdJrMvyBCdjWl
   WnSx0faAwL3KBrcQyjitG/7G0E5d7gs6YgXJqbmxXVOYaBbOJ9KavF60o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="399935683"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="399935683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 04:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871643710"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2023 04:06:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jul 2023 14:06:05 +0300
Date:   Mon, 31 Jul 2023 14:06:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, kyletso@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Add IS_ERR_OR_NULL check for
 port->partner
Message-ID: <ZMeVnbnIuf1bNuKQ@kuha.fi.intel.com>
References: <20230630065711.801569-1-hhhuuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630065711.801569-1-hhhuuu@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry to keep you waiting.

On Fri, Jun 30, 2023 at 06:57:11AM +0000, Jimmy Hu wrote:
> port->partner may be an error or NULL, so we must check it with
> IS_ERR_OR_NULL() before dereferencing it.

Have you seen this happening? Maybe the partner check should happen
earlier, before tcpm_pd_svdm() is even called?

> Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..cd2590eead04 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1626,6 +1626,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  				break;
>  
>  			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
> +				if (IS_ERR_OR_NULL(port->partner))
> +					break;
>  				typec_partner_set_svdm_version(port->partner,
>  							       PD_VDO_SVDM_VER(p[0]));
>  				svdm_version = PD_VDO_SVDM_VER(p[0]);

Now you will still build a response? I'm pretty sure you don't want
that.

Do we need to do anything in this function if the partner is lost? If
not, then why not just check the partner in the beginning of the
function. Or just make sure we don't even call tcpm_pd_svdm() if
there's no partner.

thanks,

-- 
heikki
