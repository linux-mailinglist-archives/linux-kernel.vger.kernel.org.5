Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8AB7E36A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjKGIaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjKGI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:29:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ACFE8;
        Tue,  7 Nov 2023 00:29:54 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A77S1Ck031262;
        Tue, 7 Nov 2023 08:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CAgbhith+IxcJgMX58QDJcHe1eTf1v+UVLj/drat0xQ=;
 b=Zej0VJI7e8Jl0x4pmULEu5oRNAZKqujqru3VEOTjKp1MRdqGB8f8FoXvF25Hj1YbJJl6
 xgF6RXLGKoHjPR+DDYPoM5jjiTPH6g8gwvsc+Ce+4kpcT5AOdSjm7DtQayYezL5XrPs6
 WPzdo9KVD7j8YayLrHbJbEcsc2aWtwAmyjXOWUQDwEWb1E4CBH+Ex9gyqUPSMdynW2eF
 /FZsS7a/Z6JBzPnfVaUij5lidRCAa3SOb8vSEOYX3C3QohnyvKYiJ5YbCVrGlKxxo4QJ
 dyCwLfCNH/38xvznnuKGPl/sjfSJkkTqzczGs9iZc8zS31Wthkb+i6xLisH3HZ5+Nphw xQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u74v31kef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 08:29:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A78TgcO009928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 08:29:42 GMT
Received: from [10.249.29.138] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 00:29:36 -0800
Message-ID: <7f800c67-064e-405a-bc36-39544d9e28ef@quicinc.com>
Date:   Tue, 7 Nov 2023 13:59:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
Content-Language: en-US
In-Reply-To: <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5i7WXT_WEm9jwcoxvpclFngisjiOE05r
X-Proofpoint-ORIG-GUID: 5i7WXT_WEm9jwcoxvpclFngisjiOE05r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=883
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> But there is already support for these interrupts in the driver. You
>> work for Qualcomm who built the thing so surely you can figure how they
>> intended these to be used?
>>
>> You need to provide this information so that we can determine what the
>> binding should look like. The implementation would also be simplified if
>> we don't have to add random hacks to it just because we don't know why
>> the vendor driver you refer does not use it currently on this particular
>> platform.
>>
> 
> Hi Johan,
> 
> Regarding the points of discussion we had last week on [1], here are 
> some clarifications:
> 
> 1. We do have hs_phy_irq 1/2/3/4 for tertiary port of Sc8280 as 
> mentioned. Why do we need them and would we use it in multiport targets ?
> 
> DPSE and DMSE are single ended line state of DP and DM lines. The DP 
> line and DM line stay in steady High or Low during suspend and they flip 
> when there is a RESUME or REMOTE WAKE. This is what we do/check in 
> dwc3_qcom_enable_interrupts call for dp/dm irq's based on usb2_speed.
> 
> Initially in QUSB2 targets, the interrupts were enabled and configured 
> in phy and the wakeup was interrupt was read on hs_phy_irq vector - [2].
> In that case, we modify DP/DM interrupts in phy registers, specifically 
> QUSB2PHY_INTR_CTRL and when wakeup signal comes in, hs_phy_irq is 
> triggered. But in femto targets, this is done via DP/DM interrupts and 
> there is no use of hs_phy_irq. Even hw folks confirmed they dont use 
> hs_ph_irq in femto phy targets.
> 
> As an experiment, I tried to test wakeup by pressing buttons on 
> connected keyboard when in suspend state or connecting/disconnecting 
> keyboard in suspended state on different ports and only see dp/dm IRQ's 
> getting fired although we register for hs_phy_irq as well:
> 
> / # cat /proc/interrupts  |grep phy_
> 171:   1  0   0   0  0  0  0  0       PDC 127 Edge      dp_hs_phy_1
> 172:   2  0   0   0  0  0  0  0       PDC 126 Edge      dm_hs_phy_1
> 173:   3  0   0   0  0  0  0  0       PDC 129 Edge      dp_hs_phy_2
> 174:   4  0   0   0  0  0  0  0       PDC 128 Edge      dm_hs_phy_2
> 175:   0  0   0   0  0  0  0  0       PDC 131 Edge      dp_hs_phy_3
> 176:   2  0   0   0  0  0  0  0       PDC 130 Edge      dm_hs_phy_3
> 177:   2  0   0   0  0  0  0  0       PDC 133 Edge      dp_hs_phy_4
> 178:   5  0   0   0  0  0  0  0       PDC 132 Edge      dm_hs_phy_4
> 179:   0  0   0   0  0  0  0  0       PDC  16 Level     ss_phy_1
> 180:   0  0   0   0  0  0  0  0       PDC  17 Level     ss_phy_2
> 181:   0  0   0   0  0  0  0  0     GICv3 163 Level     hs_phy_1
> 182:   0  0   0   0  0  0  0  0     GICv3 168 Level     hs_phy_2
> 183:   0  0   0   0  0  0  0  0     GICv3 892 Level     hs_phy_3
> 184:   0  0   0   0  0  0  0  0     GICv3 891 Level     hs_phy_4
> 
> Since the hs_phy_irq is applicable only for qusb2 targets, do we still 
> need to add it to DT.
> 
> 2. BAM Irq usage (u_usb31_scnd_mvs_pipe_wrapper_usb31_bam_irq[0]):
> 
> BAM IRQ is not needed in host-only controller. It was just added in 
> process of porting/deriving code from DRD controllers and is 
> non-functional (confirmed by HW team here). We can skip this from DT of 
> multiport.
> 
> 3. ctrl_irq[1] usage:
> 
> This is a feature of SNPS controller, not qcom glue wrapper, and is 
> present on all targets (non-QC as well probably). As mentioned before on 
> [3], this is used for HW acceleration.
> 
> In host mode, XHCI spec does allow for multiple interrupters when 
> multiple event rings are used. A possible usage is multiple execution 
> environments something like what we are doing on mobile with ADSP audio 
> offload [4]. Another possibility could be some of virtualization where 
> host/hyp would manage the first interrupter and could allow a guest to 
> operate only with the second (though current design does not go far 
> enough to offer true isolation for real VM type workloads). The 
> additional interrupts (ones other than ctrl_irq[0]) are either for 
> virtualization use cases, or for our various “hw offload” features. In 
> device mode, these are used for offloading tethering functionality to 
> IPA FW.
> 
> Since the DeviceTree passed to the OS, should describe the hardware to 
> the OS, and should represent the hardware from the point-of-view of the 
> OS, adding one interrupt (ctrl_irq[0]) might be sufficient as Linux 
> would not use the other interrupts. Furthermore AFAIK even UEFI/Windows 
> also use only ctrl_irq[0] for host mode in their execution environment 
> today. Do we still need to add this to bindings and DT ?
> 
> [1]: https://lore.kernel.org/all/ZTJ_T1UL8-s2cgNz@hovoldconsulting.com/
> [2]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qusb2.c?h=v6.6#n626
> [3]: https://lore.kernel.org/all/ZTduh5LULBMYf3wq@hovoldconsulting.com/
> [4]: 
> https://lore.kernel.org/all/20231017200109.11407-1-quic_wcheng@quicinc.com/
> 

Hi Johan,

  Can you help provide your comments on the above mentioned points so 
that we can take the discussion forward and finalize changes for v14 
patches. And thanks for all the reviews so far on previous revisions.

Regards,
Krishna,
