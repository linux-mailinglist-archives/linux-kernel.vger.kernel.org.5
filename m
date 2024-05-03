Return-Path: <linux-kernel+bounces-167563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF88BAB57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A181F21AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE43152197;
	Fri,  3 May 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a8VLwc2v"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65817758;
	Fri,  3 May 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734215; cv=fail; b=Pk4LqgehxJwjSpLAPfwYlqUAihisSGjHvkNfz053ya1HQcxbGhYs64nCJ6e3VgQ6fv1/der7ITcIOnmowjcpJH3gwlFURaRnd6L3+r5DlmPyAaYkSj0APeTkAm/FYi+fZW6cxYnSRjuBa4cvLEpTxFeAR7MzSvhAAPCDdqj4odg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734215; c=relaxed/simple;
	bh=GAXnuzl9HHI93E4+IRObTk1pifpQBYUecD+P8pIBJHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NF7nIQZZ6YziJjwhFRLWZWOB/oD7UaoII5keNiPgYl5cf+5xZUFFhvetQpUqepd53OYhwFVQDNzTpeXDI8vuOCH7UwTT1XDBYqSfWU4V3aIVuXenXUZBrlnnPspH79okoLZ93evI4352XfS5e0MDgkuaRnxM2iSjecfZ0Jw5HMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a8VLwc2v; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKxSiztx273QYb0Coh1bf17TGha3C2ECEOtJnTOdeNuVV9pxIVo/gussipI98JotABLhfpwJ1HVPzul4lQKVf79DoOyj8QuUeD4QQHF+ZslKrjglIeSvJuo0zdHlNP1wNAoLluSfIUdT/A5qDy7F2MsBO1MS7Om0DnrT59Tn3nQRJ50qWgdeDCSo1nHlBatH5comfMoLU+JhR5qiLUEbqTZYimlFRaG01FTf6Re3CuCY9IZ8gKcua9HKY+ULaknYB+ySjgST8+zwfv4lp9jXZ4SjeMX2Vk3XBI4+g62O5LiBa0jf3phDsvCnopcEE+RN+dY1LzkC3EGneyGhAH0edA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAVYXV9DRUCguMRlxbkbg8tEO6atVTEYFEDlDc+MLps=;
 b=KxX93kf2w4AKRFGLutIDaLJDisO0gV/+ZiKQCmtXWfk6feq/V9Sgk9Fym8Pwdnp5g0iTp3zrEb5YjRW2pbHq8u2qa5b5GZhDCopPtLUvj6pttaD/b02fe9IqgRZlPDwTkkklpAJmKY9aQWXoUVEEm+NnPwnKJ6ybe0CsuGsABD2OQcge2Rx2y4+weqGTRoixy+7EuXdbulJVludrN8uhkSWqZcxKexVjcWMbo+fGQb7zBzmXquO0lu5aUqV/t6RIHgwKB0tv0Wt2khQDvU8TTnGxum+VsYZX3VAn073fltz+YwRWPlIP+2p8K4o0goC20usoV2Fttxmq0vsSA3ZuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAVYXV9DRUCguMRlxbkbg8tEO6atVTEYFEDlDc+MLps=;
 b=a8VLwc2vwUMTkHFloJwBI9Vbp5tSTm+CZB36nlDRvOPHL1jjsl6U9MlNZatmmZScDzeM50OccI4axC+JHV/iNuFvFawHUqpgZ/pJRVO9OAQhrNaJcoAQ7ZNOiSsVTRL294GTodMuW/gOAcRZn7pmWWMF0mgnBIPXcBZkknatXpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 11:03:29 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:03:29 +0000
Message-ID: <d5a045ec-5ab3-43fc-9625-82e8fca87035@amd.com>
Date: Fri, 3 May 2024 16:33:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: amd: acp: fix for acp platform device creation
 failure
