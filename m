Return-Path: <linux-kernel+bounces-81806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AE867AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10C1B2F562
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AB12BE82;
	Mon, 26 Feb 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o2fJMto6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E44437;
	Mon, 26 Feb 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961399; cv=fail; b=PzWz4Rg4o2yPbZIval26qz6wph8VHGr3Es0Z6zHIj3d3VXZQALVfGMAlMHtwS5VBQxX4z18BXTVcB+/IsLlTGELywXliZk/BKPZ9K/86eAINVz7TzOsHNHrQONwN96aFC5ZK6mX1APU+UTWbU8vz0pdRyS5AlPoTOt3CzMC9osA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961399; c=relaxed/simple;
	bh=CZ9B5aDx6l9+235keTD7e4ysYo5zBFRaOArBl4Ctmrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkbTDyEXB2UsPfy+bDz9yD+kSPKiz3TWehLm5XG0fMzIrmGQje1M4TSuWzO7D8+2wC6QFKVTe19ptDctVlugJfM0NrKKovgsM/7S2mZdu6My4CUrZnct/EKQWsVJAjzb/cF0xt7XWcLNfHEp72DKbCJ8Os93M5xrN8eSLEdb+lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o2fJMto6; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/OpBAuM9u/km7DdLRNc8iNR16FKzBjq6IyQNpY0cdxLzPssuw1ewfNHrMzy5/OqjNV+UqvOqDl6dcvay0kq43jSxeHTEvdxt0ERU82PNXCJDdHCDgRhj8j+9uC4oMRGF10eGZdqyaaIZykM8jOlCtkYu4BFZkxchPL9CxvJBjzh99KZ4xkkYCbtcdEYyMtAKGH9evhnvRgNxZe37xfJ5NkJGMpOZ3osq9n2Zee1ZGUWMfG0kRpx6nBDg1tiFwBU/RM7qUxnTyXr7IDaUGVoJS3ia61jFjunYep+ah6mlGlMg61OjuTvimYsc/77rYf6JYQEyAMhB6r8KIQ+cZX3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyXhMVyv4gwcxUsD6b+bkksiQ8IvIdgTZcLZg/84MFk=;
 b=AqhG7jln+GaKRjobOgWoBaiVAc2m7gj0kKavRUu16jL0k2MRmez2nAU3TDWVw0/BJsJYIoN0l+WbIJWi9okPafu6QqK5HqMghtMfJLFMfW61XiXYFxqMezrnNzdL2R5+yZsRoH+UCtaqP+KrREXpyPknHsH6ynXTDs5J5GR9tfaM8LCzgSVffgO0XH5v7Cp0vfA0puBuREJdUWtOq7+pjOk7wp/cyGAF5lJ3eNgnwm809Aa6qrfDDj7F9/+OeGTB1MVVIqwz2z/ySGFy94uTJxwc25KmQqoS2kdYYTr7FkO+PXfSLtFuVqEhRPdUl4ljxWeLOPeLWxW0pmQvc4f0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyXhMVyv4gwcxUsD6b+bkksiQ8IvIdgTZcLZg/84MFk=;
 b=o2fJMto62ItkRyVMIWYG899RZbb2ZLNmNfVY3INL4++fcVr9cT4G2vZi3h88SJCANTkaFGLQXQbPpMtN0AlooIbbFu4k/IdEB0T8dhWsX/3CiKY3iCzUPxMFQHhORZ1v27qQC+z0X11HaD0hgOseLOp6NvuRqTg7q65E3xpeqj0=
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 15:29:54 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::df) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 15:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Mon, 26 Feb 2024 15:29:54 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 09:29:51 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/3] RAS: Export ras_debugfs_dir
Date: Mon, 26 Feb 2024 09:29:39 -0600
Message-ID: <20240226152941.2615007-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226152941.2615007-1-yazen.ghannam@amd.com>
References: <20240226152941.2615007-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d1a1ff-61ae-46b5-e723-08dc36dfc83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CuD5kJJGfw5pUdrXNshtLlFLroqhP8eVct0QOBCv/i/R2vrot0iKQzYqy0LAXjuF/gfXkj3J1M9RPWguvh2obKXIZwy3EtmwoHjozHtbCylxvO3qmKCV5aNwmIf8axkNZuojS4hzZsbF7NsRJXeE0810yVISt2F1nz6HpFI1SelzWRkg1gm4ZMr7tLbQNiihC9peA44Y5mW506ChPY8C1KdD55PSLE952wLDX25ciOvMbv4dNgZn+RWBRIpHXuCsZg8wRujU6xAZI4FjxvBuvhKNd+zpQm+D0QIus1cLWgwcg+8zLSrGqF9aRgArAQSQuVfVxYguWkEw/MK3NlDhNR3KEG7XhDJwFjVY9GQIXU/jA8cAwK13u1/rrs7UMinhcGYH6bLcPDJF9nQJvhC60LlitSAuoZMskjNosmsBgbTfDYZk4osHgAMYvwvO9GVW4BaddhIPvfL9CGu6Ofw8D91gRG5UAWPQgOqDrQGQZyrWm/xowd07Fn2qo4nDUgZGwz2RnYO8NpezUqmU+wzNsPIpNeSpKMEL+W+Rpb/sJrR/0LukQeSQkZiaNjKuHWmMvC1Qzpct2LjkIR/9IE+KG/U4GcaoxbUItSPnHrQnloap4THiZqczAG+TOHuL53P4W+P1+hdGIPSqhFfiem9ZyHBIxEIggBbXugrDCD+RXVphN6PiTQKYCSG6rTwZVSFV3NZVUJ5Y05hGGUiYWZVis2wEtq7nPcXXk6zmj32aMpXy64uvsY0ahLAqz+yxZtoa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:29:54.3090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d1a1ff-61ae-46b5-e723-08dc36dfc83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

..so that RAS modules can use it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index ffb973c328e3..fd3d4595c122 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -4,6 +4,7 @@
 #include "debugfs.h"
 
 struct dentry *ras_debugfs_dir;
+EXPORT_SYMBOL_GPL(ras_debugfs_dir);
 
 static atomic_t trace_count = ATOMIC_INIT(0);
 
-- 
2.34.1


