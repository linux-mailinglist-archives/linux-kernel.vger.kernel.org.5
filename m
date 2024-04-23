Return-Path: <linux-kernel+bounces-155540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC78AF3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502F31C23C30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E713D51F;
	Tue, 23 Apr 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tdo/VP4t"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CE13D50C;
	Tue, 23 Apr 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888920; cv=fail; b=Y/GYMGfkARA4qR4l3y5VL8oa75BV70rZ6t9YGyEcKGaHyVrNhvyJ8sgJloH6YMf+lFIL/1Yfs7TqZNs7WPEp5LMp++u0KWFumhlrzcwCX2pta7nOKTNCdPS7dLMDwwFJPzKFLEOJDSpcfveBNZBqdGQFjTgnM4EFH9EJRBxvoVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888920; c=relaxed/simple;
	bh=N5dDcgi/HkofmIeBhNWfU0PV0gBcBb+DTnSi4LJEQsM=;
	h=Message-ID:Date:Subject:To:Cc:From:Content-Type:MIME-Version; b=GFPSCrEmycT1fLWaxNe51rHDh7C9EURrH9sE0RwvLlIV1ij2X+SL5qcvYqfjV386GQFa9UlCfKtXzZTGfKDRzXdBnpVlgxWral9skb6Ycl3eRJFB7FMsSRUNJgOk3M6rQ2o2r5KXwliQ6jFdx8bHNkl1GcmgJxSxalDz7OUubvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tdo/VP4t; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeRTZoIuKAZsgS7P17y0JF1jMHbjIoynGpb/Cs6I4mAWZY0hIDuUgxV1JgJf8BBaSinE7t6rKMGSusolYt6HUb8ngFhdNltVtfLZe/h+nY1J+SyhxQbuJW+vvO7/nujnKoOCYzq2ezyB07LS70qs9CiWKnqurquxC1Y9ANOLWJGI4DtTryN+RyCrG+SKzlThOY0H6E22eUW5M9QQre2rH7PJKL4qI5a5eBXRpL54gvAuci7Reli5YNvlN9PUMzlXm2n37+5jCYnPNgSg7ickQGf9k1BhDYS4e5PmMLh3UGEP8sJGPJtk12/8oDEtvt+LDTGMIbjNfChky8L5KUqnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3DAb5A8+h46jv5oZv/F/Q3vHWoQqrmj4nNLPwhCZ7w=;
 b=dKhn1c+Wq+CEYd8KClU/UK7qcFTzgLZzBTq2+bQM3DPh/3QdXkpyTr5bO3Inh6KFqTADMp44zzZKhXMK08MZ5agOjzab+ZoFQKX53/ZCX3CIVu1d8uYD1Xzc0TS+JDb7zRPu1UARonFjcrdUOo0MG8yU83U09t+lOAbPhcnO4OKbSf8dHxTfegy+S0MO1OeWKR9ec2BB2bSfQ+9t927Bu3THAmUjNQtsstWYxjE0+R99vYF/Ca8siP6mfiqq/7a/u1gYBTaAVRdjw+2ihn4okrc1orhl9braaDwVDQ4f1sf/Y0jhzl1/L7irPf/kW8BytjqbewdtpZYC+nzAAEsPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3DAb5A8+h46jv5oZv/F/Q3vHWoQqrmj4nNLPwhCZ7w=;
 b=Tdo/VP4tZc0v4i0zPyXKmISsSycpTO5RQt8sjhLTdzmCLsh1V7DBGXihZzugMow/GlDlmXFvh49ZIlKWy9o2K+YQXTHYqJshYryHazPYpG3/UCWXlJ2ZdcC01rCvgrLmvx1VSzOH3KadEmLndxZdczXxCu3F1Ih5gwIya4FYjFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:15:12 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:15:11 +0000
