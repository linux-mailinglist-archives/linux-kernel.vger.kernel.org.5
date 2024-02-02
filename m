Return-Path: <linux-kernel+bounces-50343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DE8477B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB9E28C513
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA5151445;
	Fri,  2 Feb 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IDxq54+n"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2013.outbound.protection.outlook.com [40.92.98.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69314E2FE;
	Fri,  2 Feb 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899026; cv=fail; b=numUkZEDojonK4UusgSOF2DWI+FsUwZGPfE7eammP2pPZDHYAKU/QqQRAX/PMtvdymyfYlJGOiDl0zYnd5P481zjX/YyOHcfFSvx7VB8PMlJEOkKpiHiCQTp7qEnnQPH4gD1KJx3Tc4wDNaevtbTUIMwV7veNbtN24xKYvXbb9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899026; c=relaxed/simple;
	bh=1vSg7V0slaTRs1ukVxYasSpOQLE2v6JowED+BGitKRE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fW6JlFTgoMIxadXuoBhQKn2E/+IPFuWeIFVUzbsfszquG1/yGjJ+pWU3Yz36zKSVOjcujvcjCMwjN3GSDFQ8MJKkjPi77OWu1X8S8/ln3qY1gZeT7dlgeQQfcvyQywJbZGcPpwQVu6J54a4kXD+Bqrcg7nIN8uPvixGhTaCjFRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IDxq54+n; arc=fail smtp.client-ip=40.92.98.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WojvvsCMA1jAIRJj8YupU0FA0xzkhgJlmfdo4X0RdWOiIK986ISS9LOTTJu7JL7RJuNVfHh9Q7bazKJmekQtFkiyccPzXZHfOpfo+RlLjsLEzKjOZ3t4e5aKJ03n6eC4wQy91L+VgdcBIwWiBh9oR+SVVHEZ8X/SMDMOaXRfZeFR5u8J+kEnJ/g+UYNRHRNesBsQdbCQekcncKYpVgllDTcz0Z3M85hh70QBfkyVMLTbby8tQgSpBueRTvSOhohEjVAWFYSkpCiy8TVtKTMcscwjDzxbrSi5Eg9S65FKoTJ1KgQagNRCqxtNZCW7WQ+7Oa/uAyz8y6WrUIdfg4yKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO641Ge5s6tOIwOiOnxPFkCRRQ8/Ir3FgNR6xCB5EU0=;
 b=WWQrUKBTMudgi40KbpJ/gQf10p3onsKFF973ba9DrcLGJHob+DiGlTTANDgq/atbxppAzEkFFbBCZrLZHawO/tabIsLDZOj+bJcvdU81zW6DdG3bGZ9D1zz7qXxNvyJClO1T/gJZMb8SZdM4oWYvo3Ur6mGPP92aIBc52DF8KcyNCn4K0oxRkkyNHFNdt+NSIZ9f9pF/nhpIxkYc1nW/APWb4VBAbkRBFOzIxUM2pgSOtR+rDlFu5GCYdH5GYAX766fz9qkamDN8Vlm6gPk5oT9dbzaFQgtHEfZn1ACdFPLCsJQR9jU2Xy1V+knBRzz4xWxAp9f995ihzF2x5EGMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO641Ge5s6tOIwOiOnxPFkCRRQ8/Ir3FgNR6xCB5EU0=;
 b=IDxq54+nSHXFHo7ZJTFyXuVJkCf7PGeQOFEOX3TgJCv2sObdtAThgKf0p1IoRPvpIfjJJ3+GaFZWweqSBjb4qeCVVEbefSTDmwwRMMCXxeEmalN0aAYWW6EE6HcNmbcMGQslkfDqUOtmenMNg4LqzCTd0RlsojzMLCIZ+jVGd/Y2zU93W0n1qX9lmZWPJTRZ/M5OpOlAc3D/xhT1swyGiXcgJkzkYoAYyQLE1QlJpxPe/Ydg3xb4yScATp10ckH4Z/pByrmH1JsjLJiuyCDqhMi0bZzJ7/Q2XKM9e8mF8ZzEIC+PLOMrsZQERpQQsDS2cfildtPK2K8JJ2qbBU+qDw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYVP286MB3167.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 18:37:01 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::574a:19b5:4c79:4092]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::574a:19b5:4c79:4092%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 18:37:01 +0000
Message-ID:
 <TY3P286MB261189680875E6B1FE428DE098422@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Sat, 3 Feb 2024 02:36:55 +0800
