Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3A7EAEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjKNLNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjKNLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:13:32 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193DD9;
        Tue, 14 Nov 2023 03:13:29 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6601EC0003;
        Tue, 14 Nov 2023 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699960408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/R9B48pZCN9c3ng90NhzhrOB0SxCjUhVVsxdxdwVKGU=;
        b=Tklh3XJCMrk+4MzU9ju3l+yLDIVz5pQuci3HN85cZoosD3azWS6w4TrPc0Cxnc0l18TQkc
        Sy4YHLNQ6LbKuDszmwp+ovxh3W3EsnXQiKi0bfbodgqafoBRIqLaCE+WWRTNi4BKxFmN/o
        puKZbP9v3EXcwLuvtjB0bsfRuWtDa+18jNJof0pHnt8aHVhUXC49PQNLTT+bSBDxAuEeyJ
        elvRmL3CvuE3LJuuWJyIAtuyf6/OAFMPh4rpeMi4JaFY8RznWZ1011eRBKqIhrJjXNtyRY
        jnBbSc3kGviOlJt4PEWIncyw9ELGCkoqtw4yRFO1G9dlqm4P2JQh0HxH1UDenQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 14 Nov 2023 12:13:26 +0100
Message-Id: <CWYHO5EGLYQ8.19W6XQHV61VEL@tleb-bootlin-xps13-01>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/6] usb: cdns3-ti: add suspend/resume procedures for
 J7200
Cc:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        "Pawel Laszczak" <pawell@cadence.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-3-ad1ee714835c@bootlin.com>
 <87zfzh64t6.fsf@BL-laptop>
In-Reply-To: <87zfzh64t6.fsf@BL-laptop>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon Nov 13, 2023 at 4:39 PM CET, Gregory CLEMENT wrote:
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index c331bcd2faeb..50b38c4b9c87 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > @@ -197,6 +197,50 @@ static int cdns_ti_probe(struct platform_device *p=
dev)
> >  	return error;
> >  }
> > =20
> > +#ifdef CONFIG_PM
> > +
> > +static int cdns_ti_suspend(struct device *dev)
> > +{
> > +	struct cdns_ti *data =3D dev_get_drvdata(dev);
> > +
> > +	if (!of_device_is_compatible(dev_of_node(dev), "ti,j7200-usb"))
> > +		return 0;
>
> Just a small remark:
>
> What about adding a boolean in the cdns_ti struct for taking care of
> it ? Then you will go through the device tree only during probe. Moreover
> if this behaviour is needed for more compatible we can just add them in
> the probe too.

Will do. The hardest part will be to pick a good name.

> Besides this you still can add my
>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks for the review.

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
