Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5D806D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377999AbjLFLIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378025AbjLFLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:08:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C510EB;
        Wed,  6 Dec 2023 03:08:41 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B63w8AZ019177;
        Wed, 6 Dec 2023 11:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KO41K6KCZ2q9y86UP2tuixxqWTDsGs9XPyef5FhT5kQ=;
 b=o7JIM2i9jzM9HEP4gJBaXC5QEIOK40K01kcNv+p8fWTWTG096aL/+Qm/0ulZ00KzBilZ
 hcH4Y9wf7JmDljD7Pt1kw8/8LKvtlugmJ4ebAdAz7wK1fRUdea3nnHdSHXgzeWNtSGyl
 p8Qk52XITgEXx4vBYWtcAluNAViXU9kubDo8b2qucBN0xOQ/VgXzqx41gZiGQdmzJTlv
 /tCqIjXSwqqcULtfvDj983E/LoAVGKGZcnsMeAR+glb3vqrZ/QjkTehciBEBvCt+ukZT
 S6ZRqO3i8iyynYGGU7XTrn8kMpGwafRR6xlnGi37cLYOZ+B7lEKQCzWFXW+Jca1nYZsX Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdmd1922-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 11:05:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6B5WdS011560
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 11:05:32 GMT
Received: from [10.50.48.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 03:05:28 -0800
Message-ID: <f30d3c21-f355-d535-480b-2fd36167bcfd@quicinc.com>
Date:   Wed, 6 Dec 2023 16:35:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V1] scsi: ufs: core: store min and max clk freq from OPP
 table
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <quic_cang@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>
References: <20231206053628.32169-1-quic_nitirawa@quicinc.com>
 <20231206075447.GA4954@thinkpad>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231206075447.GA4954@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qSbYtsBwejFTsUUazuBVvGHNKH21h9YI
X-Proofpoint-ORIG-GUID: qSbYtsBwejFTsUUazuBVvGHNKH21h9YI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060091
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2023 1:24 PM, Manivannan Sadhasivam wrote:
> On Wed, Dec 06, 2023 at 11:06:28AM +0530, Nitin Rawat wrote:
>> OPP support will make use of OPP table in device tree and removes
>> freq-table-hz property from device tree.
>>
>> With OPP enabled in devicetree, clki->min_freq and clki->maxfreq
>> currently is not getting updated and the value is set to 0.
>>
>> Soc vendors like qcom, mediatek uses clki->minfreq and clki->maxfreq
>> in vendor specific file. These frequencies values are used to update
>> vendor specific configurations. Since the value is 0, it is causing
>> functional issue.
> 
> How about,
> 
> "OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
> for parsing OPP") doesn't update the min_freq and max_freq of each clocks
> in 'struct ufs_clk_info'.
> 
> But these values are used by the vendor host drivers internally for controller
> configuration. When the OPP support is enabled in devicetree, these values will
> be 0, causing boot issues on the respective platforms.
> 
> So let's parse the min_freq and max_freq of all clocks while parsing the OPP
> table."
> 
>>
>> Add code to store the min and max ufs clk frequency from OPP table.

Sure. Will update in next patchset.

>>
>> Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
>> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufshcd-pltfrm.c | 56 ++++++++++++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>
>> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
>> index da2558e274b4..12fa6f7d6a97 100644
>> --- a/drivers/ufs/host/ufshcd-pltfrm.c
>> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/of.h>
>> +#include <linux/clk.h>
> 
> Sort includes alphabetically.

Sure. Will update in next patchset

> 
>>
>>   #include <ufs/ufshcd.h>
>>   #include "ufshcd-pltfrm.h"
>> @@ -213,6 +214,55 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
>>   	}
>>   }
>>
>> +/**
>> + * ufshcd_config_min_max_clk_freq - update min and max freq
> 
> "ufshcd_parse_clock_min_max_freq - Parse MIN and MAX frequencies of clocks"
> 
>> + * @hba: per adapter instance
>> + *
>> + * This function store min and max freq for all the clocks.
>> + *
> 
> "This function parses MIN and MAX frequencies of all clocks required by the
> vendor host drivers."
> 
>> + * Returns 0 for success and non-zero for failure
>> + */
>> +static int ufshcd_config_min_max_clk_freq(struct ufs_hba *hba)
>> +{
>> +	struct list_head *head = &hba->clk_list_head;
>> +	struct dev_pm_opp *opp;
>> +	struct ufs_clk_info *clki;
> 
> Please maintain reverse Xmas tree order. It's not a rule for this driver, but my
> own preference.
> 
>> +	unsigned long freq;
>> +	u8 idx = 0;
>> +	int ret;
> 
> This won't be needed if all the return values are directly returned as I shared
> below.


Will Addressed all ret comments in next patchset.
> 
>> +
>> +	list_for_each_entry(clki, head, list) {
>> +		if (!clki->name)
>> +			continue;
>> +
>> +		clki->clk = devm_clk_get(hba->dev, clki->name);
>> +		if (!IS_ERR_OR_NULL(clki->clk)) {
> 
> This function won't return NULL, so IS_ERR() is sufficient.
> 
>> +			/* Find Max Freq */
>> +			freq = ULONG_MAX;
>> +			opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);
> 
> Use idx++ and get rid of the increment at the end of the 'if' condition.

If we increment idx++ here, dev_pm_opp_find_freq_ceil_indexed will use 
incremented idx which is not correct. Hence i added at end after both 
the call.

> 
>> +			if (IS_ERR(opp)) {
>> +				dev_err(hba->dev, "failed to find dev_pm_opp\n");
> 
> "Failed to find OPP for MAX frequency"
> 
>> +				ret = PTR_ERR(opp);
> 
> return PTR_ERR(opp);
> 
>> +				return ret;
>> +			}
>> +			clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
>> +
> 
> Missing dev_pm_opp_put()

Thanks. Will update in next patchset.

> 
>> +			/* Find Min Freq */
>> +			freq = 0;
>> +			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx);
>> +			if (IS_ERR(opp)) {
>> +				dev_err(hba->dev, "failed to find dev_pm_opp\n");
> 
> "Failed to find OPP for MIN frequency"
> 
>> +				ret = PTR_ERR(opp);
> 
> return PTR_ERR(opp);
> 
>> +				return ret;
>> +			}
>> +			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx);
> 
> Missing dev_pm_opp_put()
> 
>> +			idx++;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>>   {
>>   	struct device *dev = hba->dev;
>> @@ -279,6 +329,12 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>>   		return ret;
>>   	}
>>
>> +	ret = ufshcd_config_min_max_clk_freq(hba);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get min max freq: %d\n", ret);
> 
> Since we already print error message inside the function, no need to do the same
> here.

Sure. Will update in next patchset

> 
> - Mani
> 
>> +		return ret;
>> +	}
>> +
>>   	hba->use_pm_opp = true;
>>
>>   	return 0;
>> --
>> 2.17.1
>>
> 

Thanks,
Nitin
