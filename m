Return-Path: <linux-kernel+bounces-160618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E898B4025
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800151F23456
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D888241E1;
	Fri, 26 Apr 2024 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+mdO1nf"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA1171A1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159691; cv=fail; b=mZjqnopAljmUGNUoUXj0B11HwLMK0XBZ5y3pH48E+16JmYOLJeXyXInTEEkDjM4eybIuRV3aNVJYF+1FZion5HTHLUHieifKZzi1aZlr+6CHlS5rwsg2Q+bbQIj9kXRMAmwLWWGKPKbpmT0aEAy+6UoW1AWPMk5A/Stfs78uVbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159691; c=relaxed/simple;
	bh=1nK3JYRgXr4/cIVULMSvDbgikM9ISHQBp0gaM6WwCVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Pom8WfGx0q1MPRBXF2Ebm0URfoF6D2if+41Hink2YRs0XSWKRQw15+GEVJ18YyXcvwRBzYnUG/tpTuVMmHs1BtBnzw806gF/QzAzpefE6+s+5tg8lVKlZKcUa6A/m/siD2UM+qv5M44K2TGXtHSmLXC1sj11XTU+bT0GI4HEg8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+mdO1nf; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQKaQzZYvOIv31GkELCGlqOYYFvgARdceaAR5tXW8JMDfg/xdmYJJtLi7vF4P9+1nYdhn6YmtQAkWzFOHaNHsJKxrJsT9soK76tjHxtfGrpKAPid2rUvNyq6aYx18KUZGvXvit/DUjil8X21kCtzCdX3BYWkaoqbttdnNHdXJgHbqsBPR2bK49brxRD+brVWFqOCCBMfrwltZpR53R6dRYi3NYJlN2K9ksPbrBmrWcUK2dcONR4esAZcjNBRCDcnun1dQ3h7hMJkde+g9muTJodI790UXad0DZPD3oOB8Fnw8wbyRxeqTPgeeH/H2IZIgXo1nehveB5AOx2jWySrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMjbj3XLRM/v3Am8u9/T3JeIErzCcWZz7Yg4RAxXT3U=;
 b=fDTrBaEg2tNV3H5SGiC7mgFdEIhrMx0vcumXBe0l1zlskSoRo0vH+ad6pJxlhvVXeFscowBU35Vot22LaxE+ooLngF0irgiugN+Bm1DJt4zyhrUMouJmOkTYTY51UyMTHQpsq2Ic2ooSCdTywcCvcJea0BgROxhFORw5+Oab1xygKjQaSJPq80aG89c/Oil9pKFDLIeo0jwLoclV45cQ06OK6nwl0zzyAW1nQgGkpxu2P/Ph2uZ088/q9QC7ElLO7exU7eRntSq9ffv0uvsyXCkhwu+cYhZ4+I0MnplXfbw7nSwUAlLBF1lGtauxJTANshhfSJpybbCHPjlGUKNvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMjbj3XLRM/v3Am8u9/T3JeIErzCcWZz7Yg4RAxXT3U=;
 b=K+mdO1nfZTBxatXGbyn5tFyidRvCAVdVfDZZkOnSYb4RX5BA8grZzBk70hkZdSLgcEdfBUghoQWFl2RkDbyXeZiG2oflv3aoEGTVkxUEh+P0pAk3zE4b92AGauMrjTUFZRnZzTOcsyJ3S3qhWrFqbNmiZZE/WTwLW8Wrr22+Paw=
