Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29B787D82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjHYCFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbjHYCFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:05:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F71BD1;
        Thu, 24 Aug 2023 19:04:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P1UHE6031609;
        Fri, 25 Aug 2023 02:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=72NcHc3TExHejWIwg+3LuxNxMSFBD3W1+j4RzHBoI0M=;
 b=RgeNb07oUF1kkDbvLrQ7JeIsGoGwWK0OcgREaJkzaJwnMxhJ3h80r1Oi5ye979usQJfP
 xWLkxj9Amk5uT47WEKi26oPYL1ClJvVRjo84pmOtl4KL3bwG9BCdrz2/miFEj1qK9njn
 mVzukYIHeNRB+nI0cmCFMXD+qTC+V7Q/YAYu43j4MIKJTDv2IdI6Xw7pOAlKmGwDQ29/
 8JIFCCCHEO710oDfZDfB4XcdU6Zy62Bb93X2f8vz8SjEOKuf9jBEukpU8hRLl4Lnh+W2
 172SwicugBM1TSDUoIdVU7UHuKDkjK8Nz2RYI7Swao8o6niA3GVlOar174URsYBjIaJS 7g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1r3tjj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 02:03:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37P23sRG016781
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 02:03:54 GMT
Received: from [10.253.13.154] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 19:03:52 -0700
Message-ID: <086314e1-415f-1ec6-9087-5f54b988398e@quicinc.com>
Date:   Fri, 25 Aug 2023 10:03:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v2] mhi: host: Add standard ELF header image download
 functionality
To:     Kalle Valo <kvalo@kernel.org>
CC:     <mani@kernel.org>, <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1691395192-16090-1-git-send-email-quic_qianyu@quicinc.com>
 <87edjvwb0a.fsf@kernel.org>
Content-Language: en-US
In-Reply-To: <87edjvwb0a.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9MEPGzvL-_Xmkp-5Y7scP0jV-Jm95CfY
X-Proofpoint-GUID: 9MEPGzvL-_Xmkp-5Y7scP0jV-Jm95CfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250016
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/22/2023 7:51 PM, Kalle Valo wrote:
> Qiang Yu<quic_qianyu@quicinc.com>  writes:
>
>> From: Mayank Rana<quic_mrana@quicinc.com>
>>
>> Some devices (e.g. WLAN chips) are unable to handle the non-standard ELF
>> format of the FBC image and thus need special handling of the FBC image.
>>
>> Add standard_elf_image flag which makes decision in terms of how FBC image
>> based AMSS image is being downloaded with connected endpoint.
>> FBC image is having two image combine: SBL image + AMSS image.
>> 1. FBC image download using legacy single ELF header image format:
>> - SBL image: 512KB of FBC image is downloaded using BHI.
>> - AMSS image: full FBC image is downloaded using BHIe.
>> 2. FBC image download using separate ELF header image format:
>> - SBL image: 512 KB of FBC image is downloaded using BHI.
>> - AMSS image: 512 KB onward FBC image is downloaded using BHIe.
>> There is no change for SBL image download. Although AMSS image start
>> address is end address of SBL image while using separate ELF header format.
>>
>> Signed-off-by: Mayank Rana<quic_mrana@quicinc.com>
>> [quic_qianyu@quicinc.com: Update commit message, minor updates]
>> Signed-off-by: Qiang Yu<quic_qianyu@quicinc.com>
> I guess this is for an out-of-tree driver? I haven't heard any such
> requirements for ath11k or ath12k.
Yes, this is for next generation wlan chip. After confirming with WLAN 
team, we will hold this patch until WLAN team upstream the driver for 
next generation wlan chip.
>> --- a/drivers/bus/mhi/host/boot.c
>> +++ b/drivers/bus/mhi/host/boot.c
>> @@ -495,6 +495,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>>   	 * device transitioning into MHI READY state
>>   	 */
>>   	if (mhi_cntrl->fbc_download) {
>> +		dev_dbg(dev, "standard_elf_image: %s\n",
>> +				(mhi_cntrl->standard_elf_image ? "True" : "False"));
>> +		if (mhi_cntrl->standard_elf_image) {
>> +			fw_data = firmware->data + mhi_cntrl->sbl_size;
>> +			fw_sz = fw_sz - mhi_cntrl->sbl_size;
>> +		}
> So you are basically skipping the first sbl_size bytes of the firmware
> file? Why not just fix the firmware file in userspace? Or maybe you can
> use the recently added[1] mhi_cntrl->fw_data pointer and handle this in
> your driver instead?

Thanks for your suggestions. As per Mayank, with current method, we are 
able to accommodate new image request better way with less code change, 
and satisfy processing of RDDM without any modification.

Maybe we can revisit it when the driver for next gen wlan driver comes 
in picture.

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?h=mhi-next&id=efe47a18e43f59f063a82ccaa464a3b4844bb8a8
>
