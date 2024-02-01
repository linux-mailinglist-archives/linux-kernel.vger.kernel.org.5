Return-Path: <linux-kernel+bounces-47586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FD8844FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAC1C250E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4A3B193;
	Thu,  1 Feb 2024 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAnEE9Y3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487E3A8C2;
	Thu,  1 Feb 2024 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758483; cv=none; b=CEzSWnqvTYN/8lPSFZkc+fSP5brcgL35CjMigFVeszybocDaR0gYdbH0CVGM6l+z/QvcYcNeE10NKOtX0wAlwcD8AlPnNXHhv3phCBHJVDVcTocHQxJNH8QV7wn04OtrD1esYQZUvLAsZl3PdSbe1QXIwvU37plKG1U6swqnMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758483; c=relaxed/simple;
	bh=5bw602p0lyKNsaN5w1K0DJbX/ZbIajEOmzFxzdm8rrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olQ1yM2CjLocYQDIYVcnJBccSknD8GMxUod1wPLBggb+QluK6ZrNiBJ/ur8oftOXeY6uRUb/5vJHI92MOaC5qH+rYdHBcYddP79lcYqqHG+ZQGaCpw8xtpXJq2VbilOvNrgzIohYH/34rMKpZg+sumZ0SXKFUmg4zBQjqNyq7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAnEE9Y3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55ef4a66008so422985a12.3;
        Wed, 31 Jan 2024 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758480; x=1707363280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj3hcJMzBxsadZ68tugN6RNorm8HYmDm8vjqNA4qLGo=;
        b=JAnEE9Y3MBDwukCxTihwxC0morkq+FwbK1tBDGV88/bho/5Ge8ZKWp/cqkkNpInzT+
         +7kSoLwNn7PAuNqYIp13+d8Kk9T1ctyrV/L5pOx2PFomMfkbfky26Pq6VHY/byxGDF6C
         Z/LI0WKn0dAsHDCe6lPlcpO727mdT00rmF/z/m1jlbQHpnUxdXAYrpE5clmTpy3QbQ/K
         TQsbMy/mDe+53Zbt6f/1EcUd0IcBKQ6wwacrThHTtnPhsec0gxTdtLfU0zAFq23cF7+t
         G1krEapBm4JsIZWSAtfr5RLP06XUfoVIsTIALvjtvf/1c0+2wp25d6rDa3C5JSob+GYN
         Ij1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758480; x=1707363280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj3hcJMzBxsadZ68tugN6RNorm8HYmDm8vjqNA4qLGo=;
        b=wjrP4Y5t9kHuhSaAEpjI/MFZW2G2TbvSWSdfQDiiaGPEjMsQOBWcRpI/AqZuxnGRmL
         45u8Z9GOEBxpkruJMsZaIhBaQmeGUylIQaUY34/+ZV1DiiVGH9GlUyfvOI7iH+uj2ODd
         WRXGJUr9PDvBLJLxxIZyiZv81W5Gh/Gz6B1LKLq5une8qpUSzVgEGPU0uLzoIGkOlRjX
         nc4kpjR+fKhPb7+FvIGVQ8PcofrU44XJnpN0Vb9ydj6pC7OI0h0t4ZN8sgkf6BlAvbdm
         qumMW6EEEvjOtqBhYbXAPZgctzZIchF15ZXYkQSgFb39BupVnKQcwyQvet+N33NXQiqZ
         aOiQ==
X-Gm-Message-State: AOJu0YxKq3y05n8iJLceE6k4kIK5Aow3D5saLnb0+lw8SQnWxZZXjf2g
	fb6FBInrjlhjMkCXeLPvokKmBZLbOAZtM8UMcitUBFbQmzt1e95xVkslftZ4CaJcQnznu1Z/RA9
	PvzTryOONnMAo7b7+FeelOxCzTI0=
X-Google-Smtp-Source: AGHT+IFcG+avvArp/EWf/JYpYXGBGOJnK39PQ4HIPWUPZpg2Jyk9snpNDms1CGUm/1/Ev56pYfTAg+RiOaOPdm2ZuaQ=
X-Received: by 2002:aa7:d391:0:b0:55f:217d:9651 with SMTP id
 x17-20020aa7d391000000b0055f217d9651mr2776816edq.22.1706758479335; Wed, 31
 Jan 2024 19:34:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201033310.1028154-1-hayatake396@gmail.com> <20240201033310.1028154-2-hayatake396@gmail.com>
