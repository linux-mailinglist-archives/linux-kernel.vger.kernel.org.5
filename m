Return-Path: <linux-kernel+bounces-128398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3526895A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED783B29207
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71515A4A9;
	Tue,  2 Apr 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nDAg9iqR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9015A490;
	Tue,  2 Apr 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077386; cv=fail; b=CV3L+Xp8C0GyApBb/uMw7BETA3YhFczgPn0E2v9jIaFAqxPPl0oBxWodoU9qX5aGeIEFwmBE7KZsFW430ERRcbXkxQ7XMlYU4lycxLN/R8kpkMOZUUA3oEAivZLqKfZKhBk57DE4C456aO6vQNHQYE/33o72YtDQo+CN9HQ6FYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077386; c=relaxed/simple;
	bh=+A+oGJsWPl/CZDJnvCPM+e/xDdLpZCAXHc7SufPGrxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fk2PbL9WgZPPWusi9KXj6OPZNo/tH4gTUR6jXyPlJkdm6OvPyrf46gOU0+Q108T9V29eGiI41AbYNv0/O8kkgIlsFDTXLOL8J/T0isvzVmBoj5F9R6PjRIm3pzp3yCnpo2myyiqzdCeSZXYI7o4Xwe6aiBw40usRcMYVvfTiDMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nDAg9iqR; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLZBjKm1RkRizCBrPATCkBgnSZjCTuYoXuAWLwcse91rgjh9tdOESKfmUzeW0aY65RnwwL9A9b0poGGZpjAb0bIYCyd+1We0V9fmdzcDw6kKK6hJ3d9UwfjawXmTDartkLBVp4xB4jJ6xweAzWPNlKIkj5hi4SEVCA+98ntONicWsTil4nZkinKWrQ56gjo1WuqeJHp2dZ342kcjC812l7ALkEtwPC2ZS7bONyjeee/6U+4gKQgPXsAA20LQr9Pqc1J7qYUxbBF/bzo4rgDkKYqOg2PUfFVQfkyc03kpupmcWWHXiTslc6hZ4iYfLwPZFHxBh6B+PaqoRF0FW6+TTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqzh+hHDnJgVTQmj2s4S4fkbXhKHMvOPCw/ZKFxkiDo=;
 b=BpXGBfp+ia/qHL1yu/4sE1De+O7CoTOPcSIGwmpJctDKAIagfuNHnDasnT+uTjaNvgVGDTlxbVVWV1qKC//u/BGOeDi46GaJiTL9ndQ0NdGNf3JVHFA299xdDxse1D5AmkM+xMitopAJUduHeuu4b/go5Qdu7O+xLH5k+MkvN2Hr8+2aQ6eSyhawpxImrUJ2vAVUHGEt7EI6X+E4hnmL36VV4lxAJwSiP0NXoiCa8ckxSQTmNYCzrHeOT1FuKbgV8tA/11DGtf/tLV+I0D70mqtFehRIvrrXbXCtwpf2PqVeke4YFEATWOEpGITCzh4UjpXkz7WrD3GqXE9R8NxNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqzh+hHDnJgVTQmj2s4S4fkbXhKHMvOPCw/ZKFxkiDo=;
 b=nDAg9iqRaj08CdvSaOowhsCn5AQOUqqHv/s52Q9t52dZwvpeOxFyHoWOr+GeRMfJNU8h0XXbcirTiGcetOguTI2dyIgFeyKCSrqQdrMbJBRezTgUrXHfSWFpFWoJczYJELrXCYB/AXPolDisUb1cAw+mCtKYhfNanUaiSyVIOVg=
Received: from SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:03:01 +0000
Received: from SJ2PR12MB7992.namprd12.prod.outlook.com
 ([fe80::e828:426c:920:bb6b]) by SJ2PR12MB7992.namprd12.prod.outlook.com
 ([fe80::e828:426c:920:bb6b%7]) with mapi id 15.20.7409.039; Tue, 2 Apr 2024
 17:03:00 +0000
Message-ID: <29bc2adb-07d5-416d-b357-4cf084b45ed8@amd.com>
Date: Tue, 2 Apr 2024 10:02:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: Fix pdsc_check_pci_health function to print
 warning
