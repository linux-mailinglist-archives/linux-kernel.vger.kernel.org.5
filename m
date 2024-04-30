Return-Path: <linux-kernel+bounces-164488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D008B7E22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10FF286015
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0A17BB10;
	Tue, 30 Apr 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BoqQb4wO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D717A939;
	Tue, 30 Apr 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496787; cv=fail; b=iM6B9M8phwDgsdAczNW48D5gMgczmr8ZOz2C5a2AWKrQGAQEekK3smQoQ5v/3H5JDIGmhB2TAC+p3yBeoJWJScSPzAeTyMTu86qluJeLxy3ZMMlc0NIgv4oHM1fxb/G/h7WWGDN3rcpI/BjH1IakgMMG0rUzWnp1Hjqo4NxwsFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496787; c=relaxed/simple;
	bh=rNPcwG8y01DOePhAokVM8CJR2K2e59T1oj3dMl4x/Iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VUg34xsCUkgL2BWlk4kPJQBr77V6s9Y/6PpVVZUANYQz2yczmcDNtY8qiEzq3Gxvoyw0YUJsMTRmEdHEUIuPI8M+7lnwMN+pH3DNCiCky2Ea5lBluwtuR4vXMMu3dpgmFJrLkvnQgGcjExG/U3lz6h3k9NjRzOFKs5/Lp2y5VXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BoqQb4wO; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CijjzutERX8qstkoH9e3lXcrrwto1RRdUkEQNgXs5ywNOQEAgYDoGWNYvQcbd1t9GAFiJM3DFGgkoAlG5DADgjcTOu6JVvRK0ju0tgoIcumiCZk8/KlK/VLcClfc93QwlwUzEobj7oUiyljgLvmnm1MC6Wuewk1lUB5nv3b14yzgAZ9GiRyIIg18A3QhthMVE1DtXQvtymdUMCeehM3ijFuXca3xdepZHmRWL+6VYr6t6RRBmoOaPzyDWswd8xPvAd/868EKVz5skH5xaghTJlBAC+cvqGFLeuISw83BE2bRuQeKEYt+zH6XVVEQRLY54j38BIpAh0P65ywTaSjxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bzxFI7VIjh0d9VjTeV1VQAHToN16BL4k0VJZBewyak=;
 b=ZywAueQOZWpG8M4g9xLU8fJVdGF2bVK9ymmogSIk9TMpHmvkmCF/xGPY8+T8FDUSYGFSSWMwiF3MEiFcj6JqemBXw9CJG293BB3PYV4LBJtacVlNcDuQB4WE2mgHDBJ2sXZblJtTcodVFtxVC1ADspjAbHiBOaPyisUrqfym9FaZoEJec/6iLqxJ8BOYOhRoCYtV/svUX5HO+8DgvP3XATSDSVuBVGB93zZpl3KkfGMTxA1XwgkSsCVCV+izzzwgGRPvaK1HlyqRzafjKLCrlelf2SJykpspiUBZ8Ct45xunXzgLX8Tpf0EQjfbD8HZSGhea+/kEnFpgmLzT5RnETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bzxFI7VIjh0d9VjTeV1VQAHToN16BL4k0VJZBewyak=;
 b=BoqQb4wOSLfd708WkDBQ9K6hUuHUobh20LJZvO21kJyGeEVrHIrxfZzehxik6f9UtjDXMqUOa+Ff/vOgdm6ZMIEybZ8VHKfJRF49vWV8FdC1JdMHf0t62A3uCJLhW3w2LZDe6kcdEnmbq45nNwU2YorqneCGd7tnsAGh8AghPCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 17:06:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:06:22 +0000
Message-ID: <13bcd356-a5a0-4cf0-9222-bccc01177032@amd.com>
Date: Tue, 30 Apr 2024 12:06:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Fix Pstate frequency reporting on
 AMD Family 1Ah CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, trenn@suse.com,
 shuah@kernel.org
