Return-Path: <linux-kernel+bounces-100471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD6879838
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63077B22392
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CF7D071;
	Tue, 12 Mar 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GYXF9jwx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7279B65;
	Tue, 12 Mar 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258547; cv=fail; b=eRUnJD6tQ0UXOOWYtEihSu77SPc3AcY+oiNRW9t7bwuaZFNioO8B+uHGHhOtiEoCcrvhrLV64EhV48LTZDmuuZvtFawIELgML/cVhJs/ZRU4DEZ16uGLHIUIXj4Yx15A7AhaD9f52dHkumv5B1l8flpQlBj445gnsuwWtjs/CaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258547; c=relaxed/simple;
	bh=uyxwpiM9Hd38RxfQrMcuAx+zpKYLGop6dz90vv7jdjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rRVSSSSNAqF8ps+ic8pXdvsqmXoUsUxq6o36UlcfMF/ZhhsQbPryrO4j//K560jVMLcl5YueLQzkMtrDan6ZDwU6idktrvXKTgAP1OqbpGxTTEIL5++Kc9CYlEUNDq6oJRIYSS01WP2X6k9kbQxeqdceJeWzRSHwWB/s5vkigx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GYXF9jwx; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvvQXQHESIxfGS1TvSMlmMsK/7oscdsAqReiTAHlLcCkhCyFunpE3b5ijSgYrlcxZ8dQ5/sUXo4rc52L0psLu5jPTAt2smauTFnW8a0/ywbN3rgk/tyJCEnJmF0qXsgXBSi8sLqogCl2yXHaWJ8VnboYviB+P32xtEUgpVR0JkZElOfV8kSwbOTJWvot/KbMFDhS5CDw+V8078ePNPtn0DOcpMq56KyF4NQP2RmYouwiS31EH5/Rh2FXQntSqUFDfIImm6frdCyhcDfG9NYPYPm6JPDzuXM4HqkW2XBrIzO7c1hmLHKPNKKVhxO89mL09Y71xAXCkAQMKyamv2WDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlfHN3SixDRRwlrOYC2b+s8UmxvJFbJ4WgzVRJ95w4A=;
 b=gfxBIBXFdnBRZZrrWQn9NpRMa3tRxAHgBBG4C3thlcYhXSuA3fPNCPg0JnyrWztUpWfhXvFoWnWeUkTItReyw1sfVsVAjQW5JESC32B3Gpbq8Mq+9paZMKEY4esx5fvoeZCLI2aMi3DG/VHsCHo3OQdSxDD3umJA47PbIsYn/Kv4bgBAvM4PIfRg8t8MsPlS4whO4S08809Yh6qh0haIv8o/TYtj0kqiRJC3bNwC/2DGYV2C/PqaBb4OxA23StWp7cSliBZION9NAYKtfcH5yo7y/8mvGGDA47UgnXhO7uBVH8JdvZA5RJ/tqFA41ag5Xli6pkO78HfLrGw5h4pXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlfHN3SixDRRwlrOYC2b+s8UmxvJFbJ4WgzVRJ95w4A=;
 b=GYXF9jwxVFeWMYp0/rhLzM2mErySSiACmy9U5yuKXtQOJqcI0AjiRhbLvgBUyOhKChixZ0Qp6KY3OA3Kod3p9yPX79NQuCiMhle9ghts8p+pHnbWFC9uHnj094VYKs7cCcMCvflcmxbMzKG97nbsjXzXwJxl+gNa15VOG26Q+5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 15:49:03 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:49:03 +0000
