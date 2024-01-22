Return-Path: <linux-kernel+bounces-32639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1D835E57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED80B22C00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEB39AE7;
	Mon, 22 Jan 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zQ5zDcFp"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1A39ACF;
	Mon, 22 Jan 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916214; cv=fail; b=IHEw8a2yApEyPyxPFAQYZwAde8E9Tr0XS87sHWJQ+OM+2LiWc67NsF2xdArwMfD0O5Q2Kt3Qjhiod+OMTIvHvSEQ+wO7gYr3lUbeQNNgF3hwq22OmjYrSxj7Y5LsOfAeHzcoUW2HCEP77Zd1g/vFqxCLyinpyeVrghxF6OIdrtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916214; c=relaxed/simple;
	bh=Z/01aUeDoCt0zF2c3+XD134p1rztTMlXF6DFJ9IQ4m8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EWyuiJRq5CbRmU/nr7jMOHD6JS/j4aFBKkoXYAzcFKaogdu4VjEUgDvtH5hcL4ohvKibl6rF4WEZbxh8lVkP8GYL+zD7lds4onEB4i5JdhCVbpiSyirTBl6Y3BAb41/OAV4zXtCLVeRByzKqhvps77QeuoPMjtt5eUOHOPBXRpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zQ5zDcFp; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dywYW29TcoiTnJKPlh1UN4d5S+/y/ihepIPtIJVdHCqv7GwDTznG0ThrGWJThagf10w42RHdFr+dkgRLL67Ov1mn8EISc/hyI8jZO2NWNOMvdgPqlobENikLuhElgdmxwBe+ChvozSGgOnm7NGayv2hhLS4jS+82rEjMiqQRGYWhDtVN+Vbh747eOqM4mjjf1IqsyM0svQYVvYnJA1Ge47iCRJg7pGqHq5QN3hae1uc0Kzo+sWw6Zt+rkiWmH/QiCQj3cypuwtSxrlO1h1rZcGlwAFbjpkvJ6Q4d8uUEarqqS7EgI85CMwXyrHKDWbH5b21bTgR5w0MDD8cTM7vXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT2QY1kmyvFxAEoZ3SuHyEG7iBAkU0xTRN/6noc4SjA=;
 b=P0CMEE/5TSBYbOs6+EHZLEmZ6NOlarZ+9uYPBFArWuulFfJbzCexcndb7b6Vm0izlJ0hgTMkZz12QI3WkoOMMpW6UrFTlcqF0T7h7V46CVMnO+CbtdO/lErDkSA8mJHYGVI3VSd1P3gHW8C4iY3PHm9nCxk+NsTS8bZEPgeXggrBe17raeNnp55FuMPwVdJvkG+idd+H1egy2ASgdeoVTa6VADSf7PHOUq199nFAeoj7iMTwyvAWoTwhoCOe8MkgarsEei02TiTAneUgw7aCl3m1uNWm30kJbsQnqJn0z7Ix3e6YiXp3IQgdNbWqcVcUdYyRW0EHng3h5jXvoHqumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT2QY1kmyvFxAEoZ3SuHyEG7iBAkU0xTRN/6noc4SjA=;
 b=zQ5zDcFptFRsrcguyEszorVTNWQf5M+jf1gJXUGU8d+PA023KdP4vP2iI5Do/7O4+R96z/jrBjU0k+l4d3OKK8PRR7lSEyydcgPQkxuk9Olkhsar1EpeLQz6wq9JNPGTJNmDNcc83frGa4pf5V3VlymDu19zpE6HmeYDOSx66Xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 09:36:50 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:36:50 +0000
