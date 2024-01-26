Return-Path: <linux-kernel+bounces-40348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93183DEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93472289CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1741DFC7;
	Fri, 26 Jan 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3AQydYA4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AE1DA3F;
	Fri, 26 Jan 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287043; cv=fail; b=ZyQzDyHaNbxb5eKCcDq3wCbc68KPnTZ+rcw3rSoHqP5fd0hvyWr8Ns4rCh8p2BcyLP6sMjV3Vvq83y/qpDeroZnOSk1eaZeTu6ejXQt7HDicxn1QYjAtZZEHGUdtSJhaeeolNfphNKVOzcYKpDmoJAhb7oJYATKC3pF6M/OWn+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287043; c=relaxed/simple;
	bh=oFpBOJEUBHhnGjHX+xX33ueZQgjsGr5iq4QgUClj7TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kKwqmfBFFGWpHxetDE2IgU0bhr8JCgydYkoYIk/eJXYXRy0fXcp4lGrTD8V3PPfke9YzQWPgUv0KK8tAxZuhC/iv+XAFhQofxiy8hGOwbUxq/WFNKb2nCMdN7WAstDTB7tbMCV7Qf+NFdbP+pgljSkaaESo1Tv/xDhFniANEk9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3AQydYA4; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf1KvrYaMxc/cMjrQPY3EQcCxY3BTb8olcuAzuu0OI4AFWbFwBHpCJU2y52hDNG/Qn2ovoOylSpUpetSDiEite6Hg7cQj2jb9DYtqHy4HZJ+Ej6RFiRXbwRLVjtuyfN3TsIuLSnRiuzhN8UK4rwLMize1BmmN54EUGB5SqQo4IULm9i6uZmW/CQNPYCKd5WAszy2qe0+90/4hozN4centFdoLQAf6S3d7uw8/VjCXtn6ZHavHG3M9RkJ42c4f5V/RcFmipVnEKbeBY6w7pEpc0EMfQ/W7vg/PKAkiu9KEXyc59n63c3OPYbnBVti5i7eygjrvqKSREDl9hQPvtBamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/20VF70OUZFD5MfNxuE3s0smJmOsIEIHtHMF1olZj4U=;
 b=CdA/CepRPJs6IvnUYvs+iKltAyPCmSqPWVXlcMMLAz5kRl4Wza/b+fEn7Rn3J91sPPM+I1mpDqIt7gIAKM1m5Z1Foi465J80Ze4+qT5q7E6UuIHJCsBQTSt7MO0+Nf/ZeeSBTxJlDIRxD0V4ksvkT43LXXdvEVzP/H9gR4ng2K17BIX7MiRyRmIjcxF5GORGfE1NeeBuVN+taksF/qziZNjYlV4iU+3n42OrWE+LRTYDi+H58dIIx26x4843CUCB6PFBrSylhH0VWHk/swNbNsuQYTQ0U48DknWgCYQfQgkDAO/JW+YrVkhno46rRoj5mr5JNDZuGNTWl9QGt663qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/20VF70OUZFD5MfNxuE3s0smJmOsIEIHtHMF1olZj4U=;
 b=3AQydYA4jeeTq3lErGykexqRtA9ck6GC/oprMydgIhEQ1rkWTU3CCapMjkQ4sgqsHbyuOGYdXfsk3ukjV+MeimPWbcgVXjdt4QDIyhxoZUFgHJ4VsJX5kymmERzM0Zelbjd7eQqnR/mCFucY1dH9dD0mhx/i3KAVbxqzEMBG2OU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 16:37:05 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::6f6f:2684:c96e:7638]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::6f6f:2684:c96e:7638%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 16:37:05 +0000
Date: Fri, 26 Jan 2024 10:36:49 -0600
From: John Allen <john.allen@amd.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] crypto: ccp - Fix null pointer dereference in
 __sev_platform_shutdown_locked
