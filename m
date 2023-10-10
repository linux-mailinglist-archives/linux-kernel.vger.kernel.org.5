Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC89B7BFF97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjJJOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjJJOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:49:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7EAC;
        Tue, 10 Oct 2023 07:49:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0000C433C9;
        Tue, 10 Oct 2023 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696949369;
        bh=0KXvobl/M1Y6Mk3dGlW7f5LiAx1FlA/lSITdnL1j2E0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DdnJSw8J4JVDDIKJY/bZVVkcsFGN0n9hwiZzYyDSGxRRrXLFIqkOyI2aKWJR66AiZ
         37KvoEDHBBfRqKZUgmNS/rjfRybZb/is502JeVlTwwclTFI3tOeo5DKL67m33MxVq9
         UH7y4b5EVp6UvTSRPlUptKl4XMeZTCtzkHruvugBpnBVmJPioAcLTK1SDh191H95Vj
         8rlVGEmHERWpcCNepA7RPBIMnSB532XLoPl5LgMo4nDfedmtRwKG4k9LOBSA23AD9m
         Fgn23m5sgUn8VrghBi6VpmfLyKog+cEzl6654hdkZN8vK9g/nh8eJ3L8dV5hz/ydP+
         m3o1E4G/z3pUw==
Date:   Tue, 10 Oct 2023 15:49:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20231010154942.20737f17@jic23-huawei>
In-Reply-To: <83bb2425-aff1-6359-37f4-4182d4f8ed05@tweaklogic.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
        <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
        <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
        <83bb2425-aff1-6359-37f4-4182d4f8ed05@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 22:48:43 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 10/10/23 19:22, Matti Vaittinen wrote:
>=20
> >> +properties:
> >> +=C2=A0 compatible:
> >> +=C2=A0=C2=A0=C2=A0 const: avago,apds9306 =20
> >=20
> > I see the driver supports two different variants of this IC, differenti=
ated by the part-ID register. Variants are named as apds9306 and apds9306-0=
65. I wonder if we could/should have different compatibles for them?
> >  =20
>=20
> Yes, we can. It makes sense. I'll implement that.
We could.  The reason to do so is that we might in future want to use
fallback compatibles.  So we want to allow a new DT to work with older
kernel by saying - I have a new device, but it is fully compatible with
this earlier one.  In those cases we check the ID as your driver current
does, but just print a warning that we aren't sure what the device is so
are going with what the DT told us to fall back to.

Jonathan

>=20
> Regards,
> Subhajit Ghosh
>=20

