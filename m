Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D669803AD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjLDQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjLDQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:51:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA7AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:51:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BDCC433C7;
        Mon,  4 Dec 2023 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701708700;
        bh=fFXmEBT5AMl/e+v8v12kevHaf03zfjvJ1t3IxHwqbNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ba7t9+j+aC25aU7nX6xksyw/rfPPpMj8n/VfYLO3TpnArg0UAv+E45421nE8y0/MD
         X/gOjv+U2EF1gFDddOk4wwf1RH2PkfuK7S4A0l8V4DZOOM/QRmWZRuQKeIdMjPjZYq
         +48Nn6abrEeP3GxF0y2czaNjOvlsx+Ui2CNXmL9ztENe4cWVShNwgwUtcIvaZRd+C3
         XVe9xHXL0/5+Mzx3NiNSr+N8KWkW6mUYUAEP0ZT4EK+qFJsLUbcDyBSSap4l6FeqAV
         FWW4fvXp4I65VA03n8S1icgb0ke9JYVz+nBnRAdwp7ekbD+PKW0ugEa0hGxlwpX3FH
         lc0IBcv3zSBww==
Date:   Mon, 4 Dec 2023 16:51:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct
 ad9467_state
Message-ID: <20231204165129.130e189c@jic23-huawei>
In-Reply-To: <69a7ca77055fc57cff6d6be95fb5796723171230.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
        <20231204152301.6c212539@jic23-huawei>
        <69a7ca77055fc57cff6d6be95fb5796723171230.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 17:10:01 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-12-04 at 15:23 +0000, Jonathan Cameron wrote:
> > On Tue, 21 Nov 2023 11:20:19 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> > > are done which means we need to properly protect the whole operation =
so
> > > we are sure we will be in a sane state if two concurrent calls occur.
> > >=20
> > > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad9467.c | 6 +++++-
> > > =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 04474dbfa631..91821dee03b7 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -4,7 +4,7 @@
> > > =C2=A0 *
> > > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > > =C2=A0 */
> > > -
> > > +#include <linux/cleanup.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h>
> > > =C2=A0#include <linux/device.h>
> > > @@ -122,6 +122,8 @@ struct ad9467_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0output_mode;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct gpio_desc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0*pwrdown_gpio;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* protect against concurr=
ent accesses to the device */ =20
> > Not very specific.=C2=A0 Concurrent access usually fine at granularity =
of
> > individual read/write as the bus locks protect it.=C2=A0 What state
> > is actually being protected?=C2=A0 A shared buffer or some state that we
> > need to ensure remains consistent between driver and device? =20
>=20
> At this point not any buffer/data... Just making sure things remain consi=
stent
> (typical case when you have multiple reads/writes to the device). That's =
why a tried
> to emphasize "accesses to the device". Maybe I should make it explicit I'=
m speaking
> about multiple reads/writes.

Talk about the data or state rather than the access to it.
Something like
'ensure consistent state obtained on multiple related accesses.'
Or if it's RMW then say that.
>=20
> - Nuno S=C3=A1
> >  =20
>=20

