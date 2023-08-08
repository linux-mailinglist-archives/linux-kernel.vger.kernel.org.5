Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740077475D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjHHTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjHHTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C690A9;
        Tue,  8 Aug 2023 09:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D8E62430;
        Tue,  8 Aug 2023 08:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2BCC433CB;
        Tue,  8 Aug 2023 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691482631;
        bh=K20OPC5mIbzsPiYWUHqX9jSEjf0CZwpl3w8OqWWhKfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzyFfvsqOn2SmKgAq45rOvihS03doRh6QVDx0L+nurJuDyOhD0o9FSNMIPMledtLZ
         4yVhXcVtf+iv4AKdL45Nuk1EOLhr47xyrvoxYA4/EurbRJWZCJAme15gWcwnynYLIq
         X0wCYloPOy0wX9q0pAOQPvWCvzQXrZTizIRlG9mY=
Date:   Tue, 8 Aug 2023 10:17:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luke Lu <luke.lu@libre.computer>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: meson-g12a: do post init to fix broken usb
 after resumption
Message-ID: <2023080852-estranged-limpness-aafb@gregkh>
References: <20230808032510.31754-1-luke.lu@libre.computer>
 <2023080851-duh-scroll-09bf@gregkh>
 <CAAzmgs5U=BNzNNeskUMe_YEken1-CmzssRFPDCmsmar9SQo+WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAzmgs5U=BNzNNeskUMe_YEken1-CmzssRFPDCmsmar9SQo+WQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:09:45AM +0000, Luke Lu wrote:
> HI Greg:
> 
> On Tue, Aug 8, 2023 at 4:56 AM Greg Kroah-Hartman
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
> > What commit id does this fix?
> Using "git blame" to explore the history, found dwc3_meson_g12a_resume() was
> introduced along with the file of drivers/usb/dwc3/dwc3-meson-g12a.c.
> as Da Xue pointed out, the suspend/resume was never tested in GXL based SoC,
> so it's broken since the beginning..
> 
> For the Fixes tag, I think it's proper to use "5b0ba0caaf3a: (usb:
> dwc3: meson-g12a: refactor usb init)"
> since the usb_post_init() function was introduced in this commit and
> this patch will depend on it.
> 
> > Should it also go to stable kernels?
> >
> Yes, It would be great if the patch can go to stable tree, thanks for
> suggesting this
> I have it tested on 6.1-lts tree.
> 
> Btw, I would wait for a few days for more comments and CC to stable in
> next v2 if no objection.

No worries, I'll drop this from my review queue and wait for a v2.

thanks,

greg k-h
