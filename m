Return-Path: <linux-kernel+bounces-52414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE148497CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6362E287CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F817585;
	Mon,  5 Feb 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nl8GzMWJ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AF12B8C;
	Mon,  5 Feb 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129060; cv=fail; b=qupuG8rtSOImL37KGvF2+N0OaSDIXGrU1wzbgr+1cmEzel0btoNd0LSEYRVusngD8FapqsMXbl10zeVArupGLWbR+3o+kOOHvgLvCYPH/hruFFxmfb1PCrxZ6GnT7rVIxPbRoUH8BpXek/rs7JJBXWlvejINGU//4pHQ0NnANKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129060; c=relaxed/simple;
	bh=vBTHUwH6xlEEsmnHJ5CBo7N7soubSYsBmL/ljSRqwzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9PUWNY4R6jVMwm4W/2YdD9BvhjhDZuEfCTxP7vWyqPVGNtvwOaMKjLeVhGUFoLKLMW0X6qt45yDhX1lNFtHZ2xafNbjqrDBmurW/UnLfoHYE2VGr2mwO5SR46MC+UcpLvX10PS9oMv0mGPONWF2HodiM8tWBLKTQp5LUttyLoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nl8GzMWJ; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu5TUbgXBAT0cYUeRpxDcFBawYB9R9VciMMyUAtkOFlrEG22PQlSbIWuT17iBGAPXrkFZC9nV6RvuTFk7g8kvhnOsv97z9LjpQqaxAXJOf1Hf5lZZ6qzK9w3O20mBfmb1AOSCTMpOT61EetevklrIR0G/LAjiVbeW4rk2zXBW+43JOikv+hY6C30vwLA+I0vYQ1k56W5Dty6KwnZyeE+gOPEjU93mwMIUkwHTZlUvNYP7lsDI+9STp25ktCTEO8tFj8JPzSZFuRpAVtUucoCwwHZhl9TZQwUHU7GBAyksEgRsgXVzyYrjZsYqnD7r33b23nIU8UibLLzgenMfy+Rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UwAJT1Zd9ewaI2s3iuJy7BIL4gQmIIR/Q+T7qMkCKs=;
 b=WgkuOa5uclFbX8hAc+r4q0gGNfKDs8SyuzNIN3XCgIiUpTXVzSTlEnNpKlCEh60rQUQXANHWqCa5gzq1/YcIFMhKvchhZnwAX6OICaeSvDSgWs7PAJzFO/0zLMECjr1LksNtjnMoM5d3xdIXzRfjyh6ufnK/5xaz87JRdrZQQcLxDfA0V5MCUCDFzZ9J4wvukNT7SjxXKVrsPhE98yAbUeGD9ilZZcRgv1jQsPUIHvyRVSiEPPgVr37JgNtBPFs3x7CDvK/PuUgU6fkVBjIq8E0RTqSqiX70RF/gyu6fI4HD/I1psT8kxQiTN4gtquFKaZOFQx/oBP3IAuhb3yKKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UwAJT1Zd9ewaI2s3iuJy7BIL4gQmIIR/Q+T7qMkCKs=;
 b=Nl8GzMWJvt58yTx8UXg/vtA0DYOzn0SEx47BtOWxB2aVVUjdwGZRfbYmhVen+gs7a8XOMTtgGcsOWAMrB+B5cgf47DqlN7kw1he8/+qbOtENCMAbxMRMEasKObYBHgwhNi6Tnb41DXHxrnKwdVQ/D0hPJe+63l0oObh6yNVcjFJzMSy8Eq7LA7sausjHu3Wl2klYKIrEO8tX0h18JT+e3TTskuYJLTX0iee/fVFPZfNRnbhppjkSbyxW/gXT7ge7uIfyjPVkVSZ/bGdtBrVunahtl018QzA74gpKwgytNo0nixwZA+dJi15tOkhMGXTC04kJ51OsUDSB2ipm/xxgrQ==
