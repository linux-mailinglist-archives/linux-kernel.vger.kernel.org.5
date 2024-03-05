Return-Path: <linux-kernel+bounces-93045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4501A872A18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE61C21B46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8512DD82;
	Tue,  5 Mar 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c+k1E8sp"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559512D20D;
	Tue,  5 Mar 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677151; cv=fail; b=mQ+kfyq749BK2l9q7P4YmIu4GjKa9myf2b69VHWEUi3tpGpjOuF2pT0EOhYeDwDJpuznMZj/ZYH9bY0fH1H8j9nonNT1tI0H2u25DvGFX+aQqdnMdyf4AKMPV96+xNydV5KLdYR/4K1ODxQg/uO7yGQpbPHfV+Vbmvy/ybIYKXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677151; c=relaxed/simple;
	bh=ECnrVbRzkHgD8C6yqjSuGdf7G+b69ly7zwYyxIr8KQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2OLMQrl3E6O6KF5uteIiIWbHnx3eXoXmF/36yYO25OYI874w/epURJM9k5Z80BXV5o8AJNFKHF4cPeb6OZI+n07jsJMdfc/MxmL9DmNwgGV4Dtknbfevkbkd6RLfeVv74PM5+em5iOO3YehRUXQ0mRZzmHpjhE8FJos9hPFjcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c+k1E8sp; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/ycXMfOqOQwJ79eZWI0wQcANwnJYQEB5eLW6Hz7ZDXuf9eyIPucf8/ZZeRLivaCwXj5f3lGnsD2RXwrYvctmbiuQktBk+ujpwdcBlUX3txywmJvuVMSaxpxJ/K4P36g/iJRYwKIyhVVInzT/lh/IY6s7h5PpjsLq9au0jAwtluz3Ljl/5r1VLuUeTyX7qICuPGBWmSAG6+S4kl+rbc/G/LoFoomPhI2sRU4FHqlchE2y+9cUvybveqSmQs8tnN7ejJfK4PUiGMLG+hrxVtUOWJ9rDb9gHl1EKObN4DgcJdaTnjxxnhfPXSziEGOToKBwwXqp2FTaRDdTH3eNkOq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KigzDJIRzjCau7t+OZt8V41M5faKqAe2b0ilMgga4VE=;
 b=gI+83pEP1VmrAR5TFMATXgktcvrjOZh9vDHGjZMBR9IA+kLBiLssLm2KT/r+9EWpw261njr6UcUf1hxr3eH3TjOTvBQOjT6XrZ4j7w7eHZYVEJ9PRJcrrGntL+flt0Y3oKlffUbk68/kexew4uWlr5JRnr9Tu6Z2JW/dM+OOiufasCv9wH60X3dTADJSvUtjkfgV6t5jh+AqrKZ+UhULwuL1fMlfcxcCKduPNqLkEVqs3AiDOzW9dv1isKhASH1XOBSzyUFTghX1vIZ1zi3C5He0qhNRte7kAtK3chjM2M0keo9WKsfqu0Lmml6iKZLCwsq/YN6b5KBjmilg5HAGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KigzDJIRzjCau7t+OZt8V41M5faKqAe2b0ilMgga4VE=;
 b=c+k1E8spZMeMTqC6Epcho9UsT4IyY7FQRa5DjMPx4t1IdGcqC5gp3d5QHCdyPx0PkVUoGfpBeBK2tpFUEBwNSHQ4zm1oH1RlU67utJWq6Wiq43ERpDI21s/i9lAk8fqrplbKslpCabiL55cWwza+t/Jv+vn0p/OLjmFPq45tH1E=
Received: from CH2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:610:57::26)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Tue, 5 Mar
 2024 22:19:07 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::2a) by CH2PR12CA0016.outlook.office365.com
 (2603:10b6:610:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 22:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 22:19:07 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 16:19:06 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 2/4] docs/sp_SP: Add translation of process/development-process.rst
Date: Tue, 5 Mar 2024 16:18:37 -0600
Message-ID: <20240305221839.2764380-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305221839.2764380-1-avadhut.naik@amd.com>
References: <20240305221839.2764380-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 46810141-e2d9-451d-816f-08dc3d624613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	68U0BZebJi7ViOBuRyIA6aqIId2TlhYCtLnJTK68t9TEm99c3BuOcU5PLCSafd3ASxh3wLcGc9mVZE6TFpoG7PFEwvdvmjG1nWSbfSR9oLYEFYA/TObnHvaCAQDBGbNPLwXYI55SkSKCLG+kTJ7Fo1On0Ni3NRKRRuyhs0yC3xqjqcyfp/9FtrdPe6U7mC+D9c0j7rZNgua3/z3DZY2eGoApkwdKW8+Q3X7fqbmYgGTO61AIqX/Of62guk2bLfhOnMNGtQULXXjqgUvxZKTP4+Un+CZ5H6wEVg5XYPg9HTAAz0EcAxGAQ8ZhE0FFfnn4SGYDdZsU9E+4F9Zn79uFqzQ76L+moB4sETlSoQgzkuvtx8YC5SBh7ZDdQfX3NTGi2j4/Z/+Q8XHwzi6X1omEf0EEVnmeIF+HwEMoTjgrZtuEft0DzDJrbJa0T5QeERSXEY4ZXlTC0RHBUiMRLhly40pD8auOwxfdF2tMZNOw/vKj0MlHZ2wf4J+FHcVe84ukvd5bTz/th3rJY7ltOBkpKBljC+qNPyB64GgGjc5aSBgnLQ/jLEWQXrDsY4MAAe8HnnwWhv5QvmRNtIBCAH2N2oqobolOQ+VCdfB4w6y4+wPix0N+0W9zASZ+aVOEe7fYlb614Zvb2FIOMjiO/KgydQkKNpr5mu8ZKBoS/Rpfwmf+5ZTHj4ynwp3l6ccoGdebtMhohw6htIHcCsYjivnhdRGxue554cas7WbBNLG5IS8vdGmXMek7ouYprgpEtf36
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 22:19:07.0915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46810141-e2d9-451d-816f-08dc3d624613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

Translate Documentation/process/development-process.rst into Spanish

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../sp_SP/process/development-process.rst     | 24 +++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/development-process.rst

diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
new file mode 100644
index 000000000000..41616249aa9e
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -0,0 +1,24 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/development-process.rst
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+.. _sp_development_process_main:
+
+Guía del proceso de desarrollo del kernel
+=========================================
+
+El propósito de este documento es ayudar a los desarrolladores (y sus
+gerentes) a trabajar con la comunidad de desarrollo con un mínimo de
+frustración. Es un intento de documentar cómo funciona esta comunidad
+de una manera accesible para aquellos que no están familiarizados
+íntimamente con el desarrollo del kernel de Linux (o, de hecho, el
+desarrollo de software libre en general). Si bien hay algo de material
+técnico aquí, este es en gran medida una discusión orientada al proceso
+que no requiere un conocimiento profundo de la programación del kernel
+para entenderla.
+
+.. toctree::
+   :caption: Contenido
+   :numbered:
+   :maxdepth: 2
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 2239373b3999..4892159310ff 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -28,3 +28,4 @@
    management-style
    submit-checklist
    howto
+   development-process
-- 
2.34.1


