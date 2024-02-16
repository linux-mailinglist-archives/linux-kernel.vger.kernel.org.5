Return-Path: <linux-kernel+bounces-68253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F78577DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741AB283F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC9C1C288;
	Fri, 16 Feb 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m/IPNiNK"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA281BF5D;
	Fri, 16 Feb 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072835; cv=fail; b=NImc3yn1xTpzkPrXwH38AS0F1uqdkWh3XoVJ33yarsCBqwAugROleW9XKO3FSQVg5I8lLt9BG2BkTWTfCvUDE1dtpuZSUBYw7olBEuG9a7pu6TV4JAgTf2jbB2u1ZC/K/boQ0W3Tr55zZj6YTmM1I9vQBdODsb3ukXXtdYEZ8ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072835; c=relaxed/simple;
	bh=vcUPCUlylqtrdeSpoWwVYAiI5KV5q0ib86+L4C2vVfo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ukhEN2d75DGt3QzNGWX0A0SaYq+EBXnmyMSCnsweuCPm+Zb6hTwV/JliW+Bui4wOjvMW9n22VNwi2Pxi4K+M9E+GkTaYKjFIN+PRHvL5TGpxEsGqA4TGzXoQf6ZbYTLQzozdwj0uU0lq+YMk0k3P/n8B49Zzc5chZtoC8MP86y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m/IPNiNK; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DakhCVmfLh3NZVKJfl0IFw+NzUrEf2CQ3EQ2jSW9H2bbx4o2PnwsUHWNKdvX7v7tJE8RNUxi4tNLRVmNjNxLauKhIlDaBpIXtAxB719XyA1Kh8xxrNs6SgSNVbk+4YP5nx4A/yG1vfgTzp6v1nzOan2LmdoLnwdxJ69aUmgYxeq5DNkgxxNt1U9bU5lwaxZiBNHfREEYpr7B7GMKjE0/CvPSxxHze/+PN00ZlZZboR1EPdd5eso/DadFjjhB1VEoYuyZuN6jvpYEv9b0K2USW0zT9XFXYJTG9HVxuh0G7I6086rS9+LYFDxZMCf5VP3u8KuGxRxn1zhJ2/F5VewfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w1rECigBpp6HzJWD+4BnqV6Kp+gLOycyFvGNiyW9CM=;
 b=Ipx0EKPyNBh1EWX2A+uwSvslpo/M2qGyAXD6GdDmsalo+zdhPrKOIvDtY6O/OwBc23NL7t/PKOlB6E6guULs++Nhgvd66bz56y8aLJL4KA5iIGpZLTPpY3GaOZqTHIeYnq8yxjI4YN0pDaWZVsRFu54hCdepZ23mtz+QEBzYd3kSFVcH+lG1/rjosxsTzJgfmj1Ov8D5i8Qgxf+lV99N2E7uPokoy2mlTDYhEHdabonZEszN4J7z2pCYxnwlybHWSrEKLW72ZRZwULEG2JfQZTf22hPB6Zcd4W7q1rV9CQY65vJR6nIwXMmaVGvmpfaanYzS66bKBBLDtMDOrPP7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w1rECigBpp6HzJWD+4BnqV6Kp+gLOycyFvGNiyW9CM=;
 b=m/IPNiNKgqt66c3DvmYeET8eC5UdAcaSC2cdvl16lliSlFTIy++ylpnj7/goKS6NPnrf1EyzD74cVkli3SbfwUOhZafi0WQME91J4ys5HMGeFtOADSHFmB3c7BVl/4nanT2CBXptPGIzyNZbenH3Z7CgBy5bE4MiMpVqQWsvPEVpHhOtCmfI/jCQ37hmOykmabPiPgTDnyhsxo5F3iEFzZezRhr6JMhXIQRP4Dx2/4mvG7dHR2WvWUpg7HH9ZNIA0NXkDh7h/eSC8SW79vfKu0oErM8/+e1bOSaVK5EFvVwhL1gxgobtTgqxkdLOpQMMVuGDxLXhp3nzkr3itKfhtA==
