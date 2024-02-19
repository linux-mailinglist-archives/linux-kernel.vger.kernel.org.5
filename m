Return-Path: <linux-kernel+bounces-71014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137D859F67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3458A1C211AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4922F07;
	Mon, 19 Feb 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VAuiwJH6"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70A224DA;
	Mon, 19 Feb 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334208; cv=none; b=DxHWUKX7BI+SbqzfjbLDiFGcvbbKN6YTPvZoyQpCJUgbdmTZYcR2mC3SF4BG9pxeBDzIa58txutjEu26D6lCV9SB0kH4wckzrWRRBvLPo0tRSwy4/ur3UhC1XA11NIFWFmWgvGRvNa5PTkJMOdoEw2/LmkX3KSZr3rpgILrPHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334208; c=relaxed/simple;
	bh=AV8Y3jWvW/uU3F4hBzhODHm48XAlcPdOgh0bT/BOrQ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrmWnDrTysdZkZzYCH5xB9SbmHvrzNYtCXEL6kTybeQ+KqOWpVd2TQ89Lwp2RVzi5wGx7vZiuqVGvxZb8X18m+1gGoskRhkdWIkEVWA//NZbjp1JDSw+9wXRynhWmx1+uxnNu6blmlvuwbAszWztlnjsvegkhPB0w4EG7V7sBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VAuiwJH6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J5CCbc012706;
	Mon, 19 Feb 2024 04:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=rBRG/m+Jjv9d
	p4B22guvkFy10+HI6rowOZyHqDPjmPg=; b=VAuiwJH6kPRejEyptZ5MwWiv9rre
	Cnx8JbQsyxXrYHKJHWq8ZuzNt6T4/lXOKLWym2TvFsvXv/b/oWOpmcxVKrGPv63/
	mWaoZb32f0u3cOSQH3VBGNYZcYJj9908fX+j4z4DLbMs6uQ7PLz6Xwr4NmWhLCgs
	6lvIyQSoh16bKOUVXgVgyPDD9lr9Kl+kJVVk3nncNGfcPrBcDCJA3hl1CChrVNxl
	juIaBE+HaLgCg3TIJ57EHzrpMdIuiDjAHbDeFzHiOZaU5pA41Phko/s0ogypfW+1
	cQBCo5zrHYl9zosjuKUDeQD0QyP4NlyP6cc5+kLhUULIMb2OzO0+hwIfHA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3waqh8efhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 04:16:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41J9GVIW062683
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 04:16:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 19 Feb
 2024 04:16:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 19 Feb 2024 04:16:30 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41J9GL62026899;
	Mon, 19 Feb 2024 04:16:23 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: max31335: fix interrupt status reg
Date: Mon, 19 Feb 2024 11:16:15 +0200
Message-ID: <20240219091616.24480-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: smHRUyvYVRO7dTk9vegDotgtg5HkSIHn
X-Proofpoint-GUID: smHRUyvYVRO7dTk9vegDotgtg5HkSIHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_06,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=934 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190069

Fix the register value comparison in the `max31335_volatile_reg`
function for the interrupt status register.

MAX31335_STATUS1 macro definition corresponds to the actual
interrupt status register.

Fixes: dedaf03b99d6 ("rtc: max31335: add driver support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/rtc/rtc-max31335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 402fda8fd548..a2441e5c2c74 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -204,7 +204,7 @@ static bool max31335_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 
 	/* interrupt status register */
-	if (reg == MAX31335_INT_EN1_A1IE)
+	if (reg == MAX31335_STATUS1)
 		return true;
 
 	/* temperature registers */
-- 
2.43.0


