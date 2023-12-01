Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A75800A8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378747AbjLAMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378681AbjLAMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:13:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49938103;
        Fri,  1 Dec 2023 04:14:00 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B17cSvb008154;
        Fri, 1 Dec 2023 12:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ey6b8Nb6xUzGGHzqYHcKuMYjKqbqWw261ABK6acpxl0=;
 b=iJ4HA6siTYMXD4qMJyIJa4FVcJEmN7JycdGrj6BqnAJijttXY2Tz1P5Xi/beXmnypGJ6
 MuT7TOej2UJNLfeaEk1YmbQQ4rV0a/MCAzgIDfmcEsFOocrYZuiOyh4862rjz73zewmj
 Cn8m2ybVfv544LB8E4h2w5y+8hiR+UZVoyOkAQ7CYGthDiF3HAJQ/6dQgAc1ETNiYLE/
 cmVrrN+fdeu1rV0rGpWOv2xYPyd2iiB1yRjsZ4VyQHcyZFqc3lRHG3E98mNM/CRqPZpG
 g7n+OxIfhytshpFb4XIbh33TQUsMkiQhfxiYR1kHbXS/dk4mzquuC3fiYJxEWel1fiWe eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq3f7sgeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 12:13:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1CDaC8007541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 12:13:36 GMT