Received: from DM6PR07CA0056.namprd07.prod.outlook.com (2603:10b6:5:74::33) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 08:40:30 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::49) by DM6PR07CA0056.outlook.office365.com
 (2603:10b6:5:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 08:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 08:40:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 00:40:19 -0800
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 16 Feb
 2024 00:40:17 -0800
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-2-ast@fiberby.net>
 <CAM0EoMndBjwC8Otx6th_dM_aV_r80NeLEke9C8PwzGt1q3vAMA@mail.gmail.com>
 <a4798b5d-1a8a-41ab-842f-52e8c7ac00ed@fiberby.net>
User-agent: mu4e 1.10.5; emacs 29.1.90
From: Vlad Buslov <vladbu@nvidia.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?= <ast@fiberby.net>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <llu@fiberby.dk>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: sched: cls_api: add skip_sw counter
Date: Fri, 16 Feb 2024 10:35:40 +0200
In-Reply-To: <a4798b5d-1a8a-41ab-842f-52e8c7ac00ed@fiberby.net>
Message-ID: <87a5o0dcpd.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: abfd1028-6e7a-4ed0-3e17-08dc2ecaeee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5ow/cBUMt2jcHsrnD2LU45T1Z9f8ikVUWkmJaaetZj0wEG7QGi0JyAXvWMV1gmEYSa5pgft8tzjE0jZJ2V02be24HMJmfaYHxwka2JkEVeJ2aBy/Niot6oecTArb9ay2GhqAy2gdgmM2IvhpZmmnf6Kk5Mb9a4O3tnavGi2uio5vvvkXx25tO8pbWEVPO8sf27K6vqdm7v6RSoa2q50mMIZIQk0eczEreGyFOQ/SM5ADvCm1jkjVtaKj5TgErNVXER+a1bqxiQl+kOYD9RIl1qflkvY/Hoa6WdQgb5VULe9e6ktUyEUUkINjyruPIb1B552jzeJramYMLkmfuPjtdloGy5bK1zGGCQAi5FxyR6zrlZV3jjM1j5CSVEdpD8JJMRibmZEKJcKbiYFpQAM2DNJVOReKpu+7C1622j52erMgj+TA6/o3JufhyEtxkpnGlktXo11IkvsQGDfpzdKQ7O6j3fZ1cIkHkpxDnvAd23+B63wJ12qu1F3vsN80utXYkTN9oqpBcmEpHIrWES18bHi0T2/y5K3HzYu4rbotrSoSAh3ls97+e4hKF4kqXSDolxeozwqcPMfIr5jiUbaRcwp+Q5ck7WUuYF6nLpselDYXxWymErDVbTk78t7cchMxZy5z8u41IBRWX+aBcF6FRj7z8tEn23X7JpkK+rKdv8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(36860700004)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(70586007)(41300700001)(70206006)(82740400003)(7636003)(2906002)(16526019)(86362001)(4326008)(316002)(5660300002)(8676002)(8936002)(356005)(36756003)(426003)(83380400001)(336012)(54906003)(6916009)(53546011)(7696005)(66574015)(478600001)(6666004)(26005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:40:30.4618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abfd1028-6e7a-4ed0-3e17-08dc2ecaeee0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

On Thu 15 Feb 2024 at 23:34, Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.=
net> wrote:
> Hi Jamal,
>
> Thank you for the review.
>
> On 2/15/24 17:39, Jamal Hadi Salim wrote:
>> +Cc Vlad and Marcelo..
>> On Thu, Feb 15, 2024 at 11:06=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnese=
n <ast@fiberby.net>
>> wrote:
>>>
>>> Maintain a count of skip_sw filters.
>>>
>>> This counter is protected by the cb_lock, and is updated
>>> at the same time as offloadcnt.
>>>
>>> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
>>> ---
>>>   include/net/sch_generic.h | 1 +
>>>   net/sched/cls_api.c       | 4 ++++
>>>   2 files changed, 5 insertions(+)
>>>
>>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>>> index 934fdb977551..46a63d1818a0 100644
>>> --- a/include/net/sch_generic.h
>>> +++ b/include/net/sch_generic.h
>>> @@ -476,6 +476,7 @@ struct tcf_block {
>>>          struct flow_block flow_block;
>>>          struct list_head owner_list;
>>>          bool keep_dst;
>>> +       atomic_t skipswcnt; /* Number of skip_sw filters */
>>>          atomic_t offloadcnt; /* Number of oddloaded filters */
>> For your use case is skipswcnt ever going to be any different than offlo=
adcnt?
>
> No, we only use skip_sw filters, since we only use TC as a control path to
> install skip_sw rules into hardware.
>
> AFAICT offloadcnt is the sum of skip_sw filters, and filters with no flag=
s which
> have implicitly been offloaded.
>
> The reason that I didn't just use offloadcnt, is that I'm not sure if it =
is
> acceptable to treat implicitly offloaded rules without skip_sw, as if the=
y were
> explicitly skip_sw. It sounds reasonable, given that the filters without =
skip_* flags
> shouldn't really care.

It is not acceptable since there are valid use-cases where packets need
to match sw filters that are supposedly also in-hw. For example, filters
with tunnel_key set action during neighbor update event.

>
> I tried to only trigger the TC bypass, in the cases that I was absolutely=
 sure would
> be safe as a first step.
>
>
>> cheers,
>> jamal
>>=20
>>>          unsigned int nooffloaddevcnt; /* Number of devs unable to do o=
ffload */
>>>          unsigned int lockeddevcnt; /* Number of devs that require rtnl=
 lock. */
>>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>>> index ca5676b2668e..397c3d29659c 100644
>>> --- a/net/sched/cls_api.c
>>> +++ b/net/sched/cls_api.c
>>> @@ -3483,6 +3483,8 @@ static void tcf_block_offload_inc(struct tcf_bloc=
k *block, u32 *flags)
>>>          if (*flags & TCA_CLS_FLAGS_IN_HW)
>>>                  return;
>>>          *flags |=3D TCA_CLS_FLAGS_IN_HW;
>>> +       if (tc_skip_sw(*flags))
>>> +               atomic_inc(&block->skipswcnt);
>>>          atomic_inc(&block->offloadcnt);
>>>   }
>>>
>>> @@ -3491,6 +3493,8 @@ static void tcf_block_offload_dec(struct tcf_bloc=
k *block, u32 *flags)
>>>          if (!(*flags & TCA_CLS_FLAGS_IN_HW))
>>>                  return;
>>>          *flags &=3D ~TCA_CLS_FLAGS_IN_HW;
>>> +       if (tc_skip_sw(*flags))
>>> +               atomic_dec(&block->skipswcnt);
>>>          atomic_dec(&block->offloadcnt);
>>>   }
>>>
>>> --
>>> 2.43.0
>>>


