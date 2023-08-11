Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C11778FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjHKMi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:38:25 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D2730C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:38:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BAD160008;
        Fri, 11 Aug 2023 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691757503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzaCKTGz2sPx6OTPXSZ8wj/VVvy6e53lpSCJsrwlWFE=;
        b=aXhkgxdCHezeh8D5FzId75JChuUm1RwyLyO+ALkTBeuAAjMoJjbGZwdPfW0mTY6aB2omrs
        PeVNci4QGNHEsS026jsZhmSIjtKzgBkjCzL/ZHSqP0JPsJ7YWEGaLjnVJuJ63k2YEWvOKN
        2RiMr4sczB0GltBBVqh5V6XZo2x3Xe1F6610YRhoaui50Y8MrGLbKLIBY8iixG2LCqGl1u
        2taFYcVROyf49qy11c2COcwhW4g78dOa5eTz88nLVMjNY97iDCSPvvX75I1cAFbzfGsRir
        UKT5IYGyy7oWrf3tWDhbIeOHBNwPLFjXc4LLU+pjpAae5JjC+BRqf3MPIHKhnw==
Date:   Fri, 11 Aug 2023 14:38:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v9 1/7] nvmem: core: Create all cells before adding the
 nvmem device
Message-ID: <20230811143821.29cf335a@xps-13>
In-Reply-To: <154883fc-a6bc-01a9-b044-dac8848e9963@linaro.org>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
        <20230808062932.150588-2-miquel.raynal@bootlin.com>
        <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
        <20230808092433.039e2f48@xps-13>
        <05aea50f-6692-962e-abe7-765197815f03@linaro.org>
        <20230811141122.7921df1d@xps-13>
        <154883fc-a6bc-01a9-b044-dac8848e9963@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 11 Aug 2023 13:26:24 +0100:

> On 11/08/2023 13:11, Miquel Raynal wrote:
>=20
> >>
> >> =20
> >=20
> > nvmem_register() calls device_initialize() and later device_add(),
> > which is exactly the content of device_register(). Upon error
> > after device_add(), we currently call device_put(), whereas
> > device_unregister would call both device_del() and device_put().
> >=20
> > I would expect device_del() to be first called upon error before
> > device_put() *after* device_add() has succeded, no? =20
>=20
> That is correct afaiu, if device_add is succeed we need to call device_de=
l(). As the patch now moved the device_add to end of function we really do =
not need device_del() in err path.

Right, I'm looking at the end of the series where I need to add
device_del() in the error path because something gets added after
device_add(). So we are aligned, thanks for the feedback.

> >>> I also see the layout_np below should be freed before jumping in the
> >>> error section. =20
> >>
> >> you mean missing of_node_put()? =20
> >=20
> > Yes, I need to call of_node_put() before jumping into the error path. =
=20
>=20
> Are we not already doing it in nvmem_layout_get() and nvmem_add_cells_fro=
m_fixed_layout() ?

We perform the layout_get for two reasons:
- knowing if there is a layout
- using the layout
Here we are in the first case, and we don't want to retain a reference
from here. Only in the second case.

Thanks,
Miqu=C3=A8l
