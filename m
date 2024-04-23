Return-Path: <linux-kernel+bounces-155806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA18AF765
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAF61C21FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF31411F4;
	Tue, 23 Apr 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GUcQJIuT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7928DC9;
	Tue, 23 Apr 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900726; cv=fail; b=qyX/Mz+DrmAYjazOyeLLR6x826i63rQsLY+NxpetNn1THhEDKJxByCFVX+P5ZvlvLqr4eAdBUn/tXY4ID52XSWV0EhrjC0rvdqySDvq4MOjaz24zyM4tuicPbJZ10AOnBC8F06STWpb0C/xsA4KoQZdMvXNI+vMMJwEIlTUZ9L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900726; c=relaxed/simple;
	bh=WZIH4M+wfXtwXC4tXN+DH9VtoVnQ0b7YBqsKap67unE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuFEXxJa8Hzve4ro6hYBQv3FNi6WpZAP6oTJsX3FCi0WYUci/isSseiua0STRASCHy/01+h8XAAi0QPZb6Jj1LzGXX22OYed2xoLwVsNkuv9AcgKZA2JbzQAskIorJkn8islLVj+zLflgzYDbUDP7u9FS56g0E7ockM6UGv1qM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GUcQJIuT; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnsbDwWAk8k7jDJtaP09nL/D0jU8hfZU9dtvKQRJ31PGeKs9Bc1t5mrqk1RnnWVdCAOzg0ZPD3W3xzTZQ7UoDlINqySiowy6V9RMdEfTiXXcqDs9cIZ4ZBmqEgGD9OCk2sRSAFz2nlZjMot5Vbvq2KZNgfgp8rZKxnBpuk5PM8gXRAqkEdl4xx/ILZxrCs7hEVnN/25ywQOLpAZ3r8y8ti9eQUNNdasrT17bwHdctYdQXse2W+aHqZUtd6vKQibUFb/dT6Lddku1igclI2Iu0A+HkUj6myJG/2PgopvTWo/f6y1STkz8bUH1SgsTz4QlHiA+cNvCxqMRBv7dGqUpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZT7jfD7ZkF+K0XjlAbq1Aaw2DLHJP7RFPvTwNZP+2I=;
 b=hXDTOzGvHt7Z1FQj/dq9IqV0Ru9ybaxhEQklDHH0PD6v2NdnMmiQxd+emnev3dqx1xt+FuLl7g8WKZnpM0ipoPTwV86UMfT6mcHlIxavnxFkYE/NI1pUpcW0TQ1iZS+7dd0jeV6Mpwc0TICECBxiY4rjGm4O3SVf8lC9HmCM7N63rWEpecy2PH9Wz0KJzWjwKwh4ju/C8xozHODQq+l+1XII9RuncICV5NMRtk7nTG+1cTlxK7BKNbuTAo/R4P0t347sZoWWhlc2yBiWG7PXcqC1F9AdtazpllI/F7JJYbeNAqOfrVR6l3IQ3MILU5d4ojiArDaSxo0rTzblDO4/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZT7jfD7ZkF+K0XjlAbq1Aaw2DLHJP7RFPvTwNZP+2I=;
 b=GUcQJIuT9TIW2c6M10AaZ77keSK2mcCbo8Q1yNDDM8AQ35c7GMSrLX5maS7nNL9HwMMzjpPIm6kOALi/DBrFFcIc5f4jmFqwOkdU9T3hqWlkTAzxoWae0gi5+3qenR69qmwgDvoib9+BH7WhOMI5Hs4vCvN87C7RjTfEIa4xfIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:32:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:32:02 +0000
