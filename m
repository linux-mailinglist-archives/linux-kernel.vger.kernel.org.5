Return-Path: <linux-kernel+bounces-157858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5E8B1768
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D593284B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22516F278;
	Wed, 24 Apr 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y6MIjrFd"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681C16F0DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002495; cv=fail; b=EeUzoImmult5g6QNf/i6/33LUSDEN5ZWhJTpLXyXdU5JKsy4BVMeq3M1ALuskxNctecSNMdTJFOMewbCJHpVaXa1imZvsR36GwE2Jx6K/r5/IwL2lcEVdz1aDH+81MwdCC6PZvLMIHhz8x/7sk08HT3y5hgN4Q6lomkO5zXwmWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002495; c=relaxed/simple;
	bh=zIJucA2n8e69iirA/Ksd/7MGykjEswu2ptqxdaiPdSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u70jSGGR/15JvUTB6trHDrPGEW7KsQLTcRiUUYJZ5gva/K5n3YJHdnORY0aZnTPFPMBOIWJzSQxc2t0O9bfDWosK+C97mWtpD6YbrM3Kjq2kYAGu3ebnRsKNQcq787PHdSrR58UzSKvquPqF1+C04ZsF2DD5Q1c0nmLh2pmKDhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6MIjrFd; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjzqMCaVlqccnUlVel8hlhk2GkJhVIAxsWvtSEgECZrfUVsDYFyTVlEW2CYt3yfyZB67Bi7dbklJBixHwfoSbl8HPKpJjWY+qxkrbOy0GosPnFiCdQcN8oBkXUvep/NcITlCc6z14UTg/PN1wsCNGvlVOw+Aq/8y1gpyG9nGfbU704TMF9TXI/zjvAMjI17N8H8ESIjvTyx2QXnLoaaNd14RlJf6rRb6A3vAOEdQtmCcFiP+AzSDNgXQj62R6ELsofkkaIs2D8U4TqD9HnNYp4Ic8ibunyiEvRIONqAI0vU5cWRoQXQdrjBlCQ0nefO+U3ai/FO9PeJMxFsq+zLBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfogewLFl0VtwZ3KeXZIDMh4IUEs0HwN1qfVBTTxP8s=;
 b=IFaE0vMaFDiQpyJt5GldJz+0z9ZHhEBNnt1oxXRbhgJDCYQqSnVzU/clKv94qz3urPr8OnrINtu8Yw1B1te2LwWN+zLX/Va7hiyYIyN1ifPOmHUuIE+KlvIRbTvEwvEIqAJL18m01SPgTq5+yQnl5A1E8s1IDOHlve+y7573Oav2BY92pu/A+lhFsK6lFgxLTsvhhBKyQwYPgPqFpdqWNnhBnwca6wp33GAu/eIWSHD/2+cATtQ3+CkYlstgWxfAfo5xtEmCTTZ08py1ltiRpiWhdSq4hLWxHryO/U9b+xQMxlqR5lUClwF5uD/1lmIt3zw9M5rpCrH7GyI9jJN2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfogewLFl0VtwZ3KeXZIDMh4IUEs0HwN1qfVBTTxP8s=;
 b=Y6MIjrFdMnlgDxtIcJ4Aq8SlUbX2T2HYYm7Mek2fDI1TYXX45Wicfko9bcLBqmsCxc1VrTi5+8Jp9/b5ZoSC7qGG+1/ZWs14o2cgYYxa28slhr2bu47iUv9uZG3aTNenbYEnQpPSRaJzQ3d+5I9N4xewfCCK4VDG5FZ4h8YUuF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 23:48:10 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 23:48:09 +0000
