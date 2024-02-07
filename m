Return-Path: <linux-kernel+bounces-56104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CE84C603
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA76A2829C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC01200B7;
	Wed,  7 Feb 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L+59NMtE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB8200A5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293408; cv=none; b=sotw1uu3GUaWc1SpFiXnlRoomvfPI/GMZJXekJFicJobSTjaPLF0qEfyCTHJo4FVqvULOybrQNqzi61+7uTi0DPvMiHGRg0A27nBtYkhMhelsingz6YAJ6Vvmms7L9Yu5eB2qsdE/Bx/TalQlOtAUTFW8S6HlvQsNOkbEmquOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293408; c=relaxed/simple;
	bh=K966EEW2bn57d0PJDaHnyDzFPTTkj9+73hl0MGCu8Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neBXsUbpFtjvAoXhV7grhqEFeweRpko9tkvSfB+vskRKLUdMkAMJrKAxcF5QFSynqJoUIvdEwrQ/GIdh9p93o5wFukuUf2RxkXuwsb2roZOdOYUAhTIR+/9TeLhGi/qjpQlZw1Ak8FSMUC1pzOFwBbueEr9pzcbnUUXitf0kPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L+59NMtE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5116643c64eso593660e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707293403; x=1707898203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvIZaWk0eDVyDx7v9H+HqK4CGJBev3wT2rsOSf4zlOU=;
        b=L+59NMtEl/B9hK+MGWcI8vnRaB8h2AeRpdCuPqZ2/g76cZK1kPPW8P7/lWpyMP1ZnQ
         tEF4teywvZCXswvqJ0C3y5iXiYL7U4ld70a/t80xktCl25tc2B2mGvTFR3yTZCDoQCus
         q4QumyBzJWeAYKXZbZeJOHCBKHZtytXYQkrS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707293403; x=1707898203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvIZaWk0eDVyDx7v9H+HqK4CGJBev3wT2rsOSf4zlOU=;
        b=htW1C0EOJnb5JakKziZ3G8iuuaaCPAMu/RV7G1VWPObMR0FYt/bvv3tYswHHLRr+K8
         FvkOQN7krHvfwMBz77pdZUU8xsFNYiur5F20mWmFUWsB7WE9p66zfW5r870JtFEur7Bc
         /1UafkIsfNjVleV3RpjagIiMX0RGpkZswJ7HYk47Owf/h66VNbztkLVIGl+9z0V0WvV7
         Vlq+fXHcJnDhCZ7DOpCwvmdP3IBYYK1YI+MtdkAqLuj8mfUbC+i4znfNLk0I9plk1mim
         R1de3BXirF/Rwa3Ja+JvCtj/PoQ+NX0nOriHaNWloDDo3CMUWNeVm5XtiI3RrOys+jd3
         suow==
X-Gm-Message-State: AOJu0YxFEbvi2X40mUGMyo6Po7pyPruY/s3de4OqG0YlzahNrL5yYNiX
	F7frNCRZ6olqmSke7h0zyQcnD5IaXNEKgRkKr6BGTzL0HjKAYGrMU2TxntXO3+ho4ISLfPbrNgU
	B4J9PtsCATrA0JuySTKk5gNoeNVX60hm+3Qrl
X-Google-Smtp-Source: AGHT+IHeooc31o+ITQqZLaho0vKILTtlPpO0DR0u0ENOCkC3UYc0yJOS5jBMbKamLIsiaP6jaoim7suj68//OOIrqGA=
X-Received: by 2002:ac2:555a:0:b0:511:3ee1:4edf with SMTP id
 l26-20020ac2555a000000b005113ee14edfmr2938402lfk.68.1707293403453; Wed, 07
 Feb 2024 00:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207065207.3092004-1-srasheed@marvell.com> <20240207065207.3092004-6-srasheed@marvell.com>
In-Reply-To: <20240207065207.3092004-6-srasheed@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 7 Feb 2024 13:39:51 +0530
Message-ID: <CAH-L+nN04MuWS-QOxpPfQMD5iAvdZPFCp0nffuhB43+puLgk_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/8] octeon_ep_vf: add support for ndo ops
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, sedara@marvell.com, egallen@redhat.com, 
	mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Satananda Burla <sburla@marvell.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ddbf4e0610c638d7"

--000000000000ddbf4e0610c638d7
Content-Type: multipart/alternative; boundary="000000000000d7a04f0610c6385f"

