Return-Path: <linux-kernel+bounces-99240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE95878578
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE281F20F32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535D55E6A;
	Mon, 11 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QB9ho/uC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714941C6E;
	Mon, 11 Mar 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174470; cv=fail; b=AAzvman2dKbp9iquoiFBpydmf+DodL/i55ZpVKKjxp5ebqdJdJW3E45QveMutEXYRoccC4WZ7MGIEXn8zMrP1YiJZz9Ul5/7rBU8BCbzzKmCoYtdBugcr1ctxHsnv8tChDfkmqOLcPWxUV8MJvE3X77HTS8lT3KEDRLGE8cMsrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174470; c=relaxed/simple;
	bh=/YZhbkgADG6xq9I1E6nfEezEjBdxrmE1Wot6MLdJRXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KInGsfEXLz6720lHsa7pDAkw6DGI0SgAyOlkgVDPiOtAPOJGGrQDux38AyRzakMR1FKMV4Zd6VXY8J49CAZTbrg0D7cnyKm4g7bVtllMIdSGFYhKYIxad5pkD1lO3k/OnpIiwfI3BQBGGrk3ef0nrG3xVerqxLGwaYQXuAYqgeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QB9ho/uC; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDffvOKopjvSx+Q0w+pUpq9CbWvU8oedHMQZZSk7163hDOsDRLjZ3HcQq3PwrGGHYTT6E00vzixIqbcslByhZQJU0neUEBLTPbyaLIFF562BgRjPG7CK22bQwfBXqjAKwpneA7VkCzoSsc6+w0YVdkNQbbDD/K4Ap7ANCqIvhCPm83dibTbAsCOFTy47szeIw/OUqICPLJPcnt/quxGo/8z3Trllx3sdGgWWWyBbbd1fElPzRQG5XXtgqRTaJcc23elqOCv+vpSG/5/OQ1/v8CzXblJpH2daF3SEfl7lGIcw9/c2ATknENSTJs/ZIyCO09N/lloLAUyp5lt2ZkTo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MbUMF+W/lFlW6i3qt2RW/tLLwDvTYHSNoCz/loXHBo=;
 b=VEgwsAa6Dz6UR6IZoGjnxyp5Vb3rZQjHLMpzXfJm/GILYM0b4X6NAgI9ckhU7LYTq9mr1UFS7oGjNxJWu/2iYyx0kk2LAjsYfS124YmevgdxwWHDcx5xvEI21fbB9UuwGfII5Xf3rg4agNl7FalmwDv2QUknyQTTO+Jt+u0h7WKsGcEcv9W7jvH5CW7i/yeu/m/8/riWfxuSNtO/l+tCvS+6HVbmFO5toI8idhaQ8yAF83gGRKqNZG/D4FSwXIQgYqdD2+KuBodxDkO5558mBUb4Fd+wR03V6QEKjy1ueXu63Gmd4Vbk7Mjnd6BYLmzp46I6ILUeHzOY5lZPmw+H6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MbUMF+W/lFlW6i3qt2RW/tLLwDvTYHSNoCz/loXHBo=;
 b=QB9ho/uCkKIYOwbokb6YdY2iA3tj1fz45aMrqN1A7v+1hcLDVP/pcaNz0IEosWVIjhjy6Iw26JWAmsFTaA3lehdaLF6K2FGqq5wDXAcSW7sbVWLm71b5AuXFfv3N8BoA7QXXEPo3ceoyxMWPvrCfX7WCls0hN2RUwJ+ebrG0SfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:27:46 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:27:45 +0000
Message-ID: <2c45d7fb-06e4-468d-9415-0eaa48c5250b@amd.com>
Date: Mon, 11 Mar 2024 11:27:42 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v12 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240301181638.814215-1-tanmay.shah@amd.com>
 <20240301181638.814215-3-tanmay.shah@amd.com>
 <fb78bdda-2ec7-4fcc-888e-233905a9386c@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <fb78bdda-2ec7-4fcc-888e-233905a9386c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e64b5a6-73a6-47ca-eeb0-08dc41e82efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	liV2DI5vGbtL9wVYuPYDn7Xz0jwhZBMWlCLc3zWdP60T7yAP9QWTng3z3EYhMpcwUgXNccl6vnfGeSdqeqxKcB4/IWnvZii3CaDxDgPPLem2+j737H7Fk2frz5qLaeyt/jJJ74kCgG9CDMqrJyA+UNSRgaKxzO0PnRK/EtkQDBsQJq2sZYHlVlFFlb0i0tZejCie8KhPRhPMpOJsAruu4qETEktloQ3Cdd1lcLkztl4SxAd/cpiIdLds9IOlw3eXfjiMKzTAsBytin0v1qu6dMZ4QXk8RQ6gREDCrkox5xncXQ1DG0UqWO2wLVvCOCmlZ0DzPL/4lRhf6Xk1atCyD4pb/L9sfDyIso00fXX0KOoR0iD3RY6zwnIFnD5jNeR/YLvJGEuSUrL53JKH4LwO8nHUlQA0Am2xX+ftFqTNgqKcT9HqS6pLJJMWCA3A+vhaRzALYOMJxCBiRFwLs4KGI9Ks7BprC9fFdMy79vIIPRx8AxTqWXAh+Dd7XNetqaTNIawJ/F90Y7VUAkVcTHukVGmWsP34JRa97k8hoKx8r9tpOhzWzQ4JsXeSfBGjUUWQhOi/7hsfgXVkfRElea6e6g4X6LLvTs2S2UMwTL7xDYk5uVGcK5RFNm346ZHAO7qAcalUqfZKhuou3m1QZJfopDt50oHGEe7r0EFQ0iStujI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3hKNytnc2o0a3NncFpsT2FhQmh0YjlYcy9YdXdKQmpzdXNGbWZTUkxZT2J2?=
 =?utf-8?B?a2xTS2hjSFhBa29UVzVGSTE2ZzJyMlprVUhHT2dRbTJlY3FsZlBkT1RxTWtz?=
 =?utf-8?B?OUdSNXM1UkY0NFowSkh4aGRWYVdkU09aVlFIL2RaRGUwTlExMTZDV1R5RW9U?=
 =?utf-8?B?cHNXbVlJUHlpaEFlTlM0MVBocTl2dHJjaG1taEYzdW8xYkM1Q2FrUkR0aDFC?=
 =?utf-8?B?cTRybDNvcmJRSnJGRUpVTFNSMk9EalBQN3lZMFFaY3ZDNEJkU1JVRXZDUlFT?=
 =?utf-8?B?K0hNNCt6NGxUVFE1S241c0FFOE1YTk9xa3VOdkZHczRoeEJVUlZjNWhFZUJ0?=
 =?utf-8?B?UDVUczVsWWNtU1N1RlhrQ3piUkpIcXRCTUtXZDNueERFZXVmWG83ZWp6VXdm?=
 =?utf-8?B?RTVobU5XUnVEREE1UDBQQ3c4Myt3L1JCZHF0WmtVb1JaVDNVWmY1cUVOT0xX?=
 =?utf-8?B?MjBlZGxsdEpvMktJaU9rTWp6dG9Hbm0xSWdRemZQT3R4RTBmYnBXT1ZhZjR1?=
 =?utf-8?B?SVhWL3lOSXZnbWNWdDUrSVB1ZjBER3poa05rMGljTjE0dllMMjd3dDRJT3hO?=
 =?utf-8?B?VTZMYVVuMU9qSjl6Y1pudjVLNnBydGwrazBkV0lHdXhEc2k2VTlDSGhKVEpT?=
 =?utf-8?B?dTlXNlhoMXdINUZQYUtjb2FhR3dOaHhkUDkxck8vbWtJUG5NaG1XVFA5NzFr?=
 =?utf-8?B?a1ZhNVRsZGJzL1pvM0pZTllkcldvMmlCNHJXUXNpRndwd2pJMys5SS96L25M?=
 =?utf-8?B?aGF3ZlpEbzNwM2NETW0wZXNsUUE2dDYvZGR6RW1kcjUrRzVIZXNmeC9ZRVF3?=
 =?utf-8?B?YUk5R1JUUTE4NkJlN0h2Z281ODgrUmFlM2R3SEtOSmdZbjRSYkgzOFJJWXIw?=
 =?utf-8?B?YjRjdS9XZnV5YmsxbEFLUUtEdVJ6KzNveWJERnFGNkszMVd3Mm1oMExiZEpG?=
 =?utf-8?B?dFJZT3N1bzJjWExZTkpieFVWbzdjVzJBZmozblNlMDNpYnZ3ZCtyVkNHY2Zh?=
 =?utf-8?B?aXlqL0NodEdTWmpaQXFjZm54aC9PbHRXV2UybU5nLytSemFrVmxQWkJGaWwz?=
 =?utf-8?B?Mi9ISGQyYUxGVTJnUG93bnkwQllrdHBkZEZWWmQ5OGNWKzZXcVF3MGU1eVh0?=
 =?utf-8?B?bGI0alJ4a3BYRmdtUWtsU214Smw4VG5mMVVFQk1ybDNidG5JcUtlcFpZdUxQ?=
 =?utf-8?B?UWc5M2dxVGFRN1loMGhLZ3Z1S1VoT05iRkVNMkJUVTZjUEZmNTF4Nm8veTBi?=
 =?utf-8?B?dHIrNUE4dlBHS2JxOFJUOTA2cER0RE1teVg0MC9wUlIyN1o5M2FTRW0rTFRU?=
 =?utf-8?B?YW55dHNkVlR1NjdvTGdOdUlUMlFnbXJIMFgvMHdjUVRwY2c0OElGVXpUWGtZ?=
 =?utf-8?B?SStLZExUa05mQXpadmRSVXJscUlSMlFkUFNrS3g5czhnWDdmZnVNN2h0VGlL?=
 =?utf-8?B?blpFOFluL1ZxczFUK1dXWW1zSEh1TzZSZXB4K2p5Q1FZcmZyMW5MUFdDUXNH?=
 =?utf-8?B?MXFuWkR3cDlPdlFwWUxIU3lsNWJZQVZabmpodkhXeGJuNU8zQS9GakNLTUNH?=
 =?utf-8?B?RGpFekcwbjV3a1F0Y2R6eUpRMFd5alpPeEFqYTI1UGNnMEYwM2VUWlVGQlNB?=
 =?utf-8?B?MlZ2SmlMR1RXRDF5Q3VXWlJVY3hDWTRINmpGT0I5WVgzdWNyMTQwQm9zeHRY?=
 =?utf-8?B?ZkpuTkZNSnJySDlqWUVzOGU1WEZLaE5JdXlCK1BOR09tMnZVRGJkWmhrdDF2?=
 =?utf-8?B?cllwV21JRW1BQS9QTkQyakdlNkR3SVU0S0hCNVBPRUs2ekxCeTJTVDlIV0tp?=
 =?utf-8?B?NHNHUzBOcUlOVjlkT0JnMnd4Q0pQTTREZkV6VmI2RkdIdDR3YnVjdnlvcjdK?=
 =?utf-8?B?cnAvanBxdk1mdkN0ZWdmYlBSckNHZEhRZUFOaWd6YURSK3dKMnNoNC9ZOGxB?=
 =?utf-8?B?aXhTTjhpUVVYVlRzMEUyb2l6clMrVVZRQm52MjltNjhjdGZVYUR3MkdyTDQv?=
 =?utf-8?B?UU5RQ0J5M3g3elV1L3JhRU5TbWpSang3MG9yeVFYa1RSYnhtL1krOGlQdG1q?=
 =?utf-8?B?dld5NmVxZGVuVU1PVjJKcDZjWHlubmxqaUdrem9YQ0ZvZ0ZUV2dQblVROFRW?=
 =?utf-8?Q?Q3OZm9HNKf484r3lNlZ5YnvPR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e64b5a6-73a6-47ca-eeb0-08dc41e82efd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:27:45.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drfKqFHRe3YxkUQl2EdV24BE2bOIiLOIxxr3t0IafaPZItUjLn+MV2ACKXUfhUcL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

Hello Krzysztof,

Thanks for reviews. Please find my comments below.

On 3/9/24 7:25 AM, Krzysztof Kozlowski wrote:
> On 01/03/2024 19:16, Tanmay Shah wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > 
> > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > UltraScale+ platform. It will help in defining TCM in device-tree
> > and make it's access platform agnostic and data-driven.
> > 
> > Tightly-coupled memories(TCMs) are low-latency memory that provides
> > predictable instruction execution and predictable data load/store
> > timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> > banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> > 
> > The TCM resources(reg, reg-names and power-domain) are documented for
> > each TCM in the R5 node. The reg and reg-names are made as required
> > properties as we don't want to hardcode TCM addresses for future
> > platforms and for zu+ legacy implementation will ensure that the
> > old dts w/o reg/reg-names works and stable ABI is maintained.
> > 
> > It also extends the examples for TCM split and lockstep modes.
> > 
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v12:
> >   - add "reg", "reg-names" and "power-domains" in pattern properties
> >   - add "reg" and "reg-names" in required list
> >   - keep "power-domains" in required list as it was before the change
> > 
> > Changes in v11:
> >   - Fix yamllint warning and reduce indentation as needed
> > 
> >  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 188 ++++++++++++++++--
> >  1 file changed, 168 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> > index 78aac69f1060..dc6ce308688f 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> > @@ -20,9 +20,21 @@ properties:
> >    compatible:
> >      const: xlnx,zynqmp-r5fss
> >  
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +  ranges:
> > +    description: |
> > +      Standard ranges definition providing address translations for
> > +      local R5F TCM address spaces to bus addresses.
> > +
> >    xlnx,cluster-mode:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [0, 1, 2]
> > +    default: 1
> >      description: |
> >        The RPU MPCore can operate in split mode (Dual-processor performance), Safety
> >        lock-step mode(Both RPU cores execute the same code in lock-step,
> > @@ -37,7 +49,7 @@ properties:
> >        2: single cpu mode
> >  
> >  patternProperties:
> > -  "^r5f-[a-f0-9]+$":
> > +  "^r5f@[0-9a-f]+$":
> >      type: object
> >      description: |
> >        The RPU is located in the Low Power Domain of the Processor Subsystem.
> > @@ -54,8 +66,17 @@ patternProperties:
> >        compatible:
> >          const: xlnx,zynqmp-r5f
> >  
> > +      reg:
> > +        minItems: 1
> > +        maxItems: 4
> > +
> > +      reg-names:
> > +        minItems: 1
> > +        maxItems: 4
> > +
> >        power-domains:
> > -        maxItems: 1
> > +        minItems: 2
> > +        maxItems: 5
> >  
> >        mboxes:
> >          minItems: 1
> > @@ -101,35 +122,162 @@ patternProperties:
> >  
> >      required:
> >        - compatible
> > +      - reg
> > +      - reg-names
> >        - power-domains
> >  
> > -    unevaluatedProperties: false
> > -
> >  required:
> >    - compatible
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        xlnx,cluster-mode:
> > +          enum:
> > +            - 1
> > +    then:
> > +      patternProperties:
> > +        "^r5f@[0-9a-f]+$":
> > +          type: object
> > +
> > +          properties:
> > +            reg:
> > +              minItems: 1
> > +              items:
> > +                - description: ATCM internal memory
> > +                - description: BTCM internal memory
> > +                - description: extra ATCM memory in lockstep mode
> > +                - description: extra BTCM memory in lockstep mode
> > +
> > +            reg-names:
> > +              minItems: 1
> > +              items:
> > +                - const: atcm0
> > +                - const: btcm0
> > +                - const: atcm1
> > +                - const: btcm1
>
> Why power domains are flexible?

User may not want to use all the TCMs. For example, if users want to turn-on only TCM-A and rest of them want to keep off, then

they can avoid having power-domains of other TCMs in the device-tree. This helps with less power-consumption when needed.

Hence flexible list of power-domains list.

I can certainly mention "items:" under power-domains property.


>
> > +
> > +    else:
> > +      patternProperties:
> > +        "^r5f@[0-9a-f]+$":
> > +          type: object
> > +
> > +          properties:
> > +            reg:
> > +              minItems: 1
> > +              items:
> > +                - description: ATCM internal memory
> > +                - description: BTCM internal memory
> > +
> > +            reg-names:
> > +              minItems: 1
> > +              items:
> > +                - const: atcm0
> > +                - const: btcm0
> > +
> > +            power-domains:
> > +              maxItems: 3
>
> Please list power domains.

Okay. But minItems will be still what's mentioned above i.e. 2.

I hope it's fine.


>
> >  
> >  additionalProperties: false
>
>
> Best regards,
> Krzysztof
>

