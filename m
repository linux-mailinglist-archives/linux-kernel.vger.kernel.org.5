Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A537C663A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377488AbjJLHKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJLHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:09:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050DCF;
        Thu, 12 Oct 2023 00:09:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6960EC433C8;
        Thu, 12 Oct 2023 07:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697094598;
        bh=O14Gyn27mSQRHdRIVyvrPGN+SxNqyOZQQR3iMuU8frA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeULQfJq05Z1AnlTYEf8sYzkPyE7ZoUOroDPClDTiqBqOoLD3ftTZkTV+TXlsp7wB
         nvltw/pzzpXCgEQNSAivl4MCQTbVLALo9o6fCYnCYIUdC8cME+A0Kus5tW7FRXXIgO
         r46aRwWAjIeJkVkd/WrlIN3iD+hqxuvagBgbVV+0=
Date:   Thu, 12 Oct 2023 09:09:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        RD Babiera <rdbabiera@google.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <2023101247-coexist-isolated-584b@gregkh>
References: <20231012122209.6f2768df@canb.auug.org.au>
 <20231012122749.45d37e52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012122749.45d37e52@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:27:49PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 12 Oct 2023 12:22:09 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/usb/typec/altmodes/displayport.c: In function 'dp_altmode_vdm':
> > drivers/usb/typec/altmodes/displayport.c:309:33: error: too few arguments to function 'drm_connector_oob_hotplug_event'
> >   309 |                                 drm_connector_oob_hotplug_event(dp->connector_fwnode);
> >       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from drivers/usb/typec/altmodes/displayport.c:17:
> > include/drm/drm_connector.h:1984:6: note: declared here
> >  1984 | void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   fc93835bb0d7 ("drm: Add HPD state to drm_connector_oob_hotplug_event()")
> > 
> > interacting with commit
> > 
> >   89434b069e46 ("usb: typec: altmodes/displayport: Signal hpd low when exiting mode")
> > 
> > from the usb.current tree.
> > 
> > I have applied the following merge fix patch.
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 12 Oct 2023 12:17:31 +1100
> > Subject: [PATCH] fix up for "drm: Add HPD state to
> >  drm_connector_oob_hotplug_event()"
> > 
> > interacting with commit
> > 
> >   89434b069e46 ("usb: typec: altmodes/displayport: Signal hpd low when exiting mode")
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/usb/typec/altmodes/displayport.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> > index ddfb5b6ace4f..eb0bf08fc97a 100644
> > --- a/drivers/usb/typec/altmodes/displayport.c
> > +++ b/drivers/usb/typec/altmodes/displayport.c
> > @@ -306,7 +306,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
> >  			dp->data.status = 0;
> >  			dp->data.conf = 0;
> >  			if (dp->hpd) {
> > -				drm_connector_oob_hotplug_event(dp->connector_fwnode);
> > +				drm_connector_oob_hotplug_event(dp->connector_fwnode
> 
> Pretend that there is a comma at the end of the above line :-)

Looks good to me, thanks!

greg k-h
