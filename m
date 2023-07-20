Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9275B70C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGTSr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:47:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620BE4C;
        Thu, 20 Jul 2023 11:47:53 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFxHWX013040;
        Thu, 20 Jul 2023 18:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=BgoWEOSu5VAgz/EY6ImELAyLlVmK6s8QoLF1e2UUL94=;
 b=J7KGdhPl9mk54l1P9aWxZ47QQ2LqjM5QBU8yH93R2eAdlkSwRWBlEY5CvvBqDDGeSEEM
 M45qFK+y6ZSIYa6/mg3ESjmtFcKUkFN/a8+CnOLDwalzN3JaMZLW3eTi/TcX5z3aQQY9
 aVZuxzoe/6YMSdMVsMMCWX3WgbZt6eKbFv0XPlhivTZusbhQCvSOyurmV4siRTfPRTfr
 wXV3cYV/mwmlmqSqwZEzXv+7lEuLZPPWi0FswZ7HjwdmFfqi8Jai+nbFe60V1ykBIkkk
 AfXKe4yS0uZJApMhmYQfMGERz14+ii+mnAQVmmKmRYaRHPfHwve1IGIpG91xnqu8YR+5 Dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4j2tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 18:47:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KIlMwP012076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 18:47:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 11:47:22 -0700
Date:   Thu, 20 Jul 2023 11:47:21 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chengfeng Ye <dg573847474@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <sboyd@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: qcom-pm8xxx: Fix potential deadlock on
 &chip->pm_irq_lock
Message-ID: <20230720184721.GC2667611@hu-bjorande-lv.qualcomm.com>
References: <20230720071330.50382-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230720071330.50382-1-dg573847474@gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CrBcRF-os3zqeV5lUjvHtyZplfxJ9FBz
X-Proofpoint-ORIG-GUID: CrBcRF-os3zqeV5lUjvHtyZplfxJ9FBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=641 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:13:30AM +0000, Chengfeng Ye wrote:
> As &chip->pm_irq_lock is acquired by pm8xxx_irq_handler() under irq
> context, other process context code should disable irq before acquiring
> the lock.
> 
> Since .irq_set_type and .irq_get_irqchip_state callbacks are generally
> executed from process context without irq disabled by default, the same
> lock acquision should disable irq.
> 
> Possible deadlock scenario
> pm8xxx_irq_set_type()
>     -> pm8xxx_config_irq()
>     -> spin_lock(&chip->pm_irq_lock)
>         <irq interrupt>
>         -> pm8xxx_irq_handler()
>         -> pm8xxx_irq_master_handler()
>         -> pm8xxx_irq_block_handler()
>         -> pm8xxx_read_block_irq()
>         -> spin_lock(&chip->pm_irq_lock) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
> 
> Fix the potential deadlock by spin_lock_irqsave().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
