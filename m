Return-Path: <linux-kernel+bounces-84172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C6F86A355
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB42629252C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710056449;
	Tue, 27 Feb 2024 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ipFSvdVR"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2138.outbound.protection.outlook.com [40.107.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8D55C32;
	Tue, 27 Feb 2024 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075307; cv=fail; b=NfIwEofJh/5l8CXUDtx6DR3/rySUrjiqgvMBWp1ihxtKukQNZRcQkNWf1MYl8egWbz7c6AUfTTUdWYetSRXL/ZM5tXRYKMG9cYOflAyBDg7xzt9QhwuUQ9de/hR4plOUJfZ8cDURKtlv4pwGszoQUpa9USls/IGdwR6Bu22rhlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075307; c=relaxed/simple;
	bh=9c9yf9ZHJefwwJ7UoP7kygg9rUK3MEOxj7l1zVpiJug=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=L52O4FE4MPHQeygVdcJS9KNGfSMQOgUPAHmbBps5tEUo0B7doCkRPnCQKmf158ANeTwTkd7hxA9q/X/ZbBc7dvdO831xGhalp5hF3Y6XnAZwVBWluyvtZgmu3gU0+ALjO8oobdAhXi+rvlKJZo77FdccvYjRygi7bhwFYcgQ5eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ipFSvdVR; arc=fail smtp.client-ip=40.107.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTTcvAyn+nrzc7GXW9rzvsKNegVOztzAnK7agDaxVj1jnChBm0teEAV/wUHfioMVkGnoE4x2pI3JlCF58QrH3O6XIJur+b+as2lOBC1jpyg8q/txTf2gIgg9zjQhe51Tg19N10/4mc5oI2SrPjLE7R+Ec6Pdr6b4mCZ5oJckIWpEqRn/BRJ82LJlK/czHgZHqLU8J+gFQnbhXyeoq44d7EVggsgD3oHPdsdcU0mhcOv9r1OdmxFLDU5pGEfKLtuM9dS8m37fGV6aJxm5Z216xosPB3pRubvoK8dHbr6YtulGL/ZGOkf9wRikzf93YoUKczycxhQyTTkdqiTLWk89WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZF3KivCJnnPIEnGZwbRcq/ueQ2nMArP1ef/QpDpLaQ=;
 b=mA4LCodq1XE9up0RX/b7FHn2vxX7/KkrjqrGiSchv6zBuunoCrJp+eI7vz/pF5dzn5wWy1tttoCMtkVvAExFSbgL7Y1jU5rbzvynNJXDJFFwAeJEtdGRbf4q5lctOntmMwTRHSPd5GyHHlenkEr+NaWiDm9scZVZSiaS7QyFggGk8BEMPH1KQeCwMJSMSIZDRyIDuQZAchqGCwhdv83XItJCPoOKE7v6AUSA1eAl/qRHI6QuKQbzEmeW4eZqg8tJGK6tiQdunFjyRBC6t/oHB3qHWybkE7M3lRlPXheGUqObtwHSuEA7/392l5zQN3eKMY5a7iVcKNG/lHYPPAlDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZF3KivCJnnPIEnGZwbRcq/ueQ2nMArP1ef/QpDpLaQ=;
 b=ipFSvdVR0/TDpGp38lUhyANSh+3wARyrvM9jAf8ZuxN4GW0MoqynlTijP0YvkrZifk8dTlEBWRpSXSLJMzuul4TU/id73LBJ5aacVdgWOSN8ObOmjmn5l9R8Cbus3lhKVF/0ysxCJlF0cPTDyJXo8IsJidOY2uEWdzT3j4kpEVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 BN0PR01MB7055.prod.exchangelabs.com (2603:10b6:408:16a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 23:08:23 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b%6]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 23:08:23 +0000
