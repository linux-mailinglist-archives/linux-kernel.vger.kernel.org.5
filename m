Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D67E35A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjKGHQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjKGHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:16:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416A120;
        Mon,  6 Nov 2023 23:16:41 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A76gJqU019185;
        Tue, 7 Nov 2023 07:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=T6ZU3qrjKOp6bLuMLr6UI++p/4ZwG1wrO/3tH33fHbs=;
 b=L3ZY6ISdIe5n64623bqUExuevVJUvpTeJ5VeR4bEsRFujSnABQ9LZOFAykBcXh0LhbBU
 jmJTDCs7vT4Xr9aRtzatlskYrItCQGfALqv73Dp0FGKGBinjyUESiY+KOi6EY4Wzg8Hf
 HAunIHZMYTjGYbU5Jo9qzzezH5297Neoz0al5cwmH8Q/3aWyPTzgFS1lkGxGqz8Wv6i8
 H848NiKx5RxMBJ2rXOz2MC+gPfZpnkv0ELLqhrlKfL/f1eufyfTDR7sUtgWzy2H0HvpV
 t6MHACeDH2D+TYmEciENTPMl8E5keFFUO8DOzkPsdGlYfkFTA8Y0BprGO8zH5f3poS4P pw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72avswwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 07:16:27 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A77G8Rv028683;
        Tue, 7 Nov 2023 07:16:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3u5f1m6637-1;
        Tue, 07 Nov 2023 07:16:08 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77G8QG028678;
        Tue, 7 Nov 2023 07:16:08 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3A77G8EI028676;
        Tue, 07 Nov 2023 07:16:08 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 0B6965441; Tue,  7 Nov 2023 15:16:07 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 0/4] bus: mhi: host: Add lock to avoid race when ringing channel DB
Date:   Tue,  7 Nov 2023 15:16:01 +0800
Message-Id: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G5j_soQib9wIzqCpEQbnyV20VSJ-142M
X-Proofpoint-GUID: G5j_soQib9wIzqCpEQbnyV20VSJ-142M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=452 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070059
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. We need a write lock in mhi_gen_tre otherwise there is race of the WP
used for ringing channel DB between mhi_queue and M0 transition.
2. We can not invoke local_bh_enable() when irqs are disabled, so move
read_lock_irqsave() under the mhi_gen_tre() since we add write_lock_bh() in
mhi_gen_tre().
3. Unlock xfer_cb to prevent potential lockup
4. After re-lock, check mhi channel state again to stop processing of a
disabled or stopped channel.  

v1 -> v2:
Added write_unlock_bh(&mhi_chan->lock) in mhi_gen_tre() before return
because of error process.

v2 -> v3:
1. split protecting WP and unlocking xfer_cb into two patches
2. Add a new patch to stop processing buffer and eventof a disabled or
stopped channel.

Bhaumik Bhatt (1):
  bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Hemant Kumar (1):
  bus: mhi: host: Take irqsave lock after TRE is generated

Qiang Yu (2):
  bus: mhi: host: Drop chan lock before queuing buffers
  bus: mhi: host: Avoid processing buffer and event of a disable channel

 drivers/bus/mhi/host/main.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.7.4

