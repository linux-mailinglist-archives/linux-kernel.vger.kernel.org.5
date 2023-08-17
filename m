Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD077F189
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbjHQHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbjHQHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:53:59 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE611F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:53:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 364C920002;
        Thu, 17 Aug 2023 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692258836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y9kGc2RBhJekPhE/ZBHeqd32/8mqgllFPcSU0IIs0Fk=;
        b=Yh09kVWnWuZjri18++nuXRkaOqk7DFLkpWQCoa7qYIGIjbpgKtn1y16DPiOaMeRKVsPtpw
        /mkar4X5B6MmQXVlvLp1j23dYyxxRvQUxedEMN0GIXCIJ8RdPaz8kkM1a2k1sDrOxZnpCS
        4ohDk32g9y+KtLbv+Xj5W/Ew6ibG3DEZjEYvEF0bIjl2WZj9pfwQ6mwni4jVHq3Y6oQIZ7
        xu4KO/dQi+urjpXULhsU4hOThSBJYohYmPmAGgmrj+yelimnHUxUucoNIQjcdcpBjbU9oX
        JBRS/Jx01GiojJnGYlkyQn7ETH3f5RrJ+2jaiZkcMPCyR6YqBEym+SItuyrshw==
Date:   Thu, 17 Aug 2023 09:53:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1] mtd: spinand: micron: correct parameters
Message-ID: <20230817095354.3df2f7f9@xps-13>
In-Reply-To: <53a4fe26-3a6a-47ce-8532-be60da674aca@kontron.de>
References: <20230815161024.810729-1-mmkurbanov@sberdevices.ru>
        <0f54b3dd-1fce-4f81-8652-d50fe1bb3873@kontron.de>
        <b619ef58-06c3-c61a-bb0f-ba243a4a2ade@sberdevices.ru>
        <53a4fe26-3a6a-47ce-8532-be60da674aca@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

frieder.schrempf@kontron.de wrote on Wed, 16 Aug 2023 17:35:56 +0200:

> On 16.08.23 17:28, Martin Kurbanov wrote:
> > Hi Frieder.
> >=20
> > On 16.08.2023 10:21, Frieder Schrempf wrote: =20
> >> I'm okay with 1. and with adjusting region->offset to 4. But I don't
> >> really get why we want to restrict the free oob data to the
> >> non-ECC-protected area only. Is this specific to Micron? Other SPI NAND
> >> drivers also spread the free area over both, the ECC-protected and the
> >> non-protected bytes. Why do it differently here? =20
> >=20
> > We encountered a problem with the JFFS2 file system: JFFS2 marks erased
> > blocks with a marker to avoid re-erasing them. To do this, it writes
> > a special marker (cleanmarker) in the free OOB area. And if this OOB
> > area is protected by ECC, the ECC will be written. However, during
> > the next write to the main area of the same block, the ECC will be
> > incorrect because it's necessary to program both the main area and
> > the OOB area at one programming time, so that the ECC parity code can
> > be calculated properly. Other SPI NAND flash also susceptible to
> > this problem. =20
>=20
> Thanks for the explanation. As this is a generic issue, we need to fix
> it in the core and not in the Micron driver.

It's not the first time we face this issue and the first approach we
used was to "fix" the OOB layout to include all free bytes (not only
protected bytes), which had the nice side-effect of allowing to write
the cleanmarker in an ECC-free area and allow that chip to be used with
JFFS2. This is indeed not a proper solution and I agree we should have
a system-wide solution.

> Also I wonder if JFFS2 should instead write the cleanmarker with ECC
> being turned of explicitly.

The real question is, why would you still want to use JFFS2 on
SPI-NAND? UBI is meant for that. JFFS2 was designed with NORs in mind,
it can be used on small NAND chips because UBI is a bit glutton wrt,
but I doubt we still have "small" SPI-NANDs on the market which require
JFFS2 anymore. Do we?

Anyhow, if people want JFFS2 on NANDs, I agree we should maybe change
how JFFS2 works and force raw accesses when it comes to writing the
cleanmarker, because there is no knowledge of what is ECC protected or
not in the current OOB layouts. I however have no idea of the possible
side-effects, I've never looked into JFFS2 so deeply.

> I don't know enough about NAND and JFFS2 to point out a correct fix, but
> I hope Miquel and Richard have some ideas.

Thanks,
Miqu=C3=A8l
