Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAE7EAA17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjKNF1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjKNF1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:27:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053F6135;
        Mon, 13 Nov 2023 21:27:50 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE50RSc003711;
        Tue, 14 Nov 2023 05:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=T7TCzSWQjxVnFSGx+strSZ9P2j5OTbshKH3B9b0+5Lk=;
 b=WDL9urdktqN+6PJflXqDUl0/JnPhqP9W1i1WYwJroJuLpnNk1DylxjE5fNvPG0Jnb6XP
 RrJ51B5j9ktaoEV+KjiBTh0EgKiCOASqDJA0NSXW7xzL6PzU3JAkyXl+HhruqYTJ+S6G
 Qa48MEmos6hzQJSns6X+pKuQiFoiGWteevPC99vnmKtElbb2TbEpRt02DgX1j1Y954nP
 8Y5HE6M6xIXv+C35LdztqbNtgF0oHAzMCpm7PDh2vp5rVl9Kc8ssCmYf5xucE9s56QkP
 6xTnBJ9nmmHvsQN6HI0G/uC3m7NjRXpDtNgg3Wbn3IohXMABcAn0MWfqpdO+tCzJhAoz 7A== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubf6dahnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 05:27:45 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AE5Rh2q032643;
        Tue, 14 Nov 2023 05:27:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3ua2pkqrh5-1;
        Tue, 14 Nov 2023 05:27:43 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AE5RhGH032638;
        Tue, 14 Nov 2023 05:27:43 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3AE5Rggu032636;
        Tue, 14 Nov 2023 05:27:43 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id E96FC549C; Tue, 14 Nov 2023 13:27:41 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4 0/4] bus: mhi: host: Add lock to avoid race when ringing channel DB
Date:   Tue, 14 Nov 2023 13:27:37 +0800
Message-Id: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lSIgDjhy_tHndXrVrUhHIx8pbr5CUlY3
X-Proofpoint-GUID: lSIgDjhy_tHndXrVrUhHIx8pbr5CUlY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=490 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140040
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

v3 -> v4:
1. Modify commit message
2. Add unlock operation before return error

Bhaumik Bhatt (1):
  bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Hemant Kumar (1):
  bus: mhi: host: Take irqsave lock after TRE is generated

Qiang Yu (2):
  bus: mhi: host: Drop chan lock before queuing buffers
  bus: mhi: host: Avoid processing buffer and event of a disable channel

 drivers/bus/mhi/host/main.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

-- 
2.7.4

