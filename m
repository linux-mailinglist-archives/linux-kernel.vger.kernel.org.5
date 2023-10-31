Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F23D7DCB68
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbjJaLHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbjJaLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81421A1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698750392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeNTgEg8tsCK+iB2JBATlgJcpJ/vml1SpbMe3EquNfs=;
        b=bgkXzrgIqqF9eDc43BcNg/G6eEZy0PwVTlsuc/lg/npraX5Nn6Ywy2OdoNOk5JEDn7QY6v
        hVBrC2HFFttOUYOyTGNnq2wbv7cmffD6P0wedgGbmbZ9hjj0fvE7QiZjqj2uQJRHd7bX8Z
        fFJOZKyevuG++EsT2Eng8bZxXDChmtQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-h6_GJDEiNtSDeeRuhpUALQ-1; Tue, 31 Oct 2023 07:06:31 -0400
X-MC-Unique: h6_GJDEiNtSDeeRuhpUALQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-534838150afso976058a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750390; x=1699355190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeNTgEg8tsCK+iB2JBATlgJcpJ/vml1SpbMe3EquNfs=;
        b=hO5sS7flUlLmFC4lkemDxDtVzZJdohuRJkwUuWJ9GNmAl87GjXBXn+AEWA6pSCVsXY
         Icp/WH7Mzcsluv4tjid0p3pOlYBrVQLCZ98F4VMTiKCEprs2Ko2TbNR4ADJYN0kMERjm
         yD9HOPYkn1smGKK7m+Sl2SWIsiuoGkc0qo/QDFqFRsCFwOOb8uK75udIKV0cKd7Jt1y6
         JvEFbIdrasxZdMR1UmGBC9Pkcnj8FDqjM8Palru9cIfElvStyr966vYDHuWtahdH5tMZ
         7hLQCKDqahI52IUM8FUeLucWoEOVkkTcdMhMywaGGnasSg0d6wGtOOEbvFLodkDsGl8z
         qDNA==
X-Gm-Message-State: AOJu0YwNXU2pQDNFRv8IvX/m1jQ+9iReY5WF8bWpVnE9OD4++WWyoNmM
        GF1tNZ7UvI+ct7ba536gnbWQ9d8kWsgk0wTljZ21xQQPmEqO4CsLmG8mAG2EZ8u5dNb4SHq8a0r
        YxajYBPy3HUEwQ7Eq1H0mXVHE
X-Received: by 2002:a50:d49e:0:b0:53f:18f6:a153 with SMTP id s30-20020a50d49e000000b0053f18f6a153mr9697626edi.3.1698750389878;
        Tue, 31 Oct 2023 04:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU3fW9CjMF9NxM2NJf+1GvsoCwESzcm25+DVXEtCmrvZvzCFMKH+ZzuSFKY7gpsIMYtpRC6w==
X-Received: by 2002:a50:d49e:0:b0:53f:18f6:a153 with SMTP id s30-20020a50d49e000000b0053f18f6a153mr9697604edi.3.1698750389448;
        Tue, 31 Oct 2023 04:06:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b005434095b179sm942853edx.92.2023.10.31.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:06:29 -0700 (PDT)
Message-ID: <5a46ffb675addbed8a3dac176effb96eb2c8ca3e.camel@redhat.com>
Subject: Re: [PATCH net v1 2/2] octeontx2-pf: Fix holes in error code
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, wojciech.drewek@intel.com
Date:   Tue, 31 Oct 2023 12:06:27 +0100
In-Reply-To: <20231027021953.1819959-2-rkannoth@marvell.com>
References: <20231027021953.1819959-1-rkannoth@marvell.com>
         <20231027021953.1819959-2-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-27 at 07:49 +0530, Ratheesh Kannoth wrote:
