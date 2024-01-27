Return-Path: <linux-kernel+bounces-41457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC483F223
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F5F2848D7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9B2E62C;
	Sat, 27 Jan 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfl0SUTN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E72032F;
	Sat, 27 Jan 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398184; cv=none; b=ckiEhHEKdFuIlhbOkcEltt8Ub/z9YMqSnTYm47pWL2TpI54bJpCBNYdrHArIN5hWjlWNDY4rjidBPf/Hn0Sy5ar6Cx8VSzTXkUS8tu0Mvb722p4slfujafUMlP2fmT+hZt/EDAd95GCAGRMnxxUv2yD7PBH7K2Y/Hu3XS48elr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398184; c=relaxed/simple;
	bh=+7sGisfjBDLw3/+65hJ8oE5P46X3obGEXGgOIuz9ZDM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WN4xbYs5aEHyutr32vx6/LRaNluha9nlIAI5O6800j5n/8eftWYQWKAE5pnlBJIYOG+TZmf3t6Sfgu1nj3q3CDxafz6ZsLmFPkSbJZv0sfS5CniqbOTNC1P5L+CnHHnjebDH+4OA6TYsLCcodh0jl8ZSxqbwijOtgqZgHPu1epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfl0SUTN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNQLfd032284;
	Sat, 27 Jan 2024 23:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ZtabC2d
	xcshri/iz1qUsrq8UwR1bNPdOel6KB0APenU=; b=cfl0SUTNFei8oB1OgxmCymf
	Fd55UL9id5JYRDZW/RGhR6frlnO5M4c9WyeooGnVmN44ewHfS+SBBy5BaBrtoYhW
	Zoc3/Mx9VoRkEKrplwzxpvn8xMUq9QwRzcrS1M86vysyOd/gYPDwszboc/mDRHMl
	KDqrt1t1ImzXvdsC47RhN/waFn/Q9zpP3I0kVF02XBBZP6nw+DC+vpSYSBB7Htev
	5SZVPfrRB0/rthcWsh8Sn/Fpnexmd+dmvgzfDQRWS/OGdtjsLqabiQXCi0I7mT2p
	ipBFHj6Gx4u0dY0T2HevnRU9cFNCxDmURn7RVc6Vb0b88ws1MQypmRCQx90GksA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvq6shb8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQJmV031151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:19 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:16 -0800
From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: [PATCH v4 00/15] Hardware wrapped key support for qcom ice and ufs
Date: Sat, 27 Jan 2024 15:13:58 -0800
Message-ID: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KjY5zR7Wb7Z5kNM7GdqgFixxWWs-mXHx
X-Proofpoint-ORIG-GUID: KjY5zR7Wb7Z5kNM7GdqgFixxWWs-mXHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

The fourth iteration of patches that add support to Qualcomm ICE (Inline Crypto Engine) for hardware wrapped keys using Qualcomm Hardware Key Manager (HWKM)

