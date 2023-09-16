Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA657A30F5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbjIPOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjIPOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 10:46:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294218E;
        Sat, 16 Sep 2023 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=kKrlL3psbhaCacm+GqwkX8wPmM3l79IE3hZOV3TRBaI=; b=zE
        HVhZz4uTqMJMVJcu3KYGmi2MLjVRMMHNyLX6kcjia1n2F2IQc5io9HeXGOfGGKvZH8iRZIPVZcp77
        LYzk7HhHXaOsCZo9gQEC4pSqcpkLutxR9IK8JXRLqlbCiDWp1ZE+40PSHsw0ZI0x9t45osDZMRWM0
        Cd2D5NLvGyYD+O8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qhWZ9-006dsL-DM; Sat, 16 Sep 2023 16:46:35 +0200
Date:   Sat, 16 Sep 2023 16:46:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Louis-Marie <rauline.lm@protonmail.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        Antonio Napolitano <anton@polit.no>,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Gaul <gaul@gaul.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Nicolas Dumazet <ndumazet@google.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hannu Hartikainen <hannu@hrtk.in>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>
Subject: Re: Lenovo Hybrid Dock MAC passtrough patch
Message-ID: <a4d79eb6-ebab-4a7e-9b57-81c8e68b7c41@lunn.ch>
References: <guK8MKcjWbPsZ1LuRVYxFf7WfsWa025shmVj7iq289LHf59N6i6OlkD0N9KhICJzbMfFW2aXYbguZ1NtZNn6PlA_-JvF3k7uJtG89THdZ6w=@protonmail.com>
 <ZQWcQTQahx-QEGDl@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQWcQTQahx-QEGDl@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 07:14:57PM +0700, Bagas Sanjaya wrote:
> On Sat, Sep 16, 2023 at 11:41:49AM +0000, Louis-Marie wrote:
> > Hi,
> > I would like to submit a patch for enabling mac passtrough for the Lenovo Hybrid Dock.
> > Tested with Fedora 6.4.12.
> > 
> > 
> > 
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.cindex 0c13d9950cd8..02e6404bf6ea 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> > @@ -781,6 +781,7 @@ enum rtl8152_flags {
> >  #define DEVICE_ID_THINKPAD_USB_C_DONGLE            0x720c
> >  #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2     0xa387
> >  #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3     0x3062
> > +#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK       0xa359
> > 
> >  struct tally_counter {
> >     __le64  tx_packets;
> > @@ -9583,6 +9584,7 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
> >         case DEVICE_ID_THINKPAD_THUNDERBOLT3_DOCK_GEN2:
> >         case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
> >         case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
> > +       case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
> >         case DEVICE_ID_THINKPAD_USB_C_DONGLE:
> >             return 1;
> >         }
> > @@ -9832,6 +9834,7 @@ static const struct usb_device_id rtl8152_table[] = {
> >     { USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
> >     { USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
> >     { USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
> > +   { USB_DEVICE(VENDOR_ID_LENOVO,  0xa359) },
> >     { USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
> >     { USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
> >     { USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 15e9bd180a1d..ad98c8ffbc69 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -470,6 +470,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> >     /* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
> >     { USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
> > 
> > +   /* Lenovo ThinkPad Hydrid USB-C Dock */
> > +   { USB_DEVICE(0x17ef, 0xa359), .driver_info = USB_QUIRK_NO_LPM },
> > +
> >     /* BUILDWIN Photo Frame */
> >     { USB_DEVICE(0x1908, 0x1315), .driver_info =
> >             USB_QUIRK_HONOR_BNUMINTERFACES },
> > 
> > Signed-off-by: Louis-Marie Rauline <rauline.lm@protonmail.com>
> > 
> 
> Can you send above suggestion as formal patch instead? See
> Documentation/process/submitting-patches.rst for how to properly submit
> patches. And also, use git-send-email(1) when sending them so that patch
> corruption (like tabs converting to spaces and line wrapping as in above
> diff) doesn't occur.
> 
> Thanks.

This appears to do more than MAC passthrough, e.g. adding a quirk for
LPM. Please split the patch up. The MAC passthrough part is likely to
be rejected, because MAC pass through is a mess, but the quirk part
looks O.K.

      Andrew
