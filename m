Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110880A2C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjLHMFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjLHMFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:05:41 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689F1732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:05:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2109960002;
        Fri,  8 Dec 2023 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702037144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cb4XIiXdVUAfpnDEkvzJesxUepGgZi2akDCh/iP7gxw=;
        b=SXJsAH4LmYX6ecWJsWNxfTt0BBO/FKeGiy8zAOcXnCRdCUBd81h6XFfjGj53YuFj6X2qEl
        99cfYkVJAau+U5PbDLKqyP/kkA7iCoUzSfzlID8fU84Cd/OmCBQPrfqhUQXu3ImoHqgXsL
        JdG3glfHJhLz1S8nH3c8RzMZwUanFouUxEObOqqG7PCb18Uv7HTIqNl91C8uJehn/YUfRV
        gMS7zCyC4JoKvBtGo4rc5desJngmDZ36qijUxs/bBD5mC8/DMnbFxUSJMRHaWyXL4W4rW1
        x90AONEWjZM4RK0YTE7qGJOdwG088IQtuAUfwEUjtOYTQ56TeNayc/irMh/jig==
Date:   Fri, 8 Dec 2023 13:05:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v14 0/8] NVMEM cells in sysfs
Message-ID: <20231208130539.394c28d9@xps-13>
In-Reply-To: <170203247041.19230.6088380778885293722.b4-ty@linaro.org>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
        <170203247041.19230.6088380778885293722.b4-ty@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 08 Dec 2023 10:47:50 +0000:

> On Wed, 29 Nov 2023 17:37:29 +0100, Miquel Raynal wrote:
> > As part of a previous effort, support for dynamic NVMEM layouts was
> > brought into mainline, helping a lot in getting information from NVMEM
> > devices at non-static locations. One common example of NVMEM cell is the
> > MAC address that must be used. Sometimes the cell content is mainly (or
> > only) useful to the kernel, and sometimes it is not. Users might also
> > want to know the content of cells such as: the manufacturing place and
> > date, the hardware version, the unique ID, etc. Two possibilities in
> > this case: either the users re-implement their own parser to go through
> > the whole device and search for the information they want, or the kernel
> > can expose the content of the cells if deemed relevant. This second
> > approach sounds way more relevant than the first one to avoid useless
> > code duplication, so here is a series bringing NVMEM cells content to
> > the user through sysfs.
> >=20
> > [...] =20
>=20
> Applied, thanks!

Great! Thanks!

Miqu=C3=A8l
