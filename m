Return-Path: <linux-kernel+bounces-46470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09219844039
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1828A1C27AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218E7BAF0;
	Wed, 31 Jan 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MCoWEpDH"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D57B3D2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706777; cv=fail; b=tUvqfjwEtj2YxwQdeQWL0QN5AwYAn6BmNFYbhDPfTsuf+wvH5vAjrkXeydYf2dg0/ROCpAKcn7gP5vfp6aSmDyBhWGiNwQN0kyqq4lUQ1kgZN2qdCLDhuJoaw4LtcSiGYKq5NUZitkFibvU9YwowO2mB4d0IPEAw5Rx7OZu7czQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706777; c=relaxed/simple;
	bh=YCiV9JpeETPwZ5WfCMx0MlMax8GxGJIP2Iv5wZllhqg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TM2lVqhzQbe8XMNGeH9vk8MJ4xY/uWAbKQetNXuC72UnXIdR6c5ftIomVE5HXfaKZdKbsIxxlBpMzWdXt8dlY9FW34sNwNntEeGRULH8sPtVMXD5TuisZxV23SivWBSB6TmY3e9Rw+U4E/7cM2c4rSp9Dhlg87f1QdJrUnF8poQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MCoWEpDH; arc=fail smtp.client-ip=40.107.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/ripkVqyZjNp9wJQmWBbKcEidWzpzyL3EN+1BkJXw+GoXN2evrmlagRSCujicEha8hE/QfNaB4PoLPk4GR4EhpkJDI0sCKXUvOFdbpym30iQ7ouyNAG1oUyTIkyKkSq7IB5y/1Cq8eBjY8EcLWaJu8KaR1bIUnOT0F+RPR+QY/ByTCKUajPbPuyCdNwexsyYIRqfL1J6qx/8tMdq+TLUdnjmhXl5Av+3QEPMo2QMK4BNcPW/aqwaREncIrEM/7Ipv1q4vRyfgJ8Vu+cUK3CsFji4Qxv9eDCPEIvm1E7eov7WgpGjJfDeTS7YM2f3KhOd8fHl/b/+3PMawqPwCYRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcOgv1/ZGnuxkd7W01ErLZH2VhE07WcMiDEbIrr2cr0=;
 b=Bi60tm+qmoPfXvmIW1rSeYXzYY6IN2EvvrN1edWZYRY/E7ctF7L9LK5rtXE4SVThTjvmbZJoaTbF9eWHazSMuYIsp1TMylPBk6YzY6pAAOs1F7/L8HH9oOuG0VuIOEzcc0ivpP/7oTs7nExCzjYI6CxoTCi6yCPb1baTLhByybO0T5hNYjNtchRc6dl1KoinER3Q4Hf8QlB+XBY9cUP1yYiUSRyGMqvmu9BuOLBPjec83vh117RDZxNNH+yfAXSmSQFR5yWzkkd3OUiWpiPv4Rt6HVZa0b9BXMgGJI5fVwGFMTpYS++a9jd28LT0A/kYWV1+MUpmeRi6jrfCFmiJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcOgv1/ZGnuxkd7W01ErLZH2VhE07WcMiDEbIrr2cr0=;
 b=MCoWEpDHqOx/IdfUGz5pkuo5vgYmtbALy7lCUXvqvJQLS28/jkx+iBgxT+XoCP8PgtmdMTqUiVcFiW+5/RUaQO7L6eQhzfIb0hKii5pUOU2RfmCanz4NssyrMWpIkRlbUl2w80HWfAk8lQFowro3bzbcGumvAUM56wOpRfchuz1vS83kP5MEO0sg5/M6lSMy6+gBv7FbkItzHrDkNqUvlPRA7RwLVe7wD/MVQLbCFPa19hUkhaC2v1sSvEmkKjBc0eXEHJNunbCcSWhMQ9AZcYO9YjbOpdDi+6OyKj7iWZRiY/S8SM96KxFhjJK14hn7dSF59q1JS3FnZxntKlaPFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB7354.apcprd06.prod.outlook.com (2603:1096:990:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 13:12:52 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::84c3:362b:bebe:87e2]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::84c3:362b:bebe:87e2%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 13:12:52 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] mm:vmscan: shrink skip folio mapped by an exiting task
