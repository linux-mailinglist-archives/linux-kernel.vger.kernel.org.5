Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C57FA8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjK0SUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0SUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BC92
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:20:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2DC433C9;
        Mon, 27 Nov 2023 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701109258;
        bh=BPEZYswnHtTaDhuMtTBDQ96uRSzMIQ5kvejeliwaiw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbYCKymX+5I0u4bFW2dSOUBGffKJZEu4kdzCzL23Kk94zcTnWWAca+/slwSlhBAYt
         4BTNz2Dbl6Hl6QFHfVyiEaintVNanLQNjr6r+l+ruFJhY663j1FjPtzt8Vu3k621z+
         yL31ybOwTuhQpyAY9zO4VMWvlOt6zTZ70PKG5CBE=
Date:   Mon, 27 Nov 2023 18:20:55 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 1/2] driver core: Export device_is_dependent() to
 modules
Message-ID: <2023112739-willing-sighing-6bdd@gregkh>
References: <20231127051414.3783108-1-victor.liu@nxp.com>
 <20231127051414.3783108-2-victor.liu@nxp.com>
 <v6rthnruba5xaxazsn4jsptn6catso5qwuyf5xxbf4ml25b6eo@snttjo7oqlod>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v6rthnruba5xaxazsn4jsptn6catso5qwuyf5xxbf4ml25b6eo@snttjo7oqlod>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:38:13PM +0100, Maxime Ripard wrote:
> Greg, Rafael,
> 
> On Mon, Nov 27, 2023 at 01:14:13PM +0800, Liu Ying wrote:
> > Export device_is_dependent() since the drm_kms_helper module is starting
> > to use it.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v2:
> > * Newly introduced as needed by patch 2.
> > 
> >  drivers/base/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 67ba592afc77..bfd2bf0364b7 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -328,6 +328,7 @@ int device_is_dependent(struct device *dev, void *target)
> >  	}
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(device_is_dependent);
> 
> So, a committer just applied this to drm-misc-fixes without your
> approval. Could you ack it? If you don't want to, we'll fix it.

Wait, why exactly is this needed?  Nothing outside of the driver core
should be needing this function, it shouldn't be public at all (I missed
that before.)

So please, revert it for now, let's figure out why DRM thinks this is
needed for it's devices, and yet no other bus/subsystem does.

thanks,

greg k-h
