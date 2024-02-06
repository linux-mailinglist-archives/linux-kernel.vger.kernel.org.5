Return-Path: <linux-kernel+bounces-54384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D784AE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC71F242A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F712882B;
	Tue,  6 Feb 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FEb8GTlX"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F212880D;
	Tue,  6 Feb 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203076; cv=fail; b=LcFpkrq4xFyFgSS0MXMT1fcCHiqcfCBe1qdOkgFEJ6iIb+DT2/R24G+uYKScy0EsCHdnH8edwU76CHX746c1IebX+fVg+tzInIr0L20OvPw7DCU7tzvnFg3cW9m+AJfF2B6oIvG23SGVYfDYvnX6UTtmp5PjXZDZBWl2calouyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203076; c=relaxed/simple;
	bh=EqPTQKa2CARxW9glMAB9ppRQaL7qfRPT5zklbjAZhiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KKSq8K93YIH54FfBiq6pmZEo6kG3N84rfz6Dcyx5eD1OJo2zwUNZX6SBDb4Y0XxEiIej8lsE8ZBMMiisldJpiUCdLgCE6iOV/XgmNrINLuBihEsJNd2kipsFLvSsvL/bXiZFoOgYVMv3F142nLQ6kr4T6RZYNS9VJd7KJgqHKSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FEb8GTlX; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJojWE6LAp6r8ilfB6ao3C1MTKD+pnE/AgIshlejR5gekyh/jV/hXkwhZq6m37Rv5yF/ptHfXjFARI/NPKE+UcHDzSlYnHRrmxjAH8ZR85zeGYcE5eU0Zuos1ncRZUBcCXLdiNoWoPRjV9Bj8F5yKAIXVMjCpK7QgV/YFDI1BOInvNBxjuHY8cOGGVvD0zoDMTxQWoNY7MVcWIMyCnszHBioo4GUTurn6Wd99VBC5jqhoTB+YRSDmW5HgxGznyg9j6ubwnz/wBsFMoyBqumtv7tdwBUtXS2TZe3+ZeC0Ay8FCHmFZUZqOT/CwVtX50VKr/QlQHAFuAuTAPdUA8/qYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp92XYOSBBMpdoxfv13xWH1i1U+5VdObUjX9En7FZZc=;
 b=b3jCaoBxG9QhWGA8wwlDzPs27lrEbtkPwXrjtSyGHIMx32mvFKsb2QJbrIAWZY16rsrLclA4IaKy31/SR8P2MdGypiagm0AzBK7v4KlvsJAJge6G3CBXH7hxJ6Sk62ybqsD9eZOnIHd7V5R1ZQeUkbnr5ClgAB9fEI1VuCnBIfmq55P6QSiJFooduSZQ9BI+sMDGkJrLtOEAxFGnQOQSxMNz4ms9aPn2tzVCopIJC12CFKqYdfUEutZQGAVEXXgB9jCJFzlBxG2B7gTI8mAvec+xqqniKS1ZvZ62URCNbkMkt3CEQmspKCkMi7zz0Kq4WEvEyGEaoL63vmKm5n7Pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp92XYOSBBMpdoxfv13xWH1i1U+5VdObUjX9En7FZZc=;
 b=FEb8GTlXojSdqBo/OqbiM5/B2qPj/X3Sytwj6D3z5fOxqVWafrH3ZmvI6EbcGGSLqvgn5FVenVUpGAQ+Oral8H9/IXhGP6TDJ4hVsKMib9Z3S9HcyOWNZ4Fn5VI9FALeZxKeZ6mXnQNMnbmKW7LtY8IyHG7BYYJ99+Ssiuywgsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 07:04:32 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 07:04:32 +0000
