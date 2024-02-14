Return-Path: <linux-kernel+bounces-65330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA85854B53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4032B1C20AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0655C2B;
	Wed, 14 Feb 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u6uZ98/N"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C253E34;
	Wed, 14 Feb 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920512; cv=fail; b=B+DCIZqrWJwgS2EhXYvH+riNHUxhjdm7uNO8F/vrCMWUzizSbyVJuw3XfdZ1IAERIMxLsjsGHhKDDCv5EClFIa9ailG81k2r+Szm3jhubD/gG8iG5UNz+1VDhunZHyvFaEEufLJGIXDZUW66rUbyGAELX7JJqDPb7gP5NG/shWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920512; c=relaxed/simple;
	bh=Btqy89SGjDYLRNwT4dvVY597aCuwIyfCtjNSp9qRo3c=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCH+yovqkWlhETEWbf/3qqHZWTX1xYbAti88Kvf3/7GarZ8F6cbddzMFGgUGGs7nr3KtmOLq50nMVAZH1ZboV4oRgUkbQEhjYDHZWrSXL6zubggoOBG8uGe4v2QcnzoQJfPDEhN4N8NQ8zkA7oGhxz8+4EUlHHvFr9ne7c6zhBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u6uZ98/N; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAbJ0Ykkr++YRxJFuUM6VoA6kshnLp21TW8i/l5dCkrMZoGrU50gb2Pf/rwRubalpxKjM7xq+S3/t+nHGdb/vc8niBe822MJc6kjsRCpnc8517EsHCSV3r+BQSu2O1JdTch97U8Omqj0tU4plA4Is8RPI7cr6oxGSGVHE6DIlAp54tu6J9zrJPU0h3WXnIn8Wn4LbwrtQXFEU2HMhC1Eih6hPz67KwU5rSJfDCubWEiAYlvWEK8Zft6SkCyYSYQrjfjlVDLqbMi6/RxM2KQ9NIyhB+vY/cRZul5PluaFtOEYBMRStie0pjfOMZv6eGxUtclQWlDDaWbJ7NA0OHiSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD4yz+Sz5eq5flmIVRNIQVZNWNz4v2OOyD91mmX3OmY=;
 b=N/UyeLQICByQjOJEZiG5xrkk+B+N/1fkIwYXzIjM4CYA7LEopVPp5qVUiOXMmD5CjQRMAmzDYJeQLG+jrTqEjcdZztVIq0Z+8JagaVj7R0AAIljx92JyGd9YZleLiIA6kuRRoNlctuMcK+uUKF1pVc1oLJZ8ZIP8AgKkSSQ6jiduHLVOWZIlh3R/VX7x8lPLpa24SeaOsxlWde8PaR6LBleyUgi0ZsSOqbzCgV2ffFro8PXjxeit2Nxz1uez6WyR/Era5zYevm56NvQQgOpr6IuRChw+kxx6nA3S7E+3XP24h+L44fInYeEzpuMPD2lPWqAolqEb3XwyrqFg66ti1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD4yz+Sz5eq5flmIVRNIQVZNWNz4v2OOyD91mmX3OmY=;
 b=u6uZ98/Nd17KVj6H6bgyQdY/qFgfbN0WzDusB6at/Zw+mKCWGOx4/W0i510LJxw/sP76uqs7vjcxLmb7OZ3rzQOCSGJJjHe1f5dCsMTmjvzbW2LTOet/awTCS8zRhUFxkhhpA8+knLZz5iXGrLfLsIe/xVTHj7kQBirtpSWC9Pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Wed, 14 Feb
 2024 14:21:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:21:48 +0000
