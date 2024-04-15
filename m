Return-Path: <linux-kernel+bounces-145370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD928A5491
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205C3B23124
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293C81ABF;
	Mon, 15 Apr 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Jpcw6vCn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F780BFF;
	Mon, 15 Apr 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191711; cv=fail; b=HZoeYLzOl2NL1I8lkU9PcEKfhXvQGXqH8mpcKuYsFaW1HNZtQph3F5P5TRAzSPGqjcyudQOMSwN895EBbrSP8T1oilHGDb4ixChQ26+InJwvpFOMYA3cLEJgFD7K6AIxiVxWaNvHetgQqgQOwtO2UFVC20ec93wcAkrd97Ry2fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191711; c=relaxed/simple;
	bh=qYLevbAqQwGB6j3cHbXZp8X5hcl/TrtpvuMaN91B6yE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GAM8it5h6PhA4rmb+ClZEbAb91S/HrOJPGPb6X4akKsADu2wrFCesVICjVmjWms7fcdZBOg9swiRFo6DffnnMWzGFB92nwpI3F8QyPjIHBTcOUvLcRVvmma4d/JdKCL6M6LatXRk+fG6cbUro59a2BIxKoCB0JNnLGAx3ggCq8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Jpcw6vCn; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIBTMxZY58F85Uj30DOiwNh2ZdSGeAKw2zm+5tqKUFFGef40D57uAw3GvtLLwYMX/jg961gDK2RsiMms9HuLNQYoDBkFfhckBdK5S8r5XPOy1FBTAie0QiWG3q+O1omn23DUelaL+nnr73QPaIQ4Cgq9l3xRdiIflDyHNTha3WnE62VX9Y+7eRyyrLRkbq7k2G9FSts70+ibP1lsx865YMqJ2nQlIfkIyb9yFll6E3006B1WZ9CY3z7epuZei1OqEchNLX6XPGvadRykbUBsDQqtOsrNsbwKsGxPpFWrusuBEt5Vd/zP0IL6tbfQ8DuYRSvKHoLKMHcCC1SnbuI/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU9NmbgS81J6rJKGkiusKy/LJsmgDp6Sjqex00ATqjw=;
 b=j6GN3hprOwhKIQAeSooz2/Rz10dDunJZOVPGsjGzB2qtIJZ9GAhU9Nnzy2LVFaiNErmLxiPuwsVd82ctOuxGxbdn9AiHCYkl/3cM2VgZ+AHJu8mXVdJG/5LtKZaVQEZgBBPctJ4FVViNE6TH/fucROe4e6IpHom1EBDiL7qDcESDV4+6vpw26P4BlToctyThAFlHSk2mBTli5WCwtcdvEb3MkQPux+O2AWbLd//hr98KaAHX5zVdo7IBqLKTKSBG1360D9h4Nto/OLq8ClEAQDkEO7DCHWcRh3p2PvFjGJUqcDzJwurREvTjkW8oWcyC+nlt+gbwUxEu4MBfMxtSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU9NmbgS81J6rJKGkiusKy/LJsmgDp6Sjqex00ATqjw=;
 b=Jpcw6vCnE/lH0G3yCjnLoq9CSj28OjrqecQUrjL2CmwIOrvqcZXIg1zMZSOxRWoFpgr2KgiEtFKa2CggfCK9LVYgQzWRGhzW/u4JX8a7m+LT15CrPDnl/CWCHkY72LC+J3pAt9NyqmX+krF/NW9Q70435TJQRi5vaqxoSvPozeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com (2603:10a6:20b:5a4::17)
 by AS8PR02MB9210.eurprd02.prod.outlook.com (2603:10a6:20b:5b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:35:03 +0000
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::e3f0:db9c:c11:90ff]) by AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::e3f0:db9c:c11:90ff%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:35:03 +0000
Message-ID: <258e2dba-da30-795f-6408-85c06e137b61@axis.com>
Date: Mon, 15 Apr 2024 16:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] smb: client: Fix hang in smb2_reconnect
Content-Language: en-US
To: Steve French <smfrench@gmail.com>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, linux-kernel@vger.kernel.org,
 rickard314.andersson@gmail.com, kernel@axis.com
References: <20240409112758.467112-1-rickaran@axis.com>
 <20240409112758.467112-2-rickaran@axis.com>
 <CAH2r5msm+xFyMPCJV7Luf6aQ04cHOhevmjJi8J-2Bf711T1ziQ@mail.gmail.com>
