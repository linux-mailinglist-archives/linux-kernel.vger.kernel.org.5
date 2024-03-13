Return-Path: <linux-kernel+bounces-101559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A366687A8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D484B1C21D16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD243AC3;
	Wed, 13 Mar 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW+JHyXM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2E4205B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337655; cv=none; b=MKUXnBYWUrXb+filZbM/gT78r/WSPAh8vlfd2r3X5oU6SrsXANf56LTOIp6jFW+d31/uDbTCr6fvt2PTwA35lTsgNDxWr7Qxz2kGDsx1CnaSS/BekL8PjrmzABiL2OnYtS4WUpgCgLdL5ReaSEcoIIgPPi09FUfUyTT7SmQHGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337655; c=relaxed/simple;
	bh=9/dw73MZ1B7UIIGQkyR0OGzndhExa1cPWv5TXntkIIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIlyj73hbsdYiUZQFhKreO6c/kBrGHpO6/lhWH+LXhFSezs88wZmrDdLcF+O54zoWMqQZIGvCj6q/8qzmROwsCCwBKwkAQ0gOQtp4WXtBBGTv8QNCiZf5VlIPrv1OLD/gAijyWzytFPYez0i/ALO6yP02Dl882UcHaS/vfHvTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aW+JHyXM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710337652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lto8TWMjEVdFuevVc7/99LmKN94KTvc/sJ/quGAixZg=;
	b=aW+JHyXMLFSaULDDdC61AKLWptoTq0tT6Z9BHFvyrGYxcga3fdZNkpEKPt7cqgJJrEee+B
	ehxNjl0VcnDXo6d/+b5hIAUtU+jcpNYY0VrahLJWtPKe5NnFP97rNSFc7G+A2adQfhQTaQ
	yr6pZipv0bWtoaFs1yxGCFCv383CKtg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-P2Z8A5kEO0SlEc-sBuQaiA-1; Wed, 13 Mar 2024 09:47:31 -0400
X-MC-Unique: P2Z8A5kEO0SlEc-sBuQaiA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a462e4d8c44so182705866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710337649; x=1710942449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lto8TWMjEVdFuevVc7/99LmKN94KTvc/sJ/quGAixZg=;
        b=bisLjUWyCIK024H1B6G+tFdOwh9o4j1tjnQQ9YRRzhgybvxJBpMRIqZHrObMjtYt3g
         8LU93FOCbyRk0a6nU1+uva5jI2Rdzn8OYkYBCom0/KUNPPevy2ZWrWGesG8aMUsHSU3A
         phFKzfEeEw8FQCCIfPJkjXqNlDS0/RN/h4xwuDZdoDp0Cr+YazFmstC6L9im6sivm7nq
         1pM61jr8kY5nFWNXVusA5rSFTRsj9Uf4hoOXCSVyxYGZzEarpTzw86ZKTfiua4Aj9FKN
         9Os4IN5xwijdBs/FEXvtcV6VZwI4IcviK5oqXlT92QR89dWbep41rqMtYbfUD0Od0kkA
         XqEA==
X-Forwarded-Encrypted: i=1; AJvYcCXAYXWtR7fvvtp1s9VHzYhQJDA+viILRtVG9CUvmvy83xzWzvgGbCjZrBbQJ7aSQutF7yvCJ675tIrWo3DIx4Bvj3O9BlAXVPZCDy3X
X-Gm-Message-State: AOJu0YwBMJXyuk7X7VZYpqzdtMfyqQYXo7zrpA9TiyLeaVG5zD5wFOt5
	Ywi7qku4fFj51sR+BWjiSHP8nImaRjg2UefBBLvbYolco4JVqcApoPBr6eR57BWsuqAXVOEx849
	RclLx69R3BISb0XZnr2bPilZyh0MpVS1cWGd8jo3yE92SFz87FuWjb+tBtc8pgmKvq28vegr0kw
	rYWb6PGYzwsQg6Shu/cJZkWtWb9mV4k3eTm2uZrJDxhJ9v
