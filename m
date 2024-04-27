Return-Path: <linux-kernel+bounces-161162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1DE8B47D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EEB2819EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07180144D37;
	Sat, 27 Apr 2024 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hH6SOZ1u"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484C3BB47;
	Sat, 27 Apr 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714249496; cv=fail; b=lZU1K71wsS3f8+6XLLDOKgWE04DXEX05fiNropW1VV5Kcwg1KANzF74zCvePZzoUq5LjwRSAe6Kn3Qhd1jZuskoiNFuO8BCG+YsddIor54s8c4+X9Whm+ku8yrz46deoR+d3Dvj3HA4M8qktIYKSvWUP2knd/DURn/0NLckDo0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714249496; c=relaxed/simple;
	bh=TVDA3R7nuhQBPDavMNBeOsvSlPjMRE0bYwG8wUvZ+sM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHTqDNdWBxSIAinwpglhdAfcgUI3DtvF/5pVdpMwUg+B+sZROjwQXzN/CrJMI2tse0tek2dYqGUx3pQf+Y3MEskcKBXfAPlCxuY8Q5ArxGPlwdx3OwSxfgWMyigPE+Ud6eSUFZcSmCK1VW4c4PpT0hdasX5tmBPCXZuSlKphGKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hH6SOZ1u; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6keZ4uJfhu6UnCjazUV862mXPnfPzXACZJTSLh9rtF4lr5Zd5nDyJ66GWy8qFam1PfMnjkC7GcSF44wYBLA7Pl+GpqUrfvslS+aD6dScdxpw5XHMjhn4rzSYfxmE68+0q5Bw6FKWv5rqqLE4vJP0UDov+bUFcbQXpo8sILEtK9mGbJ7vDTKBjmp+Diw222TcdKR+btgVp+fTdEKuzFiBe31k4CeYDvIg/FcJYTfDhrCkUPXaXeA9RFpamZpAFRPOIEqpolQk51xnbtdts5phPjy3w77vtLzN+zmcz2My6GFYBtX1yU+zzkYwfITY+iBjjHXik+XSXUuMhAR/rfIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWJhc6Q97ljLkDz4o2wDvHhYMZkqcM+G2RWmEDELIXI=;
 b=dwu9piao1s+D0oEOO9FLN2SQahVQFStPAa2mFg5FzXrECFrnh+QVOhDA/u0Mf7CkHISXJSMAMKP0WtMtEl0WqdS9sKzAy5AC6Sgrm4ElSi/Ob8WLpFukphx9h7PTV2EAPjaG1GT5xHxaSpco90E18h0N0kWBK2tITCStjPbZzg+GDoiAKXz69SRXbrNBIYAaoBHzNbH69vVkj/HRwidZxg3FPTK+3C5fXK41P84IfBTK4vi/QIc4Fwhn3lSexrM+MJ490ZICZAwJ69QIKSYlLIr8+KfD3W9SqSzeFdffev2y/MEiqlDRUtKAKvVuWKd7a/47Fr/ChITu4vO1bkOidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWJhc6Q97ljLkDz4o2wDvHhYMZkqcM+G2RWmEDELIXI=;
 b=hH6SOZ1uk58CsE305kQVIaNMwajzMAmF6WZGYW4FNc3olmoR0ryY5pPCJdB8014oB+o6IMSCsyZJJs/drOvFUFFlVAf9/XxKbgPlPInQZgQcOV9QYr623DefXuX5AMDnWIsNbYG8AeL0D2gESIHrV2xw/zO4F2E6V4Y3M6a2Mhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 20:24:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Sat, 27 Apr 2024
 20:24:48 +0000
Message-ID: <ba4d1d2c-2fea-4578-a1f9-d4142f7c5e55@amd.com>
Date: Sat, 27 Apr 2024 15:24:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
From: Mario Limonciello <mario.limonciello@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1714112854.git.perry.yuan@amd.com>
 <64eb440fd48d10a55525253bce2e9143db872f67.1714112854.git.perry.yuan@amd.com>
 <83f93e72-b03a-4167-ab96-0a6f8017e54c@amd.com>
