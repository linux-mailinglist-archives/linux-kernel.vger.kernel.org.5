Return-Path: <linux-kernel+bounces-68267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66F8577F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFCDB20AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF181B953;
	Fri, 16 Feb 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RKFedAqy"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF631862F;
	Fri, 16 Feb 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073223; cv=fail; b=NywWJpHsIl25esIC6OnQK3P1GzMkd+rpwQfoyAy7WvsANnQA2VtdYK4p0lIvUoJw8TTqHCkhAmwO7oNuZfycMGDFMSlBLTkzMhNERCyuf3AlUbhyDLwdefjQMxPLwJaPzextBXZdyAoXcs0F+jUXUCvX+z0SmajT1omGh7eFP/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073223; c=relaxed/simple;
	bh=tL3WvbMvdqZ256RnFMXh8vg6/l6QuV1mEh3+REdoo/I=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jo7RnXY7GCARn8DAZsBYwVanfHSN4k+5q1JEcoywg08GQLAcHzSRORenjXnhIfbBvNB/LYpGJK3IH9006EVFLF6vqWbJJ3h7igGcxBWQJAEbdYJwJSyV1vpAc1N1unyrXI5wD9y1fS/OCg8+SzlsQHx4xl5OFdyxuNDAa6gDtss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RKFedAqy; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d149IThZzwbWyfsVrNTI+/KbJ1mJ+Qe8F15xj+pMYOpft7mWyKrG4qvRWMdraf4CE7A6Z3EooLENsEc6lERwNFVWtwZoi+kt1S2oX9f6AD7iDHip7UvDoVX2DoLBZ9QjJzAtaktSIi9ux6eJZ9Q7bEUh6vXv3pyx7SH+90J38bbkxRR/x0D1SDwKfKi78SYzcaKeelzhqsNWdij4dLZ1YhZ1n2gSlkiGvKBBKZEtTHc7x9vIBQ40fAo0YDQbyiOMBNlD5pPaeC1I4658fQrF39ixlqNni9OnlUuo1F7PWRTP+TAOYxguCLYdcTCMpFV/rFCCBVJo3avZpHvVGpbqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL3WvbMvdqZ256RnFMXh8vg6/l6QuV1mEh3+REdoo/I=;
 b=gTGjhHCSMNJqd77HvK6aVFqWlIt20CJfuhR7WMyxPaeaxEeyTWJzgFMVlnN1pCqizHtV6qZYZA0dDpXv6bJlZgxDllKFvHo0HgTrdbRUYIQNSIDp9vk7g9PobpNmOQnbgYTnZE/BrO0kMq6A3JHUl+4WFwTnKyOJRQiBUASCh8G1lp6UGcNUgkvLZqLJwiknwrQjE2EvwSMGTh2YvzC5pqyss0BI5dHT2xZD/vyHV3GjvuF5l9I398M0+C4ukUxrw2QF5ik8e4cLl6HmuWbUE6NcJ5sH6z/D3btNl7/ZYBNAzytcyxth7zqdw4P2Tl2SOTs+llUMeyQEArjJ7xVKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=fiberby.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL3WvbMvdqZ256RnFMXh8vg6/l6QuV1mEh3+REdoo/I=;
 b=RKFedAqyb+PQBl3NNX4VHBdtXW4ggbWi0ft8PX3DXO2ykmHlv/LM9L/yu1pHUQw6sE4pjdFHS1DFbKzlftxW8hOvoc/lU2gmxBkYUskGsn21mCT4q9ylIuyPPIk8bw1yy1o/PREYwhneLI5k4I2OhFJjZgkyeqIY8vZFG9iGqq7J8syTuL+zJe4YmYLDGScHd/iOopoNgYdKyEoiVrfIK8wmlc7bhwgXSf2xakLO2wOzxwAVfrZtW+Whi47e2AeVL1mMjRch7jy2H1ImwoxPnSdtG2Vh+Y8eFuLpjS3c95YtCdAOm6o8X1tgEFTP36qkqR9r61AlfH0JfVh3gNTiPQ==
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 08:46:57 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::ef) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29 via Frontend
 Transport; Fri, 16 Feb 2024 08:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 08:46:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 00:46:48 -0800
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 16 Feb
 2024 00:46:46 -0800