Cc: ananth.narayan@amd.com, gautham.shenoy@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, Perry.Yuan@amd.com
References: <20240430083706.69641-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240430083706.69641-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:5:80::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5d7f31-e63a-4587-0789-08dc6937dc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW1rbFpRTEtPcGpqdlhkUkhFK2hGU3hwL2ZHZ0tNTzJVanAxd2QwTVY4Zzd0?=
 =?utf-8?B?N1BMY3NRWVJpNjhvTjhyLysxLzlPUWxyRFBnNklDRzB5aUFvaHNvQ3FMaThO?=
 =?utf-8?B?REJXR3krQ2dtZXlvdVVDeURTc2QxRzd2SDlLT3NsKzllazBxUCsrN0JqUnJN?=
 =?utf-8?B?VFlDT2ZGU3MrNmhxclRiZzlGYVpsQ1ZzNXNBVUlVb1RSZ0dPeXNxTmJ4WjVl?=
 =?utf-8?B?WDNRQWZjVjd5anhIOVFxa01saDNId3M2SFVvL3dNS051TjVwL3VMd25DWHdo?=
 =?utf-8?B?b3d0VXgzQzRQR3U4UzErUWl2ZmhKMjVoNkl5bWR0Q0g2NmNNTi9vdGREazVG?=
 =?utf-8?B?eHVvYzExZmx4ZS94RzVOOTBzVnIrSGVsMVVtRSt6M2VXajJZdWtXRU9iOXow?=
 =?utf-8?B?c1Q1dE1CVGc1Mi9oZ0F2U09qVEVnSktsbkVhVzRjaURWYTJvaEFuc3lCa25P?=
 =?utf-8?B?UFllL09PbjM4bTlMMFJIdlVJOWxZTjAvSlRqWnQ3ZWQxYzFTYU1xZ0RDak5Z?=
 =?utf-8?B?M2RXdDVtWDZOMTdZbktiaXRNcjQ1bjlrbDhLWFBGMFRkRVBsZzNIdlpYT21t?=
 =?utf-8?B?RlhzeHhUY29EbWhUWldSc1lBSW9QcGxKdGlOVmhCaS9iR3M4Y2R3U3QyajFC?=
 =?utf-8?B?OVVpR3JLSzU2M1BUZ1NBY0ZuaG15aUFBQUdublNWM1M0UVJVRXdVcGVjVTln?=
 =?utf-8?B?dEhMVkVyaWthQ040U0dtRVlkdHBrY3ZqUGgrSGErNk9xZnNHVmh4OUlUeDNK?=
 =?utf-8?B?WVhIc1lVQ25YUXFhbi9GVDBRN2NIY01aTmdlV0xYT2J2bE9QL0E3bnVpTnBF?=
 =?utf-8?B?MGVHVjBlV0EzNmpodURpWGE0Q3BBZzJ6MUx0THBSVUVQYWNqOXpwc0llL3pE?=
 =?utf-8?B?cTFmaFlhUzQ4ZE9QL2libHBXdFA1UnNyUW5aUlAwS2hhTnFCcFRaQitqSVpP?=
 =?utf-8?B?Ym5tV2hjMVJsM1dCQ1M5cUZNbCszbi9SM0tFbTBiUytxTjc1MkdXa1FhRlpN?=
 =?utf-8?B?eTVFNjlYYUc0WXBXejNyTXVsYmpXSm9KSTI3dXlpVlY1a0JMRjVzZjB4Y3dW?=
 =?utf-8?B?b2hMUVR0bERBS2FjeG9wU2N0dThyZ1NuTG1GU2VOVjRUU2pvZ044cW14ckxB?=
 =?utf-8?B?QTZiYkdWeUlKSlFWLzRJUUpJaVcrNTVSeU91dmVEc0w1ZGI0bzZWVnkrMzRx?=
 =?utf-8?B?QVlmZFRVOWxlMmc1Q2VGaStHVDdSZUthbElHaENkYUtUSWw3bXJvNGdTTzZu?=
 =?utf-8?B?TFRwbU9RdTFxU2xUWW5hUUN2dVNacDJpa2Z1TlNhdWJvNWRRS2R3amJNT2pM?=
 =?utf-8?B?c2MrQ1kyelZMNXo5WjNmV3VMdWQ3VDlpY3NtcnQrbi9oVytuc0I0MngySm54?=
 =?utf-8?B?R05pNHd3V1hNNjNac1R5RTNYbmFaK2RhUzg1WFVQWUtJMnQwNTZ5NHdTdS9M?=
 =?utf-8?B?NWYrOEVNSExtNHp0SWkzNURvUzdoOVJEZC9vTVloWnE3M3EwWGxFNE9wQnRo?=
 =?utf-8?B?ZHp1MjBOM2pzSG9zelcwa1ByUk45eURDOFhOTFIzamhrYXorcUF3K0RjUnBE?=
 =?utf-8?B?K1c3aFpiTU1pLzk0cUNDcVBFcitlc0NaV21DeG9QNWVZakZTeURPVFc4azE5?=
 =?utf-8?B?S1JHTnZlYktSVnV5ZWtXUUEvQnY1dGIwVW9ENkNJdUs5N3FJMEdrTTEvR2J5?=
 =?utf-8?B?dzRuU2NkS1FVWlZkOExYQVRtdlJUS1ZDZUw3djJ5L2VPRlZlb2VmaXZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFc1K3VDdStadVJxWGt4Ny8zVXIrVmhBOFg3cHA5Z1FsZERsOEpmYjN2V0dB?=
 =?utf-8?B?eVB1TWd0NDNKbzNEUDB3dDlMRC9VU210ZVJvL2ZqVTZ0TG5yelI0Z2tCYi9P?=
 =?utf-8?B?ZGhja05LbUVXVm16OVJOMDN2aXZ3RzFIbUFVVnRnekpRYWltUXJtcWN0R2Y3?=
 =?utf-8?B?TU94bzV4WlR5RU02TFNwKzc1dkxqQW04NGUyYUdxejdmREU2MmZtejF3RnRw?=
 =?utf-8?B?cG1oMFViVkRqc3BQcUM2NlJNMDJIZ0Q2RFhaL3V2aERaVXJJVCt1UnBjNDBN?=
 =?utf-8?B?akkvQjBxNHN2Y24wNm9SOTVkK1YzSDE4ZzVZZ0dmT3dlamJHWUwxMzdCcThy?=
 =?utf-8?B?azRoUjltVkNaSGVabm8yV0YrQ3d1L1ZmeHpXK0IvTmhydURCZXJibXlYaGFr?=
 =?utf-8?B?NmN3UGxnVEtVWTIyNG8razVHem9EMlhjbCtKcUNJNkNScFIwamQzVkdyYlNm?=
 =?utf-8?B?WWFMOEUyaEJNOFR4UDhrK0RwR0pIaU1tWlNnN2ZvVG9IcWVaRStWOFZ5Q05i?=
 =?utf-8?B?SzJpN3VpYXZDdFlpYTgrRFlRNG1aUERySDdRVU5vQWx5S3QyeG1KYm96dWJq?=
 =?utf-8?B?MFJHeDdmOCtZM1c4TjlOSSszdTh4NnZ4OEJ3cnhxZ2lvbE9aenZ1THpjZjlS?=
 =?utf-8?B?VnpDdTdpZW5WWUpKY3NmaURyWFNmeElVTU5OSVFUaG5YdDlMcGhQcDVleGlt?=
 =?utf-8?B?endCMXVHb0ZyWFMzTVJodlcwOUlHMUlSeFRWa293RFdhbmZSUzliTXBJR2h5?=
 =?utf-8?B?ZHBXMjJKQUlwRG1zN2wreURqTEJrOUVIMFAxVFVGZmtGMVZHTWtFYkRDUEVW?=
 =?utf-8?B?WmFGK3hlZWdldnZ4RDU2TFlBMVlZMG9peE5VWEpwMXBzckw0YnZGTFp5aTdB?=
 =?utf-8?B?NzFTUzlhQ21IZFBmMWZsVVdGSkltL3Arc0ZhekVDUmEyTTRaK3l1RmlTcXJu?=
 =?utf-8?B?VzhUdEQ5WjFhZ0tJMXlmZDFjd2t1QXBQS3dLNjVLOEIvemNDaUtsU0hkM1BL?=
 =?utf-8?B?RXFsUU52SU40VG1XelVLaUhpWGRuMjRmRE1vT1RNc3ZrMnVCY0NQUjY3aDRY?=
 =?utf-8?B?aFRFV0ZUdlZsdkFhNmxCdzM4VWNnUmd6OFVQZ012R0syMElyZVlVS0VLMitL?=
 =?utf-8?B?cHl5MCtYT3NlVVNHRG5reTZYTjA3S1Z4RkZtSU1MZ01uU2VjR2JZTEJTNThZ?=
 =?utf-8?B?WWk5dXpLQTlsWm1EcUxaV09ibXYvMXVJR25HU2oxOEpvamRzRCtpYmhLTk9r?=
 =?utf-8?B?S1ovbG04NjNEVElLS3p3Z0R5UU9yL1pLSGJPM29kYTFnTzl6KzRTc21lSFF3?=
 =?utf-8?B?R0ZxczhvWkpvYTVTOWpsWWNnK2IxejlMSy9OUm83Z2lMTUZPVUlQL0J4aFRp?=
 =?utf-8?B?NERmZ1BJYmpaZzJWY292dEowVWMwZVhXdStTS2puc1h4cmNQcngzMTRNU1ow?=
 =?utf-8?B?Skt0UW40dStmWDJxNzV4WVJ5QllLeGJQMU1GeHBTVEVVQlNVVVg1bnV4alpU?=
 =?utf-8?B?bU9EaDB4UElkcGFIVzF5SHZza1Y2cWp4RzJCZGVoVXZjUmNpSCs0c3FMWW1w?=
 =?utf-8?B?RmE0RXpqMngvYkQ0K1QyeWt1cm1WNDNlYXdDUlNxeUZEd2hyNUIzUERadW9X?=
 =?utf-8?B?clhVYzRSN05TcXR5cmdLLzZtcmJQdFkzY3VWOTdKdFFFVjN6RVZ6WEk1ZDMy?=
 =?utf-8?B?NmlrenNzMlpUUHFHM3BjQTlrQlBld0oyK1kvSGJ5bS9ybDBpUVQ1bmh4MkNl?=
 =?utf-8?B?Slg1N1BlQU5wZWt0VHRwSjlaRGFHR0w5Y1I1bXd1azJYQzlCVVVQSVFpeFc5?=
 =?utf-8?B?Z21aNEsvNjhPRE1ycG42aEJRMVFjK0dZVUh1YlZ4REoyNkVSK0VQNTBSVUl6?=
 =?utf-8?B?Lzg1aE5YTDVXU203YXZyTzBQNFlGaTQrQkpkbWhQTWtPTm1pTFcrVVR0Y3NU?=
 =?utf-8?B?NjhuTnBHckJDTWlzd0MwY3lsb0NLSVFYU2RNbzdtcjF5TS9maS9raXBINVZX?=
 =?utf-8?B?RTBQa25aTDQvbTFjVUplNkdOQXZieDhEbmlhcXpXWGs0b09UdU9JbW9FV05C?=
 =?utf-8?B?anR2dGZBWnBYWUo4SzJnenRLSXZMQ04wRU5ZeC9LeXk2alBzbnJnS3pKVUl4?=
 =?utf-8?Q?86w+CiPcvyHGqmN89GYBJggoz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5d7f31-e63a-4587-0789-08dc6937dc62
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:06:22.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwVlL4laG63f8mhl93fwtJEL7WYOqLJQ8+z3VfrnpksIZ+/E5gRlkOS2SUxrHXAIrJ/wJISC+LnzGWCtNJdIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

