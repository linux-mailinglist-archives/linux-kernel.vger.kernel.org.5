Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5E7F5BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjKWJwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjKWJwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:52:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43FBD4A;
        Thu, 23 Nov 2023 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700733142; x=1732269142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JwTeH5mEKbp0ZeiZEBaFKb7pQPftaaqLxXwbXFYJjBs=;
  b=gzKzYi8jAqFQSoR2dnZW4pcxGuBdzw3Sz8QbBygekkW9JcWqgTcSIpeD
   1TW+7a2fIYtwrtRAHRKncOrqFrCwutWpVrCS+th3L8xlNb2I0R3rKjbC9
   B1f4YhWMcAi3o7o1RFLCNCLBgCuSUCgkOaE0TLmVc2/emKC4YFwLlQh5u
   EQ0DEKXui3AtGPmcmFMZN93QoppumRp7zURPTIKVp1LyxlHacaqTJViui
   /vcFOV4YGe4VvJiC+HDyPUos9mtQBdrJxR71iQSNvKC/w3dmF1mNrmyqB
   4pGfWLIwkmfUUVHt5N0ikJCyHOI7QFfsubFiJtd+Wmpojku9a0lvH+s9u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371587155"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="371587155"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770946423"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="770946423"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 23 Nov 2023 01:52:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Nov 2023 11:52:18 +0200
Date:   Thu, 23 Nov 2023 11:52:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, badhri@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <ZV8g0nkZSLI8YXyd@kuha.fi.intel.com>
References: <20231121203954.173364-2-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121203954.173364-2-rdbabiera@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:39:55PM +0000, RD Babiera wrote:
> When releasing an Alt Mode, typec_altmode_release called by a plug device
> will not release the plug Alt Mode, meaning that a port will hold a
> reference to a plug Alt Mode even if the port partner is unregistered.
> As a result, typec_altmode_get_plug() can return an old plug altmode.
> 
> Currently, typec_altmode_put_partner does not raise issues
> when unregistering a partner altmode. Looking at the current
> implementation:
> 
> > static void typec_altmode_put_partner(struct altmode *altmode)
> > {
> >	struct altmode *partner = altmode->partner;
> 
> When called by the partner Alt Mode, then partner evaluates to the port's
> Alt Mode. When called by the plug Alt Mode, this also evaluates to the
> port's Alt Mode.
> 
> >	struct typec_altmode *adev;
> >
> >	if (!partner)
> >		return;
> >
> >	adev = &partner->adev;
> 
> This always evaluates to the port's typec_altmode
> 
> >	if (is_typec_plug(adev->dev.parent)) {
> >		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> >
> >		partner->plug[plug->index] = NULL;
> 
> If the routine is called to put the plug's Alt mode and altmode refers to
> the plug, then adev referring to the port can never be a typec_plug. If
> altmode refers to the port, adev will always refer to the port partner,
> which runs the block below.
> 
> >	} else {
> >		partner->partner = NULL;
> >	}
> >	put_device(&adev->dev);
> > }
> 
> When calling typec_altmode_set_partner, a registration always calls
> get_device() on the port partner or the plug being registered, therefore
> typec_altmode_put_partner should put_device() the same device. By changing
> adev to altmode->adev, we make sure to put the correct device and properly
> unregister plugs. The reason port partners are always properly
> unregistered is because even when adev refers to the port, the port
> partner gets nullified in the else block. The port device currently gets
> put().
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 2e0451bd336e..803be1943445 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -267,7 +267,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  	if (!partner)
>  		return;
>  
> -	adev = &partner->adev;
> +	adev = &altmode->adev;
>  
>  	if (is_typec_plug(adev->dev.parent)) {
>  		struct typec_plug *plug = to_typec_plug(adev->dev.parent);

Sorry, I may have missed something, but do we need to call this
function with ports at all?

static void typec_altmode_release(struct device *dev)
{
        struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-       typec_altmode_put_partner(alt);
+       if (!is_typec_port(dev->parent))
+               typec_altmode_put_partner(alt);
 
        altmode_id_remove(alt->adev.dev.parent, alt->id);
        kfree(alt);
        ...

thanks,

-- 
heikki