User-Agent: Mozilla Thunderbird
From: Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v1] mmc: sdhci: fix max req size based on spec
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wiagn233@outlook.com
References: <TY3P286MB2611D07641D842BD373FD3A8987F2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------u52lex32qQRVi0SiL3w0Pk4W"
X-TMN: [vXs8Qak0uMs/TyVIzGoDJPzcNDNQ70DwMFBfirsZN1spcx+rXNO8xcH1jeT36BG9]
X-ClientProxiedBy: TY2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:404:42::34) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <486a0351-0bb7-4be1-b15b-59d8f1aeba4e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYVP286MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: ff98d6b2-52d3-45e1-0578-08dc241df00c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WIfgRnC2fIBgqtkjf4Wg0sE836yMfyYMRFOygjAaiAbi2btsuCPZ4EDwMY09I9noDZ/HKLI6fGVQYk+tQ/KF3FH5EsnNj536MfGkGPCvzvlkc5kZjWd93xmQCBKVflqrTGREKdmqJMsJHH+wgGKJ9Cnvgzxqs36t6EgZROfICeNQmCGNXVM/XaCCqKzG3ZYMeaujqSSnbSIS+qcHxzCyLzLguTu6nrKb6bGyhrcqltFYnWol9Aj7dXkMK+dade8UCFsBg6XtcyE5iBiyL+gjVYrKfI5FeA4EMvndPqrFuoi/sms71KtSIq41gwGhN2N2ClaYSltvcqDQW+c53IlQ6XodXZUZcseEDrJpHl7u9Goh+vme3Ld4YtIdV7bV0tpxXuq1DX8IHVDpLRtXbf7G9aQV7LQNa+G+ZoApHCMEaVCj+yGUDtvL5f4Az/TGWlUc/iw89481v9ZnnXUvBYAo99v9IfXOgWuJ2EYNUql8HHBLcOVRlCs+vkqbTJ6Xn0Oqzt+WR+YoYHHRvRE7jeTs77WdKU1xfwRuIm1sl5anqYNappHlxoWB5qSuvGh7QeG2oFQPgJGq9Hr7q2jgC/eTypuC0DGGPmYLuR9D3A3j6nPPj7gktAV9u5eMBBYnVUm5fo+hTGzcy1jliR1XAt6BQj8XRWzBJwMa3QBHOuyDUj4MecnjRzENHml7dh4VKbyqxcAzZplAOtlsp1VOFfkxKw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enRDYTJtaERnTTEzWklPaHd6bTBmemJZK3hibUs2UEUzL214bTdjTC9pYnE1?=
 =?utf-8?B?RnhIME9KczlBN1lPekpITXVaSnB1elh1TkRsL3FjTEwxWFAvbWFUUTBQM0Q4?=
 =?utf-8?B?YmVPYUZVaFlqSFhENmozc3NyMG82cjBieGMwT2I0dXlIL0g4Tis1azFEUFhp?=
 =?utf-8?B?V011QWd3aVcrMlQ2OWgxMlVYZnBzZGxVZXpvQWJyVkxFb3BCMlpMaW5sVEpE?=
 =?utf-8?B?dWVhVjdLMFJ2TEV4TFJrdFNKUFcwd1ZqTWcrWGJDWHY3MllCWnpkZkFLK2kz?=
 =?utf-8?B?ajAwM1hpNURYUEtMZnNTWmRlUUNMbXc2ZHoxakRMeE82QlBwVTBnaW0ycnBG?=
 =?utf-8?B?VVAxeXN2Z01uUjh3UTNsVjhkWFFIU0JobE5DZmJCcGdHYWJkTURvMm1oMXRZ?=
 =?utf-8?B?Mzh3bUNNY1VCc2l2eFhqWDhlNmt1U051K3NEdUFXT3U1cUFQWVA3Q3I5bDVt?=
 =?utf-8?B?VGtPMmV1Nk5CZFNhTDBhUit5QWx3dVRxZ1NsWkU3UzRzS2w3VU9NZW10c25N?=
 =?utf-8?B?dGkrSG1Ja3NzYVFHMDU1SlIyMUlUczMvaWJOZTF0dWNoNzNWZ0FKTnIxanJo?=
 =?utf-8?B?dlJCcmxpM1BNYU5tRFQ4UWFndkwxeTVYZXRDLzgzekw2OG1mQ0pMbHBTK3Q4?=
 =?utf-8?B?UjBHeEh4YytnUFJ0Zm1WcnVRdG1kRDA2eURPOUQxNzVsbm5jL0Y5Z1M5T0V6?=
 =?utf-8?B?ckhDQzFKUWxyMjBtSS9HdkEwSnJXV21UZXlJUWVJalQvRFVPYnpoVjl2dnV3?=
 =?utf-8?B?a21BdURNRVJBQm1SVWxkalEwcjZ6cVVXSWEzMTAxdDNsMG9UNUZaU2RZL0lj?=
 =?utf-8?B?SFhyYXlIZ3N5NlpkMmtUV2xLQXRsb3Y3M3gxaHB5aFRkN0lvR1JwcU9uWnl4?=
 =?utf-8?B?ZE1OR0RSNHhTQkVtWXhqbzE5TjBlVmhmMjQ3aitUeEhkamtVd0pQVFNzbUs3?=
 =?utf-8?B?SDVPSUVHcE1aR244eEtZdjNMTDZraS9DK2RXSXhkZ2Vxc1ZyWC9hOWhRVW5S?=
 =?utf-8?B?YTBLWnAyNmJ1SXBYTG5OU3ltUHVIbjZtd3pkZTY3ak9IdS95eDEyMjZNcGo0?=
 =?utf-8?B?K2VPcHNMQlZ2NHlBVkwweWF6VVEzV1czOUFXL1VpQkVNREhLMFJjSUlHQ3BV?=
 =?utf-8?B?NUpRMGRUWmphUzVTaUhSZW9EaWh4aDNhWUxnbklaNVJHS2d6NHkvMjNFaG9O?=
 =?utf-8?B?OU1wb1VneDJJOUQzd1NsOXN6cUtNNXpSMDNQVDQ0NVRZYzMxWUVQNE95NVhK?=
 =?utf-8?B?TTdLeWNwaStzbDZrdFhrM0FLN1hkVDhhT200OG1xcFo1cTRFZ2VuTGVaM29a?=
 =?utf-8?B?SEZvc2VQa2JLT0hLdG1IRzNHcTd5aVFDRDdjbGFyMGlVK2tJU1BIUTZqNExn?=
 =?utf-8?B?cGRZa1p2TE1WVERNanpaZWJWT0hOejEvUlN0RXhKUUNnK2FOMHRVNmt4Z0N1?=
 =?utf-8?B?ZTA3ZlAzK2o4OEFCVEpLMmJVdHpSSUtnQnV4OFRwVUowc2VJMDRJQnplRWFm?=
 =?utf-8?B?SmFkaVBaVk0vOFNPODE5aCtqRGF4NElpK1ZaSERNRWtMbk5JWVphc2dlL0pB?=
 =?utf-8?B?VjhXVm1ZUk4wWDA1d1J6NlVMZzlMdVR1Szg0MXdrQmxQL1FXcGljR1NwNWFz?=
 =?utf-8?B?R3hGUFZ6dHFEM0VEL0R6L0RzZVhlSVhLdCsvUXdSUU5iay9zYkh5dVU0NmNI?=
 =?utf-8?B?SyswZHowWG5hbi9tTlZkaUYyRnhaYmxiNGNQRWlTNG80R2dWRnBsR0NsSWJy?=
 =?utf-8?Q?YFPwrdl/ddUskocolA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff98d6b2-52d3-45e1-0578-08dc241df00c
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 18:36:59.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3167

