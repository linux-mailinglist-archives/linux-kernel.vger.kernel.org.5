Return-Path: <linux-kernel+bounces-38389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2383BEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC331F21EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F7120DDF;
	Thu, 25 Jan 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UaIUHbnr"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FC1CA8E;
	Thu, 25 Jan 2024 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178364; cv=none; b=mJutFWFHIivbCiAueR8iLhl0jmYLr3ELNvUdvZnTot9k/HTNWf4DTt5EJmI7DdGYNlrIdmWsy6QMfF3QELzIz8XN43fLup0XYuzHEgjxxS61CoZLF459tzqOjVnIB8h2PAoIF959vb3sIJf+XnhACYgWV4Ii2LKJZz5RwYcp8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178364; c=relaxed/simple;
	bh=w4dg95HncjAo56RiG38BZGd3Pzu7W8glNY+mUdjX5F0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge/c2T+bOOjDaRpd6QTZv5EWC8VIJrE7G+76SraNZYK+T7pGXi5egpzY2yaEuWZwhszHiGEbbxIWya0+8qBhqhil1yBkB3QZBpl/lvFRnbSw+gl+Xne0lSVfH8cba6AIIlgLWS/EhlrV0leOXCqFphhmtDk48D5RZEhmPCAhxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UaIUHbnr; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P7paSQ014010;
	Thu, 25 Jan 2024 04:25:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=FLv7KEn1hB6G5vu93/SxG16lAdj5fv2FDse9aetjLWg=; b=
	UaIUHbnrCAIrFSGmVpG13iFn+U/x+c5KTHL4uklV3VsGuXeGEmk1CwHE8a4wIjDJ
	1mg6ufhYYtya5UK/mlSoIuxrJ9HUtXITzaUSGtaG5+BV0c+5swBCF0YKiyYt2jD9
	bFTpEu4zymk8uOnH2FkUuaUmFRPrTGhUOoZ225ybXszMDZYjlCe6QE21sGLxo3Nl
	CDmbCESUa1S+gJi7AELWOvmdkE5BxMQ35VXAUeWyqJIgghv3HCdGpaz2hFnV8kQb
	IMOHaMkQiwApZOUvtWQcm+YRrNyfd7Ts4aD8H2mgHXiDO1H/rxUjnq/DI3Uyf6Lr
	2gKUClBe1vdXEQtmZ+nEXg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2gh-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:25:59 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:25:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:25:55 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8785882024B;
	Thu, 25 Jan 2024 10:25:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()
Date: Thu, 25 Jan 2024 10:25:55 +0000
Message-ID: <20240125102555.2621736-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nE-1YVLqE_zLrdwjYugUTb51CZuhJ-UK
X-Proofpoint-ORIG-GUID: nE-1YVLqE_zLrdwjYugUTb51CZuhJ-UK
X-Proofpoint-Spam-Reason: safe

As it devm_pm_runtime_enable() can fail due to memory allocations, it
is best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 drivers/mfd/cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index aea0f8f485785..56bd9dbbe10b0 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1065,7 +1065,9 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 	 * the boot work runs.
 	 */
 	pm_runtime_get_noresume(cs42l43->dev);
-	devm_pm_runtime_enable(cs42l43->dev);
+	ret = devm_pm_runtime_enable(cs42l43->dev);
+	if (ret)
+		return ret;
 
 	queue_work(system_long_wq, &cs42l43->boot_work);
 
-- 
2.30.2