Message-ID: <ZbPfof+82d5gouOr@AUS-L1-JOHALLEN.amd.com>
References: <20240125231253.3122579-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125231253.3122579-1-kim.phillips@amd.com>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|BL1PR12MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 636f48a4-f58a-464b-db81-08dc1e8d0821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yi6ufmQtQGYooMOHmZJuK4vniuf390/cCKdz/houCctioGmJqKxq5OUY/t9STwxHu/5np3YAnRG28ZGqAnaWgQ3qibT5T0ZyTOWVDeursT/KIYlm/0f7AeAYl9ipieJhienOU0l6XUDUuuVSRi8L/yGpT4Q/RMdOtGr4WU04mXF29R7uyCV7XpZ4o5xZ7WaHmmLYEILq5ifYEvNvRvZej8lrzwUKWn9wGin1sscHE5AJojtUnFxZFQ9IajXYXKRvI1/b+iwZnUzvyCSC6bWzMeZ9+q5PmbHKPcn6YMmXbuyaYePmy2tkj84qv9cG52PmbPpw8E8Lj9WDnbVMja7pC/WcEjlg6ikwQqyu7RlbW4lEjPBILKypYKfTSTTOkT0xypVdoq+rtqcgoSxFbRwsP8KWK4MTe/yCQzIVHV4uuIIApd36FHhR+2Hhqas6Hj7o/6e+kZI+YNMfqu6Aou1dXstTmCjdYu2/m54dwknfMTgRCoWl6jNzSVyPnXCnkXzV1OeWpDkBfKKZRB7EpRAMrHc3TzHBLkpy9b1G0bbi2LPat6UGOlA8UtpgMSialU2d/gGT8wmqQ6FaPigXWCgH4kKieYVO8pdo34MMRGSmi0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(38100700002)(8676002)(6862004)(5660300002)(4326008)(8936002)(44832011)(41300700001)(316002)(6512007)(6486002)(6666004)(2906002)(6506007)(478600001)(66946007)(66476007)(6636002)(54906003)(45080400002)(66556008)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uFq5PULXxm1mdXv7urrSQc2G3sybOaa4TbDwKMara+HiX3ZR/V9wm6maIRi?=
 =?us-ascii?Q?iJOcCdYhNTlpqLCzIpqOXCo+plbB2wzFGkM9nI991L8cT5nrJpzE00sS6R+D?=
 =?us-ascii?Q?lxccgYJNzoKrfX63RLAb4m6+EdoeArxykl7iOr8QsOthTkCUEg4rCaBeIKT3?=
 =?us-ascii?Q?VEKYeuFxVwbvU3eDfJ8ndnNiIax2j52BnBGDy2yhFrK3Qggtc9RDGsOabde2?=
 =?us-ascii?Q?ST5AHaDUGF3x6yWkACJ7sFsAcVSAyxD2sXlwZIAw2evffSYHm0MyuQnpk1to?=
 =?us-ascii?Q?mfw8MgduPbHTvMEIaYjl+n9OzoOoikZFPm8jtDBZml3GzZNbA9f76tzMrRKE?=
 =?us-ascii?Q?glOxpkJDgb6ideZ0nJovwGnvJ8VQWxWxNUZyK5vv8WBBu0IVeiPEGo/smBNd?=
 =?us-ascii?Q?XkCOYGOYqK9Q/bt9jzmAv3SjJK9yAJ/QKAjwZHXJwKv46PlvYNVFFVQK8CyM?=
 =?us-ascii?Q?rEBLhW7nBguTc2OYMIjpl7kMAUxvP/TzCf562t6Qx7qThlCexaPq01KvFbXr?=
 =?us-ascii?Q?p0y+fzOYOHtmtn6RQWGf/d4AXunHBkftcRtlXMpuFXXu863BUxAK0QV4RVsl?=
 =?us-ascii?Q?1gxewzKyBVwPA34kd3sJW5Zh1YgUA3X30ung0zb6d6/12bQ99CF7SDM5O84U?=
 =?us-ascii?Q?miaEip1iySu7LPlHoIsTdBJn2o4oU5oxBNFY0V48opYK1YpVYBRo7fz9+I4U?=
 =?us-ascii?Q?C2HhFzQHSUTMyA6iUN/pAB0nw3iyv/OCBqMMEHErzZGSXX066GYj4GCJv8pR?=
 =?us-ascii?Q?C0nqf45ZV4UgBSpT+iDAwTybGCvvmEaOAc/EL5QhhXtw9HTmx4yMxZXw8/3S?=
 =?us-ascii?Q?sPhXcz2IRCd/gXHu1gZ6VGOh57NQWN5rV/rZ5HGr8Yv+oBpkS4Msk9RbEyG4?=
 =?us-ascii?Q?f0m8i8yAWkRFef8HOuazMqNwKdzgupXHQ/5W8wdB3TH/Wr3tzAoLl68PCeAw?=
 =?us-ascii?Q?HzbYIt/54znZVsm7/09Fl0PnAmPAPp98ktTTehzFUIQX1dJEKRKMojtBx3Ow?=
 =?us-ascii?Q?uzWkyGUIvE5qw3ByW8v5HT/EzyKK6+8s2BFfBmGIHYUzwKm8OFVUMnqeCwKO?=
 =?us-ascii?Q?1KyUhW+0OMjp2egk9Q9xzP4Wtb/h1PKUC+43IIn1uhusx+6JZIbXyZby1C+B?=
 =?us-ascii?Q?mcSgqhMzhcgRblilaEnoQQaw8mqEkQJQSfKgJG7GvNKMHJWdrC/X6Jb0HeUG?=
 =?us-ascii?Q?cSklS5NtU33yA4TVTIUDUJg8IZn0lgOwwp/0clx3ACHkkCUr3Rrq7q/PC5l0?=
 =?us-ascii?Q?9FvHu99+dh9tqyyueTsJao+7g+YZJ7rCqM1XSGDjGnE8JsNjFeQtTPG75koC?=
 =?us-ascii?Q?2UUK5LL/CPqUwHr2cSRQAdXiRUQzv2GFtdZrGiqNuAudsr7Sjgt3GjPGBj9m?=
 =?us-ascii?Q?L+iy5c5/bQL9MQ0YR7lSNd7Qgq4aOhQk43K8VBI3H3L4IOcZLhjk3AngHGVs?=
 =?us-ascii?Q?af936feTRTYEKBmJd4wEFBoCkeKTEJcIeyPGi0jLjx64gB3FgQXohPeZgL/b?=
 =?us-ascii?Q?rhRXHkcKEhTBSBa3FOIdRk6kQLm2YgogZ9idmWt7gv8yGKMVOC7HN4mbC2gc?=
 =?us-ascii?Q?BQ9IUQiGrTOjf48N36qbP7J+5YlFfxDONz3HnTuG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636f48a4-f58a-464b-db81-08dc1e8d0821
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:37:05.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7op6yC5V3MNDm0wdjjhH8SpuVYRBiKsQTENF6MUH7dn4jc+MV7qUS+qsfAIzQI/gP+g5wYpE+R8f6dNn0BSzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285

