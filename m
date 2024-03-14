Return-Path: <linux-kernel+bounces-103693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67C87C30F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD6EB20CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140DF7580F;
	Thu, 14 Mar 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC0r7q2A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4F74BED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442209; cv=none; b=cBtTOg/Fbmsw642rWK7mE+R4frCgAV3FjQZzrgJlih8F6q3+v7vZNSWkGa9UpkWYU0x2yaZktJx/mh06zAmweIWm46fIUrG5gE381Mc7p3cLh6h4J3fZxUrYhEIeWoS6tpSVw0upTFyUCArSf/6F+VjTijHceUsh9fAnSLbSsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442209; c=relaxed/simple;
	bh=51QG+kMBKRvX0OMVNWDsczdt4sCxh7ArJUhZ8Z86/qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSeNv/GBpoawR2Rxcfmz26hkDNPLuQWO1iMjXOYb1w+NI6Dxzvz4ikYbbHsxlQ6reChuyQcJvRiEr7GS/c96187GuKikYY4UDcBW6KmZunxZxxBZkRq0T+gDZelDZ1gDGppK83Mz+31cMYbtfVB3dvMh+wGS/KOpsNdRbQv1O0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC0r7q2A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710442206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkHbKx45Q3L1ZP5rRqbPmhlu/JcXI6MggY9Mklvo1v4=;
	b=OC0r7q2Ak9qSIQ54iQIkdMOKj3YNGEBPgOAdSZP7F3rMvdFZXLmZfFk5mzh5yvpmviyXd5
	Tn/5ukLF8t1RcWSR80YJ9aImff2cfk9mZj1yf5WuZFrCDLgvqjUyvKClSV6zuZ9dlXsd1B
	gMHAMXkK6erlaWV6yjdYVQJgTTASxVY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ELfByNL6PVmyQmfo04KLJg-1; Thu, 14 Mar 2024 14:50:05 -0400
X-MC-Unique: ELfByNL6PVmyQmfo04KLJg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513cb05fcfdso1426864e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442201; x=1711047001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkHbKx45Q3L1ZP5rRqbPmhlu/JcXI6MggY9Mklvo1v4=;
        b=amm2ZbUN0CjJedgKRqTdutAvhe4XTCW5A3yaZGlGH6FhyuDh69rz4w0Bio8jLQYsty
         hlFUIR0OmL7rFLUprMU2VyrlpH5Sl5gopHFAfqGe5rNcEXhyULJXAsLM/KjJcv+9GuRD
         QKSSBrIMAhiuaYySuyx5j+RyYCOyuRkZik0gMiwbpUFWZYJfq3AfcOP28U8L29sOa2zm
         qKUi12D9aTP1z/sH3Swkob3Qf8toc4NPTgdvUa/Bivg2pkJ7iBn6Y5xWzFu5W8izBnLH
         GhLaddaMldxhUH6hQnYUAXkiTtzHQaopUOjTmS+48LNKTueDO4nsxN2xhGYQlYTGItb6
         iUPA==
X-Forwarded-Encrypted: i=1; AJvYcCWbNMFHysItkuY4gmp6ODF1ruFMc8QloQl89gxqSk0MQkPRwBtWZ6E/Pc0lBqQfbc7O7bpA67RSEUCkLjA9tV67JmzuUP6GFJ5Y1qFb
X-Gm-Message-State: AOJu0YzD0VUxvBr58Qp0CqyFjUR9LdnGBehIp6vil+93kVJ+PYD9ZvCf
	yIOUFvIn3e/U/nIWAkce/ti0VK3b8jRXpXlG0x9SWdepvm0Gpc0iJe0AHxSXbSsUDY6TugMdn0d
	COMYcS7XzJbtpx2Km6g5Bd8E7uanK8Sce2KNY41R8uRv+R63eKHEUePQ5uBiNln9+74a1PfcAWM
	66jT+6pPpGyz+8bNKYccTkPv0BfCPcF8GCYQze
X-Received: by 2002:a05:6512:32a6:b0:513:a83b:6761 with SMTP id q6-20020a05651232a600b00513a83b6761mr1885576lfe.18.1710442201103;
        Thu, 14 Mar 2024 11:50:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtghzZpirTx7uWUx1wqC+kUfNpMI7U42XIL0zBH0JEsKvGaTG8pDZ0YAkiVa7RCY7lobB0BVqCikGH4ZvJahE=
X-Received: by 2002:a05:6512:32a6:b0:513:a83b:6761 with SMTP id
 q6-20020a05651232a600b00513a83b6761mr1885557lfe.18.1710442200593; Thu, 14 Mar
 2024 11:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314120049.111241-1-ivecera@redhat.com>
In-Reply-To: <20240314120049.111241-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 14 Mar 2024 19:49:49 +0100
Message-ID: <CADEbmW2iX9BnUSh5vWY7tC6dtXX1-XJrY5Ox1K1JPjkemwBM9g@mail.gmail.com>
Subject: Re: [PATCH net v2] i40e: Enforce software interrupt during busy-poll exit
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com, 
	aleksandr.loktionov@intel.com, Hugo Ferreira <hferreir@redhat.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:00=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