Date: Wed, 31 Jan 2024 21:12:44 +0800
Message-ID: <20240131131244.1144-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf97237-3913-4c5f-4c85-08dc225e54df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Rygwt7sQk/1N/+B+fE8mQ3J0XbRVWLAs6JWa8hqnFo2mZ12b9ObRHiVCqjmpp4ngbqNpCAtAwKQd3FWbDSGqWcJjvrtFJt5cZZfLQM8NP5IIK8v6vB1NZT/OVkc/5xC8eQ825WJHUSrbmDBzNARGuNDoFgEO0ArzscjokJpWPvr5icbh3LqoKRAzC659cBrnSgqFfuEumUQw9t6am9tWNI3i2iU1YOgXhe3ycr7vuNC6Zu8HMM770td9ic7ttNtjmeYsYtF4MZB6gVF+1BiuGK+4HYI4GLrfXO8WFde/Q/6eEF+GRw06PKk1Ei0dBLE7e6DmKVXk70FYaV+sEMGSI1YGo3wbU+PBZTGxBVsbNIyRkOloRoopTXR3t0BroqDvbApQDXxvE0GtiNd8kINmSgPcnBi6aYvxHx8JH0WeJ10DHeZ/Fscgybhus5JthjYdwKcZ8IYazBpuYgMd0x0TBzWPlkOIqEBiQi43jGQtg8vb9Zlap2MSOnLYuA4o+xI+SCYGkgHc4rUnwVs3YJFuwmMpL8FricOtchSA+ZhEh6EWYKOKHPCbEh4afqHs7V66LLvVCgms7l6aTrPM5Mu/ei84JHyn1FWmtSIWx1ZjfxPZVDttzcs0MzZu2JGV1J5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(86362001)(8936002)(4326008)(5660300002)(2906002)(66946007)(316002)(66556008)(66476007)(38350700005)(6486002)(478600001)(52116002)(6506007)(6666004)(6512007)(38100700002)(8676002)(26005)(107886003)(2616005)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tppp+YJyDlcGyLm97UXcXcfPvLRDjepHKe03EOIaMIveIaQKufQSPQ80PbnQ?=
 =?us-ascii?Q?O2vMfrU73pK8dPb/6Wh/rb2bdmelWFxyhpY11IrMV36ut4Qxquj5c8FjVX2I?=
 =?us-ascii?Q?RkWCcGYw3YbL/XIEDGb/yYEZyEAcZnNOJi2ruOaDBET4cmTNnW6br+i60W7s?=
 =?us-ascii?Q?maWoPJpew6T1wQsoXa9Qlrd5xGawf3PoqGAvYEJp4u1v6bjteII7pTUOMqnk?=
 =?us-ascii?Q?jsthtUOwd7aklsUvAE5HXQP3PYBgpuJU2HEjjqXl58yNRMNvurd807n8/vdE?=
 =?us-ascii?Q?iBhDnuvAnDImJxHq88ubWot7eXq+LYwNC/vbeP+Q4ZdRnpMC1sPuZOyCVjxj?=
 =?us-ascii?Q?tTY4RMy83JTfx00srTKFTVwAu51BrRe9rHU+J+QMRA8TrPsi1RReOYuTXWaK?=
 =?us-ascii?Q?JbWJSpxn0jBS6IAKP4OJ4TZMsfwc0akE0Xq316lIK5Cu7EYKqIiBg1zveiiW?=
 =?us-ascii?Q?/XWq5z+0oMTLYc0VNddX2MUbiVtsrTqYhCGFuXECteY+YFMKhYKEKKhuVW5Z?=
 =?us-ascii?Q?DFaWaoHvPbPcEceVvpa+0yh49kPHrnONwbRujbjiRXvB1MTnje8jU8yySFWY?=
 =?us-ascii?Q?T3pJUIS3akgFs+UStyp3vwZlslHIVlO3tCtF5B6s1C1qF9BZwnsfabZywWKS?=
 =?us-ascii?Q?ZDlohuSvvrC5E1Qy+vAQJFkFfVcBJfFeCfz8cueHRjoi1noCw1VtKvzPJi+U?=
 =?us-ascii?Q?eG6/Y04nBT6pwTAmMU4GbeH2E0VpaQUtl2xJrjehyAN92sPSqg5JY7AV6jIN?=
 =?us-ascii?Q?fCYjDrxWqSWDlANLfJ0YuXmO5x6zTl6EzBxOGm5HIFHdu6ALo6U5mJUkJ5I2?=
 =?us-ascii?Q?ddy858ZIh+sO7HExyfNiEU9tFqAphv/Tp35S8oaBgYza7SYyfZLnOgwIxXyL?=
 =?us-ascii?Q?JKNt2btoHI5LKf0kz8TxCXOya497ju87uFVY3YUznGw1WgxEuEn7CWM2GMV3?=
 =?us-ascii?Q?OIOiExn1Dr35uqPxbjZnINsASgH4eGFKQVuLiq5MRyunryLePgY6T5mh8kxx?=
 =?us-ascii?Q?rX8UK5kgF1AS3BNhELQxpnXKnJr5gvsdM33mRGsYFwPul4o5ctTgUJzsWncE?=
 =?us-ascii?Q?+jqhmP6A03ECcpy/r2lf6mVUuXz0u9rlEauRM959My4qqzWFg/Q3qhQJgX/2?=
 =?us-ascii?Q?FL+gzsOsHWykGl707kaIe4t4IgxFEgMKZ10nNl4dqV/yOhvZ4+FNmaH/r7Hr?=
 =?us-ascii?Q?ih/Y4GcAUXFbDaaSuT5MoA9kOML+lhMyMNlbqFx2J0EmiBKO2iFNcNicTSOL?=
 =?us-ascii?Q?+Zue2WN3n84NWnBZ4ElndtMDXEBk/544f53wW4JJKUs1o2z2KJhYXQ4TAvGk?=
 =?us-ascii?Q?Y885Z8C6JndxdAbK5BmbljESciG5vE/v+WSlwik+tcIQiTfmZoz2Nii0L0Vj?=
 =?us-ascii?Q?4949HGG/UtoiEH8AHdqkPvMgSAMjkOFaktLHQMgcvdaBF5lMZj1vTKZnnera?=
 =?us-ascii?Q?wgAxsTXQu1fdfmaZdJT36k/EtZH1BG8K7LjnyquWXDka41kMjg2mH9Yg0GvM?=
 =?us-ascii?Q?UeJXr9GUbMpEjPLDllptEMpcQQFWfJUCtf6fnHE+hQhL1SGaQfvidhcurvW2?=
 =?us-ascii?Q?6iMPiu4ate0r/OJVOH8mhCWSJiH39uoIpiaoTHww?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf97237-3913-4c5f-4c85-08dc225e54df
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 13:12:52.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpiFNTHZ2XMFJFX04bgu0M9EGtpK0sh7NxMvuQPC048JB6+S+i6paegBtAwDGjAJMIzQkWwaqr2Wqu24yO0X3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7354

