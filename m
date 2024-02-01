Return-Path: <linux-kernel+bounces-48306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2791845A08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CFEB2A285
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFA62155;
	Thu,  1 Feb 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QAYXwx/G"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E05F486;
	Thu,  1 Feb 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797246; cv=none; b=u7KYXkgRFkdwsOn9tukNmJVYZZaixlToqhap0uCfCweYg0PRh0gdKuh3QnQ6BfcYUQJ67F4//EbjRlW8iut5/P/IzVFJ6ETfUACEnjxpypQcUlz8ILqrXPdR5QekGNUPSWNsOpnj5Bv/SUse8WWJkD94Gt0zgrT1URmC9Xwsq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797246; c=relaxed/simple;
	bh=IBgH0tB27y4jumRoQMdXPm5HdwQXC8IYWeN1SNZ9N8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M5H6/2Wx5sX5qttxqq6fF0Ou5SabbaZKZWZj+AcjEOwcoaeMdCfJaHNZ3fU7b/fqfzmD2pbklgHP7z1X5r0hKTEUAIO4PmTuWGN3yfrXuscANuw6P3rjxxVzPQnVDJV+zo291jxo8G7IxeCGRwW8H+WJK7oIrLG4GY282GhPMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QAYXwx/G; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411EKYQZ000513;
	Thu, 1 Feb 2024 08:20:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706797234;
	bh=J6flvXpOkXawJWzN/G+NmhHzqrhF472sihVACRH/ksM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QAYXwx/GYYIkNQ9Af3fqu5LLvgpNdsw0Jiqv7/PMCAhEoZqwcAFyJ+RiGIXedo8FG
	 m0H1v82CYEpWadNDbP8EoZJ3ycSJcr5K94+8+W4v5y9rka2C5wfnWrxA1IS9+giZKb
	 NShPPD5Zx0PZ4438tNBYH2y8vkZbBcn/kK4jmgjs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411EKYfd074862
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 08:20:34 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 08:20:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 08:20:34 -0600
Received: from [10.249.129.226] ([10.249.129.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411EKOiR059019;
	Thu, 1 Feb 2024 08:20:26 -0600
Message-ID: <2fd948fd-33e5-4f32-862d-ba5bd0e46ac9@ti.com>
Date: Thu, 1 Feb 2024 19:50:21 +0530
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

