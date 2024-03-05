Return-Path: <linux-kernel+bounces-92567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD1872244
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D661F225CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2D1126F35;
	Tue,  5 Mar 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="diZJLK0S"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2105.outbound.protection.outlook.com [40.92.107.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1437126F09;
	Tue,  5 Mar 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650846; cv=fail; b=MfVxtrN+3aM0gxIR3kyKwpgnmEKGkZ5hWekd+FeOJSlhiUxJLgvYW7OPv4nFulEfQbYQbCoi72DEEHNB1OJIpK9PlDi7wYpsNzOcTFB6gPEjou5khW2EZ54nOBPxYZVVei3N3fMrb7iOcGlSusjDV/P//OUJ5i12FL1LFa9e2RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650846; c=relaxed/simple;
	bh=wvm2zr0zxWhLhrdnwhyPcpxR1lDzs5gAChJZ5sI55SE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ye909iFXPzMbz/h5K119AcyzN4p9WUZ6MLaR2+0gvKsKh3R9dA2di/3KsVRxx2V+x+gtsi1WUE1/1vBE3f4vtdrHbI90wlLBf3/BSyOnGeXGSkQQqd0Yac6unY/kWoSQFep7Ao/uYBvXOngTDDMzRfrnOfxbx1uUsvQEInuW19I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=diZJLK0S; arc=fail smtp.client-ip=40.92.107.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrNKScMQ/ACI4I/2IjCArsffQGaJR5EJl316jUSSX6q3fQkfaLui0j9oaMCfLGA7ZhvivVIY+qY3ugdKxuAMQfe6SUp3IlniejH4DzPA9PoG1VJMna4uKffwQC+vcFn/T9OzgmORLpSVS41B/bpQMdV7CW9YUJ+WOgSzPDwpjS2aX2t1/58V8eMDnEGU3u7HFHi1K347nFQF4iI+wtx9hDWzaOG+X+ULJDfDqts5vOEdYtCxB/ByA8JrGM+JVH8UvP9Q8vXHsRtmZIirXHCDaOAOHpdgzlBE3KQZz008zh8iJmefuz3hZvcrKoF7vMMmOoNQnjk9WB+6mNuWTCOClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjQJRhNV3WmJdmuyY0EdvZMPXy9xoNwhV85QtXmXd1A=;
 b=jhJuWdKuHcn2fDUy0YxFJX/KC5nNoIfS6dgvZHTQcBjhV9gGTSF/CeCI97WHIho6gY75nevMPIwucYD04aQUI/b77LOcMghwU+WhSK65jfwArCfRqOm8r3/YxyMJq1ZcSczwHB+p8kG+UxWwreyi+8Cgdn+LDEDSZIuYnPIOZApES8LC3j1mBIg/xlFqeYd9SBHQYNglsi/l1/x3QGGHVUP5K51D7lbS3n7qNB6K1gGicIEx+dYLZ4GIuxnhRtrfJgU1/mUih1+rFwYN5qxrH+ctjT0ZDBLpo8TQvY6J87fdg56ZYopXrN6u58t0+9JowlGokyzMajTyLmUzSfA7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjQJRhNV3WmJdmuyY0EdvZMPXy9xoNwhV85QtXmXd1A=;
 b=diZJLK0Sl7f6xwaalJziU6E05hNT8OWlrwIO7dGoNcRPeRcP+NBVwbBNIP6zuKKbGymCbw2Y/n6O/1QEuZ6gqdpKpHeJXbz8pAaKLa47RWqig77Om86sprPaATyRGfrBeEn65RCKQvyMsMyMwyVZe7BD4vLsM/76sQO+MgN+ZOIEyhSc2yEcbCr6xH8RNGtKwAfUwmtFUn1896Zj9203sU405xnNjLfCBIk2T9EHqlbMI29X18oUq3xOKTinwfLUaPyWSRy/aZHV/9KY/jUIMgxSV1YPecF3IsR6d6qvHqazEC3YPpSyavhZuqDberXm8TbXp/vTdUkkn2zyaNr70Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Tue, 5 Mar
 2024 15:00:40 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:00:39 +0000
Message-ID:
 <SEZPR06MB695977006A7F883E4BC1C35196222@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 5 Mar 2024 23:00:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] dt-bindings: phy: hisi-inno-usb2: add compatible
 of hisilicon,hi3798mv200-usb2-phy
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, David Yang <mmyangfl@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-phy@lists.infradead.org,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
 <20240305-inno-phy-v4-4-a03204c9cf1c@outlook.com>
 <170965072885.3344208.7195492638472513221.robh@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <170965072885.3344208.7195492638472513221.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [yUbeZvF0Jgps/l8rvfJIYkEjjSrg0sTLE/dxY6IAHticVBLYwJokKIMauvW0+Lws]