--------------u52lex32qQRVi0SiL3w0Pk4W
Content-Type: multipart/mixed; boundary="------------pFrYLPppJCyMGj10LA5cak3V";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wiagn233@outlook.com
Message-ID: <486a0351-0bb7-4be1-b15b-59d8f1aeba4e@outlook.com>
Subject: Re: [PATCH v1] mmc: sdhci: fix max req size based on spec
References: <TY3P286MB2611D07641D842BD373FD3A8987F2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com>
In-Reply-To: <fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com>

--------------pFrYLPppJCyMGj10LA5cak3V
Content-Type: multipart/mixed; boundary="------------3J69x4CgmahBgQxm3wGqmxnG"

--------------3J69x4CgmahBgQxm3wGqmxnG
Content-Type: multipart/alternative;
 boundary="------------iFnRZ7hh40SzQVOx8XaB0MA8"

--------------iFnRZ7hh40SzQVOx8XaB0MA8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gQWRyaWFuLA0KDQpTb3JyeSBmb3IgbXkgbGF0ZSByZXBseS4gSSB3YXMgcXVpdGUg
YnVzeSB0aGlzIHdlZWsuDQoNCg0K5ZyoIDIwMjQvMS8zMCAxNDo1NCwgQWRyaWFuIEh1bnRl
ciDlhpnpgZM6DQo+IE9uIDI4LzAxLzI0IDEyOjAxLCBTaGVuZ3l1IFF1IHdyb3RlOg0KPj4g
Rm9yIGFsbW9zdCAyIGRlY2FkZXMsIHRoZSBtYXggYWxsb3dlZCByZXF1ZXN0cyB3ZXJlIGxp
bWl0ZWQgdG8gNTEyS0INCj4+IGJlY2F1c2Ugb2YgU0RNQSdzIG1heCA1MTJLaUIgYm91bmRh
cnkgbGltaXQuDQo+IEl0IGlzIG5vdCBsaW1pdGVkIGJ5IFNETUEuICBJdCBpcyBsaW1pdGVk
IGJ5IGNob2ljZS4NCj4NCj4+IEFETUEyIGFuZCBBRE1BMyBkbyBub3QgaGF2ZSBzdWNoIGxp
bWl0IGFuZCB3ZXJlIGVmZmVjdGl2ZWx5IG1hZGUgc28gYW55DQo+PiBraW5kIG9mIGJsb2Nr
IGNvdW50IHdvdWxkIG5vdCBpbXBvc2UgaW50ZXJydXB0IGFuZCBtYW5hZ2luZyBzdHJlc3Mg
dG8gdGhlDQo+PiBob3N0Lg0KPiBUaGUgbWFpbiBiZW5lZml0IG9mIEFETUEgaXMgdGhhdCBp
dCBwcm92aWRlcyBzY2F0dGVyL2dhdGhlciBhbmQgc28gZG9lcw0KPiBub3QgbmVlZCBhIGJv
dW5jZSBidWZmZXIuDQo+DQo+PiBCeSBsaW1pdGluZyB0aGF0IHRvIDUxMktpQiwgaXQgZWZm
ZWN0aXZlbHkgZG93bmdyYWRlcyB0aGVzZSBETUEgbW9kZXMgdG8NCj4+IFNETUEuDQo+IE5v
dCByZWFsbHkuDQpTbyBtYXliZSBJIGNvdWxkIGp1c3QgZGVsZXRlIHRoaXMgcGFydCBvZiB0
aGUgY29tbWl0IG1lc3NhZ2U/DQo+PiBGaXggdGhhdCBieSBhY3R1YWxseSBmb2xsb3dpbmcg
dGhlIHNwZWM6DQo+PiBXaGVuIEFETUEgaXMgc2VsZWN0ZWQgdHVuaW5nIG1vZGUgaXMgYWR2
aXNlZC4gT24gbGVzc2VyIG1vZGVzLCA0TWlCDQo+PiB0cmFuc2ZlciBpcyBzZWxlY3RlZCBh
cyBtYXgsIHNvIHJlLXR1bmluZyBpZiB0aW1lciB0cmlnZ2VyIG9yIGlmIHJlcXVlc3RlZA0K
Pj4gYnkgaG9zdCBpbnRlcnJ1cHQsIGNhbiBiZSBkb25lIGluIHRpbWUuIE90aGVyd2lzZSwg
dGhlIG9ubHkgbGltaXQgaXMgdGhlDQo+PiB2YXJpYWJsZSBzaXplIG9mIHR5cGVzIHVzZWQu
IEluIHRoaXMgaW1wbGVtZW50YXRpb24sIDE2TWlCIGlzIHVzZWQgYXMNCj4+IG1heGltdW0g
c2luY2UgdGVzdHMgc2hvd2VkIHRoYXQgYWZ0ZXIgdGhhdCBwb2ludCwgdGhlcmUgYXJlIGRp
bWluaXNoaW5nDQo+PiByZXR1cm5zLg0KPj4NCj4+IEFsc28gMTZNaUIgaW4gd29yc3QgY2Fz
ZSBzY2VuYXJpb3MsIHdoZW4gY2FyZCBpcyBlTU1DIGFuZCBpdHMgbWF4IHNwZWVkIGlzDQo+
PiBhIGdlbmVyb3VzIDM1ME1pQi9zLCB3aWxsIGdlbmVyYXRlIGludGVycnVwdHMgZXZlcnkg
NDVtcyBvbiBodWdlIGRhdGENCj4+IHRyYW5zZmVycy4NCj4+DQo+PiBBIG5ldyBgYWRtYV9n
ZXRfcmVxX2xpbWl0YCBzZGhjaSBob3N0IGZ1bmN0aW9uIHdhcyBhbHNvIGludHJvZHVjZWQs
IHRvIGxldA0KPj4gdmVuZG9ycyBvdmVycmlkZSBpbXBvc2VkIGxpbWl0cyBieSB0aGUgZ2Vu
ZXJpYyBpbXBsZW1lbnRhdGlvbiBpZiBuZWVkZWQuDQo+IE5vdCBpbiB0aGlzIHBhdGNoPw0K
WWVzLCB0aGlzIHBhcnQgaXMgcmVtb3ZlZCBmcm9tIG15IHZlcnNpb24gb2YgcGF0Y2gsIG9y
aWdpbmFsIHZlcnNpb24gaGFzIGENCiJhZG1hX2dldF9yZXFfbGltaXQiIGhvc3QgZnVuY3Rp
b24gYW5kIGltcGxlbWVudHMgaXQgdG8gdGVncmEuIEFuZCB0aGVyZSdzDQphbm90aGVyIHBh
dGNoIGFkZGluZyBhIG5ldyBkZXZpY2UgdHJlZSBpdGVtIHRvIHRlZ3JhIGNoaXBzIHRvIHNl
dCB0aGUgbGltaXQNCmZyb20gZGV2aWNlIHRyZWUgY29uZmlnLg0KPj4gRm9yIGV4YW1wbGUs
IG9uIGxvY2FsIHRlc3RzIHdpdGggcmlnb3JvdXMgQ1BVL0dQVSBidXJuLWluIHRlc3RzIGFu
ZCBhYnJ1cHQNCj4+IGN1dC1vZmZzIHRvIGdlbmVyYXRlIGh1Z2UgdGVtcGVyYXR1cmUgY2hh
bmdlcyAodXB3YXJkcy9kb3dud2FyZHMpIHRvIHRoZQ0KPj4gY2FyZCwgdGVzdGVkIGhvc3Qg
d2FzIGZpbmUgdXAgdG8gMTI4TUIvcyB0cmFuc2ZlcnMgb24gc2xvdyBjYXJkcyB0aGF0IHVz
ZWQNCj4+IFNEUjEwNCBidXMgdGltaW5nIHdpdGhvdXQgcmUtdHVuaW5nLg0KPj4gSW4gdGhh
dCBjYXNlIHRoZSA0TWlCIGxpbWl0IHdhcyBvdmVycmlkZGVuIHdpdGggYSBtb3JlIHRoYW4g
c2FmZSA4TWlCDQo+PiB2YWx1ZS4NCj4+DQo+PiBJbiBhbGwgdGVzdGluZyBjYXNlcyBhbmQg
Ym9hcmRzLCB0aGF0IGNoYW5nZSBicm91Z2h0IHRoZSBmb2xsb3dpbmc6DQo+ICJhbGwgdGVz
dGluZyBjYXNlcyBhbmQgYm9hcmRzIiBkb2Vzbid0IG1lYW4gbXVjaCB0byBhbnlvbmUgZWxz
ZS4gWW91DQo+IG5lZWQgdG8gYmUgbW9yZSBleHBsaWNpdC4NCj4NCj4+IERlcGVuZGluZyBv
biBidXMgdGltaW5nIGFuZCBlTU1DL1NEIHNwZWNzOg0KPj4gKiBNYXggUmVhZCB0aHJvdWdo
cHV0IGluY3JlYXNlZCBieSAyLTIwJQ0KPj4gKiBNYXggV3JpdGUgdGhyb3VnaHB1dCBpbmNy
ZWFzZWQgYnkgNTAtMjAwJQ0KPj4gRGVwZW5kaW5nIG9uIENQVSBmcmVxdWVuY3kgYW5kIHRy
YW5zZmVyIHNpemVzOg0KPj4gKiBSZWR1Y2VkIG1tY3FkIGNwdSBjb3JlIHVzYWdlIGJ5IDQt
NTAlDQo+IFRoZSBtYWluIGlzc3VlIHdpdGggaW5jcmVhc2luZyB0aGUgcmVxdWVzdCBzaXpl
IGlzIHRoYXQgaXQgaW50cm9kdWNlcyBtdWNoDQo+IG1vcmUgbGF0ZW5jeSBmb3Igc3luY2hy
b25vdXMgcmVhZHMgZS5nLiBhIHN5bmNocm9ub3VzIHJlYWQgbWF5IGhhdmUgdG8gd2FpdA0K
PiBmb3IgYSBsYXJnZSB3cml0ZSBvcGVyYXRpb24uICBHZW5lcmFsbHksIHRoYXQgaXMgcHJv
YmFibHkgYSBzaG93LXN0b3BwZXINCj4gZm9yIHVuY29uZGl0aW9uYWxseSBpbmNyZWFzaW5n
IHRoZSBtYXhpbXVtIHJlcXVlc3Qgc2l6ZS4NCj4+IEFib3ZlIGNvbW1pdCBtZXNzYWdlIGNv
bWVzIGZyb20gb3JpZ2luYWwgYXV0aG9yIHdob3NlIGlkIGlzIENUQ2Flciwgd2l0aA0KPj4g
U29CIGVtYWlsIGFkZHJlc3NjdGNhZXJAZ21haWwuY29tLiBJIHRyaWVkIHRvIGNvbnRhY3Qg
d2l0aCB0aGUgYXV0aG9yIDENCj4+IG1vbnRoIGFnbyB0byBhc2sgZm9yIHNlbmRpbmcgaXQg
dG8gbWFpbmxpbmUgb3IgZ2V0IHRoZSBhdXRob3JpdHkgdG8gc3VibWl0DQo+PiBieSBteXNl
bGYsIGJ1dCBJIGRpZG4ndCBnZXQgYW55IHJlcGx5LCBzbyBJIGRlY2lkZWQgdG8gc2VuZCB0
aGlzIHBhdGNoIGJ5DQo+PiBteXNlbGYuIE9yaWdpbmFsIGNvbW1pdCBpcyBoZXJlWzFdLg0K
PiBPaywgc28gaXQgaXMgbm90IHlvdXIgcGF0Y2ggYW5kIHRoZSBvcmlnaW5hbCBhdXRob3Ig
aXMgb3V0IG9mIHRvdWNoLg0KPg0KPiBJcyB0aGVyZSBhIHBhcnRpY3VsYXIgcmVhc29uIHlv
dSB3YW50ZWQgdGhpcyBwYXRjaD8NCj4NCj4+IFRoZSBhdXRob3IgYWxzbyBoYXMgYSBwYXRj
aFsyXSBhcHBsaWVkIGFmdGVyIHRoaXMgcGF0Y2gsIHdoaWNoIG92ZXJyaWRlcw0KPj4gYWRt
YSBzaXplIG9uIHRlZ3JhIGRldmljZSBmcm9tIGRldmljZSB0cmVlIHByb3BlcnR5LiBCdXQg
SSBkb24ndCBoYXZlIGENCj4+IHRlZ3JhIGRldmljZSB0byBhY3R1YWxseSB0ZXN0IHRoYXQs
IHNvIGl0IGlzIG5vdCBzZW50LCBhbmQNCj4+IGFkbWFfZ2V0X3JlcV9saW1pdCBwYXJ0IGlz
IG5vdCBpbmNsdWRlZCBpbiB0aGlzIHZlcnNpb24gb2YgcGF0Y2guDQo+IERvZXMgdGhhdCBt
ZWFuIHlvdSBoYXZlbid0IHRlc3RlZCB0aGlzIHBhdGNoIHlvdXJzZWxmIGF0IGFsbD8NClll
cywgSSBoYXZlIHRlc3RlZCB0aGF0IG9uIG15IFJhc3BiZXJyeSBQaSA1YiBhbmQgU3RhcmZp
dmUgVmlzaW9uZml2ZSAyLiBPbg0KcGk1QiwgSXQgYnJpbmdzIGFib3V0IDIzJSBzcGVlZCBp
bmNyZWFzZSBpbiBzZXF1ZW50aWFsIHdyaXRlLiBTbyB0aGVyZSdzIGENCmh1Z2UgaW1wcm92
ZW1lbnQgaW4gaW1wcm92aW5nIHdyaXRlIHBlcmZvcm1hbmNlIHRoYXQgSSB0aGluayB0aGF0
J3MgZW5vdWdoDQp0byBzZW5kIHRoaXMgcGF0Y2ggdG8gdXBzdHJlYW0uIE9uIFZpc2lvbmZp
dmUgMiwgcGVyZm9ybWFuY2UgaXMgbWFpbmx5DQpsaW1pdGVkIGJ5IGxvdyBtbWMgY2xvY2sg
YW5kIGNhbm5vdCBiZSBpbmNyZWFzZWQsIHNvIEkgY2FuJ3Qgc2VlIG9idmlvdXMNCmltcHJv
dmVtZW50IG9uIHRoYXQuDQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0KPj4gWzFdOmh0
dHBzOi8vZ2l0aHViLmNvbS9DVENhZXIvc3dpdGNoLWw0dC1rZXJuZWwtNC45L2NvbW1pdC9m
YTg2ZWJiZDU2ZDMwYjNiNmFmMjZlMWQxYzNmOWM0MTFhNDdlOThlDQo+PiBbMl06aHR0cHM6
Ly9naXRodWIuY29tL0NUQ2Flci9zd2l0Y2gtbDR0LWtlcm5lbC00LjkvY29tbWl0LzM4NWY5
MzM1YjlhNjBjZTQ3MWFjMzI5MWYyMDJiMTMyNjIxMmJlM2UNCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBTaGVuZ3l1IFF1PHdpYWduMjMzQG91dGxvb2suY29tPg0KPj4gLS0tDQo+PiAgIGRy
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8IDE3ICsrKysrKysrKysrKy0tLS0tDQo+PiAgIGRy
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCB8ICA0ICsrLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMN
Cj4+IGluZGV4IGM3OWY3MzQ1OTkxNS4uZjU0NmI2NzVjN2I5IDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jDQo+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMNCj4+IEBAIC0xMDgxLDcgKzEwODEsNyBAQCBzdGF0aWMgdm9pZCBzZGhjaV9pbml0
aWFsaXplX2RhdGEoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsDQo+PiAgIAlXQVJOX09OKGhv
c3QtPmRhdGEpOw0KPj4gICANCj4+ICAgCS8qIFNhbml0eSBjaGVja3MgKi8NCj4+IC0JQlVH
X09OKGRhdGEtPmJsa3N6ICogZGF0YS0+YmxvY2tzID4gNTI0Mjg4KTsNCj4+ICsJQlVHX09O
KGRhdGEtPmJsa3N6ICogZGF0YS0+YmxvY2tzID4gaG9zdC0+bW1jLT5tYXhfcmVxX3NpemUp
Ow0KPj4gICAJQlVHX09OKGRhdGEtPmJsa3N6ID4gaG9zdC0+bW1jLT5tYXhfYmxrX3NpemUp
Ow0KPj4gICAJQlVHX09OKGRhdGEtPmJsb2NrcyA+IDY1NTM1KTsNCj4+ICAgDQo+PiBAQCAt
NDY5MCwxMSArNDY5MCwxOCBAQCBpbnQgc2RoY2lfc2V0dXBfaG9zdChzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCkNCj4+ICAgDQo+PiAgIAkvKg0KPj4gICAJICogTWF4aW11bSBudW1iZXIg
b2Ygc2VjdG9ycyBpbiBvbmUgdHJhbnNmZXIuIExpbWl0ZWQgYnkgU0RNQSBib3VuZGFyeQ0K
Pj4gLQkgKiBzaXplICg1MTJLaUIpLiBOb3RlIHNvbWUgdHVuaW5nIG1vZGVzIGltcG9zZSBh
IDRNaUIgbGltaXQsIGJ1dCB0aGlzDQo+PiAtCSAqIGlzIGxlc3MgYW55d2F5Lg0KPj4gKwkg
KiBzaXplIGFuZCBieSB0dW5pbmcgbW9kZXMgb24gQURNQS4gT24gdHVuaW5nIG1vZGUgMyAx
Nk1pQiBpcyBtb3JlIHRoYW4NCj4+ICsJICogZW5vdWdoIHRvIGNvdmVyIGJpZyBkYXRhIHRy
YW5zZmVycy4NCj4+ICAgCSAqLw0KPj4gLQltbWMtPm1heF9yZXFfc2l6ZSA9IDUyNDI4ODsN
Cj4+IC0NCj4+ICsJaWYgKGhvc3QtPmZsYWdzICYgU0RIQ0lfVVNFX0FETUEpIHsNCj4+ICsJ
CWlmIChob3N0LT50dW5pbmdfbW9kZSAhPSBTREhDSV9UVU5JTkdfTU9ERV8zKQ0KPj4gKwkJ
CW1tYy0+bWF4X3JlcV9zaXplID0gU1pfNE07DQo+PiArCQllbHNlDQo+PiArCQkJbW1jLT5t
YXhfcmVxX3NpemUgPSBTWl8xNk07DQo+PiArCX0gZWxzZSB7DQo+PiArCQkvKiBPbiBQSU8v
U0RNQSB1c2UgU0RNQSBib3VuZGFyeSBzaXplICg1MTJLaUIpLiAqLw0KPj4gKwkJbW1jLT5t
YXhfcmVxX3NpemUgPSBTWl81MTJLOw0KPj4gKwl9DQo+PiAgIAkvKg0KPj4gICAJICogTWF4
aW11bSBudW1iZXIgb2Ygc2VnbWVudHMuIERlcGVuZHMgb24gaWYgdGhlIGhhcmR3YXJlDQo+
PiAgIAkgKiBjYW4gZG8gc2NhdHRlci9nYXRoZXIgb3Igbm90Lg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaA0K
Pj4gaW5kZXggYTIwODY0ZmMwNjQxLi45ODI1MmM0MjdmZWIgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLmgNCj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuaA0KPj4gQEAgLTM0NiwxMSArMzQ2LDExIEBAIHN0cnVjdCBzZGhjaV9hZG1hMl82NF9k
ZXNjIHsNCj4+ICAgI2RlZmluZSBBRE1BMl9FTkQJCTB4Mg0KPj4gICANCj4+ICAgLyoNCj4+
IC0gKiBNYXhpbXVtIHNlZ21lbnRzIGFzc3VtaW5nIGEgNTEyS2lCIG1heGltdW0gcmVxdWlz
aXRpb24gc2l6ZSBhbmQgYSBtaW5pbXVtDQo+PiArICogTWF4aW11bSBzZWdtZW50cyBhc3N1
bWluZyBhIDE2TWlCIG1heGltdW0gcmVxdWlzaXRpb24gc2l6ZSBhbmQgYSBtaW5pbXVtDQo+
PiAgICAqIDRLaUIgcGFnZSBzaXplLiBOb3RlIHRoaXMgYWxzbyBhbGxvd3MgZW5vdWdoIGZv
ciBtdWx0aXBsZSBkZXNjcmlwdG9ycyBpbg0KPj4gICAgKiBjYXNlIG9mIFBBR0VfU0laRSA+
PSA2NEtpQi4NCj4+ICAgICovDQo+PiAtI2RlZmluZSBTREhDSV9NQVhfU0VHUwkJMTI4DQo+
PiArI2RlZmluZSBTREhDSV9NQVhfU0VHUwkJNDA5Ng0KPj4gICANCj4+ICAgLyogQWxsb3cg
Zm9yIGEgY29tbWFuZCByZXF1ZXN0IGFuZCBhIGRhdGEgcmVxdWVzdCBhdCB0aGUgc2FtZSB0
aW1lICovDQo+PiAgICNkZWZpbmUgU0RIQ0lfTUFYX01SUVMJCTINCg==
--------------iFnRZ7hh40SzQVOx8XaB0MA8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <font face=3D"monospace">Hello Adrian,</font><br>
    <p><font face=3D"monospace">Sorry for my late reply. I was quite busy=

        this week.<br>
      </font></p>
    <p><font face=3D"monospace"><br>
      </font></p>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2024/1/30 14:54, Adrian Hunt=
