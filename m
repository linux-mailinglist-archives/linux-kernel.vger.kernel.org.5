Return-Path: <linux-kernel+bounces-137547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0BA89E3BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9191F24043
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98552157A65;
	Tue,  9 Apr 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uMCszpP6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945A1386C0;
	Tue,  9 Apr 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691461; cv=none; b=KpKZhlleMVivsbWNq1AaccR6qXkQ6PWH0TXMrKxv+R4RDkEr+L1DPcAPBcawrdYtoTGju9YpTaOUjnd7p43tqfC6upoadZMgnDvMDtEt1fBQyBxTBZbJhh4cNSmxnJuLCgzaC8iVVWOOjBdJB1qOL1p1cj9UXfXggnMosUyHSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691461; c=relaxed/simple;
	bh=NWVotNPMcQTtLRf5uoxfd7Jy0qy0OAOatNqmTgO0CsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Daq65ABIE0rpGwVh7Bb/Cezj4eGGEPPAKjxlRJP6tsapdeyJDYSqv4SBmLNGeKkh91g8jTE3pU6auXqO4psovgHsVP4UBPuApPRmypDnSuwQmWBVnrmXFpcpCYP0dGIb/5moT+K6nBz7t/vZI4W6bt48upTN4OPWh8EXan6Tgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uMCszpP6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JbFs1105947;
	Tue, 9 Apr 2024 14:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691435;
	bh=NWVotNPMcQTtLRf5uoxfd7Jy0qy0OAOatNqmTgO0CsE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uMCszpP6yRuOm0KtBdRYkAElSygNdMmzKAi4xd/nQ8p4GxOkuvdO4fmxSqkf9OHKD
	 Lh/OEc7QtoZstXYWwkBgd8aU37g1s793SDJ2qLwoWFqci78Ai/TZfNSmpSUXvW72KL
	 aZ1e4MWx7E3une6gT6dwv5iHzArME2d5be9pQ/yA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JbFZS054227
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:37:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:37:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:37:15 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JbF4u090510;
	Tue, 9 Apr 2024 14:37:15 -0500
Message-ID: <a7b0baba-56bc-47ca-9494-0178f441ff8b@ti.com>
Date: Tue, 9 Apr 2024 14:37:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco
 Dolcini <francesco@dolcini.it>
References: <20240404153319.1088644-1-jm@ti.com>
 <a148e8ab-f502-45ec-b915-22fce751ad64@roeck-us.net>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <a148e8ab-f502-45ec-b915-22fce751ad64@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On 4/6/24 8:01 AM, Guenter Roeck wrote:
> On Thu, Apr 04, 2024 at 10:33:19AM -0500, Judith Mendez wrote:
>> On AM62x, the watchdog is pet before the valid window
>> is open. Fix min_hw_heartbeat and accommodate a 5% safety
>> margin with the exception of open window size < 10%,
>> which shall use <5% due to the smaller open window size.

Please do not merge this patch, I will add an additional
patch removing the hack in this driver.

~ Judith

