Return-Path: <linux-kernel+bounces-60542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235885066F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FFE1C2315E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A95FBBC;
	Sat, 10 Feb 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z/Ok9np5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E66125;
	Sat, 10 Feb 2024 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707599734; cv=fail; b=LP5pCuY+8RPAqSr1NGcF5nggO+Q/UX1NZ28QmO60bZSc5N7UGgl01WZBXwiSWCuFpJd3/eproL781gEjGnrq3tdTt/Pq5thZypKEZ4S3mHuMAN9HChAQ/63Wm0mRXkjfXK+s4x1OPC1XTsMnITXQO4oAX34N+CqRO8/vb+WR4UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707599734; c=relaxed/simple;
	bh=uW25Xiqce8ItVDJH4ffdavl5kBmMWGsutUAQZ5muLdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hw1qECprNkdEyL0qblw8bl+neBg1YnhVcsOUFISzkeKjq15j/Luwx8H0/u4MefDrmQUPQcDPFOTvP1OCv8r2fTIX3fJv9A6A7L/wqT5eqJdFxhbFxuz0yy4mFIn+JPDFvtXsJSQj3GjvuSvvaw2EYSwLnHAC0gxU52sXR8y+Xac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z/Ok9np5; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJNQfOgiKOy+Q5W/qU+ORkZg1qFhXv0Jvylu8NViT0QGuQps6Qr2rGluClj/JFVDEVDLtxcrdocwnT5yIhkyjqT4yjMlr3ITl2UaHHreXU33pOWw0/DULw4t4ItW1SfK5UMjcVlEs2cMXJu1B6XGKQMQb00bl7aDoiLEW/0Jp+ifQnJ8Ekh5oeEuOpsmPaIwvf39ifAyF0ygfE0HEtSsG5DVvwGOw4DPv+DHrj8R02WsOi+L1T8c9BKSRRORzFJj/xgkHFGvUja8u91MoxU2xuhDMf5U/KM+JKrcJDEVkBfppOAfyK+rfEJNZ+9ePRneb75V2p2SEmJkVEDl3BmDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obr4UVpT5zqw44eRIuG1fJK9zQbbqWOD6L4VzPotulM=;
 b=mEmL4Z+gjsrGYc/jOfO2teCxmWVbfA+kJ/PgOqD6OQjR+g0nMCQhIiRgiAv8EWbcp3SxOeqnD0mm07ncNHq5S4hbRyvgggTec70DJEzysmkpXOMV39tSPjMlkRr9LIvf/MCO532k5mNeN+OY1KAWtxP3W7df56KgKZNr/LKsF/azLGZttYXtPrS2r5Zb+C2RU73UjX+3zdfEq0P7vNQXCWJD18phhxTLxuz5gxt8OkcDkKkClEYymq8IGCSgSwsjfSBIEMJ5LpUe2hYOULQPJHek4LssCDxPFVRyaJokoJiJBoQ1Vh/TG3Wnsp+2be8iDmkNYRJWO8+AsyKxK4HV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obr4UVpT5zqw44eRIuG1fJK9zQbbqWOD6L4VzPotulM=;
 b=Z/Ok9np5fWRKHko55mVJAqnm66Mes5EW1+yF95qEG+qah35UW/50ya7+d5k5L3YsUxicy/m+Ew1Z8LEHgu4YH3H2D8C/DRLwHtz3xMTFQxOqbNwvTaH36ho2tBHGb2ijS0/Iv0yERJrq/oaMaNC1e0zKujPTwAL2yvdLMaYnmTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Sat, 10 Feb
 2024 21:15:29 +0000
Received: from IA0PR12MB8424.namprd12.prod.outlook.com
 ([fe80::5f4d:73df:c733:55c]) by IA0PR12MB8424.namprd12.prod.outlook.com
 ([fe80::5f4d:73df:c733:55c%7]) with mapi id 15.20.7292.019; Sat, 10 Feb 2024
 21:15:29 +0000
