Return-Path: <linux-kernel+bounces-160198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834DB8B3A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BB11C21C54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1068314885D;
	Fri, 26 Apr 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tVv28ZpY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364572E639;
	Fri, 26 Apr 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143569; cv=fail; b=k8tSOhmYd4CA3sLgZ9xiRQ6CaoSzAQo4Ml9NoMRgE9/ocg+VrO79lvrTlu2jn8e3gGdxDgzWoZvrv8qGXbhf7iKqfed/2ecFNH6qG2u8u089sT44zNXryqH1btWxoxDP8QJQnFevHoXRVMVPYGVB/TPA5odNeSo89HtzL/D05tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143569; c=relaxed/simple;
	bh=BGXl8YC3xu6OQTr4qFbxgdl1v+5WRq8DwNDrxu21W+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDuw0pdoF04esiGBePf+XBz0I8SUOo9qAeOZd1wVTEtGJ2zUrp4D5J0vMesvTuDlbWMSUV7t41aW1XyViUgQSgwdOKvMywzEWh8wjH7HmrbkQ8uWRssF48RiGvsXE5iaHhkfLOzS6qmZ9wZyrg6d/BcIBReVJor8M4iQPg10Vck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tVv28ZpY; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9uY6Y1cUcunTKUGTPrr6kjkfIR0m+jt1FM86puy6XcscMk7qfLUD6UbpkoHJRQLIZQkKmK5fF8q/y0D2Xqg2BSrA7L4hi31epQeBNrdR/PvcRMd9wyEeytKXYY8OEE3pzVOJ54L+aauxNOV8dGymn8OCEwnYw4qI1D49VLxZUaQ8Ez/I1MyWx+DqZOLTLm30XNCOYnhFZrwjhQTx54DeKI1W90tH6LqVnGW4cb+zJ52oAnKtgTo3Fl6/r2lf4dDxtLNPBAqy0bse5sAhgjIPVzTpaqEqKQj/30iOj+5wwJ/4XOyZ5tZXZkgRwUGf1zLkooz61ZKCtDjmg2674k47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGXl8YC3xu6OQTr4qFbxgdl1v+5WRq8DwNDrxu21W+U=;
 b=kgzpSAXZOHltW79+fw2MLb0yDNt4VwDKoINfOdzIJjL2zFOzx24buuMwOcYOmE54o87v7STvpVhs9m5m902SqFyHCsTjbWNOy056lGacmBOQViOPPTvznPTQzA0MbdQbowHJlcFRgpFtx9sT52ZR2bO4PsPYeA91bQWqNAihtGsRtPZBO59oqZvbXmosrMPewRU+y2jUnjfh6cEexAXfxU9VddylY7rvz1ptA7hISa0I038IR/fcljYspC1iorNX8dxnRT0WAWAiIrh4qk+TR1MINiY3r4ktPY+AA+t77oIx8VgMP4W7sUrWqkIdD8xU23QSCVFIAWR/JRuGOayrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGXl8YC3xu6OQTr4qFbxgdl1v+5WRq8DwNDrxu21W+U=;
 b=tVv28ZpYYyj7XOnJRsDlT4MFr1SmkxOwYlyB9kfdXCb6/xHktrqBypM+N7X8c+i5ikzSascO4oiyqWaxk64xHcdbzDtwZwkF4MPbtqO/neKSOx1fWycs+BaHr78ct4Kx3ORAyhfOxs8Li+Y7Gua7e+O2qa7519oPOiQdAWyaqIDlf6I16vc3rCQjZ8SX1kE85hvkMlMV6+WORQYQzpXdYZTvzDk3oSg3hAWnwDx7DpaY+gH8wUQFLKHJdrTxLgNXrMzizCRkoLNymEfzmc/VldTWp3dl/K35QuZr9dUpRM7mraPcMPZtAhbG1cPDtpS/fjm4mkG43/m49ET1Kj3Vig==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:59:24 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 14:59:24 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "almasrymina@google.com" <almasrymina@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Topic: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Index:
 AQHalmh2YwjSjfzzmU66VYtjn6H0WLF3q+gAgABPNgCAAKoVgIAAuWSAgAAHhQCAAA86AIABMn6A
