Return-Path: <linux-kernel+bounces-81599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47EB867809
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C461C23D38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6CD129A9B;
	Mon, 26 Feb 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ktc3ORXN"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2013.outbound.protection.outlook.com [40.92.99.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311160860;
	Mon, 26 Feb 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957018; cv=fail; b=XZTsbMTKwTZiCbnQ6zsLRqqiAb+jRQ6J/ABrS8WFuhF9kHsv0KpiWWU8jnKQhWrSi8HmMQGB+kDtP01urqW675Elf9qes/xgr0haQhV9BsDuYQ+BGZmGlG+Zr7kSJ7M6wn7g6a2/40UcKflut8f24MI7B3sddmM4hSrcImg39Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957018; c=relaxed/simple;
	bh=QFbn7PIy6Ja+Xjp1R2v1JGGypDHt+uim1YjG7P1vC4g=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OYi5EbX3Mf7Ya8dp3Ajv9a9glPBITRS7kl9wKyCEUaRFMcv4yd2hYIKbuuCEJCRSU110Xcifem82fgWFp0NZchuhhJva4u2o3MWV/XPWjj+rkdeWTApQiH7b+tS/fGhH2Ne8RItw3MEa+wZPRCi/Yg0kGI3Iv843ss4X5ocY87k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ktc3ORXN; arc=fail smtp.client-ip=40.92.99.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSBwVQ9FzlqQiQTryS3s7v0C3YUmBP8FpEihladPkCBriFW3J8kR1+NpnYaUWSmQIEkbuuI6lrZ6OUmwZebqNDzp426PqnVtz0RTf3wDRn2I9G5/nPIMN2x8DGBXN3rHl8dMNGz5K+2jbpOWr8KxaBoT1RQK+cbYyJZancZktLk1hWg5IA2+hG551F3Ur6/Al5F4DQ6q8qA6jUSVyjL2IUuBfEBtB7ONYQVlIkFK2D9ZKnPDX5hnLTksJbs+1F8h789pbGIq2RTnRaDQGUJiwMTyswlXPLMuDWK5uB9wf554cCNBpGn54YBZqkzy3E8pAYHNhC/9GQ7eK9fBFvMswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFbn7PIy6Ja+Xjp1R2v1JGGypDHt+uim1YjG7P1vC4g=;
 b=nlJGbZz/B+3DUlFkoKuoAa991a0g2fKivrngTpO4R6aXbQBtTN0naomW6pF782lMFuu0B1LID7iX9kYuQQlI1RKGu9CeVIDS9GeM3F5WaqZBUAbpNwZnROyeWM4c0oXZ+S9ChgjixwxNNKHRhrXI9qzTf0vqlXbetQ5ZdNQnLr2wytuWh/zINL41unBSHZB9KdtU45YrRKwt4/pSbeYN4bgK7Qlog2Qcvi9YQWEhwUi9IHITgdOrrWYqGAbbdu6zsSV+B2jfIhbgtwVty+vWAJarFsZsI/+LHijbbkGfrk5cVhe42TZbtVGQNJK7wDLPa31nxCcupEfNwzGMi/5v3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFbn7PIy6Ja+Xjp1R2v1JGGypDHt+uim1YjG7P1vC4g=;
 b=Ktc3ORXNe+41J/UGtj6zw+nwvSgc5OuEYsAotgN4EHYVb9gNFGRCQsd08W1Cpvq2d4AFzyXx0PSfjXlxrjerpza1TQ8VsgB7fo6OXTgYNq8KZsXLsr1eeiWVgf6DPx8RXMCZeyzOailw+SHlY+tez9+mcHPDsqSD7jR4mA4upJNnxcR2ImARNydTSHwvtCAzE9jbxiB77yOHV91bKOf092Ykn7qvNs5wnibp+BPQyWq93aWcP9VKbpu6F7nb04N3o0SOMsaiMsfRgvx5prgpa9tIm51WbDLDDCwzIhrvgOiOTDfgwU7iXXK4ipNthcFEb6pBiCB7TbxTC+2/UDljtw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB2104.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:176::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 14:16:51 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 14:16:51 +0000
