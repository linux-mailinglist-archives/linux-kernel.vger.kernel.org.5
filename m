Return-Path: <linux-kernel+bounces-160186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCA8B3A55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BA71C21AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC887148822;
	Fri, 26 Apr 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o8osqmmL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054614533D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142829; cv=fail; b=Zm8isXcbxDniF8i4MRrXe761PgEdWS4WtdxggHgNLSCphswaOe0xBsX98Az4gXw0yQD0bx21QVaRd2ZywagQU4yg4uH98h5ryXwmuKRlIiOQLR3XdXqipCAYE7TcjtrGgQNECHvnos3frVYhJF2FvVUsQQsJII1lSN9rKCkbiRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142829; c=relaxed/simple;
	bh=B95fiYDlVybiS2Dhr/pP+UoBskSXPAYqB3wPJGhBOxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PAXGlBg58n7Q79I5o+IYsxXqbi2anyxa+u2CdgUpQvIKksy8m9Q+oVmVWRi3cdYyTCJirojzBCJlLJrkVJwVovPReosncvP6x1y02xw+L0Nfirq8RzMnn0NFWROBQITr5hVIcs7UPEx5iNqA1JjMIPS4ll3+2e/4yrwul1a+/q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o8osqmmL; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmMqJUEHSWK/bNp8E9Mgok6/4e46vfvQrOndYoN+dSPYc34RKp6eG6Qdsl9eOc1wjBL3IKLSlp3MsPmhNVuyYgN7/VRVMMK2+W6MCqmT5VIbXA6Shcc7dmrR0jG7lCcr0h+YhpLmHcK+RYUBG6/3lZMgIfkOFjbQo/phlYQ3sJ1jzgjyyovPHDphVCkNPQ+HWTjYwwDB8IxzqswhjJQgWK9V7dtH/MVRMQTExPQ4uzFQDCsxJe04eb7+fwpj0tV6zIHft6PnC2Kka9hzHT8ZE9vhzR+UA4t0+OBC8CMQsJ7tNoMbZ9cNAP6MtJgVqwH2lf9uc+HFfC6dZa6keGh5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVwVyAU/DxT/r7v+e+54gf91ibUJTNMEjFeafCuO74M=;
 b=NWLrPtqdNRgpuRKgoismnaYWMTAvj14nYfNO/lN+qby9RpNw1ahtQj3xB+ZGK5+QHgUcLYouhPEFvyT3ombk0GvCbDqSSUpx0TU93q0LUXM/RO2WJgFdLOk07ca3mZ3ErXJ74lLH8kc0Ma1lJywDBU7y6xR7/9LIYFLaurccw91vVi4vigo6pfnH7c0S2861MqnbTxDrOPSF8QzIvSz0RuVC5/w6w0c6boFkQkHh3xhithAdZr9ccM9i7nVHYATw+VeQ1L3qJk2gA5SEw37V/Evqx9c+dbomm5wU+ELsSw2R2ydsrfSdyTYQubvC7/nMeSblF0Z1dIW+yA/3vwdfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVwVyAU/DxT/r7v+e+54gf91ibUJTNMEjFeafCuO74M=;
 b=o8osqmmL5m7cRjMhaiVkiGwNI3sKySKBQ054bcW1Z87T+F5I20Kt/Xc2u5eu6Eq1YhqyIAbaoM9xhN1htMFvEApJ3GxR2ARr9FcIXwwFHc3XVeL9pHq49PqDBSagvWr4STxu8xAildMi6HA6atNYRWhAwyLoeNPmvz5BHVCf/dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:47:05 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 14:47:05 +0000
