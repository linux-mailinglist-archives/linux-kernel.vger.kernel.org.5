Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63450806F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377847AbjLFMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377949AbjLFMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:09:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D22D49;
        Wed,  6 Dec 2023 04:09:55 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68UWbM023863;
        Wed, 6 Dec 2023 12:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qDPW16CDpQAQqVtpr+vo+lAJt5DFMG8RCtl43Bfif2o=;
 b=LjsxT+x0f/htqjRQCSRs6PROIdh5QqkN+RzZpKhIRoi1bzS3umMK9QKreC/QnZ4efskc
 hOqxoL1dOvUkZ7yRGvsZOuSiD0Ze3NfvLvtK3lJh+6qgPAorqQXO8b426HHICBWm34u2
 LSiOLC/nKHCaScubLlAtWWBLDR/7jRLczsBmfhnrW6CpuQdCGjWo6aQbRIf+wSkoRt1/
 M4Lc9JjTeK7Ek869GQW3IgvBPMKQu0NE4FBw4CNgq7Elz1ATj8K9kkpGmkwRzxUCUKfY
 VfRl6LUMdRBJFKVErcLzFCXrnuFLSq+ASp60s5FoUEP0mdjGorj+M2qGES0+9zH2cOV8 6A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ute971hbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 12:09:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6C9jZ0006274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 12:09:45 GMT
Received: from [10.50.48.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 04:09:42 -0800
Message-ID: <5fe56e62-e1ab-1267-ddaa-576e880851c8@quicinc.com>
Date:   Wed, 6 Dec 2023 17:39:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2] scsi: ufs: core: store min and max clk freq from OPP
 table
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, Manish Pandey <quic_mapa@quicinc.com>
References: <20231206114659.13009-1-quic_nitirawa@quicinc.com>
 <20231206120246.GB12802@thinkpad>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231206120246.GB12802@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GgyBe3VRP8GiJQbYuKGBknpWEnv3sh99
X-Proofpoint-ORIG-GUID: GgyBe3VRP8GiJQbYuKGBknpWEnv3sh99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_08,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060101
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2023 5:32 PM, Manivannan Sadhasivam wrote:
> On Wed, Dec 06, 2023 at 05:16:59PM +0530, Nitin Rawat wrote:
>> OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
>> for parsing OPP") doesn't update the min_freq and max_freq of each clocks
>> in 'struct ufs_clk_info'.
>>
>> But these values are used by the vendor host drivers internally for
>> controller configuration. When the OPP support is enabled in devicetree,
>> these values will be 0, causing boot issues on the respective platforms.
>>
>> So add support to parse the min_freq and max_freq of all clocks while
>> parsing the OPP table.
>>
>> Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
>> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Hi Mani,
Pushed new patchset v3 with minor change.
Please can you review that.

Regards,
Nitin

> 
> Martin, please queue this patch for 6.7-rcS.
> 
> - Mani
> 
>> ---
>> Changes from v1:
>> As per Manivannan's comment:
>> - Updated commmit description
>> - Sort include file alphabetically
>> - Added missing dev_pm_opp_put
>> - updated function name and documention
>> - removed ret variable
>> ---
>>   drivers/ufs/host/ufshcd-pltfrm.c | 53 ++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
>> index da2558e274b4..409efa0db8fa 100644
>> --- a/drivers/ufs/host/ufshcd-pltfrm.c
>> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
>> @@ -8,6 +8,7 @@
>>    *	Vinayak Holikatti <h.vinayak@samsung.com>
>>    */
>>
>> +#include <linux/clk.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_opp.h>
>> @@ -213,6 +214,54 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
>>   	}
>>   }
>>
>> +/**
>> + * ufshcd_parse_clock_min_max_freq  - Parse MIN and MAX clocks freq
>> + * @hba: per adapter instance
>> + *
>> + * This function parses MIN and MAX frequencies of all clocks required
>> + * by the vendor host drivers.
>> + *
>> + * Returns 0 for success and non-zero for failure
>> + */
>> +static int ufshcd_parse_clock_min_max_freq(struct ufs_hba *hba)
>> +{
>> +	struct list_head *head = &hba->clk_list_head;
>> +	struct ufs_clk_info *clki;
>> +	struct dev_pm_opp *opp;
>> +	unsigned long freq;
>> +	u8 idx = 0;
>> +
>> +	list_for_each_entry(clki, head, list) {
>> +		if (!clki->name)
>> +			continue;
>> +
>> +		clki->clk = devm_clk_get(hba->dev, clki->name);
>> +		if (!IS_ERR(clki->clk)) {
>> +			/* Find Max Freq */
>> +			freq = ULONG_MAX;
>> +			opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);
>> +			if (IS_ERR(opp)) {
>> +				dev_err(hba->dev, "Failed to find OPP for MAX frequency\n");
>> +				return PTR_ERR(opp);
>> +			}
>> +			clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
>> +			dev_pm_opp_put(opp);
>> +
>> +			/* Find Min Freq */
>> +			freq = 0;
>> +			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx++);
>> +			if (IS_ERR(opp)) {
>> +				dev_err(hba->dev, "Failed to find OPP for MIN frequency\n");
>> +				return PTR_ERR(opp);
>> +			}
>> +			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx);
>> +			dev_pm_opp_put(opp);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>>   {
>>   	struct device *dev = hba->dev;
>> @@ -279,6 +328,10 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>>   		return ret;
>>   	}
>>
>> +	ret = ufshcd_parse_clock_min_max_freq(hba);
>> +	if (ret)
>> +		return ret;
>> +
>>   	hba->use_pm_opp = true;
>>
>>   	return 0;
>> --
>> 2.17.1
>>
> 
