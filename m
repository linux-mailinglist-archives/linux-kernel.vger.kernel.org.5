Return-Path: <linux-kernel+bounces-37083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481683AB49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E5B283C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8897A707;
	Wed, 24 Jan 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZNTxMpzg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47716604B2;
	Wed, 24 Jan 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104859; cv=none; b=Ju3xdsIQ8rtwC3+SOoFFJ4Bn+lzBlPYaBGq9msMvWBblTvEfQnEPahMRTHLqIbhh/D9ems3seFDmY2fo6Vn4mB5nl1OtHx+5aFjNsvElYmbbVUerLKGY0kEe/wFUntf8QeWmzlIabDF+5WuB0J2gWQLkUczj3qFHinF+q6Pu8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104859; c=relaxed/simple;
	bh=fPA44D5XOPR5x6jxxybEJEpGASetslc1kpu1GysoGrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i/rpjPkDwG9Ef13HwT8GgAuIT8T3MHZBtvYYCyZRyJ+x/WYbrQQNFE2SSYmhlTNNZ8+J2UhrnHDcCX6THTHmU2TTh6MjRrgDIvTLdmMXqkxp6OSwVHkm/SK4ptyrtJsiHT88t7KCmMkY1uEXRSz50bEXw+2rGSeISf432M6pWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZNTxMpzg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCYhQc023894;
	Wed, 24 Jan 2024 14:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=G3xYp+PIJ7x3NJhQcpjnJhbYVo3EpG34T9fmCmV32fg=; b=ZN
	TxMpzg/owJ1C1d4oiVLO5znQyS3jdYUGf3fr0nKImLDoelwISGaEC5tYGPInlNwB
	IY93BI/U+qXvWImHRSVS76P+/qcCQXjo1M27H0M87z67FpgXV6kGZF/RranzHqzO
	C109Je8CVfwOl8NHMgZSk/xuM74klLpTWqA7ZM9TOrWYfNEfWYKo00j+uKiAk32O
	Lb1n/dYfK2G2Sz2X6x5VqGxy7ytcGXqCSdxTrc8mqY7nr2QvyR4BewnLRre8tv7C
	4NHpbH1tak/qdmamnkGkhCH5JuDAnDUh3S5AEelaTHdLWdhUM3aQGFvz3T4tpa8W
	ZPse0c137l9FYPG4x7BQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtyxyrgx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:00:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OE0exU021811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:00:40 GMT
Received: from [10.216.1.184] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 06:00:37 -0800
Message-ID: <1e14dfa5-b920-4630-8f73-630d8984f980@quicinc.com>
Date: Wed, 24 Jan 2024 19:30:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in
 DT
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240123071523.23480-1-quic_janathot@quicinc.com>
 <48fb7356-506f-40c1-ac2e-4f43c2cbebea@molgen.mpg.de>
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <48fb7356-506f-40c1-ac2e-4f43c2cbebea@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3ZUDaEk5GwGlqbe96QcKuuk8b6Oj9uUv
X-Proofpoint-GUID: 3ZUDaEk5GwGlqbe96QcKuuk8b6Oj9uUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240101


Hi Paul Menzel,
Thanks for the review, addressed comments in-lined.

On 1/23/2024 3:08 PM, Paul Menzel wrote:
> Dear Janaki,
> 
> 
> Thank you for your patch.
> 
> 
> Am 23.01.24 um 08:15 schrieb Janaki Ramaiah Thota:
>> This change is done to avoid BT not to go UNCONFIGURED state when BDA
> 
> “This change is done to” is redundant, and can be left out.
> 
Agreed, addressed in incremental patch.
>> fwnode is not available in DT for QTI SOCs.
> 
> It’d be great if you documented the test setup exactly, on how to reproduce this.
> 
> Please also add a Fixes: tag.
> 
sure, addressed in incremental patch.
>> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 94b8c406f0c0..11d66f3e5f3f 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -7,6 +7,7 @@
>>    *
>>    *  Copyright (C) 2007 Texas Instruments, Inc.
>>    *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
>> + *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>    *
>>    *  Acknowledgements:
>>    *  This file is based on hci_ll.c, which was...
>> @@ -1904,7 +1905,17 @@ static int qca_setup(struct hci_uart *hu)
>>       case QCA_WCN6750:
>>       case QCA_WCN6855:
>>       case QCA_WCN7850:
>> -        set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> +
>> +        /* Set BDA quirk bit for reading BDA value from fwnode property
>> +         * only if that property exist in DT.
>> +         */
>> +        if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
>> +            set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> +            bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
>> +        } else {
>> +            bt_dev_info(hdev, "Not setting quirk bit for BDA");
> 
> In my opinion, the message in the else branch, should be a debug message, and should also contain that `local-bd-address` is not present in the devicetree..
> 
Agreed, addressed in incremental patch.
>> +        }
>> +
>>           hci_set_aosp_capable(hdev);
>>           ret = qca_read_soc_version(hdev, &ver, soc_type);
>>
>> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
>> prerequisite-patch-id: de5460a6c886a233feff19313b545ee6569369fb
>> prerequisite-patch-id: e18252a26d0f289afcbec18113b7f636a46a9aed
>> prerequisite-patch-id: 26e607ac96dc6d0d295793a0449a5b4c0f7ddc92
>> prerequisite-patch-id: c8d7f229399fc8075722ffe05260675ece93f691
>> prerequisite-patch-id: 554cc93ba4899eabe31585bf9591052058609d96
>> prerequisite-patch-id: 99c00a3d8d98a880c0d3a5545def0ca9ade0f903
>> prerequisite-patch-id: b1ef1add471677d1e1b60eaaab3e109abf7c7b2b
>> prerequisite-patch-id: 96131754c09914f327f353dee4daabb7ab5e6f29
>> prerequisite-patch-id: 610b5ec4a338d15cf8dba0459d5a1bfd28dccb4d
>> prerequisite-patch-id: 5172cd9d99462e123f264f0fd9a9768f2cae5498
>> prerequisite-patch-id: f57b8285516730da78089325d53f6125daaf2e6a
>> prerequisite-patch-id: 69dc26e36476660935070261f0e11cdd55c35688
>> prerequisite-patch-id: 8087dd28f6ef90fc3ad847b4bcde8a096ff721b5
>> prerequisite-patch-id: 8640fbfd7e5dcbdb4eacf5b748ea49678a2e6675
>> prerequisite-patch-id: b3613c0002cfd9cc77923f6ce781cec90a2f0cd1
>> prerequisite-patch-id: dc4f4077bfa02a5d5128bb39ef3a36dfc3db27bc
>> prerequisite-patch-id: 9c9aa8de9b4c50252d451a2dd76717c287fe1848
>> prerequisite-patch-id: 3c4a931debe7e8aa7d0b70870456421a17ff86a5
>> prerequisite-patch-id: df500031c7b6de9320021d52b060338b71340d91
>> prerequisite-patch-id: 14758d2fb4b6151aa9c27ab7e3cb8c742988f1d7
>> prerequisite-patch-id: 1c28faa0d8a4e294752229611ade87a216da0ce6
>> prerequisite-patch-id: 03680549373d9a5b0ab0e4c94260e8aaea04ef25
>> prerequisite-patch-id: cfcc27083466c9c87801628fe9c0f2131fc22dae
> 
> What to do about these lines?
> 
These are auto generated, not related to change.
> 
> Kind regards,
> 
> PPaul


