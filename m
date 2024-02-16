Return-Path: <linux-kernel+bounces-68285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FAE857834
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA9A2881FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F901B972;
	Fri, 16 Feb 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CrsZxBl2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC917BD6;
	Fri, 16 Feb 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073804; cv=fail; b=JoELioj8t0zH70MlP9PRWYipZVvdtCToB73A/SsyMmxu0QFH19jejaA7Ry6qgLorZuPkRroyWAMzNFUxWX+0z+OKy5LeeJzVfpTYGxA5LPcVeQREf2zcwd7/K85BX2O/7XlU0j1Cy4a8nh+i1ejFYW6EwwOCsrisgvkOqJCEV5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073804; c=relaxed/simple;
	bh=X+hc+1P0z3IvkX8FX1DS1p5o88isvxL8xj2aD0PIczA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ppRSp8TImspvywiYOKpCQ6MVXsRyMi38F4+HJ8r6i7mPbqDRC1zKYacbLU0avzLYrtkuryDVfND5cZskQ515sKhnCDjFxEB50s3bVN2/H/qbyM4iDt8tjjKokclHKndFNd/qUrwo9egw9AKMODZTRk895fXhHdkRZCqqGStOkvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CrsZxBl2; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TguaNfraMFhSFjcTDZyOtlKmFJVJVudKlOrgFOoqOQ30amWtCfw+cbpxP6ciQ77ONxGC7o+BE8x9n27gzaRYBB4DI2biwVX3fSebXZM+x0KBVHpXrp3DjhgvNo0GGpDbAn5Ywvt27bU9FVoPViP9svhOCdsgT+uSb1OAcbIsEy+aRVgWgttjmhnyqaPQYbdeRTf0bbGurvyY94zXl0tmd64PPJNpyH9FBI7lQFK5lRMzYejd+bReITpF0Aa42gMCe0ikyunTB6/PiRzon2aUHcosE5GlBhKKJhdYtSwTUlaNwra4yeAoVbnkuEnn13pzZJvlltFVOaoVMCeRyxfqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrmAB+aUY0Jr1bYbRAMAa00B92HbgX5ycs3dYx+xs4g=;
 b=MmE+ICrI+lK00NsqSJr2KVGrI0m7J88M9fU6/IPbd8n5yRTYGGaOjdMOVxC/aWf/tOcaql41EXESioFH+f3znI4X0mCogJll1Okno3qhJwTKxODsPLM0iBjAqWRYC2lSc8NnznzKQX3GJhmUuHztjsv8YKQRkEI5ibgBWfQoTM0hY7AlFyoQCy90+Wv14hnzZGfnm2l3BW6GL/9Zw4b8onbnveS8tn31V3byx7AIt29c1YsWM8NdW89BbbNJT3qBTcqqol+KEWMpg7c5FH7lRp8ITH2P9S4rQM9JFrQbKdhbbvAKLsZKAcJtk/swpeeq7PyLT7tM6A0aKNe7/jEhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=fiberby.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrmAB+aUY0Jr1bYbRAMAa00B92HbgX5ycs3dYx+xs4g=;
 b=CrsZxBl2y0YxJ+SAm4CP+qfxAGAKOO6+FgtmX96h/sBRde++slRMXYrEZRc9mzozisG6wsDh/fPeazC+aCjc5Xx8kQexAdeMh/OwnSzwR9zbTXFTHE10z+bvYUce0OFsu8PupmddVYJ/O4ipVGE+XSMr6zFLX4IN5FG/EIXCkTzTAT68b4vOzKXfeTWNzlH3MedtqIv3Csq50a/D9WBOb1pge0hibDfxdIlXEBCUKSsEhvQE6OQRCU3aOcfZEqQpbcOeJManME362ujAOKECvHoFL620Vh6VSKT1zpdfR4CO8JnQirkQbLmDUFsivIBU8oYh1T8SmNOgEXcgD4bOAA==