On 4/30/2024 03:37, Dhananjay Ugwekar wrote:
> Update cpupower's P-State frequency calculation and reporting with AMD
> Family 1Ah+ processors, when using the acpi-cpufreq driver. This is due
> to a change in the PStateDef MSR layout in AMD Family 1Ah+.
> 
> [ dhananjay: commit log, tested on 4th and 5th Gen AMD EPYC system ]
> 
> Signed-off-by: Ananth Narayan <Ananth.Narayan@amd.com>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c | 26 +++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index c519cc89c97f..0a56e22240fc 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -41,6 +41,16 @@ union core_pstate {
>   		unsigned res1:31;
>   		unsigned en:1;
>   	} pstatedef;
> +	/* since fam 1Ah: */
> +	struct {
> +		unsigned fid:12;
> +		unsigned res1:2;
> +		unsigned vid:8;
> +		unsigned iddval:8;
> +		unsigned idddiv:2;
> +		unsigned res2:31;
> +		unsigned en:1;
> +	} pstatedef2;
>   	unsigned long long val;
>   };
>   
> @@ -48,6 +58,10 @@ static int get_did(union core_pstate pstate)
>   {
>   	int t;
>   
> +	/* Fam 1Ah onward do not use did */
> +	if (cpupower_cpu_info.family >= 0x1A)
> +		return 0;
> +
>   	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
>   		t = pstate.pstatedef.did;
>   	else if (cpupower_cpu_info.family == 0x12)
> @@ -61,12 +75,18 @@ static int get_did(union core_pstate pstate)
>   static int get_cof(union core_pstate pstate)
>   {
>   	int t;
> -	int fid, did, cof;
> +	int fid, did, cof = 0;
>   
>   	did = get_did(pstate);
>   	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
> -		fid = pstate.pstatedef.fid;
> -		cof = 200 * fid / did;
> +		if (cpupower_cpu_info.family >= 0x1A) {
> +			fid = pstate.pstatedef2.fid;
> +			if (fid > 0x0f)
> +				cof = (fid * 5);
> +		} else {
> +			fid = pstate.pstatedef.fid;
> +			cof = 200 * fid / did;
> +		}
>   	} else {
>   		t = 0x10;
>   		fid = pstate.pstate.fid;


