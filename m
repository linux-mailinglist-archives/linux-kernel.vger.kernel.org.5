Return-Path: <linux-kernel+bounces-46109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4F843A76
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68591F2AD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1607367E90;
	Wed, 31 Jan 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BQrIVFNT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593967E86;
	Wed, 31 Jan 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692181; cv=fail; b=CQPbSqhe9a8BoS6rnvtH5wKae+fIMCh0uRsrYZmqzk/wATLWIPI5zlf9uMeJrD5LAaMhOfY+5Nn7iJlEQ4YmNtC24342hYB5wSFgmvcqOgMXGN8J4qghlFXRdgZyzGVSNUVbDZ+5cr45D+ucJUBNPL0A91DD2+KEgnrV4Jd1gMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692181; c=relaxed/simple;
	bh=BHJL1m30V1eH5iCR7w2BTeHXcHXgIy8xzPZlMTIl0dY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUjF8z6Dj+Q7VvMzWd+PR5KsDaQQGFZkODC5mSqFdTOwv+ISfeWrWQF2fASRGm50KgUx3YAMkWiaNzGFYIhTIkKRiciCn7QJtbbPqD67GagKKCoBuah5Fuv/FXEDQ1aOQ5Vwd/g29Va3xYEE/quok4wQzgpDcazdUSTN9w7km78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BQrIVFNT; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWohFj7FLunIDCKn1sdATblycZ2a083caMK1vOq38nJjLZd2keS0Kta/g8D3NvLbdsmGCAz9O5ygAbR8yNnpog2YeWQ4PPXU9mRy76/FJnXCRU+3NRygvAmRMMb1r6slp8CVCmAwhXwcNHnds8NQcVBpLKvjYKNHmBwYHkA/SEkxWwUGij1xmUEIF9Heq5NQvqd22PycQk5+sNBOUe0DI6rZq1tmgffqxtsh4tDSoZQq84GRhqzXTqW7AJ/f1/JoUXBem8bN+9OlKG+t8ugl/qPJLgRtlO9GAY3wb17+M2DKgejxNr2kR8xQ027osURIkOTykPTacTgqM82qbtljAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjK9NyNyiJJrdaBj/JwIU6eFfY3W/h39LafxEmMwvkE=;
 b=HjcB/olZx22ZB1Zw+mXws0ICWELqoSoVjCUUKK9XtEnl6fwknDRGdtyhkrD/J4nAlHuh3x+5xjLJkUTKij0cG5EFcmwKX3p4rml1DEixhPDauvMI3mKi/t+Y9bHtz7lOZGm2BbKNym+gUaQmIW+Yzu0yBmLMdWiB3Rp3BMD50EqeT8fEDS9RSlnRMWeIX2I5TZpFKqjBQtOCjGf1GnEhq/PEU3Qe8DXtfVl9UpukHbClJa5njUwCplbCRg8jP2x+qpch+xrBeF+eWzEblwYodH8oBL616Ldj1xw/XLgV4NW2UenuegGQvgQ8WbuopbgMsS7EmwWmaAZA/tI4TtGfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjK9NyNyiJJrdaBj/JwIU6eFfY3W/h39LafxEmMwvkE=;
 b=BQrIVFNTh9rths4OkFxW/DzACUq6kIQGxz91fS7VUyq0KF2DJrq5K6uVa5zpWED52GNCBrTceW3eJk5tGdeYsTy54e9L6uzBmRTVsHg+xYUirnzsePm6Q74gSup1X2j+pNHqLVt0+MWTZUTNYwREEm5xFeChBprAROqwN3JbQ34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 09:09:37 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 09:09:37 +0000
