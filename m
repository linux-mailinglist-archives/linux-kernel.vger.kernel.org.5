Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2047E349B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjKGEqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjKGEqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:46:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E9109;
        Mon,  6 Nov 2023 20:46:49 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A73UEFp026119;
        Tue, 7 Nov 2023 04:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2jetZAPjuf4F2dPkrQmEgRytgXtkCysHEDjVxTXueZI=;
 b=DFOQBhe0Hodwz7gvirbdS4CaAypqn5PiJ1nmnn10BCEY89pRs8ar7S8SELEmvPoEUn5+
 kKMtUpke/sSNWP6PAX5OLOVL9cbLy++9Ewwvy0nqN6r/9xpuH8r4XRLJlqLRTIMA2lW2
 rd7DhbMMf309xZh5PH3MbdDHTTUALgFzQ+r3fw9nYoojsMUnY56ypGucFpRY+zAAqkH8
 7m/5YAlarGbX372taguwseu1whbJxGzWK5XLNA1EH2Y0/NpfGHcj1bix6lsnldflwkye
 JQaBC/CFM5/5hHnY7ccLGRy+iS3j3ttUEiV6Tv3tV4EpV/gIVhq6FVIo5HYecNTzZ1+m SA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7dbs8594-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 04:46:24 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A74kNoa013041;
        Tue, 7 Nov 2023 04:46:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3u6x85hsbx-1;
        Tue, 07 Nov 2023 04:46:23 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A74ZS1b027256;
        Tue, 7 Nov 2023 04:46:22 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3A74kMkk013030;
        Tue, 07 Nov 2023 04:46:22 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 2529820A78; Mon,  6 Nov 2023 20:46:22 -0800 (PST)
From:   Can Guo <cang@qti.qualcomm.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Can Guo <cang@qti.qualcomm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v2 0/7] Enable HS-G5 support on SM8550
Date:   Mon,  6 Nov 2023 20:46:06 -0800
Message-Id: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D_9-DvKMH23HeRl7RpwgAfk4jC7zoL38
X-Proofpoint-GUID: D_9-DvKMH23HeRl7RpwgAfk4jC7zoL38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=893 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311070038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables HS-G5 support on SM8550.

This series is rebased on below changes from Mani -
https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/

This series is tested on below HW combinations -
SM8550 MTP + UFS4.0
SM8550 QRD + UFS3.1
SM8450 MTP + UFS3.1 (for regression test)

v1 -> v2:
1. Removed 2 changes which were exposing power info in sysfs
2. Removed 1 change which was moving data structs to phy-qcom-qmp-ufs.h
3. Added one new change (the 1st one) to clean up usage of ufs_dev_params based on comments from Mani
4. Adjusted the logic of UFS device version detection according to comments from Mani:
	4.1 For HW version < 0x5, go through dual init
 	4.2 For HW version >= 0x5
		a. If UFS device version is populated, one init is required
		b. If UFS device version is not populated, go through dual init

Bao D. Nguyen (1):
  scsi: ufs: ufs-qcom: Add support for UFS device version detection

Can Guo (6):
  scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
  scsi: ufs: ufs-qcom: Setup host power mode during init
  scsi: ufs: ufs-qcom: Allow the first init start with the maximum
    supported gear
  scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
  scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 5
    and newer
  phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
    SM8550

 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
 drivers/ufs/host/ufs-exynos.c                      |   7 +-
 drivers/ufs/host/ufs-hisi.c                        |  11 +-
 drivers/ufs/host/ufs-mediatek.c                    |  12 +--
 drivers/ufs/host/ufs-qcom.c                        |  78 ++++++++++----
 drivers/ufs/host/ufs-qcom.h                        |   3 +
 drivers/ufs/host/ufshcd-pltfrm.c                   |  49 +++++----
 drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
 11 files changed, 217 insertions(+), 81 deletions(-)

-- 
2.7.4

