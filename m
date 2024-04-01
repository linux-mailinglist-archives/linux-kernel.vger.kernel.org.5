Return-Path: <linux-kernel+bounces-127179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2048947C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE40B1F228DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910D58118;
	Mon,  1 Apr 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wls3XwFB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9456B9E;
	Mon,  1 Apr 2024 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014296; cv=none; b=JlvpF9nRIVx8N9iri3/xRQYyehcYA19lWMykZcDbpTduUjLK7Cd1O27jMR5aZcdUNdW4k4juZR6qkcdnpi8g6dYfLMquArBqVsD8Vs4kHrUWGkvzPg0dg1rlxWCgisJltJDHZlr0V0OIcA5RfBr0najDKsIwNvtb7sLhoAnrjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014296; c=relaxed/simple;
	bh=q7La18hXNNL7919OeH7QB28QewscyFbznXtnf29Jw8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V0soq5xuQ7wAyH3SJhHcCG9alm8yeMrw+B89BnNvPi9mAsZi4xD9mMgMXuApsdsbuomwaNZongtabWp615WxHoHWEmAwFoHj4L/AIOSnfM6C2FDWiVxdYOwsIpn6xzjhnQ9gbxzvrOaHVvJvBZGmOG95xvu+DAoEfe/4nGy83K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wls3XwFB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431NVU1j041379;
	Mon, 1 Apr 2024 18:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712014290;
	bh=EJU2nvq8Bl3WYpd7EBQ1XguFYr1UZAXNLxpZK70hq6I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Wls3XwFBFl7/fSHR4HYfEv37k0MzeJ6Ox8j0hZBbwxvogame4jamrCj/8Bir3A8xF
	 hILlm7VcLgk1tq10+i/s/TOjEjtPdFOqNa26gcv7KpexGDrnHA7H/BfdsUnixHEeve
	 N1zJRA+0Cn/wcBEt4B6lT1KvNBOJwa2S7mg/nog0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431NVUXq025250
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 18:31:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 18:31:30 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 18:31:29 -0500
Received: from [10.249.48.175] ([10.249.48.175])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431NVT1M009614;
	Mon, 1 Apr 2024 18:31:29 -0500
Message-ID: <fb0ddca3-3b74-8225-914e-d1799f6c3ca3@ti.com>
Date: Mon, 1 Apr 2024 18:31:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/13] mailbox: omap: Reverse FIFO busy check logic
To: Andrew Davis <afd@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Nick
 Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325172045.113047-1-afd@ti.com>
 <20240325172045.113047-13-afd@ti.com>
Content-Language: en-US
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20240325172045.113047-13-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/25/24 12:20, Andrew Davis wrote:
>   
>   static int omap_mbox_chan_send_noirq(struct omap_mbox *mbox, u32 msg)
>   {
> -	int ret = -EBUSY;
> +	if (mbox_fifo_full(mbox))
> +		return -EBUSY;
>   
> -	if (!mbox_fifo_full(mbox)) {
> -		omap_mbox_enable_irq(mbox, IRQ_RX);
> -		mbox_fifo_write(mbox, msg);
> -		ret = 0;
> -		omap_mbox_disable_irq(mbox, IRQ_RX);
> +	omap_mbox_enable_irq(mbox, IRQ_RX);
> +	mbox_fifo_write(mbox, msg);
> +	omap_mbox_disable_irq(mbox, IRQ_RX);
>   
> -		/* we must read and ack the interrupt directly from here */
> -		mbox_fifo_read(mbox);
> -		ack_mbox_irq(mbox, IRQ_RX);
> -	}
> +	/* we must read and ack the interrupt directly from here */
> +	mbox_fifo_read(mbox);
> +	ack_mbox_irq(mbox, IRQ_RX);
>   
> -	return ret;
> +	return 0;
>   }
Is n't the interrupt supposed to be IRQ_TX above? i.e TX ready signal?

