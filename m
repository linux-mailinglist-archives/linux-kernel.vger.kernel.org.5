Return-Path: <linux-kernel+bounces-155543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4D8AF3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452CF1C23497
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598213D503;
	Tue, 23 Apr 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TqrKX8QQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71613D290;
	Tue, 23 Apr 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889060; cv=fail; b=iRRGkJAv7dOugw8aVk8STUptimjE2mbl5zQtD7yZJ7EcGtIt9E/l8xb4QBNSlq9cTlAWJkaoy8OO7yTN3a+jB9RuZk9Qij8t94CXwU6BWzGwXXWnFwopNhlAs/c/nlgq1XnIWM7X/Ve0+32tAaBlV5AHEOjS2zDECC+xTPvNCmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889060; c=relaxed/simple;
	bh=I/FOwX6dKpVNKn3u2d2Mklu7yX4go8pinuQr7TtWA/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CDmiejsiBkc6eu2A4wSX+ltD03hfzX8oyjHmaMJY4fGuK8it4b0F6qUQvo/X97PAghwk1cUlQzO7CUGuUeHrS79mDvXDKsNckfhpewb/5gQ22AmoU0QfkX7wHT0oOOtERU+4v+h0b/8GBLS46tJ9hMPa8fbvkP0LlcFSldmyUzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TqrKX8QQ; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkaskKtSm4lZ8adHIJJtBj3MC9BDBziOEkNIDCGjFYR8wJDbqn2LVq+BvP80SjHAz/oTUk7Znv8XEdi+5BC0K5JMhFp+OZH6LMoHrHyptL9YONvyEif4HzNtRd/ER+8Lu8TE/RYP8b9DeB+GOw8NHgIeR595zrk1OrKsUG1yR9Y5E1mR7zU5OJw/lRusgTWzWmvZH+qMXhrXODK9OQY7QAFeZhrom7fEW6Yn6GpC9MrlQi1wfqQWqXCQ2yy4d38+YAnWy0oAVkLfbodDRejkJzLheozUIU2Cqa8iIk88g7jEwGfLZl1iv0W92SO3/V79uGS0qqr7AX80lu0+wtfGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/YurePsyOYGyzHogGe9ZeBzMpuCoQ+Pn8MLDO9NPTY=;
 b=Ckkgyw4nrrt93Vue4acWQqPvumDziy14PNKHQ37+bzA9zCd0aMenj+ZcopMD9Xa6k8H21dX9ddKHJ6+uhzyghQNzp/GMCo+RQZeI2KzzTp8x2I9SecUGZgkSLIZ4WptpLSrFBpGLGGLvFK82VNMmwyFFB5kDo5REw4++AFXh3/U+XM7j7UE9WHc2gObgTg4AkPcrSzTFdoyVfmlln5d38AEKOHPVH0i3UvGR2x1jQ9dx5cn0CKnYNza/v6YBwGcLneNqZi87ZR1+IHL3+LWNOjb9XKppze9d/jnAr1+tKZiKARIiW2FqYCC3y58YlcLnX4y2QbPb9qDaQOUofkPI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/YurePsyOYGyzHogGe9ZeBzMpuCoQ+Pn8MLDO9NPTY=;
 b=TqrKX8QQDiMxeuskkMfAbB8pdLEZnHa25tnInDrHA5OlKcolBK1KhSAoocYAShvZ0MWpnboRNGeRKF/HgLxV/dNR/PQzQV3Pg5Z4O56ujDWW7ZQbzG+/BkutdCpNMLhZyKjQ/hQwF5zJJXKfpuoxpdH/LdeCRlDpYUqFRhNVZ0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:17:35 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:17:35 +0000
Message-ID: <06c3431f-badf-4e50-8e8f-90363c598b38@amd.com>
Date: Tue, 23 Apr 2024 11:17:33 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] drivers: remoteproc: xlnx: Add Versal and Versal-NET
 support
