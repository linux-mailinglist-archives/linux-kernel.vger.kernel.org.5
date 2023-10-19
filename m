Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41707CF018
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjJSGb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:31:57 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDBEFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:31:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4651E1BF203;
        Thu, 19 Oct 2023 06:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697697113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxEr3Vdk9ayXK9kV3+O24G8W+TiMjxVEUmGPMuzDVM4=;
        b=fuvTJqA3k5kxHNR5Hvihjvm6FlelgtmEY6TTMUTffRAflGVS+zjkrIiabIpCjn/0tChyNq
        Y3LdIQFSBOgJJraBcairiwgN9ZDgz7oo4hgOAIT6BFP3Z2yRC2hLfm6T7xf6ElbOUR/bxh
        IbCACnyE4gCKt0Zb6bAh4j2I/ZmjM8GzpBrZkDBPz/yMJrK87u+3cHpSX53SpoAGGz7jcJ
        ZVtC8dCQPt4p3jdZdpnsz1X6CFq90vpe7biGKzn5uLPyT/QLdWrbDCXRNibBhnKXzokm/s
        XL0Ljm5IZflwaKHHEDB8H7VngAdR6Dv/31jz5wfqrzxfYsStUq2uzV6xLNLorg==
Date:   Thu, 19 Oct 2023 08:31:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 5/6] i3c: master: svc: fix SDA keep low when
 polling IBIWON timeout happen
Message-ID: <20231019083151.3bd10536@xps-13>
In-Reply-To: <20231018155926.3305476-6-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
        <20231018155926.3305476-6-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:25 -0400:

> If IBIWON timeout happen, SDA line will always keep low because miss emit
> stop.

"
Upon IBIWON timeout, the SDA line will always be kept low if we don't
emit a stop. Calling svc_i3c_master_emit_stop() there will let the bus
return to idle state.
"

With this commit log,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Call svc_i3c_master_emit_stop() to let i3c bus come back to idle statue
> when IBIWON timeout happen.
>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v1 to v2
>     - Update commite message
>=20
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index b113460f059c3..1a57fdebaa26d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -404,6 +404,7 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
>  					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
>  	if (ret) {
>  		dev_err(master->dev, "Timeout when polling for IBIWON\n");
> +		svc_i3c_master_emit_stop(master);
>  		goto reenable_ibis;
>  	}
> =20


Thanks,
Miqu=C3=A8l