Message-ID: <7d2a1c77-16db-4ab6-9dcc-146a600ac8d4@amd.com>
Date: Tue, 6 Feb 2024 08:04:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: firmware: xilinx: Describe soc-nvmem
 subnode
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0160.eurprd09.prod.outlook.com
 (2603:10a6:800:120::14) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL1PR12MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5332b9af-05b2-4dc8-1298-08dc26e1de83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6xF5O0cAidZ5vnaQPego9w2s+L+cSpcgQGg/KxqSNiSPZfwjir+/2nG/fL1XtJaDul8WoLNhj+fAVrKmEV1w2qGlX3MxGKUYAqpclgADRXQYoKz6SHARCWB2K7JH68KUc0soxHN/V6x5zXwcPnyW4KAKQvqxfiLZ+wU6ZK9Li7DEQSp+KuuJ1VG32mfffJAwViAF91vRji3pxoQInMdOPZV/JUDlWlZWe6ks8zyKOs5VAoxk5TV2uODQEJo8MfnhLw9Ep3OE2nXLbUBahNLyTqJlg8pC8RUFaV2RQHl1RbwsGEi26Q/XYtzkR+E8T/+4pLJkxblFm2cau9Ww7mnuUssvrrDA5daqNzrxJvjZnsasZgfZchaUsQLZw1b4yXb5a18UMQvKHymHzTY3/YmboeQ9O8Zg6N0tFbHxWbvoDhY8nwr687ihvlez/NKSxQBQywbhe/8oXXMQfRu7QQo6JSlgI4h4cI9xFDH8PrBtRnH+pg2LNOI5Nff9oOGViOyEgiIFvPj2telN/IxjadRJsORxnTg6WKki3026A/eoS7zEh6UCZGjPg+7gdDEoQM/BmjjwzwxM/qbauZCAyTCu/7ehUZ4SouCRLu0ZTUc0WIFoSxBfKp2nfYafPVkUR9rGc2TP1v+E7c8W4HFAmPVTa4GwgMfOttdjjL03cNP18Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(31686004)(41300700001)(316002)(66946007)(36756003)(38100700002)(54906003)(53546011)(6486002)(6512007)(6506007)(83380400001)(966005)(6666004)(66556008)(478600001)(66476007)(2906002)(4326008)(44832011)(86362001)(5660300002)(8676002)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3UxZmg2ZFdMMGRIS2RBMEVnR1dqeGoweFdsNVFTaVI5OHV6bXN6Nm1kVWUw?=
 =?utf-8?B?NTZJdDdiK3hGS2NvTjBPWHZXZE5aUVhENnBnZU90L3V5dHNwL29Qbjc2YWNn?=
 =?utf-8?B?UEd2ZXk4R3lhb29qUEpXcnZlVkQ0K1JkME5aK2psNVpocmJ1anVLSXQ3ZFJl?=
 =?utf-8?B?b3VBZ01OZDNZNTkvUDBCZzgxRXdwUTI5QUZhM09lcGNTcXd0eXo0UnpJZmI1?=
 =?utf-8?B?K1dHMVdLeTdZQ2IrNjlzYXA2Q0d5TDdxZmd5MnIrZGpHL0pPWjVsQTREZE16?=
 =?utf-8?B?b0VvVTlvZmxSWHNxY24wRW1ad2t2QjJBWmFuc2I5bng2ZEs3UTRyTDZOdFJ4?=
 =?utf-8?B?bEVZbCtBZGZvVWZpZGxIdFBIOHByZUYrOHUybmdRQlVsRnFoSTNudFZDVGpU?=
 =?utf-8?B?VkJ6L0ViZU9LYnNjdXRRV1N1QzNwVnJ0emlycTYrazJVUThMa21UWmJ6K0pV?=
 =?utf-8?B?NnZpeCswTkhiZngzVmNnNEFlamtOd0lYVmc0NUlMdFl2SkFrQ0Y0d29GOEM2?=
 =?utf-8?B?V2t5M1A0S0xUMkJoY2dVdGg0YWF6NFR5V3dDMUFudGwxNjdRR1ZhdkhMbFJw?=
 =?utf-8?B?Y0cvTDgxVXYyOGM1ZU43bGxZNDNjd3o4SkZuaElaNnFXZHBBazN2NVYra0dU?=
 =?utf-8?B?ME1jdEp5bDF5RjhXTG5lZEZUNWwvejJuRFhHRlpmdks5V3dTZHdUb0FFemtr?=
 =?utf-8?B?UkpQU01kWUZQeGhUNjFvaFduTStNUDZrVm8vcVFYRkxRMFFlMDZUUTZvZk9Q?=
 =?utf-8?B?NW1BNmJHL05SN3Z5M3ZJMFRIYTArZ0IzRURpbUt5WHV6MDBEZWNkQTBvS2pw?=
 =?utf-8?B?elNQNWJJMEJ4SGR2MFFINUNNZVFnZm85MzJZUkxFandGY2JWTmhlanlyZEsx?=
 =?utf-8?B?UlNVZWZncW1mTTU4Q1cyVWVndFZiS004aVcxbGVSM1BEemJKblVUQ0NRYXNZ?=
 =?utf-8?B?YVR2NGh0K2tMNGNYY3pWWGJ3alRUMVNLQ0pORDRFMHQxMDQyN241RUxCSWRK?=
 =?utf-8?B?c2djYmt0d2hTczgxVGFZd09jWGVRekRNTE5iMmtQR09GcktBVW81T05vcDJE?=
 =?utf-8?B?c25sVjd6LzlvMTVGYnZZRjFtU21hVmRzSVIyV1dBNFhWZDFKaTZ6OUp3Y2h6?=
 =?utf-8?B?cGltNjc1dTVJbVd1WEJ6Mkl1RlN4dm5RYzlwTVd1K1ZRVkFlQ1NabmxEREVC?=
 =?utf-8?B?MXkxSElFODZTcWwrUlNocnNibkh3NnFoYTF3SDZLVm5xMElRci9CT2R1RElB?=
 =?utf-8?B?bzNkclZwRkxIRFo4SlZzRzZHU1BKWVFsbDc3TXlPYkZNenpiUE5BNVVCamxi?=
 =?utf-8?B?eVRVNzhnQm03VndwczdqbUwwM0paQjJBZmNxS2FoOTkxVlZSNC9XNGswN29U?=
 =?utf-8?B?c3RYZmd6R0o5QW9yM2lkRlloYk01NU9nTW81aFJzQ3lZd25aMHZ3S3c3QmN0?=
 =?utf-8?B?Ulozb3d4dndsOEFOdkR5amNKOGpzSFQ1TVdqcWMxTmZKSDcvM3QzVHN5OWhk?=
 =?utf-8?B?aWFoK3EwT0hVdGJmSFhlb1I0Z2lxdE9ZeTA1NUI3UVdIam1SckNiNjE4Smdk?=
 =?utf-8?B?eWRRS2xVdEtNcWdsem1JOURwdmUyL1NQNGJlbjBrUUFJRlorMVRlSjZWWmxs?=
 =?utf-8?B?ZjMwNzE5SE9jU2tzOWlObnN0Vkk0ZEw3eG05Q0JlWDlxOVd0WEt6TGhESURF?=
 =?utf-8?B?MGVGNnhpMGJnVDAyRlg3TlpEUlZZbW5vY0NIQWlLem9tY1F1d1ZGUFBpdVQ5?=
 =?utf-8?B?MFMyaTRUMTBZRU1KcTlzVE5iQ2p1bGRZZ1hydDhxNU1QVVFubDU5ZTNSTXMw?=
 =?utf-8?B?aXJlamxlTGhjOTU0RktBOGtOS3pwcE1EY1VpNkV3ayt5UHNLL1pabkhKMnZP?=
 =?utf-8?B?SEZBOHkxMnozeUUxUXYvaDgzTWYwS3R1dTRtcGNFd3paWmkrZkJtVThicHBv?=
 =?utf-8?B?c3VVTEpLZ0M3c3J6YU5zdlRuUGhUQWFOVFJEYVRMWnBRU2ZDQmppSnNnSFRQ?=
 =?utf-8?B?NGhIMCtTVU5sNjFJZ21WYlhWNWJWNXAwWTlPM0VnZENVN2JqOWRJTEVLT1Vq?=
 =?utf-8?B?WU9YQ2FDc1BhOU92ZEkzMGtOZW1qd0l1Vmo1dWpJdUhFakQrMUlaQW90eEpa?=
 =?utf-8?Q?9u3xa8TUiHqRxZaakf2u94eKl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5332b9af-05b2-4dc8-1298-08dc26e1de83
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 07:04:32.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpCq1FWrlxY1ll2ojX74X8SJ939t7J9TrgJplqkx+81TYULqAZvPKju052wr+vMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333



