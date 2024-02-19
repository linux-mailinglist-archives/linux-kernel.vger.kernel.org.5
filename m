Return-Path: <linux-kernel+bounces-71181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7762585A1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3657B2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA72C197;
	Mon, 19 Feb 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L2larJ0L"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7E2C18E;
	Mon, 19 Feb 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341529; cv=none; b=R2ZDErE1V70JSO3g2InYaJIqH1V8iVlax+EqTkNgLmruWDc0YjnDjJSdtfqkHftvTMpUPb6E3ibtj7esILYkr4Y5vGLBWQKa4SblgF6Wf/V4kJ22SSkpYniEf8huJGpGQeNTw1cNxvJDpYjMQ1PAk54klQAV57EWhys3M5TMrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341529; c=relaxed/simple;
	bh=0nd4imR/9UVYqAWqTa7m9US/emkCCJFVXZAAahrjoH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cW+kVExUzXIp0Kr34hdAQKApDepeUcdsC1Sn4/qnEQu5z2AvFglYhE++T2Nkq+6klugPdopKywYVB0NMZ6YlLuHXTTdc6bHX/4ckBY5H7Q1yzmi/iENlQ3LtEN9+TAJtYTX2MVQU8IPeNhy5LeAqbcqIuP+qU1RCmRX2xKwhJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L2larJ0L; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41JBITYD006789;
	Mon, 19 Feb 2024 05:18:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708341509;
	bh=9xUmo2B41yjBWIaIJX0UyynYUxbiLTtssr1IxtlStFU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L2larJ0LNOWMJ4MyYNb+JtZiuFcMJLa5L++6b7V6SiDvZS9nV2JFjE9EIsrJk8oat
	 JfvLo5hb/i4+96Jp+RH3zsQSV/HJkHtqT7mXysdqShIdsIWil7VBNtXf6AC96Xiwlg
	 2V/2+fWIVHZ4+gi1w5WyKFl8k5cTUXOYBocLHCFc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41JBITdM026167
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 05:18:29 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 05:18:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 05:18:29 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41JBIRof083669;
	Mon, 19 Feb 2024 05:18:28 -0600
Message-ID: <1d7a15be-dfcf-4c1c-a381-6e76c8840603@ti.com>
Date: Mon, 19 Feb 2024 16:48:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the spi tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next
 Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap
	<rdunlap@infradead.org>
References: <20240216141110.7819d939@canb.auug.org.au>
Content-Language: en-US
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240216141110.7819d939@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 16/02/24 08:41, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the spi tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/spi/spi-summary.rst:274: WARNING: Title underline too short.
> 
> Declare target Devices
> ^^^^^^^^^^^^^^^^^^^^^
> 
> Introduced by commit
> 
>    99769a52464d ("spi: Update the "master/slave" terminology in documentation")
> 

This is a known issue with a Fix pending to be merged [0]. Thanks for
reporting.

[0] 
https://lore.kernel.org/linux-spi/20240216051637.10920-1-rdunlap@infradead.org/

-- 
Thanks and Regards,
Dhruva Gole

