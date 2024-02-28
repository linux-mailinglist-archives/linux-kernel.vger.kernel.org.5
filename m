Return-Path: <linux-kernel+bounces-84587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0486A8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D4DB23901
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0DC23757;
	Wed, 28 Feb 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DrlJyQ1H"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC051EEFC;
	Wed, 28 Feb 2024 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104036; cv=none; b=pVatGwv+862gsE8AgeO+nm6Es26u7HTRe4+hCvofwxZKRm06HcpFQsuGZKOLlbvUgRZC6xdbIL67eJXrHIX5ZS+jsZu2VuJUBjU7h6RcdofXJdsSeDE2EAgeu1eVdTRW8Ay0oBsTLIi4b7QBS2/mmU3tMieJOnRpI51xHklJEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104036; c=relaxed/simple;
	bh=rH8a1xlgSv8otqY3V1Ueh3S5uKql5Tp5aIc70RVoy20=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G52MeyJwyCaZKrAhN0zENiEdjYj/ycKzpozFWKtH/2ze9u6S03yRJ0FQMJ3ot5dlFeCNYkNhNxTJRO7vcDfPDRnMo4MiLumQ0MZj+q3I+WgKJpVNTjXh3KYMCvnFGvFS+LXy9PxCsYG/qbhpUvTBLk+KwWtGYc7fPgm/W1IOOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DrlJyQ1H; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S76kAx006101;
	Wed, 28 Feb 2024 01:06:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709104006;
	bh=bWnuJSOtHFTdxNvHrznUXkm+6A6rrZIwSqOFLyy0mkc=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=DrlJyQ1HBXpuwXzCVufloMOj4zWmZAxB5kl2/wZSCqGRQAWWMchOBexH7FiJcVvfh
	 G3tntlhbo+gR+L4SD5eWHktIOc2X3m/9HpAgjLXSVcMrxCgfVLsbcTSY9XYEx/abS8
	 8RoAKyhbVG6jtuw4kOfVkHu0xcChZ/tcDNXjhIfc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S76kR8106225
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 01:06:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 01:06:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 01:06:45 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S76eQ3016464;
	Wed, 28 Feb 2024 01:06:41 -0600
Message-ID: <7d1496da-100a-4336-b744-33e843eba930@ti.com>
Date: Wed, 28 Feb 2024 12:36:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <andrew@lunn.ch>,
        <vladimir.oltean@nxp.com>, <hkallweit1@gmail.com>,
        <dan.carpenter@linaro.org>, <horms@kernel.org>,
        <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
To: Jiri Pirko <jiri@resnulli.us>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <Zd3YHQRMnv-ZvSWs@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 27/02/24 18:09, Jiri Pirko wrote:
> Tue, Feb 27, 2024 at 09:28:15AM CET, s-vadapalli@ti.com wrote:
>> The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
>> VLAN Aware or VLAN Unaware modes of operation. This is different from
>> the ALE being VLAN Aware and Unaware. The Ethernet Switch being VLAN Aware
>> results in the addition/removal/replacement of VLAN tag of packets during
>> egress as described in section "12.2.1.4.6.4.1 Transmit VLAN Processing" of
>> the AM65x Technical Reference Manual available at:
>> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>> In VLAN Unaware mode, packets remain unmodified on egress.
>>
>> The driver currently configures the Ethernet Switch in VLAN Aware mode by
>> default and there is no support to toggle this capability of the Ethernet
>> Switch at runtime. Thus, add support to toggle the capability by exporting
>> it via the ethtool "priv-flags" interface.
> 
> I don't follow. You have all the means to offload all bridge/vlan
> configurations properly and setup your hw according to that. See mlxsw
> for a reference. I don't see the need for any custom driver knobs.
> 

Thank you for reviewing the patch. Please note that the "VLAN Aware mode" being
referred to here is different from ALE being VLAN aware. The hw offload of
bridge/vlan configurations is already supported in the context of the ALE. The
Ethernet Switch being VLAN Aware is a layer on top of that, which enables
further processing on top of the untagged/VLAN packets. This patch aims to
provide a method to enable the following use-cases:
1. ALE VLAN Aware + CPSW VLAN Aware
2. ALE VLAN Aware + CPSW VLAN Unaware

All hw offloads of bridge/vlan configurations are w.r.t. ALE VLAN Aware alone.
Currently, only use-case 1 is enabled by the driver by default and there is no
knob to toggle to use-case 2.

I am quoting sections of the Technical Reference Manual mentioned in my commit
message, in order to clarify the CPSW VLAN Unaware and CPSW VLAN Aware terminology.

CPSW VLAN Unaware:
Transmit packets are NOT modified during switch egress.

CPSW VLAN Aware:
1. Untagged Packet Operations
Untagged packets are all packets that are not a VLAN packet or a priority tagged
packet. According to the CPWS0_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the
packet header the packet may exit the switch with a VLAN tag inserted or the
packet may leave the switch unchanged....
2. Priority Tagged Packet Operations (VLAN VID == 0 && EN_VID0_MODE ==0h)
Priority tagged packets are packets that contain a VLAN header with VID = 0.
According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
header, priority tagged packets may exit the switch with their VLAN ID and
priority replaced or they may have their priority tag completely removed....
3. VLAN Tagged Packet Operations (VLAN VID != 0 || (EN_VID0_MODE ==1h && VLAN
VID ==0))
VLAN tagged packets are packets that contain a VLAN header specifying the VLAN
the packet belongs to
(VID), the packet priority (PRI), and the drop eligibility indicator (CFI).
According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
header, VLAN tagged packets may exit the switch with their VLAN priority
replaced or they may have their VLAN header completely removed...

I hope that this clarifies that CPSW VLAN Unaware/Aware is a layer on top of the
hw offload-able bridge/vlan configuration.  Please let me know if there is
anything specific that could enable this without requiring the "priv-flag" based
implementation of this patch.

-- 
Regards,
Siddharth.

