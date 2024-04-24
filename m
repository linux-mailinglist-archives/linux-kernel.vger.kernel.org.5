Return-Path: <linux-kernel+bounces-156543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C22E8B0450
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF871C223F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A0158A0F;
	Wed, 24 Apr 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qPaV+0N8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5C15885C;
	Wed, 24 Apr 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947306; cv=none; b=kA8lKIRmXIPUXpHqDTz2c62JV4f5qbQW74av/4ufZWQCUXqfoUdQL5dE6OiyuPvGzWKntXWzWQS2v4mreVt+r/vzTFtsP18TX0VbzYVKnefkJtQdFte/+TOVolum6dmmkdryx1KEvsNUoC0O5ckOKzQV02bLsBiXX9K4DhvUnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947306; c=relaxed/simple;
	bh=9dKslndYqqRusj/yH1aNNs2IzvBLatzMNa4buer5ZeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AElihs9P7PkH+0Zw/En0HYED219RQzdMh/i0zu4ezrzdsYl3CEnDBlX8h3iU8PsVU9LWjkojG2F2OKe48ObPrkmYUbg/nDXJbHvpCWoENtea9s+u95BMcjuSbdd9wcSMMFmpqUsPheDxtM5VnbWYGrRPW4JY3iliDOYK4e2ZPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qPaV+0N8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O8S717091864;
	Wed, 24 Apr 2024 03:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713947287;
	bh=WDJAPZScJOMpBY9g8xP0a01blxFcMfNH5IknQ7zpWPM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qPaV+0N8Xb2YHqZoVP0dyxcZ1aPobSolNZcWccxaryHUnKPzlOOYa1DDOODOs4FLw
	 LlLHgdVMmutEFgPoACFXuDZfSObjQeYf0gKpb6nGEMcv4Slrsdc7R/QdTUjeCWa/GY
	 iRVmnmWVGG2nFSuF7CZOnK9kGSz4qTldhPrCi7dY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O8S7df112708
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 03:28:07 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 03:28:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 03:28:06 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O8S14V096709;
	Wed, 24 Apr 2024 03:28:02 -0500
Message-ID: <a837ef60-d209-4f97-81b3-e29945f20f28@ti.com>
Date: Wed, 24 Apr 2024 13:58:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix signedness bug in
 prueth_init_rx_chns()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Roger Quadros <rogerq@ti.com>
CC: Roger Quadros <rogerq@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 23/04/24 9:45 pm, Dan Carpenter wrote:
> The rx_chn->irq[] array is unsigned int but it should be signed for the
> error handling to work.  Also if k3_udma_glue_rx_get_irq() returns zero
> then we should return -ENXIO instead of success.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