Message-ID:
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Mon, 26 Feb 2024 22:16:46 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SZbEpfCJe8wdRPgnFHvtgNUi"
X-TMN: [mW5f2czOXlp6kxhStAtE0ZCa40F5GnQNHaCRr6xkAhqj15e0CP6nMml/gphYZG4y]
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <08744844-d8f5-4c4b-b6b3-9a0b745c823a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2104:EE_
X-MS-Office365-Filtering-Correlation-Id: 194711d5-a9c9-4b3d-29fb-08dc36d5937a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pqoPCrBCHoy8kHrNfOlq+DqHhAiwNgODgN6/93HRGTNCcF89TufC7BO6x2nUNzwacdeoF9ahR1sL8sqDy/HVBNjT/4l1h5iPqVaQM8FjNaSjvo27lNRQNH+68GCZqrJFIidMv647mhpdBBU46USgB7O7BuLNwdvSRBT9uPjZa6ML9X6bntVp+WdydZfsoPW949+ErzIqxre/XYWALEIZyJvia/Hr3LjfJRzIZMEvZQSnaEteYVd4ow8oFM8QzdprEB0Cyo8eQjZziBLb0QXcKYq8L1XOilmNRm/Ga3Dda2DZqg4XXzN+Zpejly9BzgKsmUTvdIaOkU8e7oaU4MPuitbEcjar2IFDcqsTDxS1CcT5f6uovrMDTwFZRstWkqClMCeLSoU8MEkdFuoCGBPq5Fz+lTAGt1FQDm0MXgO8afk+YlD5nb9tn5af+oJ02GALI9pJf4qCNUuLmJIhoilziALwB9G+nMjTnos6wfnLVN6UQy613KHZhYveYBJ3TjKEbldUURc8a6g22+B+VCmSaO+sBuZxk9n+35NlfqJT3XTDClrnADwH8DLRF1KGmgD4yQX9hbK/NG7MHZ2DcunCuc50mfAAiC+bWHvm7LPoFfpkHVrJHU7hc7e9bs1Owj1nhjDhz6N2tejWiCS2U8J5IA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFPT2t4endjekJCOVJqZTBYZHBRbEtjaDVOaHBpWjNDeloxelg4YkxodjVi?=
 =?utf-8?B?N2J1YzRhMDEyY0RYQUxQKzBXMnplbHNpY2NWemVUM3dWWEI0aVNzVmdjVWF3?=
 =?utf-8?B?UGd4ejNvL1lHY2FpWFhpeTM4WmRBNDdLZUZ3QWJNRllOL0hXa0wwWGU1UHU0?=
 =?utf-8?B?d0tyTStpVktsOUVXb29YR1FidURsSHkwTlAzVlU0VUxMR1EySXJ0NURadkJm?=
 =?utf-8?B?ZXk5Z29YeEZqTnFSTEJjcVZITzdBZUMvalBOVCs1Zk5YcnlxYjE3bjM4N29R?=
 =?utf-8?B?aCtzOGRzWFFubEhPV2FZejdzUUFLU3FVaGt2WEpXM1FMYjV6K2NSaEQrUlRJ?=
 =?utf-8?B?OEdqWGxCZHoxamZFaElnVEUwK01RSElKYlZQbG5ZdXJKblpoemVWSVpTaHRK?=
 =?utf-8?B?b2taZGlueTFuNm5KTjJDUklxL3VmOEhCNkFlMlluZElXSU5tNXRCY0RTUGpB?=
 =?utf-8?B?VnNYRUN6S2UzeHUxdDRFdm5NY3o5T0c1eEhKQUNLTjdOaTNVY0ZIeGZvaEtT?=
 =?utf-8?B?VUE5Q3ZyejlvNlNVNE1uK2VTWHBzZWl3TG1kaDFUTTNtdFJBVlRwcHBka2pZ?=
 =?utf-8?B?QnhOYllkQ0tVbUdEK1B1T1FPQ0NWbHp0SVNpQngzenBTSllsUmd5T3Z6dC9j?=
 =?utf-8?B?RDVLYWczL0Q5Q1d1RHFRTUd6N0F0bng0RUs4MVVDTEJaOWNvQlJFY2VhVjZw?=
 =?utf-8?B?ZTkvaE1zeFRYOEZOYjl5RmtBRDhkTzNEemlrd3Fyb1h0TFdTK2ZseWp6azJF?=
 =?utf-8?B?dVlhK0dsalFGdlBmb28wS25JdWM1T3BBRDdVVEhmc0FaYlNPa0tvb1pGQUwr?=
 =?utf-8?B?QnR5Y1VTd0hXSy9PZEVZbjh2VlBKQ3NUVW5WdzNBNFFBRXZ3MjZxZElvU2s4?=
 =?utf-8?B?a3hQL2Z5Q3d0WXN0amcycDdhMnBOd1RqVmd1NzNiaE9LSGJFYUhhcDFSdGR1?=
 =?utf-8?B?aTBnbkZTMjYzR0Y0QjNuT1MvOVp2OURNTVdZZk82T1J4QlRZVkJsamV3QWJ1?=
 =?utf-8?B?U2UvL3lOdFB0YWEyQ3VjNGU4V2JRVDF1bEtlRndKZWJ1ZVk5c3ZudTBQd1Q4?=
 =?utf-8?B?aUdJRnhIcG9FamNuSHVGUDZBQUhQeFpFZVVlR28wYUE2OENqRDVDa0Z4QmxZ?=
 =?utf-8?B?RXZFRzNqVlMvcDFkN2p2YmJHVDhHeUF0c1FPQURFdnZRd0g4SHFUMVF3QTFm?=
 =?utf-8?B?UXJuOGlDblN5V3c5a0RVRnFBQkRzY01HQlB5S2FpTjFNRUdnNGZacUFlZDkx?=
 =?utf-8?B?bTVaVnhscnVkY0dQcS91cGFXT1Fkb0hDcVNkS0R6c2d3L09udTRqb0Y4QkMz?=
 =?utf-8?B?SmlFQ0FwbzZBVFFpcjRBTnl2bjBYNUJEZ2UvVmRDNXlWYjMzMi9yYmxYcHl2?=
 =?utf-8?B?eG9HY09KQWM3YmxaeXRiT1F6Um8rR1VtUHdSTUg2Wi81N2JIUlVjcDlMeUxw?=
 =?utf-8?B?SGRNU1E1M0xENGxhN1VSTno3MzFCcXluOXkySHRKNy83T3hvMmpnZ0hIL3lw?=
 =?utf-8?B?aDNHZmd6MVRNbzlGY005U0Fld0JyeEZvS1VoeXpROXdmTVNhNDB5UkFrRmRr?=
 =?utf-8?B?elZTaTNWeWRtdmxaMFFrV09RNGdwbUhNbnAxSUJmd2szVTlrSHF4Y01KUjl5?=
 =?utf-8?B?a1BJQWpxUmh2Mklqa0c4a0s0ZU92dkYxQklXR0Y1TUFHMTFLTnA1NGN4eDV6?=
 =?utf-8?B?amdHNjdsbnhKNUpqN1U4TTErUldQNG4yeHpXS1pJWTFPNzNCTXlzTWVrL2Rh?=
 =?utf-8?Q?vBQ0e9do2pX72c/Qw8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194711d5-a9c9-4b3d-29fb-08dc36d5937a
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:16:51.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2104

