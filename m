Return-Path: <linux-kernel+bounces-157362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6E8B1062
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10081C21E01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9316D309;
	Wed, 24 Apr 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0+MWzYH"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9916C450;
	Wed, 24 Apr 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977841; cv=fail; b=IG2P9gtqDPwfL4/uVxm1m9mAQJ27m9mKmKk8rWFctr4dPfjauJ+6fGD7dvlrT/FMGkac+fNDoAdiCJkzDGuklG4nDuKTFrTu8Kyr77PiQ7nZjy2fb62EKdAenEGVqmayCU21nLRpMeAznAXKP/saxW7AdpAta+aSkhH/mprBCRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977841; c=relaxed/simple;
	bh=j0G2oov7Zzf3kke7g6xoPnuUWSt+Q/udkN9+gj+UKeo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzWuhtJBTzQscMa4WuGIaq9JFTKqDTXMUkbvqEm393pakDu1O8BQ8K+S8CNc395jb/1za7lpjEtEzClSEVooqJIM5dJIzj2QvP9Gc2BFMbhvaA/QmvNpc/4gH8mXqkSLnihGoVsCy4t276srb2KV4VOX+S185hLd3TootJ3xiqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0+MWzYH; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHgJvACNv4cGdLc5fCtId75ngoLDUPvKBmWX6NvGAlQgtK3p18kSZ4ZMvi7qHlssSZwnLH/3GzzDLo/eQmNoCj3Bgvm8oZ/Fijb6wbYFsKo4WpPBZL6v4dsl94HqOXZR3smE8uFx8+PIKH1L3SUmL2d0hMjUt6kksbsVJcgm6S1lqk0VnA8MaIjbJhhCxp8kVXEyhwGkszGaE2kaGcMA3XD6tCZDlkNb8SntxGYtDv8gAOG4H5Liw0Pto+5ip5aFEvuOkpZDyctZ0woGL/b+LtgGhIxNrxsFuFoDOaQZleipfpjCPDzhHCri3S1IJxCTvDoFgaHcfQRpGB2ha4AtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcZFu7Pkqq156gqNFPs26147nmG7rSp+v40nJ5Y3Hc8=;
 b=mEbz7OjX92DGQn7xHZjZGea7SYX0LwP/AxivcUaox8vnGeV0dDgqTOqdyx+iOZmeaC7sdDfLAbDh0tcfSh/oDBGAXluupjQn/CPiBN5c7yi689NAZQ7rJZOoW7rntUrF05aAlLC3SxEc0bXRSM59aPY5cqAjFPobdFrBh3fhHS8EaBm3iO/Z9EKqWHNDpfcDMbz9+2UZ3ypBDFWdP15CtCZTcMTh9WSnfq8GfuhMRoURpmlzBoBvGDSz4ENJighFcuk8+jTBjng3ATfJxArNEc9ry/MMhp/Kupn14GChNzVcgu6b+gppHbg43RFzjDS/rrsHeT9QRgt00PAUGb1jGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcZFu7Pkqq156gqNFPs26147nmG7rSp+v40nJ5Y3Hc8=;
 b=n0+MWzYHGgxf3s0dO4nK7eBQfG8CzGt3mG8WW0O5GaMSa1jb2VbT0zq26i4T6Y5M08ZzXbXMeYYb70yml8ANO8pjHOdD47tp4j43dstqlUkJ1IPasKa0VXWsb2yyc92wErd6DyEVtHcMcpoNlmvzp5BMiA3TWN8syFifIqvvy/7L5es+lKznVb9WtwhJj/iLKGFOXuvNBiYvbbEx2UDovXwNkRpFQtii8TJqd/znHS+KkOB8L1nul3O73w6gs0hHS38OqeDBKR8wscBcneqk89a8f8R+rfm6zcUv49H0vGHL+pLHxVeXkckFE6i1UnrAqftc7yg2+iuNHjabap2t7Q==
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 16:57:15 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::60) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Wed, 24 Apr 2024 16:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 16:57:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 09:56:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 09:56:53 -0700
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Wed, 24 Apr 2024 09:56:51 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mina Almasry
	<almasrymina@google.com>, Jacob Keller <jacob.e.keller@intel.com>