Message-ID: <eb9c5d9b-07d2-4b56-98dd-c2616ef73a0a@amd.com>
Date: Tue, 23 Apr 2024 15:32:00 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 05/16] x86/mce/amd: Clean up SMCA configuration
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-6-yazen.ghannam@amd.com>
 <20240423190641.GDZigGwXXEPeDnfOsr@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240423190641.GDZigGwXXEPeDnfOsr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:408:94::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 25df4363-7637-4cda-b022-08dc63cc0d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnFZUzJHUzJnelNvNFJoeUFQTG5FVVBPV0dZSnFQOWxXV2h0cnVRUTJYeHR2?=
 =?utf-8?B?MzhUQ0drOFBpeVJPZnJLam1VQnJ1eDBYeWs5bExCbDduME15c0J0aW96ckVi?=
 =?utf-8?B?MTdTTTRDMG4xN1RYV0NpRDJyWTZtcHBNd3oxVlBXb3lhV1pmQzhvcW95N1Qy?=
 =?utf-8?B?NlZBZHErNEFmaGxsM1lvTVlTVTVkemZWUDlBNktOaWdRZjZsdzEyNEs1YjNx?=
 =?utf-8?B?bUlHak1WR2tsTjFoc0l2cEdsZ3lLWEtXTGhGVUVTZ2F2Y2ZIYVJGNytYeml5?=
 =?utf-8?B?OTYyU1dGOU82MGpXaDNHYitoU2tEZTFzdUxmZTNscmEwNTFIQlVYWlhmMWla?=
 =?utf-8?B?VU9RQi9IY1pJTWhIRU1NWHcra0lyU1MvMU9TV0JMTytFOFJZZGpsREI0V0Vw?=
 =?utf-8?B?TTYxTml5NHBmOFRtbmQ1cUhFRUhvQXRLditLOTUwS1k5b3QwVUt0WHp5aVRl?=
 =?utf-8?B?c1RJL1pRazYwUHFxNi9SNUdUSHRuaVVRbHpxSzZsTHFXVHhpZ1FDOEw2dGlU?=
 =?utf-8?B?OTRaMTRKSVRrWkEvVU9KWXlsaEhrb29RK2p0eDlqU1hHVGswcFZnVStkWDBO?=
 =?utf-8?B?d09TZ2hTc2xHcjdDOXI3MW04Ti9XRkthczk2UUZwUDdYRHpTWlV2dlJSQXdL?=
 =?utf-8?B?Y1JiNHJqaTVrbUtwaDIrNC9PdnZOUmg2SjNPdU9OMTlXdFpvV3dobm5GU3p0?=
 =?utf-8?B?ZU5HZzN2S0JiZHVkcDhOMXU4TFprek1hUEQrK1MxTGhyakNPVWFJeWU2b3FN?=
 =?utf-8?B?TG8wdkFjY2hTOG9zTSt4dWFET2hZajdEL1JabXBNZXZlRUkyQml4RktEdkYr?=
 =?utf-8?B?TUZyWmdtbzFjWE5HREFjdUZBZjN1Z3dpWDArdExnRE9LVmFJeDhteGo5dDdM?=
 =?utf-8?B?Y3BGRXpMMFNVUHFjeUQvL3ZtdXN0b3ZlanU2NThvSUZYN2prTHYvdm84SWRa?=
 =?utf-8?B?amFzbzBhNDVuK0gyWG5DMndEcU1JRlRXVERRbDRPZ1RmWlFtYi9NbVVpa25D?=
 =?utf-8?B?R3hkNUs2K0lyWW9jN0tHN0pKa0N0SDJISmxxSnFGZ2VVRG5CK0xEMTk3ZWJt?=
 =?utf-8?B?eFZJWWp5ckdUSjdDUkNVckhtVnh4UnJoWE95SWN0WENuTjVGNUF2VTEyM2Za?=
 =?utf-8?B?cUl4akE3aFhaN29pNGhIR0pGVEppSzl6V1M4RFNITis3ekwyVFJzaTM3ZExI?=
 =?utf-8?B?S3o3MllGYzZwV1Fjb3JzU3dGUHBsUjRhR3pnMnZ2ZmUyYzJ2cDRkaXlwYTF5?=
 =?utf-8?B?RG1IU1cyWnM5d2g5SUIvc1FvakRCc2tLVXlMeXNJdkRjNTBjbDdoeFlaREth?=
 =?utf-8?B?MWpmVmx3eVVCWHhFUGp5dGdUNFBlM3dqNjhpRy9GSm5MblRxU29xNXArNC9J?=
 =?utf-8?B?NXdMTCtsMDE0M24vWTdDMDc4Y2t0Vm9zSUMwM1F6a3VnM3NPMVI5Z0JNNlRC?=
 =?utf-8?B?WVNza0FnOTVFUDQ3VHV0ZzJIc3QzSDBZa1lpcU5admJMTnJHMS9EdWJVNWFZ?=
 =?utf-8?B?c3laNEVybmVOU1B6L2RhMnRaTUNlTDFMQ2dMb3YyV0F5RmF4ZVVmd0xNbEJo?=
 =?utf-8?B?c05UWVA2YjZ6WEI1VFFveTdhQTdweHB5R3BHdXVMNHQ4YTk4THJIRDJrdU8v?=
 =?utf-8?B?Q2daajJqVjAvZUtIZEpaZXdCYW5qU3ROZUZOR1dobzJsZ25BSDNtQno2QlYv?=
 =?utf-8?B?Zjgwb3BtVnBKK1V3MVJucVJEN1g2WUVWSmlkZDBnVmZwL1JIY1VoY2xnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkhKMUdscVI3clRyeVdzZDBRVGZXdkVUdlFJRk84OG5uaG14RFRES3VzT2Ja?=
 =?utf-8?B?SnNubERLV2RIc0NnaHVVa0ZWZ1RMSFRzdkVTQkZrVGtjYnFSRUMwbGxETkpj?=
 =?utf-8?B?eGlacnRzSWk0dzd2L3BKMmJ5RVk3d1NZcEQzVGoyODhrZUJiS2hMb1EraXdm?=
 =?utf-8?B?QXdaSFdSQTdBcEdRT25Yb0thc2xDNVNhdnhhWVZ3SmVIUWt1NkpGWmp4bHFM?=
 =?utf-8?B?a3J3Qkl5WkxjbUtYMXJBUEsxZXZCTFhCWVpkVzU4aDVjQ2c2UytnTFZvNklM?=
 =?utf-8?B?SWk0OFcwYWpheUUyTjV3VGZwd2kwa0tKTWZIWkdKM0FqLzV6UlNEYkFEUDh1?=
 =?utf-8?B?bkZMRHJ3bHZjK0NjMlZqK2QycnZESUdVMlUraGp0cmlzOG95MHZUbURRYndQ?=
 =?utf-8?B?N2RNWnduUjRCTkZiZFpaVUpYOXM1Q1NhV1dFR1g5bW94ZHppR0NSbjhyTm9D?=
 =?utf-8?B?QnJGR1l1eC9kaEIwS3YzUkdGSEpxdlB1eVdEV1I1U29BemUvWlFTaXNRNVgr?=
 =?utf-8?B?eHVSeGI5NzlJdFlmSlZ4TVFEV3FzVEZIRDEzclRYYnMxQnliV3VoMTJBTXQr?=
 =?utf-8?B?STlFWjZXRWE5dWhzeUpabmY0S1cveGJrWUcvWXB4VlpIUjNiM2lrWEZiYTVZ?=
 =?utf-8?B?ZnQzNjhjb29XWjFFQXZiSFowYURoN3dCV3JONVplaGp3d0FoQWFvbGJudWZt?=
 =?utf-8?B?WjRCZGl6L21wdW5hN29QMXZSd0xPY1drSE1jeXQ3OGQ3QjcxMnQrSzhRVVBD?=
 =?utf-8?B?MytZZENidWZPdTRTc2FqbnErRkZkVDJRbHdVbXRPaVhIU0s5eEtlcDZjR04w?=
 =?utf-8?B?MFo1VWZtTkxWRGR1Qm91b2x6NWphSzRmSDJlQU45S1JRUUt1bU8xSmpMVlh2?=
 =?utf-8?B?MkNsVW9xVGlrMU96ZmhHQVY3aHJNMnlhTVM5bmt1TXVpcGUrU1FRNVJuMEdz?=
 =?utf-8?B?ZFQvb0hFRVRDR1dIOFdmQmlOclplWTRFUlVBWW5ySVhabmNGQ0M2OXJiZUxY?=
 =?utf-8?B?ZWx2NHpUc05ETFJVZVlnaDc4RXVrTnVzQ2dwejdnOXdpZmMwSWVQamYvVzRm?=
 =?utf-8?B?OHZDaXBaS0V1OCtYSUVnTy9SQWg1QmIrSVJSeU84TlZwU2MyRWhGUnVudGN0?=
 =?utf-8?B?eEVieGNEUjBQaDdWV3lUeW5Vb0hxWFJoV0VFYzBLMHpZeHM4KzBVU0RWL1pK?=
 =?utf-8?B?cDhiZEhRblRjcGNVOVhMZDBvcjRDMFgvMXg2eWlQUUpnV3BLZ3VXSm1lTDdh?=
 =?utf-8?B?d3hyQWg2ZlNJdlViSDRrSnNGcFB4N2kxdkVQb3UxdGNZcnBIYXQ4NGkwVmNM?=
 =?utf-8?B?SXNzbFhnR3Z1QzRUU0lQbmNWd1BESURNa2laQVoyUVMySXBQL1JMazEvcXJj?=
 =?utf-8?B?VlFQTzk4aVM3S0Vld3NURktudUtyV1FjcDV0SGtYSk4zdkdpanc3cWFHMHdQ?=
 =?utf-8?B?Y3F3S2RITUhNK2FrdVMxbVdmYkRvNlJkNDhJaTBOQlBYREN2MTgyTmtQQ25i?=
 =?utf-8?B?VUtpdVlMOWRBc1h1L1hVeDd5TFpsZmlBeDBucUxIV2RnV21FUUY3cCtVd20w?=
 =?utf-8?B?KyttVE5WNGVvNTBsdk9zNUtpckdRaTlNNXNSSGc5bVRuK2pIaktiNEdKOHEv?=
 =?utf-8?B?UWpMYmRPeFpENkpLUEdsb3E5WnJTL2lXODZ6cVJ3NERBWkk2c0V2Y1VPUkdE?=
 =?utf-8?B?enMyMTFMK0g5ZjBrQkdTdWxxRUtXVGZNMzBsa2FXcUhvaER2Z1hBSktkbEo0?=
 =?utf-8?B?eStIWDgzNHQ2c2pqaEFzd09pL1p2UUhWdklPQ2JWZyt0TWhBRDJEc2laSks3?=
 =?utf-8?B?dGR0MG5VUU01M1FSR05rOCs0NUFtemhJazFJajUxRE16QWwxbEFrUjZ6Q2Vy?=
 =?utf-8?B?UHN6UTUyTFZPSisvenIvYUhxVkRpMElEK2Z5cVJMR1JQNFE1SjU4V2JWeGZ5?=
 =?utf-8?B?VG0wci8vbU1iYTRtWVd0cmIvUVZ3RFVoaWdZbDg2WWRYaXVBVkZ3TFpTOER2?=
 =?utf-8?B?WWkyN1R5NTVxeVVuQVByajB6dzVJUUllWm9qdkFVNm1iNHEyU2daZlJPQmNP?=
 =?utf-8?B?TFl1K0ZlVXY3WjhldHBIY25wL1llaWxqY1dVSFIrQUVXQlBoYU5EYWFkK2Vt?=
 =?utf-8?Q?mObSAUg/FYRZIcIhnRY+vx1GD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df4363-7637-4cda-b022-08dc63cc0d05
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:32:02.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn29l8SxusTXxNGybwtm9A+7+VpjbeufqlL6r09neNha/7KejhGWArLG3fnYvhpazb3FNh7PAo5+otB7GAnmTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

