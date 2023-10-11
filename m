Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8EE7C50AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjJKK7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346641AbjJKK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:59:06 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3A92;
        Wed, 11 Oct 2023 03:59:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66B07FF80A;
        Wed, 11 Oct 2023 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697021943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgoGY8ul0lSIdXFoxr+/I0RYC9e4Hx1h3Y0uNGEGlrU=;
        b=OeIQh85t+T0KKgIbElD8x57btZYA7ztF4sNusvphfF19MQzs9moZpFj6lNBVF29Ext5FmO
        3No3s6AwC51TU9yeP6Svoi3KgE5qeZ/pvajCRyHUns3cHo+Erol7iGkKiCWau/pRBYPI7o
        NpVql/WHDm3Q5UK7guhJwdghkC3k+4QisqDz+6nBO9i3k8ljYoryE2G5q/XivrNBZ3qOFF
        +6skM/G2BtnhtOsmtngqovmp4PsdvWASrMD9SiWx0UUkHTopVneVnMq/4jqYct9mCoqOza
        96vgxGMre3hQeMhmQcEIeuEs1abh3xAznpI0xs/Va0OeezAIkSUuXNNwAUumUA==
Date:   Wed, 11 Oct 2023 12:58:59 +0200
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
Subject: Re: [PATCH v12 5/7] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <20231011125859.1647c08c@xps-13>
In-Reply-To: <04112100-026c-b010-6e8c-730049d43e47@linaro.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-6-miquel.raynal@bootlin.com>
        <dc96ddb1-502c-e643-7749-d057d1fc6490@linaro.org>
        <20231011093843.49831a75@xps-13>
        <04112100-026c-b010-6e8c-730049d43e47@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

> > you don't have access to your modules. And anyway it's probably a bad
> > idea to allow endless probe deferrals on your main storage device.
> >=20
> > If the cells are not available at that time, it's not a huge deal? The
> > consumers will have to wait a bit more (or take any other action, this
> > is device dependent). =20
>=20
> In this case the nvmem consumers will get an -ENOENT error, which is very=
 confusing TBH.

Maybe we can solve that situation like that (based on my current
series):

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1448,7 +1448,10 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_n=
ode *np, const char *id)
        of_node_put(cell_np);
        if (!cell_entry) {
                __nvmem_device_put(nvmem);
-               return ERR_PTR(-ENOENT);
+               if (nvmem->layout)
+                       return ERR_PTR(-EAGAIN);
+               else
+                       return ERR_PTR(-ENOENT);
        }
=20
        cell =3D nvmem_create_cell(cell_entry, id, cell_index);


So this way when a (DT) consumer requests a cell:
- the cell is ready and it gets it
- the cell is not ready and...
   - the cell comes from a layout -> we return EAGAIN, which
     means the cell is not yet ready and this must be retried later
     (the caller may return EPROBE_DEFER in this case).
   - the cell is simply missing/not existing/not available, this is a
     real error.

What do you think?

Thanks,
Miqu=C3=A8l
