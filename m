Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5E779904
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjHKU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjHKU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:59:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A168AC;
        Fri, 11 Aug 2023 13:59:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BHLTvM012675;
        Fri, 11 Aug 2023 20:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=sGCA0R7vqoJ2iWs7IvuyI9LSVz61DhA61nAyHoTsW+s=;
 b=Dxjhctua8CrNzozjpxF4LsxJ4yWZqWg6GlU3BKLGWpZM5eso4lePZOOvlRvRp/tlOqyq
 e+St9gbMWelU+/wrkicepmOWPofvEyq+wcHOF+KHNCNx5RuQDmUukqJcF60x6p8nMBZb
 G+4jkWQDe0cYYvHKf5CeydbOD8RA6tsekj5AU6Lkl0oyqB9TZcSZPb++kDP5l2pjrtMC
 9QmCvEMSz4Fmd7F/G3mGdPNvfh8tSZV4VgWl48pGWuhOpLVhSCjjqdbEVLDp5rktxBR5
 Tzx4n/jnEDZs3PPszK/a09QuRZbfLoTNRMAHcyk24+8PlSOzc8pmqd3WS/1VtxZncTNp Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sdsaf0cjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:58:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BKwjOQ006358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:58:45 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 13:58:45 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 0/4] soc: qcom: aoss: Introduce debugfs interface and cleanup things
Date:   Fri, 11 Aug 2023 13:58:35 -0700
Message-ID: <20230811205839.727373-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4YQk9p4ZPnIJv3Dr4WxUHaDnT3fuuELY
X-Proofpoint-GUID: 4YQk9p4ZPnIJv3Dr4WxUHaDnT3fuuELY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=656 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Always On Processor supports a number useful commands for affecting
system resources during in various debug scenarious. Introduce a debugfs
interface for allowing the debugger/tester to send these commands.

While at it, let's make some improvements to the qmp_send() API.


In v1, Andrew pointed out the fact that this interface could be used to
send proprietary commands from a userspace driver. As debugfs isn't
enabled in the vast majority of shipping devices, this wouldn't be very
useful. In the mantime having this interface present is very useful for
members of the upstream Qualcomm community.

It would be even more user (developer) friendly to expose each of these
knobs as individual debugfs files. But the list of commands and
resources looks to be varying from target to target, so this is still
being investigated. The hope is to perhaps capture a set of common
resources.

Changes since v1:
- Reverse xmas tree in qmp_send() in patch 1
- Correct length check of input data in patch 2

Bjorn Andersson (3):
  soc: qcom: aoss: Move length requirements from caller
  soc: qcom: aoss: Format string in qmp_send()
  soc: qcom: aoss: Tidy up qmp_send() callers

Chris Lew (1):
  soc: qcom: aoss: Add debugfs interface for sending messages

 drivers/net/ipa/ipa_power.c        |  5 +-
 drivers/remoteproc/qcom_q6v5.c     |  8 +--
 drivers/soc/qcom/qcom_aoss.c       | 82 +++++++++++++++++++++---------
 include/linux/soc/qcom/qcom_aoss.h |  4 +-
 4 files changed, 61 insertions(+), 38 deletions(-)

-- 
2.25.1