Message-ID: <4c1f2341-8cf8-4a5d-8877-9ba1d03defc2@amd.com>
Date: Tue, 12 Mar 2024 10:49:00 -0500
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
 <2c45d7fb-06e4-468d-9415-0eaa48c5250b@amd.com>
 <18d34385-fd0b-401c-9ca4-ccf22106bd68@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <18d34385-fd0b-401c-9ca4-ccf22106bd68@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:806:d1::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6687b255-9c22-4ce7-bef8-08dc42abf121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rEoZyXDzfVIh5jPGqeSYlbWTDpSEat0ZfYk6+K+B9SQz310lNWqvcMy25zbEYFfNyFKq4JNeInKAFOl2OPU/xovCaubMtkyXvwa/T5LJK/A8CBmsTWtvmsSfm3C/gHmW6jLjbht50a2lkIf4LurU2aOlAny2N6C+B0oXqDRAbQrxRgMRJluCzijgmFzTceVVbvPjFMDpPcAh4EdWeieJRQ/tE0ugpwDBKJvQR1ISlnK7DVReaJNz+wSGlZ3baTyaEBx294CV90w+mWx/WlVtztCMWs+NvMfHvJkSsHB2kxlwIrmKcA0NCECncHJXTTHTfglSphxE5A0SJDq7eOvpX+SQ3FOiDDD/qSeUKXy0SQ10uI+ttNBtQWvTz/Bq5T8I8g8QAXLBbtACO4IfnEupHMMXl3BMpAOZix8pIbjvECAvwKDvSMFJ1+EAG11o2kQULSYGS0TqTExYSMqyiQBA8a66W0/op2jY4Pu2rMbRoVxYa3m5U3cWJfpufA6fmoIZGYADHn4DabUD/htbzuLl3wKU++yq2zF1rLyPJqE1S72aRsbFs+gRSHwxsererX7wVM9WcMTA3l0RoUv413T8qfNANeCy+o/DMVE16jKUlsKGy+u+zFsclTaF7soIO2vT9N5K8j9p9alm2FhuV/KoU8LfTKnEeOSWFW9sHThdoNc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eit5NUVXbUN2VW9MT25xcVVzdjhBaFpZbVpEeDFsaTNXNDdFSU5sRVVBZ1Zo?=
 =?utf-8?B?b3lJNmVNSnRsbmZmNTdqZit1VkhNcFBHUGowbkw5U1pmcnY3cmFKNUYrS2ll?=
 =?utf-8?B?aFgyODlwZitJRy9WRno1WmFEbHlISWVQYzFPZGFPdjF1Tjh6ZTZ6VmRvVlJN?=
 =?utf-8?B?QmFod2hLdm5DeTlWWUh3ZE82aUFaa3VQQVpNUEgybS9waU9jNTZ6MVUzbjd0?=
 =?utf-8?B?c0J2MHcvVUp3cFY3bENtTGd0Q0dXRTMvZ3FsODVSeUVFeW5WREJyWlMyeG5R?=
 =?utf-8?B?ZUwxc0o3TDdlUEZxL2p0SjBOSjdkcTMreW41U0l5MkxzSUNtZUF6TWgrL3BR?=
 =?utf-8?B?VmNLV2JmZFdOKzA1TmhIU3BKQ09TaDgvYmV1bGtIK1B2cFFEMUZOWW9wUHVx?=
 =?utf-8?B?b1ZSTTY0NXkwQ1g1ZEZEcmhLdStwdVVDb1Y1YkRkLzM5TjhMWEVETlVaRVBD?=
 =?utf-8?B?NTE5am1yZDIxZmY3UVRzUGpaYWxZRmppaDV4emFyQ3kvVEFZaUMzUGFRN1Vt?=
 =?utf-8?B?eHBPQ1FRdEtTZ2szVWVxWmxpaVFFZE1IZjh2M0ZEMFRGbWx1NFJFS3dQMXdj?=
 =?utf-8?B?SGdkT3YyN3gzK09GUGFLcWNUbmtpMzFrNFNXS3RsSjY5TmZScHJIYlcwQWpp?=
 =?utf-8?B?SmpsaGlYUTJkWHIyK21LYk9YZ0h1ZHQxbkpRV0FobmNLV2tzUHg1aS9PSnN6?=
 =?utf-8?B?SzhTQVQrL3dSRTB2QWZNRzI2SFNhRVVlc080d1gyT2g5eGdsNDFlTUFKWVlV?=
 =?utf-8?B?MUVJRUFKOFJRZWZoTUNxeTY2bjQ4MDhxYzl2UFNNT0VvZFVkUWZEbUNlR2Vk?=
 =?utf-8?B?TVlJdVR2N3ROdTVoRW12ZTExWTA0RnByVHBFaDJEeUVqR1RqSXdPSHNUWDA4?=
 =?utf-8?B?R1ZNbnFyOWtHb1gva0F2R280cmliS3UxYTlKbDlSUXNsanR4SE1jNUFsU2Nu?=
 =?utf-8?B?VFgzSFJ4b3NhZlRXTDY1MUoyN0JHZ0loM05GV2MxK0Y2MWg5bDJIYTNVcEJW?=
 =?utf-8?B?ckMvYlNRWnhwSGVrMW1hVHpSdFNGNE9ab2kvbkh6clArN25qNVpEWDdhLzA1?=
 =?utf-8?B?WnpIYTBEV3IrQWx1L0dtVk0wZmtSYTFiQVJNNXQ1WnNiQjZ1cXRMMmw4NEZv?=
 =?utf-8?B?a1hHQmtYVnIrOGx6VmszK3QzS0NrcmR1V3ErTGU2eTAzZmNsUzRRVDkvRkFP?=
 =?utf-8?B?cjB0R1RlWWF6QWJkTm4wM0V4Qk9ydS9SZkw5T0ZwamJiVitTMVl5aW1BSmFS?=
 =?utf-8?B?K1puUDlFOEhjSHdXM20zaDFCS2RSamF3ZEpwZEt4cGJtUjBRQWpmdmZJL245?=
 =?utf-8?B?R1FwV2pVNlRZRUhrUFMzdmgvODBJK25kTDBSQjRvK3cyUjlMWVFueVp4UHlO?=
 =?utf-8?B?dHNILzVTWitDb2VISVVLYzNsTUk4dG1xR1hQY2t6em1SU3hmREtDcjRXTUFR?=
 =?utf-8?B?TG92QndUbmN0TmVtcllhMmxrVFJwaVNZeFlQRUNETDBDRFZaZkhOSnZUQ25U?=
 =?utf-8?B?WnRTYzVHdk9xK0pwU1FmdmpDLzYyTmc3dkp1VkN0RkxSUXh5akZacjZ0UUNt?=
 =?utf-8?B?WHFQVmlmWXIwSEZnNnUrS0FEcElCaDVMWG4xSXpkYjRKZzNVQTdCdDRZMFRa?=
 =?utf-8?B?TXR4QXMzcEtkVXAzYS9JTURwT0hzZmZEeVBXRFRGa3I0MS9aVWw1a1ZJN0tS?=
 =?utf-8?B?d2czSWhEbk55VDFyMDRjZnYrOFdlS0pUam0wRVlwWHp3ZU1Dckw1VGd6V094?=
 =?utf-8?B?QTlkYlhqSVlHZWluOXVoTFNJS2RpSUV5cndkWmNGOE5zMVpvODZUd3JSYVdE?=
 =?utf-8?B?aXRhYmxLVktvYU9oTjJJb3BrTzMrdFUzeDVCYlJXVy9MM2w3MjN4QmdaTklo?=
 =?utf-8?B?RTAzdEFZQk1jVTNIMDdVS1crRzF1c2JENU56T3ZVeXZyY1ZpSzlLYVY2UUc0?=
 =?utf-8?B?aS9uRGc1cGhSTGZsUURmVkF0Y0hZamJuam8wMXRVQVlzMlpYeGJWV2J5V1gv?=
 =?utf-8?B?WHBOaU5jMWRTT29qUWRwcUxzZDZXQ21SaHd2a3VIVmI1SGEwUTBzWFVxT1FR?=
 =?utf-8?B?RXI2QkRXS0lJdkt3Z2R2elJvS0d1QkFFT29mY0hJc3J5MGxuVTgzWFByVWl6?=
 =?utf-8?Q?MI63kG8ECI/UZxWMFBTI0zFnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6687b255-9c22-4ce7-bef8-08dc42abf121
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:49:03.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zczf7kykNvxuBHFnCHy6KvG6G5/kKRySYeetIxpW8G3nvxET14sy3QXotcxT6tSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059


