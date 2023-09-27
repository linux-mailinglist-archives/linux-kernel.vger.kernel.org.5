Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61F7AFA78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjI0F5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjI0F5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:57:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D610A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:57:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BDEC433C7;
        Wed, 27 Sep 2023 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695794258;
        bh=RZYofYOZ1MyTug1bUsL3N5Afz42CL9StXrgCWGQiYlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGmqiIaBmzicq6U2wn6n/OIUecEF1XOXpg8I7mXbw2RULx0663GRqsl2Rztt7vc7t
         F6D97InKjGDY0PM90DOWKOFpwATvRu2kY0krn01g4Ri0rvYz1+m//JzGaP92AYv6gK
         REBTul5Lw/glesHVhRLksah9ApLMAUlgCoKM4o+c=
Date:   Wed, 27 Sep 2023 07:57:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_tingweiz@quicinc.com,
        saravanak@google.com
Subject: Re: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in
 device_links_purge()
Message-ID: <2023092722-proofread-vindicate-f26c@gregkh>
References: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:30:10AM +0800, Zhenhua Huang wrote:
> Flag FWNODE_FLAG_LINKS_ADDED stops fwnode links creation. Current kernel
> only adds it once after fwnode links creation in fw_devlink_parse_fwnode().
> After that even device links being purged, the flag will not be cleared.
> 
> Fwnode links are converted to device links and will not be added back
> forever in normal case. Essentially if a device is registered and
> unregisted (also deleted) before it is probed (due to missing fwlink
> dependencies, abort in device_links_check_suppliers), the fwlink is not
> setup next when device is newly created again. This means the probe gets
> called without meeting all dependencies.
> 
> It usuallly happens in the case of a glue driver. Of_platform_populate()
> allows us to populate subnodes. We may do it in ancestor node probing
> function, then check subnode's probing status because there may be chances
> that suppliers of subnode are not ready. We may further need to do
> of_platform_depopulate(which purges device links) and in some time
> of_platform_populate() again. Such case we miss fwnode links(so that device
> links) during second time of populating subnodes.
> 
> Fix it by Clearing FWNODE_FLAG_LINKS_ADDED flag in purging device link
> func, indicates both fwnode links and device links are absent.
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/base/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b7d7f41..2a1975d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1630,6 +1630,10 @@ static void device_links_purge(struct device *dev)
>  		__device_link_del(&link->kref);
>  	}
>  
> +	/* Clear flags in fwnode. Give a chance to create fwnode link again */
> +	if (dev->fwnode)
> +		dev->fwnode->flags &= ~FWNODE_FLAG_LINKS_ADDED;
> +
>  	device_links_write_unlock();
>  }
>  
> -- 
> 2.7.4
> 

Why is this a RESEND?  What was wrong with the first version?