X-ClientProxiedBy: KL1PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:820:e::7) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <be2ef2d0-e4df-49cc-be72-caf1dda735f0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: f756258c-b574-4611-0f82-08dc3d250573
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6ctpbu0D5OXNyAWPqDtYJL8myS8UKHvBdKeTrRM/ZZ9oSWXNC6KhPXO2HHPqiLCBOpKcQ7HrUlQufa9eJ1Yqn9nhJ4aNGY5UxwVAEKcQi9IIPxsqoQaHYIHUBYmif2+D5gMDzdUmcxLR3r2NPMkmbzoWflJ1TugLVXAeJUnYtWq7hswh6TVwnLXySxKW9k0g/Yvv/NdpA95wypllRIbbPY1wKAApv8zZmrynXCJlTdRGiyas+M1h8a4OmhyiZxkWI/A/mwnvXTxrrh3ZgpGGJPB1DYYAjcboN1LPRJcs5qhlN/xZIDBwTlmjqtA4Uj4o7o5SzCDFXRkRUyj2HQNKFi/j0hCgJwGjQTsKFRaE6fkNQErjs6dJ4lAsGnt/R2tyVBRNc57fgXYAHwG/KlK+bqTuzAiJLFeToOekSBx1nSr8d53SRdMu28OWmNse+jYdOb6VJpWt4JL3MI7tOe/a6G+ezUMMJW4qtGQXcGf2ueRF9rN1ryEEYIsPwCrz0gAz94x/zJRUID5UtqKQK9Flv9IUuMGNcxdSG/Vn2VMvOLZ8xIq99dL6eWPPFg4vzcc2pzUvsMwQHz4YbY3mESfFfdGNbb1j9uIle4d1z7Gd4o9vt5z41PSiv/ky540cTXidHfMFps4+nl1ReDTorA9SjxrdDxHlHwuPfG/e9wLdo7Vif5KLXGnPbfH52SMXBj1ti9MVM42RPJKqgkL8zVTKCb65luie0rv4EQ0vU6UxZhAJkmsSinud4MbwIK9C+hEFMo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KlW0aQhHFUPgMgakEpU8hkpF0Ks7Pzbsj4uPk4o867xgFn/qlNaS+hO0Lg/DpPOAsPbvdT+m1k99uLJl+pO5+0KVoxebwl6KAbRiRjaofBIPXKKYalmF1QOPKlLWHsT44OWlf1q+9s7T0cZ/94X77U6q8lTTxNLSJheBWxFrxJTXswnwkpGW4tWCCBKopfjLwxUZR8aQIDRD4H4mNsjD/gcciv76IbAN84U2doULuceIhY+hW88s6G9eZvHHpAMoXfD5nrjCHtvSBSRDGqNV7/ZdmJvVMqfjLKw41G2w8EBrHygM5tSRd88WKV+Bv1xNnSe8pAnbL2UxW0OfLFyTUwibf/AwRvU2g2MMVuxl/uAa/R3k6EtGFUkEHARleznkuZ1NlycC8G0lc3kOByvv76W+GXfu3QuIJy72UvtSWe1D+FTAVNIjthBOAKc2qW/ynYn9UyKvlDt/+vuKSt+VkL4viqfs2dkFT1VmLYnCIhY4GBONT1i2TjqdPw6/0G7tCvmQYXxv1/CEEaosUJlGvps78VMdKAsvOiuv+Zgk16m7Gv9lfURPcYf99cfKXOAd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2o4MVYvYkxueURhZ1Uzdk8zZVh5N214Nm03Vm9MVG85aUtEQytIMkc5TW55?=
 =?utf-8?B?V0IyZU0xYStPQ01sOGFoSXJpb3loYk1JVG9XdlpzZHZmNXlLUWZSZ1JnVVBP?=
 =?utf-8?B?TEJ0OHFvaFJyUEhjK254d0NlQzBHeFdXdEN4YnQvYU16TXNHWEcwNmFZQTli?=
 =?utf-8?B?ZjU4M2VWVWtPZ1RuTzZGMzhvcHBzUmM0ZVFsaWI0bjZnQTZSYVdoanMva1g4?=
 =?utf-8?B?NjZUbXlZc3RySWsvYllzcG9DL090RWhUbUE0ZndJMWl3U2labG4xRDJqa2F3?=
 =?utf-8?B?Nk5MOFVxM09EbTRXbHl3dzZDcG0yNnVEaWYyMXNFRXVMQzVJVXo5eXB3cDRj?=
 =?utf-8?B?dnoyYUZpUTNLWGpXVEx1MEFIZzZnLzFVZmp3TlRoRTl3SHBBeVYrYittWFhu?=
 =?utf-8?B?TjM0TElRMzIxN1NQbGg0Q3U1SjJwS2krQUkxTFlKN0RMVVYxZ3J2eDVLalpS?=
 =?utf-8?B?QlVGYWIxTmhuL0JTY1N1bnNKWHBYMTNaQ21wNTNvc0FESHU0cHpTb0NaUGUx?=
 =?utf-8?B?R0VCQ3F2VTViUVI0R2hucXRLWEE0V1RmdFhqVVFpcGN6dUgvL09DVWZ4eHBq?=
 =?utf-8?B?L2pXVnVWbmxlK1d6NkppWmJLRXYvS21GNUt4ZzZ5dDZrWVQvOG1jSGh4YTFn?=
 =?utf-8?B?eXR4RGRCaW1Bem1yQ0JSYnBFQ092WHgwaDltT1MxZFZNcEJ2UEdpdzBlQ2JX?=
 =?utf-8?B?NTFEV1lXTHMxQlhGK3pDV2dTS3o4WDBtMVlRamdNREduTnFRTkZEUm1DTFUy?=
 =?utf-8?B?bTNtUjFHWHNrMGV4RGtYVmZyREtUMDJhdy9keU1tOW1IR0pKQ3NuNm9ERVVY?=
 =?utf-8?B?ZCtmTFA3dWJBaXdCcDBkeDNyLytFWUVISXlCdEZ6OTlLWENsOVNhQk1wd1o2?=
 =?utf-8?B?YXBhMzBhUnFBS3ZpNll1QkpTUlFhTEp2ZVZxa3JXV3VJZmtoZDVVbVVkWENF?=
 =?utf-8?B?YWkrc2dFZzJXY21SNDBJVUoybG9QYk5ZQlhCTDBROGRuYVlsN3RCeVl3cXU0?=
 =?utf-8?B?ZFNBQzBUVkZwcjdkL01CUUNEMk1yMFpyRDVQVDk0bC9HMDQrS3ZJUTAvWmg3?=
 =?utf-8?B?Z25WTWFEU3ZRdXB1UTZsTXl1ampHQ2N2TjZDVVE5bEg1UG9Xb3VTTTA2OXNW?=
 =?utf-8?B?dU44VEVYSDZiVndaTVZ2dkVnV3ZGU2ttTTdBNXI5OVRTTG5ra0RiVTgwMkQx?=
 =?utf-8?B?UTA0dTF1bUVRZnhUOEhORzRJN3h0VXpHRkJObjloS1RtUS91aEFCRGs2d0ZL?=
 =?utf-8?B?RUg0TWZZVmhRdk54bDJoMi9YamV3cGFtQVdkVktKUzRocDZyUGt6RDhpWlhN?=
 =?utf-8?B?dlVLNXU1a0l5b2NDQXNJZXBOTUluQ1RyUE9kNm0vK0xBbUpxdzMrQ3NXYUN2?=
 =?utf-8?B?elNrRXhOaVUrV2cxYVNPR1pJMkRDODJXS3doLzB0WVBUNThVaUxORXY2QjBM?=
 =?utf-8?B?cHp4TDI4aEExd1p5V01WZ0llMm44azZoL21wWjZZdHNBaHpOeitQbDBneTYr?=
 =?utf-8?B?dHBQN2tDanNXR2REY0tjZmJkKzZWMGpBb2xNblZqaVVRRS82aE95S3FxWFBF?=
 =?utf-8?B?YzkrQ21lRmhjWlYyeG9pcjJRWVZyUDhENEwwRlFQSUdxcUpoZUNNbmFya09s?=
 =?utf-8?B?dlRmZ3AwL2ViZ0VGYitNUHcwMVErZnJkRVVkcHBhQWJIdzQwUXZhSkZYN1F1?=
 =?utf-8?B?YWtiMHdkK3g0OG0ramR0Q0IxRmpoNkNtM3hGc2ZQdWpabGNBTTFONUZmMHQr?=
 =?utf-8?Q?O6h5OiXAWOyqQ3U1ehbz4PqqWWMjAIWhi+vnicZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f756258c-b574-4611-0f82-08dc3d250573
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:00:39.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699

On 3/5/2024 10:58 PM, Rob Herring wrote:
> On Tue, 05 Mar 2024 10:19:49 +0800, Yang Xiwen wrote:
>> Hi3798MV200 INNO USB2 PHY is attached directly to system bus. Add
>> compatible "hisilicon,hi3798mv200-usb2-phy" for it. The ports of
>> Hi3798MV200 INNO PHY has its own address space, so


Somehow the commit msg is incomplete. Maybe the maintainer can help me 
complete it.


Or i can fix it if there will be a newer version.


>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 31 ++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
> Reviewed-by: Rob Herring <robh@kernel.org>
>

-- 
Regards,
Yang Xiwen


