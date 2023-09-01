Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5878778FFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbjIAPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjIAPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:18:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E0E65;
        Fri,  1 Sep 2023 08:18:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381AlIDx017463;
        Fri, 1 Sep 2023 15:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=gSI346QTLYAImo8PbOkLlrPdhOT/h0HS3oLDK31s1jI=;
 b=CcJA6+FuhR5LSL/d9aRV+ej9H3A4yEdL/4rtkqYHrOcbeetlDeiKiPwd4bJ1WST9r4AE
 e8WrP1ljxYWlVS6rSrw9/mny2Zu5eDSyWtV3wlOrKK+MHNAjvhHH+MhFJUIjgPrJx7tC
 lxxmatUxXNQaNE1fFqDG9OEQynJgC0AMFda9TQBrVnPD/XndnpWholb0GPdpeSWXf71c
 ztNz2OtAluTG0eO5b4YFhdG1vAIoWdM+GTuA6e+nU1glSt/Q4HyCBcCWGBrB6TE4HKtI
 L8EjpVBd/bwjNEmxc5OhRcQOU6UThS3V+JjzVMjhGPbs3OI5OC72ZAhvS5KdVZ+zOGiU iQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy9cba4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 15:18:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381FI6pO005306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 15:18:06 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 08:18:06 -0700
Date:   Fri, 1 Sep 2023 08:18:05 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Nitin Rawat <quic_nitirawa@quicinc.com>, <mani@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH V6 0/6] scsi: ufs: qcom: Align programming sequence as
 per HW spec
Message-ID: <20230901151805.GR818859@hu-bjorande-lv.qualcomm.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <or3ak3pzz6eozhvvjsjh52vrylehlhvrqrg3ey6slhjtx2mj5g@6vho7zpyeady>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <or3ak3pzz6eozhvvjsjh52vrylehlhvrqrg3ey6slhjtx2mj5g@6vho7zpyeady>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GouPAHEcA1-WQX3ACu5ywFie_1yjQ3JO
X-Proofpoint-GUID: GouPAHEcA1-WQX3ACu5ywFie_1yjQ3JO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=923 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 09:56:05AM -0500, Andrew Halaney wrote:
> On Fri, Sep 01, 2023 at 05:13:30PM +0530, Nitin Rawat wrote:
> > This patch aligns programming sequence as per Qualcomm UFS
> > hardware specification.
> 
> reading this series, it is difficult for me to understand as a user of
> the driver if this should have any noticeable effect.
> 
> Some of the patches mention that there is no functional change, some
> only say align with the HPG but change programming sequence, frequency,
> etc if I understand correctly on a quick glance.
> 
> I think being a bit verbose in some of the patches with respect to
> explaining the effect of the patch (or lack of a noticeable effect)
> would be a beneficial improvement to this series if there's another
> version.
> 
> I agree that aligning with the HPG instead of doing some undefined
> sequence is a good idea, I'm just reading some of the changes and
> thinking "I have no idea if this is going to fix something (no Fixes:
> tag but it almost sounds like one), will this improve something, or will this
> just change the programming sequence to a known and recommended
> sequence?".
> 

Very valid feedback, Andrew.

Correct or not, there are a fair amount of users out there who runs the
current implementation. Changes to that should be described in a way
that doesn't depend on inside-knowledge.

Regards,
Bjorn
