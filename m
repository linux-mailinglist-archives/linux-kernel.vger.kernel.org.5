Return-Path: <linux-kernel+bounces-99419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E9878816
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23C4B22FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069164CC6;
	Mon, 11 Mar 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGH1quAl"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1E63511;
	Mon, 11 Mar 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182385; cv=fail; b=cxu5soqvurXCwbVp5qjFGTmJI8Q4dgXaPUpCTAqFuzydzjJLUMFyort2ictPoc5wzqGf/zMU8hbD9VtG4bv55qb7liFvA0ipOsyyhvZpZRAi4ebVtzLrDqiLZoqc/QhcapzdC4kSHyiG8lZGCXn9lwQULPPDglSPUNBXe5/7dh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182385; c=relaxed/simple;
	bh=QroaU9/FS9tuwn6l+VyME+6I5GOPXhFkEAq5s11nj1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FVzOlwqieIkriX/ODJaRY9QYROkMF/FhMflMPGEdSKlyeHT0tHshg+ss0nFwSZ3ZQlnRofL4zISXHLVwIODkJfvzj4UvhKu4yWhb4Hq/7lzwKbmyi2nPDjcEZgzcyP1zbrHrZkiAHV6uEeSh//DniTgdonRoDobrPZBdUAC8uTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGH1quAl; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIqJHP/kurT7dE7tNK8wrNwFSTClHc/3R9h+iy0o1WyPL1mzjD1JKCu0iLuYG0xPhCCXOOHzeZlOguVXOXjycydY5YbcpiZLa6NRmlDYpqRz41FA0FdOisww7ioZzN7AXPJNBHOUffQtrx5BD1lrcZp+YqbLUO6HaiwG5p9h+DhLDn4ESXxjKeIEQtHye7BTIbwla8aU0KZMwkhc0FPNohdSeCF8hGTrURreCIQ0xdLO3L6duV9MtKm9n9QTFcCzDxzaIvHYDqbFfDvybp3NiAibs8vL/mYo5ZsBFiWrTwo4Nshbu5wXD0ReWkJWnHZa3lopqET5gl+VDWDw/JZuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRJ8q0N2wAwV6p0NnhfRHsBZSgRu39s/eAf0deL7kJ8=;
 b=n6PAnLxBHeiXmzxw2lVxod+Va53xbgaNYhSEpLM3WnViiWDbjIbezpm2Imxbo3QSSaGnOxweAEo1Ui9wnfviDQRg2u0ps3K71NAqp59Q4/mIWwCxBtcsAami5OMTiMVXiwTCFDLOFN3fLOdP+Kc1eVMby6oST+oR5JeuvmBrp6U0TkRyYV1bQyRYI/vdXvajVJSP9IsyoNl/cO94OMhQNRTr8haduzefgnlVKSuMvaViPym5oy9HD9zMnOMKNlOXoPCfUxQeSt6+1YetpAu7HJg0FiQubLRMFf1Vmhsi/3fp4lc4SU/0tit5u0XW3QuFRy/8nesDYBAtbhlpvQwQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRJ8q0N2wAwV6p0NnhfRHsBZSgRu39s/eAf0deL7kJ8=;
 b=rGH1quAlLCOrZFrPKAIWKGu30GkS1DglJa7juZPEm7dYdSV1VYmVDhqD5cgIz51BQeFA0uSZhQ/oDAgpHWVma5JMChMJF24bhw4Gerx8RWtV6zmTjdwv5uMArU2cbkOkqyJudJl+ldcnNklBNktsF+kj6uRBNwJ1r0WuNrmDWyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Mon, 11 Mar
 2024 18:39:40 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 18:39:40 +0000
