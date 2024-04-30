Return-Path: <linux-kernel+bounces-164408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0789B8B7D54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285A01C233BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55920176FA8;
	Tue, 30 Apr 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QNOxyOm0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCE335DB;
	Tue, 30 Apr 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495389; cv=fail; b=M8kf9HZhws7vcRMrfogQshzLclcDJXGc7fFEP0L9dAPDoWIGKQZixzoqPfhX4ydss8YmEIOA4BQ7gdm2YlVWzBrQLfMUf+NPM4q1aKtnZZPXXg5fkmCs2if+RTnzeCHHtAbgaPfyKHBI6CYFnhFjSdp0tbAeLIJCerwHpWXUQCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495389; c=relaxed/simple;
	bh=XT31Ftcabrbf/jU86b8zjSNBizj4hr1elyYU3XMxPFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADycwtnOTfg2NVLkQKaybCdfJFqjMDWuvuHFTGmeaqoGXE1v5Y3lq79LzrCkA8zvedGJkk5MexNA/YeYODqfTOl15kmPskxGb4BPbROxAvNQlEfOIpcmauolvzOffs7kqGXscMKlVieoqoanXdk7qtVjSFs61IdCuGN0rZZvI+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QNOxyOm0; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMawQ7qymFD+4vXqpUo+7amw7QNgIXgL1QB1fS7qVdgvm2T/35LXKgrRSyZ3iyyJ6Pw9UR+sBGhWKswH5XjO9mOOPAupG4i2yClWWZdN957dbkGXkJ9jzBl8ZdMSmMHxRJxE1HZjPPjCEgFGu+rL9Ag/kQPOWg1IzVpOayAAhdk812vu1jn+UbdcGsKP/tPeXf/ue2DhpBtnFyVCNRdjFA0BlCMsdYdLtI4ZEnNHNZlY3ybaVUjmri2wbYiq6jr/7wqcKXC3uSo6fnuPwomnAj3ZbN8e7C85/IakH5k8MhME2SYaVOFujVdkrIkzUkv5wtIo77p+x3PzFEkVinJteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDt+DO1oRRB7b7JcZy7vUaMkjcL/jhF3HHe9PiwrYHI=;
 b=Y8bGNlvbJ4J8stDRWgu5dJWOna1Ij2YI3XdgTympgkuWxZuYxFUuBAWpUOXOOYFwULYG0XePMwQUwpg00C1wMpivr8XKyofKEjm6iZ2uADtmgka4c0gngFEk0M5O9EQTHdYakjrl15hCffriLf2hoiFLIncbmbgnroRNF5/z89UaqJwMVGQGQdj3fa/9j7nVTgOOdOWZxcapB4j5C6na5EZ/1FAdn6mm6uWCMEEKZgv1nx2cQ90JhaqmR6rKsya4S4s9p8O0/+95WtdaE42h7Ck28xRr9YL3rHQ9U/zKeHOw08BlwATHb2GcyDVzJWkBhfpg70BNvOBFt245v5xnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDt+DO1oRRB7b7JcZy7vUaMkjcL/jhF3HHe9PiwrYHI=;
 b=QNOxyOm0VsyrtUfz1DG1BhkHPbvy9ksioki+1QjZzO1QUOEXIE22R+vdXy8fYoVi2QW2LycCennyMeUZT7Da91GU7cDk+skD8xFqHycKj4YHt2g6TO9U46Cwa6DBoKMRPq36si2yMx749dyy1WbGSMclOC9kOChJ2kbNBbf+Fho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 16:43:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:43:03 +0000
Message-ID: <38f22522-3df0-4108-ae09-ad8c1a13b274@amd.com>
Date: Tue, 30 Apr 2024 11:43:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and
 reviewer
