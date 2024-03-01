Return-Path: <linux-kernel+bounces-88283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2B86DF9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991A61C22852
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E06BFA9;
	Fri,  1 Mar 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kbd27LkD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4896313B;
	Fri,  1 Mar 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290137; cv=none; b=Sn0PH+gzkvWh7TPQ17ZDsw3g7N0rUtmMlBxMWFtLg/IRSWlVlJn0Z/WRwKRninBlwr4POmNgLs6aHhsrqudrZ2/AxTOyzu1Go2Dz+aBuitphblRHOJ2XDTUbU0sXjGYeApYjW8lZWEh4BzPT+/8o/HEnMmJFFY3mmxgkO0CWAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290137; c=relaxed/simple;
	bh=I2WiRK3nrdrTe9uyfgCck5MP1oAIB84gwGFx4QScLe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LinUg0izuVIElPI4C8hUEXIrF5WxR0+pjUrowLNohyIiS9n+MXagKu3+ANA/22AMk2vNb9RFaatGhZFxqLW5oeIkSC/eIfCr+7oqdNq1DkxQIROwiiwS8nULBfuhvdHbm43BrkrbSKKfz8/M3ONVdQtFth9NH1c5vQdG0Z0Zs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kbd27LkD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 421Ambrn047013;
	Fri, 1 Mar 2024 04:48:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709290117;
	bh=xELjhiYnnXVmlP5XfKnRq9b6+5i1JLw3KEziD4K6Wng=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Kbd27LkDkM3Xg34xNynadmm6CpIq9p/ZqlZJvqDrlhJdKxh3Zo6b7Iq6lqHae7JMg
	 on5wPhd+7MdicRB/NgywZEjMOLM+OvX2ri/nxwixnvbZTd+IghIijYB4IM0d4A+Lze
	 BZ3gLdUy+kQ+SICQSLeCIuSvSvlKc7PYNj3R3Ewg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 421AmbA5016819
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Mar 2024 04:48:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 04:48:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 04:48:37 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 421AmX86095109;
	Fri, 1 Mar 2024 04:48:34 -0600
Message-ID: <ef948e8e-b1ae-476f-b07f-4bda6d33c51b@ti.com>
Date: Fri, 1 Mar 2024 16:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <20240215110953.3225099-2-c-vankar@ti.com>
 <3e81297c-2821-4af4-b13d-dc33ae8f85cc@intel.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <3e81297c-2821-4af4-b13d-dc33ae8f85cc@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/02/24 03:51, Jacob Keller wrote:
> 
> 
> On 2/15/2024 3:09 AM, Chintan Vankar wrote:
>> The CPSW peripherals on J7AHP, J7VCL, J7AEP, J7ES, AM64 SoCs have
>> an errata i2401 "CPSW: Host Timestamps Cause CPSW Port to Lock up".
>>
> 
> What's different about timestamping only PTP packets that prevents this
> port lock up?

The difference is the way we are timestamping the packets. Instead of
getting the timestamp from CPTS module, we are getting the timestamp
from CPTS Event FIFO.

In the current mechanism of timestamping, am65-cpsw-nuss driver
timestamps all received packets by setting the TSTAMP_EN bit in
CPTS_CONTROL register, which directs the CPTS module to timestamp all
received packets, followed by passing timestamp via DMA descriptors.
This mechanism was responsible for the CPSW port to lock up in certain
condition. We are preventing port lock up by disabling TSTAMP_EN bit in
CPTS_CONTROL register.

The mechanism we are following in this patch, utilizes the CPTS Event
FIFO that records timestamps corresponding to certain events, with one
such event being the reception of an Ethernet packet with EtherType
field set to PTP.

