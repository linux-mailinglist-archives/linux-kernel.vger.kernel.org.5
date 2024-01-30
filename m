Return-Path: <linux-kernel+bounces-44449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C9A842244
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73222B2F772
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C267736;
	Tue, 30 Jan 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqLD5IFM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711965BDA;
	Tue, 30 Jan 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612531; cv=fail; b=GCr7RzhZmaOYHFsJzbVbzFPIb5EsmfWDINiLxPmhPgro3W8RRlur4nhH9ZfatDsrOFQrnsD0Djv6WqCcdXsij7tGOv39P+3GHMNDr9Kr2tD43wdptlwdbs5FY9Kbb1VSbf2fm8TimDGraOcD9tr0mLHV2oXF5taz/VJWJvQeSpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612531; c=relaxed/simple;
	bh=WmDjuvfGtfnhf4eoL8c8+KdAlaeknETRxbRlAneqjbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RifBOWAa+u/7LMGuhFqqFmyALYBCR/4tm/1IhofuUxd0XNsEXyVupr+5c6seiVG06XQdlfmPmqqaI0fw7sAMXIp2z6IkH89r7SKJXyLGQWtYktQWjvuhTzx8jVue52xYA83qW6Qn5Ka59pEMf00djuNTmvMjLDedSPdCRdeDWMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqLD5IFM; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp+tt9FEGjoRvEyjmi0df+cpOOfa8dOXE/48apPIyibXE+g/56fHqE+BcLHgzSAnCRyIZw/0cG8iJ5mIntvXYIR0Lp9SKrVmdmGhQg2EtRKWomev5qi2OkoCR8FN3g92aBLUYcuxtiFDcd1KHlOb44rW7IT4zFpihM3V6zoh6kz5coXBo1Vam3J52euIQ8iCloSlaP5GLEyb1ckRMK3rCpQ7jJ9DbMGJ7sMNOamtwFUZ02pi3MK3742tqq6JTSY1AW/viRord3OunJPwSLpRFvjsz3FDvtLDsm6mvSTv3wjQ9Fzvq4AA1sqFadyBtAp7+bNAORtA7lnBk9DKG/pCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3v4o3PkTtHjbN86s4z7VkVavzlOzV0eHlFpk2cRqHY=;
 b=e+oJeBHMrEXqbQBex+sPsefjd9Xk5maSU5wN6pyLBzhYwHiWq25jVwvO6JnBQFnu7EAJLGW6l7OoT/myadtOa2LvCIrBTAj/h06XoJqt++KGD2RI50p6KelbrLDl3gvrehDFE/A2xLx7D2xmKx0N7YxUwUNJJ95DFs4GDVoQsMv0VH+kv4745RuW69yeXDl8cTXlFe8Vkb4AdVVKcvNAKWrWrPAKZds3xF807rcM98RRTnZTld4/hOD/Gex+674yDvMuYfXQm7O3OrmL7WrNEKoJkFYM7RChVkmELJ15CKip6VLMhfyBLpMdNjsu/3mqEEJMS+78K+Q3pBaEDASHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3v4o3PkTtHjbN86s4z7VkVavzlOzV0eHlFpk2cRqHY=;
 b=EqLD5IFMtBa50wxDsvazoOBRRaIjUvcrNSpzsX69poUtuIjVJUVyoEIdjqGnzJKVySKTGL6WzfyJA+oqpQ2WE2QswJnO+54iQholInrmhKBdfuC3gIQX+vnDg5UzSGnH0AgonglhywsbyfxauXk4nVSwMBYW9J0P4ciQUh+RuQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:02:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:02:07 +0000
Message-ID: <7105e914-6e72-483d-9962-813cd9b33a14@amd.com>
Date: Tue, 30 Jan 2024 12:01:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: microchip,usb5744: Remove peer-hub as
 requirement