Message-ID: <97731c94-99b0-46be-8b78-5dac8510f690@amd.com>
Date: Tue, 23 Apr 2024 11:15:07 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] docs/MAINTAINERS: Update my email address
Content-Language: en-US
To: corbet@lwn.net, elena.reshetova@intel.com,
 Akira Yokosawa <akiyks@gmail.com>
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: beed3d04-b019-44e3-4626-08dc63b08d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFJyZHhlaTFiUlVnUVFHbVJPSWR4Nzc1N1dqdStBMVo5QmJQanhId2F2aWpJ?=
 =?utf-8?B?SXIrVHdQRFpRYlhiVFMvWkhWYVNTZ1NkbnRtUGY1SStBUHk2Q0Nkc2tYKzlZ?=
 =?utf-8?B?MTdGRlRxaGtDZ3laTWhCOFJHV0hqdi9rSlpFOGhzenBLUTlLNzlxZzZnNUo4?=
 =?utf-8?B?ZjR0QXFwaWxXREtLZ0w1Qk5BeFJFMnJhYldCZ1hFUXQrNjRsbWtnVzgxKzhD?=
 =?utf-8?B?NzJ1U0NRSGc5R3o2eEtTVGlpdG1NOXBGOE1JeVd3V0ZRNjN1cWh6Rnk0d0Zh?=
 =?utf-8?B?cUY4MXhEaVlQNDVuUXltODF4Q0RJV29kcmxZR0RNTWxhbjk3WEppQ1p1MmE0?=
 =?utf-8?B?eEZBV3JJV1BIMEtmVGJ3c0hISkVqQklvbDRpV0FhMllkVFhSeU43WXRHbGhB?=
 =?utf-8?B?ZjIwWmV4MmJ1RTdNeHFyY0JwUExzL2oyMmVTazg3Q0tuUlRMbjBIQmtvS2Z0?=
 =?utf-8?B?U2taTVV0d3U3TGNVb2k0bG1tZWZ2N0hxaGNBMHZUYkU2U2hRK1UwNEJHL3hP?=
 =?utf-8?B?aHJvMHBKRjY1elhuMmx2TXlZbkpoOUphMGF5T0hnOXR3UkdlZ2xNek5EREdK?=
 =?utf-8?B?NVhNSmVsbU5USWwzTW9jU1ZPUnFraGhEK2dMZXc4WmtldXRsQUo0WnFhelp5?=
 =?utf-8?B?N3ZXL2RkenlYM0lnenJoVzZrQXEvQStuKzhkVllPNjlGbnFxMzQ0V0J6RUlO?=
 =?utf-8?B?RHk1REJWNzhQSlVBOU9pbUJFdWs4eU9tSVBWK1NEOU0vcTc5MEovakVDRzlj?=
 =?utf-8?B?WEthbTYrcktTUXhXVUtJUmVoUVp2TWFoazU1N0dRR3NGUWd5cFVMVDVlOUFj?=
 =?utf-8?B?ajNTY1ZkUGhCSTNuMHJXOGNBM0FZWWVOdTdrQTJrZnYweVZLNTRWSWUyQ2xZ?=
 =?utf-8?B?OEFIU0JNUEsxeFkvZ3MzcXJ6cjc5TUpWcDhtOWdJMmtqYlpWSmM5YnV6VFpk?=
 =?utf-8?B?TzBNWnpOc1p2R2MyajJTOTlxa1BqSEZQZ05jK0dvR2lvSDI1a1hCemZ3ekMz?=
 =?utf-8?B?WWxNK2svWXNMdFZRdjRRclBxaWxNaGkzQXRpL0pBRndoaWVzRGhNdTU3L1pW?=
 =?utf-8?B?K0R1MCs4QjFFZEY1LzNvWm1BOVdOMGwwMkF2UW9uQ1F2UkJBY1U2K29paVBL?=
 =?utf-8?B?RlVFem1iamhhU1AxMldwdDFvbTBjR2M4QU5HdU1abzUrL3I2amd1N0tGOWxI?=
 =?utf-8?B?dFdiT2pNSFIxcVNpUEl6M2pOcndlM2swdGhEL3hHcHBIcTcxdCt5QlFiMFRC?=
 =?utf-8?B?QS94Z1dON0lzUFBwYkowWS9jRVVySjU2ekMrbzVJMzcvTm1hRVFrNy9LL0Zv?=
 =?utf-8?B?dS9LRk5tbDA5ays0UlUvc2crSnZhYUlRV3hIYkdtZHRXZzdINW9SMlhuZGgy?=
 =?utf-8?B?MUdndm9Pa3Vwbnp2ZnZjNXVOWnQxRmJjN3V1RFBNZ01VSEdsdHVjMWhkTVhO?=
 =?utf-8?B?dzdEUEtMSEVYYUdJMUZUem1TYmI5bmRqWEV6NWlMRHFvR0NMQWZIa2Fwb0d0?=
 =?utf-8?B?RnloUGhGYStoS0lreDIyYzVPRHRNT3JlWTkvcGVVZUJoWFpJYXQ5bHozdkVI?=
 =?utf-8?B?UXo1d3dBdHFTUVJsblFyZmpncGM0anJTcUlTN3lHNDFXZElaV2MxR3ZHbkNk?=
 =?utf-8?Q?ATqDK/jHuHyLo9AP12WwN6TaI2GQWgRHWDGiRJ1bC9RI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXdQRkFuOVdiTk5VaDJPNGR6eEZXajNaN20wV0hqVVp0QUhydy9UZVNsTnlt?=
 =?utf-8?B?NjNnSUdoVDJwdmNWZmkzenlaNklyMEoraEcwZWhDU0VaTW8wTHlCTHdnOTRB?=
 =?utf-8?B?NFI4RzVoc0s0bDRMeEZlTWYySlp4UzcvV0VaeC9JNkRqZlR4YmNFNFJCQTJu?=
 =?utf-8?B?MC9nLzhVT0svRmhncWVwTzJmNDkxUTF4bVlLMEV4NGJyNHFHSWpZbFQ0R1J3?=
 =?utf-8?B?R1hXaTZGdjlQMUU1eTBqRWswZStWbTExSTM5dGlFcXR2WUdRRDZaNUxzRTdN?=
 =?utf-8?B?YkoyejNiZFJRRWt3Y2VCamR4UEYwV01IZkVSaE1wbFg0OGp2elpqWHIzeFEw?=
 =?utf-8?B?SEwzT25RRWNuQ2dCcnJ5SDJQdmxyY3QyOXp1dmw4WkZQTjlJeTlUU2I3SDZN?=
 =?utf-8?B?RmYyNC9sdVdGZks2b1l1bnRMcjF4VERBMHpNREtDN0RJUUR2MzdMUzg2ZXd1?=
 =?utf-8?B?Q203Zlc2VFlqQmo0N0hHeEpNM3hTU0dvTjN5RUlUcHRoT1lnTlNPZS92bU1N?=
 =?utf-8?B?ckh0Qko3RGlOTkE0dTd5aGdkY1ZnNmJaUmdhVW8vN21HOVE1WkZLT0EwcWFF?=
 =?utf-8?B?ZFp1UHJQdGlCRGZ3RHZwWHdrRzRyeHVZVStRcmN6L3lvb3N2UXZYU2VSK3dh?=
 =?utf-8?B?bjdKVFdySjZndVJyaHV6QnRzY3dOZmtRdElpK3hMQzRHQ3FZNkd5amVaZ2Rj?=
 =?utf-8?B?M1VJMGxFYmVMQlgxRFR3VlpWcmd3ZTVGTDcyRFE2RkZlbzc5dVFnUFZSQS8w?=
 =?utf-8?B?SHBtMU9jZkFyYy81bG40cTEyL2ZFQ1JhKzZRbEExaUl1SkVrUi8xbkhYSm15?=
 =?utf-8?B?Qi9EVVhadytLajFkTmFOdFppUDF6U1VILytoRFR3L3FiY2tzYTRGeUVjWEdQ?=
 =?utf-8?B?SmtkaHB4MFkrV1cwRFV4N0hkcUl4UkdkS2pBcEpQTjJ4MG9tTURTS3BZZ1U1?=
 =?utf-8?B?dExEU2FlQkhTMTZvMlA1clBKVi8zUWpQbXJCZERKMUNkQjdBNml1Z1MxTG5s?=
 =?utf-8?B?MFZnbGVmS2ZKakRuQzNKZGJ3ODVDMjNaNXd4SUVPbk82ZXBJSGtuRTVkRFFP?=
 =?utf-8?B?ek9GSUg1cXk1SkI3MXA1MEhTUzdNbXdzN3B1Qkh3OVRoNWVXblM4Skl3a0I5?=
 =?utf-8?B?V2FXdm9kOGJVeUlabWVocHN6aWFYSnBaam9yUGFRUmwvaU9ybldmV1BsTEl5?=
 =?utf-8?B?SzdUbTIzcWdaMVh2U2hTRkE2SWhRWGRNMXo3OUVvSngvUU9FeVZ5V1BPRjZL?=
 =?utf-8?B?S2xZZk5Ja0pqUnRIT2pNRkI3MnVEQ3VHN0dzMUErTU9sRGg0Z2lEc1RoWUJr?=
 =?utf-8?B?b2lBM0VpVjIyWXZhQ3ZjUlFDNE12REVTTnpBbWhqRmpGL2VHVTVNUVRuSUhQ?=
 =?utf-8?B?d1hxMm9NalhIcForRGM0akp5RktYS2NzbHIwUGQ4R3h5QzZRcUlIc2U5YWVm?=
 =?utf-8?B?MEYxNUE4eFdvUkRsYlkyNXYwd3dxalgzVGY2cEJxZnBabGw0YnFZYzNHOWVG?=
 =?utf-8?B?Sk96MytYeVZlcXE5S2swd3U0bXZRN3pVS1pZRWZFdVFoTkFROXp3Y1lzRGVv?=
 =?utf-8?B?eVpHVzZsc2c0OTB1N21HRmZkVTl3RzhRWTZuRkhHU0hFc2pEUGNqR1lDL21n?=
 =?utf-8?B?KzVab1liUnpURDkxNkQ0UmYreDNWOWVxLzBpeE94amFHdVExZjRBSVBPRmsr?=
 =?utf-8?B?MmNTbTRiNHZBRkUvMGRTSC9jcU1BZzVmQWlVUlhEbUIxNXJ0akJldHlYUG9Y?=
 =?utf-8?B?MGhaMFBGYS9NUVpZQ2tNQXlueWZqVzZ1SXg5V1FXV1Y2cTRQcDcvTkw3bzZi?=
 =?utf-8?B?eEZMakJ0Yit1My9DN0F5OHZnYnZhSmtNeWFNSWNFOVlnbHFVTjljZDlXY3ND?=
 =?utf-8?B?MU5BUHA3Yk96NEZUbFB6UHNTeWR6bHV0eFNsK1NoR016U2ppaFE0S1Q4cFZU?=
 =?utf-8?B?M0FQcVF5YS9IUnZVLy9NTHI4YXRraWFTMi9RYmJCb29EaHRQZVFGczV3bHZj?=
 =?utf-8?B?ek43NzY1bFErT004STJBOUhwQ3YydFFxeHpTb2pWTnBDRDk2K0xQY1FoS0E1?=
 =?utf-8?B?UG5CazZEbjhGSTlJbk1KdXdaMENPM2dDUG5iTUQ3aEJaaW1iOVFvK0NTeG1T?=
 =?utf-8?Q?l/SY33AQQaEd/zNOaVYQjT2ma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beed3d04-b019-44e3-4626-08dc63b08d67
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:15:11.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHeaHRQ+Y5KNijxdwynFlKtf0muQKiVizJgz9EGt9YriaV20k9CROX44Du85O3mwHw6CU6hUAO+bjWT2537BsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

