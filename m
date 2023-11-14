Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA97EAE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjKNLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:10:26 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CE8187;
        Tue, 14 Nov 2023 03:10:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEDEE1C0005;
        Tue, 14 Nov 2023 11:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699960220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZk2NG7LMF4weSGGvdqw6ZXKkgHMu8ga7kKv8OtqZLM=;
        b=bbntZNgUvrYTXujYXIPpbH9Qpd8qEzus+iOoYJzgOWMbiWXsGHdPzV8d+fWi2Z69Eu6i8s
        /iFV+vezys8YOQWFpGwTvq0RmuNmugyYopXkVhJXCs2y4+it7g9d4SWVFR397LSmA6zY3g
        ci45ynp9fRVauFc6nzm8QK9JVcYX7u2YdKooNCjo8sDI0iQCoafndVNT5rwPQUNYrpmaar
        CNDKcUdfumwvgDLBfIUkhm6Q+2PXSBER5rYWZlVyhvEBzO67xHwBWtQSOTA86keHYnS6V3
        +amL+d1/HM9Q4J9u5HasCznEUScCm9F0srD7h/iYzaz7nsOUzOV7uazUHHtlkg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 14 Nov 2023 12:10:18 +0100
Message-Id: <CWYHLRBFE1X1.15330WETL2R7U@tleb-bootlin-xps13-01>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 4/6] usb: cdns3: support power-off of controller when in
 host role
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
X-Mailer: aerc 0.15.2
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
 <20231114083838.GC64573@nchen-desktop>
In-Reply-To: <20231114083838.GC64573@nchen-desktop>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue Nov 14, 2023 at 9:38 AM CET, Peter Chen wrote:
> On 23-11-13 15:26:59, Th=C3=A9o Lebrun wrote:
> > The controller is not being reconfigured at resume. Change resume to
> > redo hardware config if quirk CDNS3_RESET_ON_RESUME is active.
>
> Current logic has power off judgement, see cdns3_controller_resume for
> detail.

Indeed! Thanks for the pointer. I had not noticed that, those patches
come from an older kernel which didn't have it. That'll make for less
changes; patches 4 & 5 can go away.

> > +	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME)
> > +		cdns->xhci_plat_data->quirks |=3D XHCI_RESET_ON_RESUME | XHCI_SUSPEN=
D_RESUME_CLKS;
> > +
>
> If you set this flag, how could you support the USB remote wakeup
> request? In that case, the USB bus does not expect re-enumeration.

We didn't support remote USB wakeup. Only S2R mattered in our case and
USB remote wakeup wasn't a possibility.

> > +static int cdns_host_resume(struct cdns *cdns, bool hibernated)
> > +{
> > +	return cdns_drd_host_on(cdns);
>
> This one will redo if controller's power is off, please consider both
> on and power situation.

Clearly. Can see that at runtime.

Thanks for the review!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
