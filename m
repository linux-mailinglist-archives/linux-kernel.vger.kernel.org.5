Return-Path: <linux-kernel+bounces-158606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590EE8B22DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B4C1F25C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344B149C58;
	Thu, 25 Apr 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LfGb/KcN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821E149C43;
	Thu, 25 Apr 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051926; cv=fail; b=ZLHUm5XjrErGIDvfmrz/pUE+wmvE6CTh26UyvumsmXTIc1GlWJqernFtesasRC5r7XL0JMwbqdZ+JqeLMeiaKT0hNc257/givhGtDH8IP7ZA84kLRRNnPTUpUTBkJ8hj0xIR2z7d7mxAAaIb7fZh/R/rfGiippKk0RDy28q37gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051926; c=relaxed/simple;
	bh=xP1oWuogl4e48/T1+b2UsRBq1gab981HHxS2eK+48eM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=soHHeL6ndMsDScqyoD6P3iLEwOyt4sWJQDkClmMklSFq5aOtfNorPVpLPMUzoZsltRffZmQZFx+xtlgpBh6UXiV7mDpBuMGkEOm6Ay8qRCRjjuRYKHhl3T9n5+0drTueOuVf1VhHk0hfsxWJNTBb/lywS591xVY8P73Fzj2Qs/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LfGb/KcN; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjANCFVMSGSFBobIHifgCJfgKaMA7t1AJbHOljr/uuJ5MDycjY+BVt3KzV0403CsL8c9n2zij7y1IzobB7NZrGyUfOGM6yGqPplz0NJBKzvUU5F958CKnLWu6mZqPPRtG0tMpi7G9SoLM8Azy8E+P8aet3qXhY5sOcey6oUiOcbNJffhfBovlmNOgi7tTrkxWkqYTPm4G31JHb1XqIJmqQAoXZmEdd2Q5cO3sA07tWuN1PG5K5wPHDUruXDVvJqICn3+s8FmCkpIUwOevI5fFOW+YzgJL5iorOnipWeqRkKOXuKid/NnTZ+ShHK8x3ncPJ0Ylm54l+kn0XsJBn9T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1SBjLWV9QC8q5Tem+ej/1koyRxbjttfEedOCoR47nk=;
 b=l4M43LIE1F4y6L0f7ydjW057iSlWUZmDlOZbzGxS3iIqWYLc0L/MVZzyZOxrQ3pHf3NCbyyLYD+d4CqQoGiA+THTBlhES+a6Caub7fkFCAs3G/hTRb94nyennwsKRG3FVK7s/iNO8sW0awnOFmn/jXkD2949btySDVotJbHpJo4V4ukSjBrKAiTkCrLkSIin3L/2taZQbDqMdrXyzfmQ+XcNyQWlUPdr5MNMjtNm/rbswKxBBo14mHALrWqFK+POZCq09grlyk9xBnpVN2WYHaTDJS7eakVP02Ow4cK2pWpcUu7XWxY4TxRPaw7n45I4bq23pdPB6G2XaJMr3I9YDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1SBjLWV9QC8q5Tem+ej/1koyRxbjttfEedOCoR47nk=;
 b=LfGb/KcNSTqsWRTj0KzzDroAUiiamQczX0e1x25IB1LurPIRqYlj1y1Dk+j9QTJIgNwWN+zjASZ+LpBnseF9y8TcH87wybCvI5ZxLl18m4LGo8YUuFsh4gW6gRF2edAM3sY9ap2b+7kZXE0hSOOAoMonhuKUBUbXbwVOIFU2c3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 13:32:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 13:32:02 +0000