Message-ID: <17d58a39-7d56-4513-8d5f-7c18809c6cfb@amd.com>
Date: Mon, 11 Mar 2024 13:39:17 -0500
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
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 457013f7-8c87-4d32-ea98-08dc41fa9c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	57PoDzWr9zyGGyBZoaKBjPFMVtwOyZu2ZRsiGTJYxxp7riHDHTI/Qim/4NWBHpAJyhuLEYGpwSOBCKm/ZcKwci8yZwCpS1c/zIKJqHO+IlN45oEVaQ1OLY3kc4S6fWNN7LXohFkZ+ocO7WheGQ83BHxr7Km2DiIAroeLSvrt9kOhmaZQNR4lo7+6qpEMhLWkNwUksoYEk5gLcXcCj08HFE7ghH9wH1EWU+S4Qf6qs+7jsyVN0f6/4eagiqBM/r+EXUw7qHTd26BmQhHeKk4Wary7fk1c+I/2D1e/blBvTo0/3KjqSjpWzJth688eCTF06+uFuWyXlTMl/iarL5+1JtFpzBxrDEgGwOAKB2s3Qo8UUH9c4LgjEqkiHKFrFz5f9oPiNgxdFYS4eRSr4PIPAGwwGPu8VHrzTgTHlRzud7c7BhfsHkTsfjjjVjF5L07uHpvMRIUgvK9LBZ0s+/e/TsDochvAT4iFgOk0X+h3bnHRQd0CzI+y/85dwwFCAcVNjiSL4lJCYnkKPQq1duvDQPvO6SQjjcOLmZpwVR2kGit6h8VwYSZEJhH+H3guBI22UjXHu8M0+pmjVQJM1iIC5ieueGmNGzip0hL19dlJ6FZLsKUAGK2JnDwL33N7JUeIEzHT+uVdo4iYgA2OlqSn+lq72kaUugGjOx+dfcxeYvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWd4V1p4dHNIRWRLa1E0S1l6UjFtTGZXMEwrL1RsMnRZaXhtd3gxQUJ0Y1pW?=
 =?utf-8?B?L3JKanJuQ1RZd0V5NEZKajlvVzdvKzdzOHhaVGxBVTFsZnFtWEZQVW00UUZt?=
 =?utf-8?B?NFYvU2duaHpRelBLLzRKUnZvd2FKcS9IdWVIWG9nak53QnZ0VFc2L2JUbnpV?=
 =?utf-8?B?SUFsWVVLMEN6cjloTXpHc0dRNmEySTMxRGVmbW1Ka0RqTjJQL01KL0tFNU9X?=
 =?utf-8?B?YXpFSkpUeThWdURQRkY2SENUOEh3cU9CcGQ1TXliUTlhQW5Sa1hHZndQVG55?=
 =?utf-8?B?d1Z6UlFiaGZOb244emRmMXdET2o0ODZVYVBhZHNNM2tTTWFpcmxnbi95V2cw?=
 =?utf-8?B?WlI4eS9zRG04TFBHR05iakh0UEgxUzI1dG1YZXU1a05JZC9LNUJhaGVMN2dM?=
 =?utf-8?B?STkwSXl6eGJ2bURSMURtQTBNbW0zZkswZDV2QmxzdHJkdjBYV2VQRTBYYlRa?=
 =?utf-8?B?K21DSG1jVzMxa09haXlYTGVGenAzdkYrdlNSWkpwckg5c0U2U2ZUSjFZaEha?=
 =?utf-8?B?SUNNYUVONHRFUU5mVncxa1h0S25PQUlrS1hZTGhqekVpT1N2cyt2T0NzLzBu?=
 =?utf-8?B?bHEzYlVHUWZKeXpNM3RDUloyUGErN0hUTkNiN05GbGgrZm5qYTJWN1NwaGxa?=
 =?utf-8?B?Wjg0a25UanR2OHg4ZkRpVFZFbE9YU2hwWlVLU0FNczMxUkxkc054ZlN2LzBa?=
 =?utf-8?B?TXNLVGlvTEp1aDlJUWxlTHRVU2NGMVZvaGFxN3U5VXI2bnpBampVcWdiTTVv?=
 =?utf-8?B?d09WQVgrVVByZk1PNmlwSVlnWUhmZURwRFd2NldDQ21Mb2N5Y0JVcUJubWt2?=
 =?utf-8?B?Wm9nK2liY1pWMkZKQk9uODFpZllmR3B1WjBURmhtYi9yaExkdk9xNHF2ZVRj?=
 =?utf-8?B?bmpyMW1meURWa3M2U3BsbnFnTlBwQ2w0RW9BdWozQnMwTlB5R1dvamJHKzJT?=
 =?utf-8?B?QUlMbHd1a01MZjJzL3h6WFlJd1JFTFBmTW9PM3c0Sk1sZ0VMYldNWnBVbndB?=
 =?utf-8?B?NVFlZmF1b3NPSnVKZGNlT1NIc2xTR1NMMWhFMm5XNEtBMmdmcXVMSnZvRjBh?=
 =?utf-8?B?NUxaeGZSdVREYk9TbTkrM3h1TkVGRjdPVlBwVzBtRjZGaDJINE5MZDdZbGFs?=
 =?utf-8?B?VTU5dzRieEZUYUJVR1ZDOU1nREVaRGRmSTNsbmx3eGNlNDVmdmx5ckp1ZjZQ?=
 =?utf-8?B?YXAwOUJwZG0vZytVYmZnT2tnelByZ01tTTBObC94ZUNYd3lySGY4WHJ3YmUv?=
 =?utf-8?B?TDB5VGRDWXV6WExLMk50UjNhT2QrVzQ0ODZWVWJRMjJZbmVhK1RKdU5MU0hw?=
 =?utf-8?B?WjBwTFpKNjNwdkNrVGVySmZWc1ZaTzhRUDdBM2hYMHFvaDQvYUFsZDFkLytP?=
 =?utf-8?B?WHBQUFE4U0dBcnZ2aHBiL0cwOGZZUzdFTzZpa2lXbU9HUmtGYUFxZEFjWVRa?=
 =?utf-8?B?emwybHNTVFNITHIrbC9SS1d3RlU5d0dSSXNBcXlBZk93cllMaEpHYkhQaHFz?=
 =?utf-8?B?VVp6cUpEU0Z0UDJJY1FGdE1vSmlFZDZmWStZN3o1Y0ljRmdSU0RMb2lOSFhn?=
 =?utf-8?B?eCszNGczcTF2S1RqZnVqYzNVOGRoNld1WWZEYnhoR2ZZM21Ed21pelJyeG5M?=
 =?utf-8?B?YWlGWDZWS3lMV3hVOXpuVFBGWG5PcDRDWGR2bU9LUFllK2hydWtjTklDdG56?=
 =?utf-8?B?ZDdPTys5Ny93WmFnbGZqMlFhNjdGMU5SNkd6WU1yTFRTcVdVMHRhQXpBR25I?=
 =?utf-8?B?TmQyZFJSTnhzRlZIZ2VRM1VoaFdlcjRHdmFaYnJjMldUcUJoSDRJNW40UTUr?=
 =?utf-8?B?blZsQjJqeXRHazVOaTZyN0dBUHUxZnVuM29oQ1ZTSWFoV29zQlVpNkpQd0t6?=
 =?utf-8?B?T0RsODJ4UnhrZFQ5Yk9jVTg4cGFsVkxmYnROUnVPYUMzNExmeWJTTVorTTVW?=
 =?utf-8?B?cFBLZGR6K2VwMkJ1UmNjQS9QdS9OT0lCdzFhYkRyd2Jna1p3MjArcmROdXRO?=
 =?utf-8?B?elNSaDB5M2wwZ0hyUVJ3TEhkM2pWNDF2SGZwZ0E3NFlNSWZnTHV3WWJ5QnRh?=
 =?utf-8?B?emU4NlVRQzVDU0RvSDFoaGVOaVpYeE45QmdEc1RhNEF3UVdHa25wbGxibER6?=
 =?utf-8?Q?C8YyV/4293SLHLkQf+fFEwNuG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457013f7-8c87-4d32-ea98-08dc41fa9c0c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:39:40.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQbHRy9/ys8MF5+S/RjlgXKGX2evCjzMZzOJUIyrRLojX3Me6JGsrOwYkL56W6cG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173


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

Hello,

Sent v13 addressing both comments.

Thanks.


> >  
> >  additionalProperties: false
>
>
> Best regards,
> Krzysztof
>