In the near future, I will not have access to the email address I used as
maintainer of a number of things, mostly in the documentation. Update that
address to my personal email address (see Link) so I can continue
contributing and update .mailmap.

Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---

Change since v2:
- Fix .mailmap entry from <old-email> <new-email> to <new-email> <old-email>

Changes since v1:
- Update .mailmap

---
 .mailmap                                                  | 1 +
 Documentation/security/snp-tdx-threat-model.rst           | 2 +-
 Documentation/translations/sp_SP/index.rst                | 2 +-
 Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
 .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
 Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
 .../translations/sp_SP/process/email-clients.rst          | 2 +-
 Documentation/translations/sp_SP/process/howto.rst        | 2 +-
 Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
 .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
 Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
 .../translations/sp_SP/process/programming-language.rst   | 2 +-
 .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
 MAINTAINERS                                               | 8 ++++----
 14 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/.mailmap b/.mailmap
index 1eb607efcc6e..4bac5578426a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -113,6 +113,7 @@ Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
 Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
 Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
 Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
+Carlos Bilbao <carlos.bilbao.osdev@gmail.com> <carlos.bilbao@amd.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
diff --git a/Documentation/security/snp-tdx-threat-model.rst b/Documentation/security/snp-tdx-threat-model.rst
index ec66f2ed80c9..3a2d41d2e645 100644
--- a/Documentation/security/snp-tdx-threat-model.rst
+++ b/Documentation/security/snp-tdx-threat-model.rst
@@ -4,7 +4,7 @@ Confidential Computing in Linux for x86 virtualization
 
 .. contents:: :local:
 