Content-Language: en-US
In-Reply-To: <83f93e72-b03a-4167-ab96-0a6f8017e54c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 219b5f2f-e4f8-42e9-83c7-08dc66f815e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUJIMzlLSUhmRVhpTkdzNVBaUkpRZ3Y2K3RZYktnT1RYNXhDNDZSZzlaNllC?=
 =?utf-8?B?OW9kbzZjSmtIZ0FseURXdk9nT3luNEhWMU8zR0ZwMXNRckl5TTNWNkNkbmZI?=
 =?utf-8?B?cCtPbDdNNmZid2o2azZXbS9BTkpiK1kvUVFDd2IvVUdWeTVKdzkzZ2U0L3ZT?=
 =?utf-8?B?d3ZXUVc5RXlmWmR0QVBUWDBzcmZBRGdTUzlUb0RhRHk5ZE1oZmJ2K2xsWk5j?=
 =?utf-8?B?WWdyU1A4OElDWTZwUlBxajlGRVRaREVrUmQ0Q2xmOThoN1ZEbEtyVW5JeWZK?=
 =?utf-8?B?WldhU3BoRFJNLzFRNDhaZlg2TnZIMTFYc1dJUXpsN09LNHQzNytJYm5iR2p1?=
 =?utf-8?B?dGRCTkZVRWptdkF0K0g0c3VTOGN2L1JrdXcxMU9Tc0oxMFRyQVZYdGthZFQy?=
 =?utf-8?B?RDZWTjJBNWFzL1UrMGVZWmlJenQwcXdVQWtCNzFOY2hzWEdhQUszcDd6dThD?=
 =?utf-8?B?Y3hDWFVUNUU0Z21zTmlUUEMxQkNpbXVTZkhFeHQzVGhaRkk5UVhPSmZHdzNL?=
 =?utf-8?B?RFNDYjErMVc3SW85QkRUMFZaRW5iN2NPcG9Ccm90SGtsTXptcCtSY0xjTE1L?=
 =?utf-8?B?VmlNbVBGcUc1N3F0VUJGY1JMTjJTUnRIcVRVUGdjcndZaktEWFRkMmVOSVIw?=
 =?utf-8?B?N1FWU0lYaEljbFpsZzg2cXJXSzZUM1BwM2VoUVJBVFFUYkpBVGV0MUQ0Y3kr?=
 =?utf-8?B?T2Yvc2pEcnFKM2ZxaS9JT0FKWGdsbFhYdFMydkY3MWdidkVoLzV2YVJwRTc0?=
 =?utf-8?B?bnEyelRUbmZpdmJNUlo4WXhOREJkdDFOSzJkVDg4cTY5MktacDVCaXdLOUU3?=
 =?utf-8?B?ckhsZDZPUzFOQ0hRNWFmRW9lMmY3N3BocHVWNWJYUE0wUUFOckg0ckVJcXY1?=
 =?utf-8?B?Sy9sbmZWM3Y1WEY2SCtlNEN5TFVyVm5zMjNHVjRmb2RKRmFqRjhUSzZ2ZS9E?=
 =?utf-8?B?R01kZGRTcXZuVVhPN3pNbnRqWXk5QU9rWmY1WnpXQkZvUE9zSXg5Q3B3U1Uv?=
 =?utf-8?B?Z2J0RHVhc2NkTzR1MFIwMnlGeUdvUlZjWENoMnJnWXIvUnR6R045R1oxUUxM?=
 =?utf-8?B?L21oUGljbFFrcDdFdXFuWnFBNlE1ZmxkMDFEcHd0d3dLS0o3bk5DZHRZK2M4?=
 =?utf-8?B?VTNmWTVGNVh1RnUyQm1VU01QbmtvV3k2LzJMNmlCL3BqdVZWZkJ6akl3alQy?=
 =?utf-8?B?elNsc2Z2MSs3cjZtMytWQ3NINFE0RVNCMlowcHd2K3Eyc25GQ3lPMnUxK09z?=
 =?utf-8?B?RWJObGRXcU05dGcrS3ltaWpFZytSejhvZG04TWFHaE5Cck81dGxOY1pHTlcx?=
 =?utf-8?B?cXc2OEtpenlWbWJRMGRUdExQR0dqNXJqRnJSbmRNaWJicnVoamR1RjdzRXhv?=
 =?utf-8?B?WFlZMlVFaU9yOHRMbEkvVjNaVU91MnZJaG4zd2hqczFmYVFkY01QR0tnMTE5?=
 =?utf-8?B?QnROc1RaS3cvTGRURUU5ODJkakNTQi9qb2FWTGdRTjJUVEhRZk5RT2lLdyto?=
 =?utf-8?B?a3ZKTEtYeURWTTFjbjdLT2x5TVkzbC9yamIwMDh2ZTFTVlArWjBhYWw4bnZ5?=
 =?utf-8?B?bTlBMXl2ckJoQ2d2MzN5YW5EMDVwckNtYWhBeWFaTEtNamxta2IvQ0ovU21C?=
 =?utf-8?B?Y05yVlMwRGJIekFUQTErUmJkOGZkcTVsMElwVkZqamltVUlFUWpwaEhNcXh3?=
 =?utf-8?B?VkhpQ3BJUTNWVDlSSVBNbEhnSkdEVGcxcEhSSVd0bGhTK2lXeDh2QzdQZjJZ?=
 =?utf-8?Q?6rqf3tsrE3bHIkJLfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWR2WVlTV01kTTFTeHBTVXB6MzN4UnltMHBFNmNjb1dFR215cDd6SVFxMmdI?=
 =?utf-8?B?QWYwZnlscWxzVkhlWmpVL3QwMGgvamtHQlIyZFdFb1lpWWJGS1MwZEdGRHA5?=
 =?utf-8?B?akRyVEFVVTg2d2wyWGN5V2pMTlZ1Y05ZRmlCQ08wRUdMSlpvSUtHelJOL0ZR?=
 =?utf-8?B?bjJGc3Z6UlNHYmhKdWRRclYyVUNVYWk1SGdCMUEzcG0wYkk4bnpjeHVwYnEy?=
 =?utf-8?B?Y2s5WnpRMzNjMXRHbWhKVjBMMXpUbVVydmhzb24xaGhVSTdVUytNamQwVkdS?=
 =?utf-8?B?RjR5aXNwQ2daWHh0dFNuVlc1Qm1MTFJzcEZGdTFVRDFaam1HYlVYZk83YVNR?=
 =?utf-8?B?WmNCVmRJK3NXZDVrK0tXQWgrZHBab0JXNEs3TktIdzVXMDJhT0lLTGpGNVd1?=
 =?utf-8?B?Z1BySnJsM3dFME14VzhuWkptQXovZ01yWnBzN3VkWnVvWlVBNTg1V3JieEI4?=
 =?utf-8?B?VHJzOGQwc3FBeU4zK284czZrSTNMc1o2aXI3SENKNzFNNWt1ZVJMRFkrSExt?=
 =?utf-8?B?aXcxbGlqd0d4bzZ3TzVXVCtyYnF1b1h1WTgrL3JYSE9QUEtGMnpyYmNlZ2I1?=
 =?utf-8?B?aVFwMi9tY0hkVlJ6NDVLdWVqWXptRnREVnZybjVSUkZ3Z2M4NzR3QUJZZlZt?=
 =?utf-8?B?NG1hSVdOd2dsMWlUSDBQVktqTWIrYW1BUXhCTU1OVTJMYzdhVWZPWDRBMHht?=
 =?utf-8?B?cHE5VUwrWnJKb2FxcnY4VkdVR291dkNocVc0UVhuaWdqbzJwQzBBeTRsZjYy?=
 =?utf-8?B?bHAvZHRxNExtRUdmY01KK1lLM3g5VS9DZC95Nkg3UUZrNVFqZXUwY0crYjMx?=
 =?utf-8?B?U3B2d1FqaTJhNE5xcEF5SzF1OThTRk5hVFF1eTZ4djRUVmJMMStWMHcxNG9i?=
 =?utf-8?B?RmtmRmJqRUpiQ1pyemhGMnQraFZLdXBFa3VmaXhSYkxLNVVNS05ua1VBU01s?=
 =?utf-8?B?KzVkNHVTbmlUc1hRSUxwN3pVeGpsUzRZc29rRENYbm8rQy8zZStiKzE4WFQv?=
 =?utf-8?B?N0VlOGZkVEFDS1RkejZsMnBNYmZ6cG1LN2djd05LeFZaMHhqZEVqdnMzU3hY?=
 =?utf-8?B?MVNLbTFoRTVsalJhZnpVTmozdFdFdUszcmhIb1BFNVRUYjhONTErZkRaNlRp?=
 =?utf-8?B?dG54b1YwY204amFxdStTVHZKZnFMOEp4aGxzdExZWkJGc3gvUll6NGQ3ZHRY?=
 =?utf-8?B?SlJLbER5WUl6SkhaVS9ZZXdrWE5pcG9TdFVGR1NaNTEyRjlHTUt1c1FkNEhS?=
 =?utf-8?B?WGpmVGp3WU0zbURkRmxCZVZCSlExUjVmM2NwYXN5cjB0MUNCbU1VdzZMOFpa?=
 =?utf-8?B?T1plMXRKNlF3SkFzZVNZcGFLRWZ6SnBqNkFGTG5mVlZmTnA2RUJaRkRHbHdO?=
 =?utf-8?B?Z2tmNzFHTVVxRHdDMHExZTgwWXFkN2pCZWNzNG45YXVUeXhCeE1vTjZMMnYz?=
 =?utf-8?B?SG5EcGpSdUJLZ2F0c1FqK3h3YW5hdHBRa01ZZ3lvN2wvZk0wOWJCdzVOMDVv?=
 =?utf-8?B?ZDcvRlNpVWlWcXlmVk1GR0NGN0tCR3NvOEwvdWV4WjZEMlloSzg3RjFEL21H?=
 =?utf-8?B?S3o0L2RpK2dMYWEwWERiMVNLeUlXVmc1M09ENjdmZVE2aEdvY28zckhhc09o?=
 =?utf-8?B?Ky9tYURhbnFWMklnOU1DbnY2bDM4M0Vmd2dpVFhPVk5pVk4vZ05MUjZUbWp3?=
 =?utf-8?B?MDJPMzhvaWQxejBKdm1TNHNacnRwQVVhRi94dVpsWG5NYVlpUENQcVNDMDla?=
 =?utf-8?B?OHJ3SmIzejFxcS82WG9uQlU4eW9aTDRzbTExVGE5YTAwSEZmaDl2L0g2cVBC?=
 =?utf-8?B?K3YwcDVvb0xuWTBVb3FKK0FSajF4TU1zWENTOEFOWDZFTUNqVzFTWFZJb1I5?=
 =?utf-8?B?bFkvZjRNNCtPYXdNdFRST3NvdXRnQkdOSElwMHMvczJraEtlSUlHM1g5aHlh?=
 =?utf-8?B?WnVNeHYrVjFXTFhDcGR0NU04OEtDVTcrRkczU2pqd2pxc1NNSTNqcXJMZ04z?=
 =?utf-8?B?NjFMVS9tTGZxRkJHSVVOcGxMd1FQcis5dTIzUHFGMDd5Y1Y1WDBoa2cyK1ND?=
 =?utf-8?B?YVJtTUlvZzhNNXFzalBYTmFBMXQ2NjE0bXNlKzQwWW14TjJRVVhOeHY0L2Jn?=
 =?utf-8?Q?zqWlNxcGDqF6P4nUlJKbljY/r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219b5f2f-e4f8-42e9-83c7-08dc66f815e7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 20:24:48.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCnUPbLxuCVb6DxZ0gmwwptgjFiY8IVYdkxywnDF5elJxmX7tdfI9Fp2Fv9GQ9vcRGA1OXONKTS5fKUfsRwoAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777

