Return-Path: <linux-kernel+bounces-161999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAAE8B545F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D538A1C2102B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2541D554;
	Mon, 29 Apr 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bzX215ki"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14523778;
	Mon, 29 Apr 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383546; cv=none; b=Fr4mwW/bVfY5INyUvDijnvHz5z/2rWThXgL4a7z8vTfpy9QYdRlBJx/koSjcJUyPG62JFNBbo8OVnA+uDAOV0Ccu7v0xx2Vjd2YrTtdFONUyZUeybm1+zmQKxeQIyqikcxIVgvhwVEFwAa5q+FCQ7HBum4/ymBykgkku/3yjRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383546; c=relaxed/simple;
	bh=W7MvD+p/O90krreuB9fkav6CmZtQpz0wzidHSSp2Jng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A1BZaoC2edX6AL2Lh2YsTa9wcmcZmoJPyCMfPHVGBUmAk6rzZWGogHHP2TgzKOtEIj0cyZuDguyh04x2RCjbbd6A7GS5c07Vt+GCx5JSglmI4sg25EWGrFcPyGD6vJ/1KRyn6hk87fsm5rLCtzHOpeCWgfxAXdZG/Hg0B+y6eF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bzX215ki; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T9cw0t045354;
	Mon, 29 Apr 2024 04:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714383538;
	bh=lvzYwqLCfEJeLuKO9l9ekhrnO8zv0M4X8irKOCQ0xQo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bzX215kiL8MUE0nSaxv0B6NUKsYxpCTY7jCrDihLg4hOe9qXMPpUtUnFd2BW9GtdQ
	 UpZeAxaWZGVSGkQIcLupyPrpitAm8gOHl02VijOKV2iPgpnZQKXKheSrrspe9dbUuJ
	 nwswvKckIb1DtDGb1/iFkiMjAlOzTugG6x8vZnEU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T9cwdw030611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 04:38:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 04:38:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 04:38:58 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T9csRo026477;
	Mon, 29 Apr 2024 04:38:55 -0500
Message-ID: <0e6abfb3-ae9e-45db-b441-a7c97beec185@ti.com>
Date: Mon, 29 Apr 2024 15:08:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am625-sk: Add bootph-all property
 in phy_gmii_sel node
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>,
        <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240429061600.2723904-1-c-vankar@ti.com>
 <c17d8123-e9cb-45b5-84df-9fe102ddeddc@kernel.org>
 <4b3d2578-06ea-4feb-aa31-3968063953e8@ti.com>
 <f400160f-1caf-44f6-a1b2-3a538eebd63c@ti.com>
 <44e430f6-1bad-4d0c-a908-823b83625db5@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <44e430f6-1bad-4d0c-a908-823b83625db5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/04/24 12:56, Krzysztof Kozlowski wrote:
> On 29/04/2024 08:58, Chintan Vankar wrote:
>>
>>
>> On 29/04/24 12:12, Chintan Vankar wrote:
>>>
>>>
>>> On 29/04/24 12:08, Krzysztof Kozlowski wrote:
>>>> Are you sure you kept proper ordering of nodes or just stuffed this to
>>>> the end?
>>>
>>> Yes, I added this node at the end.
>>
>> Is it okay to add it at the end or it should be defined after "cpsw3g"
>> node ?
> 
> What is the ordering for this subarch? What does the DTS coding style say?
> 

I tried to verify the order this file is following from DTS coding style
documentation, but it seems it is not following the order mentioned in
Documentation.

Since we will need the same functionality for "am62x-lpsk" board I am
planning to add this node in "k3-am62x-sk-common.dtsi". In that file I
will follow the same order as it is followed in "k3-am62-main.dtsi".

> Best regards,
> Krzysztof
> 