Message-ID: <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
Date: Sat, 10 Feb 2024 15:15:26 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:610:11a::20) To IA0PR12MB8424.namprd12.prod.outlook.com
 (2603:10b6:208:40c::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8424:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ea61a3-1487-46b7-a84c-08dc2a7d6877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EXPExHo0/6Qb+B21xPIQl8AcG44ZFciu/CVjzPQNDp7vc1ImHmVBzez99/LmpaOd/PnyEo3LOtanlSsSv4OhTcFYYbrXdTu07KNeKuWlQG8QFqkMPP3nvYF2xUuaCkCHdjnMLMxl2pOeFv8z8RzSNAyNe0mqtOT2lf8iiM5jAkt/wx2ScreYgGxH5yNUkBAp+F4pPhzb0nFQVP9Tc69gXRR14HSC0+s8B8ZTIHg8PTVIy17eb9xUeijeoY05tkjArLdsyn4zVcFU+iKAZzRZTYOEk7f0WrTAaLPGFd36Uusm6SC9Rqa7hvSh6XDNA/U498+mokHOy4AaNWVJ12vm3QEMtLMT44xtK1qc+srygJy91igPpLzfgUKzE0qmR7VIZPpHAxKsX8QGcEnkrKem45QtElUxlDadfo/qRBkReyqcwrXG/OG4tweF1qV7t0mXykbH4EYaAP8OMcNPbFV8aQiC+kzm2SAegUoy04T4kYgKxcHaF1ZayPdlo7YIOq8vjkHLxCAxGVIG+hyd82Gup5I6swvc/9MreJaPEv+AZ2UBc/3nQCvY72sK5MQqjjy2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(6666004)(316002)(66556008)(5660300002)(2906002)(66476007)(66946007)(38100700002)(8676002)(8936002)(54906003)(41300700001)(6916009)(4326008)(53546011)(6506007)(6512007)(6486002)(478600001)(26005)(2616005)(36756003)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWQ5UTRnaUpDTmtweGI4RFdPeUtVbHpQMXVPWnJIRVJhdzgrRytNN3NvT1JR?=
 =?utf-8?B?KzFRdk1DMFFmRUx4L3I2N1I3SjBkWjdUaWpJeUVZNW9rYytZWm1BaVYwWUJW?=
 =?utf-8?B?ZGd4b1ZNS2doajByNnQxME9MRkI2a1pxUkpPM2QybW14amhxc0pOZzF3Z3Zm?=
 =?utf-8?B?cW0zeTNJaXg0S2RxVmhjbHk4MDNvUFQ0WlJ5MDYrK0Yyd1V5eG5mdXp0cXRr?=
 =?utf-8?B?SjlLZWRwd3plNzZzUktrbzZsRkVlTnZ3UlExamRibFVFMHZmbHdyN2M0ay8w?=
 =?utf-8?B?M3B0aUtyMTg5aTNIRkY2V0ExTTUxQVQ3ekNIcmttdVhaS2hoRzZ4TVl6K01Y?=
 =?utf-8?B?T1RwRDhwSEg0Z3RhRitNc1prVmdFeFVlTlo5MUpjM0kybkdvb1Bac1BWWE54?=
 =?utf-8?B?K2sxYW0zK2tScmJBOVpydEJ1WnI5cVRvKytMQkxuTUxBQjdBblN4Ny9qREU4?=
 =?utf-8?B?c1JwYng5K2RqS3I4bVJSNFNjKzY5cnNmb3NnTzQrUTJMWThEMUZYUU9kNzZM?=
 =?utf-8?B?aEx2NlE3Zk5BTVNlTnQ1MXhMUjdrK3BFRXJFQ2oycFhxTWtxSFhPWEoxc0tt?=
 =?utf-8?B?RkhoU3B2b1cyRGMxUUN4SkJZZ0wzRDF0bjREaTRCWkRtb0QwT3hRd1JlOEo1?=
 =?utf-8?B?NWhCazNPYXQrUWZqSE81Q2RtOGRIVkJWZjFHQ2p0a3VWci9PSGVZVTIrUHlt?=
 =?utf-8?B?Z2xUaGV1Wm5WZ2dxTW1ENVNrYmxSQy82aDBTcGYvcjl6NndqdEE2aU1wUmFt?=
 =?utf-8?B?TDYzL2NhMVViTy9XcERPWmUwc0RQbTJYU3JlaDMyblVBemQ1TWV3UGxSTVhW?=
 =?utf-8?B?N3Evc1I3V2ZNRnNtdUtaMWxSOC80a0FyODMzWnhteEl2UDNuVTVkR2g5SjFN?=
 =?utf-8?B?VmwzZVRJWFFyZEZFMVVzNlRJVCtQbk4vcDZ0VE9xYnUvekt5UDQ5Z3d3bWNJ?=
 =?utf-8?B?RXd0MS9xNStSQWRZM21jZGcvaEYxaHZrTk1Hd0hUWko4TWZtSE9lV28zM3NF?=
 =?utf-8?B?c3dRempTVXh5QmZmMFptMmF2MWNVVFIvM29HdGlmdWxjT3VweW0zd05xRTdM?=
 =?utf-8?B?VGkvUjhDZVVGeFVKRWgwRUc0Q1cyOTA1R1VxSkV4K28vbDVrRXlkZmdWcjdk?=
 =?utf-8?B?UlpQWCtSTU1LdUdJQjFURU5kTUVFZFFZMDYwU3dLVndrMDlDMHB6VXJzQ2JX?=
 =?utf-8?B?K1NCc1VCa1ZOdVVwdmM0T1RTUm01NUsyVW91WHFHYnlqdG1YK29NTzlXYWxy?=
 =?utf-8?B?TllVUXAwQjZDTno5VXkyUi9Ic3UyeGtIUEdmNGtkemI3eGEzUU1Ba081bGhs?=
 =?utf-8?B?U2UxQlZzdTVSeERKZmZHTSsxRTkxcDhLMUlFNHFYcVVUcTAvaWdLWUVvRXhj?=
 =?utf-8?B?bmdyUVlIY3d6TTRQQWk4RkFpcHhuaitZVkZFRVEyZXJLa1dxK1RBZ2Zmd0g3?=
 =?utf-8?B?U2FieXhGaGJaVUlsSXduWEU0NWFuc21JaFZ3M1FmUmRsWXUreC9kbHZtM1Yw?=
 =?utf-8?B?YlNDUkIyYU1mSzdwbURSam9QaFpTczBlWGtyZDBUblpITnNZbW95eFplZGJm?=
 =?utf-8?B?T08zM2hXTHp5dmJSc3liK2ttOHBwRGpmbUZraVMvdWJ3bFhQL3lkZ1A5VWRT?=
 =?utf-8?B?eDl0UGVDaG1POE9pNmRTRDhZZUY0TnFMM3FuUm0rWlBvRFlpeWh5S3Ywd2RR?=
 =?utf-8?B?Q0w0Z1FmN0I2OTRnZEhiTUxKa3MxTlJUbSt5dExvb1hwT1NqMWZobnFKNVl4?=
 =?utf-8?B?bDBCYVJUR0lOTmYrZXppSzZsVXFiVHhGWnJySEJoTkpOUGo5dEUzUUdXM044?=
 =?utf-8?B?d3JDbTQ0RGxYM1lhSEhVZEg4YkhlbEk0TlMwNUNTMnhDRzVBNlIxaTBENUc2?=
 =?utf-8?B?SmZhdEErK0I5Q25kNzRQZFFrb3BCRFlUVFIzRDAybFdlVVFaWHRLMjR5VVJS?=
 =?utf-8?B?aUJmOFVHeHQyTjUxODZXd2YwOWRlREFRYmt6L0E5L0dhNGs3VVVOMUJLTDhv?=
 =?utf-8?B?Y2NacGhocVAxcHhpZERrcnJBWTRxdmNvQkpMd3NobnEwSE9JaWtqK3dvbTFP?=
 =?utf-8?B?bmFsTXk2RHgyQWc1aWllTzk4ZU0vTHJ5NllhKzVtYnV2cGc5TmpNRUhHQk1v?=
 =?utf-8?Q?oNqQPi8yFxk24k8VXWCkN7X04?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea61a3-1487-46b7-a84c-08dc2a7d6877
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 21:15:29.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ0q1iQmx6Y94EeKb+MuHMUaWhlTEG58Enpr334UoD44WPpbFjQzBlp24SoLRaIJKXT8rcl8OSfSi/C9E8Yu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

Hi,

On 2/10/2024 01:52, Borislav Petkov wrote:
> On February 9, 2024 9:51:11 PM GMT+01:00, Borislav Petkov <bp@alien8.de> wrote:
>> On Fri, Feb 09, 2024 at 02:35:12PM -0600, Naik, Avadhut wrote:
>>> IIUC, this is exactly what the first patch in this series is trying to
>>> accomplish.  Please correct me if I understood wrong.
>>
>> Yes, you did.
>>
>> I don't mean to extend it - I mean to allocate it from the very
>> beginning to
>>
>> 	min(4*PAGE_SIZE, num_possible_cpus() * PAGE_SIZE);
> 

IIUC, you wouldn't want to extend the pool through late_initcall().
Instead, you would want for memory to be allocated (on the heap) and
size of the pool to be set at the very beginning i.e. when the pool
is created (~2 seconds, according to dmesg timestamps).

Please correct me if I have understood wrong.

I was actually doing something similar initially (setting size of the
pool right after its creation) but then went with extending the pool
since I wasn't sure if heap allocations should be undertaken that
early during bootup.

> max() ofc.
>
Thanks! This does clear a one part of my confusion.

-- 
Thanks,
Avadhut Naik

>> There's a sane minimum and one page pro logical CPU should be fine on
>> pretty much every configuration...
>>
>> Thx.
>>
> 
> 