X-Received: by 2002:a17:907:cbc7:b0:a45:f6de:ed18 with SMTP id vk7-20020a170907cbc700b00a45f6deed18mr9073956ejc.33.1710337649135;
        Wed, 13 Mar 2024 06:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGJcXvlWwReaRwLW3NSJHwQRUHzlMHgiH4ScCAv1zMBjYi4W2IspS4yfNyP51M1go2REeZir7h7rG2Yxttg6w=
X-Received: by 2002:a17:907:cbc7:b0:a45:f6de:ed18 with SMTP id
 vk7-20020a170907cbc700b00a45f6deed18mr9073943ejc.33.1710337648756; Wed, 13
 Mar 2024 06:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313125457.19475-1-ivecera@redhat.com>
In-Reply-To: <20240313125457.19475-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 13 Mar 2024 14:47:17 +0100
Message-ID: <CADEbmW3NQ7SQpccOqTD=p_czpBbOY=41kS7krwx2ZEDmFfcgrg@mail.gmail.com>
Subject: Re: [PATCH net] i40e: Enforce software interrupt during busy-poll exit
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com, 
	aleksandr.loktionov@intel.com, Hugo Ferreira <hferreir@redhat.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 1:55=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/etherne=
t/intel/i40e/i40e.h
> index 9b701615c7c6..4d2b05de6c63 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -908,6 +908,7 @@ struct i40e_q_vector {
>         struct rcu_head rcu;    /* to avoid race with update stats on fre=
e */
>         char name[I40E_INT_NAME_STR_LEN];
>         bool arm_wb_state;
> +       bool in_busy_poll;
>         int irq_num;            /* IRQ assigned to this q_vector */
>  } ____cacheline_internodealigned_in_smp;
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 89a3401d20ab..1ea6d06b0acc 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3915,6 +3915,12 @@ static void i40e_vsi_configure_msix(struct i40e_vs=
i *vsi)
>                      q_vector->tx.target_itr >> 1);
>                 q_vector->tx.current_itr =3D q_vector->tx.target_itr;
>
> +               /* Set ITR for software interrupts triggered after exitin=
g
> +                * busy-loop polling.
> +                */
> +               wr32(hw, I40E_PFINT_ITRN(I40E_SW_ITR, vector - 1),
> +                    I40E_ITR_20K);
> +
>                 wr32(hw, I40E_PFINT_RATEN(vector - 1),
>                      i40e_intrl_usec_to_reg(vsi->int_rate_limit));
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/ne=
t/ethernet/intel/i40e/i40e_register.h
> index 14ab642cafdb..baa6bb68bcf8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -335,6 +335,8 @@
>  #define I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT 5
>  #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT 24
>  #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK I40E_MASK(0x1, I40E_PFI=
NT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT)
> +#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT 25
> +#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_D=
YN_CTLN_SW_ITR_INDX_SHIFT)
>  #define I40E_PFINT_ICR0 0x00038780 /* Reset: CORER */
>  #define I40E_PFINT_ICR0_INTEVENT_SHIFT 0
>  #define I40E_PFINT_ICR0_INTEVENT_MASK I40E_MASK(0x1, I40E_PFINT_ICR0_INT=
EVENT_SHIFT)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40e/i40e_txrx.c
> index 0d7177083708..356c3140adf3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2658,8 +2658,22 @@ static inline u32 i40e_buildreg_itr(const int type=
, u16 itr)
>         return val;
>  }
>
> -/* a small macro to shorten up some long lines */
> -#define INTREG I40E_PFINT_DYN_CTLN
> +static inline u32 i40e_buildreg_swint(int type)
> +{
> +       u32 val;
> +
> +       /* 1. Enable the interrupt
> +        * 2. Do not modify any ITR interval
> +        * 3. Trigger a SW interrupt specified by type
> +        */
> +       val =3D I40E_PFINT_DYN_CTLN_INTENA_MASK |
> +             I40E_PFINT_DYN_CTLN_ITR_INDX_MASK | /* set noitr */
> +             I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
> +             I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
> +             FIELD_PREP(I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK, type);
> +
> +       return val;
> +}

