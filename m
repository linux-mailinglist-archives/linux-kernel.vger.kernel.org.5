Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C479E078
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjIMHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjIMHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:09:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8ADF;
        Wed, 13 Sep 2023 00:09:09 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D6eLGe012023;
        Wed, 13 Sep 2023 07:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nbXt39d+Uly5Prlmsw8HTG2GrjIJiHnSfcz+v/XS12Y=;
 b=kz2Y1XsrHUeKwbroTWpqOpdNA3x3b/ZH3U9AvnMuCHan6iv5oenKawH8KBoIz4uV2oUj
 QLn07+Iz+zb4gS9p0GwDi5zRlPsEtqtjEDhuDfJRTGWncbRffvRvOJEWQHvV6u/SCyCU
 LeKJtiorHK6bUzmy4nu9TXG23fAmlW0ktGyxEvAK4JcWVId1i90MdnrxXOVKCxSM0mQ2
 WSYV+1DrzZYSs5cz4BgB6NBKFr/Qyqv8ZDnyu/B0TUCTjtOICWgrzPOsaUkfcRQeyEaA
 5/aRKVVvlovQ2nGMQhtBhEPvqa5hiXmsAw1kI3Z05VybNQ5n+30RI8HAbS54atXwb7TL UA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8q0x58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 07:09:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D78xbK028098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 07:08:59 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 13 Sep
 2023 00:08:53 -0700
Message-ID: <6e1ab09c-6eb0-4e70-a97d-2b96f095d7a7@quicinc.com>
Date:   Wed, 13 Sep 2023 12:38:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mtd: rawnand: qcom: Unmap the right resource upon
 probe failure
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_charante@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_pkondeti@quicinc.com>
References: <20230912115903.1007-1-quic_bibekkum@quicinc.com>
 <20230912142847.4610c0a0@xps-13>
 <5e80e600-b523-476a-81bd-93d2c517b7b6@quicinc.com>
 <20230912143726.GE6404@thinkpad>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20230912143726.GE6404@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rOdNNTYoqFsrUD7Y6yU-GG5R_MU-Q-A7
X-Proofpoint-GUID: rOdNNTYoqFsrUD7Y6yU-GG5R_MU-Q-A7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=588 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 8:07 PM, Manivannan Sadhasivam wrote:
> On Tue, Sep 12, 2023 at 08:02:07PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 9/12/2023 5:58 PM, Miquel Raynal wrote:
>>>> We currently provide the physical address of the DMA region
>>>> rather than the output of dma_map_resource() which is obviously wrong.
>>>>
>>>> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
>>> Cc: stable?
>> Cc: stable@vger.kernel.org
> 
> You need to send another version adding the CC tag.

Sure Mani, sent a new patch with cc tag. Addressed in v5 patchset.

> 
> With the tag added,
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 

Added in v5 patch.

> - Mani
> 

Thanks & regards,
Bibek
