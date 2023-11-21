Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9C7F2950
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjKUJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjKUJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:49:38 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1210FA;
        Tue, 21 Nov 2023 01:49:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBD971C0018;
        Tue, 21 Nov 2023 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700560158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVEkp3Bfnnrh5RJDI1Xlb1Qdj4wYUKQF4xGHxqUM4cQ=;
        b=JmBUpE9uq6PZ+X/WdiEJxaNOlOT8Fqf1XyntNBFDTBO7n8bYWBZVQ9NmcCr9dcUNnlzU3y
        lM5xsFAHAi/WN7P//bc7ThdqCIJDrAaOJR7N4p7FzT01P7hJrU0gw7jyz8OyK/ALnBVvOC
        8tLbZxeMID73FdYMAG55Ps5UERQgLPzQPbiDMa22dScue550yU1zAapvMgsuD7Buofw5FN
        kwV+8N/JOjcUutaNpe+2JCgSR3m7BPX6zO+Rvk7r+vbnUgYB9BChLCdmagG4o8IKiD9aOZ
        Ik1HIxwRxiumBRKQAve8v1CHCdKXsRRVCZlAMHWOEHXYlM2n1RrrZicYg8L6jg==
Date:   Tue, 21 Nov 2023 10:49:17 +0100
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
Message-ID: <20231121104917.0fd67952@kmaincent-XPS-13-7390>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thinh,

On Fri, 17 Nov 2023 01:55:30 +0000
Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> > How many ports do you use? Can you try this:
> >=20
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 0328c86ef806..9921c2737829 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -296,23 +296,28 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
> >  	if (dwc->dr_mode =3D=3D USB_DR_MODE_HOST) {
> >  		u32 usb3_port;
> >  		u32 usb2_port;
> > +		int i;
> > =20
> > -		usb3_port =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> > -		usb3_port |=3D DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > -		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
> > +		for (i =3D 0; i < 16; i++) {
> > +			usb3_port =3D dwc3_readl(dwc->regs,
> > DWC3_GUSB3PIPECTL(i));
> > +			usb3_port |=3D DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > +			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i),
> > usb3_port);=20
> > -		usb2_port =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> > -		usb2_port |=3D DWC3_GUSB2PHYCFG_PHYSOFTRST;
> > -		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
> > +			usb2_port =3D dwc3_readl(dwc->regs,
> > DWC3_GUSB2PHYCFG(i));
> > +			usb2_port |=3D DWC3_GUSB2PHYCFG_PHYSOFTRST;
> > +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i),
> > usb2_port);
> > +		}
> > =20
> >  		/* Small delay for phy reset assertion */
> >  		usleep_range(1000, 2000);
> > =20
> > -		usb3_port &=3D ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > -		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
> > +		for (i =3D 0; i < 16; i++) {
> > +			usb3_port &=3D ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
> > +			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i),
> > usb3_port);=20
> > -		usb2_port &=3D ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
> > -		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
> > +			usb2_port &=3D ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
> > +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i),
> > usb2_port);
> > +		}
> > =20
> >  		/* Wait for clock synchronization */
> >  		msleep(50);
> > -- =20

Still not working on my side.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