Received: from DM6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:5:1b3::24)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 08:56:38 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::42) by DM6PR17CA0011.outlook.office365.com
 (2603:10b6:5:1b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 08:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 08:56:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 00:56:23 -0800
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 16 Feb
 2024 00:56:20 -0800
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-4-ast@fiberby.net>
User-agent: mu4e 1.10.5; emacs 29.1.90
From: Vlad Buslov <vladbu@nvidia.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?= <ast@fiberby.net>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <llu@fiberby.dk>
Subject: Re: [PATCH net-next 3/3] net: sched: make skip_sw actually skip
 software
Date: Fri, 16 Feb 2024 10:47:18 +0200
In-Reply-To: <20240215160458.1727237-4-ast@fiberby.net>
Message-ID: <871q9cdbyl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f642276-b806-48bb-4f5e-08dc2ecd2f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ZjqSZ6oKpwWLM6Sy7zwBAjIClbfCGXDiPLDRQOfNBAaxtDosKed447k1IVe5vIyUF3SyU3Ijb3PiqLkhRYPT9+rgSmDt9STbYjpMSsZaevg1MOl+pB3u97aepIk4hFJDUjP/hLODVPsNZx5fW2zqvD5tcGEOk9YIsZK8N4ME3BwSOPPDSPWKJyOSUjnBRIgU710Qx1i+VKt8ckDzhGGy2a93a4PxN8k54XH7AM60qBGm8rEvDfr9S9urKNLJ1p+IvhY71Eh6JCxIUH/gNn/ufu1Ika5yKhLHJcuednbfJQ3mIAkBU6krhYwlrrqQn4AlszfvwhzABb/4e4+DSq3TC4zn/1r+CvIwK7MLKIgWpzBin0Nb0HzrB9hTUR+rchxaX5RLWw+L74uhlcBP7HdCy0tVqgGLWGfsYEx3eZYIks6v7qukcjys/kw57K/rUR576xi00u1Y94V3RByCcrBj/NjuULVafb/0TsesCts0tL1X2HxHKePluf4InUDI4u4Mq04i5GQvXbbKvYVUcCbMLtqTAkHqXMpUKhRWKGjbQUf5+SnYEBgryuD3gz1GvaliXZo57BE7LurLZ+GfURMCsJWLb7iTBx8qKXYUN2VUq5D6d7yvFeBqTKcE4SB2I/cxhSceCeic8mNlHYi3fGXnQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36860700004)(40470700004)(46966006)(2906002)(8936002)(8676002)(4326008)(5660300002)(66574015)(426003)(336012)(83380400001)(2616005)(16526019)(26005)(36756003)(86362001)(356005)(7636003)(82740400003)(6916009)(54906003)(70586007)(70206006)(316002)(7696005)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:56:37.4918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f642276-b806-48bb-4f5e-08dc2ecd2f45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863

On Thu 15 Feb 2024 at 16:04, Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.=
net> wrote:
> TC filters come in 3 variants:
> - no flag (no opinion, process wherever possible)
> - skip_hw (do not process filter by hardware)
> - skip_sw (do not process filter by software)
>
> However skip_sw is implemented so that the skip_sw
> flag can first be checked, after it has been matched.
>
> IMHO it's common when using skip_sw, to use it on all rules.
>
> So if all filters in a block is skip_sw filters, then
> we can bail early, we can thus avoid having to match
> the filters, just to check for the skip_sw flag.
>
>  +----------------------------+--------+--------+--------+
>  | Test description           | Pre    | Post   | Rel.   |
>  |                            | kpps   | kpps   | chg.   |
>  +----------------------------+--------+--------+--------+
>  | basic forwarding + notrack | 1264.9 | 1277.7 |  1.01x |
>  | switch to eswitch mode     | 1067.1 | 1071.0 |  1.00x |
>  | add ingress qdisc          | 1056.0 | 1059.1 |  1.00x |
>  +----------------------------+--------+--------+--------+
>  | 1 non-matching rule        |  927.9 | 1057.1 |  1.14x |
>  | 10 non-matching rules      |  495.8 | 1055.6 |  2.13x |
>  | 25 non-matching rules      |  280.6 | 1053.5 |  3.75x |
>  | 50 non-matching rules      |  162.0 | 1055.7 |  6.52x |
>  | 100 non-matching rules     |   87.7 | 1019.0 | 11.62x |
>  +----------------------------+--------+--------+--------+
>
> perf top (100 n-m skip_sw rules - pre patch):
>   25.57%  [kernel]  [k] __skb_flow_dissect
>   20.77%  [kernel]  [k] rhashtable_jhash2
>   14.26%  [kernel]  [k] fl_classify
>   13.28%  [kernel]  [k] fl_mask_lookup
>    6.38%  [kernel]  [k] memset_orig
>    3.22%  [kernel]  [k] tcf_classify
>
> perf top (100 n-m skip_sw rules - post patch):
>    4.28%  [kernel]  [k] __dev_queue_xmit
>    3.80%  [kernel]  [k] check_preemption_disabled
>    3.68%  [kernel]  [k] nft_do_chain
>    3.08%  [kernel]  [k] __netif_receive_skb_core.constprop.0
>    2.59%  [kernel]  [k] mlx5e_xmit
>    2.48%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
>
> Test setup:
>  DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
>  Data rate measured on switch (Extreme X690), and DUT connected as
>  a router on a stick, with pktgen and pktsink as VLANs.
>  Pktgen was in range 12.79 - 12.95 Mpps across all tests.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  include/net/pkt_cls.h | 5 +++++
>  net/core/dev.c        | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a4ee43f493bb..a065da4df7ff 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -74,6 +74,11 @@ static inline bool tcf_block_non_null_shared(struct tc=
f_block *block)
>  	return block && block->index;
>  }
>=20=20
> +static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block)
> +{
> +	return block && atomic_read(&block->filtercnt) =3D=3D atomic_read(&bloc=
k->skipswcnt);
> +}

Note that this introduces a read from heavily contended cache-line on
data path for all classifiers, including the ones that don't support
offloads. Wonder if this a concern for users running purely software tc.

> +
>  static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
>  {
>  	WARN_ON(tcf_block_shared(block));
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d8dd293a7a27..7cd014e5066e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struct s=
k_buff *skb,
>  	if (!miniq)
>  		return ret;
>=20=20
> +	if (tcf_block_has_skip_sw_only(miniq->block))
> +		return ret;
> +
>  	tc_skb_cb(skb)->mru =3D 0;
>  	tc_skb_cb(skb)->post_ct =3D false;
>  	tcf_set_drop_reason(skb, *drop_reason);


