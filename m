Return-Path: <linux-kernel+bounces-31019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE48327A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD451F22BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9E3C6B9;
	Fri, 19 Jan 2024 10:26:46 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2041.outbound.protection.outlook.com [40.92.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC71E89B;
	Fri, 19 Jan 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660005; cv=fail; b=Gsuv5UAcNC1w7WnWWoK3CIu8QDDGQ8p4DqoTUsMX9NMno3deE+HReGywJAOeBWq6MtpfGekmWm0iUtfBQGViazi4pN6V0lmtYOmY0yByQVnZ9Psk/xbDcNwMOXCaUGLrw2UxWQACzTrVqO4xnb7rvsOMd7Yq1oElO2xfJ9pUC2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660005; c=relaxed/simple;
	bh=4zdkACczKrYvDJr2+F1r9UEYGGzW7CRPRbONfv5j+Y4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MasAyvwn3q/zMsttH8TX9j+WpBonGSgylR2KKQydhx5RlYCczD3pmKqPmvoTdiFNBF8ac9qiOsalYU4K+PpK42FFbZ/R6VUBm6Lx5d3w+xWvtSd3lyzxRXSi1nPwMdLQk3bA/eqXvZp6rSkESINnVtv/Nn9c3+cYkjkpvaz/4kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6cSfNkzg9JThoIC6hcp3ZUWglfmRJnEH+VAVQbKA9kl6HI5Pc1pbGJXPq7ucSh/CAe9oG4wCx1/U8NWUCzj8lUqfITbS8ixNhfvSrb7HyHcKY+WSb7Lytqzw3Rd77+yy0r+fh8WOfxwMygIpBJLY08fWTG3H7CZGjjZBqQPpz4HUatD1tABIgHzhWng9ZeJ30rnDFOY22cy095ug2R0LFfaSVUlooKIYtPfE7oXSJQkdwNIohotn6NaN27pbbgJJJTW0/uSgjACfTmdSxV7yaCeX77rW3U+TXBEQnRsw8SdRp2tCSbXXOotR3oXJTHZjds2pKgKsj7IJbEBNIkYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUzY8vMARfevHJNGQZ/iOTXp7aRCBYwfC35ynE4v59g=;
 b=eo2sjA5I8hPjoPR5Na/NGFJU20C4rXTHh8gP7KlwBsaJbk8gjyBMEmtQFufbJWC5P3Mkrf/u2J3AbbFmkr50tlsX3FCyzgGj1cnhT88v8Azj6saMKxc3jsWvcZRJNL7Xuqz/dCf7dXsDJCfEdaIgbqonqBHyBEVB0endOJVA6vczA+6AW/iwpOtBCcvz56HKTsyWhaNDLF/dH7tAdOXGtkTVMEAWXVBoeNDAtqljg4VvgL9J/BCnAq/EDaVo/a6ASmluEPt37dT3VEfBiFdemyCcIvALQuYYn17eDSPNk0oZ7k9XeThEfQA2Vd9upj5Gc8STjNhee0kYW/LuNoD77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM9P193MB0936.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 10:26:41 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 10:26:40 +0000
Message-ID:
 <AS8P193MB1285C2DE6BCCDC8DD40E5A64E4702@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Fri, 19 Jan 2024 11:27:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <f5ddf800df95cdce32637d41bc1539aed0a7b6f3.camel@redhat.com>
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <f5ddf800df95cdce32637d41bc1539aed0a7b6f3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [H42hYSkfusIgBzAtCP0ZV6/lSomDHaqEx20ukHiAv+PiVAVjSp2KU0KSPiHTY5iT]
X-ClientProxiedBy: BEXP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::26)
 To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <98a4b2bd-84d8-4fb6-8964-fe3a8eab2fd3@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM9P193MB0936:EE_