er =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">On 28/01/24 12:01, Shengyu Q=
u wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">For almost 2 decades, the =
max allowed requests were limited to 512KB
because of SDMA's max 512KiB boundary limit.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">It is not limited by SDMA.  =
It is limited by choice.

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">ADMA2 and ADMA3 do not hav=
e such limit and were effectively made so any
kind of block count would not impose interrupt and managing stress to the=

host.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">The main benefit of ADMA is =
that it provides scatter/gather and so does
not need a bounce buffer.

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">By limiting that to 512KiB=
, it effectively downgrades these DMA modes to
SDMA.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">Not really.
</pre>
    </blockquote>
    <font face=3D"monospace">So maybe I could just delete this part of th=
e
      commit message?</font><br>
    <blockquote type=3D"cite"
      cite=3D"mid:fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Fix that by actually follo=
wing the spec:
When ADMA is selected tuning mode is advised. On lesser modes, 4MiB
transfer is selected as max, so re-tuning if timer trigger or if requeste=
d
by host interrupt, can be done in time. Otherwise, the only limit is the
variable size of types used. In this implementation, 16MiB is used as
maximum since tests showed that after that point, there are diminishing
returns.

Also 16MiB in worst case scenarios, when card is eMMC and its max speed i=
s
a generous 350MiB/s, will generate interrupts every 45ms on huge data
transfers.

