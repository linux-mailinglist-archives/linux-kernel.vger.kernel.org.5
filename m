Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1079D117
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjILM30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjILM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:29:04 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55710F3;
        Tue, 12 Sep 2023 05:28:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8726E2000A;
        Tue, 12 Sep 2023 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694521729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6w4eE727ahcXyxO0B8znMsuiPT1RLt1MBCIFRc4fPgg=;
        b=jC/r0aqRQO/YPCJ8STlSaOY/dw4Vx09EJUWrU8X0QarVh46T7R2kyaqz+mdIXe2ucdLx8Q
        +7lSNpDrkMAYoQHely2wZKOF09lu6WINOQFz2TsjyJ/wf72PQepBKoyoY2Kwf9Dnic23UZ
        K81+HS27EPt/QMfNxuTQ+Ex2OBVjuNGP2O47bgrY8G1AufFPpRS/dVTjzU/n3Xvd9/jyTP
        y2hj2+keElhyWHi+iERfeNCxbHNdVxSob5YxwUqmHMv0htPqUgjLYbtO6kUfhCIz0XBI8x
        qXDxP5iDkGCcAlPQy18rUefZUWlR/i2k85i564hN8QA7Cg7GPb4PS1tX+FQGog==
Date:   Tue, 12 Sep 2023 14:28:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charante@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH v4] mtd: rawnand: qcom: Unmap the right resource upon
 probe failure
Message-ID: <20230912142847.4610c0a0@xps-13>
In-Reply-To: <20230912115903.1007-1-quic_bibekkum@quicinc.com>
References: <20230912115903.1007-1-quic_bibekkum@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibek,

quic_bibekkum@quicinc.com wrote on Tue, 12 Sep 2023 17:29:03 +0530:

> We currently provide the physical address of the DMA region
> rather than the output of dma_map_resource() which is obviously wrong.
>=20
> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")

Cc: stable?

> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
> v4: Incorporated suggestion from Miquel
>     - Modified title and commit description.
>=20
> v3: Incorporated comments from Miquel
>     - Modified the commit message and title as per suggestions.
>     https://lore.kernel.org/all/20230912101814.7748-1-quic_bibekkum@quici=
nc.com/
>=20
> v2: Incorporated comments from Pavan/Mani.
>     https://lore.kernel.org/all/20230911133026.29868-1-quic_bibekkum@quic=
inc.com/
>=20
> v1: https://lore.kernel.org/all/20230907092854.11408-1-quic_bibekkum@quic=
inc.com/
>=20
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 64499c1b3603..b079605c84d3 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -3444,7 +3444,7 @@ static int qcom_nandc_probe(struct platform_device =
*pdev)
>  err_aon_clk:
>  	clk_disable_unprepare(nandc->core_clk);
>  err_core_clk:
> -	dma_unmap_resource(dev, res->start, resource_size(res),
> +	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
>  			   DMA_BIDIRECTIONAL, 0);
>  	return ret;
>  }
> --
> 2.17.1
>=20


Thanks,
Miqu=C3=A8l