Message-ID: <190ec43d-bd44-42a4-a395-f278f97748fb@amd.com>
Date: Thu, 25 Apr 2024 09:31:58 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce/amd: Prep DFR handler before enabling
 banks
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-7-yazen.ghannam@amd.com>
 <20240424183429.GGZilQtVJtGhOPm1ES@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240424183429.GGZilQtVJtGhOPm1ES@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:408:f7::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b52cd6f-c54b-4519-429e-08dc652c1731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXpKSWZFam1LMXROU256UDFNcnhLL2lpcElHQ2lDcHdFSGdMaGNhbHJsU1Vu?=
 =?utf-8?B?cHd1aWYwbFF5MTYvWnE1emQxNVRkZTRFZEdobGYxWElpQUk3NURRZno1ZnZ5?=
 =?utf-8?B?cUoxZGwvZ0NxWVMyRlRmenphMVdod0Z6b1pVYko1VjBiNXJPVlJ2d3dlbklH?=
 =?utf-8?B?OGlQSzM5bmw3cEc3MTBaa3VDTGVSdzBQT2h1UTNPc0FGNlVwVUtwYlR4OTk2?=
 =?utf-8?B?K1VFRk95eG9FemlBYUNYaWk3N04vWHJRd0d6b21pbk9ZN3BreDQxUVJ3QWQr?=
 =?utf-8?B?bGxzdGtiTjFxbWltVWlBNEU4OVZZV29Zc2pYRXliMUo1eWkzOUpVa0crUjc0?=
 =?utf-8?B?T01uaS9tRlNlcCt2NVFLM2hEOGR0ZG9DTzhadkpoOTVIR2NwT1hnenBEc0hZ?=
 =?utf-8?B?YkpRNGNjQjBsQ2VHMXR0UitrNU9YS3BVc2lvRlA5MjJBVC9maTlCT0N0RmxM?=
 =?utf-8?B?Mkk3M0R1UjZDY08wd0dQTXZBVDBoRyszUk9Qd1pCZFZTNlpCajk4NzdkTXFG?=
 =?utf-8?B?MXJOcmV0MTVGT24rVHdGVWVud2ZWMXpnMlk2Z0xLTUJCeWtKM0dIQmxJWUsx?=
 =?utf-8?B?TDBDTUZKQUFQTnNtbFFOWTBBUnExeERqbkFDYVA2WTNRdTc1djlIREVzMDJv?=
 =?utf-8?B?UFltWld2Yy8wRXQ3d216cGhTOEVHcDEvYktRMm01cWtWQUpyeXBPZHViTUt2?=
 =?utf-8?B?cE11SkVaeWhnU1plYVVpSXlHR0F5T0J5ak9sdTFxSGhWcVlDMEhyQ25jVjla?=
 =?utf-8?B?WkR6cjNWNGRMM2gvd3hHb0ltUmIxUExhcEhRUHFLdVNLQitGZHZYbFp0TFQ5?=
 =?utf-8?B?Y09wUGxmOU5wdG5aQnZ5b25tVVdrSVp2cjEyN1FaMGl0Njh1VjBtS2htbEIv?=
 =?utf-8?B?aEpBcnE0OGU3bGpMNFo1ZXZibUlBcEI3K3FEb3d5Vmc0ampRWkZIZXVrSmhJ?=
 =?utf-8?B?R1FpNXBubTYrdm1mWE4zdkRFNkVmRHZpZ2tOVzJydTROdGsyTXM3RGRIZVVZ?=
 =?utf-8?B?NFg3K3BpUWgzYXYwbW03bGswVHZsZ2JhQzNOeUxZVWxlNnJGUENRTWE1OHRO?=
 =?utf-8?B?SGx0YWVFSE9iRWEzcklHdHdhbTQ1UTgzZ0tpeStMTVNxaWxySjNFSHVtaitv?=
 =?utf-8?B?ZktxQ0pNY2xWQWtHeE1TelFjMVZETWl2dGNkb2taa25PWU9IdURyV003R1lX?=
 =?utf-8?B?cStnSGNyNFdDSUw4Nk4velFsWXk4T1p2S2NrUW9LbTNMMzl4Sjd5dTlUcVRE?=
 =?utf-8?B?ZUtRYnhhRW9FUmlLd211cmNpM1dnbjAxa2Z2UVRTcTk2TjB3VU9hK0JxOVhR?=
 =?utf-8?B?dk9EdlFyR1ppZ2JuMUthdUlOcmxCU3hROWlBaGJ6VlVMTkJucytSM1lkcEN6?=
 =?utf-8?B?Y1ZheTZNSG0zSzFLWklsRU54WlZEa1NSYVlLc3R6SHEwY2VDcVdkaUVMaDRv?=
 =?utf-8?B?ZFBheGZrdTR1bEt1L3NqNk56OHdCOHJIck0zRFRZaFNrWXB4akRabVZzWWpX?=
 =?utf-8?B?b3JEK2k5d09FK0ZZMXo0aEpqQjBtcUNSM3FnWkdNZ05sR2IwQUpsMkdXMDh6?=
 =?utf-8?B?clRucS9XWlF2SUhFVHJkL282eGZ0cEpqUG9JTWxkMTdEKzQ5Q0ZGZmdxa3ZS?=
 =?utf-8?B?M1VSeEVVNG1MR2NmR2hhNENHSktrZUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2lkMG5SQnExeWZpVVVianVXQUtDM3p5dCs2OER0NkNLUy8rbkNHL0w3bDJM?=
 =?utf-8?B?aWNGM3hSUTNqZ3BsdTlsZGxSMTBlL3dsMzhzUEl1YmdabTFxY2F3SlQ4dnN6?=
 =?utf-8?B?Tzl0ejhDbUpEMExBVWl1bUd4b0VJUEs0RmdLK0llU21uVG9BU2pkQ2R3YURV?=
 =?utf-8?B?TEF1Q3FUalVzaHJna3F2N2dXQi9IallZWG56WElkTVRYRWFnK3FYUzFYdDdX?=
 =?utf-8?B?c0RuSGRVNkgzZEFmSjVYMXU1SEl0SjU0d2xSRFdwOTBPZStrd3J4N1gzNjIy?=
 =?utf-8?B?UU5wNUk2K0ZXeFcwNjFKSGxhMitiTFdCeUFQZzdxYnh1ZTh3VUx5UnM3MW54?=
 =?utf-8?B?a2RCL2M3dDRIb0NFKzViUkt6U2hwRHhKK01id1ZxcmUyK3EzWGFEbkVLUXh4?=
 =?utf-8?B?bEdJeUFpN1R4MUl2cE5QT24rSzhubWxpWHJZQ0Z4bGJlSzdYejA2SEphSU1a?=
 =?utf-8?B?NklVbVVsWmxicDFMNFlLNmFUSTJwR25aK240QVFNaTFKWGxyWm1zcUlNSFcz?=
 =?utf-8?B?TVJEVERvRkVNakpJNTFJVW9QTkYxbUVwQzBUN2N2OHovV21IMkhuSFA1NnJS?=
 =?utf-8?B?b1I0Q1RISW83VGo0NWxGMUpKVlhBMzRyblFNZlUrU280bVdZeDV4NEdheitz?=
 =?utf-8?B?VHkxZXhER28wT3dCSHdIb1BlTER2YzIzUWl4T2RyUkhwOEZEVlIrM3o2bHhD?=
 =?utf-8?B?YWZVdFVTUkcraGxodFVkLzV6VVhxdkFvY3B0VEMrejcxS3diRUNtOGFJZEFJ?=
 =?utf-8?B?cVpGdVRZMGZwN2hvc3RSVCtBbEdUN1BwUWtxdjFoTXFBOVUvbDJveXp4ZldD?=
 =?utf-8?B?UjVob2VBU1hWclJRZ29HbUNyeC9jc2pVSEdCekRWN3JSaldiN2hvRU4ycmho?=
 =?utf-8?B?VFM1TGNKTVZ3YUZNaWlocUhnNVQ0dEl4RDlaMTNCM1NoeGVCZ2VwR3B5d1JE?=
 =?utf-8?B?MDFyZS9VUFJjM1Frakd5ekJHOXA3ckVrTERmMEJrQTA4bldzQzdQY0RBbGxN?=
 =?utf-8?B?WXlWYWJCU1ZxcXVXZDM5RnJqVHhOZU9NRklXb3ZLZE4wRC9oM3QrYnoyNzJ3?=
 =?utf-8?B?djNHOTNVbTBoTXljRGVCa1BIc1JjazRKNEVWbm5qcmpCam5qLzBONTNwb05O?=
 =?utf-8?B?Q0JpWDdUaWROV2VueGdoZFVxa0xrUUhCbXVOcVJwRUJHM21uRHpLakVEZEsw?=
 =?utf-8?B?bEtyZkcwVWc5UEl2OEtSWS85cGs5YTdOTmF0alRNRHJTbEhldXpPT0o5SUVR?=
 =?utf-8?B?QUJ1QTBUeC96SUxtc2FKV1lSZGRMdFdyYUVmbWhwRCs2b0pqUnNJQjVFellI?=
 =?utf-8?B?RFgydDVTMERhMGZMV09zWDVRcHJGODJSL1R1L1Z0eGxvaU9qSUZoQ1h6QVEz?=
 =?utf-8?B?NjNTeEEzUW12REh4UlFyQUxIQWNlWFA3Nmp4b3dUTm1HRTk0Tzl0WlBhWmFU?=
 =?utf-8?B?UVNpM0lCaU5UNzdoQVJhenYwdFUwL2VtRkk2TXo4anVXRVFvUDVuWWFoTTBT?=
 =?utf-8?B?ZWw4eGtPSkFiblRybktGeFJIUVU5Nm5sRE9yY096Vm5obS82R1JMNVJvdExZ?=
 =?utf-8?B?Tlk1MFp1dGxlMnFqOVNJa1BrTVdCcEJodENyeWtvTjV4U1ViaWs3OXp3Sk4v?=
 =?utf-8?B?RCtNRDM1REVLUmptUlFzeEx5RHBza1M1MUJwZ3dBVlRXeERPNVVDc0JHQ3Mr?=
 =?utf-8?B?Y0REeS8xaTFvUm9tcnBNOWx2a0MrMkhITmJrcm9TUWhBS20zSEFFY05rRTg3?=
 =?utf-8?B?RGFFQmZQQmUzQkZ4cGE3ZlZmdHo3K3JHVnF0eHRnNUFzNVp0czd3L1pNZGsy?=
 =?utf-8?B?ZlFqWXcvYUNnMlRKNm1GRGp0Mkh4VUU0L3BRNzRsdXlNQmpaZmJnTmYwcG9G?=
 =?utf-8?B?R3BwcHF0UmlYZHpnSEUyS2JCZlVIZkZ6RlcxaGEzK3VKU1Iycy9ZY1dKSmNT?=
 =?utf-8?B?ZDl1RTc1QlNnOFFiSmI1K3JOT1RrRE9sWEpQRDRVczBUdkpuTDBpbkpGcjhR?=
 =?utf-8?B?NEE1bTBDMi9jcXZkZy96amRkOE1jS2VjU3ZnK3FRd1I2N0lJOFlKUWFQcjV2?=
 =?utf-8?B?R2pQVXZaUzYwbEsveXQzVmVjOGtrSkNqMmZ4T2VkbzY1My9LWE15QnNQTFFn?=
 =?utf-8?Q?AUPH81g1kKpxgBiDwfljnQXUA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b52cd6f-c54b-4519-429e-08dc652c1731
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:32:02.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAFDXVX9cb0MPESWHvOYo8GjlTFY3Pey8fMQYk//QZ5i9IN+Mb2sjabEdFYInJNHE+oGsHvCKkyHAPC0WDy0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012



