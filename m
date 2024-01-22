Return-Path: <linux-kernel+bounces-33079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A264883642C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5D71F24C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934023CF52;
	Mon, 22 Jan 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hRD3pUvb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB43A262;
	Mon, 22 Jan 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929325; cv=fail; b=n6u8YDtC0bjayedZndh01K/4t7BtaAgPtS47G4sfmKAQa0fXwGgcKx8VAND+zisEn8Ragtkvw4vJiDKwBMnCIToIZx562abO11zaa8885O/MEhngMMptiM+5PSRepK7w6hGXBGwsbN0zyEJ7SSwfY/8uQI2usMVMkE9b4U/TvZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929325; c=relaxed/simple;
	bh=Nuclh4JINr1oPtcygM6TTMZVvjlK2Fuj++KV+ExZz4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cSmxuKZLB6IbX+rRDQbh3aXJf1VCWthd0JZtnrvdfjKm38fhQhjPhUQYOGJ4npdGlDrEdi0zdRQ1IPIBgZioLCcqCZNgCsIwIJD7z+/hHQYYrLYZUgnkrHwng7z7C326GrAsoN3hcuwZ4Oy/QrDcYfBZto+/FAIq88p+uwujG1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hRD3pUvb; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDraxH5n7Pvu3aVoPsiXXr6HlsD+xC84iqVPwl4i98wbJLYyDBLJGgQTycovSmaNRwxVWonp9IBQEh9+ufkWBB5MLQe0uVCXLxXG1XbHHIK46kJV5DJ8KRELwwSN/yzgHzNhZ+FOFO+g0dgsGOyH2wcbC6p03O3IlcxNFZPdT8Iv1pkr9Y3csvMpXHsxTZP/mxAwk8cUfhaJvc3GYKqeGVi2hOiUmEg6q3dkKZghvfmmk7MmsdJvdcAY9xqXm9S4S7r/jBW/yIPBj/NGgLsoQ4VI41ZrxyCl5u0rrvLGPhB+N6ouhef2pqLPfSpB9v83ZJrdCaYXlhKY77DL7DPfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6OZWSVQfXbNCAkj7XsaDUKlnETBiKHw13UYAq7jN+A=;
 b=bapiBHhwZshhYVAYs/VK6wCfGej288/VabxqjtQLr5d4QrhD9XYg6LoxE2uvIr+O6hxbDUzfmYghjmXuICwT4ehsFwhzQnGXwLAnb3TlU5xTBD6ybtGWear/4YkEIY8yJxi32tbfuzV5blcQL0Ok2970F0dZVUJsLIEWToaLdm+5Y7aRs4rFV+MLFK0IlH35DgyuGWjHjCrSErl5MR3FZFH2jPwr5ud8JqJKo/5nSsGKkYTCB2dOlPgHckHG0vWlvyif6xptDjUwuD9TpAvhPFf8bOhjB0p/jz+zhky1rz0nRjHcTeld6Vk1RkncKbq/SAv1EzucNdAkVlMT8Yk0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6OZWSVQfXbNCAkj7XsaDUKlnETBiKHw13UYAq7jN+A=;
 b=hRD3pUvbTlWaauXNQwQF9TAvj0GcNOwFp0MhhtG1SQ/Io/E4/oaxSxDhZXCBK+QrNTsXPwpjF2vjw94Siqf+fSigNKR2BXKO/2Db2PcYRab6YRSi2K/VMy46KtSNb0WQFpjw4sb5juXFZKIVgwOJvDJDaFyZ2kXBSZS8d+8dn78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 13:15:21 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:15:21 +0000
