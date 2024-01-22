Return-Path: <linux-kernel+bounces-32470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411FC835C18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA0B2878DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5291804D;
	Mon, 22 Jan 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YtRvclCJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED2210F1;
	Mon, 22 Jan 2024 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910109; cv=none; b=Fxa5Xp6qVG/KpjYbFeytf7WF9aORjUuvW627dTi3In0IJll5kT9QPnRKo5aeWQF0KQuSESV7Z0qsg/iz1nETZ2UI1i9V/7fon0eZ47EsOLWW7BQ9msRgVYTk7uQTcGEob01R0TKvdcuAfXkx/jFlX/IO6myI31U59F74EhbfVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910109; c=relaxed/simple;
	bh=6kV4fffNTKi7F6v40ek7pQmipRLKFkCSO7AULoajTEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ng1MFIP8w4vYoVvcB3oBBfBqREJIsgZEG5SCiY5k427TIrhsuyUB98WNs3c4okGXUY/u/qWqca8kHKcnH/sQ8z03fSGI6eEvbOHNZrS+P0jQHu0VRfo7tcJm108ZUM/7x02gVRddegfnTfmFMoBCVzFVxDi0fRSGQbiKkdm7UjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YtRvclCJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40M7sOG9066261;
	Mon, 22 Jan 2024 01:54:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705910064;
	bh=gyE302RNTQIm7x3UlXfpEhfye5LytrcQCiTqqBhswEk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YtRvclCJ6vxgDAxKIQh8eStTANsHHsUScDH9O91MKsuPoWSvDKaLzuhPf9M2OPeOk
	 GQktI+r8+K7fKAq9V8T8QVbWNdmEN++4k1org9RCpIehax1ZJW9jZl/Dne9RNi01FM
	 f8YhCr3BZDdrJ3K6TxKAo1Yfub90qLJF13QGTWC8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40M7sOCI005427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 01:54:24 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 01:54:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 01:54:23 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40M7qiXV088179;
	Mon, 22 Jan 2024 01:54:18 -0600
Message-ID: <f9f770a9-5c49-44e2-ab81-c7eb35f0ed87@ti.com>
Date: Mon, 22 Jan 2024 13:24:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] net: ti: icssg-switch: Add switchdev based
 driver for ethernet switch support
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-3-danishanwar@ti.com>
 <20240119204043.GC105385@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240119204043.GC105385@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 20/01/24 2:10 am, Simon Horman wrote:
> On Thu, Jan 18, 2024 at 12:40:04PM +0530, MD Danish Anwar wrote:
> 
> ...
> 
>> @@ -211,6 +216,15 @@ struct prueth_pdata {
>>   * @iep0: pointer to IEP0 device
>>   * @iep1: pointer to IEP1 device
>>   * @vlan_tbl: VLAN-FID table pointer
>> + * @hw_bridge_dev: pointer to HW bridge net device
>> + * @br_members: bitmask of bridge member ports
>> + * @prueth_netdevice_nb: netdevice notifier block
>> + * @prueth_switchdevice_nb: switchdev notifier block
> 
> nit: s/prueth_switchdevice_nb/prueth_switchdev_nb/
> 
>      Flagged by ./scripts/kernel-doc -none>

Sure Simon. I will fix this.

>> + * @prueth_switchdev_bl_nb: switchdev blocking notifier block
>> + * @is_switch_mode: flag to indicate if device is in Switch mode
>> + * @is_switchmode_supported: indicates platform support for switch mode
>> + * @switch_id: ID for mapping switch ports to bridge
>> + * @default_vlan: Default VLAN for host
>>   */
>>  struct prueth {
>>  	struct device *dev;
>> @@ -236,6 +250,16 @@ struct prueth {
>>  	struct icss_iep *iep0;
>>  	struct icss_iep *iep1;
>>  	struct prueth_vlan_tbl *vlan_tbl;
>> +
>> +	struct net_device *hw_bridge_dev;
>> +	u8 br_members;
>> +	struct notifier_block prueth_netdevice_nb;
>> +	struct notifier_block prueth_switchdev_nb;
>> +	struct notifier_block prueth_switchdev_bl_nb;
>> +	bool is_switch_mode;
>> +	bool is_switchmode_supported;
>> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>> +	int default_vlan;
>>  };
>>  
>>  struct emac_tx_ts_response {
> 
> ...

-- 
Thanks and Regards,
Danish

