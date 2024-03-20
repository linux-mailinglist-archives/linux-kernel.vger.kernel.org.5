Return-Path: <linux-kernel+bounces-108561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597D880C30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241931C21E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA982260A;
	Wed, 20 Mar 2024 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VCb4JtfI"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D82BD1F;
	Wed, 20 Mar 2024 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920340; cv=fail; b=dwB4QDAf/MzcvAyaQf+NDiWdUM8OF5XSjoxPPKblRhT8FqceaSng+K+YnGEGobP1hIWIWl3VozAe0yw/P0SD3vemuMbr8onYzuuXU0MvvGC0GPXevwbO/DLbqMMAtVxKDkGGSauYx68s+LkEYFWqkJuFtjTd2XdWHqpt2iC65qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920340; c=relaxed/simple;
	bh=hYLl/iejsSKRnaFCvCjMhZO2N3479WKbqyQA/mD5gZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kbh7Zq9Cchpmj9kvO+K42d+RvLwO6c4UlpfwNK7/qe2Tn05imw+8Z0QoEX2XrLfTgTafZAEuXTuhD9Pjxyeofj7aCCUj8jSmqoJyjBpOGBXXuv1E5iWa6YrvkLzodzc5w2G15uyrD2kjRpGf2N4TKEN4XFB+foOEEtLWwKtmnmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VCb4JtfI; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=midFflO5gr1haeY8rH9Bxwp0cp2TrW/MBd2JAsdwF81D7Kejn7/F/Lhx61yTpRC7Gz7/yusRXNahN8CWS6K16Gf7n79rz3e0hiMIvvoKBVVoD7ezjw79GWw1Y8NwXdTblk3kHiqRujGNrpDt5YHl00zYXJC8wZtrwzAEqQDHF9Val3FRDwfYFg4QrLhDxYQ+MxIsDQzsokXXZFTUnjnM+3BBBm5kBjSdI8jYILMygWMtU5CfZhzRR1EF6iOikRWTLTd46as/bWhuYn9qa8L7ZJYUj4/otwrLnHopuNA4vSkEbOUG3Bb4sBWDv8FKbO7DrLHOuzFN6fd+i7pD9QMA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQVccdhgR/te4gh4jdPIpyU4qfeHCpBpgd1GjH26Kb4=;
 b=e0ATqhumfxZy6n40MLwwXVCSDZM+t89S6LbAVXml+LFZcKrj2fvJz880pJolB15O5hRTTDm5qdX0asREQeW+mSlco6fj482/NMkft4+jJe/V0I2qA7dBWRJcWVjNYTcknL/a7VXKN9Rdqh3tq0LSEUMpczzNokKcjppYlZPKSmyLjtnGEEXCAImViKCW1wXHo0x0wLfz5wNS+LACr0ZbVaRxAhG3KGci1MH24BwV40zx+PaPUOLiVR0xQc/TyrFsILWKOBJKywAwKx9dEZeXPvioskREV6G/ftzFqoV4VQNxu8xse6EFH89EdXoXtNsfLto0FayWQyznbiVKsUOTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQVccdhgR/te4gh4jdPIpyU4qfeHCpBpgd1GjH26Kb4=;
 b=VCb4JtfIz0lIsYp7twu/WVyamRpBQe5KsXkivpBaDZ7cJI8WeOyVovRtaUxigjx1eUJZBRIdX6PyeC7elccgpC1w0kWnTclyqVL+51NZNcmSBroXHDEuC7huWQju/t3Ayi/xYPskbwJOflSV6KAAWxBzJhL9f9Ph5OhSfsDuxhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by VI1PR04MB6781.eurprd04.prod.outlook.com (2603:10a6:803:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:38:53 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 07:38:52 +0000
Message-ID: <b28ec298-c9c9-450c-bb5b-593945daddb9@oss.nxp.com>
Date: Wed, 20 Mar 2024 09:38:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] add uSDHC and SCMI nodes to the S32G2 SoC
Content-Language: en-US
To: Chester Lin <chester62515@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Andreas Farber <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <a7a55dc6-c204-4aad-adff-9806d3302b6b@oss.nxp.com>
 <ZeKIjyFF0ftnr19q@linux-8mug>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <ZeKIjyFF0ftnr19q@linux-8mug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0133.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::17) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|VI1PR04MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: cd088db5-39b0-4b57-11d3-08dc48b0ca15
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l96gioSluYoZV6Nnd5F0zyFqD6/0Uk+jhO4ctdbV6E8S9UaQusXenk5UoyPGHnfj4yRa/Du8wps2pUpGFvsYLJU1oB3ucaAeUzSbHOiQ92fQAYp+E1WXwVFlJ3+8vNXeNsibE34Klh4dfV+K+MOErrCQga1JRpf5Klh5vagLtXuGNaHjZR8wO45ZDi0ieCRGuKJgR8CacCl5sLjaBsVnikF/hdDX6i5pLIeCAe46JqaWKUAUQcR8OY2xOXBiVAMykogfzP85iNPDGX9Fguh/hhDN71MFh3Tn61ZnH/sRPAHly2szi4kzOy4O4DDVRyVC4s9gk8dISszeUpPJOh7mr4Z0gz4Xn4lu8kbBQGTDqJCqIKlRitQAC3X62IPlnHvomzs2O/kawZ53+8AmIOUNOY8Pp3xqX6hprBa2UyHM+KPwSfdV9cSaWo5+2agaORn3kUOD3TGzhkFWniUMAynG8wlKVDC9iQ4TG3jqXa4bwNqeWBsdW3K/r+fq1BTj0rJbGjRKM7js13Gy24gN3+jwBvcfo+dbhuC+hgXbyKqui/hv5/L8GTdZjUIqwykkq1+DzRQvVdCzRz1GIGCA8Ry0p7jDQYIb/zCF0iSRERO4bF2QhMGahgYT8hSY3x2e0rcnPtSIT8hTghDwcTuMBU8i2Zo7JHZciFjREBGWa4ZYCFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkZDNmkyaFJJNUdCME9LN2lMcWl0cjRTVnhJQWFvREkyRS85Rk5YMUlwTXRN?=
 =?utf-8?B?MDdPT3crbmErT256WjA1Wk5rcWdpc2Y4b3cwMXRwR1dyenAzbk1PbXBmTC9O?=
 =?utf-8?B?L1h2NEJiTWI5dGR3S0xOK2Y1MEwxUkpxS2NNUHVmTkhaYlFZYkNYcFQ5Mldy?=
 =?utf-8?B?K05iZ2xKYUNMRG1rQUx4czFsb2JjWG5SLytIVSt5TUc4UURwdXp0aHNYenRw?=
 =?utf-8?B?M0xXLzNMVHMvOHpGNjlxRHF0Y1dNUWV1aDB6VkhYalljVVhuOFo2RFcrQm9h?=
 =?utf-8?B?UWVHUXEvVXFYTzZvTUdnMURpTUtZSnRSSXltNUFDaGk1T0RjWjVXbFZHWVo4?=
 =?utf-8?B?ZXZzTm9SZjVSMTMwcDdVVUY3bm44a3VPUWVjZnZBZFU1WWtkYVBaY3pFWk1o?=
 =?utf-8?B?MFUwVjExWlNPdWJLZWo1d2F2T1lmMmRhZ240aGJwVDRlV251dkhWdEREOFo4?=
 =?utf-8?B?elFKRms1TmJtZ09EMWpERVlySXY1VU5qQW1sa2FQcDlQMFdWU2Fvb2ZpaENl?=
 =?utf-8?B?NUlvaEkxK0Jac0ZVR1h2dGZVU0lINmEyWE5qN09SNDNCcUNacWNPb2FXY1F1?=
 =?utf-8?B?a1dKbVc0cERDRjRSTCtZMzh1Z3lCK1JyT09PdmczbDR0eCtVN3ZpNFdsdEtT?=
 =?utf-8?B?Z1dhQlpSRGhESnZlb0lla0cyOEZtSmVqaG9QVThTYUhVTk83M0tDM01XUndG?=
 =?utf-8?B?ZnpNQ2hiNlM5QnVIUjFhSjlZYWNYVnBxVlM2YVVBUGFyMjB3d0JTdy94cXVD?=
 =?utf-8?B?UHB0N01mcnhON2dhakpEc0xsZ2JmU3JDbm9abzkvTUgwczFyM1JmT1hJUTVq?=
 =?utf-8?B?Q1FBR2RJVWFrN2Z5WFFzVGVKUitqQmpXVHV0RVYvOC9tTHd0d0NVNnM0WEE4?=
 =?utf-8?B?UU5KTXpFMVRKUFdlMmxMRVEvMnIyZHVEMEVvdC9mY3hINjl4Tmd2dTAzbFFs?=
 =?utf-8?B?UWJQZWt0aEJUUG9rVkdaRTNKQXJPdDRmL1dIemdXL3J6cHN4cGNkQ3ZJVmg1?=
 =?utf-8?B?ZEZxYnQzVjA2bWkwYW5WSTA2enZad1pkSTNnZFhuTjlud1FlaXU5VFhSc1JR?=
 =?utf-8?B?TFZXV3AyamRSZWk3enhmSkdUUzNLMGRBangxam1KT29FbXllcVF4SzA1dVlw?=
 =?utf-8?B?RzV2VnF1anNoa1lMNklzUk1aNVZ5clRheTJ2OUlEK0Rpd0I4TXlyOE5lMTJV?=
 =?utf-8?B?VmNQTFErQlFsdDhaRlpOQkxYZGVyRnNIS3JGVmYyaHdqLzQ2WC8wY2lBNG9h?=
 =?utf-8?B?dlRaOStpanNVemVrSE5yQmtYMkpnNkFNV2ovc3dFdEszdm5Pd25wRXBCQVE2?=
 =?utf-8?B?emtHelRqbU9wamYxcUhaeGlZc0pDL0NWM1hDemVmeWt0R0xBNlNFWGNLakRH?=
 =?utf-8?B?S0lVVGRoVFlwUHhaWmdxWlc2clp4R2RmVG9iVDJPeTM5NmErbXlucEFqQTR2?=
 =?utf-8?B?TDU5Y2YzTGd4MEFuY2xCbnZkUjZhVlJZdDZEVzNVQ0RYd1FHWk8zUnpDNUFI?=
 =?utf-8?B?eDlGQlo5Mk1KZnh6cGdLS25Ha2wvQ3JZS0duQjdtdmZVTCtSRUZpYW5JY0pq?=
 =?utf-8?B?S3dZOFI4cWswQVJpcjBDRkE4eml2d2x6QmsrVDlvN2F6UDh2bTF2ZjhkcUlV?=
 =?utf-8?B?SW4wZnc4QjB0MWpBdlNGTTZlSjJERVJPd2ovNXNQbXZTeVE1empoRkd5Yjd6?=
 =?utf-8?B?a05Dby9Dd3hyYldDb0o1VGx2LzZ5TmIyNnlhaWFuL1JDaGV4R0dZZ2prOVNZ?=
 =?utf-8?B?SXVISXovUVZtcTkyRW40OUFrV3kvYVliYWRYUitzN1RqOHJVaCtYbk50Vi9n?=
 =?utf-8?B?aXhyb3FBeWZMSTJjcW1rc296QUpWTThVbjhKLzlOZGlmc2dvZyswN0J1QytQ?=
 =?utf-8?B?bGpmOE1VNFlvYVppU05TSWYxaGFzejVsSzRNNEZQSDRkelZWeGVIUmNEUU1S?=
 =?utf-8?B?OHA4VEYvZFJieUlGU2xNdUliMEl6a1dnUzVuUDU3OTgxZ0pDNW0xUHh1cHla?=
 =?utf-8?B?S2FnT3daZHF0R2l1d1hJUDAvcXRwUlhrZVNBeGY5QlNrNlJxNzFBN0djNXMr?=
 =?utf-8?B?b3hXQllud2JkSGE0dCtnWURVcHR2TDRFQWs5TUFreE53dnJKZzVGUmErdWpu?=
 =?utf-8?B?OUVPRmVtTGgyZnhsQnFXMHpmOHlaUTErZEpxTHgxeGl1eGVnWFR2Ylpyc3dV?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd088db5-39b0-4b57-11d3-08dc48b0ca15
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:38:52.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2iu/khkmOyA4DFtJ6eVnSPHHwAv23RjNK7Qe05tJjnaJ7owpeU4N4Wa/IRyrPVAJhOA5pOE9vz2VEu0VDhUn68F/wXS/Jjs6QHd53N+rsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6781

On 3/2/24 04:01, Chester Lin wrote:
[...]
> Hi Shawn,
> 
> Per the discussion in another thread, could you help to apply these two
> through the imx tree? Thanks!
> 
> Chester

Hi Shawn,

I noticed that Chester's email was sent to you as a CC recipient, which
may cause it to be filtered out based on your inbox rules. This is why I
wanted to bring this thread to your attention and kindly ask you to
confirm whether these patches will be pulled through the imx tree.

Regards,
Ghennadi