Message-ID: <6cc108e8-1d5e-4942-a969-f751f481392a@amd.com>
Date: Mon, 22 Jan 2024 14:15:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] arm64: zynqmp: Some DT alignment
Content-Language: en-US
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1704728353.git.michal.simek@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0302.eurprd07.prod.outlook.com
 (2603:10a6:800:130::30) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a66d54-cb5a-4478-509d-08dc1b4c2fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pjkdp9IYgL1hUmqbZ1VXrugp3cbSglpeNbp44GhgKGpVE7U5KvFRN8EnNzD7CY7CjwLAqHE/LYEZcUhMgkUhFhJypUE1HjNlMFWdoUOQYvIpXZc2ZzuMo5OK+ICGddJ5LtEyUup5y1Gbe5kEHxv8QnXitW2Xe3tlMSUAuGUNTd0yuE3Xze4EO9PWC1jGTSXcG3mj+ktlsTu6WQvtNeaEK7Do9zqoVM+LO7jvu14RCDKxk4w0bl/S4GXYSkeri1nYM7fOp/HvyzzM9QppUkFnEwLSDvqqk6wUXlnmIXJqgn1TXnDVHYV9exKxBWLaQay2xYBadBWZiTFe3+gxh1eybmUUDZHfJCVeY+U+n4Yd6csWkFnxgdPsp4qX1wLQX0Bo/1hyl9FTf0V4gEHIYfSf1DB3MgSaZkmfAJj90CzQt2qEFPz7W6nmprwZ4jqufURc9M5tDLdLbnkrvqWTHgTFS5U8QrKwQ0JqvyhIa5rQwHG5ppWDl2dK1D1sp7gp3UT9P4hAgdB8GlM17oI+X32M38kP4U8ForGLCq2b5zw7MKKk8NiZWPiLtdqxLDMX155TBMQmIICOP09UezBAl7l5mikNkzn7gQCpnvOLsVAmR+wmi/v/BCuHLmIWQR+fykbp4nrHQG1+uBcPVJCeoErmkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(478600001)(2616005)(83380400001)(31686004)(6512007)(6666004)(38100700002)(5660300002)(2906002)(44832011)(316002)(86362001)(31696002)(8936002)(966005)(6486002)(36756003)(4326008)(66476007)(66946007)(54906003)(66556008)(41300700001)(6506007)(53546011)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEtRQzM1YTRvNG1qTDJ0Z1gwakRLTnloRURrK3lHemhHMFFaWll5aVRwUVVS?=
 =?utf-8?B?QkRjSEZMenJ5a0prNHlpTW1rOFY2T2YvckUxZW1RdnRaN3hVWlhzVm8vcTVs?=
 =?utf-8?B?SWlYUXZBOXdyeXBzSjcvSldlYVRHcWNXdG5seDgybmowbGhsbUxaeUJVUldm?=
 =?utf-8?B?UERycUlEcVN2OUZTTExlZzZ4alJ2N2tnUVRMcENwaTRrWlVzaDJBVzVGTzZC?=
 =?utf-8?B?ZnZyei9xRnNDUm9tZXZ4cmRkc3VJWE1aTU1HWkQzMzJtZ05kRHR2VVJSNE1y?=
 =?utf-8?B?UWwxU3dmRGhPN1BZaVZhKzlqVWpiOWx2SWlpMnFuWmpLNnA0dGd2a29HSncx?=
 =?utf-8?B?eERaSzFubS9JQlhQUmJKeTRyOVdHZnpkMXBPNXBjKzh0VHZnVGNDYWVOKzl6?=
 =?utf-8?B?c013VUZZc3cxY0ZHengwSHNGeDRybm1DbkxiT2c3RkdxOTJ6N3ZiWDlSVlJw?=
 =?utf-8?B?MVF1Qk5maXd4cExKZEVtc0t0akR1NG1xMndzeUQ0RG1JdkhUSTMzZXRiUUoz?=
 =?utf-8?B?NkNEN2hzQmhKb2pvQi9lcWJkbTJwWkdZUGo0eXZVb0RzaU8zZGdBYjJMcEhY?=
 =?utf-8?B?ampIblBBcUtBbHFDL1lWYmQ3U3hKU0RTTVhnWTNtTjR1SjhMaVA2QXVQYStI?=
 =?utf-8?B?TlVCWHJPU3QyT25vVXZVUTRXeCtrakRXdmdvQVc1UVpGQ1krSlBhVHVabk50?=
 =?utf-8?B?MGR5dFFxYTlVT0dIdy9RSXlHN1JGR21Mc2FEbzExeW84RXhjWUpFS2xXUVpv?=
 =?utf-8?B?cEJvK3JBdDBhcDNnb2dtaldRRWFDYWx5RExIM1paV01RN2FJcEZFbGt2c012?=
 =?utf-8?B?Y3FHWCtDNmg4ZmYyNFB4bHVGeiszRkxUL3FHSmE2NDNiNWJBL1lXeDNHYlBx?=
 =?utf-8?B?S0xmTXhaaFlnSVVOVWtxZEZyNm90K1c2TWFBckU1eEk4eTN2cmJuTmNCU29w?=
 =?utf-8?B?bmZ4VUdDV3pyN2V2ejlQQ0R5MStwQjcySlpBdTJNMFRyQjZ6SVZxV29veC93?=
 =?utf-8?B?TU1qb3N3WHVVV2g2d3J2QVNScmQxRGtzRXBoRk8zKzJwN0dQSnFCdFJVbGsv?=
 =?utf-8?B?WTlmT21scXR1bkdjbXZkdy9DbFB1cXJOMWZTMVdaS3VyMXdTSitkVlBFcFd0?=
 =?utf-8?B?R0FkRmhmSzJtaldOK3RDRlBkRmlodHJBa2VQbGRkc3ZIVzVFeEhzb1ZFQ1VP?=
 =?utf-8?B?ZmwwcUltcXpqZFFnSWFUOTE0UU5Gb0FRQVhONFBLWTJ6aTJBY0VrYTEwR0hC?=
 =?utf-8?B?SzJUSi84WWtmT25mZGNhQkRJZHdJNUdBcTZXYTFGUC9peXllM0prbTBGN1dE?=
 =?utf-8?B?anViSGZZdm9LV2xZYTkvQTUzZ2NoK1g3TTV0NGI5R1JqWjYwZit2R1BmZm9R?=
 =?utf-8?B?QW9RRXhsMGNnS002bnFBbnUyTlc4eUt2K1NhVVJNamJEaWZhK3dhZEw0bmY0?=
 =?utf-8?B?Z2h2SVBpQ0V6dXQ1MTZ3UG1xQVFYYlNYQ1Nnb0NNbUtvSkZMa1NJM3JYcDNx?=
 =?utf-8?B?c0g2L0YyYmpHRWh1d2tXdWtFVFNjUGpIY3YzZVhOaDRJbEl0aHdBZnRJaFZl?=
 =?utf-8?B?UkdhNEh2TW5Jam11SXNTK1B3T1l3YW9ZMVZBYjQ0Y1I0K0lpSGI4U0FTQlZV?=
 =?utf-8?B?TEtRNmNEN0c2RGU2UnJDYzJMVFZ3SVIzcExUTkgvV3BKaEFLZmZteEl2bGd4?=
 =?utf-8?B?bU1IekZZOEliNDlLTHk0M3lCNkNJYitwYTZtTVFFNmdQenRwSktCOGRObkdD?=
 =?utf-8?B?NlJ4YlpEc1BHTEJnTnQ4S2tCeHNpSHcrNVFxVld0RlNBSmVmUE9qUkFKbTFC?=
 =?utf-8?B?M2tqQjRtWG14cnBQSTI2YWtMdktXM3FIUDlnS3dZYXU1VGxTR0lTM2kxazZy?=
 =?utf-8?B?Ylg2SitZUE5YMUJOQ29DM1E0KzJZdVc3d2c0WHQ5dzU4ZWdvZEUyaVhxRUE0?=
 =?utf-8?B?d3NqdDJHbWx3TjE3N1cwLzczRGNLUStHK2RIK1ppdjVQdzlzTVR3TllLMVRI?=
 =?utf-8?B?ZGluSXRYWGJLUTdXemNXb1lzTjNJVU84TXNMZy9Bd2Z1eUNxajAyazlwT3BZ?=
 =?utf-8?B?SXhNUTdOcjJsQTcwWmlDcGFsd3RNclJpcm8zSHo1Y0J1MjNoOU5rSzRIRUVy?=
 =?utf-8?Q?GOZlCThecMnBWQlWbS8loz9l2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a66d54-cb5a-4478-509d-08dc1b4c2fd9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:15:21.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yih+ZD1oWcVL2QQn2t8Q7DwNJrEvUeuvHy4MAnmUQicm75PklA/DLjJiTgbUZL3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604



