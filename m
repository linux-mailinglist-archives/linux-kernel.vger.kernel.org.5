Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116C786478
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjHXBIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjHXBIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:08:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A310DD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:08:15 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O0VUMt023805;
        Thu, 24 Aug 2023 01:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=Ir9AWRyHkSb+mhioCJGGS8D9QpbKvsqSN2O/cKTJsiI=;
 b=X8byVu7IYUT8ome1CFgpGHGSI+4cGdXCsoxHt3hTTqERWAOSOrc2Nl0rYy1V5486nPtT
 1WvAxa5nQV6LYpNZOn0kRSTqCvcKQPYsO+kgpITYAEAPasB5Fe9sPksgHmmosLdAvKX7
 QVZUTW/SQjF+vkqwZ/kD/eFecPwRNx1xOLKRoHHcjGbd/6QFRiocEafmNPt+d69Y2b2w
 LwWP8SnFo37ce5sFZ2SRenw5h4pBb/vx+gu+dizcjyLsbtTcFIEf0DFrNL8QPKSq1zgZ
 8O5zQNcbZ360edaBFx3botJ8p++zu0jgPv5HAmkxFVwz0f4Lh9a/7ZR86OqMQEi8VgBM Bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sntyur6mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 01:08:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O182W1027012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 01:08:02 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 18:08:00 -0700
Message-ID: <3eedf328-d588-cbd2-ee99-55dc776bdf5b@quicinc.com>
Date:   Thu, 24 Aug 2023 09:07:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Kassey Li <quic_yingangl@quicinc.com>
Subject: seqlock:do_raw_write_seqcount_end smp_wmb
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JeACbHHLAt0hWLEPpTxYZgO6tVhH_EdR
X-Proofpoint-ORIG-GUID: JeACbHHLAt0hWLEPpTxYZgO6tVhH_EdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_17,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=486 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Peter:
	I not quit sure on this, but is that a type error in 
do_raw_write_seqcount_end here  ?
is this change necessary to match with do_raw_write_seqcount_begin ?
		
	
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 987a59d977c5..eb8807ed3a00 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -486,8 +486,8 @@ do { 
                        \

  static inline void do_raw_write_seqcount_end(seqcount_t *s)
  {
-       smp_wmb();
         s->sequence++;
+       smp_wmb();
         kcsan_nestable_atomic_end();
  }


to match with

static inline void do_raw_write_seqcount_begin(seqcount_t *s)
{
	kcsan_nestable_atomic_begin();
	s->sequence++;
	smp_wmb();
}



BR
TNT