To: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shannon.nelson@amd.com
References: <20240321063954.18711-1-brett.creeley@amd.com>
 <20240322180251.69167fd1@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240322180251.69167fd1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To SJ2PR12MB7992.namprd12.prod.outlook.com
 (2603:10b6:a03:4c3::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7992:EE_|DM6PR12MB4401:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fssXQbyJV4kpzpqfL+y9iFTmyvzA+2CytOk44THRPBoH65cH21gOnZ6Not5vNWSzjNW4yA3DUYVP34PJGboeYVayg5hcysQNiozDJGHqRjyTk7Q+BRHwRIGieULX2GunmIpAzgmg6LvHW9ic5k+tHmpfdA0OWDxnjTlo2wJ2qEnfOD67TeI8f1v3sBsl2vDQ2hjJmvaRbI4nfEsZx/l7W5iDGuOeo5kKKQRZ2ifiqifcRB2p5EU3X2gLA8vLFxWdPBR2GM9dqbQo2FHF5JGox1MQN7gySDanTweTQYEOI4PpBCA6K5xZGVzaC8/rVIse1p8ht8UkCEHQxCbtLeMJkcOTrOFYn9OFw/7duRu2Ne35JaxMfikH8OwrRRQZoo9Mxx2FSzH6T3OWBGvrXGDjWGgN9HL/B2K9V2B29dvBVPYVoyfnayjLDLFJKvEUWVAZ3cpUJjAuw+kta7YRK76f5ybCj8mWABRUJr1w3O1doqAa+mGJuFse7GWP7GZ27LsI42iah+5gceqrTJpb2LPKhv+xdELv9cPwsBh4RjElP4TE/YkAangbDYSVkM5b5vHTvfhqc4pTEPQSQYUBBJerXSaM1z8HNiyJvURj8kIlFjHgVgi5qZnQTwJokojTl0vEHKyhjy043aauDwohVJLTACxO2QDAb8vB6UzNc7LKFbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmFOTFd5aG1oa2xjWjlOQUY4c2Y0NTk1NVd3RU1Sc1Y1UVFlOXF4anpuSTdN?=
 =?utf-8?B?bE84U2ZyVlEzUW11Vkh3UkxZVjN4MFluWjdVVi9QcSsxbUdOK24raUpRVmIv?=
 =?utf-8?B?ZUdlMTJBY0poZ1lGV3ZSNCs4MzZyY1V3VlAvNmJoem1LV09UdER6amJtclhX?=
 =?utf-8?B?cm4vTm9oNThyTmlpTUZXNFJyRDRSc2VXb3MrSVFGV3poNzRnWTBOTFhPWnNu?=
 =?utf-8?B?bHFQYkN2N015OStFTEpjenplaU9YK0JZc3VjZmJZRW9taG9OWDhsUEYwSzA0?=
 =?utf-8?B?TEY2Nk00Tmc1Vk14V05xS1NtbWFCUFZtY1RpWDFzaHYwVU5aTXNwZ25tOFRI?=
 =?utf-8?B?UE04Q0ZlR1VhckhvMjJ5Unh4WWwxZUtaN25ST3lTWUpJd0FoVW1RWXR4dWwz?=
 =?utf-8?B?L0hPZ1JBRFhTUm9yd2FSaFFjOW9aWklxQ016OXJrNlJTdnJ3c2tDWXJ5UFJU?=
 =?utf-8?B?M1JKclFlWG5sQmVYSmFoUDBXU1MwRmdsdVZkWXpEUlJFWE5xbGxrL3Ivc0d5?=
 =?utf-8?B?Qm1PY1ErUlFqaUoyc1NUYmdHd1VLWCthSlJIWDh0Q0hzd3U1N0NjOEticEkv?=
 =?utf-8?B?QmVGUmF6YlBnOXRNQ3ZZZkI2dkdvL3dmcWJyN0hOSDJCVmppSGl4cVhPVjJq?=
 =?utf-8?B?a0kzblpHcDlBeGVKTGtHYnRlWFBXWmx1V2JZblB2WkdKSUNBZzZKeXZ1S3FW?=
 =?utf-8?B?RlQ3QkphT3UyU0c5M3VmYUozelRGWDA2d2w5cUt3NXdLSWJZZ1NFL0ZSK0ly?=
 =?utf-8?B?R29wak1jekEveGVQd0VNelNIS0RvbmRNbEdOdncxRWF3eGNvQjVQZnk5c3pj?=
 =?utf-8?B?bzJQVks3TEtWN295dTBJcXlrOTBpZU5vZGRLd2NaYVU3MjQ0UTJGckJlQnV6?=
 =?utf-8?B?enNHNlhlTmZ3UE1ZZXVyVEhoamxzL1dBcTV3Rml2bFREd1M2N3VXVDlDNk1s?=
 =?utf-8?B?S05yNlNDMW52ZFllWEo5dnkrWkNleGxOcHcvNGdQaGwwdWdxM3UvOGQyWXNa?=
 =?utf-8?B?TTFSUXVvL3dkbFhsendqc0M5cUNKVXQzclVFMkdqOUI5SERRcCsxeWZBNm1l?=
 =?utf-8?B?cDc1U1NzdTh6UDMxNEFIei9ObW9iSTVGWWJNWXNDZlBjSk8rNHhiK0Z1S2FU?=
 =?utf-8?B?TktBM0NKeWtRTllHZGozQkpXL2RGQnlVelZ0REdQeFJjaTg4azRFZERRc0Qy?=
 =?utf-8?B?Y1RoM082VzBPZXUvMURjUXBKUG1BN2Q1dzlEZDdRNCtNakxhV0NDL3Rabm14?=
 =?utf-8?B?ejhVWXR0T00xMmpYaFZZR1ZsVFpTWEg1anhOY2kvSTJ5VHl0MWlLWkNjajh2?=
 =?utf-8?B?MndNTjRybVl5VWtOS0d5QVplOEhLWHJlRUVMdHJPaGtzODNZYlNjVCtNd1RK?=
 =?utf-8?B?TTdQY1g0YngrK1R2dzR0eGZ4bCtlNWZ6dEtPYUR6ZDVjdnZXdXl2RzZLODNZ?=
 =?utf-8?B?dWFyR1hHRjNWeFJjc2pGM1B5VmVTTDBBWG9ieGFjU2MzT2c3VC8rL1diWldx?=
 =?utf-8?B?d2ZSanY1OGhRWFF3alRDMlVTS1hOQnBWS2pYM2xMWkFqeUd5TVdsR2hQNzVl?=
 =?utf-8?B?aVhsbVJmMGxucnFaZU1zTjB5RHVjRk9PNFdkanc1SlNSN2J5T1VDZkhNZUF5?=
 =?utf-8?B?dFU3NDlXakxVKy9RRHBGbnVTaDRwMktwaldzNHhoY1ZuRDhrOHcwL3VLNm5w?=
 =?utf-8?B?YkFYM3Y4d25La044YVU4NGtDbGpzSDBFU3NuM1JhWnZ5RXFqMk02bms4UGJx?=
 =?utf-8?B?dHZqUlEzb1Q0V0pSalBhc1I3VDV4eVkrU0ZnblRwZ0J6YXliT3pWK2gyM1Yx?=
 =?utf-8?B?MEwrS1cvb0ZBaTBhY2hsRmViOWpVbWlDWHVyMlpybnhrNjZ0dmxLaUI0UG93?=
 =?utf-8?B?SDlZM21kOW9qeDBVQUJPdk1xWWpqbkpFNVU2bDB1VXA0WEt6K2hNQmhHY0s1?=
 =?utf-8?B?VUYrZXh1ZGNRa1krYTh6U2dQL1dJL0lEN2JwQXhYdmo3STNzOFNBT2c2YWtw?=
 =?utf-8?B?YkM0Nzl5VVlCUUoyb0FwT3ZENy9oaWFQSWEyRkxZNkJMM1RjUEZWd3lzdVkw?=
 =?utf-8?B?aC9YWk9Jd0xUNWxVdVpoN2pDdWNMOVB3Y24zU1FBeERUeXRCQkJhSGVJaUdm?=
 =?utf-8?Q?dD1gdD7tf1Z4+/how9iHyWY62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655c31cc-6ec3-4ec5-1d7c-08dc5336c07c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:03:00.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sgjALLNVXVu/S9CapOJHWSD4DcQklJueNYMJ3Ug0n8sZ/2kf0ryeekNRSPJ4ooN7mIKDSH23uCY5acGTIaX8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401

On 3/22/2024 6:02 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, 20 Mar 2024 23:39:54 -0700 Brett Creeley wrote:
>> When the driver notices fw_status == 0xff it tries to perform a PCI
>> reset on itself via pci_reset_function() in the context of the driver's
>> health thread. However, pdsc_reset_prepare calls
>> pdsc_stop_health_thread(), which attempts to stop/flush the health
>> thread. This results in a deadlock because the stop/flush will never
>> complete since the driver called pci_reset_function() from the health
>> thread context. Fix this by changing the pdsc_check_pci_health_function()
>> to print a dev_warn() once every fw_down/fw_up cycle and requiring the
>> user to perform a reset on the device via sysfs's reset interface,
>> reloading the driver, rebinding the device, etc.
> 
> Dunno, to call PCI reset you don't need much device context.
> Perhaps you could allocate a work entry, throw it onto a per-driver
> workqueue, and return. Basically some minimal viable way to
> "asynchronously" call pci_reset_function()?
> You can take a ref on the device so it doesn't disappear.
> And flush that queue on module unload.

Hi Jakub,

Yeah, this is better than my proposed solution. Now that I'm back from 
vacation I will work on a v2.

Thanks for the review,

Brett