A new `adma_get_req_limit` sdhci host function was also introduced, to le=
t
vendors override imposed limits by the generic implementation if needed.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">Not in this patch?</pre>
    </blockquote>
    <font face=3D"monospace">Yes, this part is removed from my version of=

      patch, original version has a</font><br>
    <font face=3D"monospace">"<span style=3D"white-space: pre-wrap">adma_=
get_req_limit<font
      style=3D"white-space: normal;">" host function and implements it to=
 tegra. And there's</font></span></font><br>
    <font face=3D"monospace"><span style=3D"white-space: pre-wrap"><font
      style=3D"white-space: normal;">another patch adding a new device tr=
ee item to tegra chips to set the limit</font></span></font><br>
    <font face=3D"monospace"><span style=3D"white-space: pre-wrap"><font
      style=3D"white-space: normal;">from device tree config.</font></spa=
n></font>
    <blockquote type=3D"cite"
      cite=3D"mid:fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">For example, on local test=
s with rigorous CPU/GPU burn-in tests and abrupt
cut-offs to generate huge temperature changes (upwards/downwards) to the
card, tested host was fine up to 128MB/s transfers on slow cards that use=
d
SDR104 bus timing without re-tuning.
In that case the 4MiB limit was overridden with a more than safe 8MiB
value.