Message-ID: <cc27318b-500c-40c7-bf73-09514d11dfcc@amd.com>
Date: Mon, 22 Jan 2024 10:36:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, dlemoal@kernel.org,
 cassel@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 p.zabel@pengutronix.de, gregkh@linuxfoundation.org, piyush.mehta@amd.com,
 mubin.sayyed@amd.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, git@amd.com
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:803:14::16) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c84761f-9134-4763-caf9-08dc1b2da8cf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GffYrqQ0ns8LdMoY4aAswuwiQfoZbmJO4K2VnJ6dP+lwEWSYGRvx/wW0VJLKFro5/abbT/VikpktbtssMCQ//2GZ2tq00UcZlJy+1KdWClQkitxXlqJZA+WKSs5Q+uWVXeGg/GM0T1cmDv+f6SYsB09WAa9kCqALN+n480r4gadJ48zPc/0QmLQ7QzoF8X7rDGgzXhbyCIvurkfc2Y1cRep0QNTatGll9r5RatzrRkzHQHqnmCiL/zzXfRZ+Fgd4/F4nPNIkhpjycgcJlBJmFTD3dXPkC0/DC8gcyIe03hFwpf40fqlTkYapHtfq7Dc2XN0K/PkKF4pzeuL7s/8ZbH9oIpt/XXDds+7C62fUzUPepC4Fr2jM4hTtebVOza0s62cC+mpXwkxTQSip2sTeURy+HWlCSXnNB0Z9pHfXa5HJtNB4+uL2DjUqmVmlBHD5mmPyTJ/neYsRXwjI0Hogi2D3Ofhgvd55ihoymB2e8rAZ67hLx1BclU/YsM5Jj6/AC+wdogda1qMLvu5JlNcedmQNtE6tTeHmkWFoSQdPJQVyb+gR9/1X4x6Ulnc0/kLTvc9kYdfZHpoStfJrzPWmdX7P21DZlRgi4831F4IQ4+S90QyR3YUB1Ikvpb8Rsi42JRnMqgE0RBOYd+Heaja8yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(6506007)(6666004)(6512007)(53546011)(26005)(2616005)(31696002)(86362001)(38100700002)(921011)(36756003)(41300700001)(44832011)(478600001)(83380400001)(7416002)(5660300002)(2906002)(8936002)(4326008)(66556008)(66476007)(8676002)(66946007)(6486002)(966005)(6636002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VoeUpGc1VzMC9oazRFU3czc1VabGl6aW8xK2FFck5LRzFFdHdBRURaWTVX?=
 =?utf-8?B?MS9sd3pYeGpwN09Pcm41Y1VIT2VEbHJBVlBtWEcwNUt2VE1VV29NaEhudFVt?=
 =?utf-8?B?ZnZMQ05ZdS9WV1YzZWVVOGpUSmxlVmlmai9aNHJIOTlONWVXZFl2SVVIeTlv?=
 =?utf-8?B?U3FnZEhQK0VhL0ZXeWo2ejZ6VkxoOHdCc2lRNzJ2NjJMMks1ZDlFRXR1L0FR?=
 =?utf-8?B?SXAzcEdEQTZCUWUvbXBsRFdZL0tNN2MzK1k2N01lVER5bytJbUVyV0JFSnQr?=
 =?utf-8?B?YUwrdUE4RUJUZVhEVVpJM0xicjlIeWQxWFE1dExCSEplN0JpRHZYb290azhp?=
 =?utf-8?B?aWdLanNYVTRzLzFnTkJlYWpBZE9TU3lYaUoxTnZtc0tuM1NWUGtsb2ZpaWtL?=
 =?utf-8?B?Z2ViS3QzT3pKUUpQN0FVdnFGM280VytwRWdrZHNCVUphSXZNU3ZXY2dFQW9G?=
 =?utf-8?B?THNDNGdpQmlKQldwM2k5Z1B0SzRVVTRKT0w1TXB3cWJqY1FtRXN4eW1tWHpq?=
 =?utf-8?B?MjJ2MXpRa3plVWxkejZPUnlQWFhrUVZRWHhjSmdib2IyenNrQm1LNkZHMXM5?=
 =?utf-8?B?UXB4QlhNMWJVSjVMbURhbS9adGh3NWRNaTh4Vkl4cWlDbUlGUHNJRC9rQWJk?=
 =?utf-8?B?MXIvVVZmZ1M4Umo5eGNOMVBTNlRFQ01pbXJ6bmh0RnoyamM1SDlPQmlyQTAw?=
 =?utf-8?B?a1RmSnJ3aTE0c1pKbGkzMmxUbjBXR2dYUkdoQmd0Yk1Zb3M1SmxKWEY4dGVo?=
 =?utf-8?B?b0hMRjVMS2VROGMvMkFZUTJWbld6STJxWjVwYW1EbCtpaC9WOE42NDZpQkdE?=
 =?utf-8?B?WWpEWHl2eWZLYzc2KzRvbisvOFFoMGdkNlBkU2MzY3Q0cmhpWFM3N0hzM1hv?=
 =?utf-8?B?aFBXOE9HaGMveDBnVE5hQWVub2o5dzlYNFZsZk9SKzhoWWlRSUh0UHJCWUR4?=
 =?utf-8?B?cTl2Q21JSkR2dTMySE1pNFYxeUY5V3BxandoQno2SEpKUVE1cnpNYjhJVkF6?=
 =?utf-8?B?bkJaT1FqdUIzN2IvSmQrWFM5d1drVnNYOFRJVGg5c1RMUFhweE4wTHVNOFRQ?=
 =?utf-8?B?Y0UwY3RZdmhDeW5zTE5UNUFGT2IzWHpndzE1c3pXZkk1OW9JT0FieWFsQk1y?=
 =?utf-8?B?VGprM0hOeDM0Rnh6YWdZMGNsQkc3c0dNMDZ5QVRkTFI3NlAySGliM0YvMXd0?=
 =?utf-8?B?VG5UZmNhT2xHZTJzRmdMMG9PSWNRU0lKQnNISC83WXo4akdJZmwwL0xaeGhX?=
 =?utf-8?B?R0x3ajlsMFkwUHhNcDZBUURpczRmWlE5UWlpQUZZZnRIRkJCWFBxUm9GeWFY?=
 =?utf-8?B?YTAwY29xWTAzbU16RmhiOGpSOUJyaVlUTGtZeTRLUGdDRERmL3p1ZjBQMFVs?=
 =?utf-8?B?V1BRdzBoWmRERkhkbzR3aEd3OHFWdWpFNHlRemdrbzFCQUR4S3o4ZE5hQ1M5?=
 =?utf-8?B?OGpLU0xpajVSMm9vaG12M1k2VUh2V0JBUE15WmdTKy9jY01GejZrbkpzZThs?=
 =?utf-8?B?dkNuM0h0RUFLZFhaeExzZWNLZUpTTU9BanlrbkRxbDFIZVdKSnlOcU9pMjlp?=
 =?utf-8?B?V1d2bjQ1dERndG1RSkJGalJxVXJhaWZiSXJISzBSTkRqZ0wvYXVXVEE4RFdn?=
 =?utf-8?B?dEJkb3hQUEJDZHVTdXhvUzdpZmZJVWV3MVg1Zkx2eHZ4TktYazhhU3pzdjVR?=
 =?utf-8?B?SVg2ekR4NWtUS3pEVDNMcm1WaGs2Um1pdmNiY1ZGdWp5NmpaZnI0MWtvaXp2?=
 =?utf-8?B?ejBQdXhjckNuQ1JLWGRMcWhtVHV6ajJ4RG1sdUxFV3JnQ3NHRXMvQmF2VDRl?=
 =?utf-8?B?OXRsNk5SSWp5K1U0M2pTV1hYdHAyUmY1VWQvNmQ1ckE3eU9wQnBjSHdKQ2d5?=
 =?utf-8?B?K2N6eTBZaUpRS1lVMDZoOGV2TXQ2UDVERFdDUDJKbnpTdmhWRG8vWi9aL1pO?=
 =?utf-8?B?VFRmN25FYU9hUWxZU0krY0VVRDRTdE1tUkpoWUtYWld4ekhML2QrU0tvWE8x?=
 =?utf-8?B?d2tDRUplTU84Q3dTL05oY0ZaQTdFa2U0Z0UxQVdXenhKUWdnYkRGQ3gyRDV0?=
 =?utf-8?B?UEg0aC9qK0FodnVkWm5ZbUxzR3B4RlU3OGs0M1BGQkR2UXlqNXBRSGZ4TlMx?=
 =?utf-8?Q?iyG3IGInoRZm/N0Ry0LRoc/n3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c84761f-9134-4763-caf9-08dc1b2da8cf
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:36:50.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vp3OMxv5Zfmt7/iVqChA4JlREPPNR/JH7EI8r48RCiXnzPSaWJGJb8ww0hpkzJPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491



