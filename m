Return-Path: <linux-kernel+bounces-59532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B984F881
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0254E1F21897
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD0745D2;
	Fri,  9 Feb 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pgpDh3FC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088D6DD19;
	Fri,  9 Feb 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492487; cv=fail; b=kMzpXvhoKsdlRjplkmwzRbNvcfF81fd6P7j/BpV32eBaXHTlH7LzW8y+/565Z8AlTpFmn/Zy4P5CUD+0Vw+TGOz699/zqRe0SvJUqp69bJ+4vp1dw90tXCIghwn5cm0cDE4qJMq+CXZiyfAyvjDNZpntgG2sUdNzQTGWDtNnh3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492487; c=relaxed/simple;
	bh=5vfpMGxGAjUaH4571dt/yReTPK3YbTXWgOFMFn5S4Rk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TuuhIRaRtwMryaqyg9CQ1LE+/tqMNq5ju4MsSYBGxSWi69rFWmiffcye7nj3SzXj2f1dUcObixlwArI3XjyW8j9jfObc/DarMeACO9Rke2hQhBz30/SEXR/oGkxe4c6p5l8Krk66x3ofxPrfKzH1iIYVZx4ZzPY84O3tXevIJVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pgpDh3FC; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMKJr/lJLgDGtdG9T0UBd3RB+COcWLU/DF+iTgGyf8VhDNie/E+bzkWeMxNjgVlNVBgUQ6CS6/Tm95JmEcqqzzUITZOWEDlMnR0jpG/vwTvSDrFkcDuI4hbv6RL1vQrdzwcSTlFySQmUHrNpSxUyWrgaCIek5x+ysWp64WMjmMiA8T2UcGkYRmFYwGRLu5UvA+/iw/Z6HHya/4EdpVkrwnKW6r1gIuiaTae8Ii2EzyiLNGCtU6eoVhCRXCvmM9wyd4cM6TcNnY7EQzwyZ424+JQTYy7rXcSiEvFzZWQWTFPFgrmF0NCqUrELRjZCMzoad7rDzeK60ESOr+jCcKv7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vfpMGxGAjUaH4571dt/yReTPK3YbTXWgOFMFn5S4Rk=;
 b=L0Z3QuudMThOesx4SIKyq1NXHpJMP3+4vRMwsm3DN6iqyRIqWIvEU6Riz3mUvUGyqgyC0gQBLypI29biXf7wBmyou7lX97b+5VdK0Y5psrEfa6ZEuYtbSERYoTChOzO/egzvFMcqfvNk0XUMjzWtSF4NNVHXxkAQ7e/5hTdlEOAkLwlN6kVeL1h1YcsGEmIZu/NhhflrQwnEqD5FxjQOBRyiyMHMmhkKEhjnd5g2yy3JE7tf96s1TZ7YbJXPhr4m/+jNNnBD7hs3eqt7c5lh3Mhu+Naq90SiqaK337QSXgeWQAUHsNzQhYlntzqOg2xNbdMEdMaghTjI7ITLtzBdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vfpMGxGAjUaH4571dt/yReTPK3YbTXWgOFMFn5S4Rk=;
 b=pgpDh3FC+2DJgsLQMqBDeYptMmkliJFJ6dgKRmNQ0gmEsLrBzOivYhNVC/V7szYAWUerQZJd42tYGEjO8YtISVghwomtMLNmJKZjUkyb+lqp5fDJVVjDugODw965PwixX1K9NwTvI66eQ5qGdfwSOD0fbct1cUM+NeL69AMGy/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:27:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:27:59 +0000
