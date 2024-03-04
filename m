Return-Path: <linux-kernel+bounces-91184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E2D870AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6571C212F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1179DCA;
	Mon,  4 Mar 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="02icqJzR"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0B4653A;
	Mon,  4 Mar 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580871; cv=fail; b=uv50a8gAfREb+GEfJWm9lLDwCwu4JV10YsYxdlGsDmWX6GtFnnLX4+jB4YcNEgKJwEW4YFHmSEJm1nI9/c6N7vbsT6NgSRwG6IfoYou7sZgk6Y550Qk7x2eml6TNaODtmcvG6sKZN1Wt+dv3tr0t1blTJiv2rbvBuneLI0ujDOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580871; c=relaxed/simple;
	bh=jw4UD/bGVzI0Gn30QCpe1VfmlX85rQ8lLGa8FR9Z1/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEBp3yZICBykae0QnbghRBm1CZWDScyHE0SKLmq/k7ur7dSVTpg2xPfPu1SH3p+bqNBYk11kUYOEsv4v6cETsye8HTIbz9RL7UZPxdlAKIk6TC2eGqmyvnVdxH61xXwIARck/5+wbqxyhKy/nKnzoePaMccj7SU3G9XtBhZV8UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=02icqJzR; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6PQhpQW0avHYkoSfhu9oe2U9qG2A8pEkTY5bdhYZt4D6YJAUsFuaD47X+F4iJGwidStDKqJWsf05Q59dCZnwaUWa/CGTIHR5F7KUHphmoX45z0XGS8BB0udoOH1a4S9YQVkYa9WDHB8gQv+BohBIw9SqD/LgVYrqui7/oVbZsdCgtxiptR3yQqP0UqxI0aIuNDgKSu0ttLlL+V+joVijJeLel+s8SUI7YFd0PvzmetlTpyxoExYyoKTXKjJy2MlEIsl+kc9KGSNqkw/tdAfYZpyEZtYvCfDrSVbbzFcUFVDghnzoy36/nlzANwsoclz//hokFCoysjN5EqI3Slj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGp+Lt5MbY4QJZiNE0l0uzfbCHyCryLNQ+II7SdaQeM=;
 b=Nv/MZxrvfr4AE7Q33yqr2J/jQtQhWZBwgTuQZvNfzq5TBW7v7wKICkNGRZUNRXcdjwSGjyBNiNrfzTyt37QfrYdaDmO+r7ENPjQvrl0m0FZ3+vPcOjzd3ptrKjWaTcFlRlbV7YO/Ejj29Yb1Iq5FXGl7/b2th7ysx0mjavMO26EVtV9n6mSCrdRu9OosGaE1VPOtL+fP6/aeFXVy7m2iunr/rAQTLWwTMNj8Oz73D4FchLW3FNDR5ui9VCl0Q1am36RoBvt1d1R1C1eOYGa+SGjYwiYW+W8wlFbQhx7frmy5Jp0E6wjZUfKy1U2OK8DwNDD3DPc2GKxqzqPEdGaEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGp+Lt5MbY4QJZiNE0l0uzfbCHyCryLNQ+II7SdaQeM=;
 b=02icqJzRrek2gdgK22z4MzHYbyWR8SqzbNxc13gTazsfbxuO9bATj8BK7X8MUE6fhS6mRbxxxbEBgqh+vSjBGvqeJupx+eTPSn/W3LmZIB9ZDNmaWHLkTRC5hRzo+XQGM2cLod2r3zT2n7pdTCCT0IIuJxvU7PkFDyFizSDSt3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Mon, 4 Mar
 2024 19:34:26 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 19:34:26 +0000
