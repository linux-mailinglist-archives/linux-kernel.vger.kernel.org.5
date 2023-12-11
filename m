Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63680C692
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjLKKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLKKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:30:59 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48392D5;
        Mon, 11 Dec 2023 02:31:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6FB71BF206;
        Mon, 11 Dec 2023 10:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702290661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWTlNeIFjmJ3ht3J2R7jG8wNl/cHwH5GVR0Jqd4/24w=;
        b=X7SEk9ANBgIMGnxT4dzeCUTZ61TIqy7RYbSP1eVbTw1aBSi3NQ1048OsusBh0QOHjjzUu9
        sYthyizBu/CY8OBjR0WVvhMnJ0v/N6PF65ze+UNs15N+geiglqmQjGje+DAB1W3UQpwp1W
        4Wh55PVyLlsTDORnf28gWurV+nZpr9HXLbO0Z8OmDzPOmsbUTIcV3GiA5xXR4YBORDWznj
        M1i/F0zd60tR/kurO2aJf+U52cW+viykR5f31/W8NabHbkT9fZvpzm4uONLV673TrhSEpZ
        PO9fZAmadO/O/s5FWGOJ+mu918OimwmGypZtFv38R+5JZHyRD4mOM8MNl5rxeg==
Date:   Mon, 11 Dec 2023 11:30:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nvmem tree
Message-ID: <20231211113059.094f4226@xps-13>
In-Reply-To: <730b71e2-9c3c-4b40-86a6-0794615222fd@linaro.org>
References: <20231211164916.6f0d2357@canb.auug.org.au>
        <730b71e2-9c3c-4b40-86a6-0794615222fd@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Mon, 11 Dec 2023 10:23:40 +0000:

> Thankyou Stephen for the patch.
>=20
> On 11/12/2023 05:49, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the nvmem tree, today's linux-next build (i386 defconfig)
> > failed like this:
> >=20
> > /home/sfr/next/next/drivers/nvmem/core.c: In function 'nvmem_cell_put':
> > /home/sfr/next/next/drivers/nvmem/core.c:1603:9: error: implicit declar=
ation of function 'nvmem_layout_module_put' [-Werror=3Dimplicit-function-de=
claration]
> >   1603 |         nvmem_layout_module_put(nvmem);
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Caused by commit
> >=20
> >    ed7778e43271 ("nvmem: core: Rework layouts to become regular devices=
")
> >=20
> > I have applied the following patch for today.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 11 Dec 2023 16:34:34 +1100
> > Subject: [PATCH] fix up for "nvmem: core: Rework layouts to become regu=
lar devices"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >   drivers/nvmem/core.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 9fc452e8ada8..784b61eb4d8e 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -1491,6 +1491,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct devi=
ce_node *np, const char *id)
> >   	return cell;
> >   }
> >   EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
> > +
> > +#else /* IS_ENABLED(CONFIG_OF) */
> > +
> > +static inline void nvmem_layout_module_put(struct nvmem_device *nvmem)=
 { }
> > + =20
>=20
> I see no reason why nvmem_layout_module_put() should be even under IS_ENA=
BLED(CONFIG_OF).
>=20
> Updated the patch with this fixed.

Ok, works for me. I will send a fixup with the doc change (see the
other kernel test robot report) so you can squash it as well with the
original patch.

I am surprised we get these now, I actually pushed the branch on my
Github 0-day repository and got no negative report within 3 days.
Anyway, I guess they have to prioritize the requests.

Thanks,
Miqu=C3=A8l