In all testing cases and boards, that change brought the following:
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">"all testing cases and board=
s" doesn't mean much to anyone else. You
need to be more explicit.

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Depending on bus timing an=
d eMMC/SD specs:
* Max Read throughput increased by 2-20%
* Max Write throughput increased by 50-200%
Depending on CPU frequency and transfer sizes:
* Reduced mmcqd cpu core usage by 4-50%
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">The main issue with increasi=
ng the request size is that it introduces much
more latency for synchronous reads e.g. a synchronous read may have to wa=
it
for a large write operation.  Generally, that is probably a show-stopper
for unconditionally increasing the maximum request size.
</pre>
    </blockquote>
    <blockquote type=3D"cite"
      cite=3D"mid:fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Above commit message comes=
 from original author whose id is CTCaer, with
SoB email address <a
        class=3D"moz-txt-link-abbreviated moz-txt-link-freetext"
        href=3D"mailto:ctcaer@gmail.com">ctcaer@gmail.com</a>. I tried to=
 contact with the author 1
month ago to ask for sending it to mainline or get the authority to submi=
t
by myself, but I didn't get any reply, so I decided to send this patch by=

myself. Original commit is here[1].
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">Ok, so it is not your patch =
and the original author is out of touch.

Is there a particular reason you wanted this patch?

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">The author also has a patc=
h[2] applied after this patch, which overrides
adma size on tegra device from device tree property. But I don't have a
tegra device to actually test that, so it is not sent, and
adma_get_req_limit part is not included in this version of patch.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">Does that mean you haven't t=
ested this patch yourself at all?</pre>
    </blockquote>
    <font face=3D"monospace">Yes, I have tested that on my Raspberry Pi 5=
