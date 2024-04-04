Return-Path: <linux-kernel+bounces-131729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E0898B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5721F2D2DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C476129A75;
	Thu,  4 Apr 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PxqEuPUS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65D12AAD6;
	Thu,  4 Apr 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244787; cv=none; b=TzVkducTnZiWFz1lhc3WNiiEszLSe/1DZP5LcvxQfhP3W33BK9oXL8o+oCx7PPryBN5JGem6YlBk3SE6LhU2Hb320lZhFWo07JT39o4w2DByJe6tjlSCgZkuKhuIU5JRsuhM6GgnUExSCCM84rzmj3ajaBvgoyaF8H3UhHcRysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244787; c=relaxed/simple;
	bh=yrjkmQiC3FMkSbl5HUztMPrVreWKuakw77l4M84qpsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FIdlBguX1gqod4hep7kh/cO8BV5Q++jBJbKf4FgIID9QAGXSANUBux8tL/21gk1j9VJW4XvVxZ2sF/0mu/PxRp8ZgHY0hXJD5kK27J9LBgiDJITMWw4+ex1Nc2RpykysCzx6IVgHcos1MjqdbBDSdNj9IywD4qZfLq5tudhUmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PxqEuPUS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434FWl2h074117;
	Thu, 4 Apr 2024 10:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712244767;
	bh=TlztorEvC5Xvtyqcs6DGjxvXkt168hykTsxA7fh/Buo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PxqEuPUSJQuG9lFLV1WTyrPmsWAAi3w5tx+2wOtsMRFxclD7DYus/GQ6kv9lL7jUo
	 q45ZkTPQTpGZs1QK5Uenxn3AdIOa4XWYgOyOjX5Wy/vLvvnAF1bHLY3CjDletSHyHv
	 QR3thw60yptffPoqY2uWK80MyRVofFXi5zfJuSdo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434FWlC5036328
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 10:32:47 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 10:32:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 4 Apr
 2024 10:32:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 10:32:47 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434FWlql112611;
	Thu, 4 Apr 2024 10:32:47 -0500
Message-ID: <7586bb3c-1d6a-4560-9188-14bc1762d27b@ti.com>
Date: Thu, 4 Apr 2024 10:32:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate
 5% safety margin
To: Francesco Dolcini <francesco@dolcini.it>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
	<linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240403212426.582727-1-jm@ti.com>
 <20240404082814.GA8722@francesco-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240404082814.GA8722@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 4/4/24 3:28 AM, Francesco Dolcini wrote:
> Hello Judith,
> 
> On Wed, Apr 03, 2024 at 04:24:26PM -0500, Judith Mendez wrote:
>> On AM62x, the watchdog is pet before the valid window
>> is open. Fix min_hw_heartbeat and accommodate a 5% safety
> 
> Fix => Add Fixes tag + Cc:stable ?

Thanks will add for v2
~ Judith

> 
> Thanks,
> Francesco
> 