On 1/19/24 12:36, Radhey Shyam Pandey wrote:
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>   Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml      | 3 ++-
>   .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 ++-
>   Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 3 ++-
>   Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml         | 3 ++-
>   Documentation/devicetree/bindings/usb/microchip,usb5744.yaml   | 3 ++-
>   Documentation/devicetree/bindings/usb/xlnx,usb2.yaml           | 3 ++-
>   6 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index b29ce598f9aa..9952e0ef7767 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Ceva AHCI SATA Controller
>   
>   maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>   
>   description: |
>     The Ceva SATA controller mostly conforms to the AHCI interface with some
> diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
> index b1fd632718d4..bb93baa88879 100644
> --- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
> +++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
> @@ -12,7 +12,8 @@ description:
>     PS_MODE). Every pin can be configured as input/output.
>   
>   maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> index 49db66801429..1f1b42dde94d 100644
> --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Zynq UltraScale+ MPSoC and Versal reset
>   
>   maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>   
>   description: |
>     The Zynq UltraScale+ MPSoC and Versal has several different resets.
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> index bb373eb025a5..00f87a558c7d 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Xilinx SuperSpeed DWC3 USB SoC controller
>   
>   maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> index 6d4cfd943f58..445183d9d6db 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -16,8 +16,9 @@ description:
>     USB 2.0 traffic.
>   
>   maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
>     - Michal Simek <michal.simek@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> index 868dffe314bc..a7f75fe36665 100644
> --- a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> +++ b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Xilinx udc controller
>   
>   maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>   
>   properties:
>     compatible:

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