> Error code strings are not getting printed properly
> due to holes. Print error code as well.
>=20
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]=
")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>=20
> ---
> ChangeLog:
>=20
> v0 -> v1: Splitted patch into two
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 +++++++++++--------
>  1 file changed, 46 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 6daf4d58c25d..125fe231702a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1193,31 +1193,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] =3D=
 {
>  };
> =20
>  static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =3D  {
> -	"NIX_SND_STATUS_GOOD",
> -	"NIX_SND_STATUS_SQ_CTX_FAULT",
> -	"NIX_SND_STATUS_SQ_CTX_POISON",
> -	"NIX_SND_STATUS_SQB_FAULT",
> -	"NIX_SND_STATUS_SQB_POISON",
> -	"NIX_SND_STATUS_HDR_ERR",
> -	"NIX_SND_STATUS_EXT_ERR",
> -	"NIX_SND_STATUS_JUMP_FAULT",
> -	"NIX_SND_STATUS_JUMP_POISON",
> -	"NIX_SND_STATUS_CRC_ERR",
> -	"NIX_SND_STATUS_IMM_ERR",
> -	"NIX_SND_STATUS_SG_ERR",
> -	"NIX_SND_STATUS_MEM_ERR",
> -	"NIX_SND_STATUS_INVALID_SUBDC",
> -	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
> -	"NIX_SND_STATUS_DATA_FAULT",
> -	"NIX_SND_STATUS_DATA_POISON",
> -	"NIX_SND_STATUS_NPC_DROP_ACTION",
> -	"NIX_SND_STATUS_LOCK_VIOL",
> -	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_ABORT",
> -	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
> -	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
> -	"NIX_SND_STATUS_SEND_STATS_ERR",
> +	[NIX_SND_STATUS_GOOD] =3D "NIX_SND_STATUS_GOOD",
> +	[NIX_SND_STATUS_SQ_CTX_FAULT] =3D "NIX_SND_STATUS_SQ_CTX_FAULT",
> +	[NIX_SND_STATUS_SQ_CTX_POISON] =3D "NIX_SND_STATUS_SQ_CTX_POISON",
> +	[NIX_SND_STATUS_SQB_FAULT] =3D "NIX_SND_STATUS_SQB_FAULT",
> +	[NIX_SND_STATUS_SQB_POISON] =3D "NIX_SND_STATUS_SQB_POISON",
> +	[NIX_SND_STATUS_HDR_ERR] =3D "NIX_SND_STATUS_HDR_ERR",
> +	[NIX_SND_STATUS_EXT_ERR] =3D "NIX_SND_STATUS_EXT_ERR",
> +	[NIX_SND_STATUS_JUMP_FAULT] =3D "NIX_SND_STATUS_JUMP_FAULT",
> +	[NIX_SND_STATUS_JUMP_POISON] =3D "NIX_SND_STATUS_JUMP_POISON",
> +	[NIX_SND_STATUS_CRC_ERR] =3D "NIX_SND_STATUS_CRC_ERR",
> +	[NIX_SND_STATUS_IMM_ERR] =3D "NIX_SND_STATUS_IMM_ERR",
> +	[NIX_SND_STATUS_SG_ERR] =3D "NIX_SND_STATUS_SG_ERR",
> +	[NIX_SND_STATUS_MEM_ERR] =3D "NIX_SND_STATUS_MEM_ERR",
> +	[NIX_SND_STATUS_INVALID_SUBDC] =3D "NIX_SND_STATUS_INVALID_SUBDC",
> +	[NIX_SND_STATUS_SUBDC_ORDER_ERR] =3D "NIX_SND_STATUS_SUBDC_ORDER_ERR",
> +	[NIX_SND_STATUS_DATA_FAULT] =3D "NIX_SND_STATUS_DATA_FAULT",
> +	[NIX_SND_STATUS_DATA_POISON] =3D "NIX_SND_STATUS_DATA_POISON",
> +	[NIX_SND_STATUS_NPC_DROP_ACTION] =3D "NIX_SND_STATUS_NPC_DROP_ACTION",
> +	[NIX_SND_STATUS_LOCK_VIOL] =3D "NIX_SND_STATUS_LOCK_VIOL",
> +	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] =3D "NIX_SND_STAT_NPC_UCAST_CHAN_ER=
R",
> +	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] =3D "NIX_SND_STAT_NPC_MCAST_CHAN_ER=
R",
> +	[NIX_SND_STATUS_NPC_MCAST_ABORT] =3D "NIX_SND_STATUS_NPC_MCAST_ABORT",
> +	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] =3D "NIX_SND_STATUS_NPC_VTAG_PTR_ERR"=
,
> +	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] =3D "NIX_SND_STATUS_NPC_VTAG_SIZE_ER=
R",
> +	[NIX_SND_STATUS_SEND_MEM_FAULT] =3D "NIX_SND_STATUS_SEND_MEM_FAULT",
> +	[NIX_SND_STATUS_SEND_STATS_ERR] =3D "NIX_SND_STATUS_SEND_STATS_ERR",
>  };
> =20
>  static irqreturn_t otx2_q_intr_handler(int irq, void *data)
> @@ -1238,14 +1239,16 @@ static irqreturn_t otx2_q_intr_handler(int irq, v=
oid *data)
>  			continue;
> =20
>  		if (val & BIT_ULL(42)) {
> -			netdev_err(pf->netdev, "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_L=
F_ERR_INT 0x%llx\n",
> +			netdev_err(pf->netdev,
> +				   "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n"=
,
>  				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
>  		} else {
>  			if (val & BIT_ULL(NIX_CQERRINT_DOOR_ERR))
>  				netdev_err(pf->netdev, "CQ%lld: Doorbell error",
>  					   qidx);
>  			if (val & BIT_ULL(NIX_CQERRINT_CQE_FAULT))
> -				netdev_err(pf->netdev, "CQ%lld: Memory fault on CQE write to LLC/DRA=
M",
> +				netdev_err(pf->netdev,
> +					   "CQ%lld: Memory fault on CQE write to LLC/DRAM",
>  					   qidx);
>  		}

It's not a big deal (no need to repost just for this), but the above
chunk (and a couple below, too) is not related to the current fix, you
should have not included it here.

Cheers,

Paolo

> =20
> @@ -1272,7 +1275,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, voi=
d *data)
>  			     (val & NIX_SQINT_BITS));
> =20
>  		if (val & BIT_ULL(42)) {
> -			netdev_err(pf->netdev, "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_L=
F_ERR_INT 0x%llx\n",
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n"=
,
>  				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
>  			goto done;
>  		}
> @@ -1282,8 +1286,11 @@ static irqreturn_t otx2_q_intr_handler(int irq, vo=
id *data)
>  			goto chk_mnq_err_dbg;
> =20
>  		sq_op_err_code =3D FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=3D%s\n=
",
> -			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
> +		netdev_err(pf->netdev,
> +			   "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=3D%s(%#x)\n",
> +			   qidx, sq_op_err_dbg,
> +			   nix_sqoperr_e_str[sq_op_err_code],
> +			   sq_op_err_code);
> =20
>  		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
> =20
> @@ -1300,16 +1307,21 @@ static irqreturn_t otx2_q_intr_handler(int irq, v=
oid *data)
>  			goto chk_snd_err_dbg;
> =20
>  		mnq_err_code =3D FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=3D%s\n",
> -			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
> +		netdev_err(pf->netdev,
> +			   "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=3D%s(%#x)\n",
> +			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code],
> +			   mnq_err_code);
>  		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
> =20
>  chk_snd_err_dbg:
>  		snd_err_dbg =3D otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
>  		if (snd_err_dbg & BIT(44)) {
>  			snd_err_code =3D FIELD_GET(GENMASK(7, 0), snd_err_dbg);
> -			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=3D%s\n"=
,
> -				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=3D%s(%#x)\n",
> +				   qidx, snd_err_dbg,
> +				   nix_snd_status_e_str[snd_err_code],
> +				   snd_err_code);
>  			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
>  		}
> =20