Received: from BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::33)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 10:30:56 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::c) by BN9P222CA0028.outlook.office365.com
 (2603:10b6:408:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 10:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 10:30:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 02:30:39 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 5 Feb 2024 02:30:36 -0800
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <daniel@iogearbox.net>, <mlxsw@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next] net: Do not return value from init_dummy_netdev()
Date: Mon, 5 Feb 2024 12:30:22 +0200
Message-ID: <20240205103022.440946-1-amcohen@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|BN9PR12MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afc25bf-6db9-40d7-4091-08dc2635897f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ILyFRpGJfOP2AK0JVQejOaUwuCSL3f72y58wF8z+albtqgt2nDYbblHEQs6OWn5OYpMlW9YAPeiovFQ3V/BtyZe5wzgpAQ8U7SJ26JOeB9d8Su7mn4Px05szntUXBj/T1+bqjY64gfTczz6muaaJTeTCNbNaIlbzVZ/5/xVvx/moK+iuhKV5UjcGGIQAW8zwvN0xD+tFYEvqexT9PMSz/fXPHdKbkKB+///ozkbQLly6KlsYnilsEjmdr/Zkhb6CrXgjgD6IRAtz1lg1Osk45ih518aC071CDzUJY/Fga79PCtNeGdnJpTX15DzHEr9V2q2cnwmX7iOjFacWnwOTpNyEXL6fo0x23XJviMQ0F3rKglrdchsfQtN+7U7kGQz0ZX7JcL8adcwvRjEwf2giIyby8XW/iB8WQKMje9dsgEQzaM4UcbF3u+emSYOICY3UzCBcI6PKVlquDQFd/AOATDp5qeSpMjD4JQ6eBbfvp1HcNITmef4OfLXsHPWVeBjIWnB/EXV+pwF+bzEAMeue3qpJ9zgFrNeMc06ECAjf1CSvP/br5aFdyOcuLkm+6k9JQ6KfnYnwOGBG2sfpoANU2SbHCdo+YMv+mQHt20F1j/6BAn8tUW99xr6WGZETcDR0GhycsnCAmvhkAbbBCTeaY3KVDhh6QCFQsA9hQBNw46ogmEKty8ZrPlhMZFzEdLO95LlunmlG3Jh16Plqxj0WG3Cj6UxGIFZEINUFz+Adwns=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(41300700001)(36860700001)(47076005)(82740400003)(36756003)(2906002)(83380400001)(6666004)(107886003)(16526019)(1076003)(336012)(426003)(26005)(356005)(7636003)(2616005)(54906003)(316002)(86362001)(478600001)(70206006)(110136005)(8936002)(8676002)(4326008)(70586007)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:30:55.9833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afc25bf-6db9-40d7-4091-08dc2635897f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035

init_dummy_netdev() always returns zero and all the callers do not check
the returned value. Set the function to not return value, as it is not
really used today.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87caa81f70c..c2b7083d3097 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3161,7 +3161,7 @@ static inline void unregister_netdevice(struct net_device *dev)
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 void netdev_freemem(struct net_device *dev);
-int init_dummy_netdev(struct net_device *dev);
+void init_dummy_netdev(struct net_device *dev);
 
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 3950ced396b5..f64961f92ba1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10294,7 +10294,7 @@ EXPORT_SYMBOL(register_netdevice);
  *	that need to tie several hardware interfaces to a single NAPI
  *	poll scheduler due to HW limitations.
  */
-int init_dummy_netdev(struct net_device *dev)
+void init_dummy_netdev(struct net_device *dev)
 {
 	/* Clear everything. Note we don't initialize spinlocks
 	 * are they aren't supposed to be taken by any of the
@@ -10322,8 +10322,6 @@ int init_dummy_netdev(struct net_device *dev)
 	 * because users of this 'device' dont need to change
 	 * its refcount.
 	 */
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
-- 
2.43.0


