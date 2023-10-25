Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384F57D704E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJYO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJYO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:58:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91312A;
        Wed, 25 Oct 2023 07:58:42 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEUUU6027092;
        Wed, 25 Oct 2023 14:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0Nzdx1M3poa9Sohv9GvecOCxrIdczNKBTiFsRzPNhEg=;
 b=BN9qMVWy61zuBJAXh5/NFFvEhonVHJiBTzl59gf7FXo/w8cCeW6lWoLEdYKff2oPlBjy
 JFkExd5tGgDa/UyQkoAbN0ZZFT/HYqzKQ66b92XWz3xrn5UvtTqmq88asTazRtKlW9rc
 7GMSrKfO2x1M3NkFeYRQveznBLZlC7epkjE+adgLCH/j2srhHYmdhyiDtSxw3rvem4Xr
 yA2H4BBjLdrjXanPbrwf9AhE6+4NICq0U97PFGxtnV8yZ5foEp4bx0VcLBOtfaT1cVRy
 tnJP8ajOxqn3cQyirTTicJPIbTjCt0Kf3zRmOgsaVTE9qIKR9fnEWO1Z//T/sZLnS1Gd Iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txngvhs65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:58:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PEwc7x027452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:58:38 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 07:58:38 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH] interconnect: Treat xlate() returning NULL node as an error
Date:   Wed, 25 Oct 2023 07:58:29 -0700
Message-ID: <20231025145829.11603-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jqJuwUcqJ2vbZCvmsOwbWAv3cA92iilW
X-Proofpoint-ORIG-GUID: jqJuwUcqJ2vbZCvmsOwbWAv3cA92iilW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if provider->xlate() or provider->xlate_extended()
"successfully" return a NULL node, then of_icc_get_from_provider() won't
consider that an error and will successfully return the NULL node. This
bypasses error handling in of_icc_get_by_index() and leads to NULL
dereferences in path_find().

This could be avoided by ensuring provider callbacks always return an
error for NULL nodes, but it's better to explicitly protect against this
in the common framework.

Fixes: 87e3031b6fbd ("interconnect: Allow endpoints translation via DT")
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---

I'm not specifically aware of any upstream cases of this happening, but
we did hit this downstream. And it's hard to ensure this can never
happen upstream, since it's hard to ensure that none of the
qcom_icc_desc::nodes arrays have zero holes in them, for instance.

 drivers/interconnect/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index dfab160ca529..50bac2d79d9b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -395,6 +395,9 @@ struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 	}
 	mutex_unlock(&icc_lock);
 
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
 	if (IS_ERR(node))
 		return ERR_CAST(node);
 
-- 
2.17.1

