Return-Path: <linux-kernel+bounces-127202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803738947F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074E9B22252
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8156760;
	Mon,  1 Apr 2024 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J/BALkIp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CC57303;
	Mon,  1 Apr 2024 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015234; cv=none; b=ISElAImyByPwNv9VdT3t0pajgdf5juLYL9M5OfD7nCDLsW1a2Br+D/7qQWzoVOyahiL5fw+pDqhn4rJ4zZ2a3iWxEyZ/0rGQDQv5jwV2E/gvcngpzpPgo51UXmIxcOA0bM/EiEOIEY9w7WXPU4GJC7UQ6YWeZEwA8lPnoRvVky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015234; c=relaxed/simple;
	bh=AOoodEPk5RmfeYxvfVLpELQG0Xp56P/7okwOfi5Lspo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pGd40qyBokND3VcVWp7Ko8x/ezWTkOypLdLanDvw0U8nEpCuuyXJBiYZG0soX3/8efg8B23IbLHpekeDUIHXNAteDlz+1ORpHf/cwPGijlyerRSU9tjq2DL9WPg99TnozNR5UWA+WJlSY/FJCAp5lrDL5NkOXCx05rOe/+7LMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J/BALkIp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431Nl6ct103875;
	Mon, 1 Apr 2024 18:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712015226;
	bh=AOoodEPk5RmfeYxvfVLpELQG0Xp56P/7okwOfi5Lspo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=J/BALkIp4W9XgwnJnxYkNoUsX1RZIWpDnskzpI+fnBjVPEcKC5SxQydh2iYefX0+x
	 WD6q0K47DTlGej9xgWoUfLvKaZCxpKWbMfm5vgJMl7L8yXyR7Oehpasrh7oWySCs0p
	 zQ18nMKH8Auc0oxbn+wm+dnOS6Npveit74H3Z1bI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431Nl6Jj123295
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 18:47:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 18:47:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 18:47:06 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431Nl550034899;
	Mon, 1 Apr 2024 18:47:06 -0500
Message-ID: <c297dd68-f331-4c7f-a740-8fe722b347b0@ti.com>
Date: Mon, 1 Apr 2024 18:47:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] mailbox: omap: Reverse FIFO busy check logic
To: Hari Nagalla <hnagalla@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325172045.113047-1-afd@ti.com>
 <20240325172045.113047-13-afd@ti.com>
 <fb0ddca3-3b74-8225-914e-d1799f6c3ca3@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <fb0ddca3-3b74-8225-914e-d1799f6c3ca3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/1/24 6:31 PM, Hari Nagalla wrote:
> On 3/25/24 12:20, Andrew Davis wrote:
>>   static int omap_mbox_chan_send_noirq(struct omap_mbox *mbox, u32 msg)
>>   {
>> -    int ret = -EBUSY;
>> +    if (mbox_fifo_full(mbox))
>> +        return -EBUSY;
>> -    if (!mbox_fifo_full(mbox)) {
>> -        omap_mbox_enable_irq(mbox, IRQ_RX);
>> -        mbox_fifo_write(mbox, msg);
>> -        ret = 0;
>> -        omap_mbox_disable_irq(mbox, IRQ_RX);
>> +    omap_mbox_enable_irq(mbox, IRQ_RX);
>> +    mbox_fifo_write(mbox, msg);
>> +    omap_mbox_disable_irq(mbox, IRQ_RX);
>> -        /* we must read and ack the interrupt directly from here */
>> -        mbox_fifo_read(mbox);
>> -        ack_mbox_irq(mbox, IRQ_RX);
>> -    }
>> +    /* we must read and ack the interrupt directly from here */
>> +    mbox_fifo_read(mbox);
>> +    ack_mbox_irq(mbox, IRQ_RX);
>> -    return ret;
>> +    return 0;
>>   }
> Is n't the interrupt supposed to be IRQ_TX above? i.e TX ready signal?

Hmm, could be, but this patch doesn't actually change anything, only moves code
around for readability. So if we were are ack'ing the wrong interrupt, then it
was wrong before. We should check that and fix it if needed in a follow up patch.

Andrew