Message-ID: <ed4cb373-e626-4b79-b692-df5ea2ca8899@amd.com>
Date: Wed, 24 Apr 2024 18:48:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups
 for kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
 <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::34) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db0b550-e3ce-42a5-2824-08dc64b8fee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N01ONHpxMnZEZ2ROVVEzbVdyRFh1NVU5YlcwQjBiQWU5NkdDZTlhc3RmNE16?=
 =?utf-8?B?N3Q0WUJUQjhkeGMzUDZOUXpHMUZ3NHZ6TDZhc2tWUmQ4UEFCN0psNXJnWFR5?=
 =?utf-8?B?bEgzR2twZlBPcDRWaStWZXVFL2RydUpaOUREYmtKUDB5NnU1UWp1WEVieWwz?=
 =?utf-8?B?UFpCTmZ6Tzd4SExNWlpTS1ZxUHprdmgyTzNLWXQ3emQ1eG9XNTluZS9acFpw?=
 =?utf-8?B?RUtOWlZzOXhCdUJUaFZTelcwbUZnOUIzN1Jqazg1a1VhOHBtNXVoWlVwSHRi?=
 =?utf-8?B?YTBwTEFSeUZmYy9BRWxBWXhQdklIK1ExMnIreFlGM2t6YXhXckkySlB6bExE?=
 =?utf-8?B?a29tUVgyeDZLWGdEd3ptVkpBWU9hSnRld3ZSWitUY1JPZ1ZKMmVBZkMyalds?=
 =?utf-8?B?ckJWcC9LZFBRb2xIQU52bTZxam94Z0ZlM0IrS3QvT1cwRmphNTFmam1lSTll?=
 =?utf-8?B?aDVVUmVCV1U1eU52Z1JvVUxWRHhNU3hTUHAzWmRkblM3SERRYXNoSHAvdWk3?=
 =?utf-8?B?bHZmeEQ0a3JiOUNKcUNaak92dnFYTk04ck9LQ3ZaNkw2SUtPVEVnS0dIQWkx?=
 =?utf-8?B?MXd5dU9JaUhVREdsQVorMUNBb1E1bHowbXdLN2wwUDhmZ0lXNmJrNW5mWUEv?=
 =?utf-8?B?SG5vZW0rajFPNTI0a0NxOVJFR0FlKzZud1FUMjhKeC80ckdWNjVsV2FZUk5S?=
 =?utf-8?B?WjlRMEN4VU9VZUw3ZG5RUUhsQWU0V0lJNkErZG1TLzBPVVJQdGpMQ3hEUmdi?=
 =?utf-8?B?WGQwVXgzRHBNdEhSeW1mRVpudXdtc0M0NHVUOGxMa21jcHdKa3ZtZU9ubTV5?=
 =?utf-8?B?c1VYZExHdjl5TEpjYm9SbXhVaWlVLzJHU3VkUHNHV3RySWY0c0Fycmc2Mmpt?=
 =?utf-8?B?aTZDbzJRQ0V1YlhyR1dRUjVOMHJndkZDa0t3RzEwUUF6WE1MaHJMbEMvamFH?=
 =?utf-8?B?NEdXczh0cGt5SjhYSFZVODVTSndNU1dpR1VUN3V0QXFWK1c1THlmd2RmUXRP?=
 =?utf-8?B?U3g1bmV4RGJ2R29mVitvQTRPa09rMjBtQnlxWnBuMHdaVlIwekhHMllESkxi?=
 =?utf-8?B?T1RaM2dvRDM3MG83RFNtRTFNQTVWaytVYzBaNDFnaFl0TmZ1YUNlSG9NZDB3?=
 =?utf-8?B?QUdqcXpvaHMyaGpnVGkxQStGeWgrZUcyNmRsM2JjOFhtb0VZd0NYbFZwNUd5?=
 =?utf-8?B?VytwWG1KN0dlOUVTMG1SOExicnNpWnVTdGNJMTZMYzB5UE5kMUNsNjMzcHJV?=
 =?utf-8?B?QW5NNTJWeXBMeUVCcjlzOFY5MFV6M1ArNTIyS1RiRG5OUUdjL3Y3UTN5MkR0?=
 =?utf-8?B?b0pDSStFcDVZWFRyb0sySXlsdkI5V3piSGNFME9FcEN3aEJTMXRJalRLUThX?=
 =?utf-8?B?WldRSlBMM1hKT1ZzTGs5VU5LNUlmcE0zVUtib3hwNnlPWDVBR2hOZ3VMOGpo?=
 =?utf-8?B?Q21xdmlIanQwS3JSdzI0Ym9wenAwVHB4R20vWVpwREFoeWlQZi9QOVdtaDlx?=
 =?utf-8?B?VUJOMk8wM3p5MVBRL3BFQkpOd2p6aWtMUVlnamVVSEZubitSR1pxN3N5ZHFu?=
 =?utf-8?B?OSt6aU1BaDNZOEcwdHp0bEJINjVSYzFjNmNsRTZ1Y2ExazFFZVZjUzhVa3FH?=
 =?utf-8?B?bnVSZTdMTncvUkJnRG9IU29MK2NrcGtUMXFGUVdxV1BOZjNqWFdoMVJpeTA0?=
 =?utf-8?B?MGlVNlZUbm9MaFFKSjR1d2tORjdYWThlUVpnSUVkbThjK1FKNzlsY1pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9zemZXQTlDNWRJdHVlV3ZlY1dCQlFzTXJKUURMbWc0MVAyMm9OZEVEN1hC?=
 =?utf-8?B?eXVrNU5wZGIvOU9WSFZjczZ1b0pwRm44MEZFYXdvdytrZmxkTUhEOXluNXJs?=
 =?utf-8?B?M3hDS2VjRllBOFUwMHliTzVkZzd6UjNBNDdpSG1RR1lRZWZkb2FPbjdMakx4?=
 =?utf-8?B?VjZJQWlVUFpWYmEyanQ3ZjlRaVpHZHB4cUdub1U4WERVNVBETVBhU3RaVXlh?=
 =?utf-8?B?TENTQlpxVFpwYm9SdU1HS3VYOVg0SFd0Qktic0lIY1ZocHJ5UFNUc1RaUEJG?=
 =?utf-8?B?d2FBdUFvSTlzSFFiSzBKUFFwdFh2TkM3aHo4WnE0dlBBT09wSVpnS3M5SUFC?=
 =?utf-8?B?dkUzaUxzWjUvRWVMRVUxME8wbkhlT3hER0Zwb204RDNDY1JnVnI1ZlFtc08v?=
 =?utf-8?B?VVcrMnRGV2twNzZxNkNwMzBkcmxQeVNRaW1pRFRXcHZraHdTVTVpMmV5WDlT?=
 =?utf-8?B?a2VYcWRDSklIQjhvS3h6UytTcS9lNDVCOUpVRzJNRkpUUEpNUmZVMHlOSU56?=
 =?utf-8?B?Sm1HZGwzTnpZQjQ1Wk9mNU8yWmVkRHBpQVB4aUk1V29YdWRSQm5BeUVZcjlp?=
 =?utf-8?B?RHpmenBraFJ5NDFJbkZiUUg4LzhHalZiWWZMdFRUOVNLa3MwSE1hY1hIMW9r?=
 =?utf-8?B?MG5KTVVzdXdWa3dXdTlqQ1M5MFo0L0lmVW0rMkRyYXV3OEhKdkZNUjRIYlIv?=
 =?utf-8?B?QWlmOXc1Wmt3R2I0SXJTcHZneUQxRzlhbUI1QkFiNFpOSkIrc2svY3d6RTRN?=
 =?utf-8?B?WFpsanFmZ05mMGZ0WENnampsNDVaQmN6c2xuSEMxTTc4eHVzR0dpVzRmK1Zm?=
 =?utf-8?B?dTBnZjZ0Z1FRR1kvK2lRcmplcmt4clBLS2FvdHNGLzhxdFkzRGQ4a3p0WHN1?=
 =?utf-8?B?U2xZUjR0em9aUWt0MTBiSnlGWUZ3UlQ2YndhM2gyQThRTDhaOWxpd0RJL21N?=
 =?utf-8?B?TW5pcGNHTWdJWkFRYVJMdjhQWUhXZ0hyVy9pQ3Q2eVpULzB5RzR1Vkg3bXd0?=
 =?utf-8?B?NUszakQ2UUQ4UXVqOER0V1piOEVaRHFUaFBoNjFhbkIvckRMK0orMlF3VDJI?=
 =?utf-8?B?bjZZRnllSU45dVp4MVYrOWR1blZ6bHlzQXpvOGFLdm1VZFpFV2tIWGRBN2JP?=
 =?utf-8?B?NVR2RmtSdys1SmdUTTgzZjhXbndOYVZVb0JSUG15VnQ3UEVPeWhsODJ3OGEx?=
 =?utf-8?B?K0N6b2dGUStVTEU3eUMwSTI3OEJvT3hFRDBqeUJGcXc2aTlObDZUM2JtaUhO?=
 =?utf-8?B?bmsweWlNNHBHeWQza3dOaWlwcFVjZGZUeTVxaEhPOW1qa3pUZ05JUVo1ZG9x?=
 =?utf-8?B?ZTJWT2FiandSY205NkRybFVoRmZNWU5BenJ5QXZYaGUxMmZNaUN2OVRURzVJ?=
 =?utf-8?B?clc3N1NuMUkwV1h0QmpuK2NvR0tEcG5ycmJ2NGowY2h2dDV0RXgrdHZvaTVC?=
 =?utf-8?B?VHJwWnRLUFZva1NPa29PT0VRQVJXSlQvL0ZkUHJKRWpnOWJFK1YvQTh5SElU?=
 =?utf-8?B?elBkVk1CelEyWW83bmI4ODdlT1ZkbWkram4vU2tCNENFZXlpOEh0SFpUN2dP?=
 =?utf-8?B?TmR3L2Z6UlpSeHF3QWtBNkN4QUozR1VKcVhydzJTSjg2NVdRRFF4S0x6bjlh?=
 =?utf-8?B?T3k5RkRvWUdrQS8ydmRrQTkxc2g5Y3ZlZlZIVHFnLy9RemhzaDlwM2hTZEt2?=
 =?utf-8?B?emZVeThkcE1YTjMreHhhWHArYTZxNUFDZGp3UHpUYSttdFdWeWc3OWNQeHRQ?=
 =?utf-8?B?NC9wUDZzMVk4SHArdW1wdjRHL2pkbEpjY3RGNWwyc25VNWpZbUtJWEwwUHYr?=
 =?utf-8?B?TGVoUVh6a3N2WkxPM1NDSXJzdHpHbFVyZWp3VmJCdDdrdHhrZVBneElvbStF?=
 =?utf-8?B?SXJPOFg4OUJYVm1pWGRuVGtKZThtYngxZ0lSVWRSVmsvZ0R1YVI2Qkxsc1kr?=
 =?utf-8?B?S3ZETE5jWWkrTnVPbUdsdnh1Q2VPUW9sM2daZm0zNjRkL0N4MW0rU0tIbmR4?=
 =?utf-8?B?TnVOSEdrYjhNSk9YVEVwdG9qVEF6K0M3TWh4OWdTZDVmZXRJemxVRVN6MVJ1?=
 =?utf-8?B?S0FpMzlPcDJKc09YTU9pakNrcjUycC9vQWZFeGJtZktHSnFGTi9WL2svbDZa?=
 =?utf-8?Q?nOU1dZRBEfd6LiEQX5Dal7h75?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db0b550-e3ce-42a5-2824-08dc64b8fee9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 23:48:09.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6U1J7/6wgpJdve09NuNQnB2v3DjcRlYcyVLhqdBlELZOK27vklD7ZGMxVmUMddt11EyuUg40ASeQLLe8C/Yvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Hello Boris,

> Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups for kexec.
>
> From: Ashish Kalra<ashish.kalra@amd.com>

<snip>
> Why do you keep explaining in your commit messages what a patch does?
I will fix the commit message.
>> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/include/asm/sev.h |  2 ++
>>   arch/x86/mm/mem_encrypt.c  |  3 +++
>>   arch/x86/virt/svm/sev.c    | 44 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 49 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index 7f57382afee4..6600ac467cf9 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -269,6 +269,7 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
>>   int rmp_make_shared(u64 pfn, enum pg_level level);
>>   void snp_leak_pages(u64 pfn, unsigned int npages);
>>   void kdump_sev_callback(void);
>> +void snp_rmptable_e820_fixup(void);
>>   #else
>>   static inline bool snp_probe_rmptable_info(void) { return false; }
>>   static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
>> @@ -282,6 +283,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
>>   static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
>>   static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
>>   static inline void kdump_sev_callback(void) { }
>> +static inline void snp_rmptable_e820_fixup(void) {}
>>   #endif
>>   
>>   #endif
>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>> index 6f3b3e028718..765ce94e4b89 100644
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -102,6 +102,9 @@ void __init mem_encrypt_setup_arch(void)
>>   	phys_addr_t total_mem = memblock_phys_mem_size();
>>   	unsigned long size;
>>   
>> +	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> We use CC_ATTR_HOST_SEV_SNP for host SNP support checks, including RMP
> table viability.
Ok.
>
> Also, why isn't this called in snp_init()?
>
> If there's a reason why (I think there is) put that reason as a comment
> above it why this thing needs to be called here exactly.

