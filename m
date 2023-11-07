Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7407E35A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKGHQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjKGHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:16:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0519FC;
        Mon,  6 Nov 2023 23:16:39 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A77DkHB015693;
        Tue, 7 Nov 2023 07:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=0wF1vmqvNntDEJT9NQ3UDGYk2u4j/IoHwLjboLwGHNk=;
 b=eRgU/lHpRtkppnsGMhNRGmAjCWOLVzxEDA4lYCzO46xJjJOfW5bvmahownUtHZkUkDPh
 TXP0fIWJdNh06sO7mPyWMabmQbQWHpZeYRtSZkwucB2thq4ny3nTt5aI6GMZ33Jr7yYb
 rR2H/oAPuK4nAu0GPT9+BIpJEu7N6vnFC5G07gW6AhWXx7ee+qnPSGyBbTrgygYrGqxo
 S9bAqRFl8OqlNRzuXDZqWLxuelsdO311y2sFj6ZHn7pDXUhkIcdJ5QnWCI4uqnBkGADa
 VpfBt85wxrkd6alRpxJ3wKvF8sDs0OfFq4s0luak/+DkiGbUqdlARUxB/D6zenitJ5em /A== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72avswwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 07:16:27 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A77GAvN028711;
        Tue, 7 Nov 2023 07:16:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3u5f1m663m-1;
        Tue, 07 Nov 2023 07:16:10 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77G9E4028706;
        Tue, 7 Nov 2023 07:16:10 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3A77G9D5028705;
        Tue, 07 Nov 2023 07:16:09 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 1A8705441; Tue,  7 Nov 2023 15:16:09 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event of a disable channel
Date:   Tue,  7 Nov 2023 15:16:04 +0800
Message-Id: <1699341365-47737-4-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
References: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NGTZLya88HmvASpMEyG_Kfp3twAkXhHn
X-Proofpoint-GUID: NGTZLya88HmvASpMEyG_Kfp3twAkXhHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=708 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
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

Ckeck mhi channel state after getting chan->lock to ensure that we only
queue buffer to an enabled channel and process event of an enabled channel.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index a236dc2..b137d54 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -672,6 +672,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			}
 
 			read_lock_bh(&mhi_chan->lock);
+			if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+				goto end_process_tx_event;
 		}
 		break;
 	} /* CC_EOT */
@@ -1211,6 +1213,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
 	/* Protect accesses for reading and incrementing WP */
 	write_lock_bh(&mhi_chan->lock);
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		return -EINVAL;
 
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
-- 
2.7.4

