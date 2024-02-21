Return-Path: <linux-kernel+bounces-74042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658285CF34
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF531C22E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2B38F94;
	Wed, 21 Feb 2024 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Z5X2Qhzx"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFBA35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708488214; cv=none; b=XO5tssoKUgVpiFqm+5bG/Ds0yKalAr4ZcPYvZDMCp2FES7kkEM+mcHcdMTMbHOZvGNUlfH2KcjIGSUgGwmOxFuaJ/rdgWoT4Hyt/u4hhX4MtF0CvzoTFiw4sAeutF+TLX4GNG97qAgNX0yE2leBcdJnzdUcq6c5Z1FQUaAYKH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708488214; c=relaxed/simple;
	bh=aT1sdl9ayXkLB2xeRs1vuCR8KdWKTWCt9bQfCMleplQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8iXNI/pL3SxqzPc0Z6UTBwLrE2kYohRUd12ws3wHdwc7dx2/7Drs9dAL+VLCs/X2r9qC7S27hk5YSOxcRhlXdcUfpGbzV3lEKp6fiy5IdeFn8MxOzBaLGSu+lPX99+uFuh8dQTK8bNajijWllldlgAdbvR86Ff8uItZbO4lClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Z5X2Qhzx; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KNo9u7021805;
	Wed, 21 Feb 2024 04:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version; s=pps0720;
 bh=p7N/Fss8yHIOqOkiG91vnjHgkvgIICzI0arBtQWEIDc=;
 b=Z5X2QhzxJCEUlJ5N+u6+I/qDdv4QpAb0hzmsa3InV+rPa8WSHME67ZU2w3h4pPyE7UNZ
 6I787fBlrkCheGnrB7z40328fDv0qFmtY6P/u3AI+hxY2jGbzQQLK6Xi/rZjuqddDpQ0
 hBpjW+u3/FLoNLeBwRIAgxl0esWiN0HTGZLT54xg4kHz/zWZDTEdj/Tj1fXG4EYMppBO
 N0uqmfcSL1j37bo4gYbuLgT+WOXRahiVHX/1G1CP7FvcTC6HQzMQoUDQiEuhyVUCAcV0
 7k9B+qecgUEal/JStxRuRA76fQJeKj3gUsx3aylSLHVPnlnj/Hr5gXiIqjWVFJJPXyNu AA== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3wcfmtpujx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 04:03:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 14903805673;
	Wed, 21 Feb 2024 04:03:13 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id CC9758003AD;
	Wed, 21 Feb 2024 04:03:11 +0000 (UTC)
From: matt.hsiao@hpe.com
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, keng-yu.lin@hpe.com,
        matt.hsiao@hpe.com
Subject: [PATCH] MAINTAINERS: change the maintainer for hpilo driver
Date: Wed, 21 Feb 2024 12:03:07 +0800
Message-Id: <20240221040307.23019-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-ORIG-GUID: bLLwUCtHOgMsOqij2BuGE6iotzQpIOkq
X-Proofpoint-GUID: bLLwUCtHOgMsOqij2BuGE6iotzQpIOkq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 mlxlogscore=766 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210028

From: Matt Hsiao <matt.hsiao@hpe.com>

Change the maintainer to Keng-Yu Lin as I am moving out of the project.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..f41e77672dad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9426,7 +9426,7 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/hdpvr/
 
 HEWLETT PACKARD ENTERPRISE ILO CHIF DRIVER
-M:	Matt Hsiao <matt.hsiao@hpe.com>
+M:	Keng-Yu Lin <keng-yu.lin@hpe.com>
 S:	Supported
 F:	drivers/misc/hpilo.[ch]
 
-- 
2.16.6