Message-ID: <9a82e9af-24c0-4277-b4d0-a708bba2cc88@amd.com>
Date: Wed, 14 Feb 2024 09:21:45 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214090630.GAZcyClhFloQfHEqrC@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214090630.GAZcyClhFloQfHEqrC@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:408:e5::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb2da3a-0398-4aae-f120-08dc2d684774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQDv5XFC/qriPuAaFjPGPwabhWb21uDXHn9Rt5UbHBPUv2i6x+MJa11EgZOxDACZtaezWfqBkKv4rydplZcqKp39kG3GNvmCbSJ5Wpj27O9XV5pnsGPiIY3qQAgSzTLOHiFobus62F2wco1yT8xFPnUdn+7rC9zmKYKtQKivp7MU6BUDTXLNfox8ziHi7b3qR1WZFfEhDseq7TFCeVrRUi1336EAe8o3Bab3ZHrS7jbDJ/EBCjs639QIaeBUf+da97MhVmSVzwccqMxKEC2XufqJKX8i9f4YzNEvCHIIaHK03dDTsvZAlyRXqlIp18L5wYzTbXgqH88Rw2Hn/iVOkinNElDd8RQS1X+fhlvcKMh3JvMGHIqGKkyTdpXhZZ4cZfxfjd092yOd09FH722RqAS2QGdXkzHKIIfQ0GQidCKq1ZlvddTdkxNl3KPzF5s253OE8FVNlAKW89yJSL35g9jqzIiz7kqGSr0uZMPzbzbr9l/7/6Q780+xulD4GzutZ4fK95n9gPWU8KL0hdW91JeT2/irLKELobLjnjeAHRXqcOnZsaT02btxTtPswy0m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(31686004)(41300700001)(6506007)(38100700002)(2616005)(6666004)(66556008)(36756003)(44832011)(4326008)(66476007)(8676002)(6916009)(316002)(5660300002)(2906002)(66946007)(26005)(6486002)(83380400001)(86362001)(31696002)(6512007)(53546011)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWp6eklvSWZwVS8xWGluR3BzRUVjVmxLTW1udFFZZndldllqa0daWWx1Ymhr?=
 =?utf-8?B?T0JDSEdvN0VLUEE3VTFySGNFZHgyVnJuc1ZqYTRweXZXTm9sUEQvSTdUVHhl?=
 =?utf-8?B?SXUvMDJUekJOK0I1cGl5bzRYdzdVUVN3S0J0eXM4dHZzVGY5TE5sQU5DNFB3?=
 =?utf-8?B?YXp0eXd6UkRidDdrL2Z4UENYUEVia0VmNnVORy81UW15Sk5OSjROZHhIMUNs?=
 =?utf-8?B?ak5PcUpCdEdrMDl6WFlOYm9KZXlOK3BUZ1ZDU3NlNTFsWlh3dnZwV2N6UDk2?=
 =?utf-8?B?Si9ZdnNneFUvVnJUVzZ4VEFpRlo3SC9tN1FUZnkzR3ZnaG1nRnFuR1RkQWFW?=
 =?utf-8?B?Y0VWZWdNbEJhWmx3WTdMaDVkOHUyL2ErR05ZN3FOblBLWUFhWHVqbXZ3Vkkw?=
 =?utf-8?B?SWR0dzYrWjdiZUNxY21BTk1PSXhYbDgxcHNJK2lOVmpOUS84aHR6ZGJRbDI5?=
 =?utf-8?B?M2lvZHpibEYvMmFpZWtpRmpHRThMamlqTExXMVdaRDN2eStRZnRnL1dWcEoz?=
 =?utf-8?B?bW1hNXJEdHlySTNGazF4LzA1bzBPWEdWTG4vNWVlY2loSjZ1WWZ3MG1OVjE5?=
 =?utf-8?B?ZFdvVVM1eXJxOU5mQk5BOWRISW5UMENqdnRCckV6eFo2OXFsb09XQlc5Z0dF?=
 =?utf-8?B?d21OV3c0WHd0VDNDUnJvUW5CYTg2am4zVjJjTitNc3kxREcxaDZXMXJvcXZW?=
 =?utf-8?B?aDJyYjVvcjM1VkNPYnBYUHI1VFNqRU5QV3IvNGc3TUwzMGV4MjdRTDNmQk52?=
 =?utf-8?B?UzZHZi9xVXFMekFJNWlhOUI4L09odUJXc094THVDYnFpNjVkYllmajB1aVQ4?=
 =?utf-8?B?Vlo2ZlN5dVRCNEltMGtpWkRiemlWUEY2bnl2SEtPSU1KZm9PNW1JRFpBVW50?=
 =?utf-8?B?V0hWUXdpbnM0cjBROHFFN3E5TTJ0bDV0YzNwRlJMeWl4bmdSbUpvbVJQYVlQ?=
 =?utf-8?B?Tjh1RE5qaUR5SzlTT244V1l1RlRMU0wvRVF4RGhBeXFwOHExLzNwVGt0eWVP?=
 =?utf-8?B?THBiU1ppNy8wRThQZWdPTlArT3ZzdzBpTjBrZStiVmx4VVB2TFRzbEQ2cXhQ?=
 =?utf-8?B?WnJNODBIaGw3aFE1amJsRU1IVWZzOWsxYXdqeDBxVkNNQWdjNytUQUd2cFhw?=
 =?utf-8?B?bmJJUmIrZGUvZWV2aENzRTZSYnMraU5OTHpFWk45T2pDb3oyVDJhZEMrY2xR?=
 =?utf-8?B?eVoyaTVvU1UyK1o3dVRDYU5pbEUxVGI4Y1ZycmFmTHp2RDNDZ3hMYU5wVnQv?=
 =?utf-8?B?SXZ4UXBWMzdoNFNKb2tBRnRITWFuSGt2ZXk4eG5zTXMwUHM0RTVuQW9nSEoy?=
 =?utf-8?B?YXJmNEFqZVJibXF2ZGpJK09lSWFpamlRdmpjbjgybjdrRWxLc0lDK29qclBZ?=
 =?utf-8?B?TTZuSFhCS3RRYXNienk4MG5zLzBZWGlJV0Q1c09tYm5VbHphY2JVTnBzWlpa?=
 =?utf-8?B?OXpwU0pHM1N1ZEhuL0JycUk1K0ZpT3ZmTTZqOGV5UEhMWUoxLzhjVXdLbzNo?=
 =?utf-8?B?dGY0a21OT2NyWWtVaGdSSWZ0ZllYRkoxRkRhTlBZcEIybU50QXZ0a0N0M01w?=
 =?utf-8?B?aFBQS3gwajN6ek9LakRKMFZxLzdFb1J2cUNsU2Nsc2I5UjYvOURSWUtxM0w5?=
 =?utf-8?B?Qnl6SFd2akRxZUNjMEZiVFY3OFVGYmV3QXFVVGlybitJd2lNSGVEZ29CY2Rz?=
 =?utf-8?B?UVRDR3EyeXF6UFVNRWV6cG9QL2FBOGN4RWZjY1ZVZ1hWVy9oQ2VkazV5Y0Vs?=
 =?utf-8?B?R3FPYTM1Y1IrQXpmWFg1SWlLbStOZzB6RHY3TnN4YkZtdmRsTHphQjNOSHpz?=
 =?utf-8?B?ejZIQU5pa1hNUVN0cndHdGdwVmRmRndSNkdVWFFxUzhYTU1Bbm4xNGVvcHZQ?=
 =?utf-8?B?Z3dsdGUvRkFxa2lQT1VidTBSbldpYU1tbWdhVVFHYVJYOG9xcy9WT2FRYTR2?=
 =?utf-8?B?Q2dzSjNtVXJMMnV6czYxNmJmNmV6Ky9WRGFNK001YzhnL0FxV21XQVdYSXkv?=
 =?utf-8?B?Y0ZhSU5ZRWtxdTU4WHA0ZU1NRm9ic2NUVm9ZbUhRcnZ1bjAzM2RRU3Q0N3Zo?=
 =?utf-8?B?K3I5ems1WVgyVnZWUnI0UW9EUkxQVUZkWVE0L0dGdjQ5ZnRYdEwxSjdBMlQ2?=
 =?utf-8?Q?SijnVIzHPoq4G2o5elA3q+MBM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb2da3a-0398-4aae-f120-08dc2d684774
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:21:47.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av7fZkuboLq0al5iZP0vtDSBjRvK3Rho9mxgqoenGgQg0c+DF55G5Lw/HTHH+/SzHtskh95vPdt+I3/rRD4f7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