X-MS-Office365-Filtering-Correlation-Id: 243c6f85-e25d-4aec-647f-08dc18d91ff9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rNfKZGVANuS1fqeKkZW4gAHUSEHZqAr0tarbDlOpYvAp+X+sDQitUPo9B7LaBvTv1Sfeb2/hRabiNjvT+C9Ctd6GRqoXH4AYUJ4s2pIFt2FHQMhSVNg/W7IoTliMZ8iDU5r5GewSF1mXt/rGfxWD/KvrtpfrHbeL/IFshhfH1LEx6HDFJx7fBLWEnQbtcllHWE3vqZo14p0ZFr2qCPrQyTUTDUEtqcbyU1KJHbfOVsI0HRoj9BoHiIwEvvwQrpZxsURQXjIbwSrwMC0vSs9pIoQbFnZoITgkJ5Zx07y0q0r4n70wk06aJbzVcNxy0nIW0ZQ6ziEqguxUoX01eA136atXaQzWxxrewm3onvkY0k6PbmDuoANVrCdDNfaoq9W+pw2f6+27qIU2hwmBcmONM4dr6avJNrMey3uelseStlwDRrh0niq9+QNC9jmPTwglKnJYu1UxQly4+1FysGLBtbHD4AGvey9OkmxwyM8pC7oT2ejdFm55vXypd2+7XHVxcwDp2pt3jEHAnAa4xMvNirKT3nZUfiXMWMHggZljBfSFXIqTCHlbMfIhIRttrw0S
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXgwUkFva09ocW9oY0NTcE9FTmhzU3Y5WmgrRkpCc2VoOTgrYkFNNXhZU0FI?=
 =?utf-8?B?ZGdEejhacUVKWWh0bWl6UkxkSGVNWWZsVlphMDhiVzZqNGdZd3c5LzBGcnRH?=
 =?utf-8?B?aEM4STYwYnk3MEVYS0hiczZ5dmZmL1dOVkFydWprNnJndjIzV1V0dm9GaWJv?=
 =?utf-8?B?c3A0REhKY0xIY1R1VFVINGRQamV2Mnl5M1hHY1NEMC9hQ1hCbGtNeC95VUNZ?=
 =?utf-8?B?RkNLMXpvWkpEQkdXM0V4ajNibGRVQjZkcDBmYnJ2TnZHYTRBNDVnZEJnV2xB?=
 =?utf-8?B?YTJpakdVOEp6ZHcvK3lQSkdoYzA4THdxeDBDVU02VUlXLzZQejEveU5CSCty?=
 =?utf-8?B?SnJKUVBCQllWNGJZV01UWEFxd3QvdXBpSjRUY1hIUGdOcWRmWUZQeVBSWlJI?=
 =?utf-8?B?YVZDR01lSEQ0TE05ekNHTkxEejFsOGRkRDVERmlnVUZFSHBxdlF4Yzdqcm45?=
 =?utf-8?B?SE5mMDFmVzVpbm93MDc5NFIrTndvdS9oN05TY21FRklUbTZRQk9ydFFZNFo0?=
 =?utf-8?B?bmIrZkhTZjhrYW1LNlFTSWxWQVg2cnNTWWxHWHpQWEJ2YURnVXZFS2RyaldW?=
 =?utf-8?B?UHdSOC9BeEVyUWdaN1RFakhpc3VuSU5kUzh4T05NZ1dpNXVnR3JBMjFYTFVJ?=
 =?utf-8?B?NjdnMUlRN3E5d2szU0FGMTZJMVZBM0JBcGFQcnFYZVRjdHVFZ2NFU3RjL3dJ?=
 =?utf-8?B?QVJLRTFZSGwvUWQ4NnNFQ1ZMeVlNQUdIeENIcVZYSTB3NkhXVElxeE5XS2da?=
 =?utf-8?B?QnM5VEJPQmhZVWxTUHRQQld3aXFwcGtCUjcwWDFXR3E5MEswSGw5dmlESDN5?=
 =?utf-8?B?YTJxSUJZcnZZcjNPNG9qNlZKdXVOS0ZUZGREY1lPZDZDU2FVVVJoNzk1UGV4?=
 =?utf-8?B?SFVhR2lEeEpZRVhXRWY4K1drK0FyemFXRU1icHNoTVFIVWFhbk9yLy8vZS9h?=
 =?utf-8?B?dFlOWStmdkJvUWZJbGQwR2U5ZXZjV0lBV0dQRXR2SmQyZGdoczZMbEJOTXJR?=
 =?utf-8?B?M0MvZXAramd4YVNHdnFXbVZiSUM1Y1FJalM4SmhhOG9mbW1tcGQ1LzczVkVj?=
 =?utf-8?B?eTNveFY0ZHVjVVh1UnNSL09zODJHR2ZVYnkrS1B6NC80UkdXTXhpNUlYV0tn?=
 =?utf-8?B?WFBKWi9HdENBRHRMNU9lYmVKYTB0Tk4vSE5Lc3djQ1hheVd5YVRlY2xzNG9q?=
 =?utf-8?B?ajZLVUNRaDhuZkRaUVJXUEFlcW9Ia2pIMGJqUjIxejVIVkVHT05xQ0labEtJ?=
 =?utf-8?B?Q3lRNFg3UkM3bnE3MUxtNjdaOWVxSVhncVA5U1JMdDlzc0FGbWNjczFHVGFl?=
 =?utf-8?B?bkV1c0pId0l2K0l0OXYwU2xSdUphZjdybUdVSWplVEYyL1lYTnpaLzQrc2dh?=
 =?utf-8?B?UGFrdFIwNElRMVdCejhkS1hzZU9mOEJOcGVsSHhMbEU1WE9QZnhGc2JPOFIx?=
 =?utf-8?B?TEZuMXoxMUJSVWFPTHJXeXBESjBmS3Zpcm81OTBDL2x1anA5SzdZS3djUWdp?=
 =?utf-8?B?bE9od0YzQUJkenphYU9LM1BueXBkTGhySGYzM2duSWJIRE1mTXVZOFRPc0ND?=
 =?utf-8?B?ZlFkNDVrS2k4UVVuSDN3MUxEcU91VDRHbmlrRUMyY3FzQ1VaUUMwa3dUL0oz?=
 =?utf-8?B?djBlbGdGSzJKRjFTVUl0UllUUG9UQ0JLQkMyQ01IcHpGYWl1bHg2TTdocXFh?=
 =?utf-8?B?T3A3MkdWdk53S3l6ODFNUUFDaGkrL2tBcmpXclBMOUV0ME9EY1MzdFpLeTFC?=
 =?utf-8?Q?d30hszZ7jQjAktY4dA=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 243c6f85-e25d-4aec-647f-08dc18d91ff9
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 10:26:40.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0936

On 1/16/24 13:22, Paolo Abeni wrote:
> 
> A fixes tag is requires, something alike:
> 
> Fixes: <blamed commit hash> ("<blamed commit title>")
> 
> A bisection is not strictly required, you just need to be reasonably
> confident about the the culprit.
> 

Okay, I think finally I found the commit that introduced
the broken reset logic:

commit c5e4ddbdfa1134a36589c1466ed4abb85fe6f976
Author: Chen-Yu Tsai <wens@csie.org>
Date:   Fri Jan 17 21:24:41 2014 +0800

    net: stmmac: Add support for optional reset control
    
    The DWMAC has a reset assert line, which is used on some SoCs. Add an
    optional reset control to stmmac driver core.
    
    To support reset control deferred probing, this patch changes the driver
    probe function to return the actual error, instead of just -EINVAL.
    
    Signed-off-by: Chen-Yu Tsai <wens@csie.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

that commit moved the reset de-assert next to the stmmac_hw_init function,
without any delay in between.

So I think I can now add
Fixes c5e4ddbdfa11 ("net: stmmac: Add support for optional reset control")

> You need to include the relevant target tree into the subj prefix (in
> this case 'net').

Will do, but please clarify how exactly I need to change the subject line.


Thanks
Bernd.

