Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0507FD0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjK2I3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjK2I3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:29:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F01BD6;
        Wed, 29 Nov 2023 00:29:16 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6TKc1029736;
        Wed, 29 Nov 2023 08:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=L6s3QOTaM38nTl1M4VAl4zhUZxsgmV1Lz/iG3E95P9E=;
 b=fIcNVeTF2xK6rwaR2dI6weLU36G35+Sb1l+ZUT1BEzKf6jW5V9E0CN9WqlpHBzglRuga
 6MdHEh42vs1qJyWTm9EtdSVZUo4oczGuuEfzvz9+szl7xNga4iRKDIQhhSmYAKNOqnWf
 Ihb5hDtlN7y9wWX0mOAizcPFqfzP0LfxAneiVsRZiI1ITPfSWDQ7dG6OvbPT6ZVsxg7h
 ZrptNc1f9qvCpue9LrCB4kA7sk1JUelNZaAU7nnqp36m+R/oETzZHxJ/1cKinV5Rqyxd
 McR/OGnAex4n+5nmlx0E0vWA4mOGAAKCpwnqF5r6sLTtE+lryMmmjrUy3dn36Onh3QXw GA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up02xra1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 08:28:39 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AT8Lss1017637;
        Wed, 29 Nov 2023 08:28:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3unmeuy4yt-1;
        Wed, 29 Nov 2023 08:28:38 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT8ScXQ028464;
        Wed, 29 Nov 2023 08:28:38 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3AT8Sb63028463;
        Wed, 29 Nov 2023 08:28:38 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 93E5D20A5D; Wed, 29 Nov 2023 00:28:37 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, cmd4@qualcomm.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC
        support:Keyword:mediatek),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support:Keyword:mediatek),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support:Keyword:mediatek)
Subject: [PATCH v6 00/10] Enable HS-G5 support on SM8550
Date:   Wed, 29 Nov 2023 00:28:25 -0800
Message-Id: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tntk3zMtNUV5VFJbzZSpIf7njExSWXXB
X-Proofpoint-GUID: tntk3zMtNUV5VFJbzZSpIf7njExSWXXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290062
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
SM8350 MTP + UFS3.1 (for regression test)

Note that during reboot test on above platforms, I occasinally hit PA (PHY)
error during the 2nd init, this is not related with this series. A fix for
this is mentioned in below patchwork -

https://patchwork.kernel.org/project/linux-scsi/patch/1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com/

Also note that on platforms, which have two sets of UFS PHY settings are
provided (say G4 and no-G4, G5 and no-G5). The two sets of PHY settings are
basically programming different values to different registers, mixing the
two sets and/or overwriting one set with another set is definitely not
blessed by UFS PHY designers. For SM8550, this series will make sure we
honor the rule. However, for old targets Mani and I will fix them in
another series in future.

v5 -> v6:
1. Rebased on scsi-queue-6.8
2. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c

v4 -> v5:
Removed two useless debug prints in patch #9

v3 -> v4:
Used .tbls_hs_overlay array instead of adding more tables with different names like .tbls_hs_g5

v2 -> v3:
1. Addressed comments from Andrew, Mani and Bart in patch #1
2. Added patch #2 as per request from Andrew and Mani
3. Added patch #4 to fix a common issue on old targets, it is not necessary
   for this series, but put in this series only because it would be easier
   to maintain and no need to rebase
4. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c

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

Can Guo (9):
  scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
  scsi: ufs: ufs-qcom: No need to set hs_rate after
    ufshcd_init_host_param()
  scsi: ufs: ufs-qcom: Setup host power mode during init
  scsi: ufs: ufs-qcom: Allow the first init start with the maximum
    supported gear
  scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
  scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 4
    and newer
  phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings
  phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
    SM8550
  scsi: ufs: ufs-qcom: Check return value of phy_set_mode_ext()

 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 ++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 192 ++++++++++++++++++---
 drivers/ufs/host/ufs-exynos.c                      |   7 +-
 drivers/ufs/host/ufs-hisi.c                        |  11 +-
 drivers/ufs/host/ufs-mediatek.c                    |  12 +-
 drivers/ufs/host/ufs-qcom.c                        |  90 +++++++---
 drivers/ufs/host/ufs-qcom.h                        |   5 +-
 drivers/ufs/host/ufshcd-pltfrm.c                   |  69 ++++----
 drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
 11 files changed, 306 insertions(+), 106 deletions(-)

-- 
2.7.4

