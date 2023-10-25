Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601667D60D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjJYEZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjJYEZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:25:54 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C69132
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:25:51 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-43-115-212.web.vodafone.de [109.43.115.212])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D19006C;
        Wed, 25 Oct 2023 06:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1698207949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jl9DUJy8yRzO++FF8dyWq38fc0SfZyo5hrCjsG2i7is=;
        b=IzjDm92VnW3bO+JuunQS2V8szoeiD8vRZIH3yOnVUPnKDVxr+fj4EfJdfRQmM2BFnllcch
        /OOXPhaWMCqrbjlo/+0u3sj2KSBF8DVsj35bhrdFFh2vTHmz+caMSajMHTmyaLJjDcNrx4
        qvlUCGgADIuaxF3qMPy/JJmzy4sZ/KIP09hbx2yWjzAP3ScYOiwlTZlUIZTYuecfx5i3lK
        6atWeMwiAW3ZWjj9/Hl1wRxWOKoMeNIDrDoTxKU/rAwciv16SIOl7Yr07q+6RdKEjrCGR/
        ZyQDLQLGJm6ZTKWK27P1KbvhveL5oa3SUH4vvkWZUkOMb6X6th6DOTytnvNigg==
Date:   Wed, 25 Oct 2023 06:25:48 +0200
From:   Michael Walle <michael@walle.cc>
To:     AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_mtd=3A_spi-nor=3A_Improve_?= =?US-ASCII?Q?reporting_for_software_reset_failures?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231025030501.490355-1-acelan.kao@canonical.com>
References: <20231025030501.490355-1-acelan.kao@canonical.com>
Message-ID: <6B9232E3-7159-4D97-9B40-EE77E2F6EA5B@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>When the software reset command isn't supported, we now report it
>as an informational message(dev_info) instead of a warning(dev_warn)=2E
>This adjustment helps avoid unnecessary alarm and confusion regarding
>software reset capabilities=2E
>
>v2=2E only lower the priority for the not supported failure
>v3=2E replace ENOTSUPP with EOPNOTSUPP and check the first command only
>
>Signed-off-by: Chia-Lin Kao (AceLan) <acelan=2Ekao@canonical=2Ecom>
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

As mentioned in the previous version, this doesn't add any useful informat=
ion=2E Please just drop it=2E That is, just guard the current dev_warn() wi=
th "if ret! =3D - EOPNOTSUPP"=2E

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

This should be an own patch and you'll have to fix current users of it=2E =
For example, there is at least one in spi-nor core=2E Probably more=2E=20

-michael

>=20
> 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->sp=
i, 0)) {
> 		ret =3D spi_mem_access_start(mem);

