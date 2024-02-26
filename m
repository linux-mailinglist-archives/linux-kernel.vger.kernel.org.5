Return-Path: <linux-kernel+bounces-80406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF20866826
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCF41C212E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67FFC18;
	Mon, 26 Feb 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="g2Z+kh2A"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA392EAC0;
	Mon, 26 Feb 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914337; cv=fail; b=ZA3aoMH9bR1nJdVkElo1polXQ/pUl4WCAy/wDxH0HHosA+WgnG9ReGW8dD5Gt4sDQguNfp/lTyx/NpVWPEDFjx9Gk5yD0wg6AVOUiJPiPOKQtkixl+ghruSYhrtaoh8Efxn0Wk5rA1w/7u6+0RhxWD81RA8lGJzXlQx4as9O1MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914337; c=relaxed/simple;
	bh=yMF9Qs+zQdwYeL1GEPQYyVcnrDeVQklU4UyMRAVJOz0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=islWVgEPrKeCz1mnu04g7oaTMHl689aX1nlIm7GKyAmZaeyosGDYHFB/x2FFW/88+qx3rlZGJepcz9PnZjgUenLw7yw+kjrQsMArlEXPW2oWFBuzlWfIxo3zY0/MlSzeXxNpIuxaSndyPlaWzrA3JnyBXL0c3iPZbgeCVlloKU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=g2Z+kh2A; arc=fail smtp.client-ip=40.107.101.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1TJQQREBo1XP2OvHC78Da02ojXHpXYC2dIcqLKuCejApDyHj6bvZRoPxbxXT4f2MQF858ZJqcp6qRRn7sCwBklDTyf/Y7lld4u6gEw27oBJzLS1kyVznJ2wV00VFZ1ZtGDadtaluJgynG9qs22LEr/p/aJyhN8M4AaxnoMVlD1uk79Xd0EH8X1+I7p5j5+trSbL6q+LaHqdTdwv4XMfRax7C2jcuv+zWdw0O+HyVKBYFdwn/dp3xjghQBtniTRleBeGtbPUolhZnVeNAhPnwflNkMnqJ34BFnjDoECjMV9qaKoCUK2tCWesHQ6gnnPz9eZbqXYazw8Dpidf5cijgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbtodze48iVkKsy3yoF2zAELF+xvH9wFNihMtHi7/zs=;
 b=mPIqNpwlZLDO6UEtSG8oRc0CQC9Ag4IFGoXZfA/EXRkb/ICNRzlAgBdCw3EcJqgyKTG1tuVXalDh8Jx2ArqXx2k5l5RKNiqeMyr0m+knD111Hjsh6XsnW0I6RFpKMjiuCsfTCcJrm96pi4vMo7P4pAv4kkog+FtTod7GwnUne9Blba/4E6tuoRfMfSQbJJaPV9kcTRC2ANJOfTRda6BY+Lyrfrho2X2GRZV6FmiIuSEiRC9VELPkEgsUmDtaOXa23hG90HTwyld/d3DICQCGFHXgTm+lObIPThH7eMQyN5ElzLAa/Xg+iSMjk2jK3CIAllE0ALTp4DaPWX9yvHATLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbtodze48iVkKsy3yoF2zAELF+xvH9wFNihMtHi7/zs=;
 b=g2Z+kh2AuvzWsUiTCCgvpVwHRcreJ5bD2QVdj1sxHBP8hZ6pUKRj2RvKqhILIMiFat/u/jLTRHDLvNexfFBlFW9+fBgQXk/7mxZoyzgQ0byc5oTLawvUtNts8Yk6AVbXssunER7i2cx80OQfL/zXVLnYdC1ZuerlXPaiNL3ShhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN0PR01MB7876.prod.exchangelabs.com (2603:10b6:208:383::6) by
 BY3PR01MB6740.prod.exchangelabs.com (2603:10b6:a03:365::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Mon, 26 Feb 2024 02:25:31 +0000
Received: from MN0PR01MB7876.prod.exchangelabs.com
 ([fe80::571c:364c:fd24:4ac4]) by MN0PR01MB7876.prod.exchangelabs.com
 ([fe80::571c:364c:fd24:4ac4%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 02:25:31 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: willemb@google.com,
	yangtiezhu@loongson.cn,
	atenart@kernel.org,
	kuniyu@amazon.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	paulmck@kernel.org,
	joel.granados@gmail.com,
	urezki@gmail.com,
	joel@joelfernandes.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	patches@amperecomputing.com,
	cl@os.amperecomputing.com,
	shijie@os.amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
Date: Mon, 26 Feb 2024 02:24:52 +0000
Message-Id: <20240226022452.20558-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::14) To MN0PR01MB7876.prod.exchangelabs.com
 (2603:10b6:208:383::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR01MB7876:EE_|BY3PR01MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf45a97-a546-43fd-cf1e-08dc3672343a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LvnqDjdPUXRXes21wWiJSG1scGAZxCmODdL/THso7TRc6BXzKcNg9fQRjfkbqvw8CoxzFgnLZ0mkYnbv+WmXR1TLIB+SePgD8GsmitmOtWIhgj9yxLepmUkAiB/d966M3zRjIUm8OmzlXF/s4McMnf16vbogoX4a31zh4eyBLBgs5sPZH7+O+d9l1AdrEuvkNHm36GPNvEQswVZUfq9ix7N9Sdt1ErQcAJEUW8S2vO2sh2E2TQNcLR1CLlvdgs1DJjghr88Cjf78Zp2ycLWXdbQbhggc7unPeppJmGuULZwwJ8PODfUTt7tFTE1vB9ufJ78QDg17JwQmb4cBdP4CpfTQe72wPEVdDPmVVJF/gw+4W5VNlojXnzL1/yhnOQ7Rca0qqu9IPSqD6Q+EacSCIUP9URsAv+K5lGlC4Aq/0oPLH21s/hoh7nhI5wq0bNvypPwBKywWXuSFbjsw6CuqfTPeh5b0Vr1IiNNDZ5/Feri02acg0Krjly7Axt8s7JGniwbJvvkSlz6ynu3NwTYBdWNVgC2jKuVOWDwFNvFWXH05xFTuhvQkvmp+Ira2yQN2fYdR2AkqtbDyh5vOnWK3eIE8T5N8ss64FgLlPo3xttkMN7BxwTvIYrflopKaM5p1IIMUO51kkXHAzs0YaorBBL3Y6kJ2R2qdcfrXYFfblv9g8G7ORjofpZw6hSRaZk5BDMbMBUUBewYweEjmC/3KV1RqFAwse6Opc09CkNLr3LY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR01MB7876.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3g/BVq78QcwczZVvQV6Naqqlag+HYSx4DBRlosHvEQaSekvZpR2dNYEIYvW?=
 =?us-ascii?Q?TJuJL0emMc4E7ZyjEaYmzCgtv9JQertKw8B5JQviG8l/0/z6C4viwoUtVj/x?=
 =?us-ascii?Q?Cc5NKubvi6Cgo+JDpupnIJNwxWa6DOwyXcEZ7xfNvz7IsjItiuTa5jAvPytf?=
 =?us-ascii?Q?ySiTqZ80AZD87vAQikxSQnNrz6sISHST4PjvV3EnlI+hn8DGcmVXu5hrr8SW?=
 =?us-ascii?Q?0hbwH1oYP5VHtGiQuxAE/hSN4SE4GtLgN4PJD+mptlP6ymB/Sud/e684mDOl?=
 =?us-ascii?Q?ZLPRnfCGPg1iQpaq+ZTxkIbJZSeDTfh5DFeTnBdZqGpx7Yy2TXcJ4s57G+IX?=
 =?us-ascii?Q?tthCrxZImLrM5gjzOu53uMWqt2F4EZzyWpKsZmuwDFdZO+WCHUgpArXbLxlb?=
 =?us-ascii?Q?e44i4KJcDRaZWC+YYmhhO9qmsItBslpRZ4huD+LkI4T8rffj7Z0u//Z7xEIT?=
 =?us-ascii?Q?gDTohE3SNdlFnozw7FlO/a/I5jZCOukqZh1eZ+qIiSekfhsKoI5pHWXq7X3H?=
 =?us-ascii?Q?rUskpbbRE5zMqp0bjHM2/wLvM9GpRMn8cL9QImJMRXAucuToi1Rhr+M8Gc74?=
 =?us-ascii?Q?u4YLkuOW8IzY9TZE8IUc4yB5xAFyR7m4zcH7jlMBUG/OnwtvLhVC3GcJknHt?=
 =?us-ascii?Q?8FEOJ9kfBXv7XQtfXC7II8zUCgLBIzvAY6SjAP59U7eQ6O6Srv4/DAHGU3u1?=
 =?us-ascii?Q?XVYnFZvdQh33ab7fNmbdfjAsw+VhlbRXHo7xwZrywoAHsUWzTDTjixYAyo4z?=
 =?us-ascii?Q?DuzLtQYgKe2h5JSRzT0DdXohmmzyKydKOZc2dyZsVoaDokkFxjcuwQNmtBVF?=
 =?us-ascii?Q?2zcdJmXG8VDGRZb7lA1iTcBYr7I+xzir6uCno7V5a30NrzeIYzsbeuP8OYfe?=
 =?us-ascii?Q?/6QCfg0OqK5BvUqoVt+rWu49WSONZCpQqNAXmINcNClz8F2K5RIYxdeoAIku?=
 =?us-ascii?Q?klE4VAPhZzsZws1eNcL5eVfLS6AFZB80YbqyTOQIhbrbUKv+YSwil9z3q/rL?=
 =?us-ascii?Q?GOiYQJgxsdhwBiqXzuKB/hX5gdPgrcCesPT6uQNRyOURcigYoq7w5F6ESiCk?=
 =?us-ascii?Q?K8CNeVj2/y2fWz26GowKZzR1aMqe68rHqCbWep6lHcqhDbr5ILUhXqLiMJKs?=
 =?us-ascii?Q?EUY8Mn4Rp8Ub767pGNzfsUIkvxETgAS5YjaR3UKHs+NIZ4WaiydHSz+BSPZ/?=
 =?us-ascii?Q?1FnagLmwXOQoopMlSe6DLsqv+FeQwcJXf9XPcebd1MGt5igJ61SCidQw6apm?=
 =?us-ascii?Q?2wghXlvanvyIkLuxVRaPVlMSIcXbc6j/EFfZ9phDSHr82npfmD/4Boc8SqSu?=
 =?us-ascii?Q?NLRCi4EIc/uU7vrmkGPW+/bhe7VccsKLYIotSiDUzV9bAd03VFXQUVJkIH5x?=
 =?us-ascii?Q?V1oSL/Fm5lMPEQCv/KwcI7KFHx6O+QayhGNaH8TRY1dVwsM1x4UXUsXWfzB3?=
 =?us-ascii?Q?OjIQdYeg2H3RvhNZci6GK9e7LEmn59GsOLIUYIF5Mm3QI7MYm9lWeqpLgw5R?=
 =?us-ascii?Q?a5K9QUKMfQvwdEeMH/eysP5/0TAxE4CFhXTXrTDYG5IN12Ly4OigRF/GidlS?=
 =?us-ascii?Q?Kjd47xqXGZrZExRiM+drLQ9ECFN/dhnMzIK1BTrLdG1hrjBHfDica1GpqCVL?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf45a97-a546-43fd-cf1e-08dc3672343a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR01MB7876.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 02:25:31.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kYFnIkqd8OHIMwtllNxxiGDjShoi/akfBHD29A/PFrO+f0TDswRxZkUir5cv01nlW/DBiA6TVG4JtfyY+SgqGTAqpXLMvR8KfbA8es0JhatmafcXffXv7Qi9E3QtvFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6740

This patch adds /proc/sys/net/core/mem_pcpu_rsv sysctl file,
to make SK_MEMORY_PCPU_RESERV tunable.

Commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
memory_allocated") introduced per-cpu forward alloc cache:

"Implement a per-cpu cache of +1/-1 MB, to reduce number
of changes to sk->sk_prot->memory_allocated, which
would otherwise be cause of false sharing."

sk_prot->memory_allocated points to global atomic variable:
atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;

If increasing the per-cpu cache size from 1MB to e.g. 16MB,
changes to sk->sk_prot->memory_allocated can be further reduced.
Performance may be improved on system with many cores.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 Documentation/admin-guide/sysctl/net.rst | 5 +++++
 include/net/sock.h                       | 5 +++--
 net/core/sock.c                          | 1 +
 net/core/sysctl_net_core.c               | 9 +++++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 396091651955..7250c0542828 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -206,6 +206,11 @@ Will increase power usage.
 
 Default: 0 (off)
 
+mem_pcpu_rsv
+------------
+
+Per-cpu reserved forward alloc cache size in page units. Default 1MB per CPU.
+
 rmem_default
 ------------
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 796a902cf4c1..09a0cde8bf52 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1443,6 +1443,7 @@ sk_memory_allocated(const struct sock *sk)
 
 /* 1 MB per cpu, in page units */
 #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
+extern int sysctl_mem_pcpu_rsv;
 
 static inline void
 sk_memory_allocated_add(struct sock *sk, int amt)
@@ -1451,7 +1452,7 @@ sk_memory_allocated_add(struct sock *sk, int amt)
 
 	preempt_disable();
 	local_reserve = __this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve >= SK_MEMORY_PCPU_RESERVE) {
+	if (local_reserve >= READ_ONCE(sysctl_mem_pcpu_rsv)) {
 		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
 		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
 	}
@@ -1465,7 +1466,7 @@ sk_memory_allocated_sub(struct sock *sk, int amt)
 
 	preempt_disable();
 	local_reserve = __this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve <= -SK_MEMORY_PCPU_RESERVE) {
+	if (local_reserve <= -READ_ONCE(sysctl_mem_pcpu_rsv)) {
 		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
 		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index 8d86886e39fa..df2ac54a8f74 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -283,6 +283,7 @@ __u32 sysctl_rmem_max __read_mostly = SK_RMEM_MAX;
 EXPORT_SYMBOL(sysctl_rmem_max);
 __u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
 __u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
+int sysctl_mem_pcpu_rsv __read_mostly = SK_MEMORY_PCPU_RESERVE;
 
 int sysctl_tstamp_allow_data __read_mostly = 1;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0f0cb1465e08..986f15e5d6c4 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -30,6 +30,7 @@ static int int_3600 = 3600;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
+static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
@@ -407,6 +408,14 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_rcvbuf,
 	},
+	{
+		.procname	= "mem_pcpu_rsv",
+		.data		= &sysctl_mem_pcpu_rsv,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_mem_pcpu_rsv,
+	},
 	{
 		.procname	= "dev_weight",
 		.data		= &weight_p,
-- 
2.25.1


