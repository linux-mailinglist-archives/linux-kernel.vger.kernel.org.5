Return-Path: <linux-kernel+bounces-152604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC048AC116
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FEE2812E2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A844C8F;
	Sun, 21 Apr 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="qmUfON+s"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2107.outbound.protection.outlook.com [40.107.247.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBF44369;
	Sun, 21 Apr 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728627; cv=fail; b=WD/MsL8iHUX0x6j7hncJ3HcP63nd6dqwvgie+7Wf/GXKDj1Cc4dj2uGmqkuZvkvskMTqs63KFNnab59JMbF4JN+XFur3G8CGoEWwGBQIwK8OvH9BVcDcXHGXn5B9cntjRooLlu39PfdhgaYwDzgLif/EEmUDdUR/s1SCLR3Q1uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728627; c=relaxed/simple;
	bh=wTQrjpq9qiQe5NhUc2wXuZMR4aQf0bSXkVUA3EWSr7E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A6PjZhnXTfdiDOcySDaTI+pj46F4Bobs7QjTdjXt+FZxEc6VaCg5npazYrs9EMxbYMLCwJcR+pNdhKIVfXmPOv+l5gKsc0V532ZeGbg3BFU75QVKxTPJzVCxynZs2iAJV3CbWTLoOpA7qKf8fwLlyhGkuTJ5riSM95l8vvpGtig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=qmUfON+s; arc=fail smtp.client-ip=40.107.247.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDE1FBVMLTCLQVNAriBmRV4j/4z7gnoubhV3C7ihQppymHNnF9UTNZfCoINrX8h3BnTmVH/j6bzRxU55sv9jjH/xz5Adg5eBp4ADnMAaKjO+dF0bI1Smkhk6BT3Yh1MtIDSojFzgjQ/4IDcSEX9i+WkRamz875w49G9XBybfJlx5pWy/5plgraXbcvXJhDnEyrIJbl/z7SBa1Ww6HqTLHGuWarfBNCNLCSQ0oHYCYkIfDYICz7T1YZHP6B3qTnF0DKy6JqXewqwJA4GnWLxDG6pi9Sygj3i7vzFTfabmYBmrcjdAwA7P1y81QVhAU2L4lSyk4Hel1nRxYfuztmjEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J//0LV+j2ye9lW0R5NQ8ZvG9FdyPjsY+E+QZntZY3rQ=;
 b=O/S3E4pWOg4t89nXLgO+ZTRyWg7P+Xudxu1zm2FXVyTt04MjC66Vko1zlGB2CktOZwAX1GCgedUuyRd5CIDZLwlzRBfUzo6w7Kt+24t6hL6A1VWZIt7tL6P5WWtDVdx6ksoLpANgUKVK2MP9kdRd+LRhrDhERmHesm49yy9R4wchlGREH+vp3ny2CpuU9B+bjkpGY5lJay/Beu1YuEX/S/CvwnEwG/VbzwXVLcgvqeJ62rxinWuAbRBcmtOGM014MDZiCOR2FLV9rajTC04d63j7wSiX2Cuw9VM8Z1jAOlDTUpbABWC0fGCAF6I7W73919TOsNb3s8PRSuk2hdxskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J//0LV+j2ye9lW0R5NQ8ZvG9FdyPjsY+E+QZntZY3rQ=;
 b=qmUfON+sbztHn0id/cynOydZt37+A7nq1WZePyU3/kX1qlu9P0XK4XGc1wwDR/4NdIY94vlZQ/fbZ/4111Qd95HeEHc9JauLxfoLPH9upvXNsqsLZG86K8dtAxfR1Mhafg9DQ2jyU8rpoAPKU5RIkCWLaKppXsG/N6ZNjtz3o8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by PR3PR04MB7372.eurprd04.prod.outlook.com (2603:10a6:102:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 19:43:38 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 19:43:38 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v3 0/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Sun, 21 Apr 2024 20:43:19 +0100
Message-ID: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::13) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 278a9de8-b6c6-4332-3a59-08dc623b572f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGluT25hT0V6Lzd2Rk82ZHlRWkRLQjNMQnFyU20xOUFZY0ZJb0VnTkU3R25s?=
 =?utf-8?B?NjQ4M2dJMytZcFozekNKdldobDlrS0ppSnozRzZZektuUmtLekhuMzFxd2ZU?=
 =?utf-8?B?NTVOUm1xTzl4Zk9Ka205dmJibTV1V3NzaVkrRXJycTNyWi9FdExxbGFlRCtn?=
 =?utf-8?B?R1RXUzliQithVkg3VWxtbW5aUTQ2bHFaYnFCdU0rKzZtVU9FS0xkMzNDakRS?=
 =?utf-8?B?cE1McFhRbmg1bEZocmppTG9rL0ZVWVVIQWMwQ1RSbUdaa1l4c2EvT2JBS0pM?=
 =?utf-8?B?U2tKYU82dFV4WUF5RXRXRi9EeU5jMGw4V0dYVE9kU29WSTZGTDJaT29EQkJC?=
 =?utf-8?B?d0FEWTFLbWk0ZWJUN28rRG8xU0RBRUtqd1U5SGw1OVQwbmZRcThOb00wdEFX?=
 =?utf-8?B?OVhqaVNuMDlCVG01UVMwemduV0tLRkR4SWNDYnBYVGRMaUdZVXZCTDU2dWRG?=
 =?utf-8?B?VEMyYXRnNkVLYVUrb0VydHVNTW16UTNHM3BGK3ZwSW5BRGxOTURmS3pwc0o5?=
 =?utf-8?B?M29BZUVwUFkvUVFSbmNseXc0Tnk2SzVRbURoMWhibkhjQkp2cXZzUGsvM1Vn?=
 =?utf-8?B?enZWVFJYdVRUdjlnUk5ibHRZRDVmcnVpVnpwREo4dElCVVR1MzZLeWxyZm5W?=
 =?utf-8?B?RTRFMmdpd3FSdWovZGRqKzF4QndUY0lzSy9tQ0VMZ3F4azMvUm8xbE1VR2Jx?=
 =?utf-8?B?MC8wcXd5K1BVeGhUZlhST3R0ci8zd0x0cFRjQTdEdzltMk5HazdyNHJzTkw2?=
 =?utf-8?B?ZFhtbWtBTE5xRDJJdyt3RUIrektQR1pmWktQeXhUK0hwbnAwZG1pK0tyeDVp?=
 =?utf-8?B?dFBRMllCYi9MWGdpWExDalF4RjFNd2ZVaktWOWNIQ0V6VjI0SFNFR0w2b2po?=
 =?utf-8?B?TTdZdkZFZklUaEw1dTl6MHBvMm9JdHptcmhwOC9RSldWbVNZK2xtUFhIbGR0?=
 =?utf-8?B?cyt4RW1PYmJ1eVVFQ2wxMWk4U25JV2hVUGpvTmxEVXNYVzJ5aWdLckhaeHQw?=
 =?utf-8?B?VEJtaWZOcm5ocnpxYitqR09ZcDlvRnovNTRCaGx0OEI4NnFMaWwzcEtvR2VJ?=
 =?utf-8?B?TkswR0ZrcWV0MmJ0WkgyWTI4NXhva2xDZW9oaXBzcGRrZmN0UlFydS9MSjd4?=
 =?utf-8?B?VnhpNGNyaVJrR2E5a09kKzFqMi9KeDIwbGNhU1ZXbWVGREJXUERBWFFPR2Q4?=
 =?utf-8?B?SGo3ZnB5Wndpa2N6T2ZUVjFZdTlEb3hhbUdnaE9wY1I3UUhrU2doSjFxV2FF?=
 =?utf-8?B?dHc1Znd0bVdSZG5GKzYxcDN6cVVhd1FaOTR0WUhFTXVaSE5SUjBsZDY0eWdm?=
 =?utf-8?B?dzA1REFsUVc1VytkMVo3SnE5VDFKQkNRNEpiVTV2YXp2L2hxTVNOMjJJOEJq?=
 =?utf-8?B?MUtraEFhemVOVjNDMWw1eFpOQUtONHczT2crOVNnT2Q1NzhZL05WVDhmc2ly?=
 =?utf-8?B?cFJabDY5a0NuaVdBMXhkYUdyQ1V3NGRIaGljTkx4cHJ0NTRDOGlSR2pzc0lC?=
 =?utf-8?B?d0JLdlBvWC96cTJrMDJyZ2o2UEROeWFrUXAxUklrcjd0S2dCc2ZpQm43Witw?=
 =?utf-8?B?WisxWXlwSTd3NHpwTkFDZlRhRDBDamxIZDIxU2h3UjBWbk5FSzA1Y1ptbkdp?=
 =?utf-8?B?UnZCalpOQ2MweUo1VENwcjRqcGlaRWFyNEk3QmwxVlBReWlxMGJrQk1hdWVP?=
 =?utf-8?B?VjJNVnhDYjg0Ulo5ZzdUTUF3ZGowakNnYW4xMnV5K3oxWnl5TjRleUlEU1hV?=
 =?utf-8?B?aVB4WjhFRExLNVJUSDBEQ043d0R6MG9lMytCRFBYOUlMbDdTUGo4OFRKR3Iv?=
 =?utf-8?B?R2kxKzU3STlPS2p6TVJWdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(41320700004)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRyeWh6SGhKMUN2WTExNldPWFo4YldMWGtxY2x0RS9zVXRYUll6ZzQxL0hi?=
 =?utf-8?B?ekhaRWNJSDZhZW9oM0tScXRabE9JaGR5eTQ0T2N2bDVxUnBDL0V3UmdDenVv?=
 =?utf-8?B?Ykg3UmxsaHJhdTQ0bWFzZUgrTUo0bEhDUi9iTzAvN095QjcrUkRjcWprUzdL?=
 =?utf-8?B?NDhRTnZBU1R5V2FCeHV5Ujl0aVJ5YkNLbHpsWDNrUjVFdVdlUDU1RjNzejFR?=
 =?utf-8?B?Rkt4U2x6d1o1ek9ObXR3a0k0clZSbEJjUlVYdzd5UkdmbC9zZU5nT2V1OUFW?=
 =?utf-8?B?U0t2NTViRUhsU2dnVzB4ZVExRXJNdUN3ZUpzMHdDSFhwZVp3dGt6N3drd1d6?=
 =?utf-8?B?Nk0reWdVWC9ZSFk2YTA3bzRqV0xualcwUnVkQWVTT29kdWhGOHF2TUlBaENY?=
 =?utf-8?B?RlNvZWFWMDNDVU5OYUFyY3V5VlVVNXZGM0VzQnlFU3l6NmMrTjA3eFkyc3Q4?=
 =?utf-8?B?aGhCTS9jTUMvbm1NZXJuTEVlQmlDVmZ0RWxPbzlBUGNhUkd5VXdMMHp0Z0pE?=
 =?utf-8?B?OWxMUUZkWVVrbEhReGpNbjYxNjdqNkJMckZEeFlMNDkzTXFPbGZwbi9SeDY0?=
 =?utf-8?B?Q25PYTN1aDI1Z1l5ME1kSjI0bmFDQzdMcUtSdmpldkhldGlmNWtOUGFVdFZS?=
 =?utf-8?B?eVZOMFowOXFReUltYW0vNUFvRTBERDQvWXpjdUN3WlpFamFJVktXS0RQVlhp?=
 =?utf-8?B?aFdrb1Q3TGVKekNpbWNJbldhWE9HUEMxWlFCVUpaUEpHT21na3lsTkF5eVhE?=
 =?utf-8?B?MkVJbjZWcGVZdFhnQkVBNm0rdWRNbkZCZEtrLzh6RmZaYWR5YU9ORGxmaVp3?=
 =?utf-8?B?Qk8rczI5UkV4Z2FzZG95NGZNU0NyZU5ldGpxTWpFWkZoYVVPSHlFQVorYXVQ?=
 =?utf-8?B?aVMyU0Qvbi8vTWNEOE1WSFBLTjVuTytxVStZeW1UTmFadytuSXlVUkxRL0Y1?=
 =?utf-8?B?VjdqWUtRVzJmMWZYa1luNzhBYkMwZktRNjc2WEJ6M0xTZXZiVkFmb0FoVG8y?=
 =?utf-8?B?TkV5bjM3RVhwUXZHRWJHNG8xV0NHUlhCR1pUT0VDTkVqZVNjeTVjalMrVHR1?=
 =?utf-8?B?ODlQV3FFdGtmTEExSm9ycmk4aHBiQUJVMlczbXdFcVJKQjlZVHJmOWlPa1Za?=
 =?utf-8?B?SmYreVUxbWVWRlZNZTZaenROUWhSWFNEWENJR3d5RitrYnBHY3pZeG0yWU0v?=
 =?utf-8?B?eXdHVFI4L2s4VFBiRU9sbloxR0w4cXZwdk5wQzkyTWVxbE5ob1hVaC9BUHJz?=
 =?utf-8?B?Ymg2QitTREJSRWZVQzZXRjROVWxRNHVIRGJtTklQWWxEWlVEYXhzRkR6Ylp0?=
 =?utf-8?B?dEROVWF0Q2FVUkhURWdBVnVrc3VxVFpnZ3FxR3gxNy9hTDZXQm83ekg5cWxF?=
 =?utf-8?B?bmFZU3F2MTNVWE8rRi9PNytDZlRpK1U2eGFHM2QxQ2RuenpyYUJLeDJkVmFU?=
 =?utf-8?B?NTMveU1XeGRCYjVWU3J1SHBYZmt5cFlRdWZJNUNZb1dadERCRlJmNVVPU1V2?=
 =?utf-8?B?cUVuSWtvQmszZzVQdkw4MWI4ODFzTXBEUlE2SllaZTFsSVRLRG85aTNIRkdL?=
 =?utf-8?B?V045QW5mM1FWdlpLSzdrZElHTExBdThJUjl0WlE0a2RheGFnWmJaa2htcVlm?=
 =?utf-8?B?cnpVQXptMlRrU3M3ZlN3MzFYRWVlMkFBTDE0ZFo0cVhJZFU4ZkxQb1ZCVVZl?=
 =?utf-8?B?VTZqdkU3NU1ENHg5ak5abnEwU2VSZ3JwaG0yc0JYQktMN2p1MW5RaGRVK3M4?=
 =?utf-8?B?WlZ1Nm9kaEhTUWxGK2hPOEJHWXZjWTFESyt2dTNNWHE2MWx5eFhLSldPc29r?=
 =?utf-8?B?WTd2NnVmeDBIYWl1eWI2MlRwMndCNXkrcURSK2dCUkM5cmZGL0tCZXQ4TTdQ?=
 =?utf-8?B?Q3R1MVRmWU1xWThhdGhCZm51UGRKZkhndVpjdklzbjg1cjFsR1lKYTM2eUFv?=
 =?utf-8?B?WHV6bGVDTHdCM2piWmsrcjJYV0dUU3VBWWZvdU5aSENkbUI5UFZiSjBzdDBm?=
 =?utf-8?B?c1c2V1FzVUpSL0VQZFhyS29NejlVVGVlSm5GOFJNUnFQOTMybW1Xb3JTbHQy?=
 =?utf-8?B?SEdRWVk5TGltT0RtdkNqUnZxZUNBTmMrL2h5dUR1SUhIeU9uQ25nMy9QK2dq?=
 =?utf-8?B?R2orUlRRNUFxNm9uZ3JDMGJJNlRBclczTmpWRmhSbXoyYjgvaDJ3T3BYTkR0?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 278a9de8-b6c6-4332-3a59-08dc623b572f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2024 19:43:38.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7APLjB4q2k/p8XduSn8veJVFI/tkfOknW4NWOYxAc68t8R5ztUmHf6aoKB+bCZP0PIrKrlOySH/n3sIx7RP+smvj1EPuSTQIy7X+DCpbfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes and adds a new
full speed mode available on these laptops.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Changelog:
- V1
  - fixes grammar in description
  - reorders macros
  - adds throttle_thermal_policy_max_mode() helper function
- V2
  - removes unnecessary braces in throttle_thermal_policy_max_mode()
- V3
  - fixes a use before declaration compilation error caused by reordering of local
    variables in throttle_thermal_policy_store() function

 drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 51 insertions(+), 43 deletions(-)

-- 
2.44.0


