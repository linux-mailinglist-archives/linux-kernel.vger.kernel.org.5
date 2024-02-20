Return-Path: <linux-kernel+bounces-72404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57085B2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67751F2150D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB5B58229;
	Tue, 20 Feb 2024 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yl3lZKqv"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8E5789A;
	Tue, 20 Feb 2024 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410238; cv=fail; b=VisNzZGbglBQpgjF5Gmc1hBUGHmxKqkevjsI+FU8dKYRIKZeeTC4pEu+bsvXd/TQyEMkStkOTTPApQHBCiu2GFkNj2egfaR4ZEM8ITOLvnZLlm3j+DtXmvQ8SYRuhQfRMBSuZN2p8oK1rCUXDYpf0feR4NOz18k+m04yaJtsWw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410238; c=relaxed/simple;
	bh=kJFWaAIkA45gykpJ6cvQjA75DeNBMj92kjXd+ByqJuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yb2rT6G7BH+KLuu2/YbrGqNcUD2fhDM0Ra7T+yOdufRHUeWhY6vgAw86hpY+bqK0i3PlgSF1n91tlFzVi1MVXhcRJg6+jz/Syw0iP70Z3Ke8YTcIQeBocgIokMyHgIWrGdVdPvZoE+VyrkTQPTX8eTkzxtqS+q1nwpDHZarmjWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yl3lZKqv; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhThie3KAaV26VCcbzXIQ5DNyPlU6jlmbZzryYwrblxnVzO7TekX1HjnL8Z1i77XBL4ZxRYXFnj0D6LUL1IU+TLZJbe2jvmvEA/kZ2Lz0QYSmRqQVr26Pos7BZv5DRI2gKeqFf9oDfWd5t5e0Y0oTYmuIP2qRHzHCGKzKLjjVafoAcSGcUOVrcNJtRu3m4H23u15NEy9TwR9fFjfBJHDxIdSA8WUvnoUBF8tEWlXieeVVhH6e2ISxjZikY6b1CGP7lLZRVqRNNgwGlUOTNtu6RP0GZHb2Taw+TzUGdEPjoymGvMbZMukWekNoWUbcM6CeXbVJ9R7lP6GIe0w2qar5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6wW+u+fDBT9rUtRjzwtIda0extdwiDymI+ea6dRGy8=;
 b=As00K1h2bXjm6iW6pkf4ZtGJ4zK5OlBCFEXE2HotmEP2+r3XiL5aAUA4/luFR8CUGM+5B7q1BgLcudgIxUe4BafUZLR547zgWfIumt7IEPtfzSjDAziJmRbQEq8oBkiBORIxuiMn7DqdNzVHsIYEcJvhHu6bKlBpF9C1pgqH03PQw7ccYKINwlWpE6Av1/ZxcuoiXLGI3W8JjEPPTytOdp61T/VaBRg80TksTNzo7fOQLMA2/D7LYOAJHbQ5tNylywIE51cad27rAKzr72sJtQ+zbgMTxOyze+4dFPUOX/PR3FKT+ryzir8lc9N0bOZvhvkwuIm7frUzbHGNIA5+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6wW+u+fDBT9rUtRjzwtIda0extdwiDymI+ea6dRGy8=;
 b=Yl3lZKqvHJhCpgn2CS6DfU0mAcFZ3yGzakq8ugijuy+CGpfMlt+lmn+uIm3WXbwXDg7APXlYB1N/vLluQafCBoBqYs8oFuFAOT+fQ7SQcsiSbpbbKE2WfMKD13/kQWtramQu7PsgCGdzGSW8mBAZKs7xM+veNpVk5SehKHqKUvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 06:23:55 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 06:23:55 +0000
