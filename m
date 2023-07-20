Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C5675A9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGTI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGTIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:48:43 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96163268E;
        Thu, 20 Jul 2023 01:48:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82B48E0008;
        Thu, 20 Jul 2023 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689842919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vd+lEU5Fl2TIPJ8xcsPnSNyWBBTcuOGxPgWz+JpFHhw=;
        b=TZpvZBP8z4VFpjhk1aMn9VASAw7o2tzmqRsxhui1u5vEMZ+6NllUmhF29PK0aQqjn/ZeAM
        YaoqVo/39UESzDb9wSTsghpo+eRIK0i6PmKXfQvQvVLVRn8E06yQVCapKkV1IFdqxWv91R
        ZhmjrIlW6PldJw/yx32DvspNkDLKJD8yG+9wMa6TDURVYNUIdH65VYe/bAMd9GoFnxP4NN
        /KabCx1bF6RT0MVYrin7okunOVnUhF/1FLBUqLzCNLgw47w3aAoMJv1SCqe2P0cJtR6AIE
        F8c3FJcLHdIFAga4NUHLZVTAw7mTGpOQSD9lQDOir0CWAdYb+PnmFolWBFT0EA==
Date:   Thu, 20 Jul 2023 10:48:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Foley <pefoley2@pefoley.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: avoid holes in struct spi_mem_op
Message-ID: <20230720104832.15a4d4ab@xps-13>
In-Reply-To: <598bd9d8-249e-125c-bde3-7a63ba6dc5f7@linaro.org>
References: <20230719190045.4007391-1-arnd@kernel.org>
        <598bd9d8-249e-125c-bde3-7a63ba6dc5f7@linaro.org>
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

Hi Tudor,

tudor.ambarus@linaro.org wrote on Thu, 20 Jul 2023 07:50:33 +0100:

> On 7/19/23 20:00, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > gcc gets confused when -ftrivial-auto-var-init=3Dpattern is used on spa=
rse
> > bit fields such as 'struct spi_mem_op', which caused the previous false
> > positive warning about an uninitialized variable:
> >=20
> > drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Wer=
ror=3Duninitialized]
> >=20
> > In fact, the variable is fully initialized and gcc does not see it being
> > used, so the warning is entirely bogus. The problem appears to be
> > a misoptimization in the initialization of single bit fields when the
> > rest of the bytes are not initialized.
> >=20
> > A previous workaround added another initialization, which ended up
> > shutting up the warning in spansion.c, though it apparently still happe=
ns
> > in other files as reported by Peter Foley in the gcc bugzilla. The
> > workaround of adding a fake initialization seems particularly bad
> > because it would set values that can never be correct but prevent the
> > compiler from warning about actually missing initializations.
> >=20
> > Revert the broken workaround and instead pad the structure to only
> > have bitfields that add up to full bytes, which should avoid this
> > behavior in all drivers.
> >=20
> > I also filed a new bug against gcc with what I found, so this can
> > hopefully be addressed in future gcc releases. At the moment, only
> > gcc-12 and gcc-13 are affected.
> >=20
> > Cc: Peter Foley <pefoley2@pefoley.com>
> > Cc: Pedro Falcato <pedro.falcato@gmail.com>
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D110743
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108402
> > Link: https://godbolt.org/z/efMMsG1Kx
> > Fixes: 420c4495b5e56 ("mtd: spi-nor: spansion: make sure local struct d=
oes not contain garbage")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de> =20
>=20
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>=20
> Miquel, would you please take this through mtd/fixes?

I will!

Thanks,
Miqu=C3=A8l
