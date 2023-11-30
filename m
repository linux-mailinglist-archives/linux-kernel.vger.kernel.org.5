Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DE7FECA1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjK3KQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3KQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:16:35 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743DE10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:16:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A9AF1C0003;
        Thu, 30 Nov 2023 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701339400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPIe8MgFoopxf4QsCc/BpkQti0xvkaZYjK5Tti66Lbc=;
        b=PcTsnGKj9xD4qwl2AK2ml4mmiZb0t/wDx8QFPg2FfBZjTU+Y11qIoLb1rJK2+AfKDC0LgK
        qoqi8ihWII60uWhFnD7hYwdBRapqWRbG4tUgCmRdXms0msaybEphU8DtwHvqnPseubsyX5
        tBHsZw4N64qMYE8z8parVWA8zqDoWtc3PqDhZZC7Yu+T/eDYINxxNxr0YLD/iXFDD+uTgY
        BITgAJ/XkIxowTXRTV1skLpxFZC7UW/w+8UpXunj+s1jCZajI8kAImS4AClPvAgADjSU2k
        bf5eaNx2WLwhZq9NwPewvMLTWsQE/KDpqiFDi+nihmqkHtJVdJu5qRaTdJ9jHg==
Date:   Thu, 30 Nov 2023 11:16:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 2/6] i3c: master: svc: add hot join support
Message-ID: <20231130111636.34432d30@xps-13>
In-Reply-To: <20231129221225.387952-3-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
        <20231129221225.387952-3-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:21 -0500:

> Add hot join support for svc master controller. Enable hot join defaultly.

							by default

> User can use sys entry to disable hot join.

Should we do the opposite? Disable hot-join by default and allow
enabling it?

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 58 +++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 6b6bdd163af4f..880c6ae76c013 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -128,6 +128,9 @@
>  /* This parameter depends on the implementation and may be tuned */
>  #define SVC_I3C_FIFO_SIZE 16
> =20
> +#define SVC_I3C_EVENT_IBI	BIT(0)
> +#define SVC_I3C_EVENT_HOTJOIN	BIT(1)
> +
>  struct svc_i3c_cmd {
>  	u8 addr;
>  	bool rnw;
> @@ -176,6 +179,7 @@ struct svc_i3c_regs_save {
>   * @ibi.tbq_slot: To be queued IBI slot
>   * @ibi.lock: IBI lock
>   * @lock: Transfer lock, protect between IBI work thread and callbacks f=
rom master
> + * @enabled_events: Bit masks for enable events (IBI, HotJoin).
>   */
>  struct svc_i3c_master {
>  	struct i3c_master_controller base;
> @@ -205,6 +209,7 @@ struct svc_i3c_master {
>  		spinlock_t lock;
>  	} ibi;
>  	struct mutex lock;
> +	int enabled_events;
>  };
> =20
>  /**
> @@ -428,13 +433,16 @@ static void svc_i3c_master_ibi_work(struct work_str=
uct *work)
>  	switch (ibitype) {
>  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
>  		dev =3D svc_i3c_master_dev_from_addr(master, ibiaddr);
> -		if (!dev)
> +		if (!dev || !(master->enabled_events & SVC_I3C_EVENT_IBI))

If we are going to add new events like that maybe we should have a
helper. So we can then extend the helper with the list of enabled
events?

>  			svc_i3c_master_nack_ibi(master);
>  		else
>  			svc_i3c_master_handle_ibi(master, dev);
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
> -		svc_i3c_master_ack_ibi(master, false);
> +		if (master->enabled_events & SVC_I3C_EVENT_HOTJOIN)

And you could reuse the helper here

> +			svc_i3c_master_ack_ibi(master, false);
> +		else
> +			svc_i3c_master_nack_ibi(master);
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
>  		svc_i3c_master_nack_ibi(master);
> @@ -471,7 +479,9 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
>  		svc_i3c_master_emit_stop(master);
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
> -		queue_work(master->base.wq, &master->hj_work);
> +		svc_i3c_master_emit_stop(master);
> +		if (master->enabled_events & SVC_I3C_EVENT_HOTJOIN)

and here

> +			queue_work(master->base.wq, &master->hj_work);
>  		break;

Thanks,
Miqu=C3=A8l
