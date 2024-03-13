Return-Path: <linux-kernel+bounces-101185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EDC87A3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE6E2833B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127817566;
	Wed, 13 Mar 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcgoJy59"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1F168CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316685; cv=none; b=Z6Nm0YEuWZ1/+CXMClgnKb/sR9MFkAdnEG9FoajinSRlZ6ZVeBVgKUtfbGsBFl0c2kKQKJBlDNakJ/O5d8FJFmR/7ULYzqnfJk3MpTXog9a5rprdS580WGaVlPEiwnj6OJcGUSIq2h2De5U7rQVPYa9XuNFvAbD/kHHxOtVg0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316685; c=relaxed/simple;
	bh=zpVj8pyqyOguX/knzqVNsnnWNu90us2LsZ/oEuAvwBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaTFnNICQPKhvrMO/zNTdekZmOwwGV+uEhkTYe7aqpTTFKWjMkXOqPPrzm7tBQqx+UqiegshtgABszQz/8RROMYpf85J57+5XqbKTTqkIHZ7DTHE77Dx+uOkyWP1z3UOt0Klz+wGo7gRagH/R02VY1vLd+CmBNvwYDVKYNGUWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YcgoJy59; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512fab8cc6aso1500e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710316682; x=1710921482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyI5FAXtWQkxERpfKZsZMwqi1GPHG/mW7Kqn81tTW6o=;
        b=YcgoJy59n2KQW8h6GITHM2DSmhuewo9aDxstnrqfpRc9Vypz6unfJb/ppzk6hUpPBY
         1w7EsxhMGA079Sa3aDAygJVBPrZ2t3HYoAgdVE00Ut2XxPTzSk7pG0sF5/O6xM8zSUnC
         ucVOpfp0hp2FolJ237gebWWRxvTYnwXKZcLjZ4z0fujczYVFM+cKSd7BJR++onDYLIx6
         qhHALhrhxMnoXP+VghRCeosWjAEEXCsSVyT6fJYAbgVBmi3OietC7O4pPKGkg7t+epWh
         /XANH9lKXur3WJ3a1HzuS02uCEydmHSjQi3VDcSuWOQGsMu2p1S1ChdPACY/c6j/SDgH
         Msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316682; x=1710921482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyI5FAXtWQkxERpfKZsZMwqi1GPHG/mW7Kqn81tTW6o=;
        b=U6gkswx9yNdQ7atZjCewOa9EGA/s/nLMSA3ETRfb4jgfFZUNbjHn6gEafx4npdiToC
         iTKDqLhI1TXSIqUaxiT6LflrLuevy8Y56arA4gBCeZqML1hFxGeppcODvYadXW0Y86O/
         6gW+i88U0YxxyKhdalYcc/zBbb5/T6OEHJ5OvX4O2lG4HhtYwQ3UuYIcr6qqZTG2fUPs
         vl0AEkUhUiHsJM3wNIvLUhxcmkkc4/DPjRAW59MvfJq4bm3QJO4L/Plm+oDzTKXmIE3Y
         DqINpWdcycG4V8NCeVlLottHuJ2u2JCrfvH99whdIm1WMhtIQe0HnliF1ZAGNh/fW+ob
         9DOg==
X-Forwarded-Encrypted: i=1; AJvYcCUcIven5pRSgsq4kbtoV2hLXUEX5Eky0o2qTfZPVxZZHojhC65HH2bWWCS9OVk5t4+6KeVclcTZl2ZIpwt0mpb3XPjiDE7mBPGVUGn7
X-Gm-Message-State: AOJu0Yx5wV2dImlVMNaF2XE/dYypFC8eD2SdP3378xEvdMrr+FgDBgnH
	WRsJynodzpL68EYTzgJKDKfJEKxNbiTxrtLI38ZDu2aWzew/B1dvgV2efQ4w0CHy+HCdKnJN5ov
	t++WIVm6SjYdX365ZuTZ3QXYfyuzy690hX1Fh
X-Google-Smtp-Source: AGHT+IHM0WdL9YTTo7yhCq8E0OaBp5S7ioOj3YHzWu4iyKfgo1WVJSL5Maf+Diz0yFmQk1tLUHXQcq6N89vCkqPghoY=
X-Received: by 2002:a19:3803:0:b0:513:574a:c043 with SMTP id
 f3-20020a193803000000b00513574ac043mr76704lfa.6.1710316681848; Wed, 13 Mar
 2024 00:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313063306.32571-1-gakula@marvell.com>
