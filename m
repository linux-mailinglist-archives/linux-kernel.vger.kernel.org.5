Return-Path: <linux-kernel+bounces-34986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF3838A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663F9B223AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E759B60;
	Tue, 23 Jan 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rAXucEgN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E25A0E6;
	Tue, 23 Jan 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001628; cv=fail; b=NxYEDp+/V3eFGGjDQz+j+lpgzn254gHl2wkRZi+MGjUeBvXXoastibHwvm2MnC0fQLT6kXenRxNwhwp80GIKxK9g2F511/u1uuGWL3cigk2CPZe6KMrWsEP6T5rTRR7q7l5IVgaDsG9GriHeKkxsOHwVLy1jxCnmhRx9RGHvz4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001628; c=relaxed/simple;
	bh=5msEozwNtR+p8sTFTzKgWX6nrWpHfNTyoWNbbKQYh+o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bI6kDzPWpUKSs/OgyQN/MG2mDbSZYUaE2kHu/r1Y19cXWd0kTGFrk1PAvQO9cBKUtmuP7VwIjkq25aoo18J66i+dKx/jBrYIUOq4pwYnO3xhrZj0c5hQAo91WsyvuHTqLSt6GwLxOustqBQlWSThTAYM3JnzLunaMHAEwzUon7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rAXucEgN; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP68ZUfJBCSMhrrXC3PCofEgjF87ZdNZ+TDPwHIc0dhTjal52c2ug/WcN3BtFfRKph4jPz4NBw63oJD6DBz7XWwG9yf0uL1Ypa+kU93qElUC+Qda+E5nClQduF17RXMNfdfX9y4bdGnIJA2P6/A8geJ5HALseB09kbPcuSj3Ag2BdR5rWar39t/3IIUivVevVEsNDHd4NNn1RAQY0ifdwIsjzm2fydBfBldq22A4rTSMvU5gbovk/oFPntLQR9wozBhtUwajriSJMKRZiwE8E16IFzuQSRr+4jZw9hWB6PohGNdzs/jbj0K5WI1yRAfP9fN21ZBAH8n7t2+GizMqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eotP0HO+Z6+FG1fjaHby3cvHNZrgTWqnoeLWQmun0k=;
 b=oGyC+OBKyqpCcU0G6E8/JqjdFIhcrK1RxCQkfoYw6Q3QuFMGgpt6Ro/be+3Tqj7o3w2B26AOkyBLnQ1zI0cTVXwyfsg9hG9ugDSeXdcw3Gt/x3hgWvUWA07ZpPhCvZutkzhGmevRy60jvD9uDcAKKrEhIpRljvkcKWIwNJfZFB6XL0rU+v5nFvsoEqNqJvw+Nb+QvGdCNoX9UXKOQAxdXkyGeGCyk1A6sxvfjoOlUV2LsNOYvzSdFxGPPoRHHeEDc+JynRbCjRsDKm62fFnoazl8b9zmrsbWLV+A6URpvWvSBsWaKfDkXLN0/16YcWU1PBeA/GLIA5XkhPMhrthUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eotP0HO+Z6+FG1fjaHby3cvHNZrgTWqnoeLWQmun0k=;
 b=rAXucEgN4+Ii8t7biKEXXsbYeMNV2lVrE5Jn8HmLqJ/4fgjiPb4tBJRInUik7HMNtICduFB0DBrGw8+hyPy4DMX+mXYa5GM1txS05WerpCkMuDTRQrGS8CBf+v/1qkjKiqSCIALnTioP8/JBpI2UGVnsQxQc8PBF3RDkIDCOiu7VwxwooUO5oIKOjgpwNG86r9wNU72sa+ydDwx8kDs62OrgoAqFtr7q/N18Icqau/E4gEhvEnwqcfd4lwcsBmRbmxJDGk6qtDs3E+V+AXaHms4BWnQhLnoj1zaIuXZyGPZKAQfXyFPS+V6PspGRUuQSEf6CPqgLb2zPv675/fiP/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 09:20:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 09:20:23 +0000