On Thu, Jan 25, 2024 at 05:12:53PM -0600, Kim Phillips wrote:
> The SEV platform device can be shutdown with a null psp_master,
> e.g., using DEBUG_TEST_DRIVER_REMOVE.  Found using KASAN:
> 
> [  137.148210] ccp 0000:23:00.1: enabling device (0000 -> 0002)
> [  137.162647] ccp 0000:23:00.1: no command queues available
> [  137.170598] ccp 0000:23:00.1: sev enabled
> [  137.174645] ccp 0000:23:00.1: psp enabled
> [  137.178890] general protection fault, probably for non-canonical address 0xdffffc000000001e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
> [  137.182693] KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000000000000f7]
> [  137.182693] CPU: 93 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1+ #311
> [  137.182693] RIP: 0010:__sev_platform_shutdown_locked+0x51/0x180
> [  137.182693] Code: 08 80 3c 08 00 0f 85 0e 01 00 00 48 8b 1d 67 b6 01 08 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 00 00 00 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f 85 fe 00 00 00 48 8b 9b f0 00 00 00 48 85 db 74 2c
> [  137.182693] RSP: 0018:ffffc900000cf9b0 EFLAGS: 00010216
> [  137.182693] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 000000000000001e
> [  137.182693] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000000000f0
> [  137.182693] RBP: ffffc900000cf9c8 R08: 0000000000000000 R09: fffffbfff58f5a66
> [  137.182693] R10: ffffc900000cf9c8 R11: ffffffffac7ad32f R12: ffff8881e5052c28
> [  137.182693] R13: ffff8881e5052c28 R14: ffff8881758e43e8 R15: ffffffffac64abf8
> [  137.182693] FS:  0000000000000000(0000) GS:ffff889de7000000(0000) knlGS:0000000000000000
> [  137.182693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  137.182693] CR2: 0000000000000000 CR3: 0000001cf7c7e000 CR4: 0000000000350ef0
> [  137.182693] Call Trace:
> [  137.182693]  <TASK>
> [  137.182693]  ? show_regs+0x6c/0x80
> [  137.182693]  ? __die_body+0x24/0x70
> [  137.182693]  ? die_addr+0x4b/0x80
> [  137.182693]  ? exc_general_protection+0x126/0x230
> [  137.182693]  ? asm_exc_general_protection+0x2b/0x30
> [  137.182693]  ? __sev_platform_shutdown_locked+0x51/0x180
> [  137.182693]  sev_firmware_shutdown.isra.0+0x1e/0x80
> [  137.182693]  sev_dev_destroy+0x49/0x100
> [  137.182693]  psp_dev_destroy+0x47/0xb0
> [  137.182693]  sp_destroy+0xbb/0x240
> [  137.182693]  sp_pci_remove+0x45/0x60
> [  137.182693]  pci_device_remove+0xaa/0x1d0
> [  137.182693]  device_remove+0xc7/0x170
> [  137.182693]  really_probe+0x374/0xbe0
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  __driver_probe_device+0x199/0x460
> [  137.182693]  driver_probe_device+0x4e/0xd0
> [  137.182693]  __driver_attach+0x191/0x3d0
> [  137.182693]  ? __pfx___driver_attach+0x10/0x10
> [  137.182693]  bus_for_each_dev+0x100/0x190
> [  137.182693]  ? __pfx_bus_for_each_dev+0x10/0x10
> [  137.182693]  ? __kasan_check_read+0x15/0x20
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  ? _raw_spin_unlock+0x27/0x50
> [  137.182693]  driver_attach+0x41/0x60
> [  137.182693]  bus_add_driver+0x2a8/0x580
> [  137.182693]  driver_register+0x141/0x480
> [  137.182693]  __pci_register_driver+0x1d6/0x2a0
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  ? esrt_sysfs_init+0x1cd/0x5d0
> [  137.182693]  ? __pfx_sp_mod_init+0x10/0x10
> [  137.182693]  sp_pci_init+0x22/0x30
> [  137.182693]  sp_mod_init+0x14/0x30
> [  137.182693]  ? __pfx_sp_mod_init+0x10/0x10
> [  137.182693]  do_one_initcall+0xd1/0x470
> [  137.182693]  ? __pfx_do_one_initcall+0x10/0x10
> [  137.182693]  ? parameq+0x80/0xf0
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  ? __kmalloc+0x3b0/0x4e0
> [  137.182693]  ? kernel_init_freeable+0x92d/0x1050
> [  137.182693]  ? kasan_populate_vmalloc_pte+0x171/0x190
> [  137.182693]  ? srso_return_thunk+0x5/0x5f
> [  137.182693]  kernel_init_freeable+0xa64/0x1050
> [  137.182693]  ? __pfx_kernel_init+0x10/0x10
> [  137.182693]  kernel_init+0x24/0x160
> [  137.182693]  ? __switch_to_asm+0x3e/0x70
> [  137.182693]  ret_from_fork+0x40/0x80
> [  137.182693]  ? __pfx_kernel_init+0x10/0x10
> [  137.182693]  ret_from_fork_asm+0x1b/0x30
> [  137.182693]  </TASK>
> [  137.182693] Modules linked in:
> [  137.538483] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 1b05ece0c9315 ("crypto: ccp - During shutdown, check SEV data pointer before using")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: John Allen <john.allen@amd.com>