Message-ID: <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
Date: Fri, 26 Apr 2024 09:47:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:806:f3::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd1ff02-525e-4a9e-7f7c-08dc65ffbd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2FNQ0N0UGNPVHFtekRKWWJuRkZnZ2RhbWNpWU5EUzVWNmpEZGNlMTRzMUVJ?=
 =?utf-8?B?Ri9BOFBCcDNveUd4ZkV0ZERyNEg0TUZGYUVDZVNMZGJYSFErLzErTUVvSy8w?=
 =?utf-8?B?aFB4UEJ6U25DSE5jSW9UUEhiN1dlU2xxWGlHOWVOUDdORi9ML0UrL3hiM0dm?=
 =?utf-8?B?ZkxXMFpSRmVpTGp1Q3FUdFZiOGMzZ0NiZnIyQ09RYjVwZ2NoZm8yVFFJWHZr?=
 =?utf-8?B?VnFpQ2pWR3V5cnBNUG4vS0EyT2hMajVoNHR6U1lUdDVjRGpUMzJPNG14cmEx?=
 =?utf-8?B?ZVk5bU1nbklRQit2NTg4VFh6b0U4NzF3dTh2dk9YQjR2NnlEdW81Y2dWSkFM?=
 =?utf-8?B?bHVEYTNkQ2hRcGtRMGxuU0JWVWV4QkNSNVkyNCtlOFIybEIrUDV3ZXlVWlBH?=
 =?utf-8?B?cWovM3FRRWhuUTVwWWtxZloyK3FMMjN2MVdHVmMvVUVpMHhhSE80RXcrTkdt?=
 =?utf-8?B?UTVveTM5ZFQ5QktMYlNhd3U3amRuSXRHM2dEMWdoYURJM2R2eUdxVU1NVDN0?=
 =?utf-8?B?dzQrcjRsSmV3Z1hCUnZLYlMwalp3b1k2cFRiMERITmlOcDluVnhTSlkrcTQ4?=
 =?utf-8?B?czlMdzdMaVNwS29QZG1JZXoyalc1K2l4TEJ4YjUxTXFXbytrY0JvZDFrL3Ry?=
 =?utf-8?B?K3JhZVRUemhiQWN0ZzZBelJVV2dEQVdaNGRBb1hnQzBJeGdmVXA0UzRrSmF0?=
 =?utf-8?B?dEw4VlpoUWV4MXVzR1JDY1R2SXA3Z3lydkxUaG5VT0F1RzlmSER6ZTRmNW9N?=
 =?utf-8?B?Skc3RGdscFZNbm9JbTdTTDA5aDM0SDlTR2dkaEg5T0xLOTVaTVhJekIxYktK?=
 =?utf-8?B?Nlo5ejJKdGhDbWJsbGt2S09WN1hKK2QxSVA2ck5WMUFXVFpSYkhzejNXR2hh?=
 =?utf-8?B?OGRkcklxZ3JGR2ZIa3VGU2ptY3FYRTY3RDNmdkRPeHNTQmNyMkZwbFpmdFBU?=
 =?utf-8?B?akRiVllOekVWYm5iNTJOcGFrcTlubnpKMGRKN1JRcmg0ODhJY0JqYWwzeGM0?=
 =?utf-8?B?RkxXWUU3bStnYnhLZXRFNndVMDZieThCL0orT0FIODNkOWJsK05aWEt0a1pH?=
 =?utf-8?B?b0FiWUZQL3YvOWp1L3psY3lYUXJvNzY1QlAvYlBBSjhsUWxiRVp4cG82K0Zp?=
 =?utf-8?B?STN1a24rWXJkMVZ5UVVtYU13K1JZNUllYmdPRnJ4UGp0S2VnNjRLR3dNVmo4?=
 =?utf-8?B?YndyTmcxLzkvaXFpTzlKUVRFbWZiMUhBdE05VHBrVXBvM0htb2dKczRCMTNB?=
 =?utf-8?B?V0tPb3ZaQWluREdmV0pwWG1MOHFrN2xFcVNXTE9HWFdJcmpmVnBiQ0ZpTHZu?=
 =?utf-8?B?RDd5dm5Hd2dHb0VScVZtd0xMbmlUQmxqNmxOVVFOSEt5TGVIMTdaUURjK2ZY?=
 =?utf-8?B?N2FuLzVUQlhYdGloS0ZZb29teFR3amZCQ2N2VHdrTkowN1BVWHlvdzFTekx5?=
 =?utf-8?B?M3hJZkVhb1lPMWp2R2ZyWHVMTjBwYnNBNXpIeEE4TTVobjJIU2cyc2RjNndh?=
 =?utf-8?B?WU9scFpJand6RzdQZFd4TFZPL29QeVhITTNCRUU3MEJuejNDTTRuYUtNQW93?=
 =?utf-8?B?VnFsTXdTSVc3OUFYYUkzb0dQYzBXcDg0L2ZreHBGekZhUzVkOGdaZlBjR1lo?=
 =?utf-8?B?UHZ4b0M2WDdoT2NMWE1LNmgxZkczR0xsL0tmcjdpRjlRMm1GRjgrZ2JidHpT?=
 =?utf-8?B?eEJxOXlNU2NSQ3pTZUZFVUpZQk81Wlc2SnR3WjJ6V1RiZndWMFF4YjhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmVmc0ZjQXY5dWRzYkNZejdOejBtNEdZSWlyNkIrektGM3g1bnptNG9IQjN5?=
 =?utf-8?B?ck9PYlpINzdVOS9zTDJqbzRuTFZ5MzNBZDhTaWpsbUVOMUdVVURCa3pyQTQ0?=
 =?utf-8?B?LzZrR01iTFJDTmEwMnpmN2pjUmpMT1o5NldHTmpxZldsWFNUM2ZjTnZ6bGFG?=
 =?utf-8?B?OGVmRW1CclN4M01PdGszUXNhSXJqVUtTNjRDRG9POU9lSzVZaTk5VUlIbVlN?=
 =?utf-8?B?cCtpc2tESm14aWc1N3ZpRUpWTnVkenp0cjVvZnJKaEtRUXd2WDVQUTJaczFL?=
 =?utf-8?B?TVdKSWpEdWw2Yk1BRjRVRTdNbVhyVkpzenhldEt0alBXaXBqYlhHVEpic1hi?=
 =?utf-8?B?MnJpVEF3OFNob0NGcXEvTit3NWpJdWNLM2FQOUpsMHVXV1N0ZktuMlgwNHhE?=
 =?utf-8?B?VFRDU0VvQW1IMUptVlI0Q3BJdlNxRTBFVVN0M0tPbFVlWTZISmdwSzRnOWRF?=
 =?utf-8?B?UWxiTXAyc2xJcElqczRmSGpNNExlamtVSWZBQXlMbEtKaldMVlFyU0VKOG1F?=
 =?utf-8?B?MjBiNDhKejNkSVl0TFBqRTk3NjcwSXROaVZOTU1BbndiY2FKRVBwMzZDV0Nm?=
 =?utf-8?B?emM3OFNUMzMxSzYwM3RNY004Ni9XeHNPeGt5UEJxUVZNUG4wS1VndkY3aU05?=
 =?utf-8?B?V1N2azYyM3p6elgxNGZnNnl3SG84NU9LMkMxZHZwVkV5WC9QSThUUHRmdGxR?=
 =?utf-8?B?Qmt1L05OZE5ZcjdmVDNHUUw5aW8rVVZjK0g2T3Y3bVB3Zm03QndVR21xSGxl?=
 =?utf-8?B?akVQcVl0MzJjVWdjTXJRdU4ydDVYdFhJczR0Qk5RcGV1OEgxVitEcU1NaGxO?=
 =?utf-8?B?MzRqUm9KSURuYm9PbkxEdXF5czRwbEFUSE96RC9yRjZiOTNtRUtTbndRenVy?=
 =?utf-8?B?dmN5bTVJWlY2UHBZaFhhN1pNWHNTZDRrWnhDcmRuZW85d2Q0bWwyVnk0dFhZ?=
 =?utf-8?B?cjBMaVVVejZmQzUwL3VjVmQ3M01tK1F2ZGE1MXQwMUNPRUp3ZXpzdVh5WW91?=
 =?utf-8?B?YUVQZ3FCM3FMUENvR3orWVhBOHZMckE1NENSQjl0Ums0UU1uOURzK21mQmNy?=
 =?utf-8?B?NzBVdnJxbXFUY3p4YTFVM3Q3WHVtUWtHWkp0MW9WZzAydEFqaEpRbm0xd0RT?=
 =?utf-8?B?NXFHRlV1aGI2WlB0bjVYdDVlSWdVVTVaUk53aVU4dU5OUldPaUxNajhYenNa?=
 =?utf-8?B?Q29EM3RacTRlTnAyWlhqaTlTMjAwOFF5V0hGS3kydHVLMUJEandPOE9yVDdm?=
 =?utf-8?B?VDltVHdWbHplRC84T05tWXhLM3pYdThDRVdpZWNBOVJUbUZmTnc4TXVOa3N0?=
 =?utf-8?B?eGIyR1ZNVGdvYlE2U215Y0tYN0xoUG10LytBOTdhSWNZNTBaNFNoZWtsSTRr?=
 =?utf-8?B?RDZDbkZycXV0RHNGaHJJb0pyRi9Za0JOUGIzaFMraTB3aSs4RzhaWVcyYlZk?=
 =?utf-8?B?TEN3S1MvSlp2REJ6c2RjeWw4N1dtc1FqTnhzZE1jOHpHK09WMmNpc0dnSkNw?=
 =?utf-8?B?UmNLaWU0TUkvcVpTaWVIWTFxd0Y3YnV4WEdQVHM0YWtocVdURStLYnZmZ3oy?=
 =?utf-8?B?RWpPUXJsR1VDcmZSOTVUNm5EUjV0V1F0S0NGanRFa2habVJNa2tGL0dTeGsv?=
 =?utf-8?B?dndJMXBDUG9QQkthVVVKK3JGVlJRbklKbHMxNUp0bDRFUU9YMnVBZkNlTWk1?=
 =?utf-8?B?VlU4YlNvUTNXaXRXRkJTaFZsTHZhbVAwVCtCS2VZMGpKbWRydHkxa09CN1lL?=
 =?utf-8?B?dG9NUUtEK2ZqZjJVdm5uVUh4SENRNm0wSXluRUl2a3JHYWh1QkVWWGRyUEVr?=
 =?utf-8?B?eFdSVUJSaGFVWEc2dEpHRnFVT2NiT0thQTJRV0pNd0o2Nmx3QXBDbFJjaVFL?=
 =?utf-8?B?NGpJajdsMVhLaHFHN1FhL1BwRkhYcll4N0FSSk51NXRaVkxMTVR5NVIxUHR0?=
 =?utf-8?B?dlErQ2h1Ynpza1kzMGIvd1d5RU1pOEtoNUg0N01ZYi9BSElGVktjOHJBbUVx?=
 =?utf-8?B?eTA2UGkxNXhEUjg1S2RMbDYzWkFlcGxMZHVoaWcvWDFPRmM1SWhJMi9OYkhj?=
 =?utf-8?B?emxId3R5R01LNndubVZCNlVlZXFWd0dCSDMrSDB3bHhldG9IdGVqQTNUd0lo?=
 =?utf-8?Q?NctJJRDHXZJPz4JjmJqAtbRzR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd1ff02-525e-4a9e-7f7c-08dc65ffbd91
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:47:05.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCcHPIhIf99nm6Y7jsLxwe8BA8wD6og91oUrfC9rfj0cjae9YYAxOqpIXTuoFkC8xsVAmUaz3nxxyO7esUTznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

On 4/26/2024 9:21 AM, Borislav Petkov wrote:

> On Wed, Apr 24, 2024 at 04:17:09PM -0500, Kalra, Ashish wrote:
>> With SNP guest kexec and during nested guest kexec, observe the following
>> efi memmap corruption :
> Before we delve any deeper here, lemme make sure I understand this
> correctly:
>
> * You're in a SNP guest and you're kexec-ing into a new kernel?

Yes this is the case, where i am in a SNP guest and kexec-ing into a new 
kernel.

I should have mentioned *chained* guest kexec above instead of nested 
guest kexec.

Thanks, Ashish


