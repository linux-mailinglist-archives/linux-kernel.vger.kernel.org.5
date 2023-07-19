Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7A758FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGSINg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:13:33 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE00197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:13:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFDF8FF804;
        Wed, 19 Jul 2023 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689754410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dd+zfI16pEx3BXTsAYCbZH3BDKP24/m6t4MEhjKwt/U=;
        b=nEkasCgFCgPjlAFkMM0ll8UnmJ9jTxA7HzkaHB9GQ10Ky9SpVpaoBDcgD3B/C4HCpx4HfB
        A4lRl9mY231e/7ksyJkVEUMVzIVIiSYodf1mek4y0cB1cEmFYEUFYHGFmnU3QPLodJM420
        T3oNvWOnmMShHrwnRwZaGQl6d+H6b+nDUgXkOWfgWPl+DzjOx9IHFoV7LadlJ+fxRm4VxV
        T1WiqOMIU9WuF4nt284CDA4vyZdYpaOGo+wB0rpZM3gYE47wYGYrsd/odOK96nY5Nnfmhf
        Y7bFHPt4V/degW7FOlWczukG/KceX/T0t/AEmx0Ck9vjcgxQsIFhkjIh6XWXyQ==
Date:   Wed, 19 Jul 2023 10:13:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: core: clear sysfs attributes for each NVMEM
 device
Message-ID: <20230719101327.25b9ee7a@xps-13>
In-Reply-To: <ZLavw9ZyXMWMqTu_@makrotopia.org>
References: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
        <e155a4bf-46b7-c07a-f3e0-80fae8108f56@linaro.org>
        <ZLavw9ZyXMWMqTu_@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Tue, 18 Jul 2023 16:29:07 +0100:

> On Tue, Jul 18, 2023 at 03:55:56PM +0100, Srinivas Kandagatla wrote:
> > HI Daniel,
> >=20
> > On 18/07/2023 14:55, Daniel Golle wrote: =20
> > > Set nvmem_cells_group.bin_attrs to NULL in case of an NVMEM device not
> > > having any cells in order to make sure sysfs attributes of a previous=
ly
> > > registered NVMEM device are not accidentally reused for a follow-up
> > > device which doesn't have any cells.
> > >=20
> > > Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs") =20
> >=20
> > These patches are dropped out of nvmem next branch as it was breaking s=
ome
> > existing users. =20
>=20
> Ok. I've encountered those commits in linux-next and can confirm that
> they were definitely also breaking things here, hence my patches at
> least partially fixing that.
>=20
> I agree that reverting them for now and reworking them seems to be the
> better option in this case, hence my patches won't be needed as such.

Quite the opposite, on my setup I don't have any breakage but as you
already fixed the cell name issue (also reported by Chen-yu), if you
agree, I will include these fixes (or an improved version) in my next
proposal.

Thanks,
Miqu=C3=A8l
