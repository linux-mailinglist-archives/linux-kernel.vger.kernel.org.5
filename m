Return-Path: <linux-kernel+bounces-93044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20702872A16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE611F260FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0F12D74B;
	Tue,  5 Mar 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XWQCrCW2"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C301292FC;
	Tue,  5 Mar 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677143; cv=fail; b=nTZJLQzvRdWqlpYhQ7RbNwStp2C8l3OMpOyPgwNPsCmG1/VRr46x4QUNOju1UcZR3jIwMPf7EsMynEOXW+BbJlIqlyhIDzo//zSd1kMwIYeHbrdPZOebrGJaadq/IBh/Bgc3xQazJC/kpiFv2du8BmKp+z4Ng5+AbPQT/L/s7a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677143; c=relaxed/simple;
	bh=+8EyHNLzJ49N0vtQQ95NkSuR5hr5f8Y6PbKCO/AppTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR+JtaxocOeKWvZqG289pG2CJbRZjFL3l9aKK+zQITZEaiZ6JMvD5ZKU61rmBH43TFdpCdAdXz3Gtvmz7UvA7oVMa5aqT+COb/KZpJk3Vw6bI2P4vWLccGGSdb3TchzsbkchI8oK2wLDPib8cr8j3UnjESSU0odfrO2+WJ/qpS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XWQCrCW2; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCj5GlQwWyO8aZMmHy2ciynpJMGbQW5JUXZK+5SE1vwLKp4vitbAFtPrlurG2CQKD3TAwqYU9BWSeNI5o+4DRHot39gqMpHRZMOxEWqLwIM17Xxq19kvdkK81AOTxYCCJdlULILg/cOUpGJMMheammCky5znC50sbBe3KMflpNerLK/yamNJP5oHqyF5itZ1nYp3Mmb4bURjwr21TA+xNLgaILVpmqPMtzBbRJuW3c4Zwb1xhG/9ytxlc0cItFPCVK5CVIAbiInwW1skLWgSEE8gjurpp3DVv0iahLIZWr0H/gYe11Ho+k8bfpAJP0SY0XJgihjZ/EzlIB/amyrCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fevx6G7xMv/hd4H278G13QKJr8EWbXn4kXdtafzIMk=;
 b=MUReypgKDn4gOtnVhRAJHi+P8W6wDUz5Fnl6WKvgZUZ9kCePH9+GPTzCZDzMQWCDum2Ckg5JoRdFEv4+OaC4yDpL0Td7MtlBQdKRUVrLsn15tQkcXeCRf5yVJMj+9/eKQu0m78QcALX5mHg5mPLWkI+p9zoHV2XXrmvoANv3rDOqdQPXESPqYj5CQUuDyAII2/U73xaUVbSsPBwHiVbuCy8uLRZIB8FOpFoaPuzyf6lYm0Dw/ufLxraEg8UuXSkUo1w6c4dcL6HzKADSpchfPTnzj91kvalpIbhwEx+6jl5ofTsNP9XCaqbZhNF0+twTK3DnFjl53AYxbR0bAWlIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fevx6G7xMv/hd4H278G13QKJr8EWbXn4kXdtafzIMk=;
 b=XWQCrCW2MR/jpkhbjs5KpG+aIk6XSxOhu/J/Yaf90Mat7CO9D7JrjpBS6exEZhkxVBlQIidLZamXc+IBKoUTQRBuXjDUFKrp5n7NQyVLprwCKBkRVfid5pZMqPxWNARJJsZ07BKxn7TNbOCW9/PsKYPaKN34SgfXH4Q/uuhVymg=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 22:18:56 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::67) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 22:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 22:18:56 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 16:18:55 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 1/4] docs/sp_SP: Update process/submitting-patches
Date: Tue, 5 Mar 2024 16:18:36 -0600
Message-ID: <20240305221839.2764380-2-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8e6eef-583d-40b4-2233-08dc3d623f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I1B8jFdkdrYFgfa35CqVcpmP4vV3QWUO1W/9RvMN8De0Zktj5kskCAbTId3yA07hGWuEfoyR+FSGmR3qO6nEG45aSAWJhxa+QGPl2QoqdKLI35Uo9hzJvvWo8XzbW4E7MuilDu5VsdC7nRHPqN+g8FgJZqvEVk9GSNtjDBzUwEMPASsLdXKthU0xRj5FJXe2dwJ9G7oDbxYVE+/FdP1NO5VsMrK8AV3sW5ZOEKyUBlRmMIelJktStbSH3zrfzvsaH/xWj66na/EbRkh4tf9T8QVt3B5bEpW8Ci4uuoR2FXuNAkIAVoFqymt/XjQHYgXX/n59rDtodr7jTGKQEEW8I27MJwvi8qolhX70svhqWt2zDbuaxR/NTCywhLD7H2BbLnpnsETUbkg6wXerIdk9hCbWnW83Ho5L8x8eGOJGKMdFOkPgpGAR1Q9M1CwAui2HQrBDTDPEOTBPlYTw2lILhq/DMBsGe33P5i5H4wwzSXPpPNKSgTP/czoHlV2i/k+wW5ZL7QyDpNRyMfSucwdkmpkpzCKUqQKMHUuWFxFaVNOnxWBH/bh0h5GxBmATYH22RomsWInUTVTKgPhvtSxT5v2Be6a2mHMEYTe6fqI/A1JwSU2z4o6wmKcXDIy0rBHDGib+/pWSdXuAQQ5sW4ofKigUPhGDv7dR8CWvTmHcvc938RjS+N49JgmETvlgYBml2hemLZ8THDcVQ1U13j0Okw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 22:18:56.2363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8e6eef-583d-40b4-2233-08dc3d623f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

Commit 329ac9af902e (docs: submitting-patches: Discuss interleaved replies)
updates the original Documentation/process/submitting-patches.rst file.

Translate and add the updates to its corresponding version in Spanish.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../sp_SP/process/submitting-patches.rst      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
index c2757d9ab216..3b35566db736 100644
--- a/Documentation/translations/sp_SP/process/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -356,6 +356,34 @@ Consulte Documentation/process/email-clients.rst para obtener
 recomendaciones sobre clientes de correo electrónico y normas de etiqueta
 en la lista de correo.
 
+.. _sp_interleaved_replies:
+
+Uso de respuestas intercaladas recortadas en las discusiones por correo electrónico
+-----------------------------------------------------------------------------------
+
+Se desaconseja encarecidamente la publicación en la parte superior de las
+discusiones sobre el desarrollo del kernel de Linux. Las respuestas
+intercaladas (o "en línea") hacen que las conversaciones sean mucho más
+fáciles de seguir. Para obtener más detalles, consulte:
+https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
+
+Como se cita frecuentemente en la lista de correo::
+
+  A: http://en.wikipedia.org/wiki/Top_post
+  Q: ¿Dónde puedo encontrar información sobre esto que se llama top-posting?
+  A: Porque desordena el orden en el que la gente normalmente lee el texto.
+  Q: ¿Por qué es tan malo el top-posting?
+  A: Top-posting.
+  Q: ¿Qué es lo más molesto del correo electrónico?
+
+Del mismo modo, por favor, recorte todas las citas innecesarias que no
+sean relevantes para su respuesta. Esto hace que las respuestas sean más
+fáciles de encontrar y ahorra tiempo y espacio. Para obtener más
+información, consulte: http://daringfireball.net/2007/07/on_top ::
+
+  A: No.
+  Q: ¿Debo incluir citas después de mi respuesta?
+
 .. _sp_resend_reminders:
 
 No se desanime o impaciente
-- 
2.34.1


