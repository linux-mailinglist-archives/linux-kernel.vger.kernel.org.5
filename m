Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04A7EEE61
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjKQJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:22:15 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6450D4F;
        Fri, 17 Nov 2023 01:22:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65A161BF204;
        Fri, 17 Nov 2023 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700212929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcSMTVB65o0CxA6LAXq51wxe965CmzOoRMyEDRoNDwc=;
        b=oDXdhePaO7wWX8F93nJ220tXSO0PAnWJjCQXdgsljT6UenIxwl0SCHqosxQk1iqgDoajfk
        9hr9TMOK0OP/aoIFj0H1vNVPBf1g+StIMk8UEAVg8EHDy21D1l2cJt7fMUuFU3+yMFYiTz
        33dZxDzu13Dg8X/hjDFJFhJF3B7FeeB0nirLAZQ9v0L4QwDHBQxRHcaglAqOSR2dDUdll1
        iEqgkBpelCoCeVpUAuRGnkt3YPGDvO0hM75voX3OA9+BOSxw8yN8Hml2f+ERbltwJq3RXu
        Hfm8BXklFg1Rzgf2Oop0Pn9knC6cPfpbPBmUc98JyaSjBdcptOK1Tu9jRxJSRw==
Date:   Fri, 17 Nov 2023 10:22:08 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Message-ID: <20231117102125.44995ad7@kmaincent-XPS-13-7390>
In-Reply-To: <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
        <20231116175959.71f5d060@kmaincent-XPS-13-7390>
        <20231117014038.kbcfnpiefferqomk@synopsys.com>
        <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thinh,

On Fri, 17 Nov 2023 01:55:30 +0000
Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> Hi,
>=20
> Sorry, email client issue with your email. Attempt to resend:

Thanks for your quick reply.

>=20
> On Fri, Nov 17, 2023, Thinh Nguyen wrote:
> > Hi,
> >=20
> > On Thu, Nov 16, 2023, K=C3=B6ry Maincent wrote: =20
> > > On Thu, 16 Nov 2023 17:42:06 +0100
> > > K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:
> > >  =20
> > > > Hello,
> > > >=20
> > > > Similar issue with ZynqMP board related to that patch:
> > > >=20
> > > > xilinx-psgtr fd400000.phy: lane 3 (type 1, protocol 3): PLL lock ti=
meout
> > > > phy phy-fd400000.phy.3: phy poweron failed --> -110
> > > > dwc3 fe300000.usb: error -ETIMEDOUT: failed to initialize core
> > > >=20
> > > > With CONFIG_USB_DWC3_DUAL_ROLE and dr_mode =3D "host";
> > > >=20
> > > > It may not be the correct fix. =20
> > >=20
> > > Just figured out there was a patch (357191036889 usb: dwc3: Soft reset
> > > phy on probe for host) from Thinh aimed to fix it but the issue is st=
ill
> > > here on ZynqMP.
> > >  =20
> >=20
> > How many ports do you use? Can you try this:

I am using 2 ports.
I will test it out next week as I don't have access to the board until then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
