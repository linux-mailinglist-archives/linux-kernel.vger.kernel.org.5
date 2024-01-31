Return-Path: <linux-kernel+bounces-46386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D45843EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478231F3042A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807A77F2C;
	Wed, 31 Jan 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTWFvOI3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8969D39;
	Wed, 31 Jan 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702013; cv=none; b=nPFE1MGUviOocv8bHW8ye9+zFiMOhj5XXEejR7i07OPkPS70QGBafaqmOBFHoAlPvhqCwwK3H3xvXlAR3+3W3DUlNtcw8wVZE1PGyj+dBXvvfOLqM+N50GK4gOXYPlnh1JN8dRuE1BK/oDVxTALLBnVnPDkana8mNxfsI+o8rU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702013; c=relaxed/simple;
	bh=e6U7IZSvIvmIZ9psc3hSArHZqp0dIjof9nK3JhYKmU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dehGCwaWcDsuPVdYObxkG2R1uX1Rivmo/M3Jpqi5W8JCnB20VCjRN2X0FTMuqwxRzd0kx8D2lKbPs8uDZJthkeg06cYpnDdZmwCfSbBGSWqRXj3W2MtRWdL7NEYS117ZeXiGo4yofHRWPoJ7oRDAVgx9sANijpegG+mf3/Er5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTWFvOI3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706702012; x=1738238012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e6U7IZSvIvmIZ9psc3hSArHZqp0dIjof9nK3JhYKmU4=;
  b=XTWFvOI3hC0/8xqrvZR9WW3oDX/h3TKPm4PgF0yYw5nSETGHLu7aGC4K
   Dl0GceqpOUEM+hV4I/t4xnOaaE2iBoTOzB2GivEtZ4QYA1kZPNVMj87lR
   MqKtwasTFaDJ1Corr2vAx0sO3ZYolKH3ifrhqS17HiYlqGJANzbUw/5oi
   04aBfa0UrhWsfjX3cJZQiVc/HZCuDG+cn4Jaz8tmm04zGWY6Izdytnqu4
   cPH1GxfSrA5OM3kK1OmqyTcfF+spgVdPCSB8gZ6/zL9LEKpbAWsYsvQyJ
   1jKO8cBFhLu/y87ng90XqVFzzMLhmdOFA8IklxuMnsijBsDZy8JdRzaT7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10962417"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10962417"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738071148"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="738071148"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.35.198]) ([10.246.35.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:53:27 -0800
Message-ID: <0fc3f574-6243-4c85-a6a7-442dc480c9e7@linux.intel.com>
Date: Wed, 31 Jan 2024 12:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v5] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
References: <20240131013705.1002722-1-hayatake396@gmail.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240131013705.1002722-1-hayatake396@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31.01.2024 02:37, Takeru Hayasaka wrote:
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

LGTM
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> v2->v3: Based on Harald-san's review, I added documentation and comments to 
> ethtool.h and ice.rst.
> v3->v4: Based on Marcin-san's review, I added the missing code for GTPC and 
> GTPC_TEID, and revised the documentation and comments.
> v4->v5: Based on Marcin-san's review, I fixed rename and wrong code regarding
> GTPC

[...]

>      f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet.
>      n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet.
> -

Still removing this line :c

> +    e     Hash on GTP Packet on TEID (4bytes) of the Rx packet.
>  
>  Accelerated Receive Flow Steering (aRFS)
>  ----------------------------------------

---8<---