Message-ID: <343f7b1d-1b4e-402e-bd54-4473b91b6f79@amd.com>
Date: Tue, 20 Feb 2024 11:53:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240219093900.644574-1-arnd@kernel.org>
 <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
 <412c0a42-4c19-48dd-aa4e-de39b6ec3099@app.fastmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <412c0a42-4c19-48dd-aa4e-de39b6ec3099@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d1b5a5-a446-4501-3ea1-08dc31dc8383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bPu2Z6w95T9VkTnL0EYVXqtooWChEB84ADbAHqvEjplazaM+WjnXyneWEnyA4672xVBq8Vui2HB7JDLF/u7WUZxfpk4ci+Ycp3SbkLFk+UGIAidVWIrPBT+Rzg5CgbQpXIjT6QdTXsNaD3PTcTwcFFaC9WifEvCANbnPga35InebSaDeUwAWi9BUnKjLSa1iSVbl3hx+YS/sGKILCMt+w9OG4ZebbFo4Im4G0fhj6yEMkb3FAq3eApbviRrFh6Y6et0lMP+rm2GMcvbFxsd2Y6Eiq2cwYRM3aQP0B11s6jnNY0h9R+atvNZ7Ws+28bMws/e4fPLaM7u+MNXIYm+WQjCSKBl1sFt71UX1sHNeUQPtBShGRdeU/Ra0x1sawzQ9jpgeRIuO683p5CLZv1HZ4GxNvKumH7hRh3xSiqZc6tKYNb+HKbsp2FoTR1MZyorJWPZY863sgsA66eGxwf8juDuCMMLtiNNi1iQ4DxNTu85azmuSGyzieX7Dd+nZQzOm5eMbDNpMGzqi5rx8nHlUlGlGe6Q/261lCTbbhqu6HRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEdzaXRwMmNuRzJVd0ZTRkZCUWl6N1pQV1ZZcE5PUzcwWExyS2JSMnBPOGdl?=
 =?utf-8?B?RUNrcmJtZGIyWXRhcVdTZVh6c0dKY043SUY4TjEyVnJ0eTJWWFR2N0N3bjNz?=
 =?utf-8?B?SUM0b0NVSSs4T0NzVm5qSUpEYUZOU1pUZVU2NnJIQU1Mb1E2RGVmUzJrcWpT?=
 =?utf-8?B?L3VKcXZhRTRtd3FidTQ4ZnV5dXorMU9zV1BKR2NFQ2lEU0ludjZuV3IrRUhh?=
 =?utf-8?B?WWhTRkxXNnJJcnZYY1pZbm5zc3Q5VjNsZWNNWEd4c2FURm5KZVRsNmViZzVG?=
 =?utf-8?B?Tlg2Mk1FY3JndHJINW1xNm5kSk5oeWV5KzVmSnUzOXlFOTcvVlZWTjd5OW5r?=
 =?utf-8?B?V1hVcFAzYmNuZW9EcDJnWGk4TEVIY0RYYVpCTWptWG9DZ3gvbHROL0ZOc0Ir?=
 =?utf-8?B?cFBtSVNXdDd3WW13ajdsYi9zRUFUSUhBOTlIdUZla0hGZ1FubllUeVM1VU5U?=
 =?utf-8?B?Vko1azZ3ZU5od1N2T1IxT21hK0hQc2VpNmVFYXlCeWZ4TEkvR0l5SE9XZEFY?=
 =?utf-8?B?ZVBBeFk5eWhoamo4cUMvZndaQTZiL0RJTHIrUGtUUWk4ckZ5OTUwYTF1cElG?=
 =?utf-8?B?RDRVN3cvTlhCY2Q0MXNsVzRUSDQrZWZiTVp5YTAxWVp5b08wMkRHVksxdnYw?=
 =?utf-8?B?Nytla0Izc0lWRlRoK2NUWGZPOHBJMDhJbHNqYlVZTDJZMU9xWk1WZkJZcTNN?=
 =?utf-8?B?WXZFTHNJdTNDdjE0L0FHT1M1cHJDRGRYVU00VFRxaHlnSmhpQXRySEQ5bW1y?=
 =?utf-8?B?WTVLVXc5Y0RwN1BMUVJHa3JQK1Y4WEpHUE5uS1NoN1pNRkxRNlZQQ3hvbGpT?=
 =?utf-8?B?c1dmdHBnQ3ZoYXpqVXVHVjBLNGhpbG9xRU80ODl2bHYzVnl0eEJJQUkxOUY3?=
 =?utf-8?B?UFRvS2FCakNoQ01hSG1MUmJ3Z0F1bDMrV1hhOVprd1FOTHlCUmdaNlZraWNS?=
 =?utf-8?B?cUl4RTNpNXdKZGVDK1p0eFdjMjM0OWFySmlWSVFqRnZqYUhydFhDekJXOGFU?=
 =?utf-8?B?TDZIOUN0S09FZkxzcDFtdnFlR2QxZ2FnNjBqTHFMY21XLzJodUZVUEpPWHlT?=
 =?utf-8?B?OHY1T2xoeUlEa0REbldzSnJGblBWQjVMVUZQVkhTZE1STlVCUmZ6VTg1NC9C?=
 =?utf-8?B?UmxCQTlhQy8vNWwzc0RXck1qTmwvWFprdnJmci9iMnNxc2FCQ2NITmdNOVRt?=
 =?utf-8?B?d0hnampZcHNTVkZhSDJWL0lJSy8wVmRNQVo2NDVrS3JMTUNNVXl6MmFBVWl6?=
 =?utf-8?B?cW5Ed0Z3MEk2UWtmUGJOK055bE1aQzFON0NUdldGYThCbDVjYndhT2tsUXh3?=
 =?utf-8?B?N3NmWlNTT2ZuREFYcXZXLzE5NlBZTGxsdE1yNTlya2VqSnIwT2Z2T3Qrc2ZE?=
 =?utf-8?B?TFRqYUJLVFhDTWpaLzdPbzl5Q2pVcUtOWHBEL1lUNVFDeFlwdFFPTWtrZEF6?=
 =?utf-8?B?MHR2a3RHT1RSQmo2ZndtTEptTGhmZ3JEN1VJVnFKVVNUMnk3Z1lCQjl5MWc2?=
 =?utf-8?B?OWo5MDBEbXhtTThBdDcvOU9rTzgrU0xIVlpzVGdna2NUZ1MwalJBN29vY1ZT?=
 =?utf-8?B?WDc2V24vME93NFRyT2l4QXplbDEwVlYyUks1eCtxRTdlVVF4eHhScURwYkpo?=
 =?utf-8?B?OU9OTlZGYXcvMFg3NG9Ha09Xcyt4YzdCUmQzbjZrbHlQKzNSZzU0Y2pPa2pt?=
 =?utf-8?B?ZnA4K2w2WkJFMkNVZjNMVlE1aFVhVzYvekZJbWswQytVQVMza0hYeGlpTE5p?=
 =?utf-8?B?MUJBWjdRMmxVbmZaTDlWWU5sTnN2QmowYWFwRlVJaGo2L3g3b2tIckUyNzJE?=
 =?utf-8?B?blJmdVV2cFdCdnFTRi9jQ2FZU0Q4Z3hiZlp2UFNDblpsbk5wNVdwN1E0TE93?=
 =?utf-8?B?Q1pGaU54em81TngrWmlnQlcyL2pEei9iVU9meG94ajA1RE9HekJFb1dqZW5K?=
 =?utf-8?B?ekhwMGxaZFJaQnVIUWhXRHZiQzFLZkxDaXByL1UxN1FNREFNYnNwOU9TRUFQ?=
 =?utf-8?B?Q2tJNEtsaHF2TVI2VzFXekFoNWxMNnJxWWVHOG13RWxlWm15bFp5VWI0L0Jw?=
 =?utf-8?B?REtyQUlaWkE1REFpa1FJWE5DNEJSWjkvbkJVRnA5cytJMVM0dFp6UXFNTldK?=
 =?utf-8?Q?ma6KebkPKZg2BJ8YU0XejYrTy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d1b5a5-a446-4501-3ea1-08dc31dc8383
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:23:55.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9K4QX1T1lmFiD808zY/ky6BpI4izcXT3IkjL9MLXC47uXsR7hIbII5IdC6Ewgxsdr2T18GtuDnXLwjlYU3Z8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093

On 20/02/24 11:43, Arnd Bergmann wrote:
> On Tue, Feb 20, 2024, at 06:57, Mukunda,Vijendar wrote:
>> On 19/02/24 15:08, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> In normal configs, they should all either be built-in or all loadable
>>> modules anyway, so this simplification does not limit any real usecases.
>> Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
>> AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.
> Yes, that is what I described. But as SOUNWIRE_AMD is a user visible
> symbol, there is no problem in expecting users to enable it when they
> have this hardware, and distros just enable all the drivers anyway.

Want to set SOUNDWIRE_AMD flag by default, similar to Intel & Qcom
platforms instead of explicitly enabling the Kconfig option.
>
>     Arnd