--000000000000d7a04f0610c6385f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:23=E2=80=AFPM Shinas Rasheed <srasheed@marvell.co=
m> wrote:

> Add support for ndo ops to set MAC address, change MTU, get stats.
> Add control path support to set MAC address, change MTU, get stats,
> set speed, get and set link mode.
>
[Kalesh]: You are adding support for only one ndo hook ".ndo_get_stats64"
in this patch. Am I missing something?

>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V6:
>   - No changes
>
> V5:
> https://lore.kernel.org/all/20240129050254.3047778-6-srasheed@marvell.com=
/
>   - No changes
>
> V4:
> https://lore.kernel.org/all/20240108124213.2966536-6-srasheed@marvell.com=
/
>   - Provide more stats in ndo_get_stats64 such as tx_dropped, rx_dropped
>     etc.
>
> V3:
> https://lore.kernel.org/all/20240105203823.2953604-6-srasheed@marvell.com=
/
>   - No changes
>
> V2:
> https://lore.kernel.org/all/20231223134000.2906144-6-srasheed@marvell.com=
/
>   - No changes
>
> V1:
> https://lore.kernel.org/all/20231221092844.2885872-6-srasheed@marvell.com=
/
>
>  .../marvell/octeon_ep_vf/octep_vf_main.c      | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> index 562beed9af6a..ff879b1e846e 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> @@ -186,6 +186,23 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buf=
f
> *skb,
>         return NETDEV_TX_OK;
>  }
>
> +int octep_vf_get_if_stats(struct octep_vf_device *oct)
>
[Kalesh]: You may want to make this function static.