-By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 Motivation
 ==========
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index c543b495c042..274ef4ad96b9 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -7,7 +7,7 @@ Traducción al español
 
 	\kerneldocCJKoff
 
-:maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+:maintainer: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_disclaimer:
 
diff --git a/Documentation/translations/sp_SP/memory-barriers.txt b/Documentation/translations/sp_SP/memory-barriers.txt
index 27097a808c88..153e57130775 100644
--- a/Documentation/translations/sp_SP/memory-barriers.txt
+++ b/Documentation/translations/sp_SP/memory-barriers.txt
@@ -1,6 +1,6 @@
 NOTE:
 This is a version of Documentation/memory-barriers.txt translated into
-Spanish by Carlos Bilbao <carlos.bilbao@amd.com>. If you find any
+Spanish by Carlos Bilbao <carlos.bilbao.osdev@gmail.com>. If you find any
 difference between this document and the original file or a problem with
 the translation, please contact the maintainer of this file. Please also
 note that the purpose of this file is to be easier to read for non English
@@ -18,7 +18,7 @@ Documento original: David Howells <dhowells@redhat.com>
     Will Deacon <will.deacon@arm.com>
     Peter Zijlstra <peterz@infradead.org>
 
-Traducido por: Carlos Bilbao <carlos.bilbao@amd.com>
+Traducido por: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 Nota: Si tiene alguna duda sobre la exactitud del contenido de esta
 traducción, la única referencia válida es la documentación oficial en
 inglés.
