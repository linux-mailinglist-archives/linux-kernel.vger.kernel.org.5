Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9C7A27F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbjIOUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbjIOUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:20:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14330C4;
        Fri, 15 Sep 2023 13:17:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKGPlS027253;
        Fri, 15 Sep 2023 20:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4iyMK8yURRpW6wHtBGMckqRocChvhmWY4LY6hP5z4SA=;
 b=WHZ5nr5hoEa7mYjtoTaQTiOkh3Q/4CCmt63ldro8facP/O15pJMHvH/zlVxNQWzXScNn
 fY+gWCOLTI2RO15bRx99mgKqGVlZu5a2YEUv8n1B8NsLwxYy1cT++0iFj7A/3pQUAqrG
 KpHbvi7Njkou4LMV6u4u9S+6hoo1D6jTF9q9ORsN66hcDhWODegbVEZq+5pD6Iv2/yrY
 m9Vni1qAU8H6F/arkakVENDigW3bz637mC0rY9jd383jFt4t2L4mLIPLPH63sv+00V2n
 PVIlVvJUW8Kh5IbbUcgbIHDQovf1LoUORzHCpyj1WhJanZNNarPHiT1ErNPRxV6Oo8OX tA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g86t218-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:17:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FKHnHe016283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 20:17:49 GMT
Received: from [10.110.47.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 13:17:49 -0700
Message-ID: <bed7d2d2-3c66-b174-7b4e-9a2f2c0d5f1c@quicinc.com>
Date:   Fri, 15 Sep 2023 13:17:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already
 suspended in pm resume
Content-Language: en-US
To:     William Wu <william.wu@rock-chips.com>,
        <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <frank.wang@rock-chips.com>, <jianwei.zheng@rock-chips.com>,
        <yangbin@rock-chips.com>
References: <20230911033112.3321-1-william.wu@rock-chips.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230911033112.3321-1-william.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5TrgP3HF_RkO9fHa3nZBuwKTVtjMNU8B
X-Proofpoint-ORIG-GUID: 5TrgP3HF_RkO9fHa3nZBuwKTVtjMNU8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_16,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=413
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150181
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On 9/10/2023 8:31 PM, William Wu wrote:
> If we enable PM runtime auto suspend for dwc3 on rockchip
> platforms (e.g. RK3562), it allows the dwc3 controller to
> enter runtime suspend if usb cable detached and power off
> the power domain of the controller. When system resume, if
> the dwc3 already in runtime suspended, it Shouldn't access
> the dwc3 registers in dwc3_resume() because its power domain
> maybe power off.
> 
> Test on RK3562 tablet, this patch can help to avoid kernel
> panic when accessing the dwc3 registers in dwc3_resume() if
> the dwc3 is in runtime suspended and it's power domain is
> power off.
> 
> Kernel panic - not syncing: Asynchronous SError Interrupt
> Hardware name: Rockchip RK3562 RK817 TABLET LP4 Board (DT)
> Call trace:
> dump_backtrace.cfi_jt+0x0/0x8
>    dump_stack_lvl+0xc0/0x13c
>    panic+0x174/0x468
>    arm64_serror_panic+0x1b0/0x200
>    do_serror+0x184/0x1e4
>    el1_error+0x94/0x118
>    el1_abort+0x40/0x68
>    el1_sync_handler+0x58/0x88
>    el1_sync+0x8c/0x140
>    dwc3_readl+0x30/0x1a0
>    dwc3_phy_setup+0x38/0x510
>    dwc3_core_init+0x68/0xcd4
>    dwc3_core_init_for_resume+0x10c/0x25c
>    dwc3_resume_common+0x44/0x3d0
>    dwc3_resume+0x5c/0xb8
>    dpm_run_callback+0x70/0x488
>    device_resume+0x250/0x2f8
>    dpm_resume+0x258/0x9dc
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
> Changes in v2:
> - Remove Change-Id.
> 
>   drivers/usb/dwc3/core.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 9c6bf054f15d..8274a44f2d6a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2185,9 +2185,11 @@ static int dwc3_resume(struct device *dev)
>   
>   	pinctrl_pm_select_default_state(dev);
>   
> -	ret = dwc3_resume_common(dwc, PMSG_RESUME);
> -	if (ret)
> -		return ret;
> +	if (!pm_runtime_suspended(dwc->dev)) {
> +		ret = dwc3_resume_common(dwc, PMSG_RESUME);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	pm_runtime_disable(dev);
>   	pm_runtime_set_active(dev);

In case DWC3 is runtime suspended, then we will avoid the 
dwc3_resume_common() call, but the current flow would also set the RPM 
state to RPM_ACTIVE. (from pm_runtime_set_active())  In this case, what 
happens if there is a pm_runtime_get/resume on the DWC3 device?

I think it would avoid calling rpm_resume() since the RPM state is 
already active, so we wouldn't be calling dwc3_runtime_resume().  Do you 
want to also extend the RPM suspended check to cover if we need to force 
PM runtime state back to active?

Thanks
Wesley Cheng
