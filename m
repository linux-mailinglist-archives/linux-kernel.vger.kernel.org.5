Return-Path: <linux-kernel+bounces-45571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5A4843289
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD9528511F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87299CA6B;
	Wed, 31 Jan 2024 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALtDwv9i"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12EE7EB;
	Wed, 31 Jan 2024 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663240; cv=none; b=pfvTNxppBKOykeM3ceTtSA+EpffTZkoTk5gpeqX1YLjtwmLOQoAisutE4TRq5odkX1uE2EsfhqDQJ8jnE8zDrCYBqjV4wB0f2Y2LzqumbtmTI/KvHSw1pHWm2Rtd5lB1YP1h8L91VtdPRKW+gYaNLJRKEpNYfoUOS1vdgySxy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663240; c=relaxed/simple;
	bh=WDJzHfrJ6rcqDxXx/n6KBaHcbkMbtJBFdvyNLkNFQIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYfw8Ku6bsWN0oTp1MwNhp7U+AGO+p6ADT7el8ZARIMfwRDdOP4+FXO/egWvmvx/4TINuXBc/jYBBxDzzODq33M+VBAFabHSlqBq6Y0YsxrrrWklaxOhLxmULuGWyRFTORCPYFwd+dbBBO4z1xQBHv6CfgHDLXu0TQWhY0XST8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALtDwv9i; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604058c081eso4843767b3.3;
        Tue, 30 Jan 2024 17:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706663237; x=1707268037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz2fWLh6zVAbCqdzH0ABsW/ogaOhBDVfOcexAdGVIQ4=;
        b=ALtDwv9ixzXm77mrZm8iBlkpbvhbLvXXJ1Zgq+JMa3Y0LJdtXqRsgkzwxt/x5jKYZ7
         YSyVu7s4auooPWfqXGHBRdzXvURU6v7cIxNN30AYqqAvCHJiJRF3bvhXlp894RERzgSt
         b+T06x+rst8hkTkf9GnyMlImY8OxkA6Z/DVPttt+5BMb98fvEPbNGP7Wp3Hn3VmpHid9
         zb8VZUJl8Yl2MaME6JOqMu6AeZtNh4QnuR1/v6zNEA2vR76CGHg4I1LgZZEgugL6RJJU
         fpTIhr07y9ZiuQ55iqTK8bEiDXsM/mscpYd43eTQ0FLx2fg+zCEXX8nGDwQVdxooNAVa
         uhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663237; x=1707268037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz2fWLh6zVAbCqdzH0ABsW/ogaOhBDVfOcexAdGVIQ4=;
        b=pw9stn6Wi8Q8v+QFhKYC8gFiFrsyMUKbgTMWMQ5TVcqeOvtDraGKw8zwxCOQTc+LX0
         0in8kpDms9uWvJc0sol9XymcjnnJz6kA0g5Jjslsyv946/lj24y3MEZFKJxRgilt7B1y
         MDx5BGQdVu6WGvUJEhRgShwNdueJZZyvCfjK/HrEAkx0Meimb2OcaDVZzoyYE00N67MZ
         93doF/1Y1S6fXeFEpH/oGKHtoj8fbY4n2Sr9tMV4Jhkd7SEQcQeqYJz04767t7GLm7Ez
         7Q3k/dbAA/F38hkf/NZz6JT9Rx8b2vgi0mrE38AZYh/NN/XvhTIr4wwlKrLHabUtKUoW
         QdGA==
X-Gm-Message-State: AOJu0YwSDFHnSoL5rP81MCtkY7Q4z8Nx2gJN1+peGTHk6/yulezlGeNB
	93rOz2iOsAG2tIOkaeHNBbeWKmO96rNoMyFP2XP32BL1qZOicPVjvtHRb78bTbqNPR+BpSzoxCT
	90wtIMJgDI8LJpW3lRqmfrhzJH5M=
