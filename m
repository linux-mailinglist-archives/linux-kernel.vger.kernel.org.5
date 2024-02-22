Return-Path: <linux-kernel+bounces-77032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BD860047
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566181F232D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A45A1586E8;
	Thu, 22 Feb 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FkHtVP94"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD351586F8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624875; cv=none; b=R/aoUVNcAgn4bsJiUUXYta3n9WL/x5X671+6yZo7XLldPO4iD3Dr8SofMXPqE+RWClkNen7yVuJBlUKGzYw8CLs3gykdu8kPGyEKvzFpFVYUwVwbWXKoSkRpAjkQeby9ezkMuvv3DzUZWAFgpCchJcjQHaNuFTxfL1UCjX+fMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624875; c=relaxed/simple;
	bh=RgR9aBJw9y7V9Rf10WSajNb4HmsteDZ5lf2W6UUWe6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAHfefd2VsfgaaMWZ/3PqbzmcitOudwHHKMoo5X8jdEdPIpzgLIXlyHYm7IWK/bkKoe59ZLYhjyDUMrXn7d3RZVdLtPZ19HjWjD225nFZCqq+Xn9URagXEtWYxu4kTKpw7rQB54fRjuOkDnayTCz91COH5UPjihWruiYUtCyXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FkHtVP94; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MGqhWD002357;
	Thu, 22 Feb 2024 18:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Grhe6JChjsoQRJF11IInuLGjhs+R22cmVJZpCJeZ6/M=; b=Fk
	HtVP94SgT5IYN3aIHGR5l2H8Lr6fsZKluQAXSk/WWipG0QN4UDhyGUjkFiBsk51L
	hOn+n7cIs3st5kY2SpOf48lsknBM6V+lYl6xqdF6yPvA5qERFU4kGzFU/OtPmgHn
	CHBnyQe0Kz/Yk/7fsjYOcFa7Jg3RyjQfztBkbchDoz0WT1zFBUuXxmF96JbNPh9O
	v86GdO/+SvbAJ0lXpO/33/oOPzQdZsAl/pqf/l79Hm18YuuIkhl3anQPav4jxR86
	mkzl0N+fHzOsNtWeSQi7oeXMvCCC9ruKHucHq0Vjn3CPU/cXwwxnIANl+mAdVHSY
	+C1SfORPV9ri08x9DL9Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24ahtd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI18RZ016274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:08 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:01:06 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 5/8] firmware: Convert minor inline function to macro
Date: Thu, 22 Feb 2024 23:30:30 +0530
Message-ID: <20240222180033.23775-6-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: mC9sC17vTul9WfDi_jq4kCkCmo1CQDnX
X-Proofpoint-ORIG-GUID: mC9sC17vTul9WfDi_jq4kCkCmo1CQDnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

Convert to_fw_priv() inline function to macro.
No functional change.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 2823dcd7153a..642b4d5c4375 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -80,13 +80,9 @@ struct fw_name_devm {
 	const char *name;
 };
 
-static inline struct fw_priv *to_fw_priv(struct kref *ref)
-{
-	return container_of(ref, struct fw_priv, ref);
-}
-
 #define	FW_LOADER_NO_CACHE	0
 #define	FW_LOADER_START_CACHE	1
+#define to_fw_priv(d)		container_of(d, struct fw_priv, d)
 
 /* fw_lock could be moved to 'struct fw_sysfs' but since it is just
  * guarding for corner cases a global lock should be OK */
-- 
2.43.0.254.ga26002b62827


