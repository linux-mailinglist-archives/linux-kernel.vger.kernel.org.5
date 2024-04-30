Return-Path: <linux-kernel+bounces-164509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BBD8B7E64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4670F1F237C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6117F39C;
	Tue, 30 Apr 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HRLqXk8O"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6217BB20;
	Tue, 30 Apr 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498003; cv=none; b=iSySw6ZYMzQsFpIriIMHttYUp2nxh4+TsLIrLJPsP/inCplnjYaloV+9lOJnh65HdtNOB8FNGDYFYq/uAMTRSa9FkrRU/xAohZdE7NhBfwMd58jwB6n3AAj1qpG+kLr+761D9e9XNyjf980r7gGwVD2Uebv9HrXvieIzzwQ/sXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498003; c=relaxed/simple;
	bh=luTFpMAZ43ODWsmBxcty292H+fEg7Lp6RwRcQH0YjJg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PpGXpxTOlzdSOxvEg0AmSG6pG2qU1ujHm4AgY6bpcGXAmEUCPvteSXWqtd8Hry1v0/pUKxs2Q0YrEmyUPYa4YpZOsttFV/7wgckhjt8gHGjjjodI6Yyf0N4gC7ZtqGwGAW07diU8Ax3ukcripOb7mMtcbMwmL9MYrCP6g7aBXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HRLqXk8O; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UHQUHI087503;
	Tue, 30 Apr 2024 12:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714497990;
	bh=pj7f3enURpirZBtOK07f0GSNPrxz945QCn4kmv7I0xw=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=HRLqXk8OF+3CI27Ay7bYj4Vw2xDSJpbTUou/M3ngo33iXzxo9eDjE4Ke8xK748Dk2
	 cIVtbggs0NXVGj2KVw342Oqut+MqmZCmjLf4D2BB292HC0QlLJH6tQHXT/OQ8xTRJx
	 SvlmYB/WScyD4vtfnfMy2JhmeQg3Iba+bR3aJ6n0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UHQU08031885
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 12:26:30 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 12:26:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 12:26:29 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UHQTgG059219;
	Tue, 30 Apr 2024 12:26:29 -0500
Message-ID: <fa07e1ad-8e86-4f19-878a-26a639b3a058@ti.com>
Date: Tue, 30 Apr 2024 12:26:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] MMC fixes for TI K3 platforms
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        "Nishanth, Menon" <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20240423151732.3541894-1-jm@ti.com>
Content-Language: en-US
In-Reply-To: <20240423151732.3541894-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/23/24 10:17 AM, Judith Mendez wrote:
> This patch series includes MMC updates for various TI K3 platforms.
> 
> It includes support for enabling UHS/SDR104 bus modes.
> 
> For AM62ax, add missing UHS support.
> 
> For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
> in SDHCI nodes.

Please do not merge this series, will send a update v4.

~ Judith