X-Google-Smtp-Source: AGHT+IGUZhB5C5g0+Bo7TNjmdb3eAibiE2/MgtsMVbjmBmrOtaFSMR4lEls4pu1UVvBOcQFhsA3UJ61QtphTESozjC4=
X-Received: by 2002:a25:7c05:0:b0:dc6:aebb:168e with SMTP id
 x5-20020a257c05000000b00dc6aebb168emr306638ybc.26.1706663236605; Tue, 30 Jan
 2024 17:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095307.951049-1-hayatake396@gmail.com> <c94f5f8d-7d88-4b60-b92f-e7f6697c08fa@linux.intel.com>
In-Reply-To: <c94f5f8d-7d88-4b60-b92f-e7f6697c08fa@linux.intel.com>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Wed, 31 Jan 2024 10:07:05 +0900
Message-ID: <CADFiAc+YU5sgyZGYkUTMsXcycT0JWsk8DVDyug0TPt+VQbtwjQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4] ethtool: ice: Support for
 RSS settings to GTP
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, vladimir.oltean@nxp.com, 
	linux-kernel@vger.kernel.org, laforge@gnumonks.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcin-san

Thank you for your review :)

> Remove "her" (sorry for missing it last time).

Understood :) I will correct it in the next patch.

> This doesn't seem to be used anywhere.

The parameter definition was something I included where I was
enumerating. Indeed, it's not being used anywhere, so I will remove
it.

> All headers have two blank lines before them, so don't remove this newlin=
e.

Got it.

> Two braces above: looks like ICE_FLOW_HASH_GTP_U_IPV4_TEID and > ICE_FLOW=
_HASH_GTP_IPV4_TEID should be swapped? > Ditto, ICE_FLOW_HASH_GTP_U_IPV6_TE=
ID and ICE_FLOW_HASH_GTP_IPV6_TEID seem > to be incorrectly placed.

That's a good point!Thank you.
This was a mistake on my part.
It should be:
ICE_FLOW_HASH_GTP_U_IPV(4|6)_TEID -> ICE_FLOW_HASH_GTP_C_IPV(4|6)_TEID
(At the same time, I will change ICE_FLOW_HASH_GTP_TEID to
ICE_FLOW_HASH_GTP_C_TEID, which is clearer.)
ICE_FLOW_HASH_GTP_IPV(4|6)_TEID -> ICE_FLOW_HASH_GTP_U_IPV(4|6)_TEID

> Again, missing space before (

Sorry, I forgot to fix that. I will make sure it's corrected in the next on=
e.

Thanks,
Takeru
2024=E5=B9=B41=E6=9C=8830=E6=97=A5(=E7=81=AB) 23:41 Marcin Szycik <marcin.s=
zycik@linux.intel.com>:

>
>
>
> On 30.01.2024 10:53, Takeru Hayasaka wrote:
> > This is a patch that enables RSS functionality for GTP packets using et=
htool.
> >
> > A user can include her TEID and make RSS work for GTP-U over IPv4 by do=
ing the
>
> Remove "her" (sorry for missing it last time).
>
> > following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
> >
> > In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)=
e,
> > gtpu(4|6)u, and gtpu(4|6)d.
> >
> > gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format=
 does
> > not include a TEID.
> > gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format t=
hat
> > includes a TEID.
> > gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> > gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> > gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U exte=
nded
> > header includes Uplink, applicable to both IPv4 and IPv6.
> > gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Dow=
nlink,
> > for both IPv4 and IPv6.
>
> I'd still add a short note here that all gtpu have TEID.
>
> > GTP generates a flow that includes an ID called TEID to identify the tu=
nnel.
> > This tunnel is created for each UE (User Equipment).By performing RSS b=
ased on
> > this flow, it is possible to apply RSS for each communication unit from=
 the UE.
> > Without this, RSS would only be effective within the range of IP addres=
ses. For
> > instance, the PGW can only perform RSS within the IP range of the SGW.
> > Problematic from a load distribution perspective, especially if there's=
 a bias