To: Nathan Chancellor <nathan@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240418220125.744322-1-tanmay.shah@amd.com>
 <20240423160644.GA554932@dev-arch.thelio-3990X>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240423160644.GA554932@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::19) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 63414fed-1f62-4f05-9b92-08dc63b0e31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXVpV0VYZG1GQzQvTU1jQmloRmlBZG5KUE14d3RwcTMxMExwSGllSGNIb1Fx?=
 =?utf-8?B?ZmY4Tm5qRStPMW5xZTlmNkpwZ0hERWVzOGN0c3BTUjA5WDd0aDI1ejk2QWtx?=
 =?utf-8?B?a3JOMWsrc0tLUnF5cjZXbEZ6cWk3RmNRTThXQ01yZVA4RDNBSEk3bUZaYWZI?=
 =?utf-8?B?MEdJbHFUeDRLRW9XbHA0eW1YR3g5aXFQbG1YSUFjYnQzb29WTmZyYldhbGRz?=
 =?utf-8?B?alk2eis1Q29sbzI4ZGZEc3VWdld2NjRxcTF5bklpdy92Vng3SVVhS2grQSt5?=
 =?utf-8?B?THU3TXlwMkMrTUNubVhka1dtK1dRdllHN0xwZktkbjUwd21IK1cxYlpNNXBp?=
 =?utf-8?B?TDJBY1NtcEwvOUtqOURPVGNEMjZKcExiYWtjQlRrbUxneDFGZlUwVjc4TW13?=
 =?utf-8?B?K0FVcjRXdUxZS1JoRWNRTmVic1Vyc0JBQ0pRdmhiRWJNQm9oWjFocWhham04?=
 =?utf-8?B?VGltZDdCRXVjMTg0Rk91QlVVS29rdWFnNzA1WE5XR2dnYmFkWlhqWTd3N2pB?=
 =?utf-8?B?ZmFhUUtCR3pvU3ZjNGxJUTZlMitZVEJWWmhRdjJsNy9jS0E3MEx3QURjczg2?=
 =?utf-8?B?aElWdHowZmZ2Wjh3b2tGQlJGS3UrcXNrMUxacW8vTTRQOUJSMmxWeXhWbHZn?=
 =?utf-8?B?MjZSenh2bUtkMldtclJTWFRiTGswNm8xSlRWYmhjWEtWYVpoSEJJOG82VERr?=
 =?utf-8?B?SUErbnNCUmNwVHlGaTRkNjI4YmJPampWRlk5YjZsUTRDamQ5NVhDV3VySHJG?=
 =?utf-8?B?V3VwbCszMkxlK3VyWFNCUXhzeHRpQi9INkJJSktxVnRjRzFTQTk4OGJPOEJ2?=
 =?utf-8?B?RHBNNEVhcFJmR0ZSVEs1bHBYTXN6YXR0VHV6SzhiQVVaNElqVGFXbnZ5WkpD?=
 =?utf-8?B?UTJ2RG5FZkM1RFZ3eXRFWDFuWGc1a0hOT254RnZKWnJ5cUNMUlFDVzBTdnpB?=
 =?utf-8?B?b2NjY3lwRGxaWHpUWllVT3ZpV3NhWENWWXk3UklwQTgwcjZMY3JrZXQrU1RB?=
 =?utf-8?B?My9ZVlZ1UGZVeGNtZE9QdWhuRXI2Wk9vRHU5dldwdDBZbTBpckhyNGV0QkZ3?=
 =?utf-8?B?Ujc3K1FnS2tJSlVQdSs3OTMzREZkUlRFenZaTjVjc1dzUmRsaElaQXBwOEE2?=
 =?utf-8?B?MVdONXN5QVhnUU9qc0duNEF0WUt6UXJXSTRLK2xVNHdTWlI0bFRWbmN2aU1Y?=
 =?utf-8?B?Q2pZQ2x3b2Rqc1ZyRFhtZkJoUnVFTWlGMnR2SzVEd01MWkhMS0RIUW9UMVlk?=
 =?utf-8?B?K3loV3pKeTF4anFNTGV2RHIxZTF3SmFTRVQrcGNsSUYyTk03aDdIaGhNczFu?=
 =?utf-8?B?WFhaZkNRekROVWQyc2dZcGlCZzFhblRZa1M2N0ZCSGM3V3ZQTVlDNG5zaTZJ?=
 =?utf-8?B?ZWNSdkg1bWNjeSt6MTAzSy9VWXdOb1ByZjZpREg2K0IvWmNJK2JKNjlaM3g3?=
 =?utf-8?B?UmxSVnh2S0hRa0pwMTYxUWtrTmNtQUpIamNWVGlQRHo0UXpseHF4eGNqSWtn?=
 =?utf-8?B?SnFLR3pvcGc5K1ZvdHRrV09taEhPRWZ4Y1ZkMnhRTWhZT0tXeGwyZmt4OU5N?=
 =?utf-8?B?cXQvNUM3b3ZvcnN3WmtkTjNGWlpTU3gvVk1kWkgraHMxVDJoQWRxTTljVytQ?=
 =?utf-8?B?cjZKamtiNzIyN083Mnkrb3FqaEtyTXhSK1JLbjNzZVhvVWt6TUlNZTk0QmVP?=
 =?utf-8?B?THBmQ1BxOFNFelh0R2lGRWtDcVBHY0I2NEJjd2NkaVBIQWNuUm1HWWxBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUlKcnBuQlVyR1AwVXBxc2YwUDRYcE1Ncld2akdRZWMwTVE0dTlSamRFUDhD?=
 =?utf-8?B?dGpmRE4ycnJ4c3Mxdjdxa3pRanQ1R1YvYzk4Skd1dFlZWldzeUc3ZnBnclFZ?=
 =?utf-8?B?aWgwZmNlTjJ2cGFUMDkrQkxKZUo4aXIwYnlkK2FzQURNUFBCWFFiS0NraTZz?=
 =?utf-8?B?aWNsQVVGdldjSmtabGpzcWVScTMyOXZWK3pnVEJaTjNZclZpYjg4M09uWU1W?=
 =?utf-8?B?azRTdEdEV1pTRXJsbjhMbmNTL2lGbG5FdDRHV25MVnhZWG1ESjRBazBuUXlu?=
 =?utf-8?B?VGI3K2VQVWN4czZWRFhUdXN2MGpGdVhuYmo3TmpFelpQcFdHdktPcDFLTGQy?=
 =?utf-8?B?RktmL3ZyZzJwK0kwK0JxeDVTSFIzOE1Tdmo4aHo3VUl6REUrMk5ZRnIwSmZY?=
 =?utf-8?B?RVpPeTVtNmtYa2h5amtGZGNZT0tFZjhTSW4yUnA0Zk1PTVNoa2xLc1BJSURX?=
 =?utf-8?B?QWk2VFA3aVhkWmZLZzc3cnhMd210ck95NEtGcmhDWlF1UW4wWkpvTTFuZEwx?=
 =?utf-8?B?OXJVODNuZjJHQW8vdTVKYUs5SzdMb2dFL0Z2Y1NrTXBNTVVWY3pHdnVTSGpZ?=
 =?utf-8?B?bU44UUN4WnNnZEprYm5wUUxWWDRSazNDS0hqMTdSZjhGTWxnQWtGdlpjcktS?=
 =?utf-8?B?SVNHMVdObGFRQlVlbVBSbk1mMzRVYktnZWZROHhRRC9WeEhNY29mcjZpLzFu?=
 =?utf-8?B?RDhSc1hCZjBnSWlTb2sxQ0NGcW9xKzdYd0NXSmpLMm1nQXQvMlhVbStYck9N?=
 =?utf-8?B?dEFiWEhmUWJxMy8xcEhtSDRBTENlYno2MHZ5MmdnMUxxMnBWbFNaMGpTOGg1?=
 =?utf-8?B?VDJQMW9SMmMwVDFhdVFQdmc3SWUzRk5jVzNDQWx4bTF3eU13czRwKzZ3Yy9E?=
 =?utf-8?B?b3FGMGNzdGxHaVcwQ2h2eWprTS83czF5ZVpVME85dU5OM081RjVnYXUvdHF4?=
 =?utf-8?B?TG85TUg3SXdiN2w0Q2dBbkc4L3AzT3lpM0QwMnF3SVBFNHRRQnNJaThvK1hk?=
 =?utf-8?B?RUwwMWhYZ3Z1WW5DQlRidEplQ1RneW40T2pkTnVaeFFRTVcvemxYbkVRbUll?=
 =?utf-8?B?YlQ3Q2dyVHJ2clFiSm5nRjlFNkRkNENLcmpnSUkwelpmdXV0ZmFKWU1xU0JT?=
 =?utf-8?B?UXc4OTR2RDRNYkxFeTF1MkV4dmx1TGYzZ2NOejkvM2g4Q3dIQmYvaUsyODRR?=
 =?utf-8?B?RlVDMWdpVzdld3BMejBwbmF5R2tleHNiTWV3ejFuNGVoUG9nbW1ReHAyNGJs?=
 =?utf-8?B?Y1NQWHF3aDRDKzh4bE9KSU9PT2VIY0Iya04rQmNFeWFEWVA0V3RHdDAzWFhR?=
 =?utf-8?B?M1pxMThGNk16blNobXdJdFI0QW8vZVhxRTYxVXFzRGE5aktxdkZhYWdXT2dm?=
 =?utf-8?B?UHJwRlRCTEZOS3hEdFVyUVA2UHlVZjBRb0N0dEFYVHo0YXFLOXA1QWpuV1d6?=
 =?utf-8?B?WG8zeEI2VmEwUnVWS1NNcjVlRTlnUE9vOXhqelR2N2g2MGo5elpJazhWbUhV?=
 =?utf-8?B?YjFHUThwUnI3aDJaVWVlSXpzSnFhMXNkcXdjLzE2TnNLUjc5d285ZDAvVmlE?=
 =?utf-8?B?ZFkrbkpwZmw5N1FsLzZVYy9YTnRwalloU0ZTTi9jTWozRlhnSG1iK3ZtVDhV?=
 =?utf-8?B?RlFFMHRyTWVzNlFzZ3N2bkNyaTdqTnNDOGtRbTVTZ1VCU0ZpQVFSQUQxNUhJ?=
 =?utf-8?B?aUlDeHU3QlNIVzhlVWt4U2NWRzFDKzZhMXF1VkxZaHE4MjFMZDFxN0psbng3?=
 =?utf-8?B?dmoxQ0FMaFVZZVNFamFUeTNXNE5ZSy8zNGtDT2NCZmJFWXp0Z2Z0L2I1MEIx?=
 =?utf-8?B?YUEzV3VzQUNyUWgvNGdLOGlKRkYvZnhDQjlpd0hxSisvTGx5d2llZzI0Ykdz?=
 =?utf-8?B?dWxGZ3R0dHFycVNRYnl0UTk5NjBteEdHeFoyMUVldWNtTElEamR1eHB0emZH?=
 =?utf-8?B?aGNqYW1HVGN4VW5BZXFCV2V1V25OQm5mNGNIaWhtUWxJMWFuWWpiMEpLeWNP?=
 =?utf-8?B?RzM5V3FNdS9BWEkvcVVyMUx6UWdKZUt2a21uOGlpTDQwVXJvSXI3VXZwc2Iz?=
 =?utf-8?B?VDA5a2tNVjJpV0xOTVNORXN4Z2FzN1I2V0grc1hWdTdwaEY0RU8zYzlzeVJz?=
 =?utf-8?Q?RL0jbk5YafR5IAjgERJhJ40xn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63414fed-1f62-4f05-9b92-08dc63b0e31e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:17:35.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qMygwWxiWyXcv/M64GduHDCKLKU/o9vIM4fKKzZhNGrU60HNcmGhRoEQMoRroac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472



