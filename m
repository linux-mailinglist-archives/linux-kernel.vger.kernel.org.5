Return-Path: <linux-kernel+bounces-103643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D730287C260
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCE8B2111D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5574C01;
	Thu, 14 Mar 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="cdkrXKI4"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6D70CCB;
	Thu, 14 Mar 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439464; cv=fail; b=uqxeB+gIZMTfVuv4I6KVgHGcM6UzVgg7dLJ5nJluACO/oKh/VbnWIr2keq+9NRRF6QGphj0lvmHPtENOvrgf3V7yke8n5awdexTMhAiAlx2MW9RGmX6bYNEntpVdPEiuBRPL2541MhYpYJ5ubVP3uLsnoqKgykWhfI/+QzpggUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439464; c=relaxed/simple;
	bh=cY8x8UZGGxyMv0eWdPqgBld1DXamn+D5HQIQsguGR0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=enHY2Do+jCngdS8WUb1+SowFe5NU6KMTb6IE3lEHJXXNMbZH+aODDXl8fA+Sq5e75pKAbqZVeLTjkZD3hoXUoFjHBJYDHw0JUUFDgJBi9kGMWiyqOx46gabR7zhSy/SAIXDw7FIQ8RqJvOx/moxaHy/I2NLZ9dRV9QVQdLfj3u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=cdkrXKI4; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF8z94l7aHGERMs9O/H9VL+9uyQNnLmSN1OBtXFpLMkaB56he8gTQ9o/0PimoG4JFHGwhihsIzXMr8lBj+gfyNC9Af6Jxck7llNw2mB/7lAES/bEpqe4Y4uKQL0DjFItJ98jPIGBMvTq4/N0Wbttyt+50lSuUtqG06ckZhRQ0qy0ac+NhMi+SV5LyMa1VRPf+BFZNWVimV+E3XNx3ahgLHoJuaVu0R6Och+Gfg0XbVNt+m278ykJzDHV23vAmzddHiVYlQdUe5Wy4AX+Q+ZglJsDPPiJM3+aewZMz4cWR9QyvOOwu36pl12bxtcmhfJiNeI+ZDjWRqRCw/2JrMtg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spRLlQgRVyV2BMsAxSfRIspEWUQSNw6hmzfnSDAnKRU=;
 b=myFy/tJFU8QL0/3PaKo2+r602roL4oOGgxIiaA/oM61W046jjEJ+kfBJSFEb7XrFUfex6hNTg4rVZgbwJluKrTsCJiCJZBsUsZm/qsNOLBr2jrES6Lm+cXjR+aWxk/DQHTn1mYfE0szql4QoKjlqRfuFOAGjXSLnk8dIpnh1eVwgInUilZTgPEJASKN5fqEZFTC5zkXXtWLfoEKIoUTc810CEr04WDXNbYBaiDdTEySevPdscSkPxUuCXHFKs3HC6Bfe2dY3dp46J3rK6K7xlvwf9rR7TtrPlAfa71wu3ZKh/Z/fCW6OJzLEHyBbk2iSh0hw6mCJpId/tn5XJnuNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spRLlQgRVyV2BMsAxSfRIspEWUQSNw6hmzfnSDAnKRU=;
 b=cdkrXKI4OVlhOepE8/SenYHLFCNe1rx0Rkz9Mqjay10lpZKV1S0eqa6xiAoHbLuLdhu5zg7e4Hvp1BiU0e8dS8YwzSbJCdGdbwLWpLJfyMopRzt9Q96vK6Yi8hOZaLfpwHjyvHMLC6A/vT1S5HMuJpjfSERZLpBCO/t3MIroqgdoGjKcjH8oBfexlG4SpHIbcDwDLRS0YKuRQiS3fZoJUMCVIT9lFQReHVqt1NyBEPAnvu1BbGVOjK5LWRTlmMwDa1b6p/SuehzeP5HYURBNVWjMj30AqP53nP0FfPdTfD5eNBhHw169Kl6tgHhdh2twqskVygUimRuJMd5HPT5I3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11)
 by AS8PR04MB8691.eurprd04.prod.outlook.com (2603:10a6:20b:42a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 18:04:19 +0000
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2]) by PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 18:04:18 +0000
Message-ID: <7b612db6-cec6-4873-8a38-fb4c97192aa2@criteo.com>
Date: Thu, 14 Mar 2024 19:04:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Content-Language: en-US
To: Brett Creeley <bcreeley@amd.com>, Erwan Velu <erwanaliasr1@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313090719.33627-2-e.velu@criteo.com>
 <4e203331-62f7-44e7-acd9-f684c30662de@amd.com>
 <c0ccaef6-44eb-4851-b336-cdb06647e1d2@criteo.com>
 <d16ff01c-4a01-4871-93de-a5c26a352301@amd.com>
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <d16ff01c-4a01-4871-93de-a5c26a352301@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::11) To PAXPR04MB8989.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8989:EE_|AS8PR04MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fdcd62-6f44-40a5-bf29-08dc44512b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	511utUVBFjqbdZ5wlwpYrkEzGk5RuRiTH4Q9aJvcDshgJxCYK6G7flCsZgysBnYZRVthUUSrmHzvbY0YBSOYdGOMn0vH9FKsgj+PUX93zDt4TOPNr2hcJODWfRKByh2NQ+yzvou5wEEYikwpN8Gwv8vS0q/rbyQ+i3RzpVZlKtQwqYlS0tVKMP0dHK89K83ew7gry0NyKwrCFdQeUd6phcglUmpb5zt7omViGynSS522DyZTGPcaQ4QsrLrmqJdg781bnnupCRDnEpM/xuxQHmpuH2TiHpdrKnWwtWJ/LJ8a7bQ2cg2i/IgeUtADJuXqtLQt9tO6VsDia9dCW2RpLMkRFnNFbN9lnnzIP5Ong8sa1me+pLSHoBQNLgmvW+T/f34FPhVIeZa0a/Rwr1BTSdla7eJ66QIZs3AcIFMcBNfUExqd4L/iQPrk8mrMy2vGLAp8uZgPDjFEK4ICgYwA3pOIINsyv08RZluCB7P1GEY6i5lnQrzxH2pVjzdk7eD/e02Q7l55vaabzfnRlzX4VjokY3hKo9dzB23Ky5yEBZQfWTm3RZqrtM3/SjGhu8YTN/+Ye3xyMIcnADtAPfnS8tBuUufP3cfskatwIaXLYocxZ9S2kdd3R7kUVqwzrZfKJ7Wo9NE4Wq85XnCCctkhE/BoZla5KcOyE7bWWUGfzF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8989.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHMzbW8ybWZ5TndnVFNhbzNETFpyN2ZaemR5MWJua2xCVzRORjI3S0xxckxs?=
 =?utf-8?B?RFordHBtQW9xV3k1aXhZaEJpcmszdTNEUE0zSThuVTB4OWdaOGVKZm5MZm9i?=
 =?utf-8?B?U1FLdTNBYjhGeDFWUGlkRVB0WFlQWlM1ZWJqTFRxU0tSQXkrNExkamsxbDZn?=
 =?utf-8?B?QjJiNjR1LzdLYzU0YVpUVnNRYm0wL0tPY05OZ0ZCM0I2WG5tcWxmRVJWSVZZ?=
 =?utf-8?B?Y2NHQzVTa1ZrOUUreWJBck1senpibzlBRUpuY3JEa2FpZTlhL1htYjl1OTB1?=
 =?utf-8?B?Ry84WjRRekZ2eDdGSG5rS3NRZm9KYThWK1FhV0M5Q3hLV0lVaHVDbEFsZWtI?=
 =?utf-8?B?Qk9pUXpSQVcvM3NldE9wZ2wwSDFqSms5RVI0bkp3VGQ3N2FSMEZOMzhGSkM1?=
 =?utf-8?B?SGFNR1NJVHVpMHI1VGFSMndjZ0FHSGFKVGRBZEtZN3ZHUlluWlFPdXYydHRp?=
 =?utf-8?B?UE5QZDVKcnhQUU02TG1uMzJKcnA2ZitlN1g2eGFlVXJQZkRaWUlRWm9JcUpx?=
 =?utf-8?B?VWsvcnF1Wk1LM09vd2p6L0IrOWZ4eWovZjRWU09rdFZldnprV1BJRHhaSTlL?=
 =?utf-8?B?WUw1SlY5UFl4U3VoeGcwNEJMSTE1Ull2c0kyb1p4cmUzeCtQaDV2TkRITVRs?=
 =?utf-8?B?cWxwb0hnZnM2MkpZbVg1UkdyNGVXRHAyOXBxb3NTYUZUbEJ4MUN3YWhGRzJh?=
 =?utf-8?B?N3VWVjl3eVNROXNKcUdLSEF0VW5IUDQ2Mm1RckNvVUZjbDFVeWRydTFwWWVr?=
 =?utf-8?B?elByTDh4c1hvV21OQ2IvaWJsT00zTmRwRzFCaXcyUXdlLzdvVE9QVitjYmFp?=
 =?utf-8?B?Z2piU3EyWUZYWnpGcUZLTGVQbTdjTHR1TDBWZCt3YjlBZUgvSXZWZUJNdURa?=
 =?utf-8?B?VWFkZDdIaVZoWkh5cWpXaXhkajJWQ0RHRFJqVExYb3l0Qi9SNXdMVGgzSWNu?=
 =?utf-8?B?anh5bEJYc214dDZVOVFvdURXV3dtcjg3RGUwNjFNV0VOOGIzUllDQm1FWUZS?=
 =?utf-8?B?cXdJcHExWU1lZ2FUVlFhUmZBRFRURmlYaDc5RkYwaDJST1hXYlYrSk8ycGxT?=
 =?utf-8?B?VjRDdyttZFZDUmFteU5HZ25qUlNPZ0I0Q1RTN0hPZ0hodXQ5cnUxUVpJVGVY?=
 =?utf-8?B?d3IzbTYxY1R0a2hhdzU2VDBlcG9JTEszd1huNERtdzF5VnVvOThtek9zT2Jq?=
 =?utf-8?B?TGZpWGx6RDhNVEV2OWR5OWp3S01ZSkxFbWNUSnNCZWxKUkFPMmFMY2dTeS90?=
 =?utf-8?B?aW5OYW5tY2FJZ2p5SEJyNm1Gc1RwUlZla3dzQklYdVA5ME56RUp3bzJ2eXBO?=
 =?utf-8?B?VFJzVFc5cVZQbWJjY3d1d0pTL3lNdklJVDVUZEhxSVF5dEpaYTBxdXBRUmVG?=
 =?utf-8?B?SnY0STR2ZVZWSkFZK2lPWm5oRndjclJXWjhEdmwyTDNFTGZNSXRZR3hJbW9S?=
 =?utf-8?B?ZVpXU1hJck9ZUmJZbVdzaFNJanpVNmViODZVWGVPd0FpRWprL1g3M2hVRGNo?=
 =?utf-8?B?eDV3eGJZZy8wVDFMV3JkTndxcFJUdVRvSHRYM2Z4M3Y3TFdBTGRIMVBmaG85?=
 =?utf-8?B?NEFCdmxXZzY4VkNsOXg1eGU2NlhZRFV5M2MvRXF4azlQZjZCeDAwQ2xEZitM?=
 =?utf-8?B?Zk8zZDYvOVYzWHlKZzNrRm1NY3dXRVV4bFVaQ04yZEJHNmd1cDhYN1JrOVJY?=
 =?utf-8?B?eTA1Tjk4czFHT2dqM3VpdTlvZ3NVM0VVUzhsc0trQmNEaG5SRkxrTVFFSU4r?=
 =?utf-8?B?NFBNYXVTS3JISFZ3ajRXUXlnVjIzbXd2SkdPWWxFbzlucitxN1BoTDh6TkIx?=
 =?utf-8?B?SDcyVjRxeEgzVUE4aUVxbVFBc1Q2czNDOE8wSC9CeGw4c0pVcUxyUEVvbno0?=
 =?utf-8?B?ZWtnSzFkWS85S2dTL2V0UnNVSStXRXkwUExPaGNCUEE4VFJudkJVSjM4VXhD?=
 =?utf-8?B?d05jc3dOeEJGQlRLVlJYUlR6THRPWVUrSjZ3SkZ0N3RKUjFvNXZqajg1dVRQ?=
 =?utf-8?B?WFp2dUVMb2MvSUhiR2pnR0RKbGZ4dGtSNTNLK3E5dEpBa1MvSHEwNER3NTRh?=
 =?utf-8?B?b05hNHdPYjNEZVk5dXBOU0RNSTUvVkh2eGszME56b1ZodXN1Q0cxd0pnbnhH?=
 =?utf-8?B?T3FuaUhUc0E0aGwyTFBUcW9qVzc5ZXZMRzJuZ2MwL1lhRDZjZUNNaTd0U3Fl?=
 =?utf-8?Q?b92th+kZzWdnHjottPO7ZxFXsLVSWyv2RdlxW8E3HfPZ?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fdcd62-6f44-40a5-bf29-08dc44512b0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8989.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:04:18.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwb+Xws/MF3bCtNsK2L297GLIybtz15bGOgM2mAjJ2Rt4QewvEGeW0RlNVAnXof93ILg4GG6WoX9Mq9osvugoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8691


Le 14/03/2024 à 18:55, Brett Creeley a écrit :
> [...]
> AFAIK there is no API for a user to change the max_mtu, so the only way
> the device's MFS would need to change is if it's done during
> initialization time, which should be done before netdev registration 
> anyway.

Sorry Brett, I was probably unclear and please note that I'm not a 
network developer, just a user that faced a bug.

My initial though was to check the mfs size in i40e_change_mtu() and if 
mfs is too small, then let's increase it.

Maybe just resetting it at init time to the largest value (which seems 
to be the default fw behavior) is a best approach.

I'd love to ear from Intel dev that knows this driver/cards/fw better on 
what's the best approach here.

Erwan,