This callback needs to be invoked as part of setup_arch() as it needs 
e820 table to be setup in e820__memory_setup() before the callback is 
invoked and snp_init() is called from sme_enable() in kernel/head_64.S 
(startup_64), which is much before start_kernel() -> setup_arch() is 
invoked.

I will add the comment here.

>> +		snp_rmptable_e820_fixup();
> IOW, point to the comment above that function's definition.
>
>> +
>>   	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>   		return;
>>   
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index ab0e8448bb6e..d999ff7f1671 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -163,6 +163,50 @@ bool snp_probe_rmptable_info(void)
>>   	return true;
>>   }
>>   
>> +/*
>> + * Callback to do any RMP table fixups, needs to be called
>> + * after e820__memory_setup(), after the e820 tables are
>> + * setup/populated and before e820__reserve_resources(), before
>> + * the e820 map has been converted to the standard Linux memory
>> + * resources and e820 map is no longer used and modifying it
>> + * has no effect.
>> + */
>> +void __init snp_rmptable_e820_fixup(void)
>> +{
>> +	u64 pa;
>> +
>> +	/*
>> +	 * Handle cases where the RMP table placement in the BIOS is not 2M aligned
>> +	 * and then the kexec kernel could try to allocate from within that chunk
>> +	 * and that causes a fatal RMP fault.
> Merge this comment with the one above the function and put it all there.
Ok.
>> Check if RMP table start & end
>> +	 * physical range in e820_table is not aligned to 2MB and in that case use
>> +	 * e820__range_update() to map this range to reserved, e820__range_update()
>> +	 * nicely handles partial range update and also merges any consecutive
>> +	 * ranges of the same type.
>> +	 */
> This comment talks about what this does and is kinda obvious but then
> talks about e820__range_update() and not the other ones. Just put the
> gist of what this is supposed to do and do not explain the code step by
> step.
>
> What is really missing here and what is not really trivial is why all
> three e820 tables need updating.
I will add all these details.
>
>> +	pa = probed_rmp_base;
>> +	if (!IS_ALIGNED(pa, PMD_SIZE)) {
>> +		pa = ALIGN_DOWN(pa, PMD_SIZE);
>> +		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
>> +			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
>> +			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +		}
>> +	}
>> +
>> +	pa = probed_rmp_base + probed_rmp_size;
>> +	if (!IS_ALIGNED(pa, PMD_SIZE)) {
>> +		pa = ALIGN_DOWN(pa, PMD_SIZE);
>> +		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
>> +			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
>> +			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +		}
>> +	}
>> +}
> Ontop for less duplication:
>
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index be17661fee9b..118dfe61f80e 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -163,6 +163,21 @@ bool snp_probe_rmptable_info(void)
>   	return true;
>   }
>   
> +static void __init __snp_e820_tables_fixup(u64 pa)
> +{
> +	if (IS_ALIGNED(pa, PMD_SIZE))
> +		return;
> +
> +	pa = ALIGN_DOWN(pa, PMD_SIZE);
> +	if (!e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM))
> +		return;
> +
> +	pr_info("Reserving chunk of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> +	e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +	e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +	e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +}
> +
>   /*
>    * Callback to do any RMP table fixups, needs to be called
>    * after e820__memory_setup(), after the e820 tables are
> @@ -173,8 +188,6 @@ bool snp_probe_rmptable_info(void)
>    */
>   void __init snp_rmptable_e820_fixup(void)
>   {
> -	u64 pa;
> -
>   	/*
>   	 * Handle cases where the RMP table placement in the BIOS is not 2M aligned
>   	 * and then the kexec kernel could try to allocate from within that chunk
> @@ -184,27 +197,8 @@ void __init snp_rmptable_e820_fixup(void)
>   	 * nicely handles partial range update and also merges any consecutive
>   	 * ranges of the same type.
>   	 */
> -	pa = probed_rmp_base;
> -	if (!IS_ALIGNED(pa, PMD_SIZE)) {
> -		pa = ALIGN_DOWN(pa, PMD_SIZE);
> -		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> -			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> -			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -		}
> -	}
> -
> -	pa = probed_rmp_base + probed_rmp_size;
> -	if (!IS_ALIGNED(pa, PMD_SIZE)) {
> -		pa = ALIGN_DOWN(pa, PMD_SIZE);
> -		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> -			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> -			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -		}
> -	}
> +	__snp_e820_tables_fixup(probed_rmp_base);
> +	__snp_e820_tables_fixup(probed_rmp_base + probed_rmp_size);
>   }
>   
Thanks, Ashish

