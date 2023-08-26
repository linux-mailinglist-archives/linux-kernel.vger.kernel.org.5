Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A149D789464
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjHZHk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHZHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D91987;
        Sat, 26 Aug 2023 00:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6532161717;
        Sat, 26 Aug 2023 07:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70762C433C7;
        Sat, 26 Aug 2023 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693035623;
        bh=tOZTl1Wc+vhOVNCHXGQXQuPy13/rR/W0JwaNSYoYlNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkT8k0ArYqgGPi+k5ChM8QO+C4pvTAD4Y3RCdD8VXD6v1xJW3Ac02XcKiGwYkSl8m
         btgiuCTVXmwn6UhJz7c7k288UaizkAnSH177HMPLX1K5vIVID/DcfFrg1iSoeAuT5k
         PhaQ4TMz1Cz5VdQhEiYZvo7hpXqw88e0wa7VFN/w=
Date:   Sat, 26 Aug 2023 09:40:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Message-ID: <2023082600-moisture-corroding-c1e9@gregkh>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
 <ZN+j/z97Yy0wv/if@chromium.org>
 <MWHPR11MB0048DAF02954ACC66C026533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
 <CACeCKacWhrZE6LFFwF=vDO8362u9feN71pPO8Qr8XoaRgwj5uw@mail.gmail.com>
 <MWHPR11MB0048018BB93C531401D00EF9A91FA@MWHPR11MB0048.namprd11.prod.outlook.com>
 <ZOYnJTqTajyyJV0d@chromium.org>
 <MWHPR11MB0048B06F1FEB1EF7187B4AFAA9E3A@MWHPR11MB0048.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB0048B06F1FEB1EF7187B4AFAA9E3A@MWHPR11MB0048.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 09:04:29PM +0000, Patel, Utkarsh H wrote:
> Hi Greg,
> 
> > > > >
> > > > > We are only calling it once depending upon which mode we enter TBT
> > > > > Alt or
> > > > USB4.
> > > >
> > > > There should only be 1 "call site" and that should be sufficient to
> > > > grab the VDO from the framework for all circumstances. Whether the
> > > > other invocation doesn't get called under certain circumstances isn't as
> > relevant.
> > >
> > > Are you suggesting something like this?
> > >
> > > static int cros_typec_configure_mux(struct cros_typec_data *typec, int
> > port_num,)...
> > >
> > > 	if (port->mux_flags & USB_PD_MUX_USB4_ENABLED ||
> > > 		port->mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED)
> > > 		cable_tbt_vdo = cros_typec_get_cable_vdo(port,
> > USB_TYPEC_TBT_SID);
> > 
> > My apologies, I misread the patch. I think this looks good.
> > 
> > Acked-by: Prashant Malani <pmalani@chromium.org>
> 
> Could you please add this patch to usb-next.

Ugh, it's late in the cycle, but this has been around for a while, let
me go see...
