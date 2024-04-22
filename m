Return-Path: <linux-kernel+bounces-153302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE48ACC32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF14EB24D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA31474CB;
	Mon, 22 Apr 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KjoeidS3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C214658F;
	Mon, 22 Apr 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786017; cv=none; b=cSmyFxG+rwPrZkr8tHxwA1A+cE0mKv/VvTff74bFGP7vfWsJoBkmezkH9Fjoz9tmkBcdoM5/gIvdj0VcTuHoTQeLO3IQGEDtbnawWF2sGYBxZ26uEO9VFBA8NnhV19KFO5IcFXVaT/B9w0Xg3L+vrJuSDdQfti87/d/l3pvXCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786017; c=relaxed/simple;
	bh=OtIT4ZDrndIdEQ3XvZhnwUHtIrc/1Kjzl6egH19m7JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c5aPRnVhRg4pctFEphk10LLbRRFobZnaSVzlKjuWNdj9Gf9rTkzn0MyDJdQmn2Lx/sFTHChYUmvIZkQ+ow/9d9LGvN8YhMtzK/yCo2TxgTOlycGaBsyU4KwmSsm4ORHvMeu+qTqFbDldSHnomZDlC+VrZC8Gox/12PIoeUm0wbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KjoeidS3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MBdkv3009267;
	Mon, 22 Apr 2024 06:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713785986;
	bh=xzNR1J4JC8x2iDrAZi8hRXVcWNOe522OtdWGdtBjwCs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KjoeidS3shpylO3V1IFSVlFuhnbwUEKJbERpt3In65ouHUbT8sNPYeDmY0HjfJ7km
	 eGvv5qhrqmZRLJh4GKUvIKCTLxgoEEjr/mREBkYSSMIAYDBmQyGgrR/+aHtC7/2FY2
	 CrRppFKyWPyHH0arSHE92MSdbqPHy35mZyTDsAtY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MBdkR7030973
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 06:39:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 06:39:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 06:39:46 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MBdfeg004953;
	Mon, 22 Apr 2024 06:39:42 -0500
Message-ID: <67c7f423-18ce-4804-8be9-cc4521733cd2@ti.com>
Date: Mon, 22 Apr 2024 17:09:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] Enable RX HW timestamp for PTP packets
 using CPTS FIFO
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>, <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240419082626.57225-1-c-vankar@ti.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240419082626.57225-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/04/24 13:56, Chintan Vankar wrote:
> The CPSW offers two mechanisms for communicating packet ingress timestamp
> information to the host.
> 
> The first mechanism is via the CPTS Event FIFO which records timestamp
> when triggered by certain events. One such event is the reception of an
> Ethernet packet with a specified EtherType field. This is used to capture
> ingress timestamps for PTP packets. With this mechanism the host must
> read the timestamp (from the CPTS FIFO) separately from the packet payload
> which is delivered via DMA.
> 
> In the second mechanism of timestamping, CPSW driver enables hardware
> timestamping for all received packets by setting the TSTAMP_EN bit in
> CPTS_CONTROL register, which directs the CPTS module to timestamp all
> received packets, followed by passing timestamp via DMA descriptors.
> This mechanism is responsible for triggering errata i2401:
> "CPSW: Host Timestamps Cause CPSW Port to Lock up."
> 
> The errata affects all K3 SoCs. Link to errata for AM64x:
> https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
> 
> As a workaround we can use first mechanism to timestamp received
> packets.
> 
> Series is based on linux-next tagged next-20240419.
> 
> Link to v7:
> https://lore.kernel.org/r/20240417120913.3811519-1-c-vankar@ti.com/
> 
> Changes from v7 to v8:
> - Removed empty lines between trailers in [PATCH v7 2/2] as suggested
>    by Jakub.
> 

Is it possible to merge this series if no further comment ?

> Chintan Vankar (2):
>    net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets
>      using CPTS FIFO
>    net: ethernet: ti: am65-cpsw/ethtool: Enable RX HW timestamp only for
>      PTP packets
> 
>   drivers/net/ethernet/ti/am65-cpsw-ethtool.c |  13 ++-
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  51 +++++-----
>   drivers/net/ethernet/ti/am65-cpts.c         | 107 ++++++++++++++------
>   drivers/net/ethernet/ti/am65-cpts.h         |  11 +-
>   4 files changed, 118 insertions(+), 64 deletions(-)
> 