To: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meng Li <li.meng@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Ananth Narayan <ananth.narayan@amd.com>
References: <20240429113356.1708284-1-ray.huang@amd.com>
 <efd9226b-84b4-47e9-bbb9-68bd0194a8ef@amd.com>
 <CAJZ5v0hUwKHbpWXfjArujB8FJ9wDc9_Cv5O1Y_DcyWAPHG-v_w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hUwKHbpWXfjArujB8FJ9wDc9_Cv5O1Y_DcyWAPHG-v_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:8:2a::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e314e7-d880-44a1-f1a9-08dc69349ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1RoQWxGMVdsbFY1SmtYS1FKdXdtZVVlTDZwZHUvaExSUk9NSTZpY0RjbkQy?=
 =?utf-8?B?ZTE3ZEFIVlFBSDN3aVh1a2FJWkZRMU01cmdHMmRIbWxyZ2NHODZMeW0yQlRN?=
 =?utf-8?B?eHVNaWlock9nc2JpSGo3MjNJbU1JUmJQQXlibTJuY2V5a3RqQmcycW5vZ2hX?=
 =?utf-8?B?U1djZUNLS2lLTERCWkR3VTRIWEwrNTNCbkpOYmdmenZUU1UxcWErL3pJUTg3?=
 =?utf-8?B?RHBSWjYyUS84NzN4R0RoNU1iazVaUkM5QjRtTTBaZ2xVRUVPNVJvSUxDTnZO?=
 =?utf-8?B?c1N5eERpMXJLcnVvOGpkVHNyWklHVFcwL3RNbzRhOFZkb2l1VjJHMWNXaDJo?=
 =?utf-8?B?VThkMFlaYUlIT24ydFp4ZUp0WUVaUHp5bmVpS1N3NEl2Y1ZRckNUdVFyeVBy?=
 =?utf-8?B?OGVjaFJDOWR3bVRvK2VJOUw0QjRIamNEdVZRMk04ckNXMHlKMkZSNXdvK0Y3?=
 =?utf-8?B?cEdERXdJd2ZsRzBCc1B0VGc4STJxa1l5YUlkZHQwRFN4WCs4TDY5MmJ0amlH?=
 =?utf-8?B?ajBjd1hLTFlwVlpsY0laaTBkRFUxZ05OVUJNTUxzRjdvNWZpazFadTFXMSsz?=
 =?utf-8?B?b2ZZWDVDRHlXYmd6WHA0ZTFIbnZwc0lNdWRWU1BSbEp1MVU1SXJQekxpSVZz?=
 =?utf-8?B?bE9HMVVhakxsRVpYZTA4blp2UkFidnNsMEhEY2lQUWdJY09IU1BaLzRKYUpS?=
 =?utf-8?B?UTdtaFk0ZmtGb3JWakREb0dUTDlkblBuS3NzMnRhZzJ5VWhLVnhmb2FJYzdZ?=
 =?utf-8?B?bFVhVWIvWTN2ZzRad1Ara2FqSWNZc0NDb3ZHQ1VwaFU1TThSOVl6L0phMWEw?=
 =?utf-8?B?L3VLTHVRdFYxbHZ3WGp2czN6SzRVdjlhbDFucS9OS1hkSzd6dms3dXVOMFN1?=
 =?utf-8?B?aVVCOHlHUlpKK1h6YkN3L1RzdUNXV2s4bFZQcmpoTnhiWVpvcld0aTNBSEh4?=
 =?utf-8?B?M1hsQWo2SzNkVU1IdCtCdnJZZFVacDVKaXNyREZLdUMwTnJ0RE5HUEpubTlE?=
 =?utf-8?B?VEJQQ0JwalJnaDNMK0ZnRXc1TitabnB1VmgxOUUrZERzWWJDUnVvbkZkZmpR?=
 =?utf-8?B?dzhvdlU4bzNlTkQ5RDJqQ0pTbUd4UWxRRWdFVFZUK0xXaW1naDFkaysvNTRL?=
 =?utf-8?B?akYrdk5RRk9MSVVIUWllOVpSck0yd0ZTTlhGRGRhTTNWUE1KTGFqVGJ6cHA1?=
 =?utf-8?B?cFB2K3AxL2taWDJuUW52VzI5THpmNmZ5YmxUUnZIZjJ3M3VtQWRUeTFDb3I4?=
 =?utf-8?B?RzFzWG1NaTVkVXFNZ1U5QTE3Tm9QTUFrSUUxbEw1MmdFQkk5UzZueWlWMFMz?=
 =?utf-8?B?Z3JqVGVvY3U2aXJQazV5Y0NOYjFTY3JINDQ3b3BVTUpuRXlpZEoxM1d0NEhJ?=
 =?utf-8?B?Y3FSRXVhbC9xcWU3MWR2N3BodWtYQzV5MW9BUldHbVIraEVTQ0V6YlRhNmxh?=
 =?utf-8?B?MytVMWV0SmRaR0NjaEFmSkpPbmpKZDJOUS9TeGU0T2QvYVZJT3JNb25aQ3FS?=
 =?utf-8?B?dGk5MWsxYXRSbkZpRmFpWWd1TmZsUzQ0dDBvY2tKTFlRRkJBNndCdFdtRG8y?=
 =?utf-8?B?N0dxOUZ6eWxvNE9zbStxWllTZjFDMktoVkEvQnl4VUpwZGIzaWVVVUVHQ1l3?=
 =?utf-8?B?TVY2WGEvZkxycnR0MGttZENaRFB3THVJV3FkWHFSSUEyRkJLSCttMzNFRTdD?=
 =?utf-8?B?aU9TbkxTZXdlak5MZUt5cXVrN1hwRFVaZWFBMFpJV1dGZkVvZjM1dEtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVZoV1owd1hBcW9tcTk0OEFNUjZYdWd5UEYzVHpXcVF2eUFuVXlCUnNlMkxa?=
 =?utf-8?B?RHluRDJ6MFQrR25SZkJxdHc3bUdpTUNRNXBSbWJoRGNyeFNVcTgyYmpOaG01?=
 =?utf-8?B?S2RueStKYjZSOFNGOVk1Q2Q0ZHVRbGlGTkpJSjEyMkVhaXAyNktqRk9MMGlS?=
 =?utf-8?B?UDl1eWxJd3FMQm5LcTQyMWQrZE1kMTF4cHgxKzFEZno2YkRKYkppcHIvd3hM?=
 =?utf-8?B?M2szbS9adVdYY01nRmJ5NlpyNmthRzVZVDJRM2tiaWVzYVhydHEwSmVuZlBI?=
 =?utf-8?B?dTJsU3Z3eG0yZXVhZDNZZVBTdE9OWmFIY2J3MVRaYkdLanFNN3k3MW5qVDY0?=
 =?utf-8?B?UVIwbTNta2lKVFkvU1ZzL04vQmMwejZQN1JhL0twY2tIcjkxM1hnVWphSDE3?=
 =?utf-8?B?amROM0pPRnlLRmk3MTl3R0FOSVdYQWtPR055WFhWSWlGMDJZVWlKRFVBUEZC?=
 =?utf-8?B?UktSVElJcHB3aG9IMUFjV0NRUTJ5YW45VDVENGc3MEdWSUtYeFQvblNIQ2o2?=
 =?utf-8?B?YkU2WEZYa3ZzYU9NVVh1eFVFSWFNcTJhSEV0YU90VFdndkJjN2hJd0xyOGVv?=
 =?utf-8?B?OTRRbFlyNWlteWF0eCtva0l3b3dZTzNLWXhGZU5ESHo3U1FiZXpVS1dONFNB?=
 =?utf-8?B?SkZiaTZvWXEybk8vN01EU1NsZVFhbHVsSWlXQmsrb0J2LzFnUHd6dytaOGg1?=
 =?utf-8?B?VVcreXp6WS9FdjVBWXpBbzVFanhMUm9kdlhjcEJZK2xYRVRFRGVLd2o0ZXAz?=
 =?utf-8?B?cTN6bFBBYnBjRmkvNFdlTzhpQ095QmxsaGd3SXhENHdqSUQ5L0hxd1NLanEr?=
 =?utf-8?B?ZTRPOGFFLy9RTVBYQTNWVS9CdE5qeFJucUpqNmJNdUprTktlMm5TN0ttQVZ4?=
 =?utf-8?B?RmprSlZBeWVDUloxN00yZC9FQzIvcXVqRmM5TTUzT3FtRnJVeWsyV3k5UXFB?=
 =?utf-8?B?OGNNZVRvQWtjSnRzOVRubWcyZ0IvNGJ1S2hkNC9YRERua25hdElXanNqQmNB?=
 =?utf-8?B?QXFNaXRLK1kxc25BNGx6d2dvY3pCbkZtckFYM1JxR3hyRTJEN1g0ajVROWhq?=
 =?utf-8?B?RHF4d3poNE9IYWtNbmlwVEVWYmMraXo5eW03OTkva1BDRklwSkhxb094UFF5?=
 =?utf-8?B?cVQwOGFrYWduSEpac2NRbXAvUlN6eDhSU3BJNGlqeU05YWZPdnZ6MU52N1NX?=
 =?utf-8?B?UGJURnBkTnp3K0l2L0NWUEFadU1uVFRxcllwZzZGL0hFclJ2Mm1TWVFpTW5S?=
 =?utf-8?B?ZFlhdW5xZVdmamkrWG8zZ00vMzlVYzZlUTNzTWd5M09IYWduakNOenRXb0xY?=
 =?utf-8?B?bmxwVlpnWjFKb2VqU1FpTlBpSnV2UXVtak9qdzk2SjRPM2tubzRPMnNFT1Jq?=
 =?utf-8?B?bkNNaFlqeXFmUVdzRmVBM0p5NSs1cTM0TFdnZHdYYkIwTE15Q21zbzB6S2lM?=
 =?utf-8?B?SStvaXFCMklMb3ZDdUREeGdkcG1TRHNoU0dGUE9jZi9EN2NaS2s5WnIvZnBY?=
 =?utf-8?B?THEyLzZpN2ZRMURNTXVXZVNlQVZIUFJJV0kwZnlEQnR0YUVyamhaUlZzSTJy?=
 =?utf-8?B?SEpuN2dTSUtFUUNGSU13NmRjSUJEWVdma1Z2OElrUmFWVzBwZ2NwYWt2WFND?=
 =?utf-8?B?aU9KNFE3cisxVHlydHBnQjI3S25VamkyeGk4QmErRTI3ZDEwZkFiZUR4c01z?=
 =?utf-8?B?akhVNFhyeTVZUktKQWFveWhIK3RPRUpBcjBneSt5VVB5R3p3WFFzTUxsQkUz?=
 =?utf-8?B?S1ptNkNzUHAra1ZHTkdkZzBCRldFYzBPbmVya21xMGMzZDlJTXJzTm1sKy81?=
 =?utf-8?B?Z2xVYXZxYjZUUUc5Y2hKK3RRSnNxeTRDcWE3UGQ3bUdNd2RHQndBZGVnbTBE?=
 =?utf-8?B?WTlpeWhOV3lDRnJUVzFOZGVXd2R0RGwxVWVLRlJwcE41QnZkVU50QTJSUkhS?=
 =?utf-8?B?R1V1eTg5MkxpYjhiWGVKTWZxRUtwZ1FKTDBiOHFDMkp1b2FwTlpSWkp6OURM?=
 =?utf-8?B?Rk8vZXBGcjRLOXk3QUZJWEdCMXdNai8xM00xVFArTDUzbE1UZVRGTXBFQU0w?=
 =?utf-8?B?bU1EaVN1VW9PalVrUTVOd012YlM4YldkR2V3WEt6M0dwR1ZEcVRteDVKU3Zl?=
 =?utf-8?Q?nNrd6hAvQW2DxkEN3PI3Yeg2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e314e7-d880-44a1-f1a9-08dc69349ac8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:43:03.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4jwVDHTmw2YziskronDV9mlXKuSu27FLyR5U7sH2GRNtvoteGHOHhA5LfYYd/h/aTNy7/srT8OX0ChpO8r8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