References: <20240215160458.1727237-1-ast@fiberby.net>
 <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
User-agent: mu4e 1.10.5; emacs 29.1.90
From: Vlad Buslov <vladbu@nvidia.com>
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
CC: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
	<ast@fiberby.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llu@fiberby.dk>
Subject: Re: [PATCH net-next 0/3] make skip_sw actually skip software
Date: Fri, 16 Feb 2024 10:44:36 +0200
In-Reply-To: <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
Message-ID: <875xyodcek.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4992f8-f687-4e25-3d01-08dc2ecbd519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a9y+0oX9x0/TS/hLX68bcR5oiyBUxIl/9kSiEvaRUNEnOvwV5cx9JtbnSCezvM1tc/FnejanBYAH+p4sM9nUzKbkgJXQs8wTv3VffHXsTZz0yGFt3BbWtVshQ92PJsVe40k1nqaAA0QDuN7vTv8DTq9D6PzGi4Yem0mNOZurdY0EzXW9l0ebCHXaspjI0Gs/fZTqQmJpTM0JDkbx9G99kx8fFDoi3QFO8qi9BbCMrUinmN6rhNJbEhbFioibwAEF4Kuw2PdFjlFaGmGIMFBq5lpf6IaSWsNN6ygk/ZSQ2Kn2LkvVUoqFdSj8jtGq9wL2jQ/z6YM3M+wKEC9iKEueebeU4tagQ4hGgc8nZflVgD1a9yRAuhQ8wSrZ20rR68ofvNtLgGtLKeKAzQSdWuEq7IGKSodzBd94qHAlInUs+EplIlitxAGyIN+yAqN+88xAfr5+gKuJzGi5jhLp70l6LZIE1FrcvY9DkGDVh98o6Ac422SkJyp0HmMMHPhqYuaKtzHH2IOQiBetqq6E3G32wWj8ZOTKXMmqtP00NIcUUV5rcVeCcBT+gPBKcuGJa4KlUCdKr9uBIMVBjerUSMNG2rp7T0BtB1ry4r0Qht+oiIAFziKy91rsIE2EYUjKiuCn3b423h010ZNKQaMJj55NOOlkY+CU7V5SljjFQ0bffVM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(36860700004)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(6666004)(478600001)(41300700001)(2906002)(5660300002)(4326008)(8936002)(8676002)(7696005)(70586007)(70206006)(6916009)(2616005)(54906003)(316002)(336012)(426003)(83380400001)(356005)(86362001)(82740400003)(7636003)(16526019)(36756003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:46:56.6488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4992f8-f687-4e25-3d01-08dc2ecbd519
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089


On Thu 15 Feb 2024 at 10:00, Marcelo Ricardo Leitner <mleitner@redhat.com> =
wrote:
> Hi,
>
> On Thu, Feb 15, 2024 at 04:04:41PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnese=
n wrote:
> ...
>> Since we use TC flower offload for the hottest
>> prefixes, and leave the long tail to Linux / the CPU.
>> we therefore need both the hardware and software
>> datapath to perform well.
>>
>> I found that skip_sw rules, are quite expensive
>> in the kernel datapath, sice they must be evaluated
>> and matched upon, before the kernel checks the
>> skip_sw flag.
>>
>> This patchset optimizes the case where all rules
>> are skip_sw.
>
> The talk is interesting. Yet, I don't get how it is set up.
> How do you use a dedicated block for skip_sw, and then have a
> catch-all on sw again please?
>
> I'm missing which traffic is being matched against the sw datapath. In
> theory, you have all the heavy duty filters offloaded, so the sw
> datapath should be seeing only a few packets, right?

Yeah, I also didn't get the idea here. The cited paragraphs seem to
contradict each other.


