Return-Path: <linux-kernel+bounces-32467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60F835C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FB5287B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF117BD3;
	Mon, 22 Jan 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C8JnR5iB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C61A70A;
	Mon, 22 Jan 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910003; cv=none; b=M1tnpsx6GakfntvYxQAZhLfktOi5LLoJO1JCZbiCg7JQoG/PAUNtNN7pNmUvjgGIjMK4XHk8N9q/Mx4WEpTXNXWRw41eDa06+XaDggVrBK+IgQIMLmMELVojvtN3MGzLrV1/KPUaK+xqd2+gHyZVskospLlmE4xuWw2wlzkW9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910003; c=relaxed/simple;
	bh=zGg/JyczdYkZ0t+ceaJSIs/Kq8Jy09hGt+I/QMQpZ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=chUIQz3VU05paRMeoyhv02ZYodsuiCT+ZTKMgqcsWV6Sb26SC67GPG0nr9WJPd3aq45nHx+8921QD+n41k34V2oZqSy4WQme5FxCxrL/GxgIQ7ZUofo0onm8kBgOC0Jp3et8WsuzhYTwOqM+1IkrPXJwwnFQKaWsiJSfcE2P9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C8JnR5iB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40M7qph4056864;
	Mon, 22 Jan 2024 01:52:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705909971;
	bh=ArV+uPoRSO6UOeJsZ4X7EFQTfYt+k2zHQ2CQzWZiGq0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=C8JnR5iBBsmP/y0T2FNblENaXxYMtDHWWIZe04EsTOzocwkoqAn1DI8S0Iq9f2XFI
	 E7Wvlvxf3HVUNqvVgX+9fW8F6NMqUllnacwL707jsmhC9Kb8pReTQcRysJ6vZ3LwXL
	 RO/PPJ035iRjvXnqo2uNUdAAWScSLFwSTC/gnra8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40M7qpKL003897
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 01:52:51 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 01:52:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 01:52:50 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40M7qiXU088179;
	Mon, 22 Jan 2024 01:52:45 -0600
Message-ID: <753e01ea-8882-4e42-928a-9ae588dbeb67@ti.com>
Date: Mon, 22 Jan 2024 13:22:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] net: ti: icssg-prueth: Add support for ICSSG
 switch firmware
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
 <20240118071005.1514498-4-danishanwar@ti.com>
 <20240119204154.GD105385@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240119204154.GD105385@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 20/01/24 2:11 am, Simon Horman wrote:
> On Thu, Jan 18, 2024 at 12:40:05PM +0530, MD Danish Anwar wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
>> index 48d8ed4fa7a8..90d0d98e0ef9 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
>> @@ -14,7 +14,7 @@
>>  
>>  #include "icssg_prueth.h"
>>  #include "icssg_switchdev.h"
>> -#include "icss_mii_rt.h"
>> +#include "icssg_mii_rt.h"
>>  
>>  struct prueth_switchdev_event_work {
>>  	struct work_struct work;
> 
> Hi,
> 
> I think this hunk should be squashed into the previous patch.

Sure Simon, I'll move this to previous patch.

-- 
Thanks and Regards,
Danish