From: Rickard x Andersson <rickaran@axis.com>
In-Reply-To: <CAH2r5msm+xFyMPCJV7Luf6aQ04cHOhevmjJi8J-2Bf711T1ziQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0102.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::23) To AS8PR02MB9505.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a4::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9505:EE_|AS8PR02MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f03977-dd08-4fd6-40ad-08dc5d593cf0
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	duhy3qs2HuVTfg4ITYDl0RkOOAaryDYqaKem6lTNOIBEzz7PtGzsu4Ll0wF9+JnLkuYtg2bSn/ecVTm6vAwpzzxQbdKzSXfI+0SdBDiXmkO/bhu44OtdPpp9lrdqG40a4QinXf+IX50dCUI+vyheIIO18wjPA023vcv2mWKvnkj25fHpG8TI3wGIa92GUsKUaLgzx8Q08MjuMx6mK40pJx3PEkolsr/QCOO0bREhVRbfSRbD6i9+r+E59NpVDNWJGappCqb8ir5vboyCla/GcgT5NNBWswfCRSAXndXFD/We7z9IgZ7nEBsPdu0MUxMbmZ0HVjx0TA8V/J9fppjMONZJOdgWmnnoD2Z50vWFXlgq8ghoGKXZz1zpQd2LvJVr7NKGAUU/KBNlNRLsKuI+Zpi04A0VmzoPCXkC5/X+YTq05AU4MfATHA5y7hbZp49H1Gkhm6rkCuzshsCJCgJPGxLWVqRHDnKsygs5t5ara0Qv3bu3vm5CJ2rYLWioCrhW4v4DBne0sh5LoDDvK0Cngu9fMn1wF6iECbFiepF1rIRYtTV3TbJr1dMpXyoqk8UxMW55cZEdt3r8YNSrLTHnUbZ5nzdeXsohyGfn0JosEl8OkB0ih8wZWb2QrGUtLtGBVPMV9VV9sH7z9bj6qU/X3EdgQEgc6obRyvgPnKBgtYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9505.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0pvcG5ZeUhHZXJCZkRzNVk2RUluZWdpdkJ4ak9pUFpQSVo3NzJxZFUzY25s?=
 =?utf-8?B?RE1wSTY4WmpjazFuRzRYNlRUTjlkRTh1dTZReTBySW1rZWFqSGdpT0ltaWVp?=
 =?utf-8?B?VlVQOEdwMXQzUTlIWWk0LzhlclFGZllVeE8zOUlYRmorZHA3bTRodm80TUF1?=
 =?utf-8?B?UnhGZmhxaVJwd3pRTjhyQW9lN0twUVREUFllNEpGSGR2eGswcW5ZOGRiUWNz?=
 =?utf-8?B?c1V1UW5nVWdiNUJpVGdQZm9pSW9OVSt3Z2dsb1F0VTN1QWtQVFlMTzh4dDdV?=
 =?utf-8?B?cm9FNG8yVHlWaTFoZmtNQ0V6VGNicEw0Q2plSGhhOUxXVUhhRlhMYVRxS0Ry?=
 =?utf-8?B?QnkzN21pUTlUM1YwOEpRV0M5OW1rb2tXY2NVQU9vNm42ZUxOVDlLdEw5N1BF?=
 =?utf-8?B?RUp0d0RQVGtmTE9LdXRMNVNEWVc2clFwRzlOREpoRmhHa3RqVWFkSDNHSTlj?=
 =?utf-8?B?a0VWRStNZ0p5dWhVYkxZY3Mvbm9hcWc2Z2tXci90SlJWWFZuMHZLbXNUc2N6?=
 =?utf-8?B?QmFNOUVCRFdQWjdqZUQwU2ZPalBIN0dUOVVSVktYUEFYR2dLalJ0Mmt3MFY3?=
 =?utf-8?B?b3RENWEyd2lhSXFVZG5udTNhamdzMEJVQXFuUTBIcTBlVTlFTTBBQzJtZkpz?=
 =?utf-8?B?WXR5MDVxUkF3c3RhUS9TWTNBaWNSRWp6KzlUVEtnNDJ6NUJ6czl5d2RvcDZD?=
 =?utf-8?B?TUZWdzN1SFFwNnk1VnpDY1VrUFFidWNTN1NlL3hvdHBOb2lLTEVvMkVneURY?=
 =?utf-8?B?RWZxMmdIa1dDTklqdlhjTHRsZ1MxRkgxL0JzTEhwZU9zVjduYlluQlBSNHQ4?=
 =?utf-8?B?S2FteVJxZkFyUlZzRUJiMUsrdE5qSXhqRXV5NnVFNVlJTXEvZmEyeTZnZG14?=
 =?utf-8?B?eG9qL1RYdWJuaVRnWHNuWFFIVWkyVm5FUU11YmllZ2tHbnNab1k1cEZCakJI?=
 =?utf-8?B?V0g5L3l0OCt3NXo1c01lSWQrcjhSbWJpYTU0bGxuMG81ZlVWaXBmWURDcWNH?=
 =?utf-8?B?L0VPMzFreE8rckhVUGF2MGtWMG15WW1FWGVsRVA4Q21aUnBzSzJpelhVRXUz?=
 =?utf-8?B?Z1htZW15Z3BIS2VjWXFuYjYwUlZHYUJuaElZcDRseWc5d1IyZm9xQkR3UEx4?=
 =?utf-8?B?WEF3ZWNYOUNwYUdoODVHdHhXR281QWg3eHprcGFRcEZHSWYwOWY4SGpIci85?=
 =?utf-8?B?ai9waU5yS1oyWWZvZ2s1VVNPa3hnZWwyc3pxb2p3aDM5N24wbno3VisyVGdp?=
 =?utf-8?B?R3pFNjdkYS9hMThWQjEzQ1FMOWhsVjhzS3lkNW8yTzNIUlJoYzNjUkQ5MjVU?=
 =?utf-8?B?SythcFQ0ajJkVWNZUGlzVHR5dlN6bUNqRTZQMUcrdFE1UkxxcWkyZGVLMHRR?=
 =?utf-8?B?a3JNNmhaVEk5aEV6Zm5yOXd5WkEvUkJSVGgwaWVWRjRUTmVhMzRsc3RXWVZ2?=
 =?utf-8?B?ZGdQRUd4RkowRk1XclFBcnp4ZHVDWkl6UTBUcXBMZVhYaGtzaVFuMlNURTM4?=
 =?utf-8?B?a2pqeFpZTDZldGVCUmNJajQ1a3Jyd05Gam5odlF2ZjJYRCttTmJ2SEJKOVFp?=
 =?utf-8?B?WWdjU1ZyTHI3UkxHbnpXVDA0MGVwaGFCK3NlRDZzbm1ZQ29oaGxjWENpaTRC?=
 =?utf-8?B?bDlURXpvZ1hEZHl6bUxpUUc2aDZ3cGJIM1lNUWl2dHNyY1hLK09wSysvLzJv?=
 =?utf-8?B?dUVUaFBGcit6Z0pqeWVhdVpPYTIxcTAyTU5RWWg0eldWNXRUcXlsOW5ydXMw?=
 =?utf-8?B?b0dUMFdldWhyZkRheFlnbXM3cm4ydGlvMmYvT3JlY2xLM3F0WTl5QnA0Mlor?=
 =?utf-8?B?UW1wU1BaSVo5eUlHSzNRcUpvSkE2T1FlNDVpMllaaVRkUUVrQVo4SEN1NGc2?=
 =?utf-8?B?QUhTS2JkZ2duYndyNjFJM0ZoQ3hvbzczaGpGY1JPZWpKbGN3anFiYXAyMlBn?=
 =?utf-8?B?NkFFR2JZa3dtN3lFNmg3dkE2bjM3dElGOU5qc2QzTzR3MzBuQWg2bld4bGlo?=
 =?utf-8?B?cUp1VWhSQ2p0dHFpSGZyeHdBaGhCS3ExMXN2bEh5NlptOGNQRGpEMmNvbGIz?=
 =?utf-8?B?cEk3Wmc4dEtBWXM5SjBWTGpVNDV1ejZkQWpuMGpuQWNTYVhDVHFESzU2WDNk?=
 =?utf-8?Q?pYUxG7slenJS+zjeSLfSX+K6a?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f03977-dd08-4fd6-40ad-08dc5d593cf0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9505.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:35:03.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usXjwbChVDLb4sf1vEAYyOZbsfHgr7Fb+Hu9CNTYACo6bMqwMFQpkClR6OZnVGveiHWSI2NUJ6F/ZECZ9Zr/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9210

On 4/13/24 11:02, Steve French wrote:
> Shyam and I tried some experiments and there are two cases where the
> patch breaks:
> 1) ChangeNotify will time out
> 2) Certainly byte range lock calls (they can be allowed to block) will timeout
> 
> An obvious alternative would be to not make this change for the
> commands like ChangeNotify and blocking locks but allow it for the
> others.
> 

Would it make sense to make the patch less intrusive by doing something 
like the following?:

@@ -1209,7 +1216,12 @@ compound_send_recv(const unsigned int xid, struct 
cifs_ses *ses,
         spin_unlock(&ses->ses_lock);

         for (i = 0; i < num_rqst; i++) {
-               rc = wait_for_response(server, midQ[i]);
+               if (flags == CIFS_NEG_OP) {

+                       rc = wait_for_response(server, midQ[i], 50*1000);
+               }
+               else
+                       rc = wait_for_response(server, midQ[i], -1);
                 if (rc != 0)
                         break;



So, we are just waiting with timeout in the case it is a "CIFS_NEG_OP".

Note that I am not familiar at all with this code base.

Best regards,
Rickard