b
      and Starfive Visionfive 2. On</font><br>
    <font face=3D"monospace">pi5B, It brings about </font><font
      face=3D"monospace">23% speed increase in sequential write. So
      there's a</font><br>
    <font face=3D"monospace">huge </font><font face=3D"monospace">improve=
ment
      in improving write performance that I think that's enough</font><br=
>
    <font face=3D"monospace">to send </font><font face=3D"monospace">this=

      patch to upstream. On Visionfive 2, performance is mainly</font><br=
>
    <font face=3D"monospace">limited by low mmc clock and cannot be
      increased, so I can't see obvious</font><br>
    <font face=3D"monospace">improvement on that.</font><br>
    <font face=3D"monospace"></font><br>
    <font face=3D"monospace">Best regards,</font><br>
    <font face=3D"monospace">Shengyu</font><br>
    <br>
    <blockquote type=3D"cite"
      cite=3D"mid:fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">[1]: <a
        class=3D"moz-txt-link-freetext"
href=3D"https://github.com/CTCaer/switch-l4t-kernel-4.9/commit/fa86ebbd56=
d30b3b6af26e1d1c3f9c411a47e98e">https://github.com/CTCaer/switch-l4t-kern=
el-4.9/commit/fa86ebbd56d30b3b6af26e1d1c3f9c411a47e98e</a>
[2]: <a class=3D"moz-txt-link-freetext"
href=3D"https://github.com/CTCaer/switch-l4t-kernel-4.9/commit/385f9335b9=
a60ce471ac3291f202b1326212be3e">https://github.com/CTCaer/switch-l4t-kern=
el-4.9/commit/385f9335b9a60ce471ac3291f202b1326212be3e</a>

