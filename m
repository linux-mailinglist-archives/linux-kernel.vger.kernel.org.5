Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A77CDA04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjJRLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjJRLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:07:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04623113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:07:23 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I5OKGP015238;
        Wed, 18 Oct 2023 11:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0ZZzJrMCnz11NTdj9q9mswUtohFFrY5CF+zPZe52VIs=;
 b=gCFwccLFIswHHl1Sj3+btNYVqhsEbgbMZAAOPT5t6tfxu9NjWkJQcAPSfAN82MyLXodw
 cEl5tOijGnh7u84/gmkf5C6QbDPxBi8Dlxs1udgzGuhZQoQDyORsQ7F5qTNSG4vXiQGs
 oZDgzPCTVFyPfyMaLxVSnRfhIuul9dkUHTKs9WQV2bNjZYEvLSmFBA5kAUMEufj8uPJH
 xxFyhbQZmxWDW6Xz+713nYr2B496yQajZuX1J3ndVCOaxslcNFDAi7w7ESEUe9FlZU/4
 LuNpjiJ7H9ED6w42g089w+b/wu7Tj2EMYjlBbDdzZWO3i2XfB4QXPBuDlt2HNiGrAk4r /w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt8xs8reb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 11:07:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IB70dk010040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 11:07:00 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 04:06:57 -0700
Message-ID: <c489e1d8-e621-df30-f424-b6dfaddbd6b7@quicinc.com>
Date:   Wed, 18 Oct 2023 16:36:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mtd: spi-nor: Ensure operation completion before shutdown
To:     Michael Walle <michael@walle.cc>
CC:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20231012055148.2445303-1-quic_mdalam@quicinc.com>
 <bb12db1205a5d1bfbee341d23defe0be@walle.cc>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <bb12db1205a5d1bfbee341d23defe0be@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RErKqp0_q_2ZBcl3Ksvz8nysHFS2zX1J
X-Proofpoint-ORIG-GUID: RErKqp0_q_2ZBcl3Ksvz8nysHFS2zX1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=696 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180092
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 2:41 PM, Michael Walle wrote:
> Hi,
> 
> Am 2023-10-12 07:51, schrieb Md Sadre Alam:
>> Ensure that there are no pending spi operation inprogress
>> when system halts.
> 
> What operation might be in progress here? Did you encounter some problems?
> Please explain it in more detail in the commit message.
> 
> Fixes tag?

   We have faced issue while doing nor flash read/write test with specific nor part.
   Will check once again with the same part and post new patch.
> 
> -michael
> 
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>  drivers/mtd/spi-nor/core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 1c443fe568cf..adc4d2c68695 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3690,6 +3690,9 @@ static void spi_nor_shutdown(struct spi_mem *spimem)
>>  {
>>      struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>>
>> +    /* Ensure no pending spi operation in progress */
>> +    spi_nor_wait_till_ready(nor);
>> +
>>      spi_nor_restore(nor);
>>  }
