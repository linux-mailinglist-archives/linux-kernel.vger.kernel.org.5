Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC757FD658
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjK2MLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjK2MLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:11:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838991;
        Wed, 29 Nov 2023 04:11:18 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3uKuP002226;
        Wed, 29 Nov 2023 12:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H8dxU3Vbz0VvqHA8k92Dxes+Cij9co3fEKTRyiRMwrg=;
 b=F749q/Knjg++vNPKI6eslANkLcw2G7+HiSRfnjZmwsRDuLQDLGjHQOMzr3s5zUzThjD9
 PvC20TdPtqwNxSpgYAR+bGWcGMsMuA4OBWek37AOQ4JqiwBA/qDoRL+vNDfTbmKBzdQs
 Kg3viJ0DbZeyf3Dz6v/YTtTWdFEHBfYUPBTEhRqMonX/VO/Bf/7bjI7h8/K6EEVPvXvK
 /s93nzfibU/Vr0+Tkdgai43oUP8xt7zrKvyYFsRHG7WwflMoGXA6VfSi+FaDnSOc/Slf
 JslKZBaNcpvQC066OItKxz9F+y7Ye+1JWbeE+nUYTjeVBDaaLqDhbwXlE284NEvYNXE4 bw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unkentk9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:11:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATCB48Z011399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:11:04 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 04:11:00 -0800
Message-ID: <ed81bb9e-a9cd-4d32-bfa0-2f0d28742026@quicinc.com>
Date:   Wed, 29 Nov 2023 20:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: move ufs_qcom_host_reset() to
 ufs_qcom_device_reset()
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Can Guo <quic_cang@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <bvanassche@acm.org>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
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
Content-Language: en-US
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20231128112731.GV3088@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uEMP9tTrfa0UqBAUXpy-3MfyJwwt4ySq
X-Proofpoint-ORIG-GUID: uEMP9tTrfa0UqBAUXpy-3MfyJwwt4ySq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 7:27 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 28, 2023 at 03:40:57AM +0800, Ziqi Chen wrote:
>>
>>
>> On 11/22/2023 2:14 PM, Can Guo wrote:
>>>
>>>
>>> On 10/25/2023 3:41 PM, Manivannan Sadhasivam wrote:
>>>> On Tue, Oct 24, 2023 at 07:10:15PM +0800, Ziqi Chen wrote:
>>>>> During PISI test, we found the issue that host Tx still bursting after
>>>>
>>>> What is PISI test?
>>
>> SI measurement.
>>
> 
> Please expand it in the patch description.

Sure, I will update in next patch version.

> 
>>>>
>>>>> H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
>>>>> reset host before device reset to stop tx burst.
>>>>>
>>>>
>>>> device_reset() callback is supposed to reset only the device and not
>>>> the host.
>>>> So NACK for this patch.
>>>
>>> Agree, the change should come in a more reasonable way.
>>>
>>> Actually, similar code is already there in ufs_mtk_device_reset() in
>>> ufs-mediatek.c, I guess here is trying to mimic that fashion.
>>>
>>> This change, from its functionality point of view, we do need it,
>>> because I occasionally (2 out of 10) hit PHY error on lane 0 during
>>> reboot test (in my case, I tried SM8350, SM8450 and SM8550， all same).
>>>
>>> [    1.911188] [DEBUG]ufshcd_update_uic_error: UECPA:0x80000002
>>> [    1.922843] [DEBUG]ufshcd_update_uic_error: UECDL:0x80004000
>>> [    1.934473] [DEBUG]ufshcd_update_uic_error: UECN:0x0
>>> [    1.944688] [DEBUG]ufshcd_update_uic_error: UECT:0x0
>>> [    1.954901] [DEBUG]ufshcd_update_uic_error: UECDME:0x0
>>>
>>> I found out that the PHY error pops out right after UFS device gets
>>> reset in the 2nd init. After having this change in place, the PA/DL
>>> errors are gone.
>>
>> Hi Mani,
>>
>> There is another way that adding a new vops that call XXX_host_reset() from
>> soc vendor driver. in this way, we can call this vops in core layer without
>> the dependency of device reset.
>> due to we already observed such error and received many same reports from
>> different OEMs, we need to fix it in some way.
>> if you think above way is available, I will update new patch in soon. Or
>> could you give us other suggestion?
>>
> 
> First, please describe the issue in detail. How the issue is getting triggered
> and then justify your change. I do not have access to the bug reports that you
> received.

 From the waveform measured by Samsung , we can see at the end of 2nd 
Link Startup, host still keep bursting after H/W reset. This abnormal 
timing would cause the PA/DL error mentioned by Can.

On the other hand, at the end of 1st Link start up, Host ends bursting 
at first and then sends H/W reset to device. So Samsung suggested to do 
host reset before every time device reset to fix this issue. That's what 
you saw in this patch.  This patch has been verified by OEMs.

So do you think if we can keep this change with details update in commit 
message. or need to do other improvement?


-Ziqi

> 
> - Mani
> 
>> -Ziqi
>>
>>>
>>> Thanks,
>>> Can Guo.
>>>>
>>>> - Mani
>>>>
>>>>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>>>>> ---
>>>>>    drivers/ufs/host/ufs-qcom.c | 13 +++++++------
>>>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>>> index 96cb8b5..43163d3 100644
>>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>>> @@ -445,12 +445,6 @@ static int
>>>>> ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>>>>        struct phy *phy = host->generic_phy;
>>>>>        int ret;
>>>>> -    /* Reset UFS Host Controller and PHY */
>>>>> -    ret = ufs_qcom_host_reset(hba);
>>>>> -    if (ret)
>>>>> -        dev_warn(hba->dev, "%s: host reset returned %d\n",
>>>>> -                  __func__, ret);
>>>>> -
>>>>>        /* phy initialization - calibrate the phy */
>>>>>        ret = phy_init(phy);
>>>>>        if (ret) {
>>>>> @@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct
>>>>> ufs_hba *hba)
>>>>>    static int ufs_qcom_device_reset(struct ufs_hba *hba)
>>>>>    {
>>>>>        struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    /* Reset UFS Host Controller and PHY */
>>>>> +    ret = ufs_qcom_host_reset(hba);
>>>>> +    if (ret)
>>>>> +        dev_warn(hba->dev, "%s: host reset returned %d\n",
>>>>> +                  __func__, ret);
>>>>>        /* reset gpio is optional */
>>>>>        if (!host->device_reset)
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>>
> 
