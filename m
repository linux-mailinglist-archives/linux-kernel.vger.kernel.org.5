Return-Path: <linux-kernel+bounces-81855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5A867B00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95881C29CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4112C548;
	Mon, 26 Feb 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MReaSjWx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2135.outbound.protection.outlook.com [40.107.244.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4812A14A;
	Mon, 26 Feb 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963278; cv=fail; b=gpuUad97IDWu6bALbwEpjGj2Ff11vrwXa7Zb2NIyvGZo9Yi+pigMZdfpXfBCj7ILSjyu64pkRS+XERCmlLB1ozFntISihpmXIrUt3xuQS7OCr7TqM7juT/y8ZBz5h5SAFTD0t0sQLp+yMOXCKmPC13xY6GnwVbtw9r1+25e7qOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963278; c=relaxed/simple;
	bh=71B22+rEAxX1H9i+OstDbl6NCr/6yM6TlAbnFiP92RY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=TJpI6SMPYy00kvD5GDiletGyGdS3qxdK7E7j8b1oBta5iczXZq85VJw1ZS2KlPPgCbS3tnHLVVYJ56UUeqsIeWYYvBDMsy22uskan8kdMXWHqfCtb0onseZLIm2jdfNmsibi0gtFCpeXoaFphaVm7rpswiFsuSp1HlEPJY60sok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MReaSjWx; arc=fail smtp.client-ip=40.107.244.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHGrTL8VY+5aMd8NtDwSnIE6BS69mbGEyQjOur7pj89DsPnUyaJI5Lb6G3XHebrjuYIgs1bgEzmTkU2bOv+Hw5u7lTaXkc1EQbrFiU06gkLIhdgGgeb1VggN/PDmVFOwdmMZcqrwJ3xV9Kjz2hlj0XK76Z/86gSl0DjJN/Kd0z4Ld9ZbhQ21HRsPdb+ljU0zTsqzp5BMfsd/ixskmQweU8ADr7nmdzjqQEfMRg3IgvLkB64sLEjYhygbRL/0KJXYAnhmNw3kUAI1EF+PHvzRwXbT61GV6OcYT4petl2KGifeHjiS1bw/4HO4tBMkVMh6gfPtg7og6BQgzWGJrp4GzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7GRPK4KsCB/ioqyVihrkJpiLgQATajaF2TgHlXGSZk=;
 b=P0xH+EUh4Mt6XGs8U/if0Z0yWgcmoBYyxoBY2hsPYnIv1GW/nQjRXGbwnhjdCSAOiqf6+ZXYLW48IxNLs+aSLWRCIe5h9KiBGAXznW7gMl4rBeAizoF8gbG0HlcRY43xYp2PdvuE5IXHBLMoeK3lAwZDWf5FMwRNIWU1Wvj2WwZKEegWgV9HCB3C2w+f0mYySyTWx4mlHBGQwQU12tHkulvb0hUoiAMXtZyDmg4LDS9/lovgm4nZSEFmCK9PFvkkjZX9rMX2Aeu02tMzmiKbCQUUVD1mWdgp1JLnX++LURJA33CwN4G0sl5Ww1BooTUJ7boBFfxHZLzHVEHxbBK6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7GRPK4KsCB/ioqyVihrkJpiLgQATajaF2TgHlXGSZk=;
 b=MReaSjWxsLtQgEkDfS3Zq+ur20EHufDVTgb8SjS0mL9bkF5TcmRsNDTKZyzyIk8wNaKJH4QvzGO4rr4emIKjacmklewLIund4Mx3LijIM4zDQzhZTOKLnW1ItxAymVxarNhT3QSg3YhEkdYTDqwxUUOPgGaM60fBRThfJMLW6A8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 MN0PR01MB7612.prod.exchangelabs.com (2603:10b6:208:377::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Mon, 26 Feb 2024 16:01:08 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b%6]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 16:01:08 +0000
Date: Mon, 26 Feb 2024 08:01:03 -0800 (PST)
From: "Lameter, Christopher" <cl@os.amperecomputing.com>
To: Adam Li <adamli@os.amperecomputing.com>
cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, willemb@google.com, yangtiezhu@loongson.cn, 
    atenart@kernel.org, kuniyu@amazon.com, wuyun.abel@bytedance.com, 
    leitao@debian.org, alexander@mihalicyn.com, dhowells@redhat.com, 
    paulmck@kernel.org, joel.granados@gmail.com, urezki@gmail.com, 
    joel@joelfernandes.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    patches@amperecomputing.com, shijie@os.amperecomputing.com
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
In-Reply-To: <20240226022452.20558-1-adamli@os.amperecomputing.com>
Message-ID: <3f6e41b4-e385-e045-f95b-266fc80e0904@os.amperecomputing.com>
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:610:38::44) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|MN0PR01MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: fba416a9-2837-4430-64ee-08dc36e424d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	424hC0BrwCejOwMfbDqGTgpiL0wK0tn5rZf0IJODWdn5lymhoTRkCLsxFKlDGSEhfEajAj2RoGB/3D9iR+fGI8hk+5pr0JxFCOEP8L/VfrVXJ9UtPpEruHO6Ep28Wv6AwcqWUwbFJ8+h40By8p/fugn2H5HCYnHcGtfrYSts/5MlWSBaRCMy3IHNEnd8anKPq7MP1duXt0rOctY+PF6bPmReXo+jsognFDSLFL3ptC2XAvoXQyB2ihLmlp7tIjHr1kmX1dm4XUTfWdFdEaVuSkesQh+j3Nd4PrKY3hkU/tpJiPXL/T+7Dve2lJldnxNDSru0uVofnBvfkOhKnvO7bRknFzheKIUhnFNUsrU6Q/mAP/X64Pe6MVlIJIPnVQ5ln4L/q2P5oZXDVwM0KA6rf9wBcNJQa6WNXN+zx8TaNQQgoO31S95D+lXuUMgfQXfM1SkUF6UJLpZ6JQVB9mFb4Tr+bW1RLyzobXJA+iahn//lgx5JrZQyzDmExLCGskDZmXnFEM3W14e5vjYpvm50ROS5IKxdjZwl9mHp9nKtoAIuTlTi20HqfIfLDyXn1sTT2TDaSunLh26xO+nkgGLK8e/kxYHD4izqy/e7sPdYNdr8QdUlYBCVXgOU09sC/rHtlUmCJgYtkumHV/PM8QFq8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VD/qSkiYuI+5vrVA51YTPzyYD2DCDlunoD3VN4ZafH45Y53wqEe3G22GsVC/?=
 =?us-ascii?Q?mkr9sfw4OPDzT+opeOAOXNPQC6YY7fZ2HQgi/Lp7/UWt6Y64wx2hLW+EEQqX?=
 =?us-ascii?Q?rW4DKHWDMQQ1O2AsDtUTUsAX3uG7TLlLkqVLturWiAafPA8lm/lt9hoQRA++?=
 =?us-ascii?Q?FrujThivWCpq82bUYMeXgKxwDSXKqLNM9eYgXAlYc9BpVhZgZqxPiGCRp4Sp?=
 =?us-ascii?Q?Y1LRNjv8scUPOq9bsIHv4qjn8kiYgpoYgA10rYXY/rijL7QoYySZg1saswZv?=
 =?us-ascii?Q?h/ckChYDd93PXBe1U03Ar0wplNnX27CWoSIv2VV2AECKGupkm54mTj7TBlMB?=
 =?us-ascii?Q?N+mV7q0DZMJ2Gt687XaD4S2lZtTM/4zhOCxAnYEHiHrdBMg9/qMS7zcAmEUL?=
 =?us-ascii?Q?8nrC0TiOmhIdCw6I7+riJojk39J2OFMzkjDpNsBNhdBmmAxk7J2vMyl9VBcg?=
 =?us-ascii?Q?bK7s++cBI0sdq3q1y3izDMfkNH/tu8Ua+Avza4gnYg4D2qs1zJoICaqbJame?=
 =?us-ascii?Q?mupRWm2M8hXMGU60SELVctOQnDs8BmRz77CGGhoEZSHhmkKVcAevA9K0GEl7?=
 =?us-ascii?Q?XIeCU/mF7LyOCrpUgPaEHWbp8cvHVZvNoTBJSak0v0TZhirrHd4SV3pikl+z?=
 =?us-ascii?Q?AzKK29lCp6YEocIgpyUN/+wAP7uXGUb1Hybq5gBi2ohQY9dMRSrhZ5Uo7AWO?=
 =?us-ascii?Q?4sJ0FpVqV8G02H1XpI2rqBnGZObLJdVM/e13ToVSh42TTzKIm3/R5ent2Vb4?=
 =?us-ascii?Q?Wt/N9yKTgyH0cO4PXUH6PjU0uC77W6NXOrIMCu1fQ7YwF0IJdgPgeltJrQtc?=
 =?us-ascii?Q?GJmK1p0N29WnajIrVIcaT/NH5RJ5uk0e9SKJU+ZOT7xZg+7eYpJah/bB0WS5?=
 =?us-ascii?Q?GUlr6YcbwLQ92lrC9y8JVZdAH+a6DzXhpDUftjLH6ZYD+GBPxTm2LftPq9SM?=
 =?us-ascii?Q?9b7eA3UGcsKEa5b+EsMpnWyb1iId92pQ1znOMmH7bisjsIvKv3Ow5WA+Qavq?=
 =?us-ascii?Q?0FtMuu0lmEYCOc0/+F7XTRzxosXlzAfhT2IaCc3FOyx+meeWXmrdJeFT1Og3?=
 =?us-ascii?Q?A46WLklLbq2Up9wnznlGJcZGGGuFP4Z01/H3ciMlG5m+Ki2QufiSbhUlNi8q?=
 =?us-ascii?Q?tqKeUVR/ZJX6KRI44/tObagcFwwEpamFo1gUcYOoc+fRTMGxqKlSJgGG5o7z?=
 =?us-ascii?Q?A0FTgwB8vJytoy8f0blremxF/xDEzoGPs6db81EXXPxXbZrl0Oyq54/qrbUw?=
 =?us-ascii?Q?7HMdjXC3iCMB6zY+mQEROWsDhpkhRmBqfnbz1Hz14Dk2rWZBNl9ibsEk3YhG?=
 =?us-ascii?Q?2AaUiXAAILVWHkp3gxL/UYA49D9f+PP8+lQMt28qNzTgBp8r2m0S0IkxqXle?=
 =?us-ascii?Q?PiuXH9cEPWSAaNxtfbTCU4wmBw2EP9TGHJWxY5uQDJV6YjvK5lXMiNWHG/vb?=
 =?us-ascii?Q?E74YTJGZncXGlApLoDO75VN3CUdsJpyMFRQng+FWI8ynZMg+enyacsjLWJsK?=
 =?us-ascii?Q?eFeX3SZTxmLvZmSocO3OCBpJyFkgDJYpoMsh4ChAJssm7AgHfdjbmvuPJFnV?=
 =?us-ascii?Q?lOSBvp/c1LWvxpDzQSDjX4NJDnoERPC2iia1RyKOJVyvGUBXtMK4dkLhtITQ?=
 =?us-ascii?Q?u+av0xxUArwEU6SwJ3eteNo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba416a9-2837-4430-64ee-08dc36e424d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:01:08.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e5aYo/YVN5lWQG2oiRjuk7/YqVvW0iT5yCSkMG/4bvp0HHXunj6miTR7mDs4k2j6iADzRDN8vx0DvC2hmcl+2rerzbxKoLunOJa3laRvtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7612

Looks good to me. What may be done in an additional patch is to set the 
tunable automatically higher on machines with high core counts.

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>