> > in the terminals connected to a particular base station.This case can b=
e
> > solved by using this patch.
> >
> > Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> > ---
> >
> > v2->v3: Based on Harald-san's review, I added documentation and comment=
s to
> > ethtool.h and ice.rst.
> > v3->v4: Based on Marcin-san's review, I added the missing code for GTPC=
 and
> > GTPC_TEID, and revised the documentation and comments.
> >
> >
> >  .../device_drivers/ethernet/intel/ice.rst     | 23 ++++--
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_flow.h     | 22 +++++
> >  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
> >  include/uapi/linux/ethtool.h                  | 48 +++++++++++
> >  5 files changed, 207 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice=
rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> > index 5038e54586af..6f48688940c4 100644
> > --- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> > +++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> > @@ -368,16 +368,29 @@ more options for Receive Side Scaling (RSS) hash =
byte configuration.
> >    # ethtool -N <ethX> rx-flow-hash <type> <option>
> >
> >    Where <type> is:
> > -    tcp4  signifying TCP over IPv4
> > -    udp4  signifying UDP over IPv4
> > -    tcp6  signifying TCP over IPv6
> > -    udp6  signifying UDP over IPv6
> > +    tcp4    signifying TCP over IPv4
> > +    udp4    signifying UDP over IPv4
> > +    gtpc4   signifying GTP-C over IPv4
> > +    gtpc4t  signifying GTP-C (include TEID) over IPv4
> > +    gtpu4   signifying GTP-U over IPV4
> > +    gtpu4e  signifying GTP-U and Extension Header over IPV4
> > +    gtpu4u  signifying GTP-U PSC Uplink over IPV4
> > +    gtpu4d  signifying GTP-U PSC Downlink over IPV4
> > +    tcp6    signifying TCP over IPv6
> > +    udp6    signifying UDP over IPv6
> > +    gtpc6   signifying GTP-C over IPv6
> > +    gtpc6t  signifying GTP-C (include TEID) over IPv6
> > +    gtpu6   signifying GTP-U over IPV6
> > +    gtpu6e  signifying GTP-U and Extension Header over IPV6
> > +    gtpu6u  signifying GTP-U PSC Uplink over IPV6
> > +    gtpu6d  signifying GTP-U PSC Downlink over IPV6
> > +
> >    And <option> is one or more of:
> >      s     Hash on the IP source address of the Rx packet.
> >      d     Hash on the IP destination address of the Rx packet.
> >      f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet=
.
> >      n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet=
.
> > -
>
> All headers have two blank lines before them, so don't remove this newlin=
e.
>
> > +    e     Hash on GTP Packet on TEID (4bytes) of the Rx packet.
> >
> >  Accelerated Receive Flow Steering (aRFS)
> >  ----------------------------------------
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net=
/ethernet/intel/ice/ice_ethtool.c
> > index a19b06f18e40..d0e05032f464 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -2486,6 +2486,24 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *=
nfc)
> >       case SCTP_V4_FLOW:
> >               hdrs |=3D ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4;
> >               break;
> > +     case GTPU_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV=
4;
> > +             break;
> > +     case GTPC_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4;
> > +             break;
> > +     case GTPC_TEID_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_I=
PV4;
> > +             break;
> > +     case GTPU_EH_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV=
4;
> > +             break;
> > +     case GTPU_UL_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV=
4;
> > +             break;
> > +     case GTPU_DL_V4_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IP=
V4;
> > +             break;
> >       case TCP_V6_FLOW:
> >               hdrs |=3D ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6;
> >               break;
> > @@ -2495,6 +2513,24 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *=
nfc)
> >       case SCTP_V6_FLOW:
> >               hdrs |=3D ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV6;
> >               break;
> > +     case GTPU_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV=
6;
> > +             break;
> > +     case GTPC_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6;
> > +             break;
> > +     case GTPC_TEID_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_I=
PV6;
> > +             break;
> > +     case GTPU_EH_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV=
6;
> > +             break;
> > +     case GTPU_UL_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV=
6;
> > +             break;
> > +     case GTPU_DL_V6_FLOW:
> > +             hdrs |=3D ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IP=
V6;
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -2518,6 +2554,12 @@ static u64 ice_parse_hash_flds(struct ethtool_rx=
nfc *nfc, bool symm)
> >               case TCP_V4_FLOW:
> >               case UDP_V4_FLOW:
> >               case SCTP_V4_FLOW:
> > +             case GTPU_V4_FLOW:
> > +             case GTPC_V4_FLOW:
> > +             case GTPC_TEID_V4_FLOW:
> > +             case GTPU_EH_V4_FLOW:
> > +             case GTPU_UL_V4_FLOW:
> > +             case GTPU_DL_V4_FLOW:
> >                       if (nfc->data & RXH_IP_SRC)
> >                               hfld |=3D ICE_FLOW_HASH_FLD_IPV4_SA;
> >                       if (nfc->data & RXH_IP_DST)
> > @@ -2526,6 +2568,12 @@ static u64 ice_parse_hash_flds(struct ethtool_rx=
nfc *nfc, bool symm)
> >               case TCP_V6_FLOW:
> >               case UDP_V6_FLOW:
> >               case SCTP_V6_FLOW:
> > +             case GTPU_V6_FLOW:
> > +             case GTPC_V6_FLOW:
> > +             case GTPC_TEID_V6_FLOW:
> > +             case GTPU_EH_V6_FLOW:
> > +             case GTPU_UL_V6_FLOW:
> > +             case GTPU_DL_V6_FLOW:
> >                       if (nfc->data & RXH_IP_SRC)
> >                               hfld |=3D ICE_FLOW_HASH_FLD_IPV6_SA;
> >                       if (nfc->data & RXH_IP_DST)
> > @@ -2564,6 +2612,33 @@ static u64 ice_parse_hash_flds(struct ethtool_rx=
nfc *nfc, bool symm)
> >               }
> >       }
> >
> > +     if (nfc->data & RXH_GTP_TEID) {
> > +             switch (nfc->flow_type) {
> > +             case GTPC_TEID_V4_FLOW:
> > +             case GTPC_TEID_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPC_TEID;
> > +                     break;
> > +             case GTPU_V4_FLOW:
> > +             case GTPU_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_IP_TEID;
> > +                     break;
> > +             case GTPU_EH_V4_FLOW:
> > +             case GTPU_EH_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_EH_TEID;
> > +                     break;
> > +             case GTPU_UL_V4_FLOW:
> > +             case GTPU_UL_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_UP_TEID;
> > +                     break;
> > +             case GTPU_DL_V4_FLOW:
> > +             case GTPU_DL_V6_FLOW:
> > +                     hfld |=3D ICE_FLOW_HASH_FLD_GTPU_DWN_TEID;
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> > +
> >       return hfld;
> >  }
> >
> > @@ -2676,6 +2751,13 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct=
 ethtool_rxnfc *nfc)