This function is called only from one place and with a constant
argument. Does it  really need to be a function, as opposed to a
constant? Or are you going to add more callers soon?

>
>  /* The act of updating the ITR will cause it to immediately trigger. In =
order
>   * to prevent this from throwing off adaptive update statistics we defer=
 the
> @@ -2702,8 +2716,8 @@ static inline void i40e_update_enable_itr(struct i4=
0e_vsi *vsi,
>          */
>         if (q_vector->rx.target_itr < q_vector->rx.current_itr) {
>                 /* Rx ITR needs to be reduced, this is highest priority *=
/
> -               intval =3D i40e_buildreg_itr(I40E_RX_ITR,
> -                                          q_vector->rx.target_itr);
> +               wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
> +                    q_vector->rx.target_itr >> 1);
>                 q_vector->rx.current_itr =3D q_vector->rx.target_itr;
>                 q_vector->itr_countdown =3D ITR_COUNTDOWN_START;
>         } else if ((q_vector->tx.target_itr < q_vector->tx.current_itr) |=
|
> @@ -2712,25 +2726,33 @@ static inline void i40e_update_enable_itr(struct =
i40e_vsi *vsi,
>                 /* Tx ITR needs to be reduced, this is second priority
>                  * Tx ITR needs to be increased more than Rx, fourth prio=
rity
>                  */
> -               intval =3D i40e_buildreg_itr(I40E_TX_ITR,
> -                                          q_vector->tx.target_itr);
> +               wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, q_vector->reg_idx),
> +                    q_vector->tx.target_itr >> 1);
>                 q_vector->tx.current_itr =3D q_vector->tx.target_itr;
>                 q_vector->itr_countdown =3D ITR_COUNTDOWN_START;
>         } else if (q_vector->rx.current_itr !=3D q_vector->rx.target_itr)=
 {
>                 /* Rx ITR needs to be increased, third priority */
> -               intval =3D i40e_buildreg_itr(I40E_RX_ITR,
> -                                          q_vector->rx.target_itr);
> +               wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
> +                    q_vector->rx.target_itr >> 1);
>                 q_vector->rx.current_itr =3D q_vector->rx.target_itr;
>                 q_vector->itr_countdown =3D ITR_COUNTDOWN_START;
>         } else {
>                 /* No ITR update, lowest priority */
> -               intval =3D i40e_buildreg_itr(I40E_ITR_NONE, 0);
>                 if (q_vector->itr_countdown)
>                         q_vector->itr_countdown--;
>         }
>
> -       if (!test_bit(__I40E_VSI_DOWN, vsi->state))
> -               wr32(hw, INTREG(q_vector->reg_idx), intval);
> +       /* Do not enable interrupt if VSI is down */
> +       if (test_bit(__I40E_VSI_DOWN, vsi->state))
> +               return;
> +
> +       if (!q_vector->in_busy_poll) {
> +               intval =3D i40e_buildreg_itr(I40E_ITR_NONE, 0);
> +       } else {
> +               q_vector->in_busy_poll =3D false;
> +               intval =3D i40e_buildreg_swint(I40E_SW_ITR);
> +       }
> +       wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->reg_idx), intval);
>  }
>
>  /**
> @@ -2845,6 +2867,8 @@ int i40e_napi_poll(struct napi_struct *napi, int bu=
dget)
>          */
>         if (likely(napi_complete_done(napi, work_done)))
>                 i40e_update_enable_itr(vsi, q_vector);
> +       else
> +               q_vector->in_busy_poll =3D true;
>
>         return min(work_done, budget - 1);
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/et=
hernet/intel/i40e/i40e_txrx.h
> index abf15067eb5d..2cdc7de6301c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -68,6 +68,7 @@ enum i40e_dyn_idx {
>  /* these are indexes into ITRN registers */
>  #define I40E_RX_ITR    I40E_IDX_ITR0
>  #define I40E_TX_ITR    I40E_IDX_ITR1
> +#define I40E_SW_ITR    I40E_IDX_ITR2
>
>  /* Supported RSS offloads */
>  #define I40E_DEFAULT_RSS_HENA ( \
> --
> 2.43.0
>