Date: Fri, 26 Apr 2024 14:59:24 +0000
Message-ID: <88222bf4d3b4d142ee227eb56d24fa7a7ca43fe1.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	 <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
	 <63222bf6a298ae38e77b0c0f49d13581dd9d3a74.camel@nvidia.com>
	 <CAHS8izNyJWhcRro8OFPTqsh9J4LEbm7Le6-CiW_oxi2NopAqeQ@mail.gmail.com>
In-Reply-To:
 <CAHS8izNyJWhcRro8OFPTqsh9J4LEbm7Le6-CiW_oxi2NopAqeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SN7PR12MB7154:EE_
x-ms-office365-filtering-correlation-id: fbfbbddd-0508-44ab-21f9-08dc66017606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3VtVXZJZzNlVUJWekxpR0hWN0xnSHBUdE0rWXpzcnZPK2RiUGpieWlDWHlp?=
 =?utf-8?B?SnZvZTk1dS9Cbml3aVI2S0htVEN1RWM4V3RSeXlvUXZKWnpLRkhIMHFhamVi?=
 =?utf-8?B?MmZCOHlpSE40NVRkakdMQ0FXNEcxaktjVWtPMEJWbmhnanR2bkdqN0libWhy?=
 =?utf-8?B?azlCMGxhRW96Z0xaWTViYXBjdnlLK1crK2dvUHh2V2xTVWVSdTY0b0FJNDYw?=
 =?utf-8?B?aUxPaThnS3RxQ0FIQTkxM08rWkRpT044UldwNXptME9RVUF5em5BekNNdm41?=
 =?utf-8?B?MlpTSmw1eitNZ3lHc3B2NEg3UjZ5UStsTUxvZ1poNkFCcU80QWNrV3kzWTB5?=
 =?utf-8?B?dERBVGRVSjUzbjRvc0doVnZMN29DK1R6aEJyQ3NHUlV0S1oxNkZVKzZEb3Z4?=
 =?utf-8?B?YTJ0Sld4NjNBNVhWTHg2V3dHNHlKUll2eGlDNmRJQmRZWGZkRDc1N2VUS1hM?=
 =?utf-8?B?RThMYmVnZmhRbG9qeEYyaFpCT3NnWExoM3dJd1dQMkJjajZFK3NaMG9VaFIr?=
 =?utf-8?B?aVVWY2JkTDh2dTdHd2ErSGh4SzRJSGZGVjBpZndRQWdSK24veGpzTVYwcmZV?=
 =?utf-8?B?a3hxbzZ3RmZnYmtMMVpJbHhQdVU1K0xNdHVyTllWME8vc0tCVThoRWlZRUhZ?=
 =?utf-8?B?RnhPbDNrK1A2Z0RSU3Z6anRibGYzZDV2MytNTUF6d05mTzBzK1dWMVRONi9j?=
 =?utf-8?B?QUV0aHN1RzVKb2VWVGZ6cHN6U3VvZXFFTFBmNVlYL1lQei9zaG84aEl2ekFy?=
 =?utf-8?B?MHowU0VsTnZIcHBSVHE3NklZRVU4eko2UXBJSTlCb3QweEJvcHBLYTlBR0Vq?=
 =?utf-8?B?UkJYVjVkVmtkMzFjcjQ0cjU2dkRnVVg0MU1WTFBjS1R1YndyWjlKOGFkMGpi?=
 =?utf-8?B?YnI1VEVXL3FFK3Y3MnVDY2tEL2tPVTNIdHd1eHJNZlJyOVRLR0hLeDg2THAv?=
 =?utf-8?B?MkhnVU5PLzR2NEZJSzEvVkZCM3UrUlRjc1pmOTV6WkFQaGZZeEgyZ2NpOTNQ?=
 =?utf-8?B?ZkJ3OWJvMVpyWEwrekR3TFJZQW5heC9RdmFOa0ZXQWduWnA0eHFOc2k5akxP?=
 =?utf-8?B?S1c3dGsrRzJVSFJrQUVzaEFvUzBWT2I2NGMvZjdqcXhrS3YxU3ZRenQ1QnNW?=
 =?utf-8?B?NVZzRFpiVFk3ZWpBSVVRZTRFMFRLNDN6RDdIY25nekVrNHNBMG1PSkt1K25h?=
 =?utf-8?B?YzNqeWVSZGlnNzVaMy9QMmZEMENVNnRwT3lxUEFyQ2JUb2VUZWtJTXJySU1h?=
 =?utf-8?B?d2lYUFFvUkhadXJWQkthV3NwTS9EZC94RTl2VHEycGFMeTh6Wld3dDRCaEdD?=
 =?utf-8?B?dTBZMG1KSjFqeUV0VklzTFczUjdob2gzN2ExWFN4ZlRaeHIza3VraHZpMHoy?=
 =?utf-8?B?cUhRZ0cyM251T29oRXRnaVBaRGhEWEZod0FlWnM5a2ZqRnFYNUl2cm9IY0hP?=
 =?utf-8?B?ZEdvbWF6eTN2TEJESlYwK1ZHdnhNNnY3S0JYK2w0STVObEo2ODlMM2RMdTRp?=
 =?utf-8?B?WWh5UFUxZGlrMGhsaXp4NjhDUmlXcmhseFh1cG1yQ3RiMGZUdGI2N0c4cUh5?=
 =?utf-8?B?ODBuZCtaQ3FhVmhmOXlsVVRnYnpJOFN5bnAvU1dwWDNwT3hFMWtnR2NzV28x?=
 =?utf-8?B?TUFCV1FiaWJuVUp0V2U2UExwYU5XNDZnZTZBZExjL01DdEV3YXU3bGxXTUZ5?=
 =?utf-8?B?MjVPbU4vQTRJd3MvNXpoWnJaZk9ZY1FKUDJ4WGM1YkRHTXV1M1ZQWExGQVYw?=
 =?utf-8?B?SHlNdWQwQ2RrS3BMN0ZOc1pGRkk0STFKRDYrOExtRmhyanFzTHdqTHNZeUJK?=
 =?utf-8?B?eEpzSFduVzhlaHNlV2hjQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akRhdE1od2lpMzhQOHNQTDhQd0VONzhYZjJTbnBmdG0xakVXQSt5L3JHOXRO?=
 =?utf-8?B?OW1QVzI3TFRVWHB1SVdtY2NwOGxJTmpKTHVKcjE2N2ZFaUloNno4TDlhUThB?=
 =?utf-8?B?clVQOFBKTmVrUzl6OGNyeXdwdENOT1F2bDJvMXNUaldlNzJjeWswQU5LaGIr?=
 =?utf-8?B?Z0NQUlRBZmFVc0FreGhiUEdXekw1NFJicDRiY2hySVpJbmxnUHloTkliMHJ0?=
 =?utf-8?B?Rlc1Nkh1MGRDYXJjYkpONjFmRDVPTGtxNHVDVVJQWEE0bzQxUThWOU96a2x0?=
 =?utf-8?B?ZW1BLzF2NitHRWtTdWZxRndTMXdTN0NUbmFvYVBaM0xCSFRXeWg3TFlNYTVm?=
 =?utf-8?B?dnBUVStBU0IvOWlFamZ1N2xqWWg3L2w2akt3UXVOeGJ4VWNZZ29lZlpDakV5?=
 =?utf-8?B?WlJacUxZa3F4VWYwN0FlRkluRkRHU1hmZ1dyNWt6NFo4R2dVTkMyZUJiZzhO?=
 =?utf-8?B?MHRZMEZHK3M5a1ZTT01oV0orMkhTOC83WnFETklWTkZCS09KQ1licVB5S1Fr?=
 =?utf-8?B?aVpoajd1KzlwUWhQVlVlU2ZHaFhQbkV3Nm9PaFpFaExLK01GVGd5M0t5Umtk?=
 =?utf-8?B?TTFqUVJURUprOHU3czIrWGhwY3JYMnhGN0tpbm9ucEZHSW1aQWY5SDlacXZl?=
 =?utf-8?B?ZUdub3RmcEJtb2lMS0dTdy9jbW5YdHIvOWlrRytWZElIWmFzbFh5S29tWGFY?=
 =?utf-8?B?Q1FpWnFHL0k0YVdkRnNmT29pV2F3bkZZK0d3Z3NLRTRKRUFnOEcrODVlK2Q0?=
 =?utf-8?B?R1VsWlNkV3orZGdFanAvK05uZVNVdFNBalQrRE5NRjBvSFowS1ZlenFucVQx?=
 =?utf-8?B?K2szYzdsOVlkQ0xBZ2gzbnczaXVBSVcxWTYza3VPRHAwczljaEFNRFFCbFVa?=
 =?utf-8?B?dXZBcXhDeTFFYllwZFhIM1RlbElpUDZSNkxJZ0FhbGlqWCt6WHk4dkIwZFY3?=
 =?utf-8?B?ZnEwanpGeUU3aStWTHZ2anhnTWJXMktITjBzS1N2RmcyMWVmMjlxVlplVy9z?=
 =?utf-8?B?b2ZteVhCRHVVeHA3ZGZNY1JGTzI0ZGRuRUUrek41aUxUQ3dVblZYTnVJUEQ1?=
 =?utf-8?B?OWpwSUxINFJZSnkvMWRjQU5mUWFQSEp6cU9qWHVGSVNURGdtVy9TU0dCVzFS?=
 =?utf-8?B?QmpPWmdaQUhqdGRISE90bWlwK05TTDlKVkE0K01JNWZtdFpvaHZRVytqRUNI?=
 =?utf-8?B?RzM3czBMOVN5eERDbkgxODhleDI5My93WmJHOVhtN3ljNElWdjJzcjBLY0lw?=
 =?utf-8?B?d3BrS2UzOEF1TFY3emNnaHdrY1JpaXZTNit4UVhwYThCVk9mS0ZZUFR2ai8r?=
 =?utf-8?B?WVZuVDQ5UjdsK0J1NEltc25KcFJWa0ZmOVNXZW1ROFg0bm1MQlVmblltZDdl?=
 =?utf-8?B?bzFwblJWRkZDVW1sRnVBNHVlTjFleUhhWlZJb0EyNW9DY3pHVXR4UGVGZk4x?=
 =?utf-8?B?YmxmWE5iRnJpRUlvVTBaUDh0VksyaEhWajhlSHRDZjhwMkJEcUlGYmxJYWgy?=
 =?utf-8?B?MmdROGZQa0J3YWJaRExnNFpjcDh2bi9HUzV0Zm1EQnBSaUtmWW5uakZSYnZz?=
 =?utf-8?B?NFFQa3ZnV1Z1VGZnRVlTVVpoR25HR2JLYTdDU0dDTTVJS0lOZjhMZ0V4R1Rm?=
 =?utf-8?B?Y3lob2d0US91R3dJT3JKSkYyNlJFZnMrclo3cEZEV3JIRDBkSitnOUhMZ1Ex?=
 =?utf-8?B?aGtqVk1VWHBCVUpBdGpBME9qWE83WXYvd0RvRDRMWis3M0Z0WVMyMHhhLzl1?=
 =?utf-8?B?ei81STd0cWhMeWE4NFZCMFZGSEw5TkVJL1pjVytXRkxHbmxIcllFYmdITUlM?=
 =?utf-8?B?Z2VNY3ZiMXZkcjFoTHJXVUZtSEQ4VkZ3K2N3ajdiTVJ2ZzhBL0NvTWVaeTlr?=
 =?utf-8?B?N0JQZVNHZEIwMXFvRDFCanJrU1FMZDhPeEtuSjQrMjJNR1Z5OEZBdDZteG5z?=
 =?utf-8?B?dlRvM0xKdEVkMlNPVFB0WnhxSkNjc0MzbVhwaGh4cDJCL2xkNUhXdHNhUUM3?=
 =?utf-8?B?ZnBtNy9waG9iem9EYTVJZEhjTnRZekUvb0taVXRiZ3JiQzBFRVRRT09wSW40?=
 =?utf-8?B?SkJ5M1RCY1ZQWWRrdTRMUnRoTWZJK21lZUJUWE1FOUYxYWVnU2ZKSndKOUdh?=
 =?utf-8?B?YnBmSjdkL0dML2Zjc2k4OGpSb0xUTEF0eXVIME1BK3ROdk8yS1JRYWowb3dr?=
 =?utf-8?Q?HaV4UVspWTq2EvyT7P15Dk/bNhgKVWv9fid6T8+QjBaf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33CD2E5538F3134D83637B1962F73979@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfbbddd-0508-44ab-21f9-08dc66017606
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 14:59:24.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EaqBNyBvW2TvXm69PnuwfWHqYnmcq572ehT5H5P2YZztMIMEfGYkwc5rcM39+8++foOm/EnnfC+umQQikFYOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEzOjQyIC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IE9uIFRodSwgQXByIDI1LCAyMDI0IGF0IDEyOjQ44oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAyNC0wNC0yNSBhdCAx
MjoyMCAtMDcwMCwgTWluYSBBbG1hc3J5IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBBcHIgMjUsIDIw
MjQgYXQgMToxN+KAr0FNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90
ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyNC0wNC0yNCBhdCAxNTowOCAtMDcwMCwg
TWluYSBBbG1hc3J5IHdyb3RlOg0KPiA+ID4gPiA+ICBJZiB0aGF0IGRvZXNuJ3Qgd29yaywgSSB0
aGluayBJIHByZWZlcg0KPiA+ID4gPiA+IHJldmVydGluZyBhNTgwZWE5OTRmZDMgKCJuZXQ6IG1p
cnJvciBza2IgZnJhZyByZWYvdW5yZWYgaGVscGVycyIpDQo+ID4gPiA+ID4gcmF0aGVyIHRoYW4g
bWVyZ2luZyB0aGlzIGZpeCB0byBtYWtlIHN1cmUgd2UgcmVtb3ZlZCB0aGUgdW5kZXJseWluZw0K
PiA+ID4gPiA+IGNhdXNlIG9mIHRoZSBpc3N1ZS4NCj4gPiA+ID4gVGhpcyBpcyB0aGUgc2FmZXN0
IGJldC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNvLCB0byByZWNhcCwgSSBzZWUgMiBwb3NzaWJpbGl0
aWVzOg0KPiA+ID4gPiANCj4gPiA+ID4gMSkgUmV2ZXJ0IGE1ODBlYTk5NGZkMyAoIm5ldDogbWly
cm9yIHNrYiBmcmFnIHJlZi91bnJlZiBoZWxwZXJzIik6IHNhZmUsIGJ1dCBpdA0KPiA+ID4gPiB3
aWxsIHByb2JhYmx5IGhhdmUgdG8gY29tZSBiYWNrIGluIG9uZSB3YXkgb3IgYW5vdGhlci4NCj4g
PiA+ID4gMikgRHJvcCB0aGUgcmVjeWNsZSBjaGVja3MgZnJvbSBza2JfZnJhZ19yZWYvdW5yZWY6
IHRoaXMgZW5mb3JjZXMgdGhlIHJ1bGUgb2YNCj4gPiA+ID4gYWx3YXlzIHJlZmVyZW5jaW5nL2Rl
cmVmZXJlbmNpbmcgcGFnZXMgYmFzZWQgb24gdGhlaXIgdHlwZSAocGFnZV9wb29sIG9yDQo+ID4g
PiA+IG5vcm1hbCkuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJZiB0aGlzIHdvcmtzLCBJIHdv
dWxkIGJlIHZlcnkgaGFwcHkuIEkgcGVyc29uYWxseSB0aGluayByZWYvdW5yZWYNCj4gPiA+IHNo
b3VsZCBiZSBkb25lIGJhc2VkIG9uIHRoZSBwYWdlIHR5cGUuIEZvciBtZSB0aGUgbmV0IHN0YWNr
IHVzaW5nIHRoZQ0KPiA+ID4gcmVndWxhciB7Z2V0fHB1dH1fcGFnZSBvbiBhIHBwIHBhZ2UgaXNu
J3QgZ3JlYXQuIEl0IHJlcXVpcmVzIHNwZWNpYWwNCj4gPiA+IGhhbmRsaW5nIHRvIG1ha2Ugc3Vy
ZSB0aGUgcmVmICsgdW5yZWYgYXJlIGluIHN5bmMuIEFsc28gaWYgdGhlIGxhc3QgcHANCj4gPiA+
IHJlZiBpcyBkcm9wcGVkIHdoaWxlIHRoZXJlIGFyZSBwZW5kaW5nIHJlZ3VsYXIgcmVmcywNCj4g
PiA+IF9fcGFnZV9wb29sX3BhZ2VfY2FuX2JlX3JlY3ljbGVkKCkgY2hlY2sgd2lsbCBmYWlsIGFu
ZCB0aGUgcGFnZSB3aWxsDQo+ID4gPiBub3QgYmUgcmVjeWNsZWQuDQo+ID4gPiANCj4gPiA+IE9u
IHRoZSBvdGhlciBoYW5kLCBzaW5jZSAwYTE0OWFiNzhlZTIgKCJwYWdlX3Bvb2w6IHRyYW5zaXRp
b24gdG8NCj4gPiA+IHJlZmVyZW5jZSBjb3VudCBtYW5hZ2VtZW50IGFmdGVyIHBhZ2UgZHJhaW5p
bmciKSBJJ20gbm90IHN1cmUgdGhlcmUgaXMNCj4gPiA+IGFueSByZWFzb24gdG8gY29udGludWUg
dG8gdXNlIGdldC9wdXRfcGFnZSBvbiBwcC1wYWdlcywgd2UgY2FuIHVzZSB0aGUNCj4gPiA+IG5l
dyBwcC1yZWYgaW5zdGVhZC4NCj4gPiA+IA0KPiA+ID4gSSBkb24ndCBzZWUgYW55IHJlZ3Jlc3Np
b25zIHdpdGggdGhpcyBkaWZmIChuZWVkcyBjbGVhbnVwKSwgYnV0IHlvdXINCj4gPiA+IHRlc3Qg
c2V0dXAgc2VlbXMgbXVjaCBtdWNoIGJldHRlciB0aGFuIG1pbmUgKEkgdGhpbmsgdGhpcyBpcyB0
aGUNCj4gPiA+IHNlY29uZCByZWZmaW5nIGlzc3VlIHlvdSBtYW5hZ2UgdG8gcmVwcm8pOg0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9za2J1ZmZfcmVmLmggYi9pbmNs
dWRlL2xpbnV4L3NrYnVmZl9yZWYuaA0KPiA+ID4gaW5kZXggNGRjZGJlOWZiYzVmLi40YzcyMjI3
ZGNlMWIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZl9yZWYuaA0KPiA+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9za2J1ZmZfcmVmLmgNCj4gPiA+IEBAIC0zMSw3ICszMSw3
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBuYXBpX3BwX2dldF9wYWdlKHN0cnVjdCBwYWdlICpwYWdl
KQ0KPiA+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBza2JfcGFnZV9yZWYoc3RydWN0IHBhZ2UgKnBh
Z2UsIGJvb2wgcmVjeWNsZSkNCj4gPiA+ICB7DQo+ID4gPiAgI2lmZGVmIENPTkZJR19QQUdFX1BP
T0wNCj4gPiA+IC0gICAgICAgaWYgKHJlY3ljbGUgJiYgbmFwaV9wcF9nZXRfcGFnZShwYWdlKSkN
Cj4gPiA+ICsgICAgICAgaWYgKG5hcGlfcHBfZ2V0X3BhZ2UocGFnZSkpDQo+ID4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuOw0KPiA+ID4gICNlbmRpZg0KPiA+ID4gICAgICAgICBnZXRfcGFnZShw
YWdlKTsNCj4gPiA+IEBAIC02OSw3ICs2OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiA+ID4g
IHNrYl9wYWdlX3VucmVmKHN0cnVjdCBwYWdlICpwYWdlLCBib29sIHJlY3ljbGUpDQo+ID4gPiAg
ew0KPiA+ID4gICNpZmRlZiBDT05GSUdfUEFHRV9QT09MDQo+ID4gPiAtICAgICAgIGlmIChyZWN5
Y2xlICYmIG5hcGlfcHBfcHV0X3BhZ2UocGFnZSkpDQo+ID4gPiArICAgICAgIGlmIChuYXBpX3Bw
X3B1dF9wYWdlKHBhZ2UpKQ0KPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ICAj
ZW5kaWYNCj4gPiA+ICAgICAgICAgcHV0X3BhZ2UocGFnZSk7DQo+ID4gPiANCj4gPiA+IA0KPiA+
IFRoaXMgaXMgb3B0aW9uIDIuIEkgdGhvdWdodCB0aGlzIHdvdWxkIGZpeCBldmVyeXRoaW5nLiBC
dXQgSSBqdXN0IHRlc3RlZCBhbmQNCj4gPiBpdCdzIG5vdCB0aGUgY2FzZTogd2UgYXJlIG5vdyBy
ZWFjaGluZyBhIG5lZ2F0aXZlIHBwX3JlZl9jb3VudC7CoA0KPiA+IA0KSSB3YXMgdGlyZWQgYW5k
IGJvdGNoZWQgdGhlIHJldmVydCBvZiB0aGUgY29kZSBpbiB0aGlzIFJGQyB3aGVuIHRlc3Rpbmcu
DQpEcm9wcGluZyB0aGUgcmVjeWNsZSBmbGFnIHdvcmtzIGFzIGV4cGVjdGVkLiBEbyB3ZSBuZWVk
IGFuIFJGQyB2MiBvciBpcyB0aGlzIG5vbg0KUkZDIG1hdGVyaWFsPw0KDQpUaGFua3MsDQpEcmFn
b3MNCg0KPiA+IFNvIHByb2JhYmx5DQo+ID4gc29tZXdoZXJlIGEgcmVndWxhciBwYWdlIHJlZmVy
ZW5jZSBpcyBzdGlsbCBiZWluZyB0YWtlbi4uLg0KPiA+IA0KPiANCj4gSSB3b3VsZCBndWVzcyB0
aGUgbW9zdCBsaWtlbHkgcm9vdCBjYXVzZSBvZiB0aGlzIHdvdWxkIGJlIGEgY2FsbCBzaXRlDQo+
IHRoYXQgZG9lcyBnZXRfcGFnZSgpIGluc3RlYWQgb2Ygc2tiX2ZyYWdfcmVmKCksIHJpZ2h0Pw0K
PiANCj4gVGhlIG90aGVyIHBvc3NpYmlsaXR5IHdvdWxkIGJlIGlmIHNvbWV0aGluZyBsaWtlOg0K
PiANCj4gLSBwYWdlIGlzIG5vdCBwcF9wYWdlDQo+IC0gc2tiX3BhZ2VfcmVmKHBhZ2UpIC8vIG9i
dGFpbnMgYSByZWd1bGFyIHJlZmVyZW5jZS4NCj4gLSBwYWdlIGlzIGNvbnZlcnRlZCB0byBwcF9w
YWdlDQo+IC0gc2tiX3BhZ2VfdW5yZWYocGFnZSkgLy8gZHJvcHMgYSBwcCByZWZlcmVuY2UuDQo+
IA0KPiBCdXQgSSdtIG5vdCBhd2FyZSBvZiBub24tcHAgcGFnZXMgZXZlciBiZWluZyBjb252ZXJ0
ZWQgdG8gcHAgcGFnZXMuDQo+IA0KPiBZb3UgcHJvYmFibHkgZmlndXJlZCB0aGlzIG91dCBhbHJl
YWR5LCBidXQgaWYgeW91IHdvdWxkIGxpa2UgdG8gZGlnDQo+IGZ1cnRoZXIgaW5zdGVhZCBvZiBy
ZXZlcnRpbmcgdGhlIG9mZmVuZGluZyBwYXRjaCwgdGhpcyBkaWZmIHdvdWxkDQo+IHByb2JhYmx5
IGNhdGNoIHRoZSBnZXRfcGFnZSgpIGNhbGxzaXRlLCBubz8gKG9uIG15IHRlc3Qgc2V0dXAgdGhp
cw0KPiBkZWJ1ZyBjb2RlIGRvZXNuJ3QgdHJpZ2dlcikuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+IGluZGV4IDdiMGVlNjQyMjVk
ZS4uYTIyYTY3NmY0YjZiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4gKysr
IGIvaW5jbHVkZS9saW51eC9tbS5oDQo+IEBAIC0xNDczLDggKzE0NzMsMTQgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGZvbGlvX2dldChzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiAgICAgICAgIGZvbGlv
X3JlZl9pbmMoZm9saW8pOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBkZWJ1Z19p
c19wcF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiArew0KPiArICAgICAgIHJldHVybiAocGFn
ZS0+cHBfbWFnaWMgJiB+MHgzVUwpID09IFBQX1NJR05BVFVSRTsNCj4gK30NCj4gKw0KPiAgc3Rh
dGljIGlubGluZSB2b2lkIGdldF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAgew0KPiArICAg
ICAgIFdBUk5fT05fT05DRShkZWJ1Z19pc19wcF9wYWdlKHBhZ2UpKTsNCj4gICAgICAgICBmb2xp
b19nZXQocGFnZV9mb2xpbyhwYWdlKSk7DQo+ICB9DQo+IA0KPiBAQCAtMTU2OSw2ICsxNTc1LDgg
QEAgc3RhdGljIGlubGluZSB2b2lkIHB1dF9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiAgew0K
PiAgICAgICAgIHN0cnVjdCBmb2xpbyAqZm9saW8gPSBwYWdlX2ZvbGlvKHBhZ2UpOw0KPiANCj4g
KyAgICAgICBXQVJOX09OX09OQ0UoZGVidWdfaXNfcHBfcGFnZShwYWdlKSk7DQo+ICsNCj4gICAg
ICAgICAvKg0KPiAgICAgICAgICAqIEZvciBzb21lIGRldm1hcCBtYW5hZ2VkIHBhZ2VzIHdlIG5l
ZWQgdG8gY2F0Y2ggcmVmY291bnQgdHJhbnNpdGlvbg0KPiAgICAgICAgICAqIGZyb20gMiB0byAx
Og0KPiANCg0K

