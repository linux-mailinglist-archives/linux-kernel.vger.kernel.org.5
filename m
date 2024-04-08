Return-Path: <linux-kernel+bounces-135221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38D89BCF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2485228160B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F4535CF;
	Mon,  8 Apr 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d2kxEXwo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4152F82;
	Mon,  8 Apr 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571841; cv=none; b=TZ0qJ05PbIJtrvovgiqYpveYcRYn4qE8rdgahPocIFa+SdKGfX2p6heoHoNc8H4pklXJbEHh/j5GHGbu30uwWUNAxgWnxmdMhgUXcaMvDnx00J1sBrUgOSTt0DLQIQRIbB3fkUD7a7s8QVyZ0xDO8TwGZTImKNS40RsYo+lNlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571841; c=relaxed/simple;
	bh=sMw/aCXO7lYISwDTZK7qydxkKg61DpDEmB/fTt38OmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/lXFqvCM+5IB2abRebjBVBj3NuX+Bk9TFz8SZUKrBN8Y/toy/eOg8xGql/0Liqu0P6ogqMngqDzz7XMDCg+0p8WSlNn2RQRLjoW62YBEUeIfWRb5hfmbdiXDKVfg05B2S35Z/hP0Il6WICifmE/xb5IZn3iNpEC4yA2Hunctt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d2kxEXwo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438AMjY4049014;
	Mon, 8 Apr 2024 05:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712571765;
	bh=V6vWmXTnIuRI/4gpiOh/ZT7mEvfeSp6w0CufOzbujAA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=d2kxEXwotmC2OTE8c9G8+rRanvh9ajhnpW9SWxxxJWioch4VxJlXccYWkhOmBCsUY
	 g5tQjVQnKnIrsFxyMO1PXeGzQjE2rNgKEoBxZYaJ/3zfAESxGvAcZCSKAWKDmDZbK0
	 mT1rE1OhOqRGjnBN/dWvoe7WZq+WBhJZ92/Ge+Ak=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438AMje0042797
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 05:22:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 05:22:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 05:22:44 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438AMicH017293;
	Mon, 8 Apr 2024 05:22:44 -0500
Date: Mon, 8 Apr 2024 15:52:43 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v8 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Message-ID: <20240408102243.py24oa26ycnjha3m@dhruva>
References: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
 <20240405-pinctrl-scmi-v8-1-5fc8e33871bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405-pinctrl-scmi-v8-1-5fc8e33871bf@nxp.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Apr 05, 2024 at 09:59:32 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When Agent sending data to SCMI server, the Agent driver could check
> the size to avoid protocol buffer overflow. So introduce the helper
> get_max_msg_size.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |  2 ++
>  2 files changed, 17 insertions(+)

[...]

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

