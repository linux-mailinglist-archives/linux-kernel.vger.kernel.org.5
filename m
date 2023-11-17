Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1027EEF83
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjKQJ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjKQJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:58:19 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42986CE;
        Fri, 17 Nov 2023 01:58:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D1311C000C;
        Fri, 17 Nov 2023 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700215093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4oNQfBYlP0AUFjj519pmqm6CCbxiBl1lNX7nXCCgt0=;
        b=EVJLxhTOOVfvd33Q80JnB+XnSjByT68Q3jMleNJjJUxeIFxwaMM7KtWiP3rhrh17K7hJjl
        sCvVVbITb/hJeupyFUxjrBmn7Xn5shTxVixdaOAQYsm024OTXLKACmyT4/v3eeBoEQOGWz
        jDOUZlj/HXfFA6g3o+wz299a0RVrjBoAIrPXiqAzpTsRkS1e0vjhkmot05yXW43PhSclBr
        qSc2HZ0daoGKLuTZ7371FKP5/6qFozzliywTaE3KPTLI/NvIJ8wK2LQywM8W9k1AXLJ7bD
        EnGKye/pSQG8peGAvI9WQSCJGBiUXsZGcOs6E6WQNwWUOICxwo9fxfK2LMOxdA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 17 Nov 2023 10:58:12 +0100
Message-Id: <CX0ZY6JPH6HP.3JWUAN8KZ2SZB@tleb-bootlin-xps13-01>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>,
        "Pawel Laszczak" <pawell@cadence.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To:     "Peter Chen" <peter.chen@kernel.org>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 4/6] usb: cdns3: support power-off of controller when in
 host role
X-Mailer: aerc 0.15.2
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
 <20231114083838.GC64573@nchen-desktop>
 <CWYHLRBFE1X1.15330WETL2R7U@tleb-bootlin-xps13-01>
 <20231117033814.GA485583@nchen-desktop>
In-Reply-To: <20231117033814.GA485583@nchen-desktop>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri Nov 17, 2023 at 4:38 AM CET, Peter Chen wrote:
> On 23-11-14 12:10:18, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Tue Nov 14, 2023 at 9:38 AM CET, Peter Chen wrote:
> > > > +	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME)
> > > > +		cdns->xhci_plat_data->quirks |=3D XHCI_RESET_ON_RESUME | XHCI_SU=
SPEND_RESUME_CLKS;
> > > > +
> > >
> > > If you set this flag, how could you support the USB remote wakeup
> > > request? In that case, the USB bus does not expect re-enumeration.
> >=20
> > We didn't support remote USB wakeup. Only S2R mattered in our case and
> > USB remote wakeup wasn't a possibility.
>
> Without this patch, will below be hit for your platform:
>
> 	/* re-initialize the HC on Restore Error, or Host Controller Error */
> 	if (temp & (STS_SRE | STS_HCE)) {
> 		reinit_xhc =3D true;
> 		if (!xhci->broken_suspend)
> 			xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
> 	}

Yes it hits. The warning as well. How big of an issue is that?

My understanding is that this is the expected behavior with reset on
resume if we don't explicitely pass the flag XHCI_RESET_ON_RESUME. I
don't think we should be having the broken_suspend bit set as its
mentioning some specific quirk on AMD hardware.

Is the only expected difference inbetween having CDNS3_RESET_ON_RESUME &
not having it is resume time? For reference, the status read is 0x411
ie STS_HALT | STS_PCD | STS_SRE. xhc_state is zero.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