Received: from CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 19:28:05 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::6e) by CH0PR03CA0097.outlook.office365.com
 (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 19:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 19:28:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:28:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:28:03 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 14:28:02 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Fri, 26 Apr 2024 12:27:57 -0700
Subject: [PATCH v3 2/2] drm: xlnx: zynqmp_dpsub: Fix compilation error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240426-dp-live-fmt-fix-v3-2-e904b5ae51d7@amd.com>
References: <20240426-dp-live-fmt-fix-v3-0-e904b5ae51d7@amd.com>
In-Reply-To: <20240426-dp-live-fmt-fix-v3-0-e904b5ae51d7@amd.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Anatoliy Klymenko
	<anatoliy.klymenko@amd.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
Received-SPF: None (SATLEXMB05.amd.com: anatoliy.klymenko@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f71fd1a-f0dd-4f80-5e53-08dc6626fef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V29va29laFBTOVNpRHZnWWx3cU54NThoelJSSFdFV3l0NWFPQ05sL2hpSHBX?=
 =?utf-8?B?QThtMDI4b2FvamV2eXF1MjJaSWdqN0NVeFZVcHhEM29VVWVjRWtLQzNWR1RQ?=
 =?utf-8?B?Z0JyL0hTRHJTbk5uYlZGdGRlOWx0SWY0YmpkaUxrNEtwSkUveGMwVWhoZmVD?=
 =?utf-8?B?SmpWOEhXNzhMaTdCL1NHeWl2UWVnQ0RXK2FNWXdnM2oxVExmV3NYck9qbVBZ?=
 =?utf-8?B?clF3ZVhUVnJTcmVwZVdZa1BUdml5MzN3WHgyR2haUWJYNXUrM1MrbW4xNytN?=
 =?utf-8?B?NTBXMjNFd0x2bm1CbGR2T09qRnBtZGZUbWFTdDNUQUpqU0xxRVRWNWlzclha?=
 =?utf-8?B?d2JLWXZKeGx3YVNvR0Z6VytVQkJCSTRNZDVIaHJYeTZZSEZ2aDhEbWJNYVFj?=
 =?utf-8?B?YTJtZGdVR2Qrc1RCcXJKdEZleHNCcVBWMy9ha3ZQSEJGYzh0S2xjd2JKaXBr?=
 =?utf-8?B?NzFDcHV3QUljTEtjUklWQlNmYmJ0c1FSNnhJS2V0dnlZQm9reGFYemlsNGg4?=
 =?utf-8?B?QWZMbzRGRXFwNURpMS9DY28wZ3lUd2t5Z1pFQU9LcHkvK3dnOU1nYmYvUW9m?=
 =?utf-8?B?MFB5TWpkODYwK3NJOTBWK1llRUtPb1Q1SG0xaGJuNzE2bW1KbXd5dzRVaWVQ?=
 =?utf-8?B?UXVyaU1VUHBvR2xwSlp0allpRFdUZE1McUZ0bFRJMlFaSktkd0diTXB4dzBr?=
 =?utf-8?B?VUNVWHJmRXhHTzlFa3liRW1mT0hjVk0vVENBU3J3SmJobE1jcHVwWmNVNGM1?=
 =?utf-8?B?RTlwbUdUbGwyRkdMYlRmdVczd1pOMHczek9FbUZVRmZXZGdTbkhhVmRwOFZM?=
 =?utf-8?B?d1hneUNOeUhDNUtQN25Yc2ZIYktyZzJGUi8rWThTc2Vzdk9IaG8xUURWTzI3?=
 =?utf-8?B?NkM2eXFMNUM5Unhtc1lOQmJGU25UdXliWkF4WWlsMnh5TGxPOE5wWDRocGJm?=
 =?utf-8?B?VFRtMnpzSm1rVGtjaTRqNVhndFNiT2o1aS9ZZUxNV0ZEL3JpS0ZxQmg1ZkE3?=
 =?utf-8?B?UWd2NmFXajJOcmhSdXhDNHV3L0ZuaFcrMWUzc3dYbi9LajV3QWZQaWZNZGtn?=
 =?utf-8?B?RXpHM003Sm9nZU9YS1dYWUt0WDJYZjRUbFZrb0JsMXJJUHVzN3hsYUZxZUFR?=
 =?utf-8?B?WG9iM2F2MkVYZzBPb1lGRlhJcE9Uc1hoVkVJTHlRVW1PMlVnTCtHZHB5VWoy?=
 =?utf-8?B?akM1QVMxYmovL3hPNUVEZytzNkpqYVBYeC8vUjhvRjQ1VlpRZW9rVnVwZWxJ?=
 =?utf-8?B?eTMrWWNrT2xaTjRLUlhmSWdnQ2NjN1hhOHVUVDNXdVNQUWd4ZmJjaEs3b3Qw?=
 =?utf-8?B?RjJqWGVHd3dETmtDL1dQZmJBcFVXZlNFNjM4MS9IOVp1OHAwNU54cVRQd3Iy?=
 =?utf-8?B?WW9yUmJJdmxOajNhSStHYUVVdVVERVFub2RHWXdsY1V2Q3pWZHpvaTBxWFJV?=
 =?utf-8?B?dTBiUmQwLzlzWGR5ZXNkTlhZQk5SZEJ5ZStUaTZNY0k0TTg4WTltL1ZqRWF4?=
 =?utf-8?B?ZmdDNWtTZTJQbjVEUjQxYXIyNXd5dERvd21OcjA0dWNqWGdraktXVHlrTU9o?=
 =?utf-8?B?MjYvTjBSNmFKVFVNSDRMK0k5aDRiR3ZwU3B1SzNBTCtjNHZQd1lCbExaSDhB?=
 =?utf-8?B?VVcra2hmUkZ5REpYRmhOZGFsNzZOTGN3UjZwaFhlZlM5dXIwRlFiVGxFSFpI?=
 =?utf-8?B?M1J6a1o1WlY0bnBaZWRxZjNXQ3ovaEJSRCs1VTBhaUdKWi9FTHZUVkNVQzh5?=
 =?utf-8?B?S2REMFI5bXVrOFhzVXExaG84U2g3c0xkcWhvVm9ybTl5Yk5RZFZvc2VnSk9C?=
 =?utf-8?B?dVZqMkNCSnhTTjdRZnROQTYyYmNrYmJKaWh3dzlXOHlLNkhkMEgvTU9aLzYr?=
 =?utf-8?Q?neKmW/1RkPtKd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:28:04.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f71fd1a-f0dd-4f80-5e53-08dc6626fef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794

Fix W=1 clang 19 compilation error in zynqmp_disp_layer_drm_formats().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404260946.4oZXvHD2-lkp@intel.com/

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 423f5f4943cc..c9fb432d4cbd 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -981,7 +981,7 @@ u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
 	unsigned int i;
 	u32 *formats;
 
-	if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
+	if (WARN_ON(layer->mode != ZYNQMP_DPSUB_LAYER_NONLIVE)) {
 		*num_formats = 0;
 		return NULL;
 	}

-- 
2.25.1