Content-Language: en-US
To: Stefan Eichenberger <eichest@gmail.com>, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 piyush.mehta@amd.com
Cc: francesco.dolcini@toradex.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20240130073505.8916-1-eichest@gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240130073505.8916-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::41) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 6992afae-b23f-4619-096b-08dc2182e682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dxHX8EMgsMHG3g/q4pSY0BKfi1oCJXCrp5kKJQfo49rDh9EgXmwnpoFMtzEyv6wQwg0t6zdV7Zj4SuF4mf3/U/eiaX3uBBdAIBrZpQBTjW0xAYd91nP39y1lZ+MGAeLGIQOJkrHYi+exnxoUYCTuqcH+G/36ApZbBD7NpyOEBzct+6nNz2uBPTrYjsahsCdR5gVG7Jjuu8Sl3s/J0spuSQjUz3CeYLPQVp+jpvkK0Th26Z58qTiV4NJQc6lCpNH8MRUSIaMkNBYgKZk/+TfNJkDAK1Dt9eCcEpRnhZsdyahswpL5tCBbELZ4ZWUWTnlUR2mAxhA2V/q3pXeYPFQo727ay/SBfajX8pgBEgHUY67nQSr3SqpHSY67DEVwL1YKk6ToSeS/7GAkGweg6+Uk1BLG4Qdvp2MznEZKuIMoKpcYWy8hZWl9uBUaPk/h6xdxN7+lVoUh3O0/Qv8mfDSI4EqswA2GV6sMNpUc6jsKOoUS28vQgIvceuT9GBjzYTQMNP6pqKMv9DdVo/39kB3gSjiLjV3i5wqvJPd6rhhxE7vtdRTCfZ3oT14+2vj3st6Zysz/SDAiEzxn4ePy4v5cR3ZaEwDRg3Gi3fFjit0fk9CowKSQRjncgG+hTvubW/oSj2FdL44G+GEJw1+ISS5R0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(31686004)(26005)(6486002)(478600001)(6512007)(83380400001)(6666004)(53546011)(6506007)(66946007)(6636002)(316002)(66476007)(66556008)(4326008)(8936002)(8676002)(44832011)(86362001)(31696002)(5660300002)(7416002)(2906002)(36756003)(41300700001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFJPUE9BOGFFR091aXZMK1E2WUtrWTc0UW84V25PYUNOdlMrM1U0VDVEdEx3?=
 =?utf-8?B?R3k3SkVCYmM5V3J5dUxTaEYwY0N3eTkxOEFCNkxPKzRQcWllWjE5RnE0elN6?=
 =?utf-8?B?ZUx1aWIyNnhUQnpCWlRVU0FxSW01ZUxEeWt1b3Jzd2dSOTQzNFAzRW5uR2lK?=
 =?utf-8?B?MHRPc2M0L3psMzNPMlM1ZjJtcWlOUFJkYlZzZ0dzd3lYcVEwM0VwdDlzcEVM?=
 =?utf-8?B?Zk1qZWhMcHBLNGN1VE9pY0hBRTJOVnVvd2J5c29QTDhyUWdZdndKRlpVUFlS?=
 =?utf-8?B?WGZEV3c5K09SUHg2ak5BUmpoUVJjdDZ0Ym1ESkRIU2FxLzZ3Yi9QZkI5VXdj?=
 =?utf-8?B?UktJV0h5M2xwelVsTmhZclYxeVJXc0x5cWJjVGJaN1V4bUp3cnJPeSt6ZGlV?=
 =?utf-8?B?L2RTd3RLaXZBR2VxTGxlN1p3elRqVnplQ2h3ZTRRaU50Z0VBN095SC9vRmpI?=
 =?utf-8?B?SEEyRmdlT3M3UUNhdWVsYzFRMHJTZVNEVysrTE1VTFQvN0MraHVhS0cvVGdj?=
 =?utf-8?B?a2NNNGl1emd1MWJIM2Z6eUVtNHphSVVOdlA5dEZCRndxaUc5Zm5WaENoTW1l?=
 =?utf-8?B?UitFOFFMb1grdGtxNm9LeStSVCsrUDVVTkh4UWNNanZHUWRFd0V2cmVROGtq?=
 =?utf-8?B?R3BjOThsSFRjZ1R6ZXlkYVpsR0w2eEJlQnhCUTB2T2hMZmNCOER6RnVteUVa?=
 =?utf-8?B?Qmt4K1VFRmRaWDBEZ0VkNGRwdHVKWjE2NnRDTmkwRjlFUENqQktHMWhFbnFj?=
 =?utf-8?B?TTduU3dza28yTnJhL05NbXdENEloTHlUWGlGdVgrMGM4dTBhUmg5VXI3RHZz?=
 =?utf-8?B?dTlMTXNPcjNpZzcyTnNaOGJYYUpiVTNuRHpCaXl1MkxubDh2dnZvOG5CSFB4?=
 =?utf-8?B?bWlOM2pKSC9yR3RmZm1GeWI5bkhIOGJhaTZYekNLYzVFR1B3TUJ1OU1SM3B3?=
 =?utf-8?B?QWRuaUF1OWxpR0pCS09yNHB1S1IyQTR0T1doODFDU2tXck1ONkdpZ0pXM0NC?=
 =?utf-8?B?dFB4LzkwRzdCR3VKV0JTNStyL0x4TWZVWDVtYWR5VCtMcnl1VUxIdkZPMjVE?=
 =?utf-8?B?STFIQ0dvYnU3alM4dG52a00vOHROVDV4N0hpZ3lHbDlPTmJBMGZDUWY1ZU41?=
 =?utf-8?B?YU1RcDFudmZaRXNaQ005eEhNeDNUa0pTY3YzYVEvSko4b2ZRNjBLTGdvV241?=
 =?utf-8?B?TEZ0WndZRFdZNFJGbGF3aWQxb3p6eDQvVVFvSHVZRWNYeGV0R2RObXRRclNV?=
 =?utf-8?B?dzFUOFpycCtKQlVEZWkyT2JsbHZXYW84R1RtWTZyMDIxb09UN0lUUEV4OTcr?=
 =?utf-8?B?ZkJxZTViY0UxT2JWRkdCT0xHYUZ3ZTl4RXhvMTZwbEIyUWZqQUN3MjVUcjVy?=
 =?utf-8?B?V3NUZytBN3lrWm4xYkNzQ05vbjdhTCtuUUxKNlFwMDhzZFZicWRSUm9JTEJM?=
 =?utf-8?B?YnBYVmROT0EyVWhWUFVUMzhJZXV4enNQanFWS2szM20vTHBpRk5kZnpiWTJK?=
 =?utf-8?B?ckVZenhUT1BvK2h1MzRreDVTQUZneCtQYkVnRXd6V1Zlb2UzWkZ1amt5MGZN?=
 =?utf-8?B?K2ZDMjZNck1MSEpJelNQR29KTTBzNElObEFqTVZoV0Q0MG8rcXE2UW1ZbFlJ?=
 =?utf-8?B?MjlGaThOS0Z0TFZRMk13aGpVNlJJZlRwQ014TjVEQnBxZGEreDdta2xubEJv?=
 =?utf-8?B?QzJrMlZrYlc3T0NFaDFIY3BxVkJXYVh3QmQyTU9MbUhoWlNmUzMzRktHRnAw?=
 =?utf-8?B?UFJmbDVEaGVLUWVLamJHTTIvVkdKNzBEaWJscXpDbXIvQ3hIekVDRElEVTZX?=
 =?utf-8?B?aHFCcVdlWjhDZjZXUklmRGZwWGV4ZjdBdTBiM3l6a3A4dnM5QUhueXZ4S1pt?=
 =?utf-8?B?UFErNFY3WDFsVU1HUlFnU0RaNC9DMU5aZS9JMUhna1liTWxsY2F4TDVDZnRN?=
 =?utf-8?B?aW9GbHhGSkltZ2Vmd0tHUi91TkVwdU92bFJ5Nlpxa01vWTd5WUpqM0JJZGg4?=
 =?utf-8?B?T2tLVHdrMUV1eEVuZWdTQ21xSE0wei96ZWFNN1BUblJISXpVWGlPaE5mZ0lM?=
 =?utf-8?B?aHFKbjZMSzVLb3AyQVcxa1JFRUIyRnFGTWg4V0daR3FHcHhxSk9QUEFIT0x4?=
 =?utf-8?Q?Gi/2yKMnoolz3qEPtUiAdoDYi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6992afae-b23f-4619-096b-08dc2182e682
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:02:07.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj2BsWINYbGaRWbsBaaqFUnE9OWJhkXeQfdmmidYMLW+nVFi1vW/je6AQQbP5mqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397



On 1/30/24 08:35, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The peer-hub is used to model the relationship between the USB 2 and USB
> 3 hub. However, it is possible to only connect USB 2 without having
> USB 3. Therefore, the peer-hub property should not be marked as required.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>   Documentation/devicetree/bindings/usb/microchip,usb5744.yaml | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> index 6d4cfd943f58..14dbb70b08fa 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -71,8 +71,6 @@ allOf:
>           i2c-bus: false
>       else:
>         $ref: /schemas/usb/usb-device.yaml
> -      required:
> -        - peer-hub
>   
>   additionalProperties: false
>   

Looks good.

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