On 4/23/24 11:06 AM, Nathan Chancellor wrote:
> Hi Tanmay,
> 
> On Thu, Apr 18, 2024 at 03:01:25PM -0700, Tanmay Shah wrote:
>> AMD-Xilinx Versal platform is successor of ZynqMP platform.
>> Real-time Processing Unit R5 cluster IP on Versal is same as
>> of ZynqMP Platform. Power-domains ids for Versal platform is
>> different than ZynqMP.
>> 
>> AMD-Xilinx Versal-NET platform is successor of Versal platform.
>> Versal-NET Real-Time Processing Unit has two clusters and each
>> cluster contains dual core ARM Cortex-R52 processors. Each R52
>> core is assigned 128KB of TCM memory.
>> 
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>  drivers/remoteproc/xlnx_r5_remoteproc.c | 53 ++++++++-----------------
>>  1 file changed, 17 insertions(+), 36 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> index 7b1c12108bff..a6d8ac7394e7 100644
>> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>>  		dev_warn(dev, "failed to send message\n");
>>  }
>>  
>> -/*
>> - * zynqmp_r5_set_mode()
>> - *
>> - * set RPU cluster and TCM operation mode
>> - *
>> - * @r5_core: pointer to zynqmp_r5_core type object
>> - * @fw_reg_val: value expected by firmware to configure RPU cluster mode
>> - * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
>> - *
>> - * Return: 0 for success and < 0 for failure
>> - */
>> -static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>> -			      enum rpu_oper_mode fw_reg_val,
>> -			      enum rpu_tcm_comb tcm_mode)
>> -{
>> -	int ret;
>> -
>> -	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> -	if (ret < 0) {
>> -		dev_err(r5_core->dev, "failed to set RPU mode\n");
>> -		return ret;
>> -	}
>> -
>> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> -	if (ret < 0)
>> -		dev_err(r5_core->dev, "failed to configure TCM\n");
>> -
>> -	return ret;
>> -}
>> -
>>  /*
>>   * zynqmp_r5_rproc_start()
>>   * @rproc: single R5 core's corresponding rproc instance
>> @@ -941,7 +911,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>  	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
>>  	if (of_find_property(r5_core->np, "reg", NULL))
>>  		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
>> -	else
>> +	else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
>>  		ret = zynqmp_r5_get_tcm_node(cluster);
> 
> This change breaks the build with clang:
> 
>   drivers/remoteproc/xlnx_r5_remoteproc.c:914:11: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>     914 |         else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
>         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/remoteproc/xlnx_r5_remoteproc.c:917:6: note: uninitialized use occurs here
>     917 |         if (ret) {
>         |             ^~~
>   drivers/remoteproc/xlnx_r5_remoteproc.c:914:7: note: remove the 'if' if its condition is always true
>     914 |         else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
>         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     915 |                 ret = zynqmp_r5_get_tcm_node(cluster);
>   drivers/remoteproc/xlnx_r5_remoteproc.c:907:9: note: initialize the variable 'ret' to silence this warning
>     907 |         int ret, i;
>         |                ^
>         |                 = 0
>   1 error generated.
> 
> Should ret be initialized to zero or should there be an else statement?

Hello,

Thanks for analysis. ret should be initialized with -EINVAL, so else can be avoided.
I will send patch by EOD.

Thanks,
Tanmay

> 
> Cheers,
> Nathan
> 
>>  
>>  	if (ret) {
>> @@ -960,12 +930,21 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>  			return ret;
>>  		}
>>  
>> -		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
>> -		if (ret) {
>> -			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
>> -				cluster->mode, ret);
>> +		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> +		if (ret < 0) {
>> +			dev_err(r5_core->dev, "failed to set RPU mode\n");
>>  			return ret;
>>  		}
>> +
>> +		if (of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL) ||
>> +		    device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
>> +			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id,
>> +						       tcm_mode);
>> +			if (ret < 0) {
>> +				dev_err(r5_core->dev, "failed to configure TCM\n");
>> +				return ret;
>> +			}
>> +		}
>>  	}
>>  
>>  	return 0;
>> @@ -1022,7 +1001,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>  		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
>>  		if (ret)
>>  			return ret;
>> -	} else {
>> +	} else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
>>  		if (cluster_mode == LOCKSTEP_MODE)
>>  			tcm_mode = PM_RPU_TCM_COMB;
>>  		else
>> @@ -1212,6 +1191,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>>  
>>  /* Match table for OF platform binding */
>>  static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>> +	{ .compatible = "xlnx,versal-net-r52fss", },
>> +	{ .compatible = "xlnx,versal-r5fss", },
>>  	{ .compatible = "xlnx,zynqmp-r5fss", },
>>  	{ /* end of list */ },
>>  };
>> 
>> base-commit: 912ebe48bec5927e2049e91b0e8a9cc682a709d2
>> -- 
>> 2.25.1
>> 


