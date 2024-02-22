Return-Path: <linux-kernel+bounces-77030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B78C860045
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBEA1F2679D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6BB157E81;
	Thu, 22 Feb 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gxhfx8UR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B43153BEF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624869; cv=none; b=W0VlbLqGPYOscxoSlWhkDLgcRVJuwweJGSLh/jrJb8hBbYrSCmpumXhxbE80VEXeh+Infn++LlkVLs6dlfxYgXX7u8+ne8+xpGv76KOowPNeaO6SnGWKpSpmhGktMW1ZBaVNOmi9J8/uD0wnJvVD7NjldozG8p7qTFNnQFWBarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624869; c=relaxed/simple;
	bh=YKlPBD8r4IRcXRM3XhHQwr5xkXxCVZJ/7qUyz+oSKEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KYGtKqQ3qVtmura6fIkbIXA0HD6AP5QTR66VkWK1uN/ioMCfs3jGYUfG9tSSXczRqFKNNdQK7buB4I5daOQf5G89yYTox6rfY1EAq1iSdT+WAGVNsuJf4mt9kIaAeaWwb6HiAKPocPYl3GoK6ilG8tPpzdfZkbukU44rINhLG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gxhfx8UR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M7hxNb023334;
	Thu, 22 Feb 2024 18:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=We0QmKl
	+6/c5p1Jenyrniaqj62mY7VXHfWDmerH2Nl8=; b=gxhfx8URy65A6qZ2uK+uqy5
	hoYfnBrSLue91Z58LZT7Aj+KYEvMwanZdFIdixjMl8LWE10bl4OfdwM0Om5GLTZs
	ItSyMF4b5Fto/qM1gxa0gmn8ALAIcyQBIBPwRZQQPg0fddyW4sA1icGNgA9d31tl
	7YqcXfEMvesnVVbBXLMLgJmv3u472zfsuwHi23yv6XC/4ZcImTbD0V4i7hejfVo5
	a58BNhISbCMKz1KybGJkDwFm742+o8v3Wk6MSBZz9fvF9tiSCFoHUNM3cxobTF0K
	rwc4Qdn8vU5LLiourXcexbHqqM6IwiNA+L3Q5w4nGCT5V9xkSWvIk/q5io91vKQ=
	=
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24ahtbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:00:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI0sMM010160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:00:54 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:00:51 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 0/8] Refactor and rename request firmware API
Date: Thu, 22 Feb 2024 23:30:25 +0530
Message-ID: <20240222180033.23775-1-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c3yGpIzzzGuK1En9-nVIO1hJe56HYlng
X-Proofpoint-ORIG-GUID: c3yGpIzzzGuK1En9-nVIO1hJe56HYlng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

This came as an idea, when i was looking for nowarn version
of request_firmware_into_buf() but ended up doing this.

I am keeping this as RFC, as i am not sure whether we are
open for such changes in API or some refactors.
Please provide feedback.

Mukesh Ojha (8):
  firmware_loader: Refactor request firmware lower level functions
  treewide: rename firmware_request_nowarn()
  treewide: rename firmware_request_platform()
  treewide: rename firmware_request_cache()
  firmware: Convert minor inline function to macro
  firmware: Move module template to the bottom
  firmware: remove prototype of fw_cache_piggyback_on_request()
  firmware: FW_OPT_UEVENT for all request_firmware family functions

 .../firmware/fallback-mechanisms.rst          |   4 +-
 .../driver-api/firmware/lookup-order.rst      |   2 +-
 .../driver-api/firmware/request_firmware.rst  |  14 +-
 drivers/accel/ivpu/ivpu_fw.c                  |   2 +-
 drivers/base/firmware_loader/main.c           | 226 ++++++++----------
 drivers/bluetooth/btbcm.c                     |   2 +-
 drivers/bluetooth/btintel.c                   |   4 +-
 drivers/bluetooth/hci_bcm4377.c               |   4 +-
 drivers/crypto/ccp/sev-dev.c                  |   6 +-
 drivers/crypto/inside-secure/safexcel.c       |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c  |   2 +-
 drivers/input/touchscreen/chipone_icn8505.c   |   2 +-
 drivers/input/touchscreen/silead.c            |   4 +-
 drivers/media/tuners/si2157.c                 |   2 +-
 drivers/memory/brcmstb_dpfe.c                 |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
 drivers/net/wireless/ath/ath10k/core.c        |   2 +-
 drivers/net/wireless/ath/ath10k/testmode.c    |   2 +-
 drivers/net/wireless/ath/ath11k/core.c        |   2 +-
 drivers/net/wireless/ath/ath12k/core.c        |   2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt76x0/usb_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt7601u/mcu.c   |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   2 +-
 drivers/net/wireless/silabs/wfx/fwio.c        |   2 +-
 drivers/usb/host/xhci-pci-renesas.c           |   2 +-
 include/linux/firmware.h                      |  10 +-
 lib/test_firmware.c                           |   2 +-
 sound/pci/hda/cs35l41_hda.c                   |   2 +-
 sound/pci/hda/cs35l56_hda.c                   |   2 +-
 sound/soc/codecs/wm_adsp.c                    |   2 +-
 sound/soc/sof/fw-file-profile.c               |   4 +-
 36 files changed, 152 insertions(+), 180 deletions(-)

-- 
2.43.0.254.ga26002b62827


