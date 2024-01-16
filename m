Return-Path: <linux-kernel+bounces-27023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600C82E94E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E471F24153
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB31111A1;
	Tue, 16 Jan 2024 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KXZzl4p+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723811193;
	Tue, 16 Jan 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G3v8ZG013344;
	Tue, 16 Jan 2024 05:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Mj8/AyNRT7fNEiR0tzfDTVBb78J1oJHwRqPdxSbo124=; b=KX
	Zzl4p+uShJLiYESvZEu4fDEctYpsEppQS1O9R09xmiBiwpN2rT/z0ptA/nWB3KRr
	ksKPVqkd21uMwnq802MdrexhvbEiPn4qyD1ZBBzN/18AZStgvA7PInCFUmpuIdc0
	083yhGoXjc1zZvqXIBhGyXOcd0ArTlnpYLeFerkq8PkVDFMItY0Z7Dd67mYrPX8x
	0NstGcHerzBlMFwQ/BIxkwGOvnwqmB/Ba0GULjV7rT36RcQKHr00Y/7ReVcCY8T+
	3mMl/XtYTE32gG6tpVblbyjT16XsAZPpiB6d7S4CmLr511GqBulV9VCKhpZ3VT4u
	YZxWSDzs/u7HObrwq85A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnht908am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:58:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G5wZ4C027259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:58:36 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 21:58:33 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Prashanth K <quic_prashk@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3 2/2] usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK
Date: Tue, 16 Jan 2024 11:28:16 +0530
Message-ID: <20240116055816.1169821-3-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116055816.1169821-1-quic_prashk@quicinc.com>
References: <20240116055816.1169821-1-quic_prashk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eZlwjPnm-ELeGCMaUlyqBTvYb9WtkKRQ
X-Proofpoint-GUID: eZlwjPnm-ELeGCMaUlyqBTvYb9WtkKRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160044

Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
which fixes XHC timeout, which was seen on synopsys XHCs while
using SG buffers. Currently this quirk can only be set using
xhci private data. But there are some drivers like dwc3/host.c
which adds adds quirks using software node for xhci device.
Hence set this xhci quirk by iterating over device properties.

Cc: <stable@vger.kernel.org> # 5.11
Fixes: bac1ec551434 ("usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f04fde19f551..3d071b875308 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -253,6 +253,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
+			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
-- 
2.25.1


