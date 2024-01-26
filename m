Return-Path: <linux-kernel+bounces-40080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A983D9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7311C22A65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4841B27D;
	Fri, 26 Jan 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="c+k8gTl/"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2095.outbound.protection.outlook.com [40.107.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0291A731;
	Fri, 26 Jan 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270292; cv=fail; b=kux3qYAWaKajs0nxlx0tyUa0wzc7GyNxk8EmKuPVYNH+p0z5MscmBlMZdDRSTOHUsHw2Lycx7cs2vOFgkc4Laq+UZTo81l+PKJKGHQDCKWikSurkVuI2lXGrLtY29T10Fw5kyWyv2HSWKxqWt83+CxCQTKIjxzrvbr6UUDEd8ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270292; c=relaxed/simple;
	bh=f9yUmzcGZ3rSmd+T2WsHrKRzv4dZ61yzjAZhvGVOMX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hwk+9Oe7/Mf5xsfYtlzI5r9E/sJ/owGFgIGfLuutbftLwARzmvRghAXU3ClM8LvM1ZxZ2h+RyGZFMUq2GAakQDoWrAmF8gtp5wr8Xra+zStgtZtEmiQ44YcNPEIRTKqrBh/6v/oD/wA6N5i6/59iZ3YvnZ+7tfsrEYCCpxyfrc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=c+k8gTl/; arc=fail smtp.client-ip=40.107.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3fkMXd1zhkV/5qgBsgNvqpSNQA+HVn6qgrOn2kiHiASBPdcBcdQF+Ut904ETAjLCK6Bh9//TrNF/+qATnxV5sl7jRp/m407jzyvgg/vey4XmT8BdWzMP69MaoHkdXhXcchFejjQVYpUFG2V4jlAV77Lq+7KtoFRpuD3e1p96eLBg0UXfWa3Dmt27RIVsz1rUDF81d5uNLILcoEpIAEgxrYtlGOt6/1pi7OGjMwHt1RZyClZfDcnma+OBI96geJGt1SbXNuYYOqSoI5igvWMVg9aBm9uMSK3SllaYLMaUlrpJjFxlDCFdkUe+pEF/TBgHf9ubS4YIo43WRo0W4iMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lRAOadIuHuMs2kRbrjNcYfyh/oU1deTbAU6tDKtZRw=;
 b=SG1/R0+nNc7//C0TNAQ5TihxGdBh1Kf/PGqKcVQB7ySm4V/YurYZYeRht6+okd3AZ5GymWxrqX7YMlL9dqsyOCxGC0xbcclH938Sc6firj/NBlAse/Ju5/hEF0HWrZ6a/pRhmuy0L2InmBgQa11mybuH4pz8piWTLlMMjhLtGdCGWOvweXfgU8whV/ApO0MoqhGt1u7wfs1QoaRx+bo93Txpxt9wS/t7QosBaML1t559JiB9ZUGwMUd5lnftpyYY1cKRvX0MJPspZ0ZizGZyI/tSreKzocSQPnSq6asUcAf8/bQ7/UfIZstAjy+vuWa7SPMKnXMT1MyiqcRPO7pVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unist.ac.kr; dmarc=pass action=none header.from=unist.ac.kr;
 dkim=pass header.d=unist.ac.kr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lRAOadIuHuMs2kRbrjNcYfyh/oU1deTbAU6tDKtZRw=;
 b=c+k8gTl/HJHK1F/NxQ1EAddb8FJvNOj8TjK47Ckodr8yvcCS6RhRNquUe2zw66HGO/2gr51ExXdomUjQDJbmbdckhoyvqErbukj49WpWQjjfqtaRpMdGLpeA+jF7pddXZq6D3AinJ+H1I+VnzjTIxrKQbV911vMvW8TarrNHpLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unist.ac.kr;
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::5)
 by SE1P216MB2406.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Fri, 26 Jan
 2024 11:58:06 +0000
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c]) by SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 11:58:06 +0000
From: Ingyu Jang <ingyujang25@unist.ac.kr>
To: jejb@linux.ibm.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ysjeon@unist.ac.kr
Subject: [PATCH 2/2] Add error checking and returning for transport_register_device() in scsi_sysfs_add_host()
Date: Fri, 26 Jan 2024 20:57:59 +0900
Message-Id: <20240126115759.1361058-1-ingyujang25@unist.ac.kr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0010.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::19) To SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB2287:EE_|SE1P216MB2406:EE_
X-MS-Office365-Filtering-Correlation-Id: 753d73bf-92c0-40ea-a274-08dc1e660eae
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qfFLHFTwhxQsaIMJMzJw+m566fuR+WjkE4C3/sJL5ujmAGxa8nhSHN1MDz5cSm575XiL9rk6BcwnKrL2lHezMISaZ5SYgF+k3dIa8NO6ACVyTuPX1cjvsqNJe5YOfGiddIwiXXgxlofMnkQGnH0UQk9yftzPV8Z7DPtM1L1jMRRCb5l7KpFGAGpKkTVjMpsxt9HVK684qqR8IhnJqlFEioBJJtqNlR45mTIGXM8I6Oaf0+lU/yhJy1WwWigxKYd1T5OrcaAcnbGv41xo2bzyaKwKyJX4ixNc84AZXs5vFEGlJFgI1J1bpiDZj6FaeSMqsjxPkWQ8jY47rJbr5QIY2GX8uSU30fQxjDdh+hXJrS8ajhl1VXAjtvD+lCumQ78C2xTHlDYgra4jOBq9XUeKf3W1UpcBuEphwNw84o4oy0cPX0wfRQjL9Ta8uAUdmkgesCcFkLyFQx9inz2/UOLXRKkeZRFI3L5FByC8zt290cL6IQ/4C+SVe9P3GmWrYOq52P2CGqXWRkOwN7KxaDxELwGT9JvSHuwglFRVOJm8DewN+13DEz6Ikb+KXi2Xg6MmQykuIfUqGvJF8Bx/RxQxO7l1bi1BdqCGfSVOSAx/EDy2RFOSdoJJAqP5c6cd++EV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2287.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41320700001)(38100700002)(2906002)(5660300002)(41300700001)(36756003)(38350700005)(86362001)(6486002)(26005)(478600001)(52116002)(6512007)(107886003)(1076003)(6506007)(2616005)(6666004)(4326008)(8936002)(8676002)(83380400001)(66946007)(66556008)(66476007)(316002)(6916009)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBJB5DN7DUS+MXNV5Qfy0ycAOvveqspCQVw9AKB2K+EZx57zAEdPiuzTltPE?=
 =?us-ascii?Q?gh9w6YHlW3rKN3963t6KzTSd0HNapwnjBIPVjvS1F5AxzPatG3foZcCeD9YM?=
 =?us-ascii?Q?K6JTUqNPqOuZS6NBA/aBzXkZrm7rjHtLqwE2KuN/b8HfliK7jGXgU5nVgfsY?=
 =?us-ascii?Q?/iws+gj68QiYPx+EUwSWw8e+QUCbg7iZLwjFD+nH9VD58EzSArbutJaLQB+r?=
 =?us-ascii?Q?+pdTsX2ijT7+LhvoG5D/QMMPwMuhqLMhTVte1qT0CEImxmX/8poTIF6nJRxG?=
 =?us-ascii?Q?Twq6z+sdNGjVqDLcg+zQI025tiS964BeZdqEAGKo1jyv48cBUWVJ+mYsfL/w?=
 =?us-ascii?Q?K5pMqfGaN14noiuEagzZdykstX4+Yr9Z1+Niar+2mlFGDo38OcgrMtXJgOnD?=
 =?us-ascii?Q?Uk1gdF4EiNkVnwR+E5BmRMSmqhnzcx1713n89bv9TkB4V0DRIjjcYsZtppW6?=
 =?us-ascii?Q?/ql5AqWa6MhTWj7hn0+rofHy8XdPNcRksKkfL0X7xLB0Hy1U30H0tyqRtAQQ?=
 =?us-ascii?Q?HkWrvDQn16RTb+zHlYmDcuuWemMxDueYSv75Y/XauyCr7rV7raXwXrDf46di?=
 =?us-ascii?Q?AT2u9ouTGxFDa/37+1hf4LS8QDv8qrVjFGqxAqOV9dQCC9NFt71eGYgVx1Xr?=
 =?us-ascii?Q?0nShEOLk8ue9+hmfLE80ijPfydo1DnL+pCuDq4TTqvMWqHE+FO95T7//d4lM?=
 =?us-ascii?Q?WfyTKScdtspokIAQyLXwoMtI72J5Rlr9YpkBG8P+EadF/CGxRDrlZVYbg5eY?=
 =?us-ascii?Q?PWXW0Qs9b8F6O3OCONeHADixapY7YNKka2uJ5/nNEpYa1qE7YBePMaSVaYPk?=
 =?us-ascii?Q?p5mC7RwYFK74jOnoRXDuNdTNaur7teLYVBIlgpZPfpLZz/XbnxN8BExvx5u+?=
 =?us-ascii?Q?uwvWSSMIqNR1HYTdny9WGV7AZPz2GKyCAQ8lqHmtHFeN3yGzZs8xgIR0HAUG?=
 =?us-ascii?Q?QdORAkRbdiHDk1dy/ytwoGf06hdwT4RO5VxbraeUC5OovgrQiR7XD2DBUkkm?=
 =?us-ascii?Q?/kKKd6bhomuh5+OmGBvvGTz/kAirFYXNgdiNsAOLPkVjsv3TGEXL2pMHhg1j?=
 =?us-ascii?Q?E8cGOyUto5e3XZTHu1MqwRQtOhJzdPSS8rhjUcFNNB7WbPoljZV5X2tSu9kV?=
 =?us-ascii?Q?TJp/jgtAF85YOH9a90TxuYk2CEfFMhXdG/JCLxLzm03nXXJACvPvADrolDDj?=
 =?us-ascii?Q?mRd4V7W8PyOoc7Sl2mFu7xqt+S0zUZoe2Y2psZzB+P+qIe5EACRWHuWcitgE?=
 =?us-ascii?Q?aVqUtZh+VK6dbLiJc6k7te37oVbfwt4rSRQj3j6rGCZM/m/pucL+1uPh41z+?=
 =?us-ascii?Q?3czZUITbkywewTigrPOHGZZSQt+ZyqlkT7y85BuiRnXRN4BMZlCFRrlge27C?=
 =?us-ascii?Q?VExu+Ptufh4OudQ5Zyh9PRu0OonoIbli0J0oERcHMBykSRR+Dy9YaLg1eGPF?=
 =?us-ascii?Q?dp8PJ9mJjTNTbGF0+Kg3/ZMdnYWfDUoFbjz/l4H4njXrECs2VAIztczDiJRn?=
 =?us-ascii?Q?IIpa2Fb/bYSWho8gfk1kgr8UQMF+SSEmzK/2R4qblb3nvCahb9xaJPInqmhI?=
 =?us-ascii?Q?MH9hJadgrKjRpSfp+M3c84kg8bQ3iwpCL9GeqRLp?=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-Network-Message-Id: 753d73bf-92c0-40ea-a274-08dc1e660eae
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:58:06.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i45dEIzKyU8+DR5esGwrG9EuNitO6xqN/A37nGrLzy4+MuX20f5jQnXssiOPyx7CX1E3kIJ6uu9AQ/A5NIv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2406

The function transport_register_device() can return error code.
However, scsi_sysfs_add_host() currently does not check return value
of transport_register_device() and always returns 0.
Also, return value of scsi_sysfs_add_host() is
checked at drivers/scsi/hosts.c:307.

Therefore, this commit adds error checking for transport_register_device()
and returning error code in scsi_sysfs_add_host().

Signed-off-by: Ingyu Jang <ingyujang25@unist.ac.kr>
---
 drivers/scsi/scsi_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..88f1b901d01b 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1621,7 +1621,11 @@ EXPORT_SYMBOL(scsi_register_interface);
  **/
 int scsi_sysfs_add_host(struct Scsi_Host *shost)
 {
-	transport_register_device(&shost->shost_gendev);
+	int ret;
+
+	ret = transport_register_device(&shost->shost_gendev);
+	if (ret) 
+		return ret;
 	transport_configure_device(&shost->shost_gendev);
 	return 0;
 }
-- 
2.34.1