On 4/30/2024 05:35, Rafael J. Wysocki wrote:
> On Mon, Apr 29, 2024 at 4:02 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 4/29/2024 06:33, Huang Rui wrote:
>>> I'm happy to add Gautham and Mario as the co-maintainers, Perry as the
>>> reviewer for amd-pstate driver.
>>>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> Cc: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Cc: Perry Yuan <perry.yuan@amd.com>
>>> Cc: Ananth Narayan <ananth.narayan@amd.com>
>>> ---
>>
>> Thanks Ray!  We of course talked about this offline and I'm happy to
>> step in.  Having coverage of two people is also good for any OOO
>> situation in the future to make sure patches can be reviewed in a timely
>> fashion.
>>
>> Acked-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>>>
>>> Hi Rafael,
>>>
>>> Recently, I was assigned other task of virtio-gpu support for Xen, so
>>> apology not to review the patches timely. After discussing with our AMD
>>> colleagues, we want to add Gautham and Mario as co-maintainers of this
>>> driver from server and client side. If one of the maintainers ack the
>>> amd-pstate patch, then this patch is good to be accepted from AMD
>>> perspective. And also add Perry as reviewer, he is actively contributing
>>> the patches on this driver for a long time.
>>>
>>> We will try to keep the patches reviewed on time in future.
> 
> Thank you all, patch applied for 6.10.
> 
> BTW, patch series "AMD Pstate Driver Core Performance Boost" doesn't
> seem to be ready and given that -rc7 is due this week, I'd rather
> postpone until the 6.11 cycle.

Yes; I agree with this approach too.