On 3/12/24 7:10 AM, Krzysztof Kozlowski wrote:
> On 11/03/2024 17:27, Tanmay Shah wrote:
> >>> +    then:
> >>> +      patternProperties:
> >>> +        "^r5f@[0-9a-f]+$":
> >>> +          type: object
> >>> +
> >>> +          properties:
> >>> +            reg:
> >>> +              minItems: 1
> >>> +              items:
> >>> +                - description: ATCM internal memory
> >>> +                - description: BTCM internal memory
> >>> +                - description: extra ATCM memory in lockstep mode
> >>> +                - description: extra BTCM memory in lockstep mode
> >>> +
> >>> +            reg-names:
> >>> +              minItems: 1
> >>> +              items:
> >>> +                - const: atcm0
> >>> +                - const: btcm0
> >>> +                - const: atcm1
> >>> +                - const: btcm1
> >>
> >> Why power domains are flexible?
> > 
> > User may not want to use all the TCMs. For example, if users want to turn-on only TCM-A and rest of them want to keep off, then
> > 
> > they can avoid having power-domains of other TCMs in the device-tree. This helps with less power-consumption when needed.
> > 
> > Hence flexible list of power-domains list.
> > 
>
> Isn't turning on/off driver's job? Sorry, but what is "user" here? DTS
> describes bindings, not OS policy.

Thanks for reviews.

Correct driver turns on off TCM. However, system designers (users) have option

to not include TCM that is not needed in device-tree. So 

power-domains are flexible, same as reg, and reg-names. ATCM is always

needed as vector table is in ATCM. R5 core power domain and ATCM

power-domain for each core is always required so minItems 2.



> Also, please wrap your replies to match email style.
>
> > I can certainly mention "items:" under power-domains property.
> > 
> > 
> >>
>
>
> Best regards,
> Krzysztof
>