On 1/31/24 10:17, Michal Simek wrote:
> Describe soc-nvmem subnode as the part of firmware node. The name can't be
> pure nvmem because dt-schema already defines it as array property that's
> why different name should be used.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Fix typo in subject
> - Make example bigger requested by Conor
> 
> Dt binding for nvmem node has been already merged and it is the part of
> linux-next tree.
> Here is the reference to it just in case:
> https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-ty@linaro.org
> 
> v1 available here:
> https://lore.kernel.org/r/3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com
> 
> ---
>   .../firmware/xilinx/xlnx,zynqmp-firmware.yaml  | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> index 870b94813a43..741f17c830f4 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -62,6 +62,12 @@ properties:
>         interface.
>       type: object
>   
> +  soc-nvmem:
> +    $ref: /schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
> +    description: The ZynqMP MPSoC provides access to the hardware related data
> +      like SOC revision, IDCODE and specific purpose efuses.
> +    type: object
> +
>     pcap:
>       $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
>       description: The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
> @@ -110,6 +116,18 @@ examples:
>       firmware {
>         zynqmp_firmware: zynqmp-firmware {
>           #power-domain-cells = <1>;
> +        soc-nvmem {
> +          compatible = "xlnx,zynqmp-nvmem-fw";
> +          nvmem-layout {
> +            compatible = "fixed-layout";
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            soc_revision: soc-revision@0 {
> +                reg = <0x0 0x4>;
> +            };
> +          };
> +        };
>           gpio {
>             compatible = "xlnx,zynqmp-gpio-modepin";
>             gpio-controller;

Applied.
M

