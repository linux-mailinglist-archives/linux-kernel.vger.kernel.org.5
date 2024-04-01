Return-Path: <linux-kernel+bounces-126566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5089399C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DEB283CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5967810A25;
	Mon,  1 Apr 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ETh4EF67"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3310953;
	Mon,  1 Apr 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964577; cv=none; b=jfUYbArBomYI3Q8sP8klT7usVqlJlRzEUL2amPHzN8KvWcZ6WEo2AtS4GtKegTz/KMYrFIuD1vu+3LlUvlcGVPeNXumGeir7W3s+Nh5Ch0SHNTp1E7zKy5lJk//mT+FTjae48yTzpywfEIZiM+r6Zs3TuC93atSjHmF6cZDKbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964577; c=relaxed/simple;
	bh=isJ3Jn6hKmgkrHhxfm17otcQbKQvHXaIgm0YRU9YOww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rPyLxHCub5Mobe8JHHzZNlRreBda0US+SShMDfueFFDQCwMCrVaIu3reZOCkHuM+rZFcvAjmekys3BQCMOniiJPM4rHR0KuvW6KRfc1e5QcIzJnUUnPb7bGCzl5DZTJODOQnHbA5ZJ1NWojRyacabrG9iwogqIWBrHWuCZubEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ETh4EF67; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4319gTmQ081850;
	Mon, 1 Apr 2024 04:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711964550;
	bh=i5y9JKndx7LRLlwpy0AhZG4Ql8kVBNJhuQ3M8lm2/tE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ETh4EF673HA9c13npiO3xSbf917xzXGuWjWxTTUnX+49dRBYOVh6F+jL2n3tYcBIu
	 7+j7AA+j00DfbNcZ5CYSIoNYBjfwKkl/C6YrwOgKDnWVZtoN3Dqg9qEOtQjc3d4uNd
	 fRBGgm4uM5ppf/gMPHzeHP3rs+4a8YUNaONGxsIw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4319gTuF103595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 04:42:29 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 04:42:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 04:42:29 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4319gPla073707;
	Mon, 1 Apr 2024 04:42:25 -0500
Message-ID: <8d8d3f54-4ae2-432e-9ac2-d3431436115e@ti.com>
Date: Mon, 1 Apr 2024 15:12:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpts: Enable PTP
 RX HW timestamp using CPTS FIFO
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
 <20240329150116.67da2b07@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240329150116.67da2b07@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 30/03/24 03:31, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 11:12:32 +0530 Chintan Vankar wrote:
>> CPTS module supports capturing timestamp for every packet it receives,
>> add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
>> of received packets from CPTS FIFO.
>>
>> Add another function named "am65_cpts_rx_timestamp()" which internally
>> calls "am65_cpts_find_rx_ts()" function and timestamps the received
>> PTP packets.
> 
> Maybe i'm unusually tied today but reading this patch without reading
> the next one makes no sense. I mean, you say:
> 
>    CPTS module supports capturing timestamp for every packet it
>    receives...
> 
> How is that relevant here.

Yes, I got your point it is not relevant here, I will update commit
message in next version.

> 
> When you post v5 please make sure to include a cover letter, explaining
> the overall goal and impact of the series.
> 
>> +			list_del_init(&event->list);
>> +			list_add(&event->list, &cpts->pool);
> 
> list_move() ?

Thanks for suggestion, I will update these function calls.