On 4/26/2024 09:07, Mario Limonciello wrote:
> On 4/26/2024 01:34, Perry Yuan wrote:
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> With this new sysfs entry `cpb_boost`created, user can change CPU boost
>> state dynamically under `active`, `guided` and `passive` modes.
>> And the highest perf and frequency will also be updated as the boost
>> state changing.
>>
>> 0): check current boost state
>> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
>>
>> 1): disable CPU boost
>> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>>
>> 2): enable CPU boost
>> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 99 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index aa17a3134497..53ef39c6dbfa 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1295,6 +1295,103 @@ static ssize_t prefcore_show(struct device *dev,
>>       return sysfs_emit(buf, "%s\n", 
>> str_enabled_disabled(amd_pstate_prefcore));
>>   }
>> +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
>> +{
>> +    struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
>> +    struct cppc_perf_ctrls perf_ctrls;
>> +    u32 highest_perf, nominal_perf, nominal_freq, max_freq;
>> +    int ret;
>> +
>> +    if (!policy)
>> +        return -ENODATA;
>> +
>> +    highest_perf = READ_ONCE(cpudata->highest_perf);
>> +    nominal_perf = READ_ONCE(cpudata->nominal_perf);
>> +    nominal_freq = READ_ONCE(cpudata->nominal_freq);
>> +    max_freq = READ_ONCE(cpudata->max_freq);
>> +
>> +    if (boot_cpu_has(X86_FEATURE_CPPC)) {
>> +        u64 value = READ_ONCE(cpudata->cppc_req_cached);
>> +
>> +        value &= ~GENMASK_ULL(7, 0);
>> +        value |= on ? highest_perf : nominal_perf;
>> +        WRITE_ONCE(cpudata->cppc_req_cached, value);
>> +
>> +        wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>> +    } else {
>> +        perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
>> +        ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>> +        if (ret) {
>> +            cpufreq_cpu_release(policy);
>> +            pr_debug("failed to set energy perf value (%d)\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    if (on)
>> +        policy->cpuinfo.max_freq = max_freq;
>> +    else
>> +        policy->cpuinfo.max_freq = nominal_freq * 1000;
>> +
>> +    policy->max = policy->cpuinfo.max_freq;
>> +
>> +    if (cppc_state == AMD_PSTATE_PASSIVE) {
>> +        ret = freq_qos_update_request(&cpudata->req[1],
>> +                      policy->cpuinfo.max_freq);
>> +    }
>> +
>> +    cpufreq_cpu_release(policy);
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t cpb_boost_show(struct device *dev,
>> +               struct device_attribute *attr, char *buf)
>> +{
>> +    return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
>> +}
>> +
>> +static ssize_t cpb_boost_store(struct device *dev, struct 
>> device_attribute *b,
>> +                const char *buf, size_t count)
>> +{
>> +    bool new_state;
>> +    ssize_t ret;
>> +    int cpu;
>> +
>> +    if (!amd_pstate_global_params.cpb_supported) {
>> +        pr_err("Boost mode is not supported by this processor or 
>> SBIOS\n");
>> +        return -EINVAL;
>> +    }
> 
> As this is information that will be known when you first probe, I feel 
> it would be better to affect the visibility of the file than let a user 
> discover it doesn't work when they try to write it.
> 
> Thinking down the road software like power-profiles-daemon and tuned 
> will probably adapt to this new file and if their contract is that the 
> file exists means they should write it that's going to turn into 
> needless errors in any such system's log on every boot.
> 
>> +
>> +    ret = kstrtobool(buf, &new_state);
>> +    if (ret)
>> +        return ret;
>> +
>> +    mutex_lock(&amd_pstate_driver_lock);
>> +    amd_pstate_global_params.cpb_boost = !!new_state;
>> +
>> +    for_each_present_cpu(cpu) {
> 
> It seems to me that by making an attribute for every single CPU this is 
> wrong.  It means that writing boost for one CPU's files applies to all 
> other CPUs too.
> 
> If it's going to be a global attribute that is shared by all CPUs it 
> should be a single file.
> 
> Otherwise this is going to be a problem if (for example) software tries 
> to turn on boost for only 1 CPU.  Think of this sequence:
> 
> 1) 16 CPUs, cpb_boost is currently turned off.
> 2) Software tries to turn CPB boost on for the "first" CPU only.
> 3) It reads the value of the first CPU and sees it's 0.  So It changes 
> the value for the first CPU (which causes a global change).
> 4) It reads the value for the second CPU and sees it's 1.  It tries to 
> change this back to zero, which again causes a global change.
> 5) It checks all the others and they're all 0 and it does nothing.
> 
> So you see by having a global attribute which is shared with every 
> single CPU you now have a flow problem that userspace can introduce.
> 

Hi,

Sorry, I can see now that it current IS a global attribute in this 
implementation (IE it's DEVICE_ATTR_RW not cpufreq_freq_attr_rw).

However as you're already actually applying it to each CPU individually, 
I do think it is better to make it a per CPU attribute.

There could be cases that software only wants some of the cores to be 
boosted, so could you please instead consider to convert to use 
cpufreq_freq_attr_rw for the attribute and only apply one CPU at a time?

Thanks!

>> +
>> +        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>> +        struct amd_cpudata *cpudata = policy->driver_data;
>> +
>> +        if (!cpudata) {
>> +            pr_err("cpudata is NULL\n");
>> +            ret = -ENODATA;
>> +            cpufreq_cpu_put(policy);
>> +            goto err_exit;
>> +        }
>> +
>> +        amd_cpu_boost_update(cpudata, 
>> amd_pstate_global_params.cpb_boost);
>> +        refresh_frequency_limits(policy);
>> +        cpufreq_cpu_put(policy);
>> +    }
>> +
>> +err_exit:
>> +    mutex_unlock(&amd_pstate_driver_lock);
>> +    return ret < 0 ? ret : count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>> @@ -1305,6 +1402,7 @@ 
>> cpufreq_freq_attr_rw(energy_performance_preference);
>>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>>   static DEVICE_ATTR_RW(status);
>>   static DEVICE_ATTR_RO(prefcore);
>> +static DEVICE_ATTR_RW(cpb_boost);
>>   static struct freq_attr *amd_pstate_attr[] = {
>>       &amd_pstate_max_freq,
>> @@ -1329,6 +1427,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>>   static struct attribute *pstate_global_attributes[] = {
>>       &dev_attr_status.attr,
>>       &dev_attr_prefcore.attr,
>> +    &dev_attr_cpb_boost.attr,
>>       NULL
>>   };
> 