Date: Tue, 27 Feb 2024 15:08:18 -0800 (PST)
From: "Lameter, Christopher" <cl@os.amperecomputing.com>
To: Eric Dumazet <edumazet@google.com>
cc: Adam Li <adamli@os.amperecomputing.com>, corbet@lwn.net, 
    davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    willemb@google.com, yangtiezhu@loongson.cn, atenart@kernel.org, 
    kuniyu@amazon.com, wuyun.abel@bytedance.com, leitao@debian.org, 
    alexander@mihalicyn.com, dhowells@redhat.com, paulmck@kernel.org, 
    joel.granados@gmail.com, urezki@gmail.com, joel@joelfernandes.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    netdev@vger.kernel.org, patches@amperecomputing.com, 
    shijie@os.amperecomputing.com
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
In-Reply-To: <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
Message-ID: <bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
References: <20240226022452.20558-1-adamli@os.amperecomputing.com> <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:610:e7::7) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|BN0PR01MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7db4bb-a809-4f09-bb39-08dc37e8fee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wqYk5l5CfTLvKanlRGijLrGhqamh/MVXkT+ImY2wGo0698k/MN1EH5xpd7x+rQonkB5MXofbtJ6sfLND+iqXcv3hnO/uQypyEQ7/2Tn1A1NYOFKPwnU489rtm1j7Sc0o0Dl26GQt/lYjsAYMKCx4EDgbBvvuFcdqZ+M2P16nhW/1iVJ8CjWgw+kUPTCOvKr1FQe2N/0mODS7wSJQU0QaqRALq2MY+OO5mbffc3FzUKQa+sJZU5lOI9F6EH1P8Cu2t0Kz50QlUXUZcA5N0RkDJlI4TiGcx9bcLoIjxPibmtJhpqSboUElGTdwFGCe1N+dYkndTWA4iGPalREfPOql0DhEjZ2adoXGhP9XLxo86CXvjGESjc+CafyXM4SpjMVRTVFB+awWs5yhCFu45RxMgr0KMjbwIOX6oeIdror6h1Aj8xq+nTy7J051xH20EJ25dITCRUHqJjc/m8fRTrtB1qYyNF1LcTGpBrHACHdDWH46rEockw4njQZgcPyVS3Zbdzf7gYSHK9lIOLk0STcS1YOPBV4B+zeYdDHVggwpkr/jOWyKgh89l88avIcbIeIGfUNW4cFBRJ5P4h8xuc41ymSpMSjSzWozxucagLRo46an382wPCHiYTwa2eYG0jpJRXTR16T1NMTEDilZTNMClg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3i2Dm7L643C1KQI8fyXWQa5M4slZMgVPVQVbpQFKmpSYAhgiJYBNCqpYR14?=
 =?us-ascii?Q?sBvPjIPV2kPBU/xmG6z+RgRmP+eXlVb/q1Lm7UMvQplwPDysOsJmip//RgMA?=
 =?us-ascii?Q?ZiIjJoo7XUdw2S/MjUS717XBsRLQYfqEyCaJdxD5H9ic+dGPxGB4q34rXIzI?=
 =?us-ascii?Q?4OsgYccfpwrvXTrK1z8G/bfgeIrKfOJIMN1QRUP8mLXzxZ93emj4ifR/Tgyx?=
 =?us-ascii?Q?519L7a3Saxy6bHReWcl9OpzavR/KbOC1aDgl8XJ2xalVs8z7nKhiWlHl+RJP?=
 =?us-ascii?Q?ulzkcLeL8Xbk8mR6hHlyDQucleXlPT7nRR8E1w4cueh8CnfG6sSN/P4bFONq?=
 =?us-ascii?Q?Z0KPcKMznJiUnwkVo22CbkNjm48L5PePVebPRaugKdcHyX0GfkyQEvwneAat?=
 =?us-ascii?Q?m2iQPHvX/p5dI+dxmwFeYIswMjYt/9QAN4GAHKlkOpnTdvUQ7BUsuEJxBhwU?=
 =?us-ascii?Q?bcPBqJXflP900ZPfT+VIXjwOrGNsqln7F1CiU5//hPyjZ+Zq2siQidiibzoQ?=
 =?us-ascii?Q?VLPUdIhPUX8U0jf8ly4fpXtyu6LlHmk/Y4dxosYbTlJN6Qusi275+v/b0wF7?=
 =?us-ascii?Q?i16BMdwDIkXnLAMki2QMK5k2lFTyRBl5vFV8q0g+DG4HQMVwhJi0QdcuS/0P?=
 =?us-ascii?Q?RfZbUN34OpsPw5TEY1x/86pR0RJgYLEZtfoN3dFcbTtMeDvu90Yau+2/hQEn?=
 =?us-ascii?Q?k4s4578AlqDgjGbXgnLT3jk5hTaA1zFkMcrBswzPL5mOLSxdt7WdhbAoR4Jh?=
 =?us-ascii?Q?3T5F1+/rwA1ClDUz11uj+i3LX1reUu+1c7wwuWteF0BZhUX9UTkOJQHpUf0/?=
 =?us-ascii?Q?ELNZi9fCL+XBNJ8H8LEdZTWFDMZxv0T+QlxoVA6j5S/gGnvQm+BNedTFCV+o?=
 =?us-ascii?Q?wxcXDrO5tiSaEwU/FGaE5K7POTg/MdZqCewUGjgfZ7tywY0ninJjJS2Hncsq?=
 =?us-ascii?Q?IDxwyGrrUoibIw/upAMNptQX6jIHfTY5IcrRZolMdsOo2c1caU3VthbSGg2H?=
 =?us-ascii?Q?27BF+ElksdguGznJNiyJ95l5eE2QgTRGJs0raVTJtMQo4m6jSzSPDHFvC3Hq?=
 =?us-ascii?Q?VSJuDFaVfB5Snp5q2z3XUlwzNmaaycO5CclPuQ75XlWfDsozLriTi2pnf/1a?=
 =?us-ascii?Q?HDBhn3+LYV4eI/tJoefdDf9Y22YE2len3y5DyUtmCSk4fpkI3Z7tOZE6Vf6e?=
 =?us-ascii?Q?TcHt3iRB8QcFHS4C23u4YrId98KSzDtzSD5V32UmAV25EttjRPTTLI1BvpZF?=
 =?us-ascii?Q?acyBnEPR46BHwKm8LEg0EP+NM+orn86Q4iA+OF3iYjyGOGjjvrG5/ezCOaCe?=
 =?us-ascii?Q?Ddakbua8b7F/oujMKStah9gdfdbxCwGjHPALuT3z6lkiHMs/alkppDu5iR1p?=
 =?us-ascii?Q?cIKaIDpz1B23izCdKGJ22EG9x0sg2pj02CiAD2pSCpRqUxWXd8nW29AG4lzz?=
 =?us-ascii?Q?lLUpWQqGpY2lMgikIj2tdyLstEbTPsH3kFvlK9R78Ym+bjjSEbvLPGQddYG9?=
 =?us-ascii?Q?FEwOMv9gewtyGW0TgvGasPldRQ4xEuRrlKXfUe1GgjUdUZUefTV0iB1KngAM?=
 =?us-ascii?Q?wuvepnmEoqYffd/Ka+lLnLRR0Gu4ePsFw73yJnzPB80ne2tURpgI8u+alpo9?=
 =?us-ascii?Q?H39eAcQhTfjDhYK6WX2F+q4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7db4bb-a809-4f09-bb39-08dc37e8fee6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:08:23.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFpIYIB689enl5yb5bWF9Vi9hRkjIo67eIyJalhXa/VjZSQ7oR/HyUvZfKrfUi4s47lhZt3v0lKg4QXmgiXhMzTAf7WaJV2II1LBH112GMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7055

On Tue, 27 Feb 2024, Eric Dumazet wrote:

>> sk_prot->memory_allocated points to global atomic variable:
>> atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
>>
>> If increasing the per-cpu cache size from 1MB to e.g. 16MB,
>> changes to sk->sk_prot->memory_allocated can be further reduced.
>> Performance may be improved on system with many cores.
>
> This looks good, do you have any performance numbers to share ?
>
> On a host with 384 threads, 384*16 ->  6 GB of memory.

Those things also come with corresponding memories of a couple of TB...

> With this kind of use, we might need a shrinker...

Yes. No point of keeping the buffers around if the core stops doing 
networking. But to be done at times when there is no contention please. 
Isnt there something like a timeout for skbs in the network stack already?




