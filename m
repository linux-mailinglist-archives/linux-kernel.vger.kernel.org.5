Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7379E984
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjIMNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjIMNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:41:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52C19BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:41:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5008d16cc36so11728810e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1694612494; x=1695217294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ1rUv5g/qQPI1agYI/yIm65VV4BKQNh+OmVlPyNu3k=;
        b=e962oToqcpH5a8kXi5VpIH78SfLr8H/Z0pJc8zeYkclZ2/SrEVzNoo3utcg2jGILEG
         uNG8w2dOzQFrUE6tdO3bB7Am0CV8jwKb5OMoxm9M6GWCTgyqbzRXDig+22ehaPaXXxUx
         vyE/A48Y9s148C2APDEsIK8EdvJcHEDrh3X0YbqDhfWT+umZ47yC8KuV5+ULTjRFAcX8
         So7lBFwUMf8JhMA82DxcrlOV2qhATN8ePjv76HbFUeZj38E5qR97zbQgALi1P58gSJKL
         1+UHFt8XFIP0S/jTGJ2C4nMz2qMdUz8xfMOhylLbTqbHh/znI5vGjR9LpFFBEKstSuHv
         OWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694612494; x=1695217294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ1rUv5g/qQPI1agYI/yIm65VV4BKQNh+OmVlPyNu3k=;
        b=aVFSNiWvskrv29f2Cl8ySphG4KtopLWBrpeOTolPykZhg+tHf8L6RY3UiDXFp6vgZM
         5u9EtQEuMK5qz+NTVQv+hCnVcN4hikFGmA4UkcTNLhm+jkOYa/osBtPRKVnKbFGoZvHI
         Tc/keZv1vEDdv1q3+4mr6JWThq/ykBwFR1EXuHA1Z9jmocFRZj6CFh9xSiZdQGV51yle
         2qUKdYitU8e3zfpBzrRLt2pFdFgx73RdJGY0H+fsF0ac4fTgp1NZGh7hHFFTzy1moGhi
         VD22aSqjTdsIc2h3AmCsniy2S+MPNU8yWD4R+sl5ledcdR7X4qYu1XwliQILlroB6+K8
         35iw==
X-Gm-Message-State: AOJu0Yxh5TJHfV5h8L7XBrVWzfObI5lHDHKpEC/jDvw6p1QEMp7TpcZA
        uI4jQJTHpWuFBm7rIffjKwRsrucJeiDuLF3jWhry4Q==
X-Google-Smtp-Source: AGHT+IFaRgGOtENQHeZDax7vKLrpvaqziPhUjnjmndkG6cnhLYp5RFYRwQm6c9zj4eSLFyVrPqtdL7ljEGWFqQAvbOo=
X-Received: by 2002:a05:6512:312c:b0:4fe:7dcc:3dc1 with SMTP id
 p12-20020a056512312c00b004fe7dcc3dc1mr1784034lfd.44.1694612494095; Wed, 13
 Sep 2023 06:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230911170340.699533-1-mge@meta.com>
In-Reply-To: <20230911170340.699533-1-mge@meta.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Sep 2023 15:41:23 +0200
Message-ID: <CAMGffEm4dSagsKJBrCd5XLb-RonocWrTO2bsZJXG7tojxOLKiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pm80xx: Use phy specific sas address when sending
 PHY_START command
To:     Michal Grzedzicki <mge@meta.com>
Cc:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 7:03=E2=80=AFPM Michal Grzedzicki <mge@meta.com> wr=
ote:
>
> Some cards have more than one sas addresses. Using incorrect
> address causes communication issues with some devices like expanders.
>
> Signed-off-by: Michal Grzedzicki <mge@meta.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm800=
1_hwi.c
> index 33053db5a713..90069c7b1642 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -4180,7 +4180,7 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *p=
m8001_ha, u8 phy_id)
>         payload.sas_identify.dev_type =3D SAS_END_DEVICE;
>         payload.sas_identify.initiator_bits =3D SAS_PROTOCOL_ALL;
>         memcpy(payload.sas_identify.sas_addr,
> -               pm8001_ha->sas_addr, SAS_ADDR_SIZE);
> +               &pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
>         payload.sas_identify.phy_id =3D phy_id;
>
>         return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index f6857632dc7c..1b2c40b1381c 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4671,7 +4671,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *p=
m8001_ha, u8 phy_id)
>         payload.sas_identify.dev_type =3D SAS_END_DEVICE;
>         payload.sas_identify.initiator_bits =3D SAS_PROTOCOL_ALL;
>         memcpy(payload.sas_identify.sas_addr,
> -         &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
> +               &pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
>         payload.sas_identify.phy_id =3D phy_id;
>
>         return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
> --
> 2.34.1
>