--------------SZbEpfCJe8wdRPgnFHvtgNUi
Content-Type: multipart/mixed; boundary="------------xP4e0pyXWUr4T14vaJzWtgTD";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <08744844-d8f5-4c4b-b6b3-9a0b745c823a@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
In-Reply-To: <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>

--------------xP4e0pyXWUr4T14vaJzWtgTD
Content-Type: multipart/mixed; boundary="------------Pt5Z7bd0hnk5mSBbcSvKMltu"

--------------Pt5Z7bd0hnk5mSBbcSvKMltu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUnVzc2VsbCwNCg0KPiBPbiBNb24sIEZlYiAyNiwgMjAyNCBhdCAwOToyMzo0NlBNICsw
ODAwLCBTaGVuZ3l1IFF1IHdyb3RlOg0KPj4gT0RJIERGUC0zNFgtMkMyIGlzIGNhcGFibGUg
b2YgMjUwMGJhc2UtWCwgYnV0IGluY29ycmVjdGx5IHJlcG9ydCBpdHMNCj4+IGNhcGFiaWxp
dGllcyBpbiB0aGUgRUVQUk9NLg0KPj4gU28gdXNlIHNmcF9xdWlya18yNTAwYmFzZXggZm9y
IHRoaXMgbW9kdWxlIHRvIGFsbG93IDI1MDBCYXNlLVggbW9kZS4NCj4gVGhpcyB3YXMgcHJl
dmlvdXNseSBzdWJtaXR0ZWQgYnkgU2VyZ2lvIFBhbHVtYm8sIGFuZCBjb21lcyBpbiB0d28N
Cj4gZGlmZmVyZW50IGZvcm1zIC0gYW4gT0VNIHZlcnNpb24gYW5kIG5vbi1PRU0uIFRoZXJl
IHdhcyBleHRlbnNpdmUNCj4gZGlzY3Vzc2lvbiBhYm91dCB0aGlzLCBhbmQgdGhlIHJlc3Vs
dCBpcyB0aGF0IEknbSBub3QgYWNjZXB0aW5nIHRoaXMNCj4gcXVpcmsgZm9yIHRoaXMgbW9k
dWxlLg0KPg0KPiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIG1vZHVsZSBfZGVmYXVsdHNfIHRv
IDEwMDBiYXNlLVggYW5kIHJlcXVpcmVzDQo+IG1hbnVhbCByZWNvbmZpZ3VyYXRpb24gYnkg
dGhlIHVzZXIgdG8gb3BlcmF0ZSBhdCAyNTAwYmFzZS1YLg0KPiBVbmZvcnR1bmF0ZWx5LCB0
aGVyZSBpcyBubyB3YXkgZm9yIHRoZSBrZXJuZWwgdG8ga25vdyB3aGV0aGVyIHRoYXQNCj4g
cmVjb25maWd1cmF0aW9uIGhhcyBvY2N1cnJlZC4NCk5vLCBJbiB0aGUgZmlybXdhcmUgb2Yg
dGhpcyBzdGljaywgdGhlIHNwZWVkIHJhdGUgaXMgY29uZmlndXJlZCB0byBhdXRvDQpuZWdv
dGlhdGlvbiByYXRoZXIgdGhhbiBmaXhlZCAxMDAwYmFzZS1YLiBJIHRyaWVkIDMgZGlmZmVy
ZW50IHZlcnNpb25zIA0Kb2YgdGhlIGZpcm13YXJlIGFuZCBnZXRzIHRoZSBzYW1lIHJlc3Vs
dC4gQWxzbywgdXNlciBjYW4gcGx1ZyBpbiBhbmQgb3V0IA0KdGhlIG9wdGljIGZpYmVyIGZv
ciBmaXZlIHRpbWVzIGluIDMwIHNlY29uZHMgdG8gdHJpZ2dlciBhIGZvcmNlIGZhY3Rvcnkg
DQpyZXNldC5UaGlzIGZ1bmN0aW9uIGlzIGFsc28gZW5hYmxlZCBieSBkZWZhdWx0LiBUaGlz
IHdvdWxkIGFsc28gcmVzZXQgDQp0aGUgc3BlZWQgY29uZmlndXJhdGlvbiB0byBhdXRvIG5l
Z290aWF0aW9uIGJ1dCBzdGlsbCBrZWVwcyBMT0lEIGNvbmZpZy4gDQpCZXN0IHJlZ2FyZHMs
IFNoZW5neXUNCj4gVGhlIGFkZGl0aW9uIG9mIHRoaXMgcXVpcmsgbWFrZXMgdGhlIGtlcm5l
bCBzZWxlY3QgMjUwMGJhc2UtWCB3aGVuDQo+IHRoZSBtb2R1bGUgaXMgcGx1Z2dlZCBpbiB0
byBhIGhvc3QgdGhhdCBzdXBwb3J0cyBib3RoIDI1MDBiYXNlLVgNCj4gYW5kIDEwMDBiYXNl
LVgsIHJlc3VsdGluZyBpbiB0aGUgbGluayB3aXRoIHRoZSBtb2R1bGUgbmV2ZXIgY29taW5n
DQo+IHVwLiAoMjUwMGJhc2UtWCBpcyAxMDAwYmFzZS1YIGNsb2NrZWQgMi41eCBmYXN0ZXIs
IGFuZCB0aGVyZSBpcw0KPiBub3RoaW5nIGluIHRoZSBsaW5lIHByb3RvY29sIHRoYXQgaWRl
bnRpZmllcyB0aGlzLikNCj4NCj4gQ29uc2VxdWVudGx5LCBhZGRpbmcgdGhpcyBxdWlyayBt
YWtlcyBtb2R1bGVzIGluIHRoZWlyIGRlZmF1bHQNCj4gY29uZmlndXJhdGlvbiBub3QgbGlu
ayB3aXRoIHRoZSBob3N0LCBhbmQgdGh1cyBiZSBpbmFjY2Vzc2libGUuDQo+DQo+IFRoZXJl
Zm9yZSwgZm9yIHRoZSBiZXN0IHVzZXIgZXhwZXJpZW5jZSAoaW4gdGVybXMgb2YgaGF2aW5n
IGEgd29ya2luZw0KPiBtb2R1bGUgd2hlbiBpdCB0dXJucyB1cCBhdCB0aGUgZG9vcnN0ZXAp
IHRoZSBvbmx5IG9wdGlvbiBpcyB0byByZWZ1c2UNCj4gdGhpcyBxdWlyay4NCj4NCj4gTm93
LCB3aGF0IEkgcmVhbGx5IGRvbid0IGxpa2UgaXMgdGhhdCBJIGhhZCBhIGxlbmd0aHkgZGlz
Y3Vzc2lvbiBvdmVyDQo+IHRoaXMgd2l0aCBTZXJnaW8sIGFuZCBpdCBzZWVtcyBmcm9tIGEg
bWFpbmxpbmUgZGV2ZWxvcGVyIHBvaW50IG9mIHZpZXcNCj4gdGhhdCAib2gsIFNlcmdpbyB3
YXNuJ3Qgc3VjY2Vzc2Z1bCBpbiBnZXR0aW5nIHRoaXMgbWVyZ2VkLCBzb21lb25lIGVsc2UN
Cj4gY2FuIGhhdmUgYSBnbyIuDQo+DQo+IEl0IF9pc24ndF8gdGhlIHBlcnNvbiB3aG8gaXMg
dGhlIHByb2JsZW0gLSBpdCBpcyB0aGUgcHJpbmNpcGxlIGFuZCB0aGUNCj4gY29uZnVzaW9u
IHRoaXMgd2lsbCBjYXVzZSB0byB1c2VycyB3aG8gcmVjZWl2ZSBtb2R1bGVzIGluIHRoZWly
IGRlZmF1bHQNCj4gY29uZmlndXJhdGlvbiAoMTAwMGJhc2UtWCksIGFuZCB0aGVuIHBsdWcg
dGhlbSBpbiB3aXRoIHRoaXMgcXVpcmsgaW4NCj4gcGxhY2UsIGFuZCB0aGUga2VybmVsIHNl
bGVjdHMgMjUwMGJhc2UtWCByZXN1bHRpbmcgaW4gbm8gbGluayBhbmQgKm5vKg0KPiBhY2Nl
c3MgdG8gdGhlIG1vZHVsZS4NCj4NCg0K
--------------Pt5Z7bd0hnk5mSBbcSvKMltu
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------Pt5Z7bd0hnk5mSBbcSvKMltu--

