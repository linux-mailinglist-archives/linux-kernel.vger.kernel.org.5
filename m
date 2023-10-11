Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57187C4B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjJKHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjJKHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:15:33 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDDCCA;
        Wed, 11 Oct 2023 00:15:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 872AB20008;
        Wed, 11 Oct 2023 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697008529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLic967F7xVWAQS01EJJVyWRdikOCnBlhxP8uIsZpxo=;
        b=ofek58a8XMiySPLmjgK3tew5LoJ1n8A6jKYGJoSWWmt45/+rNqpz/qH3SRSogulXulKS3m
        rw+ZIpvKGCWjd9GJ0Z5F2Dz3yf4WkIkFyTbf7Xq1DzNvrjbkDvpWxpeMcUEly86CAKkoe1
        S141GEc5bhbrtPeWLg7laiHNL1EbXgYy9HAu3fyPEz30+EG+xwzPJTZnGd+X4q/AHJBLkj
        KaY7KPXyRY1sijhH56hrbvg9onBH301bnia7fjgeaw4QEXrBRqkqwPV1wLo8BBYWupYti4
        jPEtb9fM9c2reiwx9MGBYGTBxC/ohFQDsmFKlsrkuJ7iGGvlwm/HA08gL/iv2Q==
Date:   Wed, 11 Oct 2023 09:15:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 7/7] nvmem: core: Expose cells through sysfs
Message-ID: <20231011091524.0c9ecc55@xps-13>
In-Reply-To: <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-8-miquel.raynal@bootlin.com>
        <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

> > +{
> > +	struct bin_attribute **cells_attrs, *attrs;
> > +	struct nvmem_cell_entry *entry;
> > +	unsigned int ncells =3D 0, i =3D 0;
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +
> > +	if (list_empty(&nvmem->cells) || nvmem->sysfs_cells_populated) {
> > +		nvmem_cells_group.bin_attrs =3D NULL;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	/* Allocate an array of attributes with a sentinel */
> > +	ncells =3D list_count_nodes(&nvmem->cells);
> > +	cells_attrs =3D devm_kcalloc(&nvmem->dev, ncells + 1,
> > +				   sizeof(struct bin_attribute *), GFP_KERNEL);
> > +	if (!cells_attrs) {
> > +		ret =3D -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	attrs =3D devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribu=
te), GFP_KERNEL);
> > +	if (!attrs) {
> > +		ret =3D -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	/* Initialize each attribute to take the name and size of the cell */
> > +	list_for_each_entry(entry, &nvmem->cells, node) {
> > +		sysfs_bin_attr_init(&attrs[i]);
> > +		attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> > +						    "%s@%x", entry->name,
> > +						    entry->offset);
> > +		attrs[i].attr.mode =3D 0444;
> > +		attrs[i].size =3D entry->bytes;
> > +		attrs[i].read =3D &nvmem_cell_attr_read;
> > +		attrs[i].private =3D entry;
> > +		if (!attrs[i].attr.name) {
> > +			ret =3D -ENOMEM;
> > +			goto unlock_mutex;
> > +		}
> > +
> > +		cells_attrs[i] =3D &attrs[i];
> > +		i++;
> > +	}
> > +
> > +	nvmem_cells_group.bin_attrs =3D cells_attrs;
> > +
> > +	ret =3D devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
> > +	if (ret)
> > +		goto unlock_mutex; =20
>=20
> This is going to create groups after the nvmem device is added, isn't thi=
s going to be problem with user space notifications?

Greg said it was not. I hope I understood correctly :-)

And anyway, cells have never been available to userspace, so there is
nothing userspace might expect yet?

Thanks,
Miqu=C3=A8l