These patches do the following:
- Address comments from previous versions (https://lore.kernel.org/linux-arm-msm/20231122053817.3401748-1-quic_gaurkash@quicinc.com/)
- Tested on top of Eric's latest fscrypt and block set: https://lore.kernel.org/all/20231104211259.17448-1-ebiggers@kernel.org/
- Rebased and tested on top of Linaro's SHMBridge patches: (https://lkml.org/lkml/2023/11/20/555)

Explanation and use of hardware-wrapped-keys can be found here:
Documentation/block/inline-encryption.rst (https://lore.kernel.org/all/20231104211259.17448-1-ebiggers@kernel.org/)

Testing: 
Test platform: SM8650 MTP

The changes were tested by mounting initramfs and running the fscryptctl
tool (Ref: https://github.com/ebiggers/fscryptctl/tree/wip-wrapped-keys) to
generate and prepare keys, as well as to set policies on folders, which
consequently invokes disk encryption flows through UFS.

Tested both standard and wrapped keys (Removing qcom,ice-use-hwkm from dtsi will support using standard keys)

Steps to test:

The following configs were enabled:
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_QCOM_INLINE_CRYPTO_ENGINE=m
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
CONFIG_SCSI_UFS_CRYPTO=y

Flash boot image to shell and run the following commands

Creating and preparing keys
- mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/userdata
- mount /dev/disk/by-partlabel/userdata -o inlinecrypt /mnt
- ./fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/userdata > /mnt/key.longterm  OR
   dd if=/dev/zero bs=32 count=1 | tr '\0' 'X' \ | fscryptctl import_hw_wrapped_key /dev/disk/by-partlabel/userdata > /mnt/key.longterm
- ./fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/userdata < /mnt/key.longterm > /tmp/key.ephemeral
- ./fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt

Create a folder and associate created keys with the folder
- rm -rf /mnt/dir
- mkdir /mnt/dir
- ./fscryptctl set_policy --hw-wrapped-key --iv-ino-lblk-64 "$keyid" /mnt/dir
- dmesg > /mnt/dir/test.txt
- sync

- Reboot
- mount /dev/disk/by-partlabel/userdata -o inlinecrypt /mnt
- ls /mnt/dir (You should see an encrypted file)
- ./fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/userdata < /mnt/key.longterm > /tmp/key.ephemeral
- ./fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt
- cat /mnt/dir/test.txt

NOTE: Evicting a key with HWKM is not supported in the current SCM call for HWKM v2 chipsets, TZ already supports a different call for this.
Changes will be added separately for these after further internal discussions. But this should not stop merging the existing patches.

Merge Strategy:

This is an open-ended question to the community and the respective component maintainers.
The changes have the following components.

- Fscrypt and block patches (From Eric Biggers)
- SHMBridge patches (Bartosz Golaszewski)
- Qualcomm SCM (This patchset)
- Qualcomm ICE (This patchset)
- UFS Core ((This patchset))
- Qualcomm UFS Host (This patchset)

It would be ideal if one maintainer can take in all the changes together since working with many immutable branches shared with each other might get tricky.

Gaurav Kashyap (15):
  ice, ufs, mmc: use blk_crypto_key for program_key
  qcom_scm: scm call for deriving a software secret
  qcom_scm: scm call for create, prepare and import keys
  soc: qcom: ice: add hwkm support in ice
  soc: qcom: ice: support for hardware wrapped keys
  soc: qcom: ice: support for generate, import and prepare key
  ufs: core: support wrapped keys in ufs core
  ufs: core: add support to derive software secret
  ufs: core: add support for generate, import and prepare keys
  ufs: host: wrapped keys support in ufs qcom
  ufs: host: implement derive sw secret vop in ufs qcom
  ufs: host: support for generate, import and prepare key
  dt-bindings: crypto: ice: document the hwkm property
  arm64: dts: qcom: sm8650: add hwkm support to ufs ice
  arm64: dts: qcom: sm8550: add hwkm support to ufs ice

 .../crypto/qcom,inline-crypto-engine.yaml     |  10 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   3 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   3 +-
 drivers/firmware/qcom/qcom_scm.c              | 247 ++++++++++++++
 drivers/firmware/qcom/qcom_scm.h              |   4 +
 drivers/mmc/host/cqhci-crypto.c               |   7 +-
 drivers/mmc/host/cqhci.h                      |   2 +
 drivers/mmc/host/sdhci-msm.c                  |   6 +-
 drivers/soc/qcom/ice.c                        | 315 +++++++++++++++++-
 drivers/ufs/core/ufshcd-crypto.c              |  87 ++++-
 drivers/ufs/host/ufs-qcom.c                   |  61 +++-
 include/linux/firmware/qcom/qcom_scm.h        |   7 +
 include/soc/qcom/ice.h                        |  18 +-
 include/ufs/ufshcd.h                          |  22 ++
 14 files changed, 754 insertions(+), 38 deletions(-)

-- 
2.43.0