CC: Jianbo Liu <jianbol@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Date: Wed, 24 Apr 2024 19:56:46 +0300
Message-ID: <20240424165646.1625690-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.42.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 21971d67-c8fa-4d4f-98a3-08dc647f97c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FUukJpNr9davpWBU/TW7uN3kGSL7H7gsYbkdlB4B/DsAkygTTDOD+wqyye49?=
 =?us-ascii?Q?1qCzHid/gktoHjpnjls4fUpwk4Nehqwk+wvNTjzFpgzku+Zkmwj5kBrnSTSI?=
 =?us-ascii?Q?Dv1hWa7dT8eXGpQvTPHYXQmlayXFyhH+IcxY1ok+1HWc+53FrwoIYIvP33du?=
 =?us-ascii?Q?Yvnl/Ds7PiUUoHSBfZLZoZ05AUZMd6ovhTBPbNMSJMH6vKEAreSZ74whkgw7?=
 =?us-ascii?Q?6JKgk+G6r14dgV4YMH49MlmmPKR7uxIkRujMI2NPr7wonrc5fCnpfsStI6jv?=
 =?us-ascii?Q?EqcjyqIgXQbUbcXIay1V3HseyGk5jjdMP8BIXw/e1N3PN4Tf4Hf/qAoJIThu?=
 =?us-ascii?Q?w0ewou7rvf4S6sx+8wDayMFhOVin55a8GZFG9KOJBxWwtBYfJjTHx/rFQQmo?=
 =?us-ascii?Q?LMstYtpMZQ+6wzbmuM/4fEbJ1pMkfXgLhvrUmXmQk1tUkqSNfH3m2dUzDp8N?=
 =?us-ascii?Q?AWCKJeWYLHXE887bmsBfzwjv8+PveKrlCiUhmKQVrqZmLUcPdBrESLavYZlh?=
 =?us-ascii?Q?lVGecdjzoW9KF93FjMc5Dud6Kq0/mCHJq3VDoy2erttiXgBiwKM7rG5YDzeZ?=
 =?us-ascii?Q?IaXkdJOVW3AD6ezERJdRa82l0ECm9ciatYUYJE+PLzXrHHia4zZ0jlTYGJIe?=
 =?us-ascii?Q?CIRMUvr3WgzCxBFIWUORlM2YEBuDgqHJ+pmACOXqLVSmkmNo+R440x/pdaqA?=
 =?us-ascii?Q?YONU/RakVHtTG93gasYSTchx+XtATf5ekYuKRGaFoNNzIzjbeGcJ7RdTwl8J?=
 =?us-ascii?Q?HjWBBZiPVv6h6rhQr3Zo+TMCHKt8C0Nt/lVx3Pi7YHug3lYnSSE4dwabPnR7?=
 =?us-ascii?Q?iigsYjrZt6h35KUA2KEJl7eIuSubwjbEEcxYe9Wn36AaiW9Avav0Oh+WKtQ3?=
 =?us-ascii?Q?2k2QmyvUfNOAC5vx+LjtpyVKpVBhUbqRdsonWeMIb3wbC+tkEeImUxbWt3jb?=
 =?us-ascii?Q?bCj3v9CEU1/gtRhoClT69MZIqBOPmRuCskySIjM1f46lhzZbL9/Anv/ODSNx?=
 =?us-ascii?Q?lsDsTr2EtfGawlXXMeLUTbka61swhphOTo3agrPbLlWmITg8I2kktpix4Om1?=
 =?us-ascii?Q?nHBgJnuApouNdXs2kalsx34hhKn0Rrmit2pjgySxhvqqD3aqhz6EAwWnvirN?=
 =?us-ascii?Q?1uhXdpAzUsxavywyNZW7YvMDX/XEHMZvBpKzTXYzP8pzYJrY5t7WMYOc9Dff?=
 =?us-ascii?Q?sSqs4ZDRWNFpQQqGFaXJTKXqWGB3v5HHFpN6njq6zVAH+UHkvy4nWJZh2zVl?=
 =?us-ascii?Q?PFmZ7wspIUqrQ7aEoK1/PIpbRoYzwLjf5zU2g7iWIwS3lciHEgUE2d2S62ti?=
 =?us-ascii?Q?6nc4JriIKmskW0VYXvAEsLb6/HHPwGerymXnW9ZFJkTTVPISkT2CG8ckEOVx?=
 =?us-ascii?Q?6eApe5IQKXzxckxLao73qo0/Fp6r?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 16:57:14.8032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21971d67-c8fa-4d4f-98a3-08dc647f97c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

