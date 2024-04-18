Return-Path: <linux-kernel+bounces-150137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0938A9AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4311C20EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8415B157;
	Thu, 18 Apr 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOV+4dQW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC21DFCF;
	Thu, 18 Apr 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445816; cv=fail; b=K+bUz7YbLthfMt7qTsZTl6JHEDq8+9eNCQ7AhqQpdc+3cDgyOIn1Fl9W5gZ+qInNk6YJVyVHFFUGWLnEW/WNsy/AFMvkMizOUuylAFuJfvtaOwVwsDgTO7c3lzbnSdPsgzeHBR0xPDOJxMOSrGqkrDt4Vyjvm8J2MtYnRdLwNYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445816; c=relaxed/simple;
	bh=5pGUrpsICmQLTPWIM8Or6o4cyW3gYlpGBCIU5JKWTF4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FQrLQYZqwx7y8ly+LGeq1XtxGWOdWLCkh0dA3Niq5doNyuaOSkrdNJQzw35CNH2koB03ZGNq/jdyE5EcKP0gFLqd2CiiP16T+8p3MOp38hieMvaLFjw08DcmQ1MimYS1XmziXSvxQXGtrdOxRSwsco5bVi39RXWr3xMgBPCSntY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOV+4dQW; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyFxCPKbcx5VbdZsFm9z+DHrCfEMCl2twocLEArwbE3XhlCKfASUdEgF0q0YbZ942SeSLn+zVrPuXjsIn6A4+QJTKhP2tdgRlJyeCaTDVGmgKiS3JDsLwpXYKajNK30XA2CECyoCbSuKIHHI+sU+/H2weZVX+YaaU0L8B0yi6TduLqxAam8gaekaIAykyN5mQ5NNpBp5vrHxuaXqkl1L9Qu630SX0zhSYi8juU04AE6dMsdCn16kOlznb9BI5F7V0NCiSYmrq4Zcj2GrlpBYrVSQcUIccOtyXoCFAkDr5HrYiPbfup66DFmUSWCu4EUgfGs6oU3uvOpxJmUfeThB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pGUrpsICmQLTPWIM8Or6o4cyW3gYlpGBCIU5JKWTF4=;
 b=KBZC83/R5Ni/iUGLCQZSkpug4iyXOtsHkM/3QzIeEfWcdrAWamkMie6QL52P6QCOmcozdIxeOlhUljM/nO50FKrDOZb1lPHsuJKnMcg82Rl+hRfh+kZim6PJIpvH9p+iwrXjI5uT8XdjO0Kgo88ZCpcAtfWfF+mmD0gAyhT+f3uU/Uo8AlHOaiWNlJk0VEwCMjvfvfzRjXm1G1QHyNSDNt/VqyIVAl3KTSDP00XZr34rnE3c4+HuimaNWs6vvm76l6GcOqFBgHHxs2/xLE1PtQbkENtYDxordTvIDzEc92Joxfo0RxI4xztny0joQ7eD5lDjDM1hXhSOc2Ctv3gERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pGUrpsICmQLTPWIM8Or6o4cyW3gYlpGBCIU5JKWTF4=;
 b=FOV+4dQWbfC+o4CFO8dbEeDHmY4aix1crWBlxB6n+/Ddk75YdvInEQqMFdh8TxwRNftTexCkdQN+NKowIcyZyG8dTqNbJCbtOBxSBr+lAKkr5MfzzeJRF9jQCNxYlNUpe/I6oyAyGXIyKqleo4SzSjKQ6NFjLxAzp1V/lNqeOVlrdv6cNAu5BlOn4AXExTU6uJvcjUaI2zJ6H4tfQRiIl0KnTU7gpj4OtYR/viAwK/f4BquHA6f64m9wZWMGwf56fiekzHtHt/Hxk2Ena0bwjy6xurY5jxss+rmMgsCdkNGJJyC9mNdl73ZAT+QAuPTqUwD3PmoTUfHrPYdSmHk7LQ==
Received: from SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 13:10:08 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d9) by SJ0PR03CA0388.outlook.office365.com
 (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Thu, 18 Apr 2024 13:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:10:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:09:56 -0700
Received: from yaviefel (10.126.230.35) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 06:09:52 -0700
References: <20240417135131.99921-1-ast@fiberby.net>
 <87o7a8c76m.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
	<ast@fiberby.net>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: validate control flags
Date: Thu, 18 Apr 2024 14:58:50 +0200
In-Reply-To: <87o7a8c76m.fsf@nvidia.com>
Message-ID: <87plumbyw3.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 drhqmail201.nvidia.com (10.126.190.180)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8636c8-6f5b-40c0-cd94-08dc5fa8df43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kgDJ5myEj+l+BoBT8Nojq76EQCWUmYmDWV1zY/8akLQ9L2MLg0uFfRmnOQ/Gj1vZpQd2fO7mo7tjDjKV1BiMIoMNS5bt82cDOT6Jv72wWo7IUo4/UdHEPrnjvewnk/ISAZrwY5T+hAXuBJyefAZUg1DIjBahaa++sbTZo/OicsUshVHBG2PsO7IdNa0Ot31vvMR2Ar9pvYCHDEO+PtdeJfbJz9+tSbSX1xVyDqCNiTTl3xmPw4nIjsBpEu8+h0pmmwM0ySpEGnakwTDVPp71ONdT88Hygx5ntV65iWYt+5HeghqmnZBL9DPjMbtegSDpfkFh/YbnG0gwVyGsUs2u1sL/IuQKOhLkwqCmmi0Dh02L1nM82S2q+UB5beVIT9F/e72/tdyiv/JaS63UBK+kB15oV+7jvGOWYCU3ToXmocWG5SuKKBq+g9s7Z32NxOnxQKYfloFq88tpGiLq99CQM5rlSsNQn+a8M8f5aQAIFHErSyAxNfLlQAcgjxcATmkV1HK3QTT9IjVidGBvEoEHaAz6JOKY/WIdOR86hlsWapev1fczhbqZDKlgAth47GSEvi4oNp7udG/YLnj4dx3x9Z7SOyhFbR0BuOJ/fwOGGldkgFSRdhoE9ZwEO2jcV2f7KQX1XHgypNZ0WIMkGKPEMrZkytpV+O23RTbBW78mMEOFW90dt9nDFoeiNnmcbRC6UW8p1f/zDPAHZUIXWLqfIy/wrnZFN7f2IAsX/mUul+S3JPmxxsp2aJmRrPnnFrBH
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:10:08.3893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8636c8-6f5b-40c0-cd94-08dc5fa8df43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766


Petr Machata <petrm@nvidia.com> writes:

> Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:
>
>> This driver currently doesn't support any control flags.
>>
>> Use flow_rule_has_control_flags() to check for control flags,
>> such as can be set through `tc flower ... ip_flags frag`.
>>
>> In case any control flags are masked, flow_rule_has_control_flags()
>> sets a NL extended error message, and we return -EOPNOTSUPP.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
>
> Thanks, I'll take this through our regression.

Nothing bombed.

Tested-by: Petr Machata <petrm@nvidia.com>

