Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0906A79E287
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjIMIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjIMIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:48:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6FB198E;
        Wed, 13 Sep 2023 01:47:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D6rjLM011651;
        Wed, 13 Sep 2023 08:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=47VC1yn9WJ7Nh+GGQ+9Mqxm5rnZYsKhcTYBLi0YS1I8=;
 b=Z3zpmKhLMWC9C5Syb+n2oZRW6FS/IAvqqPkvkLXYFy8ZEdfG8xzBgoLynxp5wxhfzs9f
 NGjjwUZGZbTKDpNKbwFh3wJPpOHGLHINHGl+bs0Q4EQEgIa0mB+YsPLrR6cv794NbnQF
 w8KVg8NDRK4hZBDiSHh9o7UUW8GkJ8AniT33CftmA/YYKHIYUuLmXSdk1nCPR2tRInBC
 PQuoPzjVnp9gAmWFZx5jEPjE7zGhFMvTiIQ6C9vVINpeNuv6zrzfE+P9Qet7OPSNoZ0H
 5q176MEwms24fm7f5EbrC8sqsJ5NukdhCdb4HoI3K2vh2f0jtJDRZL2WoTwaX8DEUNe9 6A== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2ygr96ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 08:47:47 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38D8lic0016827;
        Wed, 13 Sep 2023 08:47:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3t0hskj2ae-1;
        Wed, 13 Sep 2023 08:47:44 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38D8liU6016821;
        Wed, 13 Sep 2023 08:47:44 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 38D8lixH016819;
        Wed, 13 Sep 2023 08:47:44 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 827114DB3; Wed, 13 Sep 2023 16:47:43 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 0/2] Add lock to avoid race when ringing channel DB
Date:   Wed, 13 Sep 2023 16:47:39 +0800
Message-Id: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: adE5b9uR7A5r6W-Tp5JB9j3TYXZOd4f2
X-Proofpoint-ORIG-GUID: adE5b9uR7A5r6W-Tp5JB9j3TYXZOd4f2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=536 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. We need a write lock in mhi_gen_tre otherwise there is race of the WP
used for ringing channel DB between mhi_queue and M0 transition.
2. We can not invoke local_bh_enable() when irqs are disabled, so move
read_lock_irqsave() under the mhi_gen_tre() since we add write_lock_bh() in
mhi_gen_tre().

v1 -> v2:
Added write_unlock_bh(&mhi_chan->lock) in mhi_gen_tre() before return
because of error process.

Bhaumik Bhatt (1):
  bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Hemant Kumar (1):
  bus: mhi: host: Take irqsave lock after TRE is generated

 drivers/bus/mhi/host/main.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.7.4