The patch referenced in the fixes tag introduced the skb_frag_unref API.
This API still has a dark corner: when skb->pp_recycled is false and a
fragment being referenced is backed by a page_pool page, skb_frag_unref
can leak the page out of the page_pool, like in the following example:

 BUG: Bad page state in process swapper/4  pfn:103423
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x103423000 pfn:0x103423
 flags: 0x200000000000000(node=0|zone=2)
 page_type: 0xffffffff()
 raw: 0200000000000000 dead000000000040 ffff888106f38000 0000000000000000
 raw: 0000000103423000 0000000000000041 00000000ffffffff 0000000000000000
 page dumped because: page_pool leak
 Modules linked in: act_mirred act_csum act_pedit act_gact cls_flower
 act_ct nf_flow_table sch_ingress xt_conntrack xt_MASQUERADE
 nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat
 br_netfilter overlay rpcrdma rdma_ucm ib_iser libiscsi
 scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_ib
 ib_uverbs ib_core zram zsmalloc mlx5_core fuse CPU: 4 PID: 0 Comm:
 swapper/4 Not tainted 6.9.0-rc4+ #2
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x53/0x70
  bad_page+0x6f/0xf0
  free_unref_page_prepare+0x271/0x420
  free_unref_page+0x38/0x120
  ___pskb_trim+0x261/0x390
  skb_segment+0xf60/0x1040
  tcp_gso_segment+0xe8/0x4e0
  inet_gso_segment+0x155/0x3d0
  skb_mac_gso_segment+0x99/0x100
  __skb_gso_segment+0xb4/0x160
  ? netif_skb_features+0x95/0x2f0
  validate_xmit_skb+0x16c/0x330
  validate_xmit_skb_list+0x4c/0x70
  sch_direct_xmit+0x23e/0x350
  __dev_queue_xmit+0x334/0xbc0
  tcf_mirred_to_dev+0x2a5/0x3e0 [act_mirred]
  tcf_mirred_act+0xd7/0x4b0 [act_mirred]
  ? tcf_pedit_act+0x6f/0x540 [act_pedit]
  tcf_action_exec+0x82/0x170
  fl_classify+0x1ee/0x200 [cls_flower]
  ? tcf_mirred_to_dev+0x2a5/0x3e0 [act_mirred]
  ? mlx5e_completion_event+0x39/0x40 [mlx5_core]
  ? mlx5_eq_comp_int+0x1d7/0x1f0 [mlx5_core]
  tcf_classify+0x26a/0x470
  tc_run+0xa2/0x120
  ? handle_irq_event+0x53/0x80
  ? kvm_clock_get_cycles+0x11/0x20
  __netif_receive_skb_core.constprop.0+0x932/0xee0
  __netif_receive_skb_list_core+0xfe/0x1f0
  netif_receive_skb_list_internal+0x1b5/0x2b0
  napi_gro_complete.constprop.0+0xee/0x120
  dev_gro_receive+0x3f4/0x710
  napi_gro_receive+0x7d/0x220
  mlx5e_handle_rx_cqe_mpwrq+0x10d/0x1d0 [mlx5_core]
  mlx5e_poll_rx_cq+0x8b/0x6f0 [mlx5_core]
  mlx5e_napi_poll+0xdc/0x6c0 [mlx5_core]
  __napi_poll+0x25/0x1b0
  net_rx_action+0x2c1/0x330
  __do_softirq+0xcb/0x28c
  irq_exit_rcu+0x69/0x90
  common_interrupt+0x85/0xa0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x26/0x40
 RIP: 0010:default_idle+0x17/0x20
 Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff ff cc cc cc cc f3 0f 1e
 fa 8b 05 76 3f 0a 01 85 c0 7e 07 0f 00 2d 1d 74 41 00 fb f4 <fa> c3 0f
 1f 80 00 00 00 00 f3 0f 1e fa 65 48 8b 35 04 b3 42 7e f0
 RSP: 0018:ffff88810087bed8 EFLAGS: 00000246
 RAX: 0000000000000000 RBX: ffff8881008415c0 RCX: 000000e116d359fb
 RDX: 0000000000000000 RSI: ffffffff8223e1d1 RDI: 000000000003f214
 RBP: 0000000000000004 R08: 000000000003f214 R09: 000000e116d359fb
 R10: 000000e116d359fb R11: 000000000005dfee R12: 0000000000000004
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  default_idle_call+0x3d/0xf0
  do_idle+0x1ce/0x1e0
  cpu_startup_entry+0x29/0x30
  start_secondary+0x109/0x130
  common_startup_64+0x129/0x138
  </TASK>

How it happens:
-> skb_segment
  -> clone skb into nskb
  -> call __pskb_trim(nskb)
    -> call pskb_expand_head(nskb) because nskb is cloned
      -> call skb_release_data(nskb) because nskb is cloned
        -> nskb->pp_recycle = 0
    -> skb_unref(nskb->frag[i], nskb)
    	-> nskb->pp_recycle is false, frag is page_pool page
	-> Fragment is released via put_page(frag page), hence leaking
	   from the page_pool.

Something tells me that this is not be the only issue of this kind...

The patch itself contains a suggested fix for this specific bug: it
forces the unref in ___pskb_trim to recycle to the page_pool. If the
page is not a page_pool page, it will be dereferenced as a regular page.

The alternative would be to save the skb->pp_recycled flag before
pskb_expand_head and use it later during the unref.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Co-developed-by: Jianbo Liu <jianbol@nvidia.com>
Fixes: a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
Cc: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 37c858dc11a6..ab75b4f876ce 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2634,7 +2634,7 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 		skb_shinfo(skb)->nr_frags = i;
 
 		for (; i < nfrags; i++)
-			skb_frag_unref(skb, i);
+			__skb_frag_unref(&skb_shinfo(skb)->frags[i], true);
 
 		if (skb_has_frag_list(skb))
 			skb_drop_fraglist(skb);
-- 
2.44.0


