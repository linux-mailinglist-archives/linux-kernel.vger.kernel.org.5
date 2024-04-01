Return-Path: <linux-kernel+bounces-126570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF53B8939B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACEB2845A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACB812E59;
	Mon,  1 Apr 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sma4FM2C"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCF10961;
	Mon,  1 Apr 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964730; cv=none; b=eBr3VJPKRDpBTLNWj5EXUXqSfIBqC/L0vY1hZocR7s1nueODIKFT7pG7InPhVYPQIv4i5WNoAucp4QVRIybW/ludeZ5oxjKe78Ax40eNDXjhifGs06hZP6n0SXmB6FH6wNNQj6kf2SA660FtiTTXj53xLGd+nXyqUfBFTZP4v9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964730; c=relaxed/simple;
	bh=eV+OvalZWLRK2mZGJdcqHlgvFQZDOg9+43ahVhwnX4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AY/uzJhB8OAgCJfDsNM0+TvIJMQmh1co1OhW0wlLHg0sQTc9DZGy2cjsq22UyqtKYEDs4mxEIbt8KgqUH7IsrPMKRuj2EZPv0OTbEQPZV5f587W17ApG42Ce8fDB8B5Ve0rmOpcbtqboGN8HarwRwUjo0bo+uYO1D1HDMw/IKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sma4FM2C; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4319j4nf036416;
	Mon, 1 Apr 2024 04:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711964704;
	bh=3S2xvaZ3v3wuVPNr46fhQGhxReU2KliWLP656lV+sEM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sma4FM2C/aBAqHuRfafteu9eXRuxPfrq7n1AEVDTbRR4bIbinVr4cGOUs1Koh8bo2
	 8qfe8b31iQ3SYRtlO6LnPT1Hi4LSP4CMK61lPDhjxkhicq5fap7kuDW65FiMc/qXBc
	 7L4YHeyEZbhbYz7iHwg1xtRere5puEdkWYgRVQms=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4319j4wm002750
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 04:45:04 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 04:45:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 04:45:04 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4319ix0W075731;
	Mon, 1 Apr 2024 04:45:00 -0500
Message-ID: <b40ba4a7-e2b0-46e6-a5b8-2dfaa6bbbabd@ti.com>
Date: Mon, 1 Apr 2024 15:14:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/3] net: ethernet: ti: am65-cpsw: Enable RX
 HW timestamp only for PTP packets
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240327054234.1906957-1-c-vankar@ti.com>
 <20240327054234.1906957-2-c-vankar@ti.com>
 <20240329145904.0b7cb60f@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240329145904.0b7cb60f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 30/03/24 03:29, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 11:12:33 +0530 Chintan Vankar wrote:
>> To prevent port lock up, disable TSTAMP_EN bit in CPTS_CONTROL
>> register. The workaround for timestamping received packets is to
>> utilize the CPTS Event FIFO that records timestamps corresponding to
>> certain events, with one such event being the reception of an
>> Ethernet packet with the EtherType field set to Precision Time
>> Protocol (PTP).
> 
> You mention EtherType here but the drive retains L4 support,
> which is somewhat confusing. Perhaps mention L4 / UDP ports
> here, too.

Okay. I will update message with your suggestion.


