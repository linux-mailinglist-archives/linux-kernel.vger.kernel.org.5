Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44FC7AE624
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjIZGkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjIZGkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:40:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49797AF;
        Mon, 25 Sep 2023 23:40:11 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q58NuB030917;
        Tue, 26 Sep 2023 06:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T8mV7AkFQM0nhzBiFcBjsEXg08CoxMbkHo1NRZn7xQY=;
 b=KHqZsvg3k6k3cNmAK0q/nf8JTs8hQwNSi1rR6Cq1oQLhxSu5EbKtFv3C+lycVXZeJODw
 NcfMHgBDsbue0O2kjRmX4Ebtz3nuGSTxnNNZeQT84m1G3I0KIVKyoHVTH13ntixuEDK8
 Sq0lMChQe9sO/cEa6j3bDyEbfmUgZ1ezXRwthEzjWMluvosNlJALHj0gYLAYpV1EAZqz
 r7d3EoOIdLMrmyKzzpvREaUY46mHDf20BfrrH4APcYFRanr6CFoSqMs2IWFIIEDFSE2S
 3rsPCKpWMae8wHyEtpEPTB8a2UqRjNGRQy3bcOndJuy2vwkdJGF9oAfNlpcJThNgProW qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexgh52m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 06:39:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q6dRpP031713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 06:39:27 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 23:39:21 -0700
Message-ID: <c06480b1-95e3-49cd-9498-5c7c5f1deabe@quicinc.com>
Date:   Tue, 26 Sep 2023 12:09:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Veerabhadrarao Badiganti" <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
 <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
 <ea318551ec0b43429ce47bfac9ebf285@quicinc.com>
 <CAPDyKFq2-Jwii_aMbsqYNM_Dq0-MMEEtUYnNKGbQgvDL+M-wdw@mail.gmail.com>
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <CAPDyKFq2-Jwii_aMbsqYNM_Dq0-MMEEtUYnNKGbQgvDL+M-wdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uTYgw018y0xzFoxeI5THTAQi7phhsQRY
X-Proofpoint-GUID: uTYgw018y0xzFoxeI5THTAQi7phhsQRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_04,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=899
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2022 4:18 AM, Ulf Hansson wrote:
> On Tue, 24 May 2022 at 07:37, Sarthak Garg (QUIC)
> <quic_sartgarg@quicinc.com> wrote:
>> Hi Ulf,
>>
>> Please find the gains seen on micron and kingston eMMC parts below with partial initialization feature (These are the averaged numbers) :
>>
>> 1) Micron eMMC (ManfID 0x13)
>>
>> Partial init                            Full Init
>>
>> a) _mmc_resume:                         _mmc_resume :
>>
>> Total time : 62ms                       Total time : 84ms
>> (Decrease % from full init = ~26%)
> Alright, so we gained around 22ms. Not too bad.
>
>> Breakup :
>> mmc_claim_host_time: 0.2ms              mmc_claim_host_time: 0.1ms
>> mmc_power_up_time: 33ms         mmc_power_up_time: 33ms
>> mmc_sleepawake_time: 28ms               mmc_init_card_time: 50ms
>> mmc_partial_init_time: 1ms
>>
>> b) _mmc_suspend:                        _mmc_suspend:
>>
>> Total time: 5ms                         Total time: 7.5ms
>> mmc_claim_host_time: 0.5ms              mmc_claim_host_time: 1ms
>> mmc_flush_cache_time : 1.5 ms   mmc_flush_cache_time : 2.5 ms
>> mmc_sleep_time: 1.5ms           mmc_sleep_time: 2ms
>> mmc_power_off_time: 1.5ms               mmc_power_off_time: 1.5ms
> The suspend time shouldn't really differ. Or is there a reason for this?


I think this could be due to run to run variation as we can see 
mmc_claim_host and mmc_flush_cache itself taking some extra 1ms.


>
>>
>> 2) Kingston eMMC (ManfID 0x70)
>>
>> Partial init                            Full Init
>>
>> a) _mmc_resume:                 _mmc_resume :
>> Total time : 46ms                       Total time : 62ms
>> (Decrease % from full init = ~25%)
>>
>> Breakup :
>> mmc_claim_host_time: 0.2ms              mmc_claim_host_time: 0.2ms
>> mmc_power_up_time: 30ms         mmc_power_up_time: 30ms
>> mmc_sleepawake_time: 14ms               mmc_init_card_time: 31ms
>> mmc_partial_init_time: 2ms
>>
>>
>> b) _mmc_suspend:                        _mmc_suspend:
>> Total time : 5ms                        Total: 5ms
>>
>> Breakup :
>> mmc_claim_host_time: 0.5ms              mmc_claim_host_time: 0.5ms
>> mmc_flush_cache_time : 1.5 ms   mmc_flush_cache_time : 1.5 ms
>> mmc_sleep_time: 1.5ms           mmc_sleep_time: 1ms
>> mmc_power_off_time: 1.5ms               mmc_power_off_time: 1.5ms
>>
>> Did some minor modifications as well to this patchset as per avri's comment which I'll post as V2.
>> Please let me know your inputs about these numbers.
> Thanks for posting these numbers, much appreciated! Please try to
> include some of the data as part of the commit message as I think it's
> valuable information.
>
> When it comes to reviewing the code, I am awaiting your v2 then.
>
> [...]
>
> Kind regards
> Uffe

Sure will add this data to the commit text in V2.


