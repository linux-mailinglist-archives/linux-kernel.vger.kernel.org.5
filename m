Return-Path: <linux-kernel+bounces-51403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEAF848AD9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D849A282DFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4163A1;
	Sun,  4 Feb 2024 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RhY9n+cI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11D8825;
	Sun,  4 Feb 2024 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017202; cv=fail; b=Z7xUMGmYjVyuV+lhbUn13kxcJM6bsP3vRTiu4zKf29W5S9BZEr1AIuoBUch47qrQj3YkUrkIx2VtbGvdhqlatDreFJBpTnvN4SMiqL1kZghokbHstThAtDZ4JeT8R+xK/tp9jw38JGq6+Z3oiMDJAbZ+C/IKQpOrw4uhxcV9jDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017202; c=relaxed/simple;
	bh=a7HUM9GDkpRgPggDObzXxL1tRHl/EW7CtZAkMKBnLBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO6+F034526uqf9/2TKIFrgLEPyWZoxiSVVQ06d9hPHCvCRl3jSPXu2GgsFhyzHybntPn287eNNsQCKuZFQiAMFsJ8YQ99HZEvR0PQVoR8PLh682rGxhS+UX4tdoLc84bf+TyqHbZN7iaa++xulZI2zaSl5JM8gWQZOb4VFlhlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RhY9n+cI; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ23shdbnVQTrwAOUcAGrkOXweqB8VpSImpJTX1Afkzc7Q75qnBGev3cYpa//whg9PRk7us39Ftm7o3Tw8CB1fIICMmwPeS6lT3jgWzz6i6XAuPfKvEV56bHpgkypXkohFj32Q7gA6GqinKSN8WF06lisbBKOqA4lsqnM9ALC4lHsFCb5UunGAZnHa8PiV/OyF1GMZK1HJEjOe6jemWfZ/0aCOPhMUQpbjZ6rkAU5WRPyzcGqMznmubQOBymzVRhreKAdK/KfK2on/T1ibjLN/lt9CWCV4t7f1eY0/SW+P6Aes4NBlKgumBs/LYAPngeubBbDxHkwVxqLrCoQInn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=id1BTJJ6oBmxQvtvNrxE/2nNRcjmICBHA0g/suMAQ1277zn8zL2pIeNiF0BHEmYTyanp4G1u7oym43jYVjGAdMg4oYzGjJclATxZI7HI7LyLooSVrrZ85CoAnCEYs9T40bczoo586QQ2HZh7wAOZkIsT+o2XWkQ8cpQYQGWrklsbkEIptr4vdz4N4Zdd9BJjt20WNJjBYoDvc73OCvr0iVjtJ3bIFJMoCvciSFZj1dpeWkcIf+63nkaL1yUyyuwx6ORNG7gbuRmnOwYrFj1TuwnZF4HEyap3R9qPg991zcgceaZ+cqhZl2+qQfTjWaEEb1iEa2ClOlSYAammvXT7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=RhY9n+cI8bpvy87Vh13bcj3DDOGdcwNouqQKZcDJjnLANRY2eeSdK1s2OuTToQb0adueHUfsx2nNOk0/ZuQQK9QBBRZXQfFnKiMpy6OR7ufg+vT2p3QNzZaDRXGa+cSpF1zqeD15PDx47wn/6BZbRBKE7eWK4j+fhKz8OiHQQfY=
Received: from CY5PR15CA0173.namprd15.prod.outlook.com (2603:10b6:930:81::18)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Sun, 4 Feb
 2024 03:26:36 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::70) by CY5PR15CA0173.outlook.office365.com
 (2603:10b6:930:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Sun, 4 Feb 2024 03:26:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:32 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Sun, 4 Feb 2024 11:26:10 +0800
Message-ID: <ebbe3741501a31b1ffcea208393cdd8929df6455.1707016927.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707016927.git.perry.yuan@amd.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: f70004ee-1958-44e8-cf08-08dc253117d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5uX2do/63k8zrVtBTLWqbl8CFg3N5BPgzIximO4kaLZkUhKq9Wg58Oy7X8hVZEnXyrP36Iq0xOUciPx3+UEKsP3I14hoQo1Es7wxpcRL12ebukDQLJsn5gGABhKgxu4pyVrfcgCar3x7xFGSB53cWMytcENdVYygJHF33b+7VcCPeSu+o9U6A8IQukfUELHF53S6WtopijA7V+UuTd56oN0Dfp9kiCunIt405xgx/gurKaqFBOILjIVSRLrZKQYZi30PxqojO1kZZoNkWx74cdt9hgJ6+L7zVbiqnTI91xMDumMgEfazpxsimLepvVj0S6Fi605LnV6mX655OwUmVtRn++oJNecOKwS2JO34bCMg8G7vLoJyMrf6kRUWNFw5yepLiSfvk6gIPom/jtgOBTAmoZyDk0ap2mXo+pI4Rq4uWXt9BOu2i/EVfWUJMtjRVxbYfYK4eXz/MIxIO5+QOYoGRYGpg/EjHLK2vr0bdvLy74yWr8hffHj4W2QWMBRi7cUHz95ULVUCbTtpGdtGDDPJnAujAQxHJB1dbSu/6qEnr3JAUP5WcFTozu0QDaEuqWN9p5S6LugNDxhsyNy9VC9Zccj1FBOxT8okc+8PofCQZFsloJ+b/xyEkKSwbqm0cILazpSLoyGGp/+WiQ2qto2NsyQXkyEu1OuLvZDf8YffqjTSvJcfOPq8a654r5ivlt7ylVL6QG2EL21tQgdocYCKiRz8LtZpns/X+gvsCk1+IKHlmJ83q5ThOk5XNOTb6uvsnpNl98TBlonvFQZIJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(44832011)(5660300002)(2906002)(41300700001)(2616005)(336012)(426003)(26005)(16526019)(47076005)(83380400001)(478600001)(86362001)(40480700001)(40460700003)(7696005)(6666004)(356005)(81166007)(82740400003)(36860700001)(70586007)(110136005)(70206006)(316002)(8676002)(54906003)(6636002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:36.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70004ee-1958-44e8-cf08-08dc253117d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849

Address an untested error where the nominal_freq was returned in KHz
instead of the correct MHz units, this oversight led to a wrong
nominal_freq set and resued, it will cause the max frequency of core to
be initialized with a wrong frequency value.

Cc: stable@vger.kernel.org
Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..ac7faa98a450 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -640,8 +640,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return cppc_perf.nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


