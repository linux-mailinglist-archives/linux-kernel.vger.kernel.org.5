Return-Path: <linux-kernel+bounces-161830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FE8B51E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F31F2133C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007512E74;
	Mon, 29 Apr 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HasDBHgB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523A111A5;
	Mon, 29 Apr 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373901; cv=none; b=GaSUHw25adlXkIhTzRHnglvObmxt2PQDpHsHi633hA5Kyf3m6suQ7Y0DaiEIW/4KXPxXL9ye08W6M7zT23Uy1oWE/41DLJi3JhSe7aoLRTTO3bskUMIRcKq4/urNwsfGwQMMpFIDUoDT0RyVH9xMjb4cZNN9WrRmXuEE7Yh18c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373901; c=relaxed/simple;
	bh=Py68IY/+ljaICP3qWpJKN4auBrI7bO6Iy+kpy+BcGjY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PCWE8vsUeb6uvdUjLCpnqBP2hcqLCUX9A4532zUMEJTtXMSS3v/g308LdZIJrWvFEjtnASA9HTP7pyd/6kXfQMKAf1sgASLyCV1tPQPqplW0NDGC27hZyV2M+J80rs8m1A5QrWTQbCE96VAY43v/dFsqDAOg7It60GftOUtLZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HasDBHgB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T6wCPJ069784;
	Mon, 29 Apr 2024 01:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714373892;
	bh=uxsEzA8YQiJtpudbOgeMEIqvfY/FdfNq87a9eDj3ncU=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=HasDBHgBFWKDlZFIALCl+FWYzRpklLkYP55Uq9n9ou1DUkbLAf2kcOY4XhT6yLuXF
	 ojWYa3+4wPOyIDLAkgMfsKWi/XtHjxNm27pUynKffMLZEwxUkhS+MZOYa49xBObmxF
	 GptKmd3MhrrPnPqLJvIrU0l60YUjy/D4RTYnwWic=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T6wCOv030073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 01:58:12 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 01:58:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 01:58:12 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T6w8WM004811;
	Mon, 29 Apr 2024 01:58:09 -0500
Message-ID: <f400160f-1caf-44f6-a1b2-3a538eebd63c@ti.com>
Date: Mon, 29 Apr 2024 12:28:08 +0530
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
From: Chintan Vankar <c-vankar@ti.com>
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
In-Reply-To: <4b3d2578-06ea-4feb-aa31-3968063953e8@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/04/24 12:12, Chintan Vankar wrote:
> 
> 
> On 29/04/24 12:08, Krzysztof Kozlowski wrote:
>> Are you sure you kept proper ordering of nodes or just stuffed this to
>> the end?
> 
> Yes, I added this node at the end.

Is it okay to add it at the end or it should be defined after "cpsw3g"
node ?