On 1/8/24 16:39, Michal Simek wrote:
> Hi,
> 
> I am sending couple of patches to update DTs for current ZynqMP boards.
> All should be aligned with the latest DT binding and should also solve all
> build issues reported by W=1.
> 
> Thanks,
> Michal
> 
> 
> Ilias Apalodimas (1):
>    arm64: zynqmp: Add an OP-TEE node to the device tree
> 
> Michal Simek (9):
>    arm64: xilinx: Move address/size-cells to proper locations
>    arm64: zynqmp: Setup default si570 frequency to 156.25MHz
>    arm64: zynqmp: Describe assigned-clocks for uarts
>    arm64: zynqmp: Fix comment to be aligned with board name.
>    arm64: zynqmp: Introduce u-boot options node with bootscr-address
>    arm64: zynqmp: Remove incorrect comment from kv260s
>    arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
>    arm64: zynqmp: Comment all smmu entries
>    arm64: zynqmp: Align usb clock nodes with binding
> 
> Neal Frager (1):
>    arm64: zynqmp: Add output-enable pins to SOMs
> 
> Srinivas Neeli (1):
>    arm64: zynqmp: Add resets property for CAN nodes
> 
> Tejas Bhumkar (1):
>    arm64: zynqmp: Disable Tri-state for MIO38 Pin
> 
> Thippeswamy Havalige (1):
>    arm64: zynqmp: Update ECAM size to discover up to 256 buses
> 
>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 16 ++-
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 36 ++++++-
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 37 ++++++-
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  6 ++
>   .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |  2 +
>   .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |  2 +
>   .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  6 +-
>   .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 10 +-
>   .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  2 +
>   .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |  2 +
>   .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  4 +-
>   .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  4 +-
>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 12 ++-
>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 +-
>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  6 +-
>   .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 12 ++-
>   .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 10 +-
>   .../boot/dts/xilinx/zynqmp-zcu1275-revA.dts   |  4 +-
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 97 ++++++++++---------
>   19 files changed, 204 insertions(+), 70 deletions(-)
> 

Applied 2-14 patches. Patch 1 should be revisit based on discussion with 
Krzysztof here
https://lore.kernel.org/all/f2c1cae3b845d4609f8181f2dcb09a55f705667c.1704893723.git.michal.simek@amd.com/


Thanks,
Michal


