Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F22781400
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379848AbjHRT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379856AbjHRT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:59:16 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7C35AD;
        Fri, 18 Aug 2023 12:59:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C8FD60002;
        Fri, 18 Aug 2023 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692388752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9WQ4s+hROk+ahs4ROvh5ESGeMbt5mmR8H5xOLugL5s=;
        b=ZiAXgzeTTaj5OwCo1sItpPbJtBXQctG9Gstnj8B/OYpBy8tcmSbPkitg18sxNxqPcR3CDX
        GaGh0SUiVO1ccAEwAtBgUcjoXfyOj40NAntN7HJV+PWGNB0Ce8kSBLFBtt3GyR6slsYMqI
        oajWAa6r8Sk4837o5n3pZy1aBp62ALz2ourz89jL7J6Gqzo15SRc/G0Q0XcH/IZG8Uq76V
        dzpgJxtVpWWCWoSr1OAR7yg0zEyOc8xSH/qFOzh1vHijQJMLHOziJJYPXDqFlqDDhQ/QMI
        QuyOT4WIEw5m97H10IBSZ6HqxegL2sC4sUF7J9dVmFW7B9dGVCy0HaSp1pmGmg==
Date:   Fri, 18 Aug 2023 21:59:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 1/3] mtd: rawnand: qcom: Update read_loc size to 512
Message-ID: <20230818215908.0e60b00b@xps-13>
In-Reply-To: <20230818145101.23825-2-quic_mdalam@quicinc.com>
References: <20230818145101.23825-1-quic_mdalam@quicinc.com>
        <20230818145101.23825-2-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Md,

quic_mdalam@quicinc.com wrote on Fri, 18 Aug 2023 20:20:59 +0530:

> For parameter page read upper layer is passing len
> as 256 bytes and if we try to configure 256 bytes
> size in read loaction register then subsequent bam
> transaction is getting timed out for 4K nand devices.
> So update this length as one step size if its
> less than NANDC_STEP_SIZE.
>=20
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

I'm fine with patches 2 and 3 and will take them. But this one does not
seem legitimate. I don't like it. Are you sure the ECC engine was not
enabled when it timed out? Default should be having the ECC disabled
and it should just get enabled when you need it. There is no reason
why, specifically on NAND devices, it would not be possible to read 256
bytes.

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index d4ba0d04c970..413e214c8e87 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2885,6 +2885,9 @@ static int qcom_param_page_type_exec(struct nand_ch=
ip *chip,  const struct nand_
>  	op_id =3D q_op.data_instr_idx;
>  	len =3D nand_subop_get_data_len(subop, op_id);
> =20
> +	if (len < NANDC_STEP_SIZE)
> +		len =3D NANDC_STEP_SIZE;
> +
>  	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
> =20
>  	if (!nandc->props->qpic_v2) {


Thanks,
Miqu=C3=A8l
