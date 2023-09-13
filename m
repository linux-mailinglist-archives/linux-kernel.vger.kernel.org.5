Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6488979E986
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbjIMNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjIMNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:42:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AB19BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:42:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so8829107a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1694612563; x=1695217363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPiMXPatZJVjyv7SBGb+AlKmkuYF/0lvNelGkcgX1eE=;
        b=b+sDv3R8iV4tRXFYAvD5TO1w7dCln3c59/fQj6E1kou1FMYUwmDCAy9+NKzamE1nAK
         hYZOiFt0FFoQSFnvLcB5X/QwbC2Dk6L6z9t/2sE0frL0vzSZzSBlpjYlHHMieQghcjaj
         tLnA+2I+XF8SSG1IYAihI9zcWkLQ+uXEaG+7iKHSKGadzDWcWmN34bcqzS2IyjphDYuU
         gVUR/0UBuTUsQ7FW1/DSCAGa9hoHRZmvSWj+EuX6E+5IdUQ3rtiDZAl3Lpgc3xCUX9Yb
         HXIinCOlOG1BOrN7gKh3k6eq+pYBUGE7TbjmD0SQALArjb5hr1tpS7vfEfo9Tus0pk65
         W3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694612563; x=1695217363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPiMXPatZJVjyv7SBGb+AlKmkuYF/0lvNelGkcgX1eE=;
        b=XiMt1DRbKvzixpcS/MMXwsLgNCF9jaxNej/sQn2cDIkNlYJhl5N48XQa4lbIr7HVkR
         cKJEQYs3QAbiw1xuoq4uIinQqMBfJsi1QhEvGFr5v4gxdcgGfKybPM1wT+wwvo8czVEa
         x64tx6H+NISklrXI75eKPdFtOcCerL+YONG+jQnSEfccMr9xuWjf7dhD79kIU6FxXdw3
         ugUv9mbkAupD6UfbbcSf1I7Rs8CEZqfdj/Ks2YvLMdHsVsX0sdttTgsjnI36mwadfDYS
         NcSev3/8kU31f013k01K2xsH+ozvrQ7GzaKh8/VhzfcZFeD1uT7bE/7UcwvIyXrmf60c
         uBEQ==
X-Gm-Message-State: AOJu0Yw7TQnJxotUhJ0Xsv+0607rkVFEr+ZIKiCpuWCu9c7OYSW8YFU9
        r+4QVCgfkh42yL7fhioWNhyojb3xYqQAelWfsBU+1w==
X-Google-Smtp-Source: AGHT+IF9n/C9qnYQx3bsd4Pgzhwlxwmzz75gOLhHdUsGRW0QiTyJilwXXxQkeyjbuVClCY2VglvzkOOTJ1Cs884ZYf0=
X-Received: by 2002:a05:6402:2028:b0:523:1410:b611 with SMTP id
 ay8-20020a056402202800b005231410b611mr2261215edb.25.1694612563055; Wed, 13
 Sep 2023 06:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230911170340.699533-1-mge@meta.com> <20230911170340.699533-2-mge@meta.com>
In-Reply-To: <20230911170340.699533-2-mge@meta.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Sep 2023 15:42:32 +0200
Message-ID: <CAMGffE=kWc1rsNfn6n8d1qkYw2U8sz+n5E-GEkWB7=835j=66g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pm80xx: Avoid leaking tags when processing
 OPC_INB_SET_CONTROLLER_CONFIG command
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
> Tags allocated for OPC_INB_SET_CONTROLLER_CONFIG command need to be freed
> when we receive the response.
>
> Signed-off-by: Michal Grzedzicki <mge@meta.com>
can you please add the fixes tag, so stable can pick it accordingly?
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index 1b2c40b1381c..3afd9443c425 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3671,10 +3671,12 @@ static int mpi_set_controller_config_resp(struct =
pm8001_hba_info *pm8001_ha,
>                         (struct set_ctrl_cfg_resp *)(piomb + 4);
>         u32 status =3D le32_to_cpu(pPayload->status);
>         u32 err_qlfr_pgcd =3D le32_to_cpu(pPayload->err_qlfr_pgcd);
> +       u32 tag =3D le32_to_cpu(pPayload->tag);
>
>         pm8001_dbg(pm8001_ha, MSG,
>                    "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
>                    status, err_qlfr_pgcd);
> +       pm8001_tag_free(pm8001_ha, tag);
>
>         return 0;
>  }
> --
> 2.34.1
>
