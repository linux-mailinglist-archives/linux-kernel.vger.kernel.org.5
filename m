Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD4772386
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjHGMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjHGMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:11:45 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5CAE47
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:11:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B78A34000A;
        Mon,  7 Aug 2023 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691410261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zA0Pqt8JIxag0Qxf0Qj9I/LI0SmbQ7bxHc5QrMxN8pU=;
        b=A8gMQ035qKR7tPaLmCmG+XF1bt0w2wj91ufeIiUZM45cNeuwmFzd8N4jA8gPZmATF4UJBk
        0UFAuHIid6Ciha0Xwwc6MLB4PQhta/ufLaC2moy49vBRsxQkru4NOMU9t8fhlFX+WNj34N
        fJS/XGzBboxIWeO4wlFbMaBY+o107CDMGbh8n0onUqYPMMJcj8HTSg0srv8ei5GwUzMauF
        9FK/z5h5FqI0eZtcLyFLXVrmCpz01ZGNJkuDOrM/A8SsFb54hsx3f5eyGA07xvH0f5xBF7
        YrZM+O4AcTCMAJl+BstMoBy5xHn67c8irpbrqqgA5I0m9YeaktFXi9e6GJ/wMg==
Date:   Mon, 7 Aug 2023 14:10:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v8 4/8] nvmem: core: Track the registered devices
Message-ID: <20230807141057.64976ee1@xps-13>
In-Reply-To: <2023080732-gulp-pancake-93a5@gregkh>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
        <20230807082419.38780-5-miquel.raynal@bootlin.com>
        <2023080732-gulp-pancake-93a5@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, 7 Aug 2023 11:02:35 +0200:

> On Mon, Aug 07, 2023 at 10:24:15AM +0200, Miquel Raynal wrote:
> > Create a list with all the NVMEM devices registered in the
> > subsystem. This way we can iterate through them when needed (unused for
> > now).
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/nvmem/core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 257328887263..4e81e0aaf433 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -23,6 +23,7 @@
> >  struct nvmem_device {
> >  	struct module		*owner;
> >  	struct device		dev;
> > +	struct list_head	node;
> >  	int			stride;
> >  	int			word_size;
> >  	int			id;
> > @@ -76,6 +77,9 @@ static LIST_HEAD(nvmem_cell_tables);
> >  static DEFINE_MUTEX(nvmem_lookup_mutex);
> >  static LIST_HEAD(nvmem_lookup_list);
> > =20
> > +static DEFINE_MUTEX(nvmem_devices_mutex);
> > +static LIST_HEAD(nvmem_devices_list); =20
>=20
> But this list should already be in the driver core, why create
> yet-another-list-and-lock?

I did not think about using it. I believe you mean using
bus_for_each_dev() here? Could definitely make the trick; I'll try.

>=20
> Why is "when needed" not sufficient to use the list already present?
>=20
> And now note, you have the same structure on 2 different lists, watch
> out for device lifetime rules :(
>=20
> thanks,
>=20
> greg k-h


Thanks,
Miqu=C3=A8l
