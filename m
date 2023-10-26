Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB17D7CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjJZG2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZG2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:28:09 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBC187
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:28:05 -0700 (PDT)
Received: from [127.0.0.1] (unknown [154.134.133.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E67FC6FB;
        Thu, 26 Oct 2023 08:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1698301683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKIJ9pz/6EelcsD3a+FNse1RgjHqReUk/N6IeQ8agD0=;
        b=QjfTdqrrPXwyDOeS0DcSV0WIao1R/jbdIkBMLxnP/rfGfwoj05rWZojGmqROIJv1nuBv4b
        NalHvOgdtYzNI3YudfDrOWe9Icl5d5gXL+G5+QAMQGvksC4f+2vFkA+3ApDkeyI7aNR/O8
        PaMIO5oSLmp1mgFA8ZIB0BmciV79cPC9GkzmNxD/w8wtolIiAwp5VNaZ0IZuKs6ZlwqAvJ
        88TYAG+eBUcZA6nRayAq9AH+lYRYDjlE55M0uGwCtousTPH2vBrWej5CorUSILFfmi6Fob
        slJzISECcy04LenBRnCEGoYPfSZ2p1lrucEHDtLwjMswblcEwXlcvXxRIIOKug==
Date:   Thu, 26 Oct 2023 09:28:01 +0300
From:   Michael Walle <michael@walle.cc>
To:     AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_mtd=3A_spi-nor=3A_Improve_?= =?US-ASCII?Q?reporting_for_software_reset_failures?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231026012017.518610-1-acelan.kao@canonical.com>
References: <20231026012017.518610-1-acelan.kao@canonical.com>
Message-ID: <F56F4D7D-1264-41E1-9CE7-5DA410A22D73@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26=2E Oktober 2023 04:20:17 OESZ schrieb AceLan Kao <acelan=2Ekao@canoni=
cal=2Ecom>:
>From: "Chia-Lin Kao (AceLan)" <acelan=2Ekao@canonical=2Ecom>
>
>When the software reset command isn't supported, we now report it
>as an informational message(dev_info) instead of a warning(dev_warn)=2E
>This adjustment helps avoid unnecessary alarm and confusion regarding
>software reset capabilities=2E
>
>Signed-off-by: Chia-Lin Kao (AceLan) <acelan=2Ekao@canonical=2Ecom>

NAK=2E You surely missed my comments on the previous version=2E=20

-michael

>---
>v2=2E only lower the priority for the not supported failure
>v3=2E replace ENOTSUPP with EOPNOTSUPP and check the first command only
>v4=2E move the version information below the '---' line
>---
> drivers/mtd/spi-nor/core=2Ec | 5 ++++-
> drivers/spi/spi-mem=2Ec      | 2 +-
> 2 files changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mtd/spi-nor/core=2Ec b/drivers/mtd/spi-nor/core=2Ec
>index 1b0c6770c14e=2E=2E42e52af76289 100644
>--- a/drivers/mtd/spi-nor/core=2Ec
>+++ b/drivers/mtd/spi-nor/core=2Ec
>@@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor=
)
>=20
> 	ret =3D spi_mem_exec_op(nor->spimem, &op);
> 	if (ret) {
>-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
>+		if (ret =3D=3D -EOPNOTSUPP)
>+			dev_info(nor->dev, "Software reset enable command doesn't support: %d=
\n", ret);
>+		else
>+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> 		return;
> 	}
>=20
>diff --git a/drivers/spi/spi-mem=2Ec b/drivers/spi/spi-mem=2Ec
>index edd7430d4c05=2E=2E93b77ac0b798 100644
>--- a/drivers/spi/spi-mem=2Ec
>+++ b/drivers/spi/spi-mem=2Ec
>@@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct=
 spi_mem_op *op)
> 		return ret;
>=20
> 	if (!spi_mem_internal_supports_op(mem, op))
>-		return -ENOTSUPP;
>+		return -EOPNOTSUPP;
>=20
> 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->sp=
i, 0)) {
> 		ret =3D spi_mem_access_start(mem);