Signed-off-by: Shengyu Qu <a class=3D"moz-txt-link-rfc2396E"
        href=3D"mailto:wiagn233@outlook.com">&lt;wiagn233@outlook.com&gt;=
</a>
---
 drivers/mmc/host/sdhci.c | 17 ++++++++++++-----
 drivers/mmc/host/sdhci.h |  4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..f546b675c7b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1081,7 +1081,7 @@ static void sdhci_initialize_data(struct sdhci_host=
 *host,
 	WARN_ON(host-&gt;data);
=20
 	/* Sanity checks */
-	BUG_ON(data-&gt;blksz * data-&gt;blocks &gt; 524288);
+	BUG_ON(data-&gt;blksz * data-&gt;blocks &gt; host-&gt;mmc-&gt;max_req_s=
ize);
 	BUG_ON(data-&gt;blksz &gt; host-&gt;mmc-&gt;max_blk_size);
 	BUG_ON(data-&gt;blocks &gt; 65535);
=20
@@ -4690,11 +4690,18 @@ int sdhci_setup_host(struct sdhci_host *host)
=20
 	/*
 	 * Maximum number of sectors in one transfer. Limited by SDMA boundary
-	 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
-	 * is less anyway.
+	 * size and by tuning modes on ADMA. On tuning mode 3 16MiB is more tha=
n
+	 * enough to cover big data transfers.
 	 */
-	mmc-&gt;max_req_size =3D 524288;
-
+	if (host-&gt;flags &amp; SDHCI_USE_ADMA) {
+		if (host-&gt;tuning_mode !=3D SDHCI_TUNING_MODE_3)
+			mmc-&gt;max_req_size =3D SZ_4M;
+		else
+			mmc-&gt;max_req_size =3D SZ_16M;
+	} else {
+		/* On PIO/SDMA use SDMA boundary size (512KiB). */
+		mmc-&gt;max_req_size =3D SZ_512K;
+	}
 	/*
 	 * Maximum number of segments. Depends on if the hardware
 	 * can do scatter/gather or not.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a20864fc0641..98252c427feb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -346,11 +346,11 @@ struct sdhci_adma2_64_desc {
 #define ADMA2_END		0x2
=20
 /*
- * Maximum segments assuming a 512KiB maximum requisition size and a min=
imum
+ * Maximum segments assuming a 16MiB maximum requisition size and a mini=
mum
  * 4KiB page size. Note this also allows enough for multiple descriptors=
 in
  * case of PAGE_SIZE &gt;=3D 64KiB.
  */
-#define SDHCI_MAX_SEGS		128
+#define SDHCI_MAX_SEGS		4096
=20
 /* Allow for a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------iFnRZ7hh40SzQVOx8XaB0MA8--

--------------3J69x4CgmahBgQxm3wGqmxnG
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------3J69x4CgmahBgQxm3wGqmxnG--

--------------pFrYLPppJCyMGj10LA5cak3V--

--------------u52lex32qQRVi0SiL3w0Pk4W
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmW9NkgFAwAAAAAACgkQX75KBAfJsRkz
6Q/8CV3Cns+szgMwS1HV47KnxyWMqbtFYTVWxqs5RXy9fCu739JVBdLCdmJvMaJdLA+vcC885gq+
z59kjMS5uRYsv48bAwZNYGewwMeoiJ6X+4a1+sHJ+9Qz55SJSBwf6NBFEEuoqI7Koogzx2l3Y+zi
9oGiXC+K/6umZ+HM/7k5yxZeVgIlCSLog8/JWpilFfeCBzZ0/ahAJGGWhrybYZcf8zBg3/pJXyfV
osRc+R2jRNc1Dq8ZHMziVspkTcfB/VmFHNIu7DJkMcxp5JTY9SnN07BZo0fj/BW2ebcES9jlWarj
BmMrcjsxLb9DCJp1b43FzeLIz6xHA0X0m8e0xasHAJLljfMj4ARMwTPD8hsmER3iXu1ViWfXniZy
Xnb61UWSIHR3gMYaeO8ZTVWv5JmCrB3ewkL1N9VN9Gj2QSrUO4F3eWeVpfKlK9AveukORJhozQ1l
wc8/GCO+GN8bQETO6wKlidX3x/q8KteXlp3SdsVP0QHTZ4bOa9tj0RxoMs4ALwvN/bZD3/5eHGpl
MLSNK7qxRkOoH4UaP7+C4APGdPx1+QZbcXvMYk0xnVLX9JuqB2arzjFEIwZpME6jwogUDknoayeZ
Fo8R0EyOD4rHQ03cJ/SIA2kGY06MP7RFdSnAYaNv0IqUziyD+By/flImgPrHFuO3CQVpSDnDGu9/
Zsc=
=rzGM
-----END PGP SIGNATURE-----

--------------u52lex32qQRVi0SiL3w0Pk4W--

