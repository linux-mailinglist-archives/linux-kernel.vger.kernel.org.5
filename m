Return-Path: <linux-kernel+bounces-48309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA827845A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347C5B2A7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3B5F48C;
	Thu,  1 Feb 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh0Iz/LY"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63A5F462;
	Thu,  1 Feb 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797349; cv=none; b=oookAMu/1XtQvTw2yWOj6hAhVH8w8P1ixsUGPsx+KZXaLH1eNXfw1w+GV8dt+51x5iOeXYjvnvyCt+cO6JYc2pFMHTcj2FWofCcuUhMnBgUeerSY4/hdUMLcKrY2PxB8HSd9sDEwtFO15rggS9WLkWyQj3BRWGE6tH3mLUoLyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797349; c=relaxed/simple;
	bh=vZ0f9QgMh/MLNXr5IM6uI3bSgBD+ttKqdlYxHv7Mncg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1SQ/yCqTKTh2Bc9WVndRFU2M1zgZddNbR+wvWjM7DlwWdKWJFQV+my5uezHdgr0BbJboFzrura9k/VItnIpSbYs4LbNM5yqD07swpez74p6161JsoIzUof+lLuZ+ErinVKX+MEL+GGkRY2ZTNcJQXeK7Mq6WraoJhZAQcZeTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh0Iz/LY; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797347; x=1738333347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vZ0f9QgMh/MLNXr5IM6uI3bSgBD+ttKqdlYxHv7Mncg=;
  b=eh0Iz/LYSRxrIMy5ktuHOewhdE9InVgas6hdfpruATWNEdw8/VWAmVtk
   lru3y9hCt8Tr8VnlQWJOEMfP4mjZLXLLRuMKWorauxY0/g6l2bz2X+D1+
   P6wXGjvWs9uYctyUmYN+PusFgfXQegIchvcRzvqkZiGVmuidxKbWOve+q
   qndrMW9MJr6wTQOPTnotT/rZ1oMF7WJGBB3HQelgkwlRf9Ad1AvwwLjPg
   0P6noVVgmge495lanEGB6AIEMQib8vDeVkx+Q2XvQCVanvdmKMG+KMaFr
   c9z56J4u+00P9ccOikYeKbyMvRRIMJZFu03IiQcGFkZr3X+I8ZG2ZWxrZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="401034126"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="401034126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:22:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119948354"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119948354"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.35.198]) ([10.246.35.198])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:22:23 -0800
Message-ID: <043361a1-bb11-4d0c-bbc2-d31b38deb4dc@linux.intel.com>
Date: Thu, 1 Feb 2024 15:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v7 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
Content-Language: en-US
To: Takeru Hayasaka <hayatake396@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, vladimir.oltean@nxp.com,
 linux-kernel@vger.kernel.org, laforge@gnumonks.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 mailhol.vincent@wanadoo.fr
References: <20240201033310.1028154-1-hayatake396@gmail.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240201033310.1028154-1-hayatake396@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01.02.2024 04:33, Takeru Hayasaka wrote:
> This is a patch that enables RSS functionality for GTP packets using ethtool.
> 
> A user can include TEID and make RSS work for GTP-U over IPv4 by doing the
> following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
> 
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
> 
> gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format does
> not include a TEID.
> gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format that
> includes a TEID.
> gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extended
> header includes Uplink, applicable to both IPv4 and IPv6.
> gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downlink,
> for both IPv4 and IPv6.
> 
> GTP generates a flow that includes an ID called TEID to identify the tunnel.
> This tunnel is created for each UE (User Equipment).By performing RSS based on
> this flow, it is possible to apply RSS for each communication unit from the UE.
> Without this, RSS would only be effective within the range of IP addresses. For
> instance, the PGW can only perform RSS within the IP range of the SGW.
> Problematic from a load distribution perspective, especially if there's a bias
> in the terminals connected to a particular base station.This case can be
> solved by using this patch.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> v2->v3: Based on Harald-san's review, I added documentation and comments to
> ethtool.h and ice.rst.
> v3->v4: Based on Marcin-san's review, I added the missing code for GTPC and
> GTPC_TEID, and revised the documentation and comments.
> v4->v5: Based on Marcin-san's review, I fixed rename and wrong code regarding
> GTPC
> v5->v6: Based on Marcin-san's review, Undoing the addition of unnecessary
> blank lines.Minor fixes.
> v6->v7 Based on Jakub-san's review, Split the patch.
>  include/uapi/linux/ethtool.h | 48 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 06ef6b78b7de..11fc18988bc2 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2023,6 +2023,53 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	IPV4_FLOW	0x10	/* hash only */
>  #define	IPV6_FLOW	0x11	/* hash only */
>  #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
> +
> +/* Used for GTP-U IPv4 and IPv6.
> + * The format of GTP packets only includes
> + * elements such as TEID and GTP version.
> + * It is primarily intended for data communication of the UE.
> + */
> +#define GTPU_V4_FLOW 0x13	/* hash only */
> +#define GTPU_V6_FLOW 0x14	/* hash only */
> +
> +/* Use for GTP-C IPv4 and v6.
> + * The format of these GTP packets does not include TEID.
> + * Primarily expected to be used for communication
> + * to create sessions for UE data communication,
> + * commonly referred to as CSR (Create Session Request).
> + */
> +#define GTPC_V4_FLOW 0x15	/* hash only */
> +#define GTPC_V6_FLOW 0x16	/* hash only */
> +
> +/* Use for GTP-C IPv4 and v6.
> + * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
> + * After session creation, it becomes this packet.
> + * This is mainly used for requests to realize UE handover.
> + */
> +#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
> +#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
> +
> +/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
> + * The format of these GTP packets includes TEID and QFI.
> + * In 5G communication using UPF (User Plane Function),
> + * data communication with this extended header is performed.
> + */
> +#define GTPU_EH_V4_FLOW 0x19	/* hash only */
> +#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
> +
> +/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
> + * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
> + * UL/DL included in the PSC.
> + * There are differences in the data included based on Downlink/Uplink,
> + * and can be used to distinguish packets.
> + * The functions described so far are useful when you want to
> + * handle communication from the mobile network in UPF, PGW, etc.
> + */
> +#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
> +#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
> +#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
> +#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
> +
>  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
>  #define	FLOW_EXT	0x80000000
>  #define	FLOW_MAC_EXT	0x40000000
> @@ -2037,6 +2084,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	RXH_IP_DST	(1 << 5)
>  #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
>  #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
> +#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
>  #define	RXH_DISCARD	(1 << 31)
>  
>  #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL

