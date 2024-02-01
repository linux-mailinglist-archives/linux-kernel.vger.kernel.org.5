Return-Path: <linux-kernel+bounces-48298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C38459CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F86B24FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF45D493;
	Thu,  1 Feb 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oaocL2L0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A835D47F;
	Thu,  1 Feb 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796959; cv=none; b=uxopQT7dE7KHITw8TwkHpUHeUNVrZaMmkb23G1rxFhac3nKKQe3dQsM37gzZndZGZDTGNR8v0aaYJ49IGpmiQ26qJicXly1edoxNofJRtVgX1ImhfZoFSMaZ1avOHRF2awWjYlt2eHsojwLUVkTwaFWULBDs9NoP8Ij2Ad2szU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796959; c=relaxed/simple;
	bh=IBgH0tB27y4jumRoQMdXPm5HdwQXC8IYWeN1SNZ9N8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RWhoxQG3Zkb21K4XSWlK3m+01+w64zQy8aHalLlhp6f0M35Y37Yi44eNMJEUzHe+NoD8LDlMgvjYUXksOMUBjg72VTs+ltY8rkT9Vi8p5Ih+1AcBuwibuxIdgCSqtDDLaOdN7KFD/7/OLDiI00BjqtQX8ZctR3Yf2aTD8n7dd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oaocL2L0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411EFfZa122499;
	Thu, 1 Feb 2024 08:15:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706796941;
	bh=J6flvXpOkXawJWzN/G+NmhHzqrhF472sihVACRH/ksM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oaocL2L0YFB2E/M/Mx3/J+AVekeYV3/SxFQxmP03dI+IyFr1AHCTLo7qmpgXN4a4i
	 en3Xrd/L0oem5F1g3NVcsfl/EmRXe/XQdl4DPO/Y5bMeJPle4Qyp8VYbMLoe9S1WR2
	 QS0OFNUhIcWkKPkw4B5vnKx04f/8Uk/UcwAT24Fw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411EFfv3014842
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 08:15:41 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 08:15:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 08:15:41 -0600
Received: from [10.249.129.226] ([10.249.129.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411EFAoe050156;
	Thu, 1 Feb 2024 08:15:18 -0600
Message-ID: <0ff9f349-25f1-408c-b7f8-ffad035f427e@ti.com>
Date: Thu, 1 Feb 2024 19:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 1/2] net: ethernet: ti: Introduce
 inter-core-virt-eth as RPMsg driver
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <rogerq@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <srk@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240130110944.26771-1-r-gunasekaran@ti.com>
 <20240130110944.26771-2-r-gunasekaran@ti.com>
 <20240201133001.GC530335@kernel.org>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240201133001.GC530335@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Simon,

On 2/1/2024 7:00 PM, Simon Horman wrote:
> On Tue, Jan 30, 2024 at 04:39:43PM +0530, Ravi Gunasekaran wrote:
>> TI's K3 SoCs comprises heterogeneous processors (Cortex A, Cortex R).
>> When the ethernet controller is completely managed by a core (Cortex R)
>> running a flavor of RTOS, in a non virtualized environment, network traffic
>> tunnelling between heterogeneous processors can be realized by means of
>> RPMsg based shared memory ethernet driver. With the shared memory used
>> for the data plane and the RPMsg end point channel used for control plane.
>>
>> inter-core-virt-eth driver is modelled as a RPMsg based shared
>> memory ethernet driver for such an use case.
>>
>> As a first step, register the inter-core-virt-eth as a RPMsg driver.
>> And introduce basic control messages for querying and responding.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  drivers/net/ethernet/ti/inter-core-virt-eth.c | 139 ++++++++++++++++++
>>  drivers/net/ethernet/ti/inter-core-virt-eth.h |  89 +++++++++++
>>  2 files changed, 228 insertions(+)
>>  create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.c
>>  create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.h
>>
>> diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.c b/drivers/net/ethernet/ti/inter-core-virt-eth.c
>> new file mode 100644
>> index 000000000000..d3b689eab1c0
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/inter-core-virt-eth.c
>> @@ -0,0 +1,139 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> Hi Ravi and Siddharth,
>
> The correct style for SPDX headers in .c files is a '//' comment:
>
> // SPDX-License-Identifier: GPL-2.0

I will fix this.

>> +/* Texas Instruments K3 Inter Core Virtual Ethernet Driver
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
>> + */
> ...
>
>> diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.h b/drivers/net/ethernet/ti/inter-core-virt-eth.h
> ...
>
>> +struct icve_common {
>> +	struct rpmsg_device *rpdev;
>> +	spinlock_t send_msg_lock;
>> +	spinlock_t recv_msg_lock;
> Spinlocks ought to come with an comment regarding what they lock.

I will add the comments as reported by checkpatch.

>
>> +	struct message send_msg;
>> +	struct message recv_msg;
>> +	struct icve_port *port;
>> +	struct device *dev;
>> +} __packed;
>> +
>> +#endif /* __INTER_CORE_VIRT_ETH_H__ */
>> -- 
>> 2.17.1
>>
>>

Ravi

