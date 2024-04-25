Return-Path: <linux-kernel+bounces-158014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5158B1A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE3A1C214F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF83A28D;
	Thu, 25 Apr 2024 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fhLlvLAc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5D23CE;
	Thu, 25 Apr 2024 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021776; cv=none; b=iGOmjUUUN9Mz1gkUz0bc6F0aSoDLMLTfVA7M06hBZoYsdgqTO+mXzGS9ufWXU1NG7otK67bwqitd+Z6aMJo0KGg17OUHBDUbsD2ZYpfm4VtGLksqLB1+1doQSqr/UdaLBeBIge6I3AzM5zAL7aEWyFe6A7m25SJFvL6MfDcPenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021776; c=relaxed/simple;
	bh=btL2U0xX8vOa3CUE0RGK83zpb2weZMhXS7KZYm21kNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PuUKLXCyuNyOZYSEugQnZ9CSSIcawIomputLKtC3LY2jmmSK/KKLZGiSXbE/7OqN5HqaaslDbXe8L5pWZ0HxLMnX1GNGBSM8hV7N1UtSKRTSPLZAHqpEUvHacyHO4SMOtcBKDdFtZ8Ee7qD14d6O8L7rXoeGBnkkgNpEgcke2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fhLlvLAc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43P59Mdm031618;
	Thu, 25 Apr 2024 00:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714021762;
	bh=abCh8DJAQ8EITF5dNI93dkBuAr1ujFzQM9OnIyIGsoY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fhLlvLAcGS8HMNys+wT5KisP/ZvAPNom+9RmsRSApuaX2MbE1lHobFtsier8+tKaN
	 bpRPsAWTuKwsLErQor1u8sKLW9wSRknW4LhAJ0OPm/moFwQTqfCa2wmLEk1aLPqoyH
	 IPyIUVwGGNdcOfiSux7MIOVLfe+qQbp+ZLCDt9Wk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43P59Mra101601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 00:09:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 00:09:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 00:09:22 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43P59HJg113693;
	Thu, 25 Apr 2024 00:09:18 -0500
Message-ID: <d5b1864b-9756-92f0-ba32-1009aa89e83d@ti.com>
Date: Thu, 25 Apr 2024 10:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message
 type on TX packets
To: "Trexel, Ed" <ed.trexel@hp.com>,
        "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "jreeder@ti.com" <jreeder@ti.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srk@ti.com"
	<srk@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240424071626.32558-1-r-gunasekaran@ti.com>
 <MW5PR84MB157272BC110ED170C35983F790172@MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <MW5PR84MB157272BC110ED170C35983F790172@MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Ed,

On 4/25/24 7:06 AM, Trexel, Ed wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com> 
> Sent: Wednesday, April 24, 2024 1:16 AM
> To: s-vadapalli@ti.com; rogerq@kernel.org; r-gunasekaran@ti.com
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; richardcochran@gmail.com; jreeder@ti.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; srk@ti.com; Trexel, Ed <ed.trexel@hp.com>
> Subject: [PATCH net v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets
> 
> CAUTION: External Email 
> From: Jason Reeder <mailto:jreeder@ti.com>
> 
> The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
> field from the second nibble of the PTP header which is defined in the
> PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
> the first two bytes of the PTP header are defined as the versionType
> which is always 0x0001. This means that any PTPv1 packets that are
> tagged for TX timestamping by the CPTS will have their messageType set
> to 0x0 which corresponds to a Sync message type. This causes issues
> when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
> timestamp that never appears.
> 
> Fix this by checking if the ptp_class of the timestamped TX packet is
> PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
> sequence ID in the skb->cb data structure. If the sequence IDs match
> and the packet is of type PTPv1 then there is a chance that the
> messageType has been incorrectly stored by the CPTS so overwrite the
> messageType stored by the CPTS with the messageType from the skb->cb
> data structure. This allows the PTPv1 stack to receive TX timestamps
> for Delay_Req packets which are necessary to lock onto a PTP Leader.
> 
> Fixes: f6bd59526ca5 ("net: ethernet: ti: introduce am654 common platform time sync driver")
> Signed-off-by: Jason Reeder <mailto:jreeder@ti.com>
> Signed-off-by: Ravi Gunasekaran <mailto:r-gunasekaran@ti.com>
> Tested-by: Ed Trexel <ed.trexel@hp.com>

Seems like your email client is not configured as per guidelines [1].
Also Tested-by reply is not inline with norm.

Once your mail client is configured correctly, could you please reply
with your "Tested-by" tag to the original patch mail?

[1] - https://www.kernel.org/doc/html/v4.10/process/email-clients.html 

-- 
Regards,
Ravi