Message-ID: <c0742517-868d-4dbc-b6e1-a5fddeceb6d9@amd.com>
Date: Wed, 31 Jan 2024 10:09:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: xilinx: Add support for KV260 CC
Content-Language: en-US
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <14c184225cc4f0a61da5f8c98bc0767f8deba0df.1706019781.git.michal.simek@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <14c184225cc4f0a61da5f8c98bc0767f8deba0df.1706019781.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:803:64::40) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: f72ebc39-aab9-4825-18b8-08dc223c5963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ae6f5aGVBsrdOiZEXlT5+4KFtBGpMojemgRIizaJ6iY2ts9fzNzh7XnoPYvrZ4hNqgO9xT1tdGANKXi7LF3mVh/nuT/fw7IO5DdT8oTOPU2MQVxNEDUJFIftBOBtXERjoc6he71tG1peHxIdnA33g+hV6vYOihPnWgSQUlRzKSDygK6A8UP5gzPD4tahUBZdZ7nTfggTcoHParTdgfoXnuqwFbWhFQ4+PFdVIUsGVaAi6pNab7vDLj6AlMwr5oiXTE+jmC04h4sQ1n7d+3zo+0m4RETDP944CCYyEAaFLs81OzwaAFeYcA1dZtm1TkSq7/H/kGaUVIOaYDGWKbj+7XsHVgjuEmISe+h2KbZcBiHJpm1zR6kg0EW9FNIw4eI9Im2OmwtufdMQTKKGuPNj7b2owdmgdOdxBA8FaCTMvsWyi0ZnU+u+lVnTe5HmlWNqbGVa6NrPu78PDmu/kseGsinAh3VaGreEUFIAgIHgw5TE2XnVzH4fGPeAL476kL3B1F9dzEHfExzZMHxDC0wgvX6Evwhh4OddSIBYPPGwsWDENHx8EG4C7vBDm6IoTWdtXLx9odp9vX0Dteb+XPvUHa+voXhAy/GxdDoAZKwWGDhyT9B1UCwSsKVNgf95z/+yElxvgPp+Kh1u3yw+zGM7tQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(2616005)(41300700001)(31686004)(316002)(36756003)(6512007)(478600001)(53546011)(6506007)(966005)(83380400001)(6666004)(6486002)(38100700002)(54906003)(5660300002)(31696002)(86362001)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUNhbmo3ekJGd0I2N3RJanZTa1krSXhCSFJCVHg5eGVJbTB3aXptMEtuYVh3?=
 =?utf-8?B?TTFHNDEzM3VQUUh0dnhVYlg1dXNVTFRnQmJ0OGt0RmFUalI0SElIUUlhOGhj?=
 =?utf-8?B?RmgzeWk2OUJiVm9pRGFKOEM3ZkN5UDNZd0tiUDBaSWIreEZDU2tLTDZIU3NZ?=
 =?utf-8?B?WDc5YkNVcFM2RDBqcU9KTUVBc3VSUktGa1daZXVHYU8xQ1RTS05SbUw1dkJ1?=
 =?utf-8?B?a1NGNGJXdzlWZGtNUmpmazFKbDRpWFAzQVdHSklmWmRpKzhERk10NUxmMjFv?=
 =?utf-8?B?dnVwSW40VkFOd2JhZ1NiN1A4MGhXNnpLZWJ4NllINzZLT3VMU2hieGdpT0Zj?=
 =?utf-8?B?WmlUWmhoZk1DZXhFRTdmdmR4THZjTzVFZU9aUWY5Z3Jpekp1cFY3UmtMbW82?=
 =?utf-8?B?VkdwM3IrL2RPOS9hS3N0SGhvckVoL2JhNllwcUdDdUpMSHc3RGJJS3VNNGRs?=
 =?utf-8?B?ZmhCYkxZancwT0toZkdQVWtlM2I3Sk9YUkpMVEdrNWhFOFl0ZjJsblo4UHRE?=
 =?utf-8?B?bGNETUhHcUUyeFJZK2FvVW00Vk1LRDlXMExPZ29lU1RFTm9mN0JWT3lIMWFk?=
 =?utf-8?B?ZmdsQ1BXRXJHNC9LN2lTTWx0a2VFY2hqUU00SXRXZzFZWE52SnJlMEl4L0o4?=
 =?utf-8?B?UkR6elV2bjU5aEthRDB4eWQ3c05jSkNzdklIMlhIekEwWjRsQWdtS2FEb3NO?=
 =?utf-8?B?b0xqdENOQkpCbGYwVXhackkxUUlUbUFManZUbTdBUHFsUVg1U0NwNXRia2tE?=
 =?utf-8?B?RVdPK1o5c3c0N2lTbnV0cU1aaGtlNERWdnBCdHY4TnhLZWd0cHhCVnUvRjVv?=
 =?utf-8?B?ampFVDUzeUlCL01HQnRFMXJzanlsc2xnYVUvSDRpR0YycTQwdC9SN2hKZkxv?=
 =?utf-8?B?RUNIcWZ6b1hiTyt1TEo3TUJCTERieTNEdnF2SXFXaUlsdEs0VGt0TzBiMC9Z?=
 =?utf-8?B?cTRSOWxrblBlR1JQVm9zeGRnVnFXUjlYa05iZHZva21GdGprZGY1UUlUcVZx?=
 =?utf-8?B?ZjJ3TFlqWmYxVGY1aklrSDNKY3VoRnZOVE95SkNSNEZ2KzIreHFmdTZmSW9z?=
 =?utf-8?B?djRLL085TXlMcEhINTZ3eUtWQ1h3T2tjOWxUNEZhSXNMRGJUS2QzZ1ZJd2Zh?=
 =?utf-8?B?dzdkN3RiMXl1OHNHK28xY1k4WmRNKytGVWlrMjVOUXFXNk5CL0Jpd1VGdVRo?=
 =?utf-8?B?ejh5TWFuenlGYkdFV3JlLzh5M0txWUNyZlFLdlNKL1lyMFB1V1I5VVR3YVZR?=
 =?utf-8?B?OUNnWmNwcUJuWmg3RXlxOEZ6UWs5a3g0ODV5Q252OSt1R3Z1clZHd3l6Rnl0?=
 =?utf-8?B?S1JoSkhISGJiR1hMVnlDZHd0RVVpZDRMellQSmlkTmdTNjQ5SDR2NW9Bbjc0?=
 =?utf-8?B?TVQ1NFpxL3lpeWpOdkR3QXZQYUhpUHAwMjcxditPTVJ4bWxDSkZFdEJ3R3l6?=
 =?utf-8?B?dkM3eWFOeHRUdExNN21rTDluelozeEw2cmtxNVR1b0hwN2VLUlErN1hqM3hp?=
 =?utf-8?B?cDFkUGVOODJCMUVSL1kzZm55VFlUK0xaOUdNOTVveDFFcWtDMS9Xbk9pdGtn?=
 =?utf-8?B?Y3JEUHlpaytjRlk4Mk1zckw0RFJmU3ZLVElFdTFxK0c0bng5ZnZwRng5Zjla?=
 =?utf-8?B?SWtoaWpwYlpqU0FyQ09JWmpaNE1LZjg2UmFNL0xYMkVDQW5HM0h3TTVYTU1R?=
 =?utf-8?B?Q0prRmFkZngrMWtveWJYc3RwcmlCTEVvcUVxaXBnOEZZZjBxVFh0Z0xtVWlw?=
 =?utf-8?B?MTNEWmhxSFFreXBGY3NQUUFXYXV6RlZkREswUTRLKzdoSmNnM04zcW9Mb0tF?=
 =?utf-8?B?K1k0bC9GajA2WXVBd1duTU84bm11NWhaU0dEcm96dXBDYTcwSGNGUlozTG5M?=
 =?utf-8?B?RjJ5YVl3ZTV1bTQxNDBnNGhLa0EyMEhNUll1TVdxTWJickMzeVhhenVrdUMv?=
 =?utf-8?B?UkxYZm4vZks3TVVHcWFOaWFLKy82QU54U3VGK3F0WGczQmE3VjhpaEF1TzJi?=
 =?utf-8?B?aVlZYWd3WHJzczNjMmw2T2JZazR2eTQyYUwveHdRcHlkVjVOR3k4Nm1Oam92?=
 =?utf-8?B?dExrUm4yR004UllhVFJmeXpTZk9sejZJcFNBN3lSWC9peFVOOHdRVlBNYkRW?=
 =?utf-8?Q?XG8pRSF0YXC3+oCoDAwdlCKcN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72ebc39-aab9-4825-18b8-08dc223c5963
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:09:37.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1VP5mc3HlDOZhCT/miXICIiRyRJW8wXo8LMdxAXAc+0QB0dHFW16bZh2j1ita8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258



