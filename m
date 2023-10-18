Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF47CDA05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjJRLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:07:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F810E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:07:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I6ApHh011707;
        Wed, 18 Oct 2023 11:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ix6ZpUMVpeBCtPeI7PgVsnjw1IDYnRh6hsgCYDArqqk=;
 b=TCpGAlhVGzzGYHUqVAgRTfBxGW7r3l9edYesXVV8nRXNeW+y8d9IxkeffrYg9B8ArHRb
 Sljl3t6Yb7TNsThBQqVfPrFLSWChotCj3hJZPhqet9TVOoWXR710Cr41BdMuLSY+6SBy
 EBxKBsiSs4KwuWlIXPc8jrjTO6KN5WShxLG8uUh+1k2l66oOnVshHk6rqhgTfskxGs6J
 rGyXg1lnAiAO2jEdUL3emIUzR1CFDh+pQERnuTARnHSTucxUv9Cez+utssSVfVaOIbYs
 VyPWIJCtgIm/RebDKNIs2Pv006MaOx26c31pwvDP4iGOrgMr21Epd6SqMaWPaxHf27Pa MQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsvxwtc0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 11:07:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IB7fbg011157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 11:07:41 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 04:07:37 -0700
Message-ID: <62909863-5f1d-7fc7-3fd5-a8da0caa89ba@quicinc.com>
Date:   Wed, 18 Oct 2023 16:37:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mtd: spi-nor: Ensure operation completion before shutdown
Content-Language: en-US
To:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>
CC:     <tudor.ambarus@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20231012055148.2445303-1-quic_mdalam@quicinc.com>
 <bb12db1205a5d1bfbee341d23defe0be@walle.cc> <mafs034ygm9yc.fsf@kernel.org>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <mafs034ygm9yc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GawOuAzjbGeZmEDcqcMoiSnUNK6Xgh0V
X-Proofpoint-ORIG-GUID: GawOuAzjbGeZmEDcqcMoiSnUNK6Xgh0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=377 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180092
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 3:36 PM, Pratyush Yadav wrote:
> On Thu, Oct 12 2023, Michael Walle wrote:
> 
>> Hi,
>>
>> Am 2023-10-12 07:51, schrieb Md Sadre Alam:
>>> Ensure that there are no pending spi operation inprogress
>>> when system halts.
>>
>> What operation might be in progress here? Did you encounter some problems?
>> Please explain it in more detail in the commit message.
> 
> +1
> 
> Ideally we should never reach this function with a pending operation. I
> think we should do a proper wait in the place we did the operation that
> needs waiting rather than here. That would make sure operations other
> than shutdown, like reads, also work properly.
> 

   We have faced issue while doing nor flash read/write test with specific nor part.
   Will check once again with the same part and post new patch.
