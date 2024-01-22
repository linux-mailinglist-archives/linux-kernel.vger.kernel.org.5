Return-Path: <linux-kernel+bounces-32785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933C83600C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763F9B22019
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD93A264;
	Mon, 22 Jan 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AeP7C9p8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBA3A8C3;
	Mon, 22 Jan 2024 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920551; cv=none; b=o/KN4NI3Go7Pe8GdXfQjZE59oGcOU7UkU3fUgcSGeO15Io5i+q6QCom3QPZKfFhbTHEHMrf6N03Y3Jyaz7Bvo983PaAMFPy82UyWGi+SEScu8VGJcjuCLv9dsnhWbl8J9rR2pB76V0tF49qYoUp/xx5XRUFAQcYPeNkQdnTABpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920551; c=relaxed/simple;
	bh=G/7NfDFOlqtjKjUrpbty5x9de3dLn4eUQJxwgMCjSdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZ4G5pdeoIlCPM4XjkATBhVSX/zAiFVvYgtwHOKnpj7Ly85/YKizJDNFGVmJVyAYZ1S34cx3WGwyTsI21Eqzpl3Zcyy910TnaiGDUa4hC5QAGhCNZHwN25qhCPHc3IqEvAcpzgD1TvO+5aZBKVMmsL64QxW/k6TaWggR/wJYDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AeP7C9p8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MAmoUX116000;
	Mon, 22 Jan 2024 04:48:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705920530;
	bh=BJya4J7U2wsMIZQXgChP3PwMJktx8r9T37jW6na+29g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AeP7C9p820x3uyj/qwJyH4LKUX3cRh2wjwSINg5BwXaqc9Sl+Wj1OCR+aA6ZBdBX4
	 HoVKTa95ZtCevUftW2jQa0oV78e80VNnAaJQTeY/kMYQu6Rh6fdt7SgG+/qmKGQruO
	 QmZ3vfj+sq/DFYyy0OvEadQ43uYa6zUGiqN1Ak20=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MAmnW8015586
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 04:48:50 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 04:48:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 04:48:49 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MAmiYU061813;
	Mon, 22 Jan 2024 04:48:44 -0600
Message-ID: <ad5c31cc-7cb6-4791-86fe-b2ba30abf33e@ti.com>
Date: Mon, 22 Jan 2024 16:18:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] net: ti: icssg-prueth: Add helper functions to
 configure FDB
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-2-danishanwar@ti.com>
 <a9c18466-7d7d-4a63-8096-d832bd9e455f@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <a9c18466-7d7d-4a63-8096-d832bd9e455f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/01/24 7:25 pm, Andrew Lunn wrote:
>> +int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
>> +		      u8 vid, u8 fid_c2, bool add)
>> +{
>> +
>> +	for (i = 0; i < ETH_ALEN; i++)
>> +		mac_fid[i] = addr[i];
> 
> ether_addr_copy()

Sure.

> 
>> +
>> +	/* 1-1 VID-FID mapping is already setup */
>> +	mac_fid[ETH_ALEN] = fid;
>> +	mac_fid[ETH_ALEN + 1] = 0;
>> +
>> +	fdb_slot = bitrev32(crc32_le(0, mac_fid, 8)) & PRUETH_SWITCH_FDB_MASK;
>> +
> 
>> +	fid_c2 |= ICSSG_FDB_ENTRY_VALID;
>> +	memcpy(&fdb_cmd.cmd_args[0], addr, 4);
>> +	memcpy(&fdb_cmd.cmd_args[1], &addr[4], 2);
>> +	fdb_cmd.cmd_args[1] |= ((fid << 16) | (fid_c2 << 24));
>> +	fdb_cmd.cmd_args[2] = fdb_slot;
> 
>> +int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
>> +		     u8 vid)
>> +{
> 
>> +	for (i = 0; i < ETH_ALEN; i++)
>> +		mac_fid[i] = addr[i];
>> +
>> +	/* 1-1 VID-FID mapping is already setup */
>> +	mac_fid[ETH_ALEN] = fid;
>> +	mac_fid[ETH_ALEN + 1] = 0;
> 
>> +	memcpy(&fdb_cmd.cmd_args[0], addr, 4);
>> +	memcpy(&fdb_cmd.cmd_args[1], &addr[4], 2);
>> +	fdb_cmd.cmd_args[1] |= fid << 16;
>> +	fdb_cmd.cmd_args[2] = fdb_slot;
> 
> Maybe add some helpers to reduce the amount of duplicated code?
> 

Some codes are duplicated in icssg_fdb_add_del() and icssg_fdb_lookup().
I'll try to add helpers in next version to minimize this.

>       Andrew

-- 
Thanks and Regards,
Danish

