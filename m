Return-Path: <linux-kernel+bounces-61990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 795EE8519B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196E7B23CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089404644E;
	Mon, 12 Feb 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GOe2IcUq"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB145C14;
	Mon, 12 Feb 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755624; cv=none; b=Ajn5o4KWHeSHT/9XoDjAwwFEPEiUWeQpRtqMupL6bOThD/1JfxqRPZDpQtFDHXHoPrphnpve6LE4YKiXqI3GVGUC3+NoPS5MXEdJvryXfyER5aIw6nEDIgyybeU5kkzpra7XOR19Eiqs11MIxEM1MaEGD1/aUvlE2V+nccx8YmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755624; c=relaxed/simple;
	bh=OLThqie85gVmR9Yab/ZQoqebv/8yoVw1DTXtYOQrMqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HxeOaNV+5KRhflWffGrtIem3673CkvxMgbKh7GTf9Milugr8Nv1kbGpo0N1+wGl71QOr2yQdXOFxGQgOrH5cLcVShxGptoiVKX6lHhW5h9vsF7XBVfK+MKwXdqynBW3s8PrzJXydCMFSWUwn0lyt3vcr0a/qA1OAVs3oGDzktVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GOe2IcUq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGXZHd046969;
	Mon, 12 Feb 2024 10:33:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755615;
	bh=bdglKLiBxmLh/P0SiwOI9VL6Pidk0MGz17YLEmcXpGI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GOe2IcUqEWf7zfR31dzGKT47L44vP6zMpF2pdtKYchA/I8QKoAA9MfCPp+mb/5xxu
	 Bq1lx2xH+ATMvzjDg1+d0fhaqVfMwKGvBNEGk7JmBOT2pInE2NTAh9IZSlViLHp75c
	 N4vDm7V6ic0cCJH1KY0dhvT5aSBWkuF2IJlJX5ZQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGXZHB030501
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:33:35 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:33:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:33:35 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGXZMU094696;
	Mon, 12 Feb 2024 10:33:35 -0600
Message-ID: <7482f19f-b340-482f-bdf6-a5a68aeaf09e@ti.com>
Date: Mon, 12 Feb 2024 10:33:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add tuning algorithm for delay chain
To: Francesco Dolcini <francesco@dolcini.it>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240211160232.GB4443@francesco-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240211160232.GB4443@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 2/11/24 10:02 AM, Francesco Dolcini wrote:
> On Tue, Feb 06, 2024 at 07:15:13PM -0600, Judith Mendez wrote:
>> This patch series introduces a new tuning algorithm for
>> mmc. The new algorithm should be used when delay chain is
>> enabled. The ITAPDLY is selected from the largest passing
>> window and the buffer is not viewed as a circular buffer.
>> The new tuning algorithm is implemented as per the paper
>> published here [0] and has been tested on the following
> 
> Where is this `[0]`?

I must have missed linking the ref doc here, will add in next
iteration, thanks.

> 
>> platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
>> EVM.
> 
> In the other patches you link some document, but I was not able to find
> anything related to AM62, can you provide some reference on this
> specific SOC?

This patch series fixes issues that affect all Sitara SoCs, not only
AM62x. However, I could use AM62x for reference, no problem.

> 
> Francesco
> 

~ Judith