Message-ID: <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
Date: Mon, 4 Mar 2024 13:34:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: dc463d20-0403-4146-87bb-08dc3c821a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GLFZbsBb9rDNtE8W3Askxf+G725EZdAR57Td8TZIN1OqquF8MBcF4JTDxCCYQtvw2SoxO4nnMzdMGVuymIITgxKBXhlcjez2SovWzows7Qk/2nnFHoMW01L+fgRW+99vhM4BWQBHYzM5wPVfmwae8gsi/qnn4Gc696aVdhaeymDydRe7VWwCj15qZjISgO4FgijQjXj0hraF6WnVPubLU1gsGvGbIxc1r6ObnpfHVyIKY3rzug5EyX+W11LYvZRB/wI+KZ7+Nozdwo8xSVbCHvEgSj+GxnfpQg0+jAoM5KzN4WzWM+cuCjCOeHb0kfhf71Xd0hvDpx51CS61hH6inz2QytrWdJshcyIb7PBtibX9MaE4S1Nj2uIoEXD50In14MLmAgPyOg7tdfldiLKZyv3iayDJxt+bg8n6QSP7Ycz6q1KiIQ7+cBSksKb6RuFEaiP3xGIr75kjJ0Ejt8lMHnBQr7BuNIGFeAx2PtBYVk/SCvna0kL4+kHVYBaxTqTbhNj25/kIHANkKxMePLm/QbA5qu0MFM1DQSjHr2xKuHrMlW+QeGFCA1MQ6XTcxxViq5x2EQmFE8GvzKJaKTn0m4omAv1UBBHJQcY0j3nTOPfwJdBxSW1yIs4B5m3iUIK9lvk0XMLnKU0P8Ynl499zFwPpcR56T6bUvj/0XBPOws01tJokYcj2OBwoAZzNz1ZeBOjZPRkpxoa5EYz0c24GvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVMMHZPS2dQU1pOK3N2MThKNDcrVDNQY2pPSjBSWUVUa0ZXRzFENm9kZU9w?=
 =?utf-8?B?YzlqcDJWWFdOR21wcCsxOTZCYm5WMkdML1B4LzNzMGk3Mk50VEk3WWpWcXVW?=
 =?utf-8?B?a0RHZkJLTDRHRzViU05ENTVsVUtsZ2U2YnlWMUphOU5xQ1RkdlM3UWZXaWNr?=
 =?utf-8?B?bWRGZDc5Qmk2N1JUbTR1SzFEemFyVGdUd0tVMSthRDBQSzdCdXlRUytQdWY0?=
 =?utf-8?B?L21qSG01MjVhRnptbVhiaVQyb0d3UlRzR3crajdZWjZRSzJBQ1FWbTk3TlJM?=
 =?utf-8?B?Qmtzek0xQ2lheE9VeEtkM0ZnZGoxVmU4R2N3YlRzeVV6MFFvZGRlOGtRWjdu?=
 =?utf-8?B?emRUcDFmSkhsbEFsK1lEL0JmWnFMQWR6RjZRaWtOUUJqbmFGQW9YcmN2TkVl?=
 =?utf-8?B?anFRa3ZTN1ZUVi80Z0VPOXcxcUtRcDdJVXVjdmUvU3BGVVdIRHB0UFkxazNZ?=
 =?utf-8?B?aUFDR0NRU21HKzJPR01DKzNBZXhLK0I3Z3RJeXlnZmlYTytKMUR2NzdHaHhO?=
 =?utf-8?B?QXR0SW12Rkh2djVZNXBUQlN1U0dpYmF0aDhRc2M2U1pBK3p5bkJzaEhBL3pk?=
 =?utf-8?B?MWdDOExjL0E5TUtJcS9SS2VoWHhPeThJakl0K1puS1BuQyt4SHZidlZDcjRX?=
 =?utf-8?B?NFBhbFN4VnRWeHg1OUNrYUFXUTBZQ0lBNStaRXUyNzZNOVVYTE16Q3JjbTBs?=
 =?utf-8?B?OGYxSU4vMlB1Ym84emN5bVY0cTVRbDNCeFFuVGQrZmlFNXV2dUNuYWR3dFZo?=
 =?utf-8?B?YWYxTTlZTlNjTERhNlFJWGxnSHd6ckd2L1NUSWZlRSswSHkzSEdYdXpGbzBV?=
 =?utf-8?B?cVk3UHVhWGxpUURLUTZnVFIwU3dVY3d0cjNYZzRmWHBjeTFCRVdmenBWaUNn?=
 =?utf-8?B?dUcybk05OHpNN3V2b012UVJXOXZoY1FHajVlODE1VUZJMmllTmpid0tWUSs3?=
 =?utf-8?B?bklvSEsxUGpzOGxwdGEzNTZvdXIwL3ZTQy9JZWErRlliYVNRL1hYdCs5SDBq?=
 =?utf-8?B?b2l6b0YvREgvSHV4d3c2T0hxR0R5djdjRUxHVFhQRFZEcDVtdUYyaS8waTlq?=
 =?utf-8?B?RnptamlxY0xlU1o5SGZaZ3dacUYzSnYzeTRKU2pxWHBWb3hsRm9mRERXS0tU?=
 =?utf-8?B?dWZDU3oybTF3bGlUN3ZGYmcrRTBheEZ2d0tvRXFaMklvNzY2cUlERzhOTnJW?=
 =?utf-8?B?VmNodjRRVHIvRm5aS0NLdVdJRW9GekN2Vm5GVHdOajQzUW81YkF0aTZiUFFo?=
 =?utf-8?B?NlpFalJjSUx0SDJsU3B4bTJRYWVTT3g4akR6N2NGcjhSWW50WUM5QlE5QmRH?=
 =?utf-8?B?ajRFOWMrT0JzVFdTdncvWGsyZFREZVBKMnBxQ2ZRSHVBR2VDOHlDdjV3ZFlB?=
 =?utf-8?B?U1VGRGNFUVJ3d3F6VVpJdG1jVm9RUGZkWUpzY1Q4NGRaUnlnbC9Kdk1nb3Ra?=
 =?utf-8?B?RWpzbUtLVEtXSXorRENLTkhDak41dTdoWktuYmJqb2dYdVovUTAybkI2eG1p?=
 =?utf-8?B?S1RXUytra2U1TzI3MUdqYjkveFpYUW9EVDU1WFFDWXZDOU5RajJIZ0lSb0lh?=
 =?utf-8?B?d05nNXg2eHFqOFF1UnNrdmxMWHFNVXJHZE42N2dYRm10ZDBEcmpkUEUrUTQ3?=
 =?utf-8?B?N05udm5acnlJbCtCR2NXcUcyT2hMczZqSEZKdWNiWVdWU2dCaHI5bExmbXpk?=
 =?utf-8?B?bE5NZTloaHdMbEhGRjdvdThmQkRoMkg5T21Qc0hqWE5VMGZ0UzMrMUh4ZVh4?=
 =?utf-8?B?Qi9DMjZ5Rmt3bUwwSDdEaUpGcllBT3NNZmZPWlZrYnpEejFibXBYV3BUa3Js?=
 =?utf-8?B?MG9Qamwza0NuQUJ2ellKT2lreGZDaGd0MzVtMEE2SmtqdzRrYjNBd01qR1o2?=
 =?utf-8?B?Y1h1aEtnWDNvaEZnTWFVZE8yNFhwaHlNMm5uci9QS2NPcUUxcHdkTlUzazhz?=
 =?utf-8?B?RzlrdG5CZmU4OUEwNm9KcGRkdnk3L0tqd01JeHB6ZXptQ2J2aWVuVW04SGVo?=
 =?utf-8?B?MkRxTnc5aHVjeFZ1T2dyNHZuWkhENlBvUy8wdEc4akNzN0pueTN6bUdzQXFq?=
 =?utf-8?B?cXpmNHFDQVBxcGJ6WFlVVld0Wk1tYVZmWUwrUTJMcHdCY0UvNzBwdmFqM1M1?=
 =?utf-8?Q?8RGo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc463d20-0403-4146-87bb-08dc3c821a36
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 19:34:26.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bm0CF5tlU/UKMAI493E4I3UQhx/LCL3m0BJh8zyi6U/C+u1+H3nUT1LGDa0W75At
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

