Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330D7BBCC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjJFQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjJFQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:32:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D0C6;
        Fri,  6 Oct 2023 09:32:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0360E0002;
        Fri,  6 Oct 2023 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696609953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ttf6wkaFsFlxhmC0+pUMWKDP9EjjF8Omo60fPoYTBA=;
        b=LBhGuP6h8C7MbjZLCHnlJaBRcSAcqASBfIimdsaHAlR7ueGjO6eKSGmV7fs0KbgEv/bXRF
        72BgRQVk4Rvgn437fHLbpO9CRvVqz2dFWfUhgdvt/2x3vpwd2nJw8+h0WpWbzQU4+H+dpH
        lmCl7p6NvMbDslUCSyWw5/Grfq5A1/Mb9iODQbYPPPsUkcEuqdmj8eLwf52riEvqJsa/2D
        2sJnL05oPFNlCBbazjaDYwSDpljSq5mJf7zXgqP1YqVmelTdg/Hfb9F6rNShiGVrEKfsyr
        hMUbCK77GK6mcsTCdJ7TTesDX3Aes9ZN9qsx0+w3D4hDl6HJneviDfODH4WVGQ==
Date:   Fri, 6 Oct 2023 18:32:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 2/7] nvmem: Clarify the situation when there is no
 DT node available
Message-ID: <20231006183229.51cd8e60@xps-13>
In-Reply-To: <05cd4592d0cfe0fb86aeb24db01de547@milecki.pl>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-3-miquel.raynal@bootlin.com>
        <05cd4592d0cfe0fb86aeb24db01de547@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Fri, 06 Oct 2023 13:41:52 +0200:

> On 2023-10-05 17:59, Miquel Raynal wrote:
> > At a first look it might seem that the presence of the of_node pointer
> > in the nvmem device does not matter much, but in practice, after > look=
ing
> > deep into the DT core, nvmem_add_cells_from_dt() will simply and always
> > return NULL if this field is not provided. As most mtd devices don't
> > populate this field (this could evolve later), it means none of their
> > children cells will be populated unless no_of_node is explicitly set to
> > false. In order to clarify the logic, let's add clear check at the
> > beginning of this helper. =20
>=20
> I'm somehow confused by above explanation and code too. I read it
> carefully 5 times but I can't see what exactly this change helps with.
>=20
> At first look at nvmem_add_cells_from_legacy_of() I can see it uses
> "of_node" so I don't really agree with "it might seem that the presence
> of the of_node pointer in the nvmem device does not matter much".
>=20
> You really don't need to look deep into DT core (actually you don't have
> to look into it at all) to understand that nvmem_add_cells_from_dt()
> will return 0 (nitpicking: not NULL) for a NULL pointer. It's all made
> of for_each_child_of_node(). Obviously it does nothing if there is
> nothing to loop over.

That was not obvious to me as I thought it would start from /, which I
think some other function do when you don't provide a start node.

> Given that for_each_child_of_node() is NULL-safe I think code from this
> patch is redundant.

I didn't say it was not safe, just not explicit.

> Later you mention "no_of_node" which I agree to be a very non-intuitive
> config option. As pointed in another thread I already sent:
> [PATCH] Revert "nvmem: add new config option"
> https://lore.kernel.org/lkml/ba3c419a-6511-480a-b5f2-6c418f9c02e7@gmail.c=
om/t/

I actually wanted to find again that patch and could not get my hands on
it, but it is probably a much better fix than my other mtd patch, I
agree with you.

> Maybe with above patch finally things will get more clear and we don't
> need this PATCH after all?

Yes. Srinivas, what are your plans for the above patch?

Thanks,
Miqu=C3=A8l
