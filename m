Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED080716A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378726AbjLFN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378633AbjLFN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960AD1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701871098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vng2/SnRgWTDDru8v8rtd+Rz3Crl3Lo3N7L+CSCh4JI=;
        b=U6ndjGcMn8L5G/YRdiFGLeZsfJam5+XWaVaBEAwvPsFDMCjgaYVxJXKfBaHP/kDKM1vz/p
        ulc5e/GpPwWqCKav8f79SH3+AG4ilhKuJRi0Ox+a0a5GxZlK9j02a8ZEsPLExFjaYbXFHZ
        TtbVHgoMJ+b93n7kSvwG269XmGiON/M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Iy9N6ZvMNleouBPlHPkVRg-1; Wed, 06 Dec 2023 08:58:17 -0500
X-MC-Unique: Iy9N6ZvMNleouBPlHPkVRg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bedc84260so3151914e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871096; x=1702475896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vng2/SnRgWTDDru8v8rtd+Rz3Crl3Lo3N7L+CSCh4JI=;
        b=dxOvV/Ht8YetvTX65Uw970kx3UHgCyA+rML02xduYF3817pPs8gWK6RImpns7Kd7rM
         WOe0aOZ8a23mUkXtQWyrDu21RDYkjqpvyvV6exCoN47MhJS0CTLjWUplrMfMlZBkbEeE
         +m7HJqZWhf7ryX2jiy6AqMyrSmZS+L7e/2Z8Jq/tyIn4F4rPKIhfTlMv+3MAE+/7sBCM
         CiKz/Z9c87ruU1Wg/WgkIEOUr4FdBu2jNmf2+gPSTw8L8I9gcEp0GYtBWHUiOKDaCElv
         MBua3JBNHCw6TRBLDLJ8bBhwPfLP74P3QIAsCw/sXq7yvv+u1jLjfqnCi9TKrenrKqjk
         qJcA==
X-Gm-Message-State: AOJu0YyK2D6+qD1oJwnMOJcESamBSd7DYVBR1N1eSxtjZ3vYXZrAHeAp
        6X3aVMP3+qHOwNb/KvSw9DWXX6X63iNsR0Tlzc2BHRx4cvkKgzMFop6PqdSQ5PnXlAF6m2L+be2
        evtUNr+eXor4F+tzpglS8MHAhlwMoyMbZ6WSSrVDu
X-Received: by 2002:a05:6512:3e0b:b0:50b:efa8:c518 with SMTP id i11-20020a0565123e0b00b0050befa8c518mr485155lfv.102.1701871095847;
        Wed, 06 Dec 2023 05:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbx/bUgoIEFkWQBTPj3Hmf5awFPNN9VUatDvKn08A1pfbHIt7BwQojoCII4CcgQhO88V7+7sV0bBg1vmXj87g=
X-Received: by 2002:a05:6512:3e0b:b0:50b:efa8:c518 with SMTP id
 i11-20020a0565123e0b00b0050befa8c518mr485149lfv.102.1701871095525; Wed, 06
 Dec 2023 05:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20231206063549.2590305-1-srasheed@marvell.com>
In-Reply-To: <20231206063549.2590305-1-srasheed@marvell.com>
From:   Michal Schmidt <mschmidt@redhat.com>
Date:   Wed, 6 Dec 2023 14:58:04 +0100
Message-ID: <CADEbmW32rjDJgr4xEArasguWfsSNTJpw__AgsE9n8mwE3qXwFA@mail.gmail.com>
Subject: Re: [PATCH net v1] octeon_ep: explicitly test for firmware ready value
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 7:36=E2=80=AFAM Shinas Rasheed <srasheed@marvell.com=
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
> +               return (status =3D=3D FW_STATUS_READY) ? true : false;

"status =3D=3D FW_STATUS_READY" is already the bool value you want. You
don't need to use the ternary operator here.

>         }
>         return false;
>  }
> --
> 2.25.1
>