diff --git a/Documentation/translations/sp_SP/process/code-of-conduct.rst b/Documentation/translations/sp_SP/process/code-of-conduct.rst
index adc6c770cc37..a6c08613aefc 100644
--- a/Documentation/translations/sp_SP/process/code-of-conduct.rst
+++ b/Documentation/translations/sp_SP/process/code-of-conduct.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
-:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_code_of_conduct:
 
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index a37274764371..b5a84df44cea 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/coding-style.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_codingstyle:
 
diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
index fdf1e51b84e4..55d5803daf41 100644
--- a/Documentation/translations/sp_SP/process/email-clients.rst
+++ b/Documentation/translations/sp_SP/process/email-clients.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_email_clients:
 
diff --git a/Documentation/translations/sp_SP/process/howto.rst b/Documentation/translations/sp_SP/process/howto.rst
index dd793c0f8574..72ea855ac9dc 100644
--- a/Documentation/translations/sp_SP/process/howto.rst
+++ b/Documentation/translations/sp_SP/process/howto.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/howto.rst <process_howto>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_howto:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-docs.rst b/Documentation/translations/sp_SP/process/kernel-docs.rst
index 2f9b3df8f8fa..a62c6854f59b 100644
--- a/Documentation/translations/sp_SP/process/kernel-docs.rst
+++ b/Documentation/translations/sp_SP/process/kernel-docs.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_kernel_docs:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
index d66902694089..d47a1c154610 100644
--- a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_statement_kernel:
 
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
index 7c7dfb4ba80b..32a99aac2f6c 100644
--- a/Documentation/translations/sp_SP/process/magic-number.rst
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_magicnumbers:
 
diff --git a/Documentation/translations/sp_SP/process/programming-language.rst b/Documentation/translations/sp_SP/process/programming-language.rst
index 301f525372d8..ba2164057f45 100644
--- a/Documentation/translations/sp_SP/process/programming-language.rst
+++ b/Documentation/translations/sp_SP/process/programming-language.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_programming_language:
 
diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
index c2757d9ab216..18bb3413c3ca 100644
--- a/Documentation/translations/sp_SP/process/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_submittingpatches:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7980e5b1ad..6b7c08907cc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -997,7 +997,7 @@ F:	drivers/video/fbdev/geode/
 
 AMD HSMP DRIVER
 M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
-R:	Carlos Bilbao <carlos.bilbao@amd.com>
+R:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/arch/x86/amd_hsmp.rst
@@ -5352,7 +5352,7 @@ F:	drivers/usb/atm/cxacru.c
 
 CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
 M:	Elena Reshetova <elena.reshetova@intel.com>
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/security/snp-tdx-threat-model.rst
 
@@ -10590,7 +10590,7 @@ F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h
 
 INDEX OF FURTHER KERNEL DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
@@ -20701,7 +20701,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
 SPANISH DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 R:	Avadhut Naik <avadhut.naik@amd.com>
 S:	Maintained
 F:	Documentation/translations/sp_SP/
-- 
2.41.0