On 4/23/2024 3:06 PM, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:48AM -0500, Yazen Ghannam wrote:
>> +	/*
>> +	 * OS is required to set the MCAX enable bit to acknowledge that it is
>> +	 * now using the new MSR ranges and new registers under each
>> +	 * bank. It also means that the OS will configure deferred
>> +	 * errors in the new MCA_CONFIG register. If the bit is not set,
>> +	 * uncorrectable errors will cause a system panic.
>> +	 */
>> +	mca_config |= FIELD_PREP(CFG_MCAX_EN, 0x1);
> 
> Can we please drop this cryptic crap?
> 
> 	mca_config |= SMCA_MCI_CONFIG_MCAX_ENABLE;
> 
> if I trust the PPR.
> 

Okay.

>> -		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
>> +	/*
>> +	 * SMCA sets the Deferred Error Interrupt type per bank.
>> +	 *
>> +	 * MCA_CONFIG[DeferredIntTypeSupported] is bit 5, and tells us
>> +	 * if the DeferredIntType bit field is available.
>> +	 *
>> +	 * MCA_CONFIG[DeferredIntType] is bits [38:37]. OS should set
>> +	 * this to 0x1 to enable APIC based interrupt. First, check that
>> +	 * no interrupt has been set.
>> +	 */
>> +	if (FIELD_GET(CFG_DFR_INT_SUPP, mca_config) && !FIELD_GET(CFG_DFR_INT_TYPE, mca_config))
>> +		mca_config |= FIELD_PREP(CFG_DFR_INT_TYPE, INTR_TYPE_APIC);
> 
> Ditto:
> 
> 	if (mca_config & CFG_DFR_INT_SUPP &&
> 	  !(mca_config & CFG_DFR_INT_TYPE))
> 		mca_config |= CFG_DFR_INT_TYPE | CFG_INTR_TYPE_APIC;
> 
> Plain and simple. Not this unreadable mess.
> 

This is not the same.

"CFG_DFR_INT_TYPE" is a register field.

"INTR_TYPE_APIC" is a value. And this same value can be used in other register
fields.

I think it's fair to just use logical AND for single bit checks instead of the
FIELD_GET() macro.

But the FIELD_PREP() macro does help for setting bitfields. I think it's
clearer than manually doing the proper shifts and masks.

> And use proper prefixes with the register name in them:
> 
> SMCA_MCI_CONFIG_
> 
> or so, for example.
> 

Okay. I was thinking to keep the names shorter since they are only used in
this file. But I'll change them.

>>  
>> -		wrmsr(smca_config, low, high);
>> -	}
>> +	if (FIELD_GET(CFG_LSB_IN_STATUS, mca_config))
>> +		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = true;
>> +
>> +	wrmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_config);
>> +}
>> +
>> +static void smca_configure_old(unsigned int bank, unsigned int cpu)
> 
> Yah, at the end of the patchset there should be patches which remove all
> the _old things. Not in a different patchset. You can split things
> accordingly.
> 

Okay. I'll include the follow up patches in the next revision of this set.

Thanks,
Yazen

