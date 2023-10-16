Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075657CB6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjJPWwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJPWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:52:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919095;
        Mon, 16 Oct 2023 15:52:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GLH7hi016583;
        Mon, 16 Oct 2023 22:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aTf3anfLH8/yKr6bETOnY4WCnCGyzbit9cJjSDMWkw0=;
 b=nwLgnPAttkUiCNQTVJraOAOXNEaU3VI5na8RhOUuB0J704jXlifrRKlSzw2ZOs+MjJSR
 /3fptKrT1KHj+TqPbLp1k7Q3QOz+MAL9OOmQ2orY7zjOwaW7Ihv+jjMHmHgliebNGEmi
 ktOkrc8PcKcpgCcDUAyPt5NydFmQ8WVLzZArGjUhAmwf1IvAG+94MqZHCQ/oQcAeMfm6
 SchpP8+oGDLQtvcd7yQpcDgFmsD3cnUzp5TLbp6yWvGz6kve8jGvjQ3LU+ez7ukykvFg
 mmJFy1HsZLdkl0cVFPL0zlLGpwmOqap75o/0FgNauHrMXuoBzaxhYDuhBmDjTZN6ElER Hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts0xkt649-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 22:51:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39GMplUK012901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 22:51:47 GMT
Received: from [10.48.240.22] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 16 Oct
 2023 15:51:47 -0700
Message-ID: <32ab8646-d41d-4dd2-a8c8-93845f198462@quicinc.com>
Date:   Mon, 16 Oct 2023 15:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: use vmm_table as array in wilc struct
Content-Language: en-US
To:     =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        <stable@vger.kernel.org>
References: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
 <bb95048f-2540-4d42-abb2-3132d33cd6c3@quicinc.com>
 <74eac5f2-228b-4775-a101-53b2fdd5bf86@bootlin.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <74eac5f2-228b-4775-a101-53b2fdd5bf86@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MGT4cR8Hr7M8hEnoqiQSu19wzUAKNlZz
X-Proofpoint-ORIG-GUID: MGT4cR8Hr7M8hEnoqiQSu19wzUAKNlZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=679 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2023 2:23 PM, Alexis Lothoré wrote:
> Hello Jeff,
> 
> On 10/16/23 17:26, Jeff Johnson wrote:
>> On 10/16/2023 1:29 AM, Alexis Lothoré wrote:
>>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c
>>> b/drivers/net/wireless/microchip/wilc1000/wlan.c
>>> index 58bbf50081e4..e4113f2dfadf 100644
>>> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
>>> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
>>> @@ -1492,7 +1492,7 @@ int wilc_wlan_init(struct net_device *dev)
>>>        }
>>>          if (!wilc->vmm_table)
>>> -        wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
>>> +        wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE * sizeof(u32), GFP_KERNEL);
>>
>> this is probably OK since the values are constant, but kcalloc() is generally
>> preferred
> 
> Ok, I can submit a new version with kcalloc. One thing that I do not understand
> however is why checkpatch.pl remains silent on this one. I guess it should raise
> the ALLOC_WITH_MULTIPLY warning here. I tried to dive into the script to
> understand why, but I drowned in regexes (and Perl, with which I am not familiar
> with). Could it be because of both sides being constant ?

I also drown when looking at checkpatch.pl -- so many "write-only" 
regexes! But I think the following is what excludes your patch:
$r1 =~ /^[A-Z_][A-Z0-9_]*$

It is a compile-time constant so the compiler can flag on overflow, so 
it's your call to modify or not.

/jeff