On 1/23/24 15:23, Michal Simek wrote:
> When DT overlay is applied at run time compatible string or model AFAIK is
> not updated. But when fdtoverlay tool is used it actually creates full
> description for used SOM and carrier card(CC). That's why there is no
> reason to use generic SOM name and its compatible strings because they are
> not properly reflected in newly created DT.
> Composing dt overlays together was introduced by commit 7a4c31ee877a
> ("arm64: zynqmp: Add support for Xilinx Kria SOM board") and later renamed
> by commit 45fe0dc4ea2e ("arm64: xilinx: Use zynqmp prefix for SOM dt
> overlays").
> DTB selection is done prior booting OS that's why there is no need to do
> run time composition for SOM and CC combination. And user space can use
> compatible string and all listed revisions to figured it out which SOM and
> CC combinations OS is running at.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> We are using U-Boot DTB reselection feature to identify SOM + CC
> combination.
> 
> This patch depends on
> https://lore.kernel.org/r/90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com
> 
> ---
>   .../bindings/soc/xilinx/xilinx.yaml           | 34 +++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> index 7c75dbb4f307..131aba5ed9f4 100644
> --- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> @@ -148,6 +148,40 @@ properties:
>             - contains:
>                 const: xlnx,zynqmp-smk-k26
>   
> +      - description: Xilinx Kria SOM KV260 revA/Y/Z
> +        minItems: 3
> +        items:
> +          enum:
> +            - xlnx,zynqmp-sk-kv260-revA
> +            - xlnx,zynqmp-sk-kv260-revY
> +            - xlnx,zynqmp-sk-kv260-revZ
> +            - xlnx,zynqmp-sk-kv260
> +            - xlnx,zynqmp
> +        allOf:
> +          - contains:
> +              const: xlnx,zynqmp-sk-kv260-revA
> +          - contains:
> +              const: xlnx,zynqmp-sk-kv260
> +          - contains:
> +              const: xlnx,zynqmp
> +
> +      - description: Xilinx Kria SOM KV260 rev2/1/B
> +        minItems: 3
> +        items:
> +          enum:
> +            - xlnx,zynqmp-sk-kv260-rev2
> +            - xlnx,zynqmp-sk-kv260-rev1
> +            - xlnx,zynqmp-sk-kv260-revB
> +            - xlnx,zynqmp-sk-kv260
> +            - xlnx,zynqmp
> +        allOf:
> +          - contains:
> +              const: xlnx,zynqmp-sk-kv260-revB
> +          - contains:
> +              const: xlnx,zynqmp-sk-kv260
> +          - contains:
> +              const: xlnx,zynqmp
> +
>         - description: AMD MicroBlaze V (QEMU)
>           items:
>             - const: qemu,mbv

Applied.
M

