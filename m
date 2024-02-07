Return-Path: <linux-kernel+bounces-55786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC884C1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C74A1C23F01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46A1BF3A;
	Wed,  7 Feb 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VS3yQeN9"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CE10A08;
	Wed,  7 Feb 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268530; cv=none; b=XGmIp8juQNpn4hvoTw9CFrQAziqu4YKQALhFlhT3oSzW0PTOcH8++ZYyLt6UQNVQdf9OrZm5mpJGIsUN91tIvEuyabTtjjerIYbRJoKgRWzPw8pxlnJVdZYFtAJw/xr+TJcHXSeFziR+Ma0OlP7maVO2H1QtAfwZhqlM/dpy8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268530; c=relaxed/simple;
	bh=PaJV0dwJCY3rLy+k1vVDwWO2OPl7I28jlWl9NOqIFxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXzjcDo0Y2+xzQSLaScsGxAi7OhJTZUl7BKtift0GCVzHeGhWEO0nr7pQeqtvXrJpjW6iFbhZm2ZNME7w+8Ttr4p3RI/1J/wTQTAXP7IstUJdG4FJY3H9UOMXI4XtEfdn+6QR7Cw8mwGIaZrE/qaEdc8yzfSSAdHmpdhuWvCkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VS3yQeN9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKi0101975;
	Tue, 6 Feb 2024 19:15:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707268520;
	bh=RdS9TC8rCGy1b4uCt4j3JAyxW7QaBSflgKOBRehwNis=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VS3yQeN9FmTK2lIOgSJIEo7oXesNFy4mXc/ZHPxsvODPQQq7ewKIWEqjfY7cuUoUx
	 hmjfmGJot7n+R82pfU2w6uG2ILVM79pKe9Xf5Kw6ZOa2O7WewFe+228PlEcFEDasYz
	 afrqtylSzJ/m5RFhOCfEe13O65gjD8vma7+3GTGI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4171FKsk114486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 19:15:20 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 19:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 19:15:20 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKMs122103;
	Tue, 6 Feb 2024 19:15:20 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/7] mmc: sdhci_am654: Fix itapdly/otapdly array type
Date: Tue, 6 Feb 2024 19:15:17 -0600
Message-ID: <20240207011520.3128382-5-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011520.3128382-1-jm@ti.com>
References: <20240207011520.3128382-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

While integer type works, the otap_del_sel and itap_del_sel
arrays are manipulated as u32, so change array types to u32.

Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
Fixes: a0a62497f6aa ("mmc: sdhci_am654: Add support for input tap delay")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 935f581c05d8..35ba7d921690 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -141,8 +141,8 @@ static const struct timing_data td[] = {
 
 struct sdhci_am654_data {
 	struct regmap *base;
-	int otap_del_sel[ARRAY_SIZE(td)];
-	int itap_del_sel[ARRAY_SIZE(td)];
+	u32 otap_del_sel[ARRAY_SIZE(td)];
+	u32 itap_del_sel[ARRAY_SIZE(td)];
 	u32 itap_del_ena[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
-- 
2.43.0