Message-ID: <a00a3d5f-9d96-4886-9ebe-4e2962667ab3@nvidia.com>
Date: Tue, 23 Jan 2024 09:20:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: memory-controllers: narrow regex for unit
 address to hex numbers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Dmitry Osipenko
 <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240123083517.21091-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240123083517.21091-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9124f2-96bd-41cb-f26c-08dc1bf48752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yskk5E1JpQ+L12OK7ygp4BvAzzesIHh0SBoTJgNJoacgzeXXfxgIsS7ZsvpAEB2yOuFxqdOdWCMQjEGFpknwdjDCmw0u2Bekf8IZj+74CGa6++udfp4aR+oPIh1g1g7MJR31VS8H4/qWRJMocsuYjySzVXplDZCRID8StF415fYZXxNPKwxsSlIM87OYukp8+JDhHJBFUmYKnzltoYsnGhs+GhhqaSOG/Fr2pstwtH+4mBZX51meydkldkSXQsJcC0EvsLINijvU3JYZ3v68NgrtbG2OGQGbUsuVit/JsLDRH8ID+UXB3XmjQjrDyyy99ESvTRxVGFnG/twxPfgXGKwUb8GJaNOTjfDNMYWPS1NpWWhPnGCbJjnwSA1ottiHHzPUlna8Yt0n5yp/fvx0piHwEsml1AKvRXDDQtc68h7T0yBqUvZ7qnredVmHFFlpKv2zejv3cSPGtF1aPMpsF1Mw/xcMdOEoKvUDhf8zVIc3bqlTNRG9XJXXU8amwgPYQlbCGzLAaFhM4ChFyFWd/PJEUlB+zdKLAElKImMd6SRw1AXRtxgjIb5VjS12IwFOSvxTGu5zK5UteknSiz26sK5GYsxlKLtqawTH9tuSDdoBi08oHa6guIWs7I+g3t2lv5sjBXc7AfvUopN42ZIoQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(316002)(8936002)(478600001)(8676002)(26005)(36756003)(6486002)(83380400001)(53546011)(6506007)(55236004)(6666004)(2616005)(6512007)(41300700001)(66476007)(5660300002)(31696002)(31686004)(38100700002)(2906002)(66946007)(66556008)(110136005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHlQbUdtYmkvQ3czOWJ2WXZxb2tpbWZtb2VRYWJlMXVsQ3VBTjB1d2o3Tm9h?=
 =?utf-8?B?OG1JTGlmL2JUbGk0YTQ3RFJWUlV5OThpNGJYQlFlT013YkMzZGFOeTlRMVlU?=
 =?utf-8?B?NS9IbjBUY3NqU296MDBzSFc0Y1NCRmliRXNiR1o4T2JHZEZQWFhtRlhFS2JC?=
 =?utf-8?B?OTIxYnJtU2NKS0Q2dC9YaFh6K1o4eW41YzZoRmpQUVZzYzJwaE1zOC8rNUVZ?=
 =?utf-8?B?dmxkZ3ZrelhrdTA5OEtaVEQ0R0c1R0hjU283b0ZiQmg5SzVjdDZHZHZRbjBh?=
 =?utf-8?B?bVlJL2syMjQvM1RMRG5OZ2dQNzgzUWhaYTRId3B6dXZNRXFFSFJhQ1RwbjRz?=
 =?utf-8?B?R0ltajRoOUFOczBpQTloOXg4N3BPOE5HaUExMnhNVFR2Ry9xRTFtaE1nN01K?=
 =?utf-8?B?YzB3MkRuUEd4Zm5KeXZKQ2ZnSmpvVWJpK1g5VHJmU2lveUk3Z0VrK1p3SGJ4?=
 =?utf-8?B?UHIzTUN2ODV1cXNOeitmNlViMlNyU0ZjYVUvcmhsMm02WWQ0N1UzNWdnV3Nr?=
 =?utf-8?B?a0lDYmNPQnhFMUE3K0NPbWF2cFRnRWFvdlRUVXM2WnpKcEZ1OG41R2MwclpN?=
 =?utf-8?B?Y1NuSEF1clR5SzI3WitmQ1hodUpiMDFOOWNMV3BvalNiak9HSGlkc1BMVWtP?=
 =?utf-8?B?Q2kySjdrUlF3bVJ3WUo3M0NYMFhhUGZ3VjJOZklpaTU4SzRjM3c5L1h6Sm1z?=
 =?utf-8?B?c2NwOTJVUHVkSitQMDVEWHZjSnBhMG1YaVRrampXN3FUSTRMTThDMVF0NTZt?=
 =?utf-8?B?cmFPbk5JYlpQZjY0UGd6N3IvRFRYTXdIOStnTTZneDBKSi9HaXBGVVFVUDQy?=
 =?utf-8?B?S2cwdUVLb0NOSFRQSVVpZXcrK0tKL1BHQnlvYzlJZkpOTTJlaWhoZ1dIN1JR?=
 =?utf-8?B?cmIxNThsd2dZTnord202djZyWEtFNzN3Wi8xcVFFdTdYV1FwQzFoeDhwRlAv?=
 =?utf-8?B?NTlVQ2RObHFFRnE2UUxXMGRVOUFUSlY4c0RrMHNTM0l4QnlKVGRYUGtqV2ZR?=
 =?utf-8?B?blZUbXJXRTVIbXNIWTFmdDk3VWhyazM2eDJqUTFCNFBwVHpxTUpIbU5ZalZJ?=
 =?utf-8?B?M1RkY3Q3WTR3N00rbzlDWThHMnJVZzlVUUoyYUl6bWx0NGVWbVZyOWFFUk5S?=
 =?utf-8?B?YUtoUzRoSDJDR0F1V0hKTWFvTlE2WUE1WWEvdVVGVVZBRTlRRU5RSi9vUGVF?=
 =?utf-8?B?SmdLK1RuMzRyeDdCbVV1WnV4MWVGZ3MyMDV4MFpaakNQMjZTdWk5bTBJbVpz?=
 =?utf-8?B?bHU2ajVEMHR1U0xqNDF4UVRYdTFmY1UvWmsrV0NUblNtbnBoYWtld1NZODlT?=
 =?utf-8?B?QVVqWG54K0FQSXgvWllRaHZBQ21Pcm02K1NKNitqRHlzUU1tbFZ5Yjd6N3FE?=
 =?utf-8?B?S0J2OHcvMjNxRGtjY1ZGZnQwNHd2VGEyR3VPa0Y5amxGYkNqK1BxV3prcWQv?=
 =?utf-8?B?bUluYVAxOFY4VVZPTEJrdVRtckpQYXBoLzZaL3ZLVnY2SHhIRk1Db2UwQ2ZP?=
 =?utf-8?B?N2ZoT0kyR1dTMm5GN0F2SStuWFR6eWlXdjJmTTc5Tkg3aXA1MmZXZDJlclN6?=
 =?utf-8?B?cERtQnRvWGVmSWt1aVlvMWg5dk9oUUdaQ05sQVYzalhQVVV0cHBCYTZ5RXI3?=
 =?utf-8?B?d0p1Q3lVQkg1OEV4MG9pWnozdk9hMjVZdmhqZ1MrdFNFNzZaWHpVcFdiTHFk?=
 =?utf-8?B?R1c0U0hUSGJvTllnZ3lnOVNXdWg0cTBWSVdFL3lxcnBzcXA4NTl5TXo4OWhY?=
 =?utf-8?B?SlVMQTFqalNEeWlPYkxMZWtoTm84SXRhWXB2cE5hNUZCa3NIek4xbkUwSjZD?=
 =?utf-8?B?MHV4d0ltYjVaL2ZqUU5ZZHRqNnJvMVYzZHhGWmVMa0tCOVdOelorUGZDajRU?=
 =?utf-8?B?YXN0UW9Pbmk5dWNwVW1JZ2lkcENHRFJ3ZlNFSDNxcVptNVBrUVZweWpaaFdn?=
 =?utf-8?B?eHRwMlVBQmNxa25yWVRhVEc0eFlwL0UwK09uam42MjhJdXZxamMwYW95TTJD?=
 =?utf-8?B?aWIrVGNWNnplU1ZUUVUyV0w0aWZUZEtYZFpXbWtSREFxSGhwckRFUlVGZ1hx?=
 =?utf-8?B?Z1Z3bmdRNG1RR0Z5TGxkN09sSnBnWWozWkQzNlNlR0gwaWVPZTVoUjdHK2p0?=
 =?utf-8?B?cFZMS2xBRWtPdEhyN3JEQzE0ajdGYW9wUDQyNVJuSFJSelhsU1d0UERxblIv?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9124f2-96bd-41cb-f26c-08dc1bf48752
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:20:23.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPrjNbIwbqYa73wojdCwuzEOkFON7cqzooY1fl5FPWRkOUfBi7Qir6ATKAS2rLrSo7tHa0akYByn5v0R+XKEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971


On 23/01/2024 08:35, Krzysztof Kozlowski wrote:
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/memory-controllers/nvidia,tegra20-emc.yaml         | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> index f54e553e6c0e..71896cb10692 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> @@ -145,7 +145,7 @@ patternProperties:
>     "^emc-table@[0-9]+$":
>       $ref: "#/$defs/emc-table"
>   
> -  "^emc-tables@[a-z0-9-]+$":
> +  "^emc-tables@[a-f0-9-]+$":
>       type: object
>       properties:
>         reg:


Thanks! We could add the fixes tag ...

Fixes: de3d7018372c dt-bindings: memory: tegra20: emc: Convert to schema

Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

