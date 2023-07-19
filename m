Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9075995F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjGSPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGSPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:18:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE044210B;
        Wed, 19 Jul 2023 08:18:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JDuIcH009598;
        Wed, 19 Jul 2023 15:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=9K1mMR1iHlRgY1J+lDP2ewhpZLX/fOyQb9/Z2hIWlmc=;
 b=bSmekRRqadmhYRYbf+qo6nkjTt9ZNm7iJmW1eSij1gIEaxEYunDjhuyt9v1EPVjZWfVO
 FEkhtxcq9wi4nJDtcmGrIWVEdgKxnwdCtox/sfi2AWrFLgoeSry58gl+GQWUZ3HgBYxu
 s9FKhxZSlDBmhb63vK8nnrFhXAm98XZSGxQK3/ORovlA/YRADfWjAZoTcbkY1ol7Vo02
 5Ed/N4c2xXfi5g80GUqGZmPX0dtf1y1v8/P8SPuG+UnJBkHQ+793Ry5HBjC6Vgm4XmFu
 pc3vDnp8//PeeQbeDyPo3Ij+GXsFq7Ezl7lVxEPrMxoZOPsctUHNpM7SdZ6J++8mLeLV 4w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxd98gum2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 15:18:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JFIINS016563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 15:18:18 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 08:18:18 -0700
Date:   Wed, 19 Jul 2023 08:18:17 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chengfeng Ye <dg573847474@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: qcom-pm8xxx: Fix potential deadlock on
 &chip->pm_irq_lock
Message-ID: <20230719151817.GB4176673@hu-bjorande-lv.qualcomm.com>
References: <20230628072840.28587-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230628072840.28587-1-dg573847474@gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b7TQnPUUCGAfvLvqCD3-HLdDeJwmcxS5
X-Proofpoint-ORIG-GUID: b7TQnPUUCGAfvLvqCD3-HLdDeJwmcxS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_10,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=731 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:28:40AM +0000, Chengfeng Ye wrote:
> As &chip->pm_irq_lock is acquired by pm8xxx_irq_handler() under irq
> context, other process context code should disable irq before acquiring
> the lock.
> 
> I think .irq_set_type and .irq_get_irqchip_state callbacks should be

You are correct, so please drop "I think", and change "should be" to
"are generally".

> executed from process context without irq disabled by default. Thus the
> same lock acquision should disable irq.
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
> The tentative patch fix the potential deadlock by spin_lock_irqsave().

I don't think this is a "tentative patch fix", it is the patch to fix
the issue. I think you can omit this line, because you already described
your problem, and the solution above.

> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
