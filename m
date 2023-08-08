Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB9774AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjHHUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjHHUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A6211E92A;
        Tue,  8 Aug 2023 09:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AF56238B;
        Tue,  8 Aug 2023 06:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E904C433C8;
        Tue,  8 Aug 2023 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691475022;
        bh=EOGAaHCEP1owoAYsDzjK3qET7oP6l2+V/Y0rh3FHdLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9VfyL5O+92X/TbxQmSC8SpxCmww997RuNiU5C7Xlk8BOK+qKNNmMCgZzQ1/b2Na6
         4DlzEkK0Fki41R73GZAHXoieTxnYzvPn28GaTIk/oznq158pibD88Isse9K2sVOo4K
         azpa9Jj9IboFC4ttS87DfGUbW6scQPkzXy3xBu0U=
Date:   Tue, 8 Aug 2023 08:10:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Da Xue <da@libre.computer>
Cc:     Luke Lu <luke.lu@libre.computer>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: meson-g12a: do post init to fix broken usb
 after resumption
Message-ID: <2023080832-plated-slackness-20e4@gregkh>
References: <20230808032510.31754-1-luke.lu@libre.computer>
 <2023080851-duh-scroll-09bf@gregkh>
 <CACqvRUaK_Pj1DT4QY+YpKmvGeFqmM8KPcYWqTLNJoUJJaEbFAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACqvRUaK_Pj1DT4QY+YpKmvGeFqmM8KPcYWqTLNJoUJJaEbFAg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:33:45AM -0400, Da Xue wrote:
> On Tue, Aug 8, 2023 at 12:56 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 08, 2023 at 03:25:10AM +0000, Luke Lu wrote:
> > > Device connected to usb otg port of GXL-based boards can not be
> > > recognised after resumption, doesn't recover even if disconnect and
> > > reconnect the device. dmesg shows it disconnects during resumption.
> > >
> > > [   41.492911] usb 1-2: USB disconnect, device number 3
> > > [   41.499346] usb 1-2: unregistering device
> > > [   41.511939] usb 1-2: unregistering interface 1-2:1.0
> > >
> > > Calling usb_post_init() will fix this issue, and it's tested and
> > > verified on libretech's aml-s905x-cc board.
> > >
> > > Signed-off-by: Luke Lu <luke.lu@libre.computer>
> >
> > What commit id does this fix?  Should it also go to stable kernels?
> 
> Hi Greg,
> 
> Suspend device tree flag has not been enabled in-tree for the Amlogic
> GXL (S805X/S905X/S905D) series due it having PSCI 0.2 and thus never
> untested. Most of the suspend resume code was only tested on newer
> G12A/B series.
> 
> This and "[PATCH v3] net: phy: meson-gxl: implement
> meson_gxl_phy_resume()" fixes USB and Ethernet after resume. HDMI
> requires another fix.
> 
> It would be great if they could go into stable since we are carrying
> these two patches in our tree on 6.1 and they're applicable back to
> 5.4 but I am not sure what the criteria is.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
has the criteria.  If you think it should go there, then please resend
with a cc: stable tag in the signed-off-by area.

thanks,

greg k-h