Message-ID: <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
Date: Fri, 9 Feb 2024 09:27:56 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
 <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240130222034.37181-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:8:54::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 332de958-2d4f-441c-14da-08dc2983b290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nsw3KJyTIRSaupfgkcqDE9z5RBpr1Tm/K+aSORyjFaPBqBRw/oU92/uCZ9FT1sy9rkf0r2hVCHE376rWr48w9WxFnCIly7+Kb6bM7imArlWpp/psr35/9hBsINyxapQeGmauBUtjZ9fPY69dSMokFMFinaysv9SEcHIztGNh1TugdOTe18VQlVVNtYqKP5tbVm9/vTWdb6ef2GfZzUNC1g8a0VI0+Rct9ChMemdl8Ic2q2wj3XnXXMe8c5DD/aomPev+kwmBCsW6oEvjfrSHnx2wMUv36VlHU7ccVMnHdzVGyPQpNHssRud+ifVPvms7/kniC3/s47VSHEz2zaHlpZCKAM6P1V5ain8P/sIxQLUgTMu49i3aLs7NwVSwxWHeqMK4NC5gnK7ulRd6NHwq/fctmLBM4P9qvV5Cbeu10Gf1K0tgzN6hHz43I6FktO/CLnowq4CUZrgpGbLRJ2rNWacpBeNexnTvQD4dnSXJHZX9KxzWdVxZjunZBiIATTUhx5Tc4PHBfcKE1BR8vmVI1CFTuWqtU6vMK2ZG3G8Bwncm/OLOb6aQeZvTTyI0OnnU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4744005)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6666004)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGFTbzNsbVM4TmN4RUNXeE1CR2gzZ0haODNFZ2ZLMEdGU1padDdBSDcwTnNz?=
 =?utf-8?B?UzZkb05NWmpjaFlVQ09jakpPWGRUUWhNL0hUeW1HUEJ5amhJMGx4WVlrV2hu?=
 =?utf-8?B?eGU2VlcyUmJhTFpjZ21WSjRHLzUrWmkvUFJabWt0MkdnS2UvUG0reTRWdXly?=
 =?utf-8?B?MkNXU2ZjdHF6NFM5SXkvMGxZOTFGc3hWNXFGSHFSZkVPU0lkNUtFSC9hNXJa?=
 =?utf-8?B?bDhzT0U0V0JGQVo4UHhHenErU1BIb2x4eldUR0ladnpEbGJrSlNFZndFSExJ?=
 =?utf-8?B?cFBwZVFCV0dZNHNSd0dIbDlBckwvSkF1THBkRVJuNkJXOXFpSVI4SndVYng4?=
 =?utf-8?B?TlBGRnNsNHZoYjIxRWp0RXBMVlFLQ3RDQnMrWmFIQWQ1T2d2ZlhFOElCbjdp?=
 =?utf-8?B?YWVkNExvUGNDZ244TCtGbU9BOXhlSkRPODF1VUlPRjBkMVkvSkt1UXYrR3FL?=
 =?utf-8?B?S0pPa0VQWlYxR0pGcHJiZERhTitoKzJ2bkJVMnhPRWlxbmR0QXlRd2lNcTk2?=
 =?utf-8?B?c2haN3NzRUNlRGE2UHZFOHNvRERUaFY1WEwwSHFYdlNMbUttVmEvT2hMUXN2?=
 =?utf-8?B?QmlEYWdBMlQwd3h0bkRLaXA5LzdhUmRadzR1VXYyVzNxRkJ5R0pxQ3IwZVFL?=
 =?utf-8?B?aS9LdmthRUFzRjdidTg2dENETFFZak0zQTZzT2FaVjZzVEpVQWlDODVVcFN1?=
 =?utf-8?B?RElobW5OZS9qRWtsNGRQczdPQ1JXanFxQW1yMVZ0RVFYUGZoaFdaOXB3OFBJ?=
 =?utf-8?B?NEN1bUhQdEdEcGJROEF3YytINENDMDZTbkZuOHJiTkdKbVR6ajRxLzJyYmI2?=
 =?utf-8?B?VGZlVjMyZDRqYWt3SzFEWkRaYSt3R0huclNEdS9CcTR6QjAwMko1bkJ0aUp5?=
 =?utf-8?B?WHEzRlNlaXlRaWhYWFV6UE8ySDJIR0xNRFJOM1VOdkJDaHdvZzc3WU8wMGlq?=
 =?utf-8?B?dGNJNkZZTnNLaGVkcXVNejFYSE9HOE8rNWdHR2c0TW5MNm5sTFllcGhPbXNJ?=
 =?utf-8?B?czZ5eDZSTUZtZTQ3cUxraVFDYjdrdUZMUFRuZXhMUHBoNTFkOHZ5YmZJc3FI?=
 =?utf-8?B?UTlHemNiY1JiMC9NZ2xVTlNwcm43dmtVcjJsbWcvVkIrVyt3QmZUZWl1TW84?=
 =?utf-8?B?V3RtbW1HQklIRjZDK0pwQVYxQU1QbjQyQmtGNkhQNStSL1lkc1Q4SFk4blBo?=
 =?utf-8?B?VjJTRk9OQVQ0K2xXNnhYS1RGWUZCeVkwd1RZWWpSUTBmeVhzbU8xeC9TVkt0?=
 =?utf-8?B?QXZtNkNtY0xCL3RyVEZxNjJOV256ekpqTnpIWVpTd0dnK3dYeHNBWWpMWXFI?=
 =?utf-8?B?aFc4UVVXZXVOb09UalVhODRzRzJYOGVUZHJCTlZrV3JQR2ZwWHBJTUFwSGJi?=
 =?utf-8?B?T1NtbHVyVWNTYzE5dm5Kays2dWozVCtPc2h1azZUeTkvZWl0cSthRXY3OEpS?=
 =?utf-8?B?UHNEVzVPSnFzUXE1SHNxcERQWFlsNnVLR1BOZVRtd0RpSnM4SDFhK1gxcDJu?=
 =?utf-8?B?dTFWWTJUaWxNdDhiQ2lubVFMTVdKb2JPTFQvVFc4OUJPMURpRTNuemNyOVJL?=
 =?utf-8?B?K2oxMkVMWkpDVjZLM1FObUt0WVNyQjVXUWFWOGg4MC9JeWlNeXFpSkt1SU1q?=
 =?utf-8?B?WjVYb2FraUFGZmtjSFgyTW1KQVJNbVdDeE1wS3hOS3FrUk9LZDdRNTBJUHg0?=
 =?utf-8?B?cHMvTVB5NkVtUjRnRFZiUUdrOXBEZUhUQjdTZVBhaDFrTFJxd1NoRm5rQ3VB?=
 =?utf-8?B?RWFhTzlkcnhlUjZUcnBVRmZLbnVDU2hKTENyQ0JrZGMxWUJacHJXcFg1MndQ?=
 =?utf-8?B?VVluYThzdDhCSFhkYllUNHl0QmlEVWxMbE52cGFCSVlNdktKcjFZeHczdklo?=
 =?utf-8?B?aEo1ckt0UVR0clpFZ1NIWWl0d3ZTSGVwWksvTlpnbW9wOXR6MHFpa1pxNjBX?=
 =?utf-8?B?d1pnLzlPRmtzVGFhTU5LUTFuTmZjUC92QnFkc3NleXoxazh0SFloYUo4OWxZ?=
 =?utf-8?B?SjFTK3hiaWg1U3VWblV4MnhOYmNuT2VhM2NsQzNRc1czNlRKdS9wekxldTFI?=
 =?utf-8?B?OVUzYTZWUk50VndlOGxvWGVTbnVKZkZKL2RsWGlvMTQ3UUZ2d09aUlMwbFBs?=
 =?utf-8?Q?d6AA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332de958-2d4f-441c-14da-08dc2983b290
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:27:59.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsLOOVMyNMSFBkYRhZels7HqFp4/e13PciPmnlIaFZkUDkpXvKtd6A8kqkAnJAvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Tony,

On 1/30/24 16:20, Tony Luck wrote:
> This is the re-worked version of this series that I promised to post
> yesterday. Check that e-mail for the arguments for this alternate
> approach.

To be honest, I like this series more than the previous series. I always
thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.

You need to separate the domain lists for RDT_RESOURCE_L3 and
RDT_RESOURCE_L3_MON if you are going this route. I didn't see that in this
series. Also I have few other comments as well.

Thanks
Babu


