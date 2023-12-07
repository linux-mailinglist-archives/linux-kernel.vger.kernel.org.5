Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158D3808371
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378392AbjLGIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLGIp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E169C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701938730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm6L75ZYUtSIBUEJVs/M0f9Bq72gbApPuHksEfrv+cQ=;
        b=KwTouXZhLip/7N8sw+mBycWR6lyLIGQCRUG2Zqgjd78YcU0g2JPv/s6UFPenaEeJ+Wd/xc
        0TQNlJR/rI5LQKWHWO8j4eUNsa696n0nH08KUPQDyJjzfZJ2j9qDGAVz2iD3YeOyAkLhoa
        kkECqmvcANCkkQYbgGXM5lXRmaX0RIY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-0gVLcwVFOfOyzi0TfYTaYw-1; Thu, 07 Dec 2023 03:45:28 -0500
X-MC-Unique: 0gVLcwVFOfOyzi0TfYTaYw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50becd7229aso327328e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938727; x=1702543527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm6L75ZYUtSIBUEJVs/M0f9Bq72gbApPuHksEfrv+cQ=;
        b=ZclqO3j5gfI3cAS+ASKlfFBLZY/pg6yxrRfStr3yGLYuoXcFdsf0hZp6UjYg3fK/y/
         C7RTqoMdx7+vNenTvWDEc/Un8pHberdC+XVRob7CBw1XU54GEmt8rtUFQhxsFoHFS3H2
         GGicqk06Iw0zh/0MHY9wuzjyh1XWd3aWsjLTlyQ6zLeRCk7erhZPDeLm1/9tlbSHAtaH
         Z4ixd4X/6tqcBI9XNwh1rvqodnUoxQBBvNGLkDUMTxOQt9XyzPYyioqLVU5i5de9Uq8T
         GB038cB+MYyUxFjl+C/pYNvcz6WXMibVcQTauMnLHgfHnoCfSUbmQ0DYuTssfAPRAgi+
         sjYQ==
X-Gm-Message-State: AOJu0YxE5AtnU0S8fG5qEVDWaEMz9l9XLU5DbY4l/UMsxyDSnwJxADCY
        xUdwwZkmXqQyqVii2qzsnHmyTia4ovoFXfmGRV3TX7mDQRmQuWqpu65oRB39qNyWWJxzE8iordn
        IkRwyAljFJDlegDirJkP++TOKBn+5apwmfAalAEk0jGezwayny74=
X-Received: by 2002:a05:6512:3b5:b0:50b:f724:8f87 with SMTP id v21-20020a05651203b500b0050bf7248f87mr1028447lfp.74.1701938726813;
        Thu, 07 Dec 2023 00:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjLjnpf+13CTzR83DOtoFZ35srDsGFdV7klkXJYOwEr3ONEBKAKlKMSpQz3BG/YoNgBs6vnaFNTqR5n1VDDNU=
X-Received: by 2002:a05:6512:3b5:b0:50b:f724:8f87 with SMTP id
 v21-20020a05651203b500b0050bf7248f87mr1028438lfp.74.1701938726450; Thu, 07
 Dec 2023 00:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20231207074936.2597889-1-srasheed@marvell.com>
In-Reply-To: <20231207074936.2597889-1-srasheed@marvell.com>
From:   Michal Schmidt <mschmidt@redhat.com>
Date:   Thu, 7 Dec 2023 09:45:15 +0100
Message-ID: <CADEbmW1qF7UvGr0rZ0NUMiP0Lybgz3CHLB3JVBn_Na-8md-tgQ@mail.gmail.com>
Subject: Re: [PATCH net v2] octeon_ep: explicitly test for firmware ready value
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        pabeni@redhat.com, horms@kernel.org, kuba@kernel.org,
        davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 8:50=E2=80=AFAM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
>
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V2:
>   - Fixed redundant logic
>
> V1: https://lore.kernel.org/all/20231206063549.2590305-1-srasheed@marvell=
.com/
>
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 552970c7dec0..b8ae269f6f97 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pde=
v)
>
>                 pci_read_config_byte(pdev, (pos + 8), &status);
>                 dev_info(&pdev->dev, "Firmware ready status =3D %u\n", st=
atus);
> -               return status;
> +#define FW_STATUS_READY 1ULL
> +               return (status =3D=3D FW_STATUS_READY);

The parentheses are not necessary, but if you find it better readable
this way, so be it.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>

>         }
>         return false;
>  }
> --
> 2.25.1
>