In-Reply-To: <20240201033310.1028154-2-hayatake396@gmail.com>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Thu, 1 Feb 2024 12:34:27 +0900
Message-ID: <CADFiAcLyFcYSczjbx5dnVh3sYLeniadpRHYjyMWiQZJUuhCgPw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] ice: Implement RSS settings for GTP using ethtool
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, vladimir.oltean@nxp.com, laforge@gnumonks.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi reviews.
I made a mistake in sending the patch without increasing the version,
so I will send it again as v7.

Thanks
Takeru

2024=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=A8) 12:33 Takeru Hayasaka <hayatak=
e396@gmail.com>:
>
> Following the addition of new GTP RSS hash options to ethtool.h, this pat=
ch
> implements the corresponding RSS settings for GTP packets in the Intel ic=
e
> driver. It enables users to configure RSS for GTP-U and GTP-C traffic ove=
r IPv4
> and IPv6, utilizing the newly defined hash options.
>
> The implementation covers the handling of gtpu(4|6), gtpc(4|6), gtpc(4|6)=
t,
> gtpu(4|6)e, gtpu(4|6)u, and gtpu(4|6)d traffic, providing enhanced load
> distribution for GTP traffic across multiple processing units.
>
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
>  .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
>  4 files changed, 162 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.r=
st b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> index 5038e54586af..934752f675ba 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> @@ -368,15 +368,28 @@ more options for Receive Side Scaling (RSS) hash by=
te configuration.
>    # ethtool -N <ethX> rx-flow-hash <type> <option>
>
>    Where <type> is:
> -    tcp4  signifying TCP over IPv4
> -    udp4  signifying UDP over IPv4
> -    tcp6  signifying TCP over IPv6
> -    udp6  signifying UDP over IPv6
> +    tcp4    signifying TCP over IPv4
> +    udp4    signifying UDP over IPv4
> +    gtpc4   signifying GTP-C over IPv4
> +    gtpc4t  signifying GTP-C (include TEID) over IPv4
> +    gtpu4   signifying GTP-U over IPV4
> +    gtpu4e  signifying GTP-U and Extension Header over IPV4
> +    gtpu4u  signifying GTP-U PSC Uplink over IPV4
> +    gtpu4d  signifying GTP-U PSC Downlink over IPV4
> +    tcp6    signifying TCP over IPv6
> +    udp6    signifying UDP over IPv6
> +    gtpc6   signifying GTP-C over IPv6
> +    gtpc6t  signifying GTP-C (include TEID) over IPv6
> +    gtpu6   signifying GTP-U over IPV6
> +    gtpu6e  signifying GTP-U and Extension Header over IPV6
> +    gtpu6u  signifying GTP-U PSC Uplink over IPV6
> +    gtpu6d  signifying GTP-U PSC Downlink over IPV6
>    And <option> is one or more of:
>      s     Hash on the IP source address of the Rx packet.
>      d     Hash on the IP destination address of the Rx packet.
>      f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet.
>      n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet.
> +    e     Hash on GTP Packet on TEID (4bytes) of the Rx packet.
>
>
>  Accelerated Receive Flow Steering (aRFS)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/e=
thernet/intel/ice/ice_ethtool.c
> index a19b06f18e40..d0e05032f464 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2486,6 +2486,24 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nf=
c)
>         case SCTP_V4_FLOW:
>                 hdrs |=3D ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4;
>                 break;
> +       case GTPU_V4_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV=
4;
> +               break;
> +       case GTPC_V4_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4;
> +               break;
> +       case GTPC_TEID_V4_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_I=
PV4;
> +               break;
> +       case GTPU_EH_V4_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV=
4;
> +               break;
> +       case GTPU_UL_V4_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV=
4;
> +               break;
> +       case GTPU_DL_V4_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IP=
V4;
> +               break;
>         case TCP_V6_FLOW:
>                 hdrs |=3D ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6;
>                 break;
> @@ -2495,6 +2513,24 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nf=
c)
>         case SCTP_V6_FLOW:
>                 hdrs |=3D ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV6;
>                 break;
> +       case GTPU_V6_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV=
6;
> +               break;
> +       case GTPC_V6_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6;
> +               break;
> +       case GTPC_TEID_V6_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_I=
PV6;
> +               break;
> +       case GTPU_EH_V6_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV=
6;
> +               break;
> +       case GTPU_UL_V6_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV=
6;
> +               break;
> +       case GTPU_DL_V6_FLOW:
> +               hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IP=
V6;
> +               break;
>         default:
>                 break;
>         }
> @@ -2518,6 +2554,12 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnf=
c *nfc, bool symm)
>                 case TCP_V4_FLOW:
>                 case UDP_V4_FLOW:
>                 case SCTP_V4_FLOW:
> +               case GTPU_V4_FLOW:
> +               case GTPC_V4_FLOW:
> +               case GTPC_TEID_V4_FLOW:
> +               case GTPU_EH_V4_FLOW:
> +               case GTPU_UL_V4_FLOW:
> +               case GTPU_DL_V4_FLOW:
>                         if (nfc->data & RXH_IP_SRC)
>                                 hfld |=3D ICE_FLOW_HASH_FLD_IPV4_SA;
>                         if (nfc->data & RXH_IP_DST)
> @@ -2526,6 +2568,12 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnf=
c *nfc, bool symm)
>                 case TCP_V6_FLOW:
>                 case UDP_V6_FLOW:
>                 case SCTP_V6_FLOW:
> +               case GTPU_V6_FLOW:
> +               case GTPC_V6_FLOW:
> +               case GTPC_TEID_V6_FLOW:
> +               case GTPU_EH_V6_FLOW:
> +               case GTPU_UL_V6_FLOW:
> +               case GTPU_DL_V6_FLOW:
>                         if (nfc->data & RXH_IP_SRC)
>                                 hfld |=3D ICE_FLOW_HASH_FLD_IPV6_SA;
>                         if (nfc->data & RXH_IP_DST)
> @@ -2564,6 +2612,33 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnf=
c *nfc, bool symm)
>                 }
>         }
>
> +       if (nfc->data & RXH_GTP_TEID) {
> +               switch (nfc->flow_type) {
> +               case GTPC_TEID_V4_FLOW:
> +               case GTPC_TEID_V6_FLOW:
> +                       hfld |=3D ICE_FLOW_HASH_FLD_GTPC_TEID;
> +                       break;
> +               case GTPU_V4_FLOW:
> +               case GTPU_V6_FLOW:
> +                       hfld |=3D ICE_FLOW_HASH_FLD_GTPU_IP_TEID;
> +                       break;
> +               case GTPU_EH_V4_FLOW:
> +               case GTPU_EH_V6_FLOW:
> +                       hfld |=3D ICE_FLOW_HASH_FLD_GTPU_EH_TEID;
> +                       break;
> +               case GTPU_UL_V4_FLOW:
> +               case GTPU_UL_V6_FLOW:
> +                       hfld |=3D ICE_FLOW_HASH_FLD_GTPU_UP_TEID;
> +                       break;
> +               case GTPU_DL_V4_FLOW:
> +               case GTPU_DL_V6_FLOW:
> +                       hfld |=3D ICE_FLOW_HASH_FLD_GTPU_DWN_TEID;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
>         return hfld;
>  }
>
> @@ -2676,6 +2751,13 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct e=
thtool_rxnfc *nfc)
>             hash_flds & ICE_FLOW_HASH_FLD_UDP_DST_PORT ||
>             hash_flds & ICE_FLOW_HASH_FLD_SCTP_DST_PORT)
>                 nfc->data |=3D (u64)RXH_L4_B_2_3;
> +
> +       if (hash_flds & ICE_FLOW_HASH_FLD_GTPC_TEID ||
> +           hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
> +           hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
> +           hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
> +           hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
> +               nfc->data |=3D (u64)RXH_GTP_TEID;
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethe=
rnet/intel/ice/ice_flow.h
> index ff82915ab497..2fd2e0cb483d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.h
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.h
> @@ -37,13 +37,13 @@
>  #define ICE_HASH_SCTP_IPV4     (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_SCTP_=
PORT)
>  #define ICE_HASH_SCTP_IPV6     (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_SCTP_=
PORT)
>
> -#define ICE_FLOW_HASH_GTP_TEID \
> +#define ICE_FLOW_HASH_GTP_C_TEID \
>         (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID))
>
> -#define ICE_FLOW_HASH_GTP_IPV4_TEID \
> -       (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_TEID)
> -#define ICE_FLOW_HASH_GTP_IPV6_TEID \
> -       (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_TEID)
> +#define ICE_FLOW_HASH_GTP_C_IPV4_TEID \
> +       (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_C_TEID)
> +#define ICE_FLOW_HASH_GTP_C_IPV6_TEID \
> +       (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_C_TEID)
>
>  #define ICE_FLOW_HASH_GTP_U_TEID \
>         (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_IP_TEID))
> @@ -66,6 +66,20 @@
>         (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_EH_TEID | \
>          ICE_FLOW_HASH_GTP_U_EH_QFI)
>
> +#define ICE_FLOW_HASH_GTP_U_UP \
> +       (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID))
> +#define ICE_FLOW_HASH_GTP_U_DWN \
> +       (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID))
> +
> +#define ICE_FLOW_HASH_GTP_U_IPV4_UP \
> +       (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_UP)
> +#define ICE_FLOW_HASH_GTP_U_IPV6_UP \
> +       (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_UP)
> +#define ICE_FLOW_HASH_GTP_U_IPV4_DWN \
> +       (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_DWN)
> +#define ICE_FLOW_HASH_GTP_U_IPV6_DWN \
> +       (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_DWN)
> +
>  #define ICE_FLOW_HASH_PPPOE_SESS_ID \
>         (BIT_ULL(ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID))
>
> @@ -242,6 +256,13 @@ enum ice_flow_field {
>  #define ICE_FLOW_HASH_FLD_SCTP_DST_PORT        \
>         BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)
>
> +#define ICE_FLOW_HASH_FLD_GTPC_TEID    BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_T=
EID)
> +#define ICE_FLOW_HASH_FLD_GTPU_IP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_I=
P_TEID)
> +#define ICE_FLOW_HASH_FLD_GTPU_EH_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_E=
H_TEID)
> +#define ICE_FLOW_HASH_FLD_GTPU_UP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_U=
P_TEID)
> +#define ICE_FLOW_HASH_FLD_GTPU_DWN_TEID \
> +       BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID)
> +
>  /* Flow headers and fields for AVF support */
>  enum ice_flow_avf_hdr_field {
>         /* Values 0 - 28 are reserved for future use */
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ether=
net/intel/ice/ice_lib.c
> index 9be724291ef8..3c4282019570 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1618,6 +1618,25 @@ static const struct ice_rss_hash_cfg default_rss_c=
fgs[] =3D {
>          */
>         {ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4,
>                 ICE_HASH_SCTP_IPV4, ICE_RSS_OUTER_HEADERS, false},
> +       /* configure RSS for gtpc4 with input set IPv4 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4,
> +               ICE_FLOW_HASH_IPV4, ICE_RSS_OUTER_HEADERS, false},
> +       /* configure RSS for gtpc4t with input set IPv4 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4,
> +               ICE_FLOW_HASH_GTP_C_IPV4_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> +       /* configure RSS for gtpu4 with input set IPv4 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4,
> +               ICE_FLOW_HASH_GTP_U_IPV4_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> +       /* configure RSS for gtpu4e with input set IPv4 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV4,
> +               ICE_FLOW_HASH_GTP_U_IPV4_EH, ICE_RSS_OUTER_HEADERS, false=
},
> +       /* configure RSS for gtpu4u with input set IPv4 src/dst */
> +       { ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV4,
> +               ICE_FLOW_HASH_GTP_U_IPV4_UP, ICE_RSS_OUTER_HEADERS, false=
},
> +       /* configure RSS for gtpu4d with input set IPv4 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV4,
> +               ICE_FLOW_HASH_GTP_U_IPV4_DWN, ICE_RSS_OUTER_HEADERS, fals=
e},
> +
>         /* configure RSS for tcp6 with input set IPv6 src/dst, TCP src/ds=
t */
>         {ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6,
>                                 ICE_HASH_TCP_IPV6,  ICE_RSS_ANY_HEADERS, =
false},
> @@ -1632,6 +1651,24 @@ static const struct ice_rss_hash_cfg default_rss_c=
fgs[] =3D {
>         /* configure RSS for IPSEC ESP SPI with input set MAC_IPV4_SPI */
>         {ICE_FLOW_SEG_HDR_ESP,
>                 ICE_FLOW_HASH_ESP_SPI, ICE_RSS_OUTER_HEADERS, false},
> +       /* configure RSS for gtpc6 with input set IPv6 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6,
> +               ICE_FLOW_HASH_IPV6, ICE_RSS_OUTER_HEADERS, false},
> +       /* configure RSS for gtpc6t with input set IPv6 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6,
> +               ICE_FLOW_HASH_GTP_C_IPV6_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> +       /* configure RSS for gtpu6 with input set IPv6 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6,
> +               ICE_FLOW_HASH_GTP_U_IPV6_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> +       /* configure RSS for gtpu6e with input set IPv6 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV6,
> +               ICE_FLOW_HASH_GTP_U_IPV6_EH, ICE_RSS_OUTER_HEADERS, false=
},
> +       /* configure RSS for gtpu6u with input set IPv6 src/dst */
> +       { ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV6,
> +               ICE_FLOW_HASH_GTP_U_IPV6_UP, ICE_RSS_OUTER_HEADERS, false=
},
> +       /* configure RSS for gtpu6d with input set IPv6 src/dst */
> +       {ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV6,
> +               ICE_FLOW_HASH_GTP_U_IPV6_DWN, ICE_RSS_OUTER_HEADERS, fals=
e},
>  };
>
>  /**
> --
> 2.34.1
>