In-Reply-To: <20240313063306.32571-1-gakula@marvell.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 08:57:50 +0100
Message-ID: <CANn89i++jodT8mzqY82LuxL2WXA4DF6XD5nCmHcsAyKe22Jxbw@mail.gmail.com>
Subject: Re: [v2 net PATCH] octeontx2-pf: Disable HW TSO for seg size < 16B
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, sgoutham@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:33=E2=80=AFAM Geetha sowjanya <gakula@marvell.com=
> wrote:
>
> Current NIX hardware do not support TSO for the
> segment size less 16 bytes. This patch disable hw
> TSO for such packets.
>
> Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>
> v1-v2:
>  - As suggested by Eric Dumazet used ndo_features_check().
>  - Moved the max fargments support check to ndo_features_check.
>
>  .../marvell/octeontx2/nic/otx2_common.c        | 18 ++++++++++++++++++
>  .../marvell/octeontx2/nic/otx2_common.h        |  3 +++
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c   |  1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 11 -----------
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c   |  1 +
>  5 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 02d0b707aea5..de61c69370be 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -221,6 +221,24 @@ int otx2_set_mac_address(struct net_device *netdev, =
void *p)
>  }
>  EXPORT_SYMBOL(otx2_set_mac_address);
>
> +netdev_features_t
> +otx2_features_check(struct sk_buff *skb, struct net_device *dev,
> +                   netdev_features_t features)
> +{
> +       /* Due to hw issue segment size less than 16 bytes
> +        * are not supported. Hence do not offload such TSO
> +        * segments.
> +        */
> +       if (skb_is_gso(skb) && skb_shinfo(skb)->gso_size < 16)
> +               features &=3D ~NETIF_F_GSO_MASK;
> +
> +       if (skb_shinfo(skb)->nr_frags + 1 > OTX2_MAX_FRAGS_IN_SQE)
> +               features &=3D ~NETIF_F_SG;
> +

This is a bit extreme. I would attempt to remove NETIF_F_GSO_MASK instead.

if (skb_is_gso(skb)) {
     if (skb_shinfo(skb)->gso_size < 16 ||
         skb_shinfo(skb)->nr_frags + 1 > OTX2_MAX_FRAGS_IN_SQE))
           features &=3D ~NETIF_F_GSO_MASK;
}

This would very often end up with 1-MSS packets with fewer fragments.

-> No copy involved, and no high order page allocations.

> +       return features;
> +}
> +EXPORT_SYMBOL(otx2_features_check);
> +
>  int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
>  {
>         struct nix_frs_cfg *req;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 06910307085e..6a4bf43bc77e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -961,6 +961,9 @@ void otx2_get_mac_from_af(struct net_device *netdev);
>  void otx2_config_irq_coalescing(struct otx2_nic *pfvf, int qidx);
>  int otx2_config_pause_frm(struct otx2_nic *pfvf);
>  void otx2_setup_segmentation(struct otx2_nic *pfvf);
> +netdev_features_t otx2_features_check(struct sk_buff *skb,
> +                                     struct net_device *dev,
> +                                     netdev_features_t features);
>
>  /* RVU block related APIs */
>  int otx2_attach_npa_nix(struct otx2_nic *pfvf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index e5fe67e73865..2364eb8d6732 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2737,6 +2737,7 @@ static const struct net_device_ops otx2_netdev_ops =
=3D {
>         .ndo_xdp_xmit           =3D otx2_xdp_xmit,
>         .ndo_setup_tc           =3D otx2_setup_tc,
>         .ndo_set_vf_trust       =3D otx2_ndo_set_vf_trust,
> +       .ndo_features_check     =3D otx2_features_check,
>  };
>
>  static int otx2_wq_init(struct otx2_nic *pf)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index f828d32737af..9b89aff42eb0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1158,17 +1158,6 @@ bool otx2_sq_append_skb(struct net_device *netdev,=
 struct otx2_snd_queue *sq,
>
>         num_segs =3D skb_shinfo(skb)->nr_frags + 1;
>
> -       /* If SKB doesn't fit in a single SQE, linearize it.
> -        * TODO: Consider adding JUMP descriptor instead.
> -        */
> -       if (unlikely(num_segs > OTX2_MAX_FRAGS_IN_SQE)) {
> -               if (__skb_linearize(skb)) {
> -                       dev_kfree_skb_any(skb);
> -                       return true;
> -               }
> -               num_segs =3D skb_shinfo(skb)->nr_frags + 1;
> -       }

Then you need to keep this check for  non GSO packets.

One way to trigger this is to run netperf with tiny fragments.
TCP is unable to cook GSO packets, because we hit MAX_SKB_FRAGS before
even filling a single MSS.

netperf -H $remote -t TCP_SENDFILE -- -m 10



> -
>         if (skb_shinfo(skb)->gso_size && !is_hw_tso_supported(pfvf, skb))=
 {
>                 /* Insert vlan tag before giving pkt to tso */
>                 if (skb_vlan_tag_present(skb))
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index 35e06048356f..04aab04e4ba2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -483,6 +483,7 @@ static const struct net_device_ops otx2vf_netdev_ops =
=3D {
>         .ndo_tx_timeout =3D otx2_tx_timeout,
>         .ndo_eth_ioctl  =3D otx2_ioctl,
>         .ndo_setup_tc =3D otx2_setup_tc,
> +       .ndo_features_check     =3D otx2_features_check,
>  };
>
>  static int otx2_wq_init(struct otx2_nic *vf)
> --
> 2.25.1
>