> >           hash_flds & ICE_FLOW_HASH_FLD_UDP_DST_PORT ||
> >           hash_flds & ICE_FLOW_HASH_FLD_SCTP_DST_PORT)
> >               nfc->data |=3D (u64)RXH_L4_B_2_3;
> > +
> > +     if (hash_flds & ICE_FLOW_HASH_FLD_GTPC_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
> > +         hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
> > +             nfc->data |=3D (u64)RXH_GTP_TEID;
> >  }
> >
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/et=
hernet/intel/ice/ice_flow.h
> > index ff82915ab497..9d6803d68a45 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_flow.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_flow.h
> > @@ -66,6 +66,20 @@
> >       (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_EH_TEID | \
> >        ICE_FLOW_HASH_GTP_U_EH_QFI)
> >
> > +#define ICE_FLOW_HASH_GTP_U_UP \
> > +     (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID))
> > +#define ICE_FLOW_HASH_GTP_U_DWN \
> > +     (BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID))
> > +
> > +#define ICE_FLOW_HASH_GTP_U_IPV4_UP \
> > +     (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_UP)
> > +#define ICE_FLOW_HASH_GTP_U_IPV6_UP \
> > +     (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_UP)
> > +#define ICE_FLOW_HASH_GTP_U_IPV4_DWN \
> > +     (ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_DWN)
> > +#define ICE_FLOW_HASH_GTP_U_IPV6_DWN \
> > +     (ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_DWN)
> > +
> >  #define ICE_FLOW_HASH_PPPOE_SESS_ID \
> >       (BIT_ULL(ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID))
> >
> > @@ -242,6 +256,14 @@ enum ice_flow_field {
> >  #define ICE_FLOW_HASH_FLD_SCTP_DST_PORT      \
> >       BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)
> >
> > +#define ICE_FLOW_HASH_FLD_GTPC_TEID  BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_T=
EID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_IP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU=
_IP_TEID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_EH_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU=
_EH_TEID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_EH_QFI BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_=
EH_QFI)
>
> This doesn't seem to be used anywhere.
>
> > +#define ICE_FLOW_HASH_FLD_GTPU_UP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU=
_UP_TEID)
> > +#define ICE_FLOW_HASH_FLD_GTPU_DWN_TEID \
> > +     BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID)
> > +
> >  /* Flow headers and fields for AVF support */
> >  enum ice_flow_avf_hdr_field {
> >       /* Values 0 - 28 are reserved for future use */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/eth=
ernet/intel/ice/ice_lib.c
> > index 9be724291ef8..72f737c6c9ba 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -1618,6 +1618,25 @@ static const struct ice_rss_hash_cfg default_rss=
_cfgs[] =3D {
> >        */
> >       {ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4,
> >               ICE_HASH_SCTP_IPV4, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc4 with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_IPV4, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc4t with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> > +     /* configure RSS for gtpu4 with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_IPV4_TEID, ICE_RSS_OUTER_HEADERS, false=
},
>
> Two braces above: looks like ICE_FLOW_HASH_GTP_U_IPV4_TEID and
> ICE_FLOW_HASH_GTP_IPV4_TEID should be swapped?
>
> > +     /* configure RSS for gtpu4e with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_EH, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu4u with input set IPv4 src/dst */
> > +     { ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_UP, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu4d with input set IPv4 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV4,
> > +             ICE_FLOW_HASH_GTP_U_IPV4_DWN, ICE_RSS_OUTER_HEADERS, fals=
e},
> > +
> >       /* configure RSS for tcp6 with input set IPv6 src/dst, TCP src/ds=
t */
> >       {ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6,
> >                               ICE_HASH_TCP_IPV6,  ICE_RSS_ANY_HEADERS, =
false},
> > @@ -1632,6 +1651,24 @@ static const struct ice_rss_hash_cfg default_rss=
_cfgs[] =3D {
> >       /* configure RSS for IPSEC ESP SPI with input set MAC_IPV4_SPI */
> >       {ICE_FLOW_SEG_HDR_ESP,
> >               ICE_FLOW_HASH_ESP_SPI, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc6 with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_IPV6, ICE_RSS_OUTER_HEADERS, false},
> > +     /* configure RSS for gtpc6t with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_TEID, ICE_RSS_OUTER_HEADERS, fal=
se},
> > +     /* configure RSS for gtpu6 with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_IPV6_TEID, ICE_RSS_OUTER_HEADERS, false=
},
>
> Ditto, ICE_FLOW_HASH_GTP_U_IPV6_TEID and ICE_FLOW_HASH_GTP_IPV6_TEID seem
> to be incorrectly placed.
>
> > +     /* configure RSS for gtpu6e with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_EH, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu6u with input set IPv6 src/dst */
> > +     { ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_UP, ICE_RSS_OUTER_HEADERS, false=
},
> > +     /* configure RSS for gtpu6d with input set IPv6 src/dst */
> > +     {ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV6,
> > +             ICE_FLOW_HASH_GTP_U_IPV6_DWN, ICE_RSS_OUTER_HEADERS, fals=
e},
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.=
h
> > index 06ef6b78b7de..cdc3fa7fc944 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -2023,6 +2023,53 @@ static inline int ethtool_validate_duplex(__u8 d=
uplex)
> >  #define      IPV4_FLOW       0x10    /* hash only */
> >  #define      IPV6_FLOW       0x11    /* hash only */
> >  #define      ETHER_FLOW      0x12    /* spec only (ether_spec) */
> > +
> > +/* Used for GTP-U IPv4 and IPv6.
> > + * The format of GTP packets only includes
> > + * elements such as TEID and GTP version.
> > + * It is primarily intended for data communication of the UE.
> > + */
> > +#define GTPU_V4_FLOW 0x13    /* hash only */
> > +#define GTPU_V6_FLOW 0x14    /* hash only */
> > +
> > +/* Use for GTP-C IPv4 and v6.
> > + * The format of these GTP packets does not include TEID.
> > + * Primarily expected to be used for communication
> > + * to create sessions for UE data communication,
> > + * commonly referred to as CSR (Create Session Request).
> > + */
> > +#define GTPC_V4_FLOW 0x15    /* hash only */
> > +#define GTPC_V6_FLOW 0x16    /* hash only */
> > +
> > +/* Use for GTP-C IPv4 and v6.
> > + * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
> > + * After session creation, it becomes this packet.
> > + * This is mainly used for requests to realize UE handover.
> > + */
> > +#define GTPC_TEID_V4_FLOW 0x17       /* hash only */
> > +#define GTPC_TEID_V6_FLOW 0x18       /* hash only */
> > +
> > +/* Use for GTP-U and extended headers for the PDU session container(PS=
C).
>
> Again, missing space before (
>
> > + * The format of these GTP packets includes TEID and QFI.
> > + * In 5G communication using UPF (User Plane Function),
> > + * data communication with this extended header is performed.
> > + */
> > +#define GTPU_EH_V4_FLOW 0x19 /* hash only */
> > +#define GTPU_EH_V6_FLOW 0x1a /* hash only */
> > +
> > +/* Use for GTP-U IPv4 and v6 PDU session container(PSC) extended heade=
rs.
>
> Again, missing space before (
>
> > + * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished b=
y
> > + * UL/DL included in the PSC.
> > + * There are differences in the data included based on Downlink/Uplink=
,
> > + * and can be used to distinguish packets.
> > + * The functions described so far are useful when you want to
> > + * handle communication from the mobile network in UPF, PGW, etc.
> > + */
> > +#define GTPU_UL_V4_FLOW 0x1b /* hash only */
> > +#define GTPU_UL_V6_FLOW 0x1c /* hash only */
> > +#define GTPU_DL_V4_FLOW 0x1d /* hash only */
> > +#define GTPU_DL_V6_FLOW 0x1e /* hash only */
> > +
> >  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
> >  #define      FLOW_EXT        0x80000000
> >  #define      FLOW_MAC_EXT    0x40000000
> > @@ -2037,6 +2084,7 @@ static inline int ethtool_validate_duplex(__u8 du=
plex)
> >  #define      RXH_IP_DST      (1 << 5)
> >  #define      RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
> >  #define      RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> > +#define      RXH_GTP_TEID    (1 << 8) /* teid in case of GTP */
> >  #define      RXH_DISCARD     (1 << 31)
> >
> >  #define      RX_CLS_FLOW_DISC        0xffffffffffffffffULL
>
> Thanks,
> Marcin

