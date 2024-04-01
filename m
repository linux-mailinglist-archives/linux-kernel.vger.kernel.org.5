Return-Path: <linux-kernel+bounces-126571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 945068939B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3E01F2122A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078EC10A3B;
	Mon,  1 Apr 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H4IgENyy"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245D10953;
	Mon,  1 Apr 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964826; cv=none; b=PtWMBoBcbeO1UaxVIgrNFYygzIaHQv0nBl1C12U3a9oiAV74HloTojlz0ImASKnYAYSo3rd7LmX/EyIMy5VpVPEz4RKMSOJeeir5d4yZBS2aRm+Mm4udIGWqve/q8qDr7732cEU0J36YjjSEC3lEUl+IC9I44O593+Hf3/Js/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964826; c=relaxed/simple;
	bh=ikA8MDST2pXkX5fvpsetPaZ87FEe2/XOnEPeV5hEdWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YBP11AElH8/llXWXaGYWd1mITBrldcD8ZrRqvfUnpWidoMr7542/2E08xIdZZcagqORttP+3dzc8ymRdFQ5xQluux2izxl4EkLKJwM/o2yFdDs8bknoIJDR7drEfQwEFM6+wZ12sHVeGyS/8yX5ePsK5Akn2qqUmPX9ZZZyv3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H4IgENyy; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4319kfaK037664;
	Mon, 1 Apr 2024 04:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711964801;
	bh=GhP5JL9UrBvNzC+YjH3zvQlQUkQUerqqI1bJfe0019Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H4IgENyyXQHgD5rNK0yeyIHVyoOglcgg4xT2+pOB9jY/2df7+qBPpgMXVW97bg3As
	 LobVu9YNnPiDOG1A2e5WC5J0gefE7hUPEhDSwW57BJFBbmvxBZ8VaBxAYJggYvwSDz
	 YMPLaM9L37H1FsKoZicAqY78aGP0uZgzSiFxeiKM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4319kegB059389
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 04:46:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 04:46:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 04:46:40 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4319ix0X075731;
	Mon, 1 Apr 2024 04:46:36 -0500
Message-ID: <d7c1adc3-e9b2-4ed8-b16e-e36474c4b5f5@ti.com>
Date: Mon, 1 Apr 2024 15:16:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool:
 Update rx_filters for CPSW's timestamping capability
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
 <20240327054234.1906957-3-c-vankar@ti.com>
 <20240329145517.7b46a15a@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240329145517.7b46a15a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 30/03/24 03:25, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 11:12:34 +0530 Chintan Vankar wrote:
>> Update supported hwtstamp_rx_filters values for CPSW's timestamping
>> capability.
> 
> Is there a reason this is not part of the previous patch?

No there is no reason to make it as independent patch, I will combine
this patch with previous patch in next version.

