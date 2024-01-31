Return-Path: <linux-kernel+bounces-47282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EF844B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0241C284D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B93BB53;
	Wed, 31 Jan 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DVrGbXGs"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE673A29B;
	Wed, 31 Jan 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741585; cv=fail; b=HXYJycauHF2QegpQcX6ifFKkzKe0fswV/Sa8XCWxPdYUIBsU1oNGU9x122aMYDr8oS/P4+BC1wIH5e71tkUr2nvM/6sAiBdRXSpNx9d6Gl7ak3PSyaXtQj6SWXxKdJCQ1w7eOb3i1jKmAhVRmYeFg6uba5aYAx1MIFnw+7z1NuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741585; c=relaxed/simple;
	bh=u8ftxr/zmcmQ+41E9vLMzmh0IdM3CStGbY0JP47+G98=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rm4Wefba6ihxgf0DmDQw+me+G2QabHGklKrK++3I2VbfznGH6dQpUjvxPxAe915ZlJo0xvkViotiWTrhDuraCyXYx0mSfa8fTtJEIcLNV9p/TmS5vuyd5KBFjjZZq+xHD1XbtsmA3lW0CsoMOxQiA6M6wUZpWBluXij/3MlUx1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DVrGbXGs; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgX0lBaPElxJM7kAVWqF3YWInzGOEfYxc+Je9OYYTb7LBP+uZ/m7+OW7bUcMfveUcUGqljkupvDUTMahDPqVGhA8mtcd+bafW4RVZwG8Eps7Y8K19oFAtjtRwPe5qFR4GgumFKd2t3gkKt9c1PD3utaobQh1TBTsfoL6CS3DXifG9MtWNy845SiCona7nkI+SeGbhlc2T/g75ERRybz8NM9HDFi0F2eTWxn7gYMt/ocujKCJmqTsMnqoAxQ+r955k/ocTnr/GVhJ6c4FkqkYsoorDhzhUGEZnEXOsgBu9NWZ41V/cSCG7TRXsxt36qHqBQiv1UIeDx2JTmx0Ws4l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2GA1trPozishODq9GcYNZH4hhJM7/o15GxCaIyy8Gw=;
 b=HTclhD5YhY90MzkLxTXLX7QbjpKSsBlMlXhaN/eH1d4gQF1vOX6uxZc+d4+Rqi9BhV3SP2SGwOMAsjH2iS9rl3i3xCu2xwJCKoyOI4gj+Z5Om4/foGENB2IPmq/j+kzKEjANxsiMIHOwc+IUxHRAkfi8s8oLmj/2BnivUy7HmAmC4bVSbfnj8wbBgKNp8+zzPvGvofVk0deM92J2XfuQI0j957lcQkE/CnkCovNZeqLwmYcBbMrpjza8r8MX91Qy/y2Qvg4kJhAMITmB/CrP8QgI272QaXwNlfshDNHw7Fcvsii+7QsuB3aWCXzhl10hHd8aRfoUJGW/6SAllqzqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2GA1trPozishODq9GcYNZH4hhJM7/o15GxCaIyy8Gw=;
 b=DVrGbXGs5KyxsUcQtmdSUn5CYu3Kz3bCdK6NffjirHabMqCPRyPZ2TyUS8/vHxLSEexxjWlkgkI+Gjv9KO4n2nUTQPcb8w4Qz5z9/PzAZPWzmUhSxGHJpH4eFI+JRYUJDmOfWdV5PfTYq/FHL7mSDilhN4QKZhzL952wjz0yX/8=
Received: from DM6PR06CA0009.namprd06.prod.outlook.com (2603:10b6:5:120::22)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 22:53:01 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::60) by DM6PR06CA0009.outlook.office365.com
 (2603:10b6:5:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 22:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 22:53:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 16:52:59 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, "open list:IIO SUBSYSTEM AND
 DRIVERS" <linux-iio@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] iio: accel: Fix a compilation problem
Date: Wed, 31 Jan 2024 16:52:46 -0600
Message-ID: <20240131225246.14169-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: f0269b82-acbc-4855-b451-08dc22af6029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+cOGVVnG528b8JlZxScBmvpBxjLXr1sJWdv++yu6PdszAMB2fTH08a/1s67105wuLkERbeH8U9VVMvkv4H3jw6YaifRwYhPBpSBfL9SMYYYDgKMebBo7R8B+GP2jl9G5/OZpvgmUYOvAab6/95ZotRTGAiRYM19LZ/lphvSc+evBHuhdWqMnEUSPLBxrS77A8RWF6hTiq0UfJttvOsv4qnhzAugplxvZ7o8hH/r52wbsvQ9QKSxPf0KyRAY5E2sEzMG8WI3cUEUKSFMWFWJTpedZFmJOw/11kkIgqblSJTfOGuqzwboRtS3mwM+dbex5Bd4LG8v9ilt1WwtRY8Ej1Bd9Ay7ufifoxdcIa5lrcHknyD1Pt4t/bTscL7x7SEW+fcD4jb3qIf6ULiOpgQ1V9q7pyIONcxYCILR5YNMSgTEkIoFSqVSL0m0DiVQvRcIwDW7g/lZKuvS4JmwQFA6XYLEXVNm3ca70uQtfWIvwU4oCkDS6LvextphdrX7g/H5FzC4C8gO+rLofCp1lepKpSAZ11no9KwLwDRTkfUaO00DDAj1VyjRkgjaOFpDvvuCStLx4A/AzitaHdMp5rML37lOIZxpdUtSBNBHZfWWYTBkDzLPRDPFlAfo7CcbNI4YSUAwYFLoYXCCL/I6sjf1cQYGjNRci1oUvyG0wufuNRwzopjiLgBSdhV6MivKE8G3KQpuNGLi2PC9yyPu1ysOvnALNw9dGQVRzcbCq/tLkXYBCM5oJfCmrH9qDZ6u+jXMxRrbhMDNk1xMijVMblb24Bg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(4326008)(44832011)(40480700001)(40460700003)(1076003)(82740400003)(4744005)(36860700001)(2906002)(8936002)(8676002)(16526019)(26005)(83380400001)(6666004)(336012)(426003)(5660300002)(356005)(54906003)(81166007)(70206006)(86362001)(478600001)(316002)(6916009)(70586007)(966005)(2616005)(7696005)(47076005)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 22:53:00.6641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0269b82-acbc-4855-b451-08dc22af6029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

The kernel fails when compiling without `CONFIG_REGMAP_I2C` but with
`CONFIG_BMA400`.
```
ld: drivers/iio/accel/bma400_i2c.o: in function `bma400_i2c_probe':
bma400_i2c.c:(.text+0x23): undefined reference to `__devm_regmap_init_i2c'
```

This was caught with one of the kconfigs used by the LKP robot for a
separate issue.

Link: https://download.01.org/0day-ci/archive/20240131/202401311634.FE5CBVwe-lkp@intel.com/config
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 91adcac875a4..c9d7afe489e8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -219,10 +219,12 @@ config BMA400
 
 config BMA400_I2C
 	tristate
+	select REGMAP_I2C
 	depends on BMA400
 
 config BMA400_SPI
 	tristate
+	select REGMAP_SPI
 	depends on BMA400
 
 config BMC150_ACCEL
-- 
2.34.1


