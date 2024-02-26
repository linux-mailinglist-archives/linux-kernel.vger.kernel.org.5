Return-Path: <linux-kernel+bounces-81783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE9867A13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D02A3A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72112CD8E;
	Mon, 26 Feb 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="skzXpczi"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2075.outbound.protection.outlook.com [40.92.99.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AB249F9;
	Mon, 26 Feb 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960854; cv=fail; b=b9k+CGpMrMTn8jX+uU4o42UkkadUr11lvzWFdZnLH5nU41+ltwrMyMCfInsHP2xWZxqlpTUPAvKBqNHHTHp03QTpi8HXE2DRkFB0he2XnmYmBYcenZFxncTnYDhwZIgEM4Jz7//u1ZVaj+4dkib+hdThV2/rf+6FTElHLwL1ktY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960854; c=relaxed/simple;
	bh=sQEA9nEjR5YyEJPJWfGj3xIz5bvJh4XqnHxKEB9azVM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bgaxa+ESQ3EiqslGes1myp7NY7bF/3B3Ro3/Kd5H0Gu9/Kk+5j5WXZt6sBezhkQgyrsZQyJp7sdvOmClHsOmXBp+GieYtPfmWjnpgxpO6vkkHAXwWwL6wxYhZyJrluTmxhV20L/Y9txxQvUzAaneFGjyVIiEaJuKtAk9dO6lj/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=skzXpczi; arc=fail smtp.client-ip=40.92.99.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac9rdHVPOfzx7uGVU359vp0JnRVt7f0JAIaPY66DBFGpcaD6KNBExLZYU276n3+Q2geBr9Hr5Tj9BVxISjYXAQtAexchpRr8h7F8CT9yRXOAs6QmLJEDqNcO1DSt47miEWqRxQUE4/lmeMJ9D4MSUXRQgPZS2Q6MA+i3W9tjxsbGQtdbyynU09wG7LZkhbnroCAGr+NwZw1iu/UtzAs1xgI2NA/DLGxn5T5iv+GKZCEb7pWiA6HLrtWDBtSL3CORNqDCg6ueM9y1y/ZUKtJOElz664CyTSFUsHOOs8M+c2lxQ0yx3lRT79p5BJ2ETcst2VFL1KwFebNPuuNi1knhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQEA9nEjR5YyEJPJWfGj3xIz5bvJh4XqnHxKEB9azVM=;
 b=DNamd4Ebj542O0mHQNEXfyiOwIoaFyxx8pkaKXmTpQE2j5Ls+eg0r5KZIoEF/Y7EfUNcNUsJd7NYpSvj9NpwkKsDm2C/7oACTVcuBH0yVE5YLTn5CCMnYi6f6/Y32KgbYCZTKN4Vc3YVdIV+nUCUNmxhtroxgmp3wu5ASiG1QExPx1i/vKfDGFN3ZT+4kgUJpCmtYJebi3EWggWEJFZ3lawZ6TDLQqCGj11UMB64oJLp+1bWkikxy+4itz3WhWWlDJHvMGwknlTsCcdrSW3PML21/9UIkJCUQWM0XXUq+dW4vd04f7KJ6ggaUMFMaJng3iEEcTsAavATB5iuBwV+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQEA9nEjR5YyEJPJWfGj3xIz5bvJh4XqnHxKEB9azVM=;
 b=skzXpczixCgyBDLd9Dn90VnEofpWi3mKv34UcShr3MAPEC+auTxk/5RVqnFI6abBpHpQW7aLFE9AYst220YaEaVO7rX3grDED/h+fOjQVona4pEzJHVYLvONtWsVTveAFMI3dsq3I1xEGiW0TMk/VLRDCL0REQQyLA8bNbXfXD9PESrqjy2JzaK+yU8vn+/ytr+Li2mVQXhNJRiHh5C0d9csvWXopPO/BS5CkystiIM4sZKzsQCvzJZY0XEMPPlNIIG83TBaK0ctCvuHCW8BpvJF98X0xdmu9IDVoXmzxGe9JyPSdQ5cEMy34tPxKbopqFHnQBVX2kP0xuNI+hx7ig==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB2756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 15:20:48 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:20:48 +0000
Message-ID:
 <TY3P286MB2611578CBBB25D48FA5452A7985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Mon, 26 Feb 2024 23:20:47 +0800
User-Agent: Mozilla Thunderbird
From: Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
To: Andrew Lunn <andrew@lunn.ch>
Cc: wiagn233@outlook.com, "Russell King (Oracle)" <linux@armlinux.org.uk>,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Z6xTV8N5oz2v26AZie0LdMmx"
X-TMN: [8oxgQ1bXBd4FBo4VN1mT9xUhQlD3fOUtytQZHPOYq+Y+sd402Bg6uZExkPz4eM05]
X-ClientProxiedBy: TYCPR01CA0116.jpnprd01.prod.outlook.com
 (2603:1096:405:4::32) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <3f15c219-783c-4bb9-a290-324c3aa990b3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB2756:EE_
X-MS-Office365-Filtering-Correlation-Id: c9abdc85-2c2a-4a39-8b27-08dc36de82de
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/RqNP35+qYt8hVzvxEb9xfv38JP1zGUkQRPSh9wiEvlTf/N+Qha6FWARu/FODSplrD2eVyvkwZr6chNYZ7y+YJsNRxCjj3oACZyTJ20cOnFfqGvY9MX3HCvZdpco1pClWSc2Z64mou0uMYcdFjA4y+cVkatm3jFGk9d4qOtjzwwHDFW2yojg2TuxT7L5Ob5m94ZOLOzUDqndYlQrG1tjSk9YyBs6HypCUsM7GIpgDbhSHupGuBa3Ot4EdX6pp6Qu2ecB0Hx6NUDvw2CWAyaZFkNSpvEboBZ25wOLlJTWGGctKINlIWcnU01LhZpcM3b8TA2TLbfWTXxgDuysAmvIKZukUc8KCgA0+OTwd7RfAo5WPI38myFhs+KuDhHuHVLUfpfSilIHjDFVMVKDaD1bwvcSs2smoZdPYj88XOiNygURwTzJDocw2Bo+0UtCCpU8K/SaDtMsKXweWFvHwjWnncyFvo+/duX1TnNX3yo/EyeG1YYQr9W817UGX1NgX5oZB6Iyzybuuv802uogAZIxsPGhC5s9xDSEqPQpfRq34LweLLDTBkXpTkT6uQAsl52VbAguueafjuGZfRTqy4qf61Lv34YiV4gf8sMTae+puvm3LIveFU06slRAjYPcwyP7/Si6TfBxD21yXZJMgtqhrsR2MtQwuMPH3FB6QoapwTSRhj8aHiRgdQjwgyhcRov1zXjEemJkMDuhgowyCjkq0sKiNn1Jq/O/j84r3ji9qMs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZNYkRGZzVGSGxBenlCZEVKSGtYRlpuZEduZUlZQzFyeVRrYS92WEFUaGZh?=
 =?utf-8?B?cWVNbDZRamhYeXBTMm5IeFVwRUY1QlBjaThMYlIweWxLQUxwbHF6SjBuYkZN?=
 =?utf-8?B?eENBb0dVVUVkMm84Nk1iYXhQQ21nVnBLUHVjSGhIMjFhbnFORGt4bFZxaDgz?=
 =?utf-8?B?aWFhdTRnODU5TDJLUXZ6NWNpTmdGc0F1dXFLQmZ1YjBXaGVlUDJBSklJcU5p?=
 =?utf-8?B?djhzNExTMU1jcFEwemZBWmRhWCtDdEpLSjN6cEw2dFowUFphTVY3OCsrY2I0?=
 =?utf-8?B?UnNjaXMrVXFaMDBTOGRvdjc2Q2J4czB2bFc2RWw5S2l3Mlh3aUI2SHYwSnBo?=
 =?utf-8?B?dDdIV2NFT3l6M0I3YjA2Q2lZNXJiaHV2cjdaaitKSTdrVmsySVBDdGI3RU5o?=
 =?utf-8?B?dVlORTNva3ZjOVZ3TDNRYW14TkV0R3VlVTJzZjIyRnBoRHY5REJYZlY2UUFo?=
 =?utf-8?B?ZFk0WmxGUzBFaUlqTndOY1B0UlkveUN2elpvK1grWEMvQkYyVGVCcGVuT1FD?=
 =?utf-8?B?ZUhrS29SVlZYeTNWVEdKemxteWJKQzUzZ3JmeGFJc25WUk5oRXg2bmhqQitF?=
 =?utf-8?B?Sm5aNUxkNmZJSjlSbEhpcmcrRitmd2JwdGViTnY3Q3EwVnBrVmVUNThycHlh?=
 =?utf-8?B?NXJ1UlN4MG9OYURlbUoyZ091dElteW1waUVlR01yb3hkUVBWd3FBQlhLaXVi?=
 =?utf-8?B?ZXhXU3N1dmc1NlFmU0d0SC91ZTIwK3JzdnEvY2lZUi80ankrY1JzVGZrVXlM?=
 =?utf-8?B?UVEwU0VLS1lPTGx3OS82NXl5OTQzT3VSMmJycXNiSXNmbVF1WHkxcEdVWkFi?=
 =?utf-8?B?eHRkTkJhUXcvUGR2STBHSWliWG9JMzdySnlwR1h0eS9zL2NxRkNTdU5pZXNT?=
 =?utf-8?B?amltc1laRC9QRmwxV1ZiTjZ4bk02QUN1NnBaeXBpSmVVZitIVUVvVHljbHNJ?=
 =?utf-8?B?dVZLQVRNalVKZkI0b1ZvdTJQU3VmcUZsZVlGVHZCa0ZrT2piZkd4WUk2KzJM?=
 =?utf-8?B?YnY3bWF0NysrVG82WjNYNE5hbWVNdko3aStaenRGam5CRExMcnVFempldkdx?=
 =?utf-8?B?ZTVJWlJURVQzNTZpdG1wL0MweU0wTGZ1NE5OWDBGclF4bEp1Y2pGaldZWlND?=
 =?utf-8?B?OW1oUFk3akhOUUtCa3lha25vOThJMVFLK2Y5bFZmUVFBVWt5c1VtUjdaT3Ju?=
 =?utf-8?B?R0x1VWtTdjV5YnZMUlhWU3pvZE5uejJiUjJUUW5PUTExcVZmcDhOUVorNVFt?=
 =?utf-8?B?OHBHa0lSZDRwa2NXakNSZnVXRTBaNHlpUFY5dVNNVG4xK01HL3hXbWNvNUVC?=
 =?utf-8?B?aHBaUGI2Yk9tSEhiVktuK3Ztb3pQQ1ZQZkxlMUlFRXRkKzlFVU9hYVpnV2w5?=
 =?utf-8?B?NGovcE1JcERXa01NS2ljVEg1Y3cvSndidkErRlBoYmxYK2FRWDJnZE96Mzhj?=
 =?utf-8?B?Mm92S0hzamRUZGhtVm5TTnhxbkhUSWJzYTAyQ2N5NSsrdmxmVjkyZTdpaXhh?=
 =?utf-8?B?UlBaU3hUKzIzY1RIcjk0MXBOMmpBTFRjRE04N2RldWMyV0RIMDliOEJGdThH?=
 =?utf-8?B?TlZyZlNFWlhMS005M0UwakhBbHJJMHlDV2dvc1J3V2xoNzU3QTBhWk9XNjNo?=
 =?utf-8?B?U0FvUEV1Q1cyazU1bm1NVWZpNCtlZEd3Y1Rwb2M1NU5yejRqanE1dkdNajZk?=
 =?utf-8?B?bEh0dEszZjdZNVE5ZVZxNTlyUXVpYXNPdkk4cDVneXMrNGw4WUx2QldZL0k4?=
 =?utf-8?Q?t+eIkpx/oEXE5Y2ozw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9abdc85-2c2a-4a39-8b27-08dc36de82de
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:20:48.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2756

--------------Z6xTV8N5oz2v26AZie0LdMmx
Content-Type: multipart/mixed; boundary="------------6WtJLX1NNG4eO8h34oU3Yxzd";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: wiagn233@outlook.com, "Russell King (Oracle)" <linux@armlinux.org.uk>,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <3f15c219-783c-4bb9-a290-324c3aa990b3@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
In-Reply-To: <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>

--------------6WtJLX1NNG4eO8h34oU3Yxzd
Content-Type: multipart/mixed; boundary="------------J1Zr04UF46n1C0tW0hUdWyBL"

--------------J1Zr04UF46n1C0tW0hUdWyBL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmV3LA0KDQpXaGVuIHRlbG5ldCBjb25uZWN0ZWQgdG8gdGhlIHN0aWNrKEl0J3Mg
dXNpbmcgYnVzeWJveCksICJjYXQgL3Byb2Mva21zZyINCndvdWxkIHJlcG9ydCBzb21ldGhp
bmcgbGlrZSAiPDQ+Y2hhbmdlIG1vZGUgdG8gMCIsIHRoYXQgMCBpcyB0aGUgYWN0dWFsDQpz
cGVlZCByYXRlIGNvZGVuYW1lIGl0IGNoYW5nZXMgdG8uIFlvdSBjb3VsZCBjaGVjayB0aGlz
IFsxXSBmb3IgbW9yZQ0KaW5mb3JtYXRpb24uDQoNClNvcnJ5IGJ1dCBJIGNhbid0IHJlY29y
ZCBteSBrbXNnIG91dHB1dCBub3csIHNpbmNlIGVuYWJsZSBjb25uZWN0aW9uIHRvDQpteSBz
dGljayB3b3VsZCBtYWtlIHRoZSBuZXR3b3JrIHRvIGRpc2Nvbm5lY3QgZm9yIGFsbCB1c2Vy
cyBhbmQgbXkNCnJvb21tYXRlcyBhcmUgdXNpbmcgaXQuDQoNCkJlc3QgcmVnYXJkcywNClNo
ZW5neXUNCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9BbmltZTQwMDAvUlRMOTYweC9ibG9i
L21haW4vRG9jcy9GTEFTSF9HRVRTRVRfSU5GTy5tZCNsYW5fc2RzX21vZGUNCg0K5ZyoIDIw
MjQvMi8yNiAyMzowNiwgQW5kcmV3IEx1bm4g5YaZ6YGTOg0KPj4gV2VsbCwgdGhhdCBzZWVt
cyBzb21lIGtpbmQgd2VpcmQgdHJpY2sgaW1wbGVtZW50ZWQgaW4gdGhhdCBjaGlwJ3MgU0RL
IChtYXliZQ0KPj4gaGFyZHdhcmU/KS4gSXQgd291bGQgYXV0b21hdGljYWxseSBkZXRlY3Qg
dGhlIHNwZWVkIHJhdGUgdGhhdCBob3N0IHVzZXMgYW5kDQo+PiBzd2l0Y2ggdG8gdGhhdCBy
YXRlLiBUaGUgc3lzdGVtIGxvZyBvZiB0aGUgc3RpY2sgc2hvd3MgdGhhdC4NCj4gDQo+IFBs
ZWFzZSBjb3VsZCB5b3Ugc2hvdyBzb21lIGV4YW1wbGVzIGZyb20gdGhlIHN5c3RlbSBsb2cu
DQo+IA0KPiBJZiB0aGlzIHBhdGNoIGlzIGFjY2VwdGVkLCB0aGVzZSBkZXRhaWxzIG5lZWQg
dG8gYmUgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdlLCB0byBleHBsYWluIGhvdyB0aGlzIGFj
dHVhbGx5IHdvcmtzLCB3aGVuIGl0IHNob3VsZCBub3QNCj4gYWN0dWFsbHkgd29yay4uLi4N
Cj4gDQo+ICAgICAgICAgQW5kcmV3DQoNCg==
--------------J1Zr04UF46n1C0tW0hUdWyBL
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------J1Zr04UF46n1C0tW0hUdWyBL--

--------------6WtJLX1NNG4eO8h34oU3Yxzd--

--------------Z6xTV8N5oz2v26AZie0LdMmx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXcrE8FAwAAAAAACgkQX75KBAfJsRkx
TxAAkrFdhlFP+SQyBcQmXmTti6096InkIF4515u4ka+Fn1I+O6IEBObNF496mKYH5EPW32PvD08M
LgC0X4/ZLJQVMYNwjalzrfGLYNJsL3psc03ZZHa7L9I4xVJOaxDMHV3kApRRDxFDGZRErfw4MwR2
L2T8WjyQt3vvSrqpy++IeGQRwR/dslgaeVE/dkAypIfJdxyPEqO0Hkf0zPjU3xq1tG1ej6SyWvr/
lDPVOKuR3jWWsKWBEuikdMzWBvF935TwkjO+uR9Fuq7yay1yHy19iPjjBDIH7Oe8fuYtf1ashOoe
B8aZ4PNx/P8M4hM6VsFB9uFnblV+lUxCEs8zT50IPUKG0NLCaY5FUaWdlArUOeVcdHGhsStmUUhd
8wNPygiAV4FU5/LqlGgyLQWwq0glj/prf/aUm7XFA/7pSc6C9na+ik8eCoVuvyJuEi7cRzrcKldu
BiETpPnW/kUnfe3vX2i6EzDTfbxDVXw+E7w2QXQCLp1L0cCuSkEJYV6Sy1J8q2ZfpjO6/N53bfzZ
VEUjkez5iHb6yRx8OJ2B/3qhq0SYsnTqdiGPz9Kkn3Gfq5NgpasylS/Y5tyYpwue3KaCfKvr/pZ/
kNkF8YHEsHLoLx6bgNS1ZoQsvwk2LSqtYff5yo6T66bK2plLpq1Wv27H/Hf51+Wkmt39Wkq+jwKM
MxM=
=mcZE
-----END PGP SIGNATURE-----

--------------Z6xTV8N5oz2v26AZie0LdMmx--