If the folio shrinked by shrink_inactive_list is mapped by an exiting
task, this folio should be freed in the task exit flow rather than be
reclaimed in the shrink flow, because the former takes less time.

When the exiting tasks and shrink_inactive_list occur at the same time,
the lruvecs's folios which shrink_inactive_list reclaims may be mapped
by the exiting tasks. And when system is low memory, it more likely to
occur, because more backend applidatuions will be killed.

The shrink_inactive_list reclaims the exiting tasks's folios in lruvecs
and transforms the exiting tasks's anon folios into swap memory, which
will lead to the increasing load of the current exiting tasks.

This patch can alleviate the load of the tasks exiting process. Because
it can make that the exiting tasks release its anon folios faster
instead of releasing its swap memory from its anon folios swap-in in
shrink_inactive_list.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

 mm/rmap.c | 7 +++++++
 1 file changed, 7 insertions(+)
 mode change 100644 => 100755 mm/rmap.c

diff --git a/mm/rmap.c b/mm/rmap.c
index 1cf2bffa48ed..e6702bfafdde
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio,
 	int referenced = 0;
 	unsigned long start = address, ptes = 0;
 
+	/* Skip this folio if it's mapped by an exiting task */
+	if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
+		unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
+		pra->referenced = -1;
+		return false;
+	}
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-- 
2.39.0


