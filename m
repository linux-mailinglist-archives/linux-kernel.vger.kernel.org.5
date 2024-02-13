Return-Path: <linux-kernel+bounces-63408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB8852EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BFE1F26D08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB54364B7;
	Tue, 13 Feb 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lDY7dytz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FA364B6;
	Tue, 13 Feb 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822954; cv=fail; b=Ptp1jb0qXr/5705U/VZQ8D1j5HxcfdsDCV0QkHYD+oS0yFcQXucqMLE8czk+WRiWd3oPNDoSvtPwoHd8Bh0aT0a7c/cnBTxH9uoB+mCQf4abqrj8re7n+fWwOWE49MHa2umQcRh/m9CUAoepV1/OyOZW6fSxlmXbncp+ZDqUNX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822954; c=relaxed/simple;
	bh=tLMKZnpejfuepMUApSKrvgycON8KgAaS2jAQ7VORTjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HsECIX5dNvN/15WsXKwkh7tSqc7FQM/5d+uKTMXjL4BBubsHO5a/3SHp7Hz8skLL/PZjM21JjvKE6U0jEfiwa7nlQKCLsrh5GXfdFhvQjhbYDe9Dni0YXozlJkpXFk4xki9BqtSuS90iOkFgVQKGhtP7jnIaQgpeo4rx7TCHUBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lDY7dytz; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvZv+S8XJcpjqiaAY8PiD63oBCEsslTki6bfeLJ82/WkHKgsD7EUKMSQK8TZcuBMQPj7lJdhep3BBC4yYpsse6pUyBSry/WEIZ5Ocaoj927JC0FkJ+dblgDP7HUEnDlfXVR7qfn8ZOiBh+mudKH8nc5DJojhsp66SFtzho9+GKRfQvt7PWl21KSji5kzd+2OSfcFjYtNIHbV4eHDCWhadyhWU5fRD+rQep14DgVhgXvXgb3rwyC2l8zuNmW5eX90u+kA9FvHXlDm3E7n+e5e4LJ+CSlTZ80F5C1i6P0MR3hHeo+W1jg0n2lYmayoNQzUu+2hyXIom9qrsiuTzLvN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH7eJmu9/+kxgR9IBSaGCbrUfRtUfHks7SlDDhSNYeM=;
 b=kOoSjw0GKOkvmlg5oVgRjkSIfkWmgDxLbqiJqmZ+yMqc9J4axmM6hd8yXlQZD1wFpO70ehgpFI76sMsBY5t0SUI9MYKSyXCKc9B82Uq/pAEH0bPfqaZLOjEUlVpfOATOzWvMvlChx3czsG4TxVN+5upk8OP2lDkmbvUUrXmj8HvYtYSCBXkC+OeqxhmZY800gjcGKQH2d7of94RmYQQqt2zV+5UiNsV9peavZOxKR2VlsgCmOeguT20q/T6i4afM8w0G2usZpKe3Xyszsu0qgVzb2YJdFab5mKwlrVZu8vbK61RNV8dXO3F/DSQcpOKiuOOQhJ/daNSuhzz7awMK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH7eJmu9/+kxgR9IBSaGCbrUfRtUfHks7SlDDhSNYeM=;
 b=lDY7dytzqxJISMqjAvITpIW+oYsieR+WNbR1SHUFe+szcIvcRQ6tiOdFmFgyswTneLAD6GeT+G5NO6WGKPmMR8VALUql1HKOr59LxwF1tbsSBe6HJClkwW7dtIcJqvY7KZfwroHN7vpgTMi6Xwhu9b8XedfWNY6kJJGcVFcxH9krbipfgBHmvttHS+yhGjwjYo/NINSfDsCfKQkuLs8a3A+h1M9DTJVrxQfB0rFnjjxU1oeH6SlolEWTBa20vPDnS0CI5mZWe6+wLgaGTNbSjndcvHo2Bc/1QdVied4uJb6vFlP/u/gKOMI0S2dUQsgiQnRrxz/q5epu/D6/ZxFDcg==
Received: from SJ0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:a03:33e::19)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Tue, 13 Feb
 2024 11:15:48 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c6) by SJ0PR03CA0044.outlook.office365.com
 (2603:10b6:a03:33e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 11:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 11:15:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 03:15:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 03:15:35 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 13
 Feb 2024 03:15:34 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Updates to mlxbf-pmc
Date: Tue, 13 Feb 2024 06:15:24 -0500
Message-ID: <cover.1707808180.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 3783762e-828f-44a6-b245-08dc2c852167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hX8vsLIONTV7RdIFxrfcmzlfbQagKIWeGzk9f5vp23SUUItyOtwmme6NArqHkWvUGqoG2O1kYetQUnMFAdlLXZyVua6XpTLwParm4o+PObeeNxzLgAssBEp2qCoEwYoId8EKcZ/SmEjXsd2P46DHV6Su9K50O1m9NSRRMc076eImAbz7nUljgRN31OsCor0T5MEpNK6UJnR43wy6AT5/SUZEzcNNIHQ3Ksi/NiUzqLYL5HUe6NJRbVdZOZRoPMaiuk7e6xqibTTl0jV6qHXGlFFbDbWXzNcTsZAG3lfOQi5Zw55tLeJK0mO/AGBybmTfnkdz02+D9hL7RwPC1VygUXLNraaPqGBSnCKZlpZtuoDfkmAWWnxc1Y+4jcNhYoa12+QSKQeDFTnxTk/sxOrbmy5axa756EngS7MHgoC2zOECAuIRngLujrbOYVGuB264i+EBhLmOE97xhrgrUKbZ0eiHlftKdyhiD+5Dv+pXBWz7qPYdanmSAUXeNCV9W8AvpsEwyovuJ57i65EOAjOUzdx4Pm9E9A6UdNKnKzGA1wZeT9j+EuanBCld1RJN3p3knyBTeaEwl7i/zT0yAjolP2/Ri+/Wis0YnXI3LEx6ee8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(2906002)(36756003)(7696005)(86362001)(7636003)(70206006)(356005)(478600001)(426003)(336012)(54906003)(82740400003)(6636002)(110136005)(6666004)(4326008)(83380400001)(70586007)(5660300002)(26005)(8676002)(8936002)(316002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:15:48.2328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3783762e-828f-44a6-b245-08dc2c852167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

This submission contains 4 patches:
Patch 1 replaces all uintN_t usage with kernel-style types
Patch 2 resolves signed/unsigned int mix-up
Patch 3 adds support for 64-bit counters and tracking cycle count
Patch 4 adds support for the clock_measure performance block

v2 -> v3
Add commit descriptions for patches 1 and 2
Remove unnecessary newlines from function argument lists
Use size_t instead of unisgned int for array sizes

v1 -> v2
Added 2 new patches to address generic issues
Replaced all uintN usage in the driver
Fixed signed/unsigned mix-up and replaced identifiers accordingly
Replaced kstrtoint with kstrtouint as applicable
Retained devm_kasprintf usage since other instances require dynamic allocation

Shravan Kumar Ramani (4):
  platform/mellanox: mlxbf-pmc: Replace uintN_t with kernel-style types
  platform/mellanox: mlxbf-pmc: Fix signed/unsigned mix-up
  platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and
    cycle count
  platform/mellanox: mlxbf-pmc: Add support for clock_measure
    performance block

 drivers/platform/mellanox/mlxbf-pmc.c | 388 ++++++++++++++++++--------
 1 file changed, 276 insertions(+), 112 deletions(-)

-- 
2.30.1


