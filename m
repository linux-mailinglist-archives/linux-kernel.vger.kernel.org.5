Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92280543B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbjLEMfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjLEMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD73134
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701779709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DwGrP4LOcEDhuukK6/wBXzdqZN1dqbWTFoUTAihTAk=;
        b=FUCJ8oMCsTGshakALAZ0UdK714mDftrjiKheFVzz5C503NV20vaCcMLiiqwIuOjUWtOUzh
        YZn3kwjVQDTutczRmZGhwztfRGLVYVxdKKg6xf8lZ2AgoMyBsbx/6CZ4GLU8bon2O97GjG
        R12ivPMdV/lGoj7qlnfkVJXKcAP/eXQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-vxlCZun5PuSvIZH8XNRhYw-1; Tue, 05 Dec 2023 07:35:08 -0500
X-MC-Unique: vxlCZun5PuSvIZH8XNRhYw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1a3f8b80e1so61347866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779707; x=1702384507;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DwGrP4LOcEDhuukK6/wBXzdqZN1dqbWTFoUTAihTAk=;
        b=eWZZn39YeEmWnsW26xMKoUBh+Yh1K9csD1gKz0TTT9QGHiLAX4CAde+9mahdGHbAzO
         dLdFjSO7vGRGwDK2P7PW14dM7aaxV0yY6lCvVJpl7Un87YQy6vraEW/U1SW6zCR8aN3a
         rEjiSCwh2q5QlqH9utl/90xy8eOz4LEcjD4CYqPYrbePXFASBwC0mey45eM+Wt48XNpD
         o9xvcyWJs4SzUlcZUqbWLS+zca4aRDynZm6bsQL/SA0SwACXzbOFdWYPcEDCd8PBXms/
         KvO9dFcc9D/NXxGhprV3faJ56x4E2S0jevRVrf/7tmpXOQOhbSJFKd/n7wSHRo3lK0UW
         Hlqg==
X-Gm-Message-State: AOJu0YzURidik80k8BfE38MQCu1SNdWjUO68Z8iaOariHrC4CvCuRrqz
        qZW5sHRfF2/JrOezLOzWdb5CQm9nxs/LxS3fzUXnxvrVuqnNLgqe5p3M8jdUGMHzIH6JY7PN3NF
        UP5RBZJNhk+5b4ilNJxqxcBxb
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1557182ejc.7.1701779707602;
        Tue, 05 Dec 2023 04:35:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuSZp9LKqyfpMrOE70M71zmI6cNJo0W3WIDa52qufIoKhA+eMs0comLsDg/dvVVJ/6iOUq/g==
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1557156ejc.7.1701779707285;
        Tue, 05 Dec 2023 04:35:07 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709061f4800b00a0435148ed7sm6750839ejk.17.2023.12.05.04.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:35:06 -0800 (PST)
Message-ID: <6bb19e86b3f5c83bbc85c09b845e52208ce424d7.camel@redhat.com>
Subject: Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_npa_register_reporters
From:   Paolo Abeni <pabeni@redhat.com>
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        George Cherian <george.cherian@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Dec 2023 13:35:05 +0100
In-Reply-To: <20231202095902.3264863-1-alexious@zju.edu.cn>
References: <20231202095902.3264863-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-12-02 at 17:59 +0800, Zhipeng Lu wrote:
> The rvu_dl will be freed in rvu_npa_health_reporters_destroy(rvu_dl)
> after the create_workqueue fails, and after that free, the rvu_dl will
> be translate back through rvu_npa_health_reporters_create,
> rvu_health_reporters_create, and rvu_register_dl. Finally it goes to the
> err_dl_health label, being freed again in
> rvu_health_reporters_destroy(rvu) by rvu_npa_health_reporters_destroy.
> In the second calls of rvu_npa_health_reporters_destroy, however,
> it uses rvu_dl->rvu_npa_health_reporter, which is already freed at
> the end of rvu_npa_health_reporters_destroy in the first call.
>=20
> So this patch prevents the first destroy by instantly returning -ENONMEN
> when create_workqueue fails. In addition, since the failure of
> create_workqueue is the only entrence of label err, it has been
> integrated into the error-handling path of create_workqueue.
>=20
> Fixes: f1168d1e207c ("octeontx2-af: Add devlink health reporters for NPA"=
)
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/dr=
ivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 41df5ac23f92..058f75dc4c8a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> @@ -1285,7 +1285,7 @@ static int rvu_npa_register_reporters(struct rvu_de=
vlink *rvu_dl)
> =20
>  	rvu_dl->devlink_wq =3D create_workqueue("rvu_devlink_wq");
>  	if (!rvu_dl->devlink_wq)
> -		goto err;
> +		return -ENOMEM;
> =20
>  	INIT_WORK(&rvu_reporters->intr_work, rvu_npa_intr_work);
>  	INIT_WORK(&rvu_reporters->err_work, rvu_npa_err_work);
> @@ -1293,9 +1293,6 @@ static int rvu_npa_register_reporters(struct rvu_de=
vlink *rvu_dl)
>  	INIT_WORK(&rvu_reporters->ras_work, rvu_npa_ras_work);
> =20
>  	return 0;
> -err:
> -	rvu_npa_health_reporters_destroy(rvu_dl);
> -	return -ENOMEM;
>  }
> =20
>  static int rvu_npa_health_reporters_create(struct rvu_devlink *rvu_dl)

LGTM

Acked-by: Paolo Abeni <pabeni@redhat.com>

but allow some little more time for Marvel's people to have a better
look.

Cheers,

Paolo