--------------xP4e0pyXWUr4T14vaJzWtgTD--

--------------SZbEpfCJe8wdRPgnFHvtgNUi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXcnU4FAwAAAAAACgkQX75KBAfJsRl7
0A//Rf7eNp0U21RwJWLoj3Zh41jMkVh0p7hkoSDN0zRUvDgmDG1Z+5/u9dCnbj8IVm+v8C2YF6JV
2bxzJfQtGSEhUia/3nqfV4mDxsSXbmzUejNkf1uk4zYiVz/kt0kfS5d3NyKdvpYGFKlsQpokuamE
3BSMwMnU0JRTr3tlJdgvxTUWavG64yrt+AG6IxpJw2QRIwPcKNyqFxugH7FxwZgcVvrNGddIY0Ox
XooeGCPxIU03HidDw0ZtpHnCoI2G9y9PWnW3jjz17C/mTRHwgkZH9QLZvuMRUSNwASVBTPR+KI3e
f8ZmMMCCe5guYgkDJTfN/FQk8fjGq+i/ZA82+CE4EPVAC011u9SCBLVpV7agKI6mS0vWVs4B4Quh
8rqsQmie+QvHR6d3S4A8/1v6/vbJdU6dPooZfnYXPCwZ8MzYpdB9sTOTFe3E560QeOqb43lOSMs4
xkbTi3uAjk78i2Z672WF8D2ERFRYPBiUhfYFZrD5uKsUzRDR/EE4LZwbEdo7u78GGbAU1Z9iiJxq
MDh9O5KyTzwrl3D8++SVVBxqU7jvhjDz9Lpw49aR++wLJ4ACUiYx2Dpo3aYejTb96iQcs0zFH8Vs
tZPmNb+SMffW5JCaa/+lyAY1pJxR8+4ZxROMxM3i4gZu8oJoOQXLXvaCp5v5FUJtWg40vAcz+0d3
G74=
=4JBZ
-----END PGP SIGNATURE-----

--------------SZbEpfCJe8wdRPgnFHvtgNUi--

