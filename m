Return-Path: <linux-kernel+bounces-151165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B98AAA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C2E1F22F70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC15F569;
	Fri, 19 Apr 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xX1nVF+L"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE64C8A;
	Fri, 19 Apr 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515424; cv=none; b=R4ZmkGAZAVyNmWlZ2wZ1F0w59wndPaNW1dykb2bExR6aDN3sjAl4fnUcVJdNfhUuMwhFO67kdpUGFEgEP4dbgtQ8qBL+DNVzu69eS0xp5xjrh9Wnw2acIM78p/CXRYqT2NycfLhwaUIAEsf2UXS3v8fu9uF3Syhpx2z46PbCVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515424; c=relaxed/simple;
	bh=N0P6f1YdebBFeQkudgS8GWtA8SUMDSzGlF92Ghhx5Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSRZeyYNsUGjoRGOXcu++tKMvrooEaroEW4JrnKqS8EkgdGmk6Dg/kOzNix2oalDuhcs6oSQ3HB0wBOVJWaYHYEXhN0pooyGkR8+fOEvEvq5DoBRTELHYo/qSc4Rbp4Ik5HfvDi6THD7S2VbjYSVtp/23TeGYenaKCkAp/yQ2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xX1nVF+L; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J8U6Ip010384;
	Fri, 19 Apr 2024 03:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713515406;
	bh=Dlv+RCoAGYzLiH6HRbCslfp0qGJbdNY0vW5H/6Uf47Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xX1nVF+LsoNDnB+1ati+fFwXZ/69iBNApp5dTalfNQgK7hhjQHAwYq8/LFCp0C9Jo
	 ZvJVnMUx9WtrbKEIwylORDzefOw2a2yeFFPXwKcQvc5dayppXHOUGQZfrL+v9VeFnc
	 5O1DylosjScbir4q6QKmZ25j2ipnvXbpHg6GpHyI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J8U6Rf005590
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 03:30:06 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 03:30:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 03:30:06 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J8U0nK048008;
	Fri, 19 Apr 2024 03:30:01 -0500
Message-ID: <7621947e-cf0c-481c-8180-328ab2df0748@ti.com>
Date: Fri, 19 Apr 2024 13:59:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ethernet: ti: am65-cpsw/ethtool:
 Enable RX HW timestamp only for PTP packets
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <s-vadapalli@ti.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240417120913.3811519-1-c-vankar@ti.com>
 <20240417120913.3811519-3-c-vankar@ti.com>
 <20240418185146.497cb075@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240418185146.497cb075@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/04/24 07:21, Jakub Kicinski wrote:
> On Wed, 17 Apr 2024 17:39:13 +0530 Chintan Vankar wrote:
>> Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> No empty lines between trailers, please

I posted v8 at:
https://lore.kernel.org/r/20240419082626.57225-1-c-vankar@ti.com/