> during poll exit") followed by commit 23be7075b318 ("ice: fix software
> generating extra interrupts") I'm seeing the similar issue also with
> i40e driver.
>
> In certain situation when busy-loop is enabled together with adaptive
> coalescing, the driver occasionally misses that there are outstanding
> descriptors to clean when exiting busy poll.
>
> Try to catch the remaining work by triggering a software interrupt
> when exiting busy poll. No extra interrupts will be generated when
> busy polling is not used.
>
> The issue was found when running sockperf ping-pong tcp test with
> adaptive coalescing and busy poll enabled (50 as value busy_pool
> and busy_read sysctl knobs) and results in huge latency spikes
> with more than 100000us.
>
> The fix is inspired from the ice driver and do the following:
> 1) During napi poll exit in case of busy-poll (napo_complete_done()
>    returns false) this is recorded to q_vector that we were in busy
>    loop.
> 2) In i40e_update_enable_itr()
>    - updates refreshed ITR intervals directly using PFINT_ITRN register
>    - if we are exiting ordinary poll then just enables the interrupt
>      using PFINT_DYN_CTLN
>    - if we are exiting busy poll then enables the interrupt and
>      additionally triggers an immediate software interrupt to catch any
>      pending clean-ups
> 3) Reuses unused 3rd ITR (interrupt throttle) index and set it to
>    20K interrupts per second to limit the number of these sw interrupts.
>
> Test results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Prior:
> [root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 -=
-mps=3Dmax -t 120
> sockperf: =3D=3D version #3.10-no.git =3D=3D
> sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)
>
> [ 0] IP =3D 10.9.9.1        PORT =3D 11111 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: [Total Run] RunTime=3D119.999 sec; Warm up time=3D400 msec; Sen=
tMessages=3D2438563; ReceivedMessages=3D2438562
> sockperf: =3D=3D=3D=3D=3D=3D=3D=3D=3D Printing statistics for Server No: =
0
> sockperf: [Valid Duration] RunTime=3D119.549 sec; SentMessages=3D2429473;=
 ReceivedMessages=3D2429473
> sockperf: =3D=3D=3D=3D> avg-latency=3D24.571 (std-dev=3D93.297, mean-ad=
=3D4.904, median-ad=3D1.510, siqr=3D1.063, cv=3D3.797, std-error=3D0.060, 9=
9.0% ci=3D[24.417, 24.725])
> sockperf: # dropped messages =3D 0; # duplicated messages =3D 0; # out-of=
-order messages =3D 0
> sockperf: Summary: Latency is 24.571 usec
> sockperf: Total 2429473 observations; each percentile contains 24294.73 o=
bservations
> sockperf: ---> <MAX> observation =3D 103294.331
> sockperf: ---> percentile 99.999 =3D   45.633
> sockperf: ---> percentile 99.990 =3D   37.013
> sockperf: ---> percentile 99.900 =3D   35.910
> sockperf: ---> percentile 99.000 =3D   33.390
> sockperf: ---> percentile 90.000 =3D   28.626
> sockperf: ---> percentile 75.000 =3D   27.741
> sockperf: ---> percentile 50.000 =3D   26.743
> sockperf: ---> percentile 25.000 =3D   25.614
> sockperf: ---> <MIN> observation =3D   12.220
>
> After:
> [root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 -=
-mps=3Dmax -t 120
> sockperf: =3D=3D version #3.10-no.git =3D=3D
> sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)
>
> [ 0] IP =3D 10.9.9.1        PORT =3D 11111 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: [Total Run] RunTime=3D119.999 sec; Warm up time=3D400 msec; Sen=
tMessages=3D2400055; ReceivedMessages=3D2400054
> sockperf: =3D=3D=3D=3D=3D=3D=3D=3D=3D Printing statistics for Server No: =
0
> sockperf: [Valid Duration] RunTime=3D119.549 sec; SentMessages=3D2391186;=
 ReceivedMessages=3D2391186
> sockperf: =3D=3D=3D=3D> avg-latency=3D24.965 (std-dev=3D5.934, mean-ad=3D=
4.642, median-ad=3D1.485, siqr=3D1.067, cv=3D0.238, std-error=3D0.004, 99.0=
% ci=3D[24.955, 24.975])
> sockperf: # dropped messages =3D 0; # duplicated messages =3D 0; # out-of=
-order messages =3D 0
> sockperf: Summary: Latency is 24.965 usec
> sockperf: Total 2391186 observations; each percentile contains 23911.86 o=
bservations
> sockperf: ---> <MAX> observation =3D  195.841
> sockperf: ---> percentile 99.999 =3D   45.026
> sockperf: ---> percentile 99.990 =3D   39.009
> sockperf: ---> percentile 99.900 =3D   35.922
> sockperf: ---> percentile 99.000 =3D   33.482
> sockperf: ---> percentile 90.000 =3D   28.902
> sockperf: ---> percentile 75.000 =3D   27.821
> sockperf: ---> percentile 50.000 =3D   26.860
> sockperf: ---> percentile 25.000 =3D   25.685
> sockperf: ---> <MIN> observation =3D   12.277
>
> Fixes: 0bcd952feec7 ("ethernet/intel: consolidate NAPI and NAPI exit")
> Reported-by: Hugo Ferreira <hferreir@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +++
>  .../net/ethernet/intel/i40e/i40e_register.h   |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 46 ++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
>  5 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/etherne=
t/intel/i40e/i40e.h
> index ba24f3fa92c3..2fbabcdb5bb5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -955,6 +955,7 @@ struct i40e_q_vector {
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
> index f86578857e8a..6576a0081093 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3911,6 +3911,12 @@ static void i40e_vsi_configure_msix(struct i40e_vs=
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

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