Content-Language: en-US
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2685ef-08e4-4689-3c2b-08dc6b60a985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bi9BcXM2OTR6ZlhoRUhMMW9uRUthdXhOY2x1dGwybnBBeU55cnU3WUNVOFR2?=
 =?utf-8?B?dkVodWVtNTAxTmV5Mm1xbHVEWEZOVVJaSk1MK1FidWhtd0lDVVk0Unh4bUp5?=
 =?utf-8?B?a1Q3a202aHRpanZXUnI2RjlkSEtick5rOUg4bkJGY0U3OUxJdUtFUEk1N091?=
 =?utf-8?B?dkVCK3ZlT1pxWEwyaU9RWnFIK2lFS24yR1VENndJMllsV0lZSE8zRmR3bGtN?=
 =?utf-8?B?V0xXUkd0dUY0ZmU3UkM3NEdOSjVUMUhXQ01jTnJUTnZMcE9ZU1BxYngvbUp1?=
 =?utf-8?B?Yy9MaTJwK0UrNENPbDZkdUtzbjE3STZ6dVJOckxHUXFIemg0a0t6Rmt1c0Ju?=
 =?utf-8?B?N3BoVWt4M1RHQ0dHbUUyVUc3aURuVTNPZHhNTWppRGtOQktmS3V4SXlJbHpu?=
 =?utf-8?B?TmRCMWhHRFZObXcrUTBDTEF6RGRsVWZMMzB0NXhNVXlQK1RUVmR2MjJXQi91?=
 =?utf-8?B?alM2dDV4WTQxZnFpK2xWV2x4NXo0SExoM21FMWFTdlBVUFpFTVNhaFB4dlRa?=
 =?utf-8?B?RDkwaFd0MDQ5UFNOeGpWQ0tqcThxeDI4NTlQTmlwZ2xVaTR4RzNDUVQ1RXhh?=
 =?utf-8?B?UHR5d1FxMXZTaHIyUkFRSHFWSzdhR0h2YllPbUd1dUpEa2piRlNpS1dNOEky?=
 =?utf-8?B?bGVOWWtVRFRTUTBhZ2ZWU0N2ZCtMV2tBY2ZQWkdJc3ptNmNuK2ovcVVjSnpD?=
 =?utf-8?B?aG8yUEdxdXViMVI5c25zRlg3RlQ5VjB6S1RtOUszV3ZvQmg1SzdJazkrd0po?=
 =?utf-8?B?SFRuVWlxR2F3c1ArZE1MYm1kR0I0dDNQZVVUZFNQTU56QjIydThKdHFtVEtl?=
 =?utf-8?B?dUluOFhDTXpTbFcvWEdLUUtKa1FEV20rbi9RczZlRE1Pblo4NUtUSVRCNU9O?=
 =?utf-8?B?OTlEMXJaNEoveXVRZlBrWTVzMGxtRmtjRW9KM1U5ZnowWFZyN2UxeGZrM0NB?=
 =?utf-8?B?ZTZMMFI3dmR2Q3NaRm52U2trZDVWNGRSMncvZXZQb3hxTnRwUGFsV2E1VzY5?=
 =?utf-8?B?UjBGMnZTaVV6TU5SM1ZHWURhOHZiUSs5ZXJ5bkVTSTJOcU9nWUkyT1RqL1hy?=
 =?utf-8?B?UFpSYUdFYlB5U3BKdDNmNG5zc3VwbXhnZnRlMGpFLyt4QXRQZDdSNUFjVUFa?=
 =?utf-8?B?M3MydGI1L1h4QnMrNEl3YVVpK2pLRWVlV004eFUvdXdlZ0VoTHpUVnA2Sks5?=
 =?utf-8?B?RkZIM3ZJSS9VSkFlNk9EcFMyQkhvYXNYK1lzRXY4TGRzR0xtc1VMME9rLzJ5?=
 =?utf-8?B?NUJPLzNSMWZLMjM5em5DZDZhK0FFdVoybTlIOXU0MCswamxmNFptVnJJUlRC?=
 =?utf-8?B?MFBUd3JZSFpQVGVFRUhSam9KZmtoQktPalBoZ3BrTWFjT2NJSGIvcWxRVXZN?=
 =?utf-8?B?OTdBTDVXWUk4YTI3R01MQ2tWQi8zakN2d0NBQVgzNzJ2NDM0ZkdFa1crZnVN?=
 =?utf-8?B?T1QySGFiZFh0SjgydlArUEVpZ3pjbUZ4M0hDTU1DMmd6dG80aU83MFQ1T255?=
 =?utf-8?B?VHhlUTZOWWlEQVJEVm9QYkVBTlB2MHpCNEpQWTdtbzM2R2E4aGVka0RYMjdU?=
 =?utf-8?B?SjBURGt0bURTRTU4WWNXM0xJOGxvT3VuUUdDZ0J4YWhWMUxNZE90V1kyV1Jh?=
 =?utf-8?Q?Ux4gdI8/EwTGF/LBLtP9QIecSCAI4LrsH3mdSit3bltA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXdqUGZ3dmRIK3JvU1dlMG5xOFhmdGF2Sml6QTlrZlNjTjVVNUJHQldxT0Fu?=
 =?utf-8?B?S0hQZG5rcHdXczJRY1o5THpjNDBtejdiUjAwem1qTloxRkNNZzhPeS81a1NR?=
 =?utf-8?B?VnQ1blFZNy9IQmpNVGdEU0tmS1VUV2NrS3pLWXNWQTNCS0poMEVaWnpSdmhn?=
 =?utf-8?B?bG80eUhQSU9CdmU4VzVZMEhzbmt5NU1yTEtkdWFKVkw1MytURGZsR0w1UXYz?=
 =?utf-8?B?ZkNFY203TEUzVmZtaFlHMElNcStPcmNOZHhoKy9HdFVpU2R0Ylg2aFFQdWtI?=
 =?utf-8?B?V3N0NnluQXd6TjJvT3labndFQWRiZDlQQlNUZmFpbEMrR2tpM05adUgzUEJY?=
 =?utf-8?B?d1FlSXBJOGk4bTFIZFduaElvQXhaNnFSOG9GeDlYRHlFcmkvYktDL3g3R01P?=
 =?utf-8?B?VWtucnhyYS92K0RqTjIzZTEzdmw0c0lxaCtITktwcE05amErRFg2TXcwaWxI?=
 =?utf-8?B?YWwzTmxsdmNjRUd3Rk1sMUwyZ0F5ZWdWK0IvWDdSc3hvZDVXRWdHbTJEUVVJ?=
 =?utf-8?B?M0dNMURiSjRiQjlNZFFleXVTbmJKREloSW4xSEdYOFA1bHBzeXRRcHB1clFT?=
 =?utf-8?B?U2hnMWpWVCsvTXVsNWF1UUhXRnVnOHRmMzZhNHhTN2l5NldQM1MxbktEQmhJ?=
 =?utf-8?B?T1VLeXp6VGRGd3VWWWFpQ0FYZ0ZvbURCMUhleVhYYjNLTXNWcy9PZGl3QThN?=
 =?utf-8?B?MHRMMGRXVDdWaVRYTTRWUDBncUZtN1R2dzNuS2xHU0ZDMkRSQlJ4bE9TYjVI?=
 =?utf-8?B?OE5NSVZ5RnU2Y2U0dUFzNGxJN2F3cG9hbGdCRXNocEllb1l4a0ZMNUlFVkpT?=
 =?utf-8?B?Qm1TQ1JNTFpXcE9pV1I5eWc2Zjl2eEFvallQZ3dqYnJadWtqOTBlb0YxZ0tV?=
 =?utf-8?B?MWw5Ky9rNzZBVFlBWTBDYnRiRzQ5N1Y5cmZIcVhIYmdKeTY0cVUrWWlzMzdn?=
 =?utf-8?B?V3R6Vi90R0dZODFlYi9aYjUvdG9XS29Odk9ucGNMUHRuQUZlRkFuVkZSUWNR?=
 =?utf-8?B?TERoU2dNbm9qQ2FwWXFXL09lUGp6U1d2Um91MVFpdlhvMXN3YjBLbW0zZVNU?=
 =?utf-8?B?azRMeFVmTkc2UHNSdHlCMlhKVVB4R2hVTWllOFgvMXdYWUZzV3E0NWJqMHQw?=
 =?utf-8?B?TFRaSkRGRmRHVDNVTlRldGZZQnY4OVp1RDFyRXRiV2c5MXltbWpxb2g3MW5t?=
 =?utf-8?B?dHVZYkpQem5kbFB6WDBNZENpYkxEM3FPekI2L2hicm9ZS00vK2lDNDhFdUI2?=
 =?utf-8?B?eEpQWGdnMGR0V0ZUZnlSRlAwRWZlSjFYNGFHMmtRWUtRc0FhUHVWbVd1YWpv?=
 =?utf-8?B?SjVDa3pBUnQ5Y1lldmFOVWMzRGxYcXZ1TWtxajFQVjd3MmlhSjF5ektkZkZW?=
 =?utf-8?B?ZFl1cVFUbW42Z1hoUTVFOTRpcHBjdU9JNkZkc0Uzdzh5MlJYSTYxdFNEdTZV?=
 =?utf-8?B?RDMyZ1NuSlVYWlB3aXZ6VjNOcjA0ZHZac2J2Tm9RNkdaZDcwL0tqTW10NVFa?=
 =?utf-8?B?TUhHc3lxbUY4T2o1ZzFZV052Qmlnekkyc0dabmJkTm1PVGduVGpxMFRnUlp0?=
 =?utf-8?B?b1hsZjZWQnhncFM5Q2dHOURHdXVWNkdFZUpFY0wrR2o5d0FqeVM4cStjN2xF?=
 =?utf-8?B?WSthWVphVEkwb3hlbEk3c05HSlVVcU5KOHArakdweWhFT2E2NzBMbGl2cmsv?=
 =?utf-8?B?NmpSOUhkL0ErbUg4bDd4R0xjU0pyb0U2VTBqcUpRa0ttQVhXMTZRM3llNEVX?=
 =?utf-8?B?NkxpNk5VQjRXd3pJUzZHazlabWJhSlJnNE5oNkpkTGNlU2QzM2JMd2wxaTM5?=
 =?utf-8?B?TFlIQXlvUHhpS3FRNnRSNnhPdDM5OGJWNnVNTCtteEUvRS81WFJrWW41VEVB?=
 =?utf-8?B?NllOVXFTUm9OQW5IRVdIMXNnY3ZyNG9XUzZ0anNEZTJjYUNUT2pxSTRBTmZL?=
 =?utf-8?B?NGo3bENzUzhzYjhGUDdsc0NZWWcweWJYZklpWnpOS1ErRENDVExwMDhWZFNt?=
 =?utf-8?B?dy9GTXZUbjVJcm9iOHNaSnVtenpPUERHSWw1ZzJBei9QdFJmMnZ2b3NxblZQ?=
 =?utf-8?B?YzB0Um9mZitjbTBNc1l6cXpXYk5GNGVQRmphS0h4MWlGZ01KdGVmbUt2WmdX?=
 =?utf-8?Q?EtSlWrm82IZcx0H/iD7Hh8uFa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2685ef-08e4-4689-3c2b-08dc6b60a985
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:03:29.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovqUbtRxJFL2VzHzByHAwwrI7XRpqh70IjDuKCu6en2hfAgi3G7lluDfLHFuMCIDTeHhtG/VhOMDxRNhy6NZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