On 2/14/2024 4:06 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> Memory errors are an expected occurrence on systems with high memory
>> density. Generally, errors within a small number of unique physical
>> locations is acceptable, based on manufacturer and/or admin policy.
>> During run time, memory with errors may be retired so it is no longer
>> used by the system. This is done in the kernel memory manager, and the
>> effect will remain until the system is restarted.
>>
>> If a memory location is consistently faulty, then the same run time
>> error handling may occur in the next reboot cycle. Running jobs may be
>> terminated due to previously known bad memory. This could be prevented
>> if information from the previous boot was not lost.
>>
>> Some add-in cards with driver-managed memory have on-board persistent
>> storage. Their driver may save memory error information to the
>> persistent storage during run time. The information may then be restored
>> after reset, and known bad memory may be retired before use. A running
>> log of bad memory locations is kept across multiple resets.
> 
> Too many "may"s above, please tone them down.
>

Will try :)
  
>> A similar solution is desirable for CPUs. However, this solution should
> 
> GPUs you mean?
>

I mean CPUs. GPUs would fall under the "add-in" card scenario.
  
>> leverage industry-standard components, as much as possible, rather than
>> a bespoke platform driver.
>>
>> Two components are needed: a record format and a persistent storage
>> interface.
>>
>> A UEFI CPER "FRU Memory Poison Section" is being proposed, along with a
>> "Memory Poison Descriptor", to use for this purpose. These new structures
>> are minimal, saving space on limited non-volatile memory, and extensible.
>>
>> CPER-aware persistent storage interfaces, like ACPI ERST and EFI Runtime
>> Variables, can be used. A new interface is not required.
> 
> I don't think stuff which is being proposed belongs here.
>

Do you mean this should be left out of the commit message?
  
>> Implement a new module to manage the record formats on persistent
>> storage. Use the requirements for an AMD MI300-based system to start.
>> Vendor- and platform-specific details can be abstracted later as needed.
> 
> This is a big diff so I'm splitting mails.
> 

Okay.

Thanks,
Yazen


