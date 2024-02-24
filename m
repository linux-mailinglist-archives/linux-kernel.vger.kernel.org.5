Return-Path: <linux-kernel+bounces-79590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D425886248B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602451F2302A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D792C862;
	Sat, 24 Feb 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V/lLmuSL"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2072.outbound.protection.outlook.com [40.92.107.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509625575;
	Sat, 24 Feb 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774455; cv=fail; b=ZfLKVHw9Se5Tn6bwZOAttAVwa2amzA8Vji7siJwoSthuBH8xidZai9VSogcJzM3iuJ+iyr7AHhT5QZbNEDnSgoC2BN6KbyNzVZoDpCE9KlCxTleCzne2vKtoSY3+LdqSW71b+X+zPiy0QzzJeXNDzs7uWKWvcG0J6phnDmOg2o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774455; c=relaxed/simple;
	bh=poVroh8ar8IIXY6Yp15kmWDlKNYpGmxLyFARAdOisrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PO/k3jbt39MGjnTa05w3pW4Y2Bis3Ngtqd8TbK262NH4iP3K8TpF70ubcPisksnNoekeL7Y99T222Sci2oGtcK/QfBbZHz92BIDgzRI0C3Ih0kWNHC5PxvAPZMXTTLGA+2xd+IgdfhKXksQXjFeqm4mWuPOQdzfWRgU1P0/jUGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V/lLmuSL; arc=fail smtp.client-ip=40.92.107.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+14Zgyn3RdX1eIJvSHSZ23DlPxkCAdmuUz/qkGL3tTBAQEiA4T4Nx87N3ZTxAI0H5ECdZlxP3OgYg00/duKqlUgAnYwMro+p8QMQIdSgFTa8K63mLj61OnFr5V+l4adc/B1ToDO2v7NIc9YY4HcAD9YbcLnQdzwfnUec9NSYCSaSaUmhaTskmEzWR/cwrxo2wRPSJj5jxQjHRUHfnd8Hv8JLhMIeI08jGRfNldR6kA2zsZVmQlQ6vuQEH8xt/qQiRSLbDhKvR+VBwAdG0RtEeJ/3Uz5SD2Xlxhbq95eNz3fju6okXUwrD40xT1U/hkI2UmFgfllFtdUQkl18z9iXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz87vnQmTAIfaU94C8v8q1gEXONxMVBrH2XXpjUx+5g=;
 b=H5x/s50J+V8722SvlpV41smWxQuthxsBVmUK8xlMKjcPe1y24ox6CNCVtvgWCbj6lgLwPpXIHratDdAibZCTNGm/L03Q1Uc3+S4lHQQwviSc5wnUz6sBg7qY1RioQJ5Dwq4RXdK9oEonYO/g2ZIFtZmAEUzw7pbaHbH6+1bQUopEijNmiK2Yb4nOFHG9jSvvhVT2kDXo6TiLnbXv7/EFzYRVNyoXoFeF52qk5F6KDJqFXD5VxTRyzfR5eF7xzOrbo1VTrT9Gc8M6R4HoHgfOOw65XPLZx6c2nKkopKfJ2rCDC+baoUtz91kxaY2kqq+2Cerv9CZKJ2qLNd7pcIVqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz87vnQmTAIfaU94C8v8q1gEXONxMVBrH2XXpjUx+5g=;
 b=V/lLmuSLiKuDOf4hUTf8h2bfvtqsud8T/wh12DGRQdiWow8vHUZXvmozoMpLamPx8hXeRjcU3cef4iF/FbH+qFFolOVvzcKx0b9e8U+0RfooTaVl+JCj/eYkx4m39rYSOl+uuMsydRj+a6cDlaa6aM8wFDWTEOPkwyzctkw1kE2erjUt+VaH3svPFCNKvC16xDWj+Dp6rzUXgauPCzsyQzrXb6BLgHXkR1ZGAn+m33dl3wHibsmjOI58XuOfN7fbCROUQNeQnCieIrLgYjb7jao8OhmGMkLrUMm4sLeeOhlkcnzpGZqvkosb/V0HvClPdaszaqbljOTY8xQIpb1MYQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR06MB7035.apcprd06.prod.outlook.com (2603:1096:820:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Sat, 24 Feb
 2024 11:34:06 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 11:34:06 +0000
Message-ID:
 <SEZPR06MB695934A8E7DEAD4366433AA496542@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 24 Feb 2024 19:33:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
 <20240224-dwc3-v2-1-8e4fcd757175@outlook.com>
 <b64155f2-2965-4ea1-8c23-7c79d7a01c9f@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <b64155f2-2965-4ea1-8c23-7c79d7a01c9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [atjOoS/3My+gmj6gyw1ZL/qVHoDIoGP45cD5NuFpJm2dAtvBKyF+dV4SjDbLp9kzMghsoz6ilXg=]
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <816e5a92-4ab5-4202-9c14-ee49e2430d9a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR06MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e5cbca-ff31-43e8-176a-08dc352c821f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e9o4WaLiBzsbs2PDue/HDxMPbYBECPs04WpWame3eU/SuXyqFK8LxD+UqxCXV/ZCg266ESWYeDOdgd9JxdGOvojW4HNtB+lFdBVBcVJ7AjgKGEGzlCPbFyHsW9k8JVT22R0EKS/sDiTrvxL/hVuOhe5gM1Ke/wmrXeu8Gkhs4YvyjwECUTV5qXhL1cVAi4PFeQlQGn607VWTPIYueAqYhQ3pSJP1HppV6lEarOB+JfKtbBqBWF9DoIHm9ABCQbyeY4gzSVie/bsds2JawPj8x3fQVGXSgoubwbpxpWFzu0ifueOpPB+STlWUDSQjU5nQsE68O+MOunMkVWYocVJ+kU1DEjdAzxg5DrnOiTnKVEqb4e0PLRduNZsNEBqlU8H6d177E/1TTJiuq/o3YsD8JyFh+1eHuqDNsiy/12nGBWU+q1dryKSp5Sbk/7eZ1UlTSnq2N0Vb+BaSmqffrlccUlRAaktoR5crM08oDCxSbTKiWrg8K1lBprqFIbKFpBaVjEVI2dHn+7hz69VGUIo+qPZdD2KBDfRZDZbZwxuxTL3jui/kZIgztnceyC60tG9P
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bytQeDhCMTk4YzBQSHdwc3hBTzQwTkRibkEwRWl3Ykx0SktiZVFzdTFudkFH?=
 =?utf-8?B?QWFucFo0Unk1ZkFuS2JOYzhkUVoyeThzaHN5b3ZDdUIvTnVxVjdsZkJzN0c1?=
 =?utf-8?B?ZUpXMlNmaUs4cld1c1d3U01iV09xcG00UHVVcTFVM0VXT2VLM3kyYlAxQjM4?=
 =?utf-8?B?enFOOC9DcGtONnRBbTVDRmpaVVU1UE5wMmJXcEZ0MlVrQjJKbjZnK3F3TGlk?=
 =?utf-8?B?aktnanVGVFRpSm1zeTAvaDZ5dFh1bzhmRjF0V3owZTRJcXZuek5POXJBOTNp?=
 =?utf-8?B?YUZwbWdDd0hITEtBZVJUdzNlNklna3c5TTF0U1NZdzBQQWhhS3lUR25vR1Ey?=
 =?utf-8?B?TWd2UWxIWFlOTStidjB3SjJRQ1k3SGNLekNYUnZibUZOZ1VURGp2YkgyalZu?=
 =?utf-8?B?SlVEZ2ovSHJDcTVicExCQkp3Z2Z5a2pSMU9OV1hhY002MmhuU01hZDdjZ3BP?=
 =?utf-8?B?NlRVei94Rm5Dbm5sU2NZak5ubGdjaDVhRm1VVGR4cTA1Q3p6VWdOWHB4azFm?=
 =?utf-8?B?SW9xSjRXTkJLblhYMW1XSk1xMng1ZTZZUDc3Wk1ia0tlZURaUHhVcnZKWGUz?=
 =?utf-8?B?eFlPRE4wTmltUkxMRVZMOXFpeit5cHl6YUdGVGpWUGNraUp0UmNMUU9JSU9h?=
 =?utf-8?B?THpEc3U0cnVjNEFGTW1PKzkyZysrYUJ6bE5wSDAvZGtYcmpiMStqMkxuUXBJ?=
 =?utf-8?B?OHNJd2ZyV2hQRTlucXBnWWZIVVQ5KzhFTldmMHBXbVFQWmNCcnlZSk1yZ0pJ?=
 =?utf-8?B?R0grZnpGMFJLNnhqRG5SdTlTbCtoR1pMUmtyM0E1QmEwczhlMHVzZ2FiQ2RO?=
 =?utf-8?B?cnRkMjYwczV4dVByMFhSeUlGV1puL0JBTzJlcnVVWmtvODlFVTRBS2gxNFpV?=
 =?utf-8?B?V2hZUkd0WHFxc3F6dGs3bWppR1ZTUTFraWRDVlF0UENpcm1kbzk2OVNnOXFQ?=
 =?utf-8?B?WGVIMVlWN05zY3hnaUF6c2I0V3paZm9lOEVkNUhybnk5Z25NWlNaQjhhNTgr?=
 =?utf-8?B?MS96dk9LQnd3a3Z1b0lBZ2JpRnJPY0lidFlZbkR0TFBjdjVGeDYvTTZNODlr?=
 =?utf-8?B?T1h2L3QyVjVCUXpNZk13MGtOald4QlJvdWZwNEEya1NJUDNiMkQ3M2hPWlh6?=
 =?utf-8?B?YU1vSkFiMkZxOG1NRVVFYXdDTkE5NUVtYkk0N0N1aTFJdkV5SkZoQ3RNQS9t?=
 =?utf-8?B?emlodVpLbXRDNUY2dUF3QkFDZ3dqYTdTd1VuZUxSTjRqWnUwakxqV0d4M215?=
 =?utf-8?B?NVp4Qml2UHRZRFFFKzNtQjM1S1loNE40TGZBYk1ERjVGUXlPaDlKRlhHUi84?=
 =?utf-8?B?U0ZFbVF5TlNDWmhuSWtMRXdhb2lGcWMrbmxrcGRYYUtvaTBqcm9GN2pLRmsx?=
 =?utf-8?B?QXM5bU83MlJ1UWpESWFBWG1sWnpITE1TaTNNa1gvd2dOVHdySk5EN29BNkZH?=
 =?utf-8?B?RXJTQ3dPQUdOSmx6OUl0a3QxVFdGQXhjMzhENVlnYlJ4cjkxQ1pScGp0UkZE?=
 =?utf-8?B?R243Y2NsVlBkM1llazFkc2pqdThUbTJ4a0VuYUJINzdyNjdZQU5uQnV2YzRF?=
 =?utf-8?B?Zng3WmQySi9FVngzNnZlS1hSSkU2eUZOWXhTU1RldE9teTc4czhiS2NUbU9X?=
 =?utf-8?B?dUlubEtNbjVFalVZNlkvZUtQUDRRVUdROWR1c0pyYmVvVUtSdVpERGdrVlJZ?=
 =?utf-8?B?dnNQazYwNW5NY2tyR041eDdYUjdjeVFsNHZRQUEvK25YdkpkdldlMzhpN1Uy?=
 =?utf-8?Q?hujIBhCyEARcSRYYtcDJyXujSerejHjJJv/gayH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e5cbca-ff31-43e8-176a-08dc352c821f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 11:34:05.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7035

On 2/24/2024 6:28 PM, Krzysztof Kozlowski wrote:
> On 23/02/2024 22:43, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Document the DWC3 controller used by Hi3798MV200.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>
>> +
>> +properties:
>> +  compatible:
>> +    const: hisilicon,hi3798mv200-dwc3
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  reg: true
> Constraints. maxItems: X


Is it mandatory to have this property if this node is going to be under 
a "simple-bus"? I'm taking rk3399-dwc3.yaml as reference. In fact, dwc3 
wrapper on mv200 does not have an extra register space. The wrapper only 
needs to turn on the clocks and deassert the resets. It does not 
need/have a register space.


I don't think it makes sense duplicating the same address twice.


But reg property is required by "simple-bus" so i don't know why there 
is no warning for rk3399-dwc3.


>
>> +
>> +  ranges: true
>> +
>> +  clocks:
>> +    items:
>> +      - description: Controller bus clock
>> +      - description: Controller suspend clock
>> +      - description: Controller reference clock
>> +      - description: Controller gm clock
>> +      - description: Controller gs clock
>> +      - description: Controller utmi clock
>> +      - description: Controller pipe clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: bus
>> +      - const: suspend
>> +      - const: ref
>> +      - const: gm
>> +      - const: gs
>> +      - const: utmi
>> +      - const: pipe
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: soft
>> +
>> +patternProperties:
>> +  '^usb@[0-9a-z]+$':
> unit addresses are in hex, so a-f
>
> Open existing bindings and look how it is done there. There are no
> bindings for DWC3 glue/wrapper device having a-z.
>
>
>> +    $ref: snps,dwc3.yaml#
>> +
>> +additionalProperties: false
> Same comments: open existing bindings and take a look how it is there.
> This goes after 'required:' block.
>
>> +
>> +required:
>> +  - compatible
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - ranges
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    usb@98a0000 {
>> +            compatible = "hisilicon,hi3798mv200-dwc3";
> reg is always the second property. ranges is third.
>
>
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
> Use 4 spaces for example indentation.
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


