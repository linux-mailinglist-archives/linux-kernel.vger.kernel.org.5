Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4137F5DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbjKWL07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345069AbjKWL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC65D7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700738817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFq+BEnbZxFqfaT3CQSP/UqcZPRY8UI20FDoLhF4BDY=;
        b=U+wxMOnRV8Da0pw7a1ofpqaId2euhZFwR/vnCiJCVH30jZ9g0+P55IKxVClthGuDhyTy4Y
        teJ0Z5+ls/OXt0zkhGx1IOQYUWZuB7JuIs/G6TxhTUiVUBj9OjwPa9f+mjW1N5F1q0qqWl
        qeXrNYmQJEocZGY7BWoqrUt7Ah2g4UQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-SFqZnqLgO1mc-JxxuPn-KA-1; Thu, 23 Nov 2023 06:26:56 -0500
X-MC-Unique: SFqZnqLgO1mc-JxxuPn-KA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a0627211f11so10639066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700738815; x=1701343615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFq+BEnbZxFqfaT3CQSP/UqcZPRY8UI20FDoLhF4BDY=;
        b=aRGQUPtetk/Pbx/dTUPV+7/Jg5Bp8QgFGO4KqXwvs7APupVy9cZV8UunzFQ+riehiZ
         UJAVtupv+XDFjeIm4gqnDXGIimFMche6ufgwmGAUw1BDn5Mi7IVu42EHn73rw/00IK6/
         GBBWSZiWW4Q+XpIkRIrgsQ5Yp7265L1ddZ+Eer4zhcczCDYKbh3aNsis5vPN9gEiyOl7
         1VDY8Vg+93h9voswDc1SM2udgMuBGEUDOt6h6Wi+z/QG432pdAL/fpDyMu8tSryZiHgI
         xfGNN8SDQHq8aTVygn5EWvn5pXaXJ7dWTFJ3f6iUOfxARD8s52cVanfWx/3mSJmrtphF
         uQ9g==
X-Gm-Message-State: AOJu0YwhXer5Iikd+vaTYwVuUZfbwhsMx2hr5BgweXSNPanCdzSspViF
        XH/FmAyHFplWG/AJr7jlq/zTDiSo0Mm7gAJI1d94SaPR5HNQrf29eESS1oVJSV4/ioFfA+giSpU
        i4MkM1V7N4RmM+1idwgSQVLSE8Ox8N42l
X-Received: by 2002:a17:906:74ca:b0:9dd:5609:55b9 with SMTP id z10-20020a17090674ca00b009dd560955b9mr3755032ejl.2.1700738815109;
        Thu, 23 Nov 2023 03:26:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjzqKBEB+IvSpAaThccpRNjrOFH6OqB69C/kRlQ9A8H7EgXahNy9IVIIpsA621BAYcN16LSw==
X-Received: by 2002:a17:906:74ca:b0:9dd:5609:55b9 with SMTP id z10-20020a17090674ca00b009dd560955b9mr3755014ejl.2.1700738814760;
        Thu, 23 Nov 2023 03:26:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id fy21-20020a170906b7d500b009e603786444sm665877ejb.90.2023.11.23.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:26:54 -0800 (PST)
Message-ID: <5327988fc5d02f3352be66b5f0a2ca9a468ef1da.camel@redhat.com>
Subject: Re: [PATCH 1/4 net] qca_spi: Fix SPI thread creation
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Nov 2023 12:26:53 +0100
In-Reply-To: <20231121163004.21232-2-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
         <20231121163004.21232-2-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> The qca_spi driver create/stop the SPI kernel thread in case
> of netdev_open/close. This is a big issue because it allows
> userspace to prevent from restarting the SPI thread after
> ring parameter changes (e.g. signals which stop the thread).
> This could be done by terminating a script which changes
> the ring parameter in a loop.
>=20
> So fix this by moving create/stop of the SPI kernel into
> the init/uninit ops. The open/close ops could be realized just
> by 'park/unpark' the SPI kernel thread.
>=20
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA=
7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_spi.c | 35 ++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethern=
et/qualcomm/qca_spi.c
> index bec723028e96..b11a998b2456 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -580,6 +580,11 @@ qcaspi_spi_thread(void *data)
>  	netdev_info(qca->net_dev, "SPI thread created\n");
>  	while (!kthread_should_stop()) {
>  		set_current_state(TASK_INTERRUPTIBLE);
> +		if (kthread_should_park()) {
> +			kthread_parkme();
> +			continue;
> +		}
> +
>  		if ((qca->intr_req =3D=3D qca->intr_svc) &&
>  		    !qca->txr.skb[qca->txr.head])
>  			schedule();
> @@ -679,25 +684,17 @@ qcaspi_netdev_open(struct net_device *dev)
>  	qca->sync =3D QCASPI_SYNC_UNKNOWN;
>  	qcafrm_fsm_init_spi(&qca->frm_handle);
>=20
> -	qca->spi_thread =3D kthread_run((void *)qcaspi_spi_thread,
> -				      qca, "%s", dev->name);
> -
> -	if (IS_ERR(qca->spi_thread)) {
> -		netdev_err(dev, "%s: unable to start kernel thread.\n",
> -			   QCASPI_DRV_NAME);
> -		return PTR_ERR(qca->spi_thread);
> -	}
> -
>  	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
>  			  dev->name, qca);
>  	if (ret) {
>  		netdev_err(dev, "%s: unable to get IRQ %d (irqval=3D%d).\n",
>  			   QCASPI_DRV_NAME, qca->spi_dev->irq, ret);
> -		kthread_stop(qca->spi_thread);
>  		return ret;
>  	}
>=20
>  	/* SPI thread takes care of TX queue */
> +	kthread_unpark(qca->spi_thread);
> +	wake_up_process(qca->spi_thread);

The above looks racy: after 'request_irq()' the interrupt handler can
raise an irq before the thread being unparked.

Additionally I think you can drop the 'if (qca->spi_thread)' in
qcaspi_intr_handler()

Cheers,

Paolo

