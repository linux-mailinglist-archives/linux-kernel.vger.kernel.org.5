Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D1079CE37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjILK1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjILK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:26:50 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F710DC;
        Tue, 12 Sep 2023 03:26:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C19660007;
        Tue, 12 Sep 2023 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694514403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/O8MVT56+zUGcQzRzvIk5l2qYL/0RI/d40KXm58VTfc=;
        b=YV8nZp2bkWgjApjHU/fxeam8UdOwPYtwPQrOHDC/CjeTqVk80qjBb2xjc+vZ9ZTxZHo2PP
        WEB5g8JZo7LAl81+K5cKMhRLArv5hTzIhVsW/qQDmqNLK1Qvm3WTJyqjZgQfPMw/9ngVQh
        MJj2EXbIGnEoZzrQ6d83OMQXpYB/C3YmjOKtrBtKFTEHg6X93KlZoV3L1qW15PhAp7kuW5
        eQNYSdEzM/oHXuZlKf2gTYvP9eNF8CDYsPZi1DsUSnCGMe9NC3xS+S2x6COewIhm7tf1iW
        iX9pya5BNojLoteQuPfZyF6YS9dsfbboT5xUmtIFERNKkgYyB3+qRnQbw91Weg==
Date:   Tue, 12 Sep 2023 12:26:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charante@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH v3] mtd: rawnand: qcom: unmap dma address during probe
 failure
Message-ID: <20230912122640.1ed25673@xps-13>
In-Reply-To: <20230912101814.7748-1-quic_bibekkum@quicinc.com>
References: <20230912101814.7748-1-quic_bibekkum@quicinc.com>
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

quic_bibekkum@quicinc.com wrote on Tue, 12 Sep 2023 15:48:14 +0530:

Title: s/during/upon/?

> Fix address argument of nand controller currently being
> passed to dma_unmap_resource() in probe error path.

What about:

	Unmap the right resource upon probe failure: we currently
	provide the physical address of the DMA region rather than the
	output of dma_map_resource() which is obviously wrong.

> This address argument should be the dma address returned by
> dma_map_resource() instead of the physical address of nand controller.
>
>=20
> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
> v3: Incorporated comments from Miquel
>     - Modified the commit message and title as per suggestions.
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