On 02/05/24 19:33, Vijendar Mukunda wrote:
> ACP pin configuration varies based on acp version.
> ACP PCI driver should read the ACP PIN config value and based on config
> value, it has to create a platform device in below two conditions.
> 1) If ACP PDM configuration is selected from BIOS and ACP PDM controller
> exists.
> 2) If ACP I2S configuration is selected from BIOS.
>
> Other than above scenarios, ACP PCI driver should skip the platform
> device creation logic, i.e. ACP PCI driver probe sequence should never
> fail if other acp pin configuration is selected. It should skip platform
> device creation logic.
>
> check_acp_pdm() function was implemented for ACP6.x platforms to check
> ACP PDM configuration. Previously, this code was safe guarded by
> FLAG_AMD_LEGACY_ONLY_DMIC flag check.
>
> This implementation breaks audio use cases for Huawei Matebooks which are
> based on ACP3.x varaint uses I2S configuration.
> In current scenario, check_acp_pdm() function returns -ENODEV value
> which results in ACP PCI driver probe failure without creating a platform
> device even in case of valid ACP pin configuration.
>
> Implement check_acp_config() as a common function which invokes platform
> specific acp pin configuration check functions for ACP3.x, ACP6.0 & ACP6.3
> & ACP7.0 variants and checks for ACP PDM controller.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218780
> Fixes: 4af565de9f8c ("ASoC: amd: acp: fix for acp pdm configuration check")
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/acp/acp-legacy-common.c | 96 ++++++++++++++++++++++-----
>  sound/soc/amd/acp/acp-pci.c           |  9 ++-
>  sound/soc/amd/acp/amd.h               | 10 ++-
>  sound/soc/amd/acp/chip_offset_byte.h  |  1 +
>  4 files changed, 95 insertions(+), 21 deletions(-)
>
> diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
> index b5aff3f230be..3be7c6d55a6f 100644
> --- a/sound/soc/amd/acp/acp-legacy-common.c
> +++ b/sound/soc/amd/acp/acp-legacy-common.c
> @@ -358,11 +358,25 @@ int smn_read(struct pci_dev *dev, u32 smn_addr)
>  }
>  EXPORT_SYMBOL_NS_GPL(smn_read, SND_SOC_ACP_COMMON);
>  
> -int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
> +static void check_acp3x_config(struct acp_chip_info *chip)
>  {
> -	struct acpi_device *pdm_dev;
> -	const union acpi_object *obj;
> -	u32 pdm_addr, val;
> +	u32 val;
> +
> +	val = readl(chip->base + ACP3X_PIN_CONFIG);
> +	switch (val) {
> +	case ACP_CONFIG_4:
> +		chip->is_i2s_config = true;
> +		chip->is_pdm_config = true;
> +		break;
> +	default:
> +		chip->is_pdm_config = true;
> +		break;
> +	}
> +}
> +
> +static void check_acp6x_config(struct acp_chip_info *chip)
> +{
> +	u32 val;
>  
>  	val = readl(chip->base + ACP_PIN_CONFIG);
>  	switch (val) {
> @@ -371,42 +385,94 @@ int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
>  	case ACP_CONFIG_6:
>  	case ACP_CONFIG_7:
>  	case ACP_CONFIG_8:
> -	case ACP_CONFIG_10:
>  	case ACP_CONFIG_11:
> +	case ACP_CONFIG_14:
> +		chip->is_pdm_config = true;
> +		break;
> +	case ACP_CONFIG_9:
> +		chip->is_i2s_config = true;
> +		break;
> +	case ACP_CONFIG_10:
>  	case ACP_CONFIG_12:
>  	case ACP_CONFIG_13:
> +		chip->is_i2s_config = true;
> +		chip->is_pdm_config = true;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void check_acp70_config(struct acp_chip_info *chip)
> +{
> +	u32 val;
> +
> +	val = readl(chip->base + ACP_PIN_CONFIG);
> +	switch (val) {
> +	case ACP_CONFIG_4:
> +	case ACP_CONFIG_5:
> +	case ACP_CONFIG_6:
> +	case ACP_CONFIG_7:
> +	case ACP_CONFIG_8:
> +	case ACP_CONFIG_11:
>  	case ACP_CONFIG_14:
> +	case ACP_CONFIG_17:
> +	case ACP_CONFIG_18:
> +		chip->is_pdm_config = true;
> +		break;
> +	case ACP_CONFIG_9:
> +		chip->is_i2s_config = true;
> +		break;
> +	case ACP_CONFIG_10:
> +	case ACP_CONFIG_12:
> +	case ACP_CONFIG_13:
> +	case ACP_CONFIG_19:
> +	case ACP_CONFIG_20:
> +		chip->is_i2s_config = true;
> +		chip->is_pdm_config = true;
>  		break;
>  	default:
> -		return -EINVAL;
> +		break;
>  	}
> +}
> +
> +void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
> +{
> +	struct acpi_device *pdm_dev;
> +	const union acpi_object *obj;
> +	u32 pdm_addr;
>  
>  	switch (chip->acp_rev) {
>  	case ACP3X_DEV:
>  		pdm_addr = ACP_RENOIR_PDM_ADDR;
> +		check_acp3x_config(chip);
>  		break;
>  	case ACP6X_DEV:
>  		pdm_addr = ACP_REMBRANDT_PDM_ADDR;
> +		check_acp6x_config(chip);
>  		break;
>  	case ACP63_DEV:
>  		pdm_addr = ACP63_PDM_ADDR;
> +		check_acp6x_config(chip);
>  		break;
>  	case ACP70_DEV:
>  		pdm_addr = ACP70_PDM_ADDR;
> +		check_acp70_config(chip);
>  		break;
>  	default:
> -		return -EINVAL;
> +		break;
>  	}
>  
> -	pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
> -	if (pdm_dev) {
> -		if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
> -					   ACPI_TYPE_INTEGER, &obj) &&
> -					   obj->integer.value == pdm_addr)
> -			return 0;
> +	if (chip->is_pdm_config) {
> +		pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
> +		if (pdm_dev) {
> +			if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
> +						   ACPI_TYPE_INTEGER, &obj) &&
> +						   obj->integer.value == pdm_addr)
> +				chip->is_pdm_dev = true;
> +		}
>  	}
> -	return -ENODEV;
>  }
> -EXPORT_SYMBOL_NS_GPL(check_acp_pdm, SND_SOC_ACP_COMMON);
> +EXPORT_SYMBOL_NS_GPL(check_acp_config, SND_SOC_ACP_COMMON);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
> index 5f35b90eab8d..ad320b29e87d 100644
> --- a/sound/soc/amd/acp/acp-pci.c
> +++ b/sound/soc/amd/acp/acp-pci.c
> @@ -100,7 +100,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
>  		ret = -EINVAL;
>  		goto release_regions;
>  	}
> -
Empty line drop is not relevant to this patch.
Will fix and re-spin the patch series.
>  	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
>  	if (IS_ERR(dmic_dev)) {
>  		dev_err(dev, "failed to create DMIC device\n");
> @@ -119,6 +118,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
>  	if (ret)
>  		goto unregister_dmic_dev;
>  
> +	check_acp_config(pci, chip);
> +	if (!chip->is_pdm_dev && !chip->is_i2s_config)
> +		goto skip_pdev_creation;
> +
>  	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
>  	if (!res) {
>  		ret = -ENOMEM;
> @@ -136,10 +139,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
>  		}
>  	}
>  
> -	ret = check_acp_pdm(pci, chip);
> -	if (ret < 0)
> -		goto skip_pdev_creation;
> -
>  	chip->flag = flag;
>  	memset(&pdevinfo, 0, sizeof(pdevinfo));
>  
> diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
> index 5017e868f39b..d75b4eb34de8 100644
> --- a/sound/soc/amd/acp/amd.h
> +++ b/sound/soc/amd/acp/amd.h
> @@ -138,6 +138,9 @@ struct acp_chip_info {
>  	void __iomem *base;	/* ACP memory PCI base */
>  	struct platform_device *chip_pdev;
>  	unsigned int flag;	/* Distinguish b/w Legacy or Only PDM */
> +	bool is_pdm_dev;	/* flag set to true when ACP PDM controller exists */
> +	bool is_pdm_config;	/* flag set to true when PDM configuration is selected from BIOS */
> +	bool is_i2s_config;	/* flag set to true when I2S configuration is selected from BIOS */
>  };
>  
>  struct acp_stream {
> @@ -212,6 +215,11 @@ enum acp_config {
>  	ACP_CONFIG_13,
>  	ACP_CONFIG_14,
>  	ACP_CONFIG_15,
> +	ACP_CONFIG_16,
> +	ACP_CONFIG_17,
> +	ACP_CONFIG_18,
> +	ACP_CONFIG_19,
> +	ACP_CONFIG_20,
>  };
>  
>  extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
> @@ -240,7 +248,7 @@ void restore_acp_pdm_params(struct snd_pcm_substream *substream,
>  int restore_acp_i2s_params(struct snd_pcm_substream *substream,
>  			   struct acp_dev_data *adata, struct acp_stream *stream);
>  
> -int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip);
> +void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip);
>  
>  static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
>  {
> diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
> index cfd6c4d07594..18da734c0e9e 100644
> --- a/sound/soc/amd/acp/chip_offset_byte.h
> +++ b/sound/soc/amd/acp/chip_offset_byte.h
> @@ -20,6 +20,7 @@
>  #define ACP_SOFT_RESET                          0x1000
>  #define ACP_CONTROL                             0x1004
>  #define ACP_PIN_CONFIG				0x1440
> +#define ACP3X_PIN_CONFIG			0x1400
>  
>  #define ACP_EXTERNAL_INTR_REG_ADDR(adata, offset, ctrl) \
>  	(adata->acp_base + adata->rsrc->irq_reg_offset + offset + (ctrl * 0x04))