On 4/24/2024 2:34 PM, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:49AM -0500, Yazen Ghannam wrote:
>> Scalable MCA systems use the per-bank MCA_CONFIG register to enable
>> deferred error interrupts. This is done as part of SMCA configuration.
>>
>> Currently, the deferred error interrupt handler is set up after SMCA
>> configuration.
>>
>> Move the deferred error interrupt handler set up before SMCA
>> configuration. This ensures the kernel is ready to receive the
>> interrupts before the hardware is configured to send them.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>
>> Notes:
>>     Link:
>>     https://lkml.kernel.org/r/20231118193248.1296798-11-yazen.ghannam@amd.com
>>     
>>     v1->v2:
>>     * No change.
>>
>>  arch/x86/kernel/cpu/mce/amd.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 3093fed06194..e8e78d91082b 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -589,6 +589,9 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
>>  	u32 low = 0, high = 0;
>>  	int def_offset = -1, def_new;
>>  
>> +	if (!mce_flags.succor)
> 
> Does succor imply smca?
> 
> Because you have now this order:
> 
> 	deferred_error_interrupt_enable(c);
> 
> 	...
> 
> 	configure_smca(bank);
> 
> and that one tests mce_flags.smca
> 
> Now, if succor didn't imply smca, we'll enable the DF irq handler for
> no good reason on (succor=true && smca=false) systems.
> 
> If the implication is given:
> 
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> 

They are independent features. SUCCOR is the feature that defines the deferred
error interrupt and data poisoning. This predates SMCA. SUCCOR was introduced
in the later Family 15h systems.

Thanks,
Yazen