> +{
> +       struct octep_vf_iface_rxtx_stats vf_stats;
> +       int ret, size;
> +
> +       memset(&vf_stats, 0, sizeof(struct octep_vf_iface_rxtx_stats));
>
[Kalesh]: You can avoid memset by initializing vf_stats =3D {};

> +       ret =3D octep_vf_mbox_bulk_read(oct, OCTEP_PFVF_MBOX_CMD_GET_STAT=
S,
> +                                     (u8 *)&vf_stats, &size);
> +       if (!ret) {
>
[Kalesh] For better alignment:
if (ret)
     return ret;

> +               memcpy(&oct->iface_rx_stats, &vf_stats.iface_rx_stats,
> +                      sizeof(struct octep_vf_iface_rx_stats));
> +               memcpy(&oct->iface_tx_stats, &vf_stats.iface_tx_stats,
> +                      sizeof(struct octep_vf_iface_tx_stats));
> +       }
> +       return ret;
> +}
> +
>  int octep_vf_get_link_info(struct octep_vf_device *oct)
>  {
>         int ret, size;
> @@ -199,6 +216,46 @@ int octep_vf_get_link_info(struct octep_vf_device
> *oct)
>         return 0;
>  }
>
> +/**
> + * octep_vf_get_stats64() - Get Octeon network device statistics.
> + *
> + * @netdev: kernel network device.
> + * @stats: pointer to stats structure to be filled in.
> + */
> +static void octep_vf_get_stats64(struct net_device *netdev,
> +                                struct rtnl_link_stats64 *stats)
> +{
> +       struct octep_vf_device *oct =3D netdev_priv(netdev);
> +       u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
> +       int q;
> +
> +       tx_packets =3D 0;
> +       tx_bytes =3D 0;
> +       rx_packets =3D 0;
> +       rx_bytes =3D 0;
> +       for (q =3D 0; q < oct->num_oqs; q++) {
> +               struct octep_vf_iq *iq =3D oct->iq[q];
> +               struct octep_vf_oq *oq =3D oct->oq[q];
> +
> +               tx_packets +=3D iq->stats.instr_completed;
> +               tx_bytes +=3D iq->stats.bytes_sent;
> +               rx_packets +=3D oq->stats.packets;
> +               rx_bytes +=3D oq->stats.bytes;
> +       }
> +       stats->tx_packets =3D tx_packets;
> +       stats->tx_bytes =3D tx_bytes;
> +       stats->rx_packets =3D rx_packets;
> +       stats->rx_bytes =3D rx_bytes;
> +       if (!octep_vf_get_if_stats(oct)) {
> +               stats->multicast =3D oct->iface_rx_stats.mcast_pkts;
> +               stats->rx_errors =3D oct->iface_rx_stats.err_pkts;
> +               stats->rx_dropped =3D
> oct->iface_rx_stats.dropped_pkts_fifo_full +
> +                                   oct->iface_rx_stats.err_pkts;
> +               stats->rx_missed_errors =3D
> oct->iface_rx_stats.dropped_pkts_fifo_full;
> +               stats->tx_dropped =3D oct->iface_tx_stats.dropped;
> +       }
> +}
> +
>  /**
>   * octep_vf_tx_timeout_task - work queue task to Handle Tx queue timeout=
.
>   *
> @@ -313,6 +370,7 @@ static const struct net_device_ops octep_vf_netdev_op=
s
> =3D {
>         .ndo_open                =3D octep_vf_open,
>         .ndo_stop                =3D octep_vf_stop,
>         .ndo_start_xmit          =3D octep_vf_start_xmit,
> +       .ndo_get_stats64         =3D octep_vf_get_stats64,
>         .ndo_tx_timeout          =3D octep_vf_tx_timeout,
>         .ndo_set_mac_address     =3D octep_vf_set_mac,
>         .ndo_change_mtu          =3D octep_vf_change_mtu,
> --
> 2.25.1
>
>
>

--=20
Regards,
Kalesh A P

--000000000000d7a04f0610c6385f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 7, 2024 at 12:23=E2=80=AF=
PM Shinas Rasheed &lt;<a href=3D"mailto:srasheed@marvell.com">srasheed@marv=
ell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Add support for ndo ops to set MAC address, change MTU, get stats.<b=
r>
Add control path support to set MAC address, change MTU, get stats,<br>
set speed, get and set link mode.<br></blockquote><div>[Kalesh]: You are ad=
ding support for only one ndo hook &quot;.ndo_get_stats64&quot; in this pat=
ch. Am I missing something?</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Signed-off-by: Shinas Rasheed &lt;<a href=3D"mailto:srasheed@marvell.com" t=
arget=3D"_blank">srasheed@marvell.com</a>&gt;<br>
---<br>
V6:<br>
=C2=A0 - No changes<br>
<br>
V5: <a href=3D"https://lore.kernel.org/all/20240129050254.3047778-6-srashee=
d@marvell.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/all/20240129050254.3047778-6-srasheed@marvell.com/</a><br>
=C2=A0 - No changes<br>
<br>
V4: <a href=3D"https://lore.kernel.org/all/20240108124213.2966536-6-srashee=
d@marvell.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/all/20240108124213.2966536-6-srasheed@marvell.com/</a><br>
=C2=A0 - Provide more stats in ndo_get_stats64 such as tx_dropped, rx_dropp=
ed<br>
=C2=A0 =C2=A0 etc.<br>
<br>
V3: <a href=3D"https://lore.kernel.org/all/20240105203823.2953604-6-srashee=
d@marvell.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/all/20240105203823.2953604-6-srasheed@marvell.com/</a><br>
=C2=A0 - No changes<br>
<br>
V2: <a href=3D"https://lore.kernel.org/all/20231223134000.2906144-6-srashee=
d@marvell.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/all/20231223134000.2906144-6-srasheed@marvell.com/</a><br>
=C2=A0 - No changes<br>
<br>
V1: <a href=3D"https://lore.kernel.org/all/20231221092844.2885872-6-srashee=
d@marvell.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/all/20231221092844.2885872-6-srasheed@marvell.com/</a><br>
<br>
=C2=A0.../marvell/octeon_ep_vf/octep_vf_main.c=C2=A0 =C2=A0 =C2=A0 | 58 +++=
++++++++++++++++<br>
=C2=A01 file changed, 58 insertions(+)<br>
<br>
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/dr=
ivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c<br>
index 562beed9af6a..ff879b1e846e 100644<br>
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c<br>
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c<br>
@@ -186,6 +186,23 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buff =
*skb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NETDEV_TX_OK;<br>
=C2=A0}<br>
<br>
+int octep_vf_get_if_stats(struct octep_vf_device *oct)<br></blockquote><di=
v>[Kalesh]: You may want to make this function static.=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct octep_vf_iface_rxtx_stats vf_stats;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;vf_stats, 0, sizeof(struct octep_vf=
_iface_rxtx_stats));<br></blockquote><div>[Kalesh]: You can avoid memset by=
 initializing vf_stats =3D {};=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D octep_vf_mbox_bulk_read(oct, OCTEP_PFVF=
_MBOX_CMD_GET_STATS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(u8 *)&amp;vf_st=
ats, &amp;size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<br></blockquote><div>[Kalesh] For b=
etter alignment:</div><div>if (ret)</div><div>=C2=A0 =C2=A0 =C2=A0return re=
t;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;oct-&gt=
;iface_rx_stats, &amp;vf_stats.iface_rx_stats,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(struct octep_vf_iface_rx_stats));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;oct-&gt=
;iface_tx_stats, &amp;vf_stats.iface_tx_stats,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(struct octep_vf_iface_tx_stats));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
=C2=A0int octep_vf_get_link_info(struct octep_vf_device *oct)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret, size;<br>
@@ -199,6 +216,46 @@ int octep_vf_get_link_info(struct octep_vf_device *oct=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+/**<br>
+ * octep_vf_get_stats64() - Get Octeon network device statistics.<br>
+ *<br>
+ * @netdev: kernel network device.<br>
+ * @stats: pointer to stats structure to be filled in.<br>
+ */<br>
+static void octep_vf_get_stats64(struct net_device *netdev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rtnl_link_stats64 *stats)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct octep_vf_device *oct =3D netdev_priv(net=
dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 tx_packets, tx_bytes, rx_packets, rx_bytes;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int q;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tx_packets =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tx_bytes =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rx_packets =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rx_bytes =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (q =3D 0; q &lt; oct-&gt;num_oqs; q++) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct octep_vf_iq =
*iq =3D oct-&gt;iq[q];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct octep_vf_oq =
*oq =3D oct-&gt;oq[q];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tx_packets +=3D iq-=
&gt;stats.instr_completed;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tx_bytes +=3D iq-&g=
t;stats.bytes_sent;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_packets +=3D oq-=
&gt;stats.packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_bytes +=3D oq-&g=
t;stats.bytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;tx_packets =3D tx_packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;tx_bytes =3D tx_bytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;rx_packets =3D rx_packets;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;rx_bytes =3D rx_bytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!octep_vf_get_if_stats(oct)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;multicast=
 =3D oct-&gt;iface_rx_stats.mcast_pkts;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;rx_errors=
 =3D oct-&gt;iface_rx_stats.err_pkts;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;rx_droppe=
d =3D oct-&gt;iface_rx_stats.dropped_pkts_fifo_full +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oct-&gt;iface_rx_stats.=
err_pkts;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;rx_missed=
_errors =3D oct-&gt;iface_rx_stats.dropped_pkts_fifo_full;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;tx_droppe=
d =3D oct-&gt;iface_tx_stats.dropped;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * octep_vf_tx_timeout_task - work queue task to Handle Tx queue time=
out.<br>
=C2=A0 *<br>
@@ -313,6 +370,7 @@ static const struct net_device_ops octep_vf_netdev_ops =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ndo_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D octep_vf_open,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ndo_stop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D octep_vf_stop,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ndo_start_xmit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D octep_vf_start_xmit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_get_stats64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D octep_vf_get_stats64,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ndo_tx_timeout=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D octep_vf_tx_timeout,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ndo_set_mac_address=C2=A0 =C2=A0 =C2=A0=3D oct=
ep_vf_set_mac,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ndo_change_mtu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D octep_vf_change_mtu,<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000d7a04f0610c6385f--

--000000000000ddbf4e0610c638d7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIPjPk7Ut5IG+4qOwrN2HSsCc81Xqh0f3rrX8eR1jHhB0MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIwNzA4MTAwM1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC9s2ESSqh8
ZpgwfrYfZx9QDnMocqB2I9KekkIkj2/p0A/6xJxTFZSJr9pLTTv+YjCs9foNZe7bKsQByI+y9+mI
Z2gu6xo/C0rZq31eVSbwdGcwPKJH9+9G4YgAbkCR0yWSOVZKWZ/30RpNRd48Gg6u0vsqBgby7Z+Q
KCcHbygP29naBg1ecx+XXC/Tu+fHumbACbL0XMmTDTRIELYWurxlmXGGPUedTTZWcCc+VT1xxJ5a
gy1BvX882qW9JkWZ7rTdIqN+dYg473SwsGYRfEEEwOj8afYebonl3JCC2kPN7YmLg/CoIOHqEEv1
KuprIoxp9h3g6bK7BAXy11/vm5KB
--000000000000ddbf4e0610c638d7--