Received: from [10.253.11.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 04:13:31 -0800
Message-ID: <50818674-e5b7-415f-a023-40611ea10850@quicinc.com>
Date:   Fri, 1 Dec 2023 20:13:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: move ufs_qcom_host_reset() to
 ufs_qcom_device_reset()
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Ziqi Chen <quic_ziqichen@quicinc.com>
CC:     <quic_asutoshd@quicinc.com>, <bvanassche@acm.org>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231025074128.GA3648@thinkpad>
 <85d7a1ef-92c4-49ae-afe0-727c1b446f55@quicinc.com>
 <c6a72c38-aa63-79b8-c784-d753749f7272@quicinc.com>
 <20231128112731.GV3088@thinkpad>
 <ed81bb9e-a9cd-4d32-bfa0-2f0d28742026@quicinc.com>
 <20231201051800.GA4009@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231201051800.GA4009@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F7grcWgsbEM9qf_ZPO2mclnFNXKptlYx
X-Proofpoint-GUID: F7grcWgsbEM9qf_ZPO2mclnFNXKptlYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_09,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 12/1/2023 1:18 PM, Manivannan Sadhasivam wrote:
> On Wed, Nov 29, 2023 at 08:10:57PM +0800, Ziqi Chen wrote:
>>
>>
>> On 11/28/2023 7:27 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Nov 28, 2023 at 03:40:57AM +0800, Ziqi Chen wrote:
>>>>
>>>>
>>>> On 11/22/2023 2:14 PM, Can Guo wrote:
>>>>>
>>>>>
>>>>> On 10/25/2023 3:41 PM, Manivannan Sadhasivam wrote:
>>>>>> On Tue, Oct 24, 2023 at 07:10:15PM +0800, Ziqi Chen wrote:
>>>>>>> During PISI test, we found the issue that host Tx still bursting after
>>>>>>
>>>>>> What is PISI test?
>>>>
>>>> SI measurement.
>>>>
>>>
>>> Please expand it in the patch description.
>>
>> Sure, I will update in next patch version.
>>
>>>
>>>>>>
>>>>>>> H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
>>>>>>> reset host before device reset to stop tx burst.
>>>>>>>
>>>>>>
>>>>>> device_reset() callback is supposed to reset only the device and not
>>>>>> the host.
>>>>>> So NACK for this patch.
>>>>>
>>>>> Agree, the change should come in a more reasonable way.
>>>>>
>>>>> Actually, similar code is already there in ufs_mtk_device_reset() in
>>>>> ufs-mediatek.c, I guess here is trying to mimic that fashion.
>>>>>
>>>>> This change, from its functionality point of view, we do need it,
>>>>> because I occasionally (2 out of 10) hit PHY error on lane 0 during
>>>>> reboot test (in my case, I tried SM8350, SM8450 and SM8550， all same).
>>>>>
>>>>> [    1.911188] [DEBUG]ufshcd_update_uic_error: UECPA:0x80000002
>>>>> [    1.922843] [DEBUG]ufshcd_update_uic_error: UECDL:0x80004000
>>>>> [    1.934473] [DEBUG]ufshcd_update_uic_error: UECN:0x0
>>>>> [    1.944688] [DEBUG]ufshcd_update_uic_error: UECT:0x0
>>>>> [    1.954901] [DEBUG]ufshcd_update_uic_error: UECDME:0x0
>>>>>
>>>>> I found out that the PHY error pops out right after UFS device gets
>>>>> reset in the 2nd init. After having this change in place, the PA/DL
>>>>> errors are gone.
>>>>
>>>> Hi Mani,
>>>>
>>>> There is another way that adding a new vops that call XXX_host_reset() from
>>>> soc vendor driver. in this way, we can call this vops in core layer without
>>>> the dependency of device reset.
>>>> due to we already observed such error and received many same reports from
>>>> different OEMs, we need to fix it in some way.
>>>> if you think above way is available, I will update new patch in soon. Or
>>>> could you give us other suggestion?
>>>>
>>>
>>> First, please describe the issue in detail. How the issue is getting triggered
>>> and then justify your change. I do not have access to the bug reports that you
>>> received.
>>
>>  From the waveform measured by Samsung , we can see at the end of 2nd Link
>> Startup, host still keep bursting after H/W reset. This abnormal timing
>> would cause the PA/DL error mentioned by Can.
>>
>> On the other hand, at the end of 1st Link start up, Host ends bursting at
>> first and then sends H/W reset to device. So Samsung suggested to do host
>> reset before every time device reset to fix this issue. That's what you saw
>> in this patch.  This patch has been verified by OEMs.
>>
> 
> Thanks for the detail. This info should have been part of the patch description.
> 
>> So do you think if we can keep this change with details update in commit
>> message. or need to do other improvement?
>>
> 
> For sure we should not do host reset within device_reset callback. I'd like to
> know at what point of time we are seeing the host burst after device reset. I
> mean can you point me to the code in the ufshcd driver that when calling
> device_reset you are seeing the issue? Then we can do a host_reset before that
> _specific_ device_reset with the help of the new vops you suggested.

Actually, anytime when we are about to reset the device, we need to 
reset host before that, because, as Ziqi mentioned, if host is still 
bursting after device is reset, it may lead to PA/DL errors. It might be 
a bit confusing, because host can be bursting some flow control frames 
and/or dummy frames even when SW thinks it is in idle state.

The reason why the PHY error cannot be easily observed is because that 
PHY error is non-fatal, it does not trigger error handling, and there is 
no logs or prints in serial console, meaning it is silent. However, we 
have error history, in which PHY error can be recorded. Although PHY 
error is non-fatal, we don't like to see any of it, because our PHY team 
and customers are requesting zero tolerance to PHY error.

Currently, there are 3 scenarios where host reset should go before 
device reset -

1. When Linux boots up, in ufshcd_hba_init(), we reset the device. In 
this case, we need to reset the host before reset the device, because 
the previous boot stage usually leave the device and host both active 
before jumping to Linux. This is the first case which this change was 
made for at the beginning.

2. When the 2nd init kicks start in ufshcd_probe_hba(), we reset the 
device. In this case, we need to reset the host before reset the device. 
This is the case which I mentioned in my previous reply.

3. In UFS error handler, we reset the device. In this case, we need to 
reset the host before reset the device.

Thanks,
Can Guo.

> 
> - Mani
> 
>>
>> -Ziqi
>>
>>>
>>> - Mani
>>>
>>>> -Ziqi
>>>>
>>>>>
>>>>> Thanks,
>>>>> Can Guo.
>>>>>>
>>>>>> - Mani
>>>>>>
>>>>>>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/ufs/host/ufs-qcom.c | 13 +++++++------
>>>>>>>     1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>>>>> index 96cb8b5..43163d3 100644
>>>>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>>>>> @@ -445,12 +445,6 @@ static int
>>>>>>> ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>>>>>>         struct phy *phy = host->generic_phy;
>>>>>>>         int ret;
>>>>>>> -    /* Reset UFS Host Controller and PHY */
>>>>>>> -    ret = ufs_qcom_host_reset(hba);
>>>>>>> -    if (ret)
>>>>>>> -        dev_warn(hba->dev, "%s: host reset returned %d\n",
>>>>>>> -                  __func__, ret);
>>>>>>> -
>>>>>>>         /* phy initialization - calibrate the phy */
>>>>>>>         ret = phy_init(phy);
>>>>>>>         if (ret) {
>>>>>>> @@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct
>>>>>>> ufs_hba *hba)
>>>>>>>     static int ufs_qcom_device_reset(struct ufs_hba *hba)
>>>>>>>     {
>>>>>>>         struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>>>>>> +    int ret = 0;
>>>>>>> +
>>>>>>> +    /* Reset UFS Host Controller and PHY */
>>>>>>> +    ret = ufs_qcom_host_reset(hba);
>>>>>>> +    if (ret)
>>>>>>> +        dev_warn(hba->dev, "%s: host reset returned %d\n",
>>>>>>> +                  __func__, ret);
>>>>>>>         /* reset gpio is optional */
>>>>>>>         if (!host->device_reset)
>>>>>>> -- 
>>>>>>> 2.7.4
>>>>>>>
>>>>>>
>>>
> 
