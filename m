Return-Path: <linux-kernel+bounces-154946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4A8AE366
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885301C220AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680A76056;
	Tue, 23 Apr 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qDRsJJb0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424ED757EE;
	Tue, 23 Apr 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870408; cv=none; b=ZWTfVGW17S+zQtzcwCHZOpBmhL8PR2Ap0F4DOA7mZJKWFpo3dEaXcR0mWNcqnZ4KqUYec9esuCjR1XCylH0ln/G8bIUMI8ecurXjzIb/CxOZGWX59h1zAVtBbUwK/xKjF6FSkKkbZ+FkiPmKNcYJk6IF9B3797GfZYS1S8ntirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870408; c=relaxed/simple;
	bh=xi+p9Aq+rLkwX64YbZih1zn1N7OINid8fRd3s6RwH6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dCpeliCI7riIWRHhVBbLvOnaa7T760NhV8gGnEWpD8szVZBUP62pD7XwSc/lvpfFkYhQw0bSzgGdDbNLyRytsGT0G5XR8A8R8ceMimZGdPu2+cF40/B5vz61wb0We1l0AjnWFyYAZhyGcM2wTLtzitF3Gx0JdRbDm1jROKCIRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qDRsJJb0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NB6UnV073180;
	Tue, 23 Apr 2024 06:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713870390;
	bh=XSNBGgTi8rj9WzeNTLXIKZPG5fboAicbyYRXMZYYjpw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qDRsJJb0E789F2YGFYK3VCtIe3E3IbWm/Lxji3FQ7DI0FUAK+YDgRFSuYgdO3Dw0J
	 FNR/j+0uNUlZjjGMor/DeJxPJ+m3u7QadWfHUKQ7jWX4PKvepENSv2RzI6uuQ1Rbgm
	 GvU0dZCA69+WZVokTG8Nnhvv+/oXp5RPYWz7LteQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NB6UJa025529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 06:06:30 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 06:06:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 06:06:29 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NB6PEK039021;
	Tue, 23 Apr 2024 06:06:25 -0500
Message-ID: <52c7352f-a91b-3604-5ae0-88d7bb814e51@ti.com>
Date: Tue, 23 Apr 2024 16:36:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: Fix PTPv1 message type
 on TX packets
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <s-vadapalli@ti.com>, <rogerq@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <richardcochran@gmail.com>, <jreeder@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240419080547.10682-1-r-gunasekaran@ti.com>
 <4a92f794480b12c21eaeeeb66521dbe978f08414.camel@redhat.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <4a92f794480b12c21eaeeeb66521dbe978f08414.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Paolo,

On 4/23/24 3:31 PM, Paolo Abeni wrote:
> On Fri, 2024-04-19 at 13:35 +0530, Ravi Gunasekaran wrote:
>> From: Jason Reeder <jreeder@ti.com>
>>
>> The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
>> field from the second nibble of the PTP header which is defined in the
>> PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
>> the first two bytes of the PTP header are defined as the versionType
>> which is always 0x0001. This means that any PTPv1 packets that are
>> tagged for TX timestamping by the CPTS will have their messageType set
>> to 0x0 which corresponds to a Sync message type. This causes issues
>> when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
>> timestamp that never appears.
>>
>> Fix this by checking if the ptp_class of the timestamped TX packet is
>> PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
>> sequence ID in the skb->cb data structure. If the sequence IDs match
>> and the packet is of type PTPv1 then there is a chance that the
>> messageType has been incorrectly stored by the CPTS so overwrite the
>> messageType stored by the CPTS with the messageType from the skb->cb
>> data structure. This allows the PTPv1 stack to receive TX timestamps
>> for Delay_Req packets which are necessary to lock onto a PTP Leader.
>>
>> Signed-off-by: Jason Reeder <jreeder@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> Please provide a suitable fixes tag, thanks!

am65_cpts_match_tx_ts() was added in the very first commit of the file.
Would that be a suitable fixes tag? I understand that the purpose of
the fixes tag is to know to which all previous kernels, the fix needs to
be applied. 

Please let me know, if it is ok to provide first commit as fixes tag, so that
I can send a v2.

> 
> Paolo
> 

-- 
Regards,
Ravi