Hi Reinette,

On 3/1/2024 5:20 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 3/1/2024 12:36 PM, Moger, Babu wrote:
>> On 2/29/24 15:50, Reinette Chatre wrote:
>>> On 2/29/2024 12:37 PM, Moger, Babu wrote:
> ...
>
>>>> To make more clear, let me list all the groups here based this.
>>>>
>>>> When none of the counters assigned:
>>>>
>>>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>> resctrl/00=none,none;01=none,none (#default control_mon group)
>>>> resctrl/mon_a/00=none,none;01=none,none (#mon group)
>>>> resctrl/ctrl_a/00=none,none;01=none,none (#control_mon group)
>>>> resctrl/ctrl_a/mon_ab/00=none,none;01=none,none (#mon group)
>>> I am concerned that inconsistent use of "/" will make parsing hard.
>> Do you mean, you don't want to see multiple "/"?
> No. I think that having a consistent number of "/" will be easier to
> parse. In the above example, there are instances of 1, 2, as well as
> three "/" among the lines. That seems complicated to parse.
>
> I was thinking that it will make interpreting and parsing easier if there
> consistently are just always two "/".
>
> (You may find things to be different once you work on the parsing code
> though.)
>
> In summary:
> * for monitoring of default CTRL_MON group: "//<flags>"
> * for MON_GROUP inside default CTRL_MON group: "/<MON group>/<flags>"
> * for monitoring of non-default CTRL_MON group: "<CTRL_MON group>//flags"
> * for MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON group>/<flags>"
>
> What do you think?
Looks like you tried to keep two "/" in all the options. Looks good most 
part. Will keep the options open for changes when we start implementing.
>
>> resctrl/ctrl_a/mon_ab/
>>
>> Change to
>>
>> mon_ab/
> rather:
> ctrl_a/mon_ab/<flags>
Sure.
>
>>> I find "resctrl" and all the "none" redundant. It is not clear what
>>> this improves.
>>> Why have:
>>> resctrl/00=none,none;01=none,none
>>> when this could do:
>>> //00=_;01=_
>> ok.
>>
>> "//" meaning root of resctrl filesystem?
> More specifically, monitoring of default control group. It is not intended to
> specify a pathname.
>
>>>> When some counters are assigned:
>>>>
>>>> $echo "resctrl/00=total,local" >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to
>>>> default group)
>>>>
>>>> $echo "resctrl/mon_a/00=total;01=total" >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to mon
>>>> group)
>>>>
>>>> $echo "resctrl/ctrl_a/00=local;01=local" >
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>> $echo "resctrl/ctrl_a/mon_ab/00=total,local;01=total,local" >
>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>>>
>>> We could learn some more lessons from dynamic debug (see Documentation/admin-guide/dynamic-debug-howto.rst). For example, "=" can be used to make an assignment while "+"
>>> can be used to add a counter and "-" can be used to remove a counter.
>>> "=_" can be used to remove counters from all events in that domain.
>> Yes. Looked at dynamic debug. I am still learning this interface. Some examples below based on my understanding.
>>
>> To assign a counters to default group on domain 0.
>> $echo "//00=+lt;01=+lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> It should not be necessary to use both "=" and "+" in the same assignment.
> I think of "=" as "assign" and "+" as append ("-" as remove).
Here are our options.

a. assign one event (+)

b. unassign one event (-)

c. assign both (++ may be?)

d. unassign both (_)

I think append ( "=") is not required while assigning.  It is confusing.

Assign or Add both involve same action.

How about this? This might be easy to parse. May be space (" ") after 
the domain id.

<group>/<domain id> <action><event>; <domain id> <action><event>

>
> An example of this, just focusing on default group.
>
> #hypothetical start state of no counters assigned
> $ cat mbm_assign_control
> #control_group/monitor_group/flags
> //00=_;01=_
Looks good.
>
> #assign counter to total MBM of both domains
> $ echo "//00=t;01=t" > mbm_assign_control
There is no difference in assign or add. Just add total MBM event.

$ echo "//00 +t;01 +t" > mbm_assign_control

> $ cat mbm_assign_control
> #control_group/monitor_group/flags
> //00=t;01=t
good.
>
> #add counter to local MBM of both domains without impacting total MBM counters
> $echo "//00+l;01+l" > mbm_assign_control
It is not required to know about whether total MBM event  is already 
assigned or not.  Just assign the event of your interest. If it is 
already assigned then kernel just ignores it. Kernel has information all 
the assignment status.

$echo "//00 +l;01 +l" > mbm_assign_control

We will know the full status of the assignment when we list again.

> $ cat mbm_assign_control
> #control_group/monitor_group/flags
> //00=tl;01=tl
Good.
>
> #remove local MBM counters without impacting total MBM counters
> $echo "//00-l;01-l" > mbm_assign_control
Remove local MBM counters. We don't need to know about total MBM counter.

$echo "//00 -l;01 -l" > mbm_assign_control

> $ cat mbm_assign_control
> #control_group/monitor_group/flags
> //00=t;01=t
Good.
>
> #assign local MBM counters, removing total MBM counters while doing so
> $echo "//00=l;01=l" > mbm_assign_control
Again confusing here.  Just remove total event and add local event in 
two commands.

$echo "//00 -t;01 -t" > mbm_assign_control
$echo "//00 +l;01 +l" > mbm_assign_control

> $ cat mbm_assign_control
> #control_group/monitor_group/flags
> //00=l;01=l
good
>
> #remove all counters
> $echo "//00=_;01=_" > mbm_assign_control
> $ cat mbm_assign_control
> #control_group/monitor_group/flags
> //00=_;01=_
>
>
>> To assign a counters to mon group inside the default group.
>> $echo "mon_a/00=+t;01=+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> I think it will simplify parsing if number of "/" is consistent:
> $echo "/mon_a/00=t;01=t" > ...
>
>> To assign a counters to control mon group inside the default group.
> It is not clear to me what you mean with this.
>
>> $echo "ctrl_a/00=+l;01=+l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> this looks similar to previous example, so I think it will be hard for parser
> to know whether it is dealing with control group or monitor group.
> I am not sure I understand your example, but this may perhaps be:
>
> echo "ctrl_a//00=l;01=l > ...
>
>> To assign a counters to control mon group inside another control group.
> I do not know what you mean with "another control group"
>
>> $echo "mon_ab/00=+lt;01=+lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
> How will parser know which control group? I was expecting:
> $ echo "<CTRL_MON group>/<MON group>/<flags>"
Sure.
>
>> To unassign a counters to control mon group inside another control group.
>> $echo "mon_ab/00=-lt;01=-lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>
>> To unassign all the counters on a specific group.
>> $echo "mon_ab/00=_" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>
>> It does not matter control group or mon group. We just need to name of the group in this interface.
> It matters because users can have monitor groups with the same name within
> different control groups.

Agree.

I will list all the example again once we agree on specific format.

Thanks

Babu


