Return-Path: <linux-kernel+bounces-150235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768DC8A9C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A6B1F24334
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D616ABD8;
	Thu, 18 Apr 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BwpscZgx"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F226165FCF;
	Thu, 18 Apr 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448896; cv=fail; b=pcbHv57wsNRSdTDBGuMV6OxpqR5n6L2Dh56igBiWps+5haEvX6ihlGbXB+P1ayh00wkNxXyGWMZ1xaViH0Otk48RMKYFP7t087XXTpOdSEe4PNWAP+TA/39DgwI2cR7BZD3TRjYaLNA/HJC5+xBoKJqaBDQ+CWcsG3fPhd8j8aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448896; c=relaxed/simple;
	bh=F+jsHQ2fTSJ0lj7GgpE9iq0tO84Tuzd9vJ8+GCZrqJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cz0LF4o18fvWPBmn/sgQzD2h1WP56cxL28cRljXTXZ+ODnyMxVrTvpBgjuuhUw2eqjM/9ijIgzit6j0kK95R4YIvbBwFwj6mnhdzmfM4YQ483s5hEydfN35BTyCN/nQrXTkvELKehW9s/n1uLHExCSEf0+AoJWkOIuUaBvLoOv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BwpscZgx; arc=fail smtp.client-ip=40.107.8.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ5dolnsZHfE4UzHBrKiF2SNeOitgK0VR1FNzd3SQy/4x8Z4HDsfXfbK4KNQyMjbgwi28busqK7WUB5bBxTcvMTM7s0R/R7K8RCwfSZdug19WbPMordymr9X0WGTtHsjClSpkNlOwUsBT/i7DYb3lHxyfurXPeIdvBaMT1qw0MseE4BR2rJQXvjzl8h057aZa8OObl8ab4e0FC16XhZwaDe+f4NdTegGnNyqav6tmFh2avzaqKUwvjARHlfFcc9lu2+lrViPYk66womqjCwa+e7QgUATZrgndEW+Sa3vvSVwNyFU/MF6NkQMG9Eydq0P0sxkXjww3630NdAbrjlLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvDd4WZ/FXu6kJbvOJ1cc5VZdmsmYLjcGRKSXqgnvuA=;
 b=HgcNm2/vVM1SgLkFeLa8efiyxC3GeYIgqU23dvtyoeoBpca+CGZ2mn+uSn7WzZ62hDylRyE42MO7QRO0BjIB8jCx/ZXPX79PgdqAnWjpaLpHmfSoIEK+KKfeussUcN784XJgpm5BCclTMJFqvoG97bZDTgdLVym7BBUpiXTj42tS110fORiHl6hSwWjl7c7md4vf0wKrOQyCp3SfxMu/77bqaMZ2oCdvLue7wSyGwvi9hcVaUy598Bq/jlIKgDuyJt5YTTnobbYk4rQKGM+9okqSQSA7zwapfGdTheWfdT1ioeeZhryEmGhLhchNd84TDEoLDqcuHQmDzxgR1mJx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvDd4WZ/FXu6kJbvOJ1cc5VZdmsmYLjcGRKSXqgnvuA=;
 b=BwpscZgxIEuabAkJTV77DUe7C0UlDrbGMfhgi/fs9rkvm96eXHLV++WXC/2DUyzcjD3h0E1eZHZrp0Zv8Pe4eOJJXPLL4ruLdSyYumhFXNgLBqAllXdy1JY/8v/RBM+niEUWgViHQGjDMLlAMb5pqazynaNm4FrVd+36cXQUYss=
Received: from AS8P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::11)
 by AM9PR02MB7041.eurprd02.prod.outlook.com (2603:10a6:20b:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 14:01:31 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:330:cafe::2) by AS8P250CA0006.outlook.office365.com
 (2603:10a6:20b:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 14:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 14:01:31 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 Apr
 2024 16:01:30 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 Apr
 2024 16:01:30 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 18 Apr 2024 16:01:30 +0200
Received: from pc51235-2237.se.axis.com (pc51235-2237.se.axis.com [10.96.29.3])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 309AC33D4;
	Thu, 18 Apr 2024 16:01:30 +0200 (CEST)
Received: by pc51235-2237.se.axis.com (Postfix, from userid 3319)
	id 2CB8F4112992; Thu, 18 Apr 2024 16:01:30 +0200 (CEST)
From: Johan Adolfsson <johan.adolfsson@axis.com>
Date: Thu, 18 Apr 2024 16:01:15 +0200
Subject: [PATCH 2/2] dt-bindings: panel-simple-dsi: Add generic panel-dsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-foo-fix-v1-2-461bcc8f5976@axis.com>
References: <20240418-foo-fix-v1-0-461bcc8f5976@axis.com>
In-Reply-To: <20240418-foo-fix-v1-0-461bcc8f5976@axis.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
	<quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
CC: Johan Adolfsson <johan.adolfsson@axis.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AM9PR02MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1223f6-eb19-4812-f850-08dc5fb00ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Kt+GqcWAHrOf+dnuwj2Bh/r10qiOp3KaV12YYzUF9/U912JAYVUhuCquMQO4Zdm+ZinrVNIqkKNspuiEnR72zvjAh8DlxGD1USmk8eK/aOgVUVPbXV3v/jzF1W7ahF3sVHjXbHV0cIVej/HatCcf6HASNWq1h4LPUyK19UJlb4mTWJE0P6m59Wl95+/toV4gJUO6rw0M/pnajxN510JqmprIYj9RJLQQt6TiCM6Oz6pLLWmAdM/dFE+QDRSoN2jbUL4rdzd+XW/QufUQkgFsB/OCOIKgGV6WhBFepWqcNOpIoFei9325jxXOb+M9OsTIKt3H3syTnYhwuWeBajiM0kXOdJzzqPKhXtI0nNMOpVbtKGAPyWZP6mWk0kZyXouYV2V3cdPsV+/9abxokh5Gh1J1fJ3h06omNyser4bUXI7lDyaZeHOxb/4e7KliFfMbfCOmnNAtZVP9+h0jA+IgwOyLQhuvt8B1bsrQ7UjnU1X0MEY5Vo8629EptXAj+5nK9476Z0YuCOw4btPKMntgQpML13nu+2/yY/J2AuXuOC/lOG4nw7UoQKFBerDhSJ7XSJ4/6xHqRxuwIIwkgpxUCI0Ncza7Qkx1GieJbDUFJ360nweaCfxJBhrOgD8nYrlBcB6GGYntnLrxyGj1BW3a6g7FnU4qKiEvQcKVtWEqK1aiSwmtgZhIK/UPyXuwUFjbhzWgMKb0D/U+lwMrFwAJiEch8yUQ16vf7OZyYPPnfoC6v1d5EwqZykiUEhZtnyrZGHSlmKDtI6PdTG1USZdGw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 14:01:31.4292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1223f6-eb19-4812-f850-08dc5fb00ce3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7041

panel-dsi is similar to panel-dpi with overridable timings

Signed-off-by: Johan Adolfsson <johan.adolfsson@axis.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index f9160d7bac3c..4c9dd4f66a8f 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -56,6 +56,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Generic dsi panel with timing overridable
+      - panel-dsi
 
   reg:
     maxItems: 1

-- 
2.30.2


