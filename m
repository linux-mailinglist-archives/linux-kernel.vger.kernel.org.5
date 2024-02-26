Return-Path: <linux-kernel+bounces-81352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F2867499
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B2D28655F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEA604CC;
	Mon, 26 Feb 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3ffn9bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75940604BA;
	Mon, 26 Feb 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949908; cv=none; b=FxCwoznXTKdbafmL2h4ip6QY9cYvUyoADHi1wgubjbNMnSXETDg5C2c5uY+RQhrCIB6Ue4JyOaYpIPuFL9l/0a8CRQZYTAC8lqxUXHy4VJxyJzqvIzTBkW6KMxSOxKOVdOwybfRzM41amq5snZhO+QDr7LLlFR/mNir8FRaKCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949908; c=relaxed/simple;
	bh=VSnvGelLdUIxZaIuWRNLfdqqVKrr+uqj31Ykk1ZLMCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7ng5c1FEF+5N1NsI9B0c+4QwwPRH65yTFHmwfFUWRydw/izYeSzfdwyxH4jxi7wIyCSRtc2NPYhFsVLTa2UoTwjdLhPgBPGnfA9XnrzA/qW2otUj2X8ech7KutL6pMpmZBP7Ak5Wbk9o2O/qCAj45lWeyP3KbK4qmt5Slxx3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3ffn9bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC11C433F1;
	Mon, 26 Feb 2024 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949908;
	bh=VSnvGelLdUIxZaIuWRNLfdqqVKrr+uqj31Ykk1ZLMCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E3ffn9bdlAqqJECX5jOmuhuODqmMzGVocETBwQE3reLPzykSZ3ycyJ0TEf4AZ+KJb
	 yLRnbdhjiPrrgHEcwKAv+u68lWMGraKvyP59AB4dytfWg/mjHpABqrOYxdFiIo7jxO
	 25vwmq+dwb8iVzkGSjTsfeRvcAghQSmfRSwtzw40EPNFKNSh3LupfSzaLtWD7BUMUR
	 Fmw4V9sOwsRMO5d6oZiRtMLskwDTYjhrZoJD6B5xYb0PIQV88SjdZO8l3XDEnFgRC+
	 URKxKJ8vyhcnocyQDFMf9NhLtOU/ZTSvriJeQK35sgCGdSP0rz0PMrr1Fwse/g7gpY
	 gHlpcOgeJt3Mw==
Message-ID: <fc4f148d-d4d3-4994-8d36-c382c13ba52b@kernel.org>
Date: Mon, 26 Feb 2024 14:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Pekka Varis <p-varis@ti.com>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <20240215110953.3225099-2-c-vankar@ti.com>
 <4c82705d-b05c-4ee8-88ed-42f944a023ac@kernel.org>
 <03d53049-e649-4714-8ad4-49619a5e9475@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <03d53049-e649-4714-8ad4-49619a5e9475@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/02/2024 10:59, Siddharth Vadapalli wrote:
> On Mon, Feb 19, 2024 at 12:59:55PM +0200, Roger Quadros wrote:
>> Hi,
>>
>> On 15/02/2024 13:09, Chintan Vankar wrote:
>>> The CPSW peripherals on J7AHP, J7VCL, J7AEP, J7ES, AM64 SoCs have
>>> an errata i2401 "CPSW: Host Timestamps Cause CPSW Port to Lock up".
>>
> ...
> 
>>>  
>>> @@ -856,6 +852,9 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
>>>  		ndev_priv = netdev_priv(ndev);
>>>  		am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
>>>  		skb_put(skb, pkt_len);
>>> +		skb_reset_mac_header(skb);
>>
>> Why do you need to add skb_reset_mac_header here?
>>
>>> +		if (port->rx_ts_enabled)
>>> +			am65_cpts_rx_timestamp(common->cpts, skb);
>>
>> The timestamp should be added before you do skb_put().
> 
> Roger,
> 
> Could you please clarify why the timestamp should be added before
> skb_put()?

My bad. hwtimestamps lies after skb->end so it doesn't matter.

-- 
cheers,
-roger

