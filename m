Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB5769111
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGaJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGaJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:05:34 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF81BF3;
        Mon, 31 Jul 2023 02:04:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26892C000B;
        Mon, 31 Jul 2023 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690794271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paD0F/s5wQsBQRkvq2Qm1XvzYl6lyAfijOD4Z469+bg=;
        b=c6voLSKxaap6HO19TVEMxOT83kiXe89mF7goxSN642GXAjveLL4uvwUd39e//bf0qagWdj
        zoCVHbQXN1wxZlGPgzmq9+dPPIOhjJu17YxojI+7Lik2/ic4K/3mJVha8bktBEwGwsO8z0
        egRm2XJYEQgCMqEnBMIlUYAmRnq8mjuW5lwkrjrLWBJgJSKSMej9MUyiDdUN5gdVqqb6SR
        SKJ1GfUymyN3kETJWoboCQ0zHqGrncAm6ewQVjOVbZYLf5FnfVip36JmU+ImIl+n8a1htO
        6rox25xmQ3vF7juOlB2n5ZJuC/xEzEOiF/Pot45qQZSBGTwdtEKV30rLvDueUQ==
Date:   Mon, 31 Jul 2023 11:04:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: nand-controller: add
 nand-skip-bbtscan and nand-no-bbm-quirk DT options
Message-ID: <20230731110428.7d581494@xps-13>
In-Reply-To: <c919ba00-f741-33ff-cc6f-18988c52f14d@gmail.com>
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
        <20230718-curfew-jumble-aeafe95c5cc7@spud>
        <c919ba00-f741-33ff-cc6f-18988c52f14d@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan, Richard,

jbx6244@gmail.com wrote on Wed, 19 Jul 2023 21:39:24 +0200:

> On 7/18/23 17:46, Conor Dooley wrote:
> > On Sat, Jul 15, 2023 at 12:48:16PM +0200, Johan Jonker wrote: =20
> >> A NAND chip can contain a different data format then the MTD framework
> >> expects in the erase blocks for the Bad Block Table(BBT).
> >> Result is a failed probe, while nothing wrong with the hardware.
> >> Some MTD flags need to be set to gain access again.
> >>
> >> Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
> >> so that the original content is unchanged during the driver probe.
> >> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> >> the nand_erase_nand() function and the flash_erase command.
> >>
> >> Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
> >> so the user has the "freedom of choice" by neutral
> >> access mode to read and write in whatever format is needed.
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>
> >> Previous discussion:
> >> [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt opt=
ion
> >> https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.Jav=
aMail.zimbra@nod.at/
> >> ---
> >>  .../devicetree/bindings/mtd/nand-controller.yaml    | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yam=
l b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> >> index f70a32d2d9d4..ca04d06a0377 100644
> >> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> >> @@ -103,6 +103,19 @@ patternProperties:
> >>            the boot ROM or similar restrictions.
> >>          $ref: /schemas/types.yaml#/definitions/flag
> >>
> >> +      nand-no-bbm-quirk:
> >> +        description:
> >> +          Some controllers with pipelined ECC engines override the BB=
M marker with
> >> +          data or ECC bytes, thus making bad block detection through =
bad block marker
> >> +          impossible. Let's flag those chips so the core knows it sho=
uldn't check the
> >> +          BBM and consider all blocks good.

I am sorry but this is totally broken. We cannot just "consider all
blocks good".

> >> +        $ref: /schemas/types.yaml#/definitions/flag =20
> >=20
> > While this seems okay, as it seems to describe facet of the hardware...
> >  =20
> >> +      nand-skip-bbtscan:
> >> +        description:
> >> +          This option skips the BBT scan during initialization.
> >> +        $ref: /schemas/types.yaml#/definitions/flag =20
> >=20
> > ...this seems to be used to control the behaviour of software, and does
> > not describe the underlying hardware.
> >=20
> > Maybe I'm off, but the description of the property does not hint at the
> > aspect of the hardware that this addresses. =20
>=20
> Hi Conor,
>=20
>=20
> Thank you!
> Your point is correct.
> However I need both flags to change MTD software driver probe behavior in=
 case of formatting.
>=20
> Patch was made after comment by  Miquel:
> 'I would rather prefer a DT property which says "do not use the
> standard pattern".'
>=20
> DT should describe hardware and not software probe configuration.
> Currently not aware what other options we have for module parameters.
> Prefer my solution in the link. Could the MTD maintainer have a look agai=
n? Thanks!
> Please advise.

The more I think about this, the less I want to support it. You are
basically getting rid of any bad block support so in practice you don't
want to use mtd. Richard, what do you think? I have no strong opinion
about all this, but I just feel it's terribly wrong.

Thanks,
Miqu=C3=A8l
