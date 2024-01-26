Return-Path: <linux-kernel+bounces-40236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A488E83DCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168391F22FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665F1DFD8;
	Fri, 26 Jan 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="NW/Rzc/v"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4A1CA9A;
	Fri, 26 Jan 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281116; cv=fail; b=M8bC8pByDr4aoh9J7m6ZUS2BSfJ/d06DCf7G24NmWpIFaO+XdZIqvgdfw1ELR4EMIgSq4kVs6xD12OYswPxFxP6E/3tSm6AkFGlAa3GCsSty1sYq+E2d2LUR4cMz//PMi+dpZZjywkd8EAjjb0YOJbgi17qgNOVQLbsCFuaXdDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281116; c=relaxed/simple;
	bh=L1LBo3EmHljy0N4wo6uS24KfxGyxhrOe9FDDZAXSSXY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HcDZLZ/oVnLKvOoW0yjCZJNHvxFirntes9IwEABc9hVBa3rqrWWWUctWvF5q0eX0ZfAKoYwk3JAWaGl2XMlLVT/sFGwgp50eMtXVyn6o34m0vwdkFn67DccUmVBGcGoxUgNaW2MOZfAv0bJk3yaOVaHtyBPzeHKu4CljvU35ztk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=NW/Rzc/v; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEZV7cXC2JLpj6SdV3H2Dg6dkr2w1IpE+59odzv2Vg9VWHiEAvkAVd4zKHEC1BEnuPGbJtB759Bn1r2nPSFVfh7Pxr+lLhZOAp2MQnyGHkAZvRSXuLztpOMUZXZgb0fyKBT7L08KEmBQ5n2+/maPJkLbQch66YDKLnAYvBVgwbNWdCz7FBf6i69ueSjZ1JATY+YrGJBLXC3Fz+yGKqpmHslZlrHCfbJgEBdmXpRvExsF5A6L9OJOwIy5Iq2kHXLgRi00ZQobQdDlOb23CWt4m7i4dDZYqnv4nx9gT30errzgscqeE04xJ9pNVwZ/4rIZQv9LuKj8v3xukgAWmXUzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Avz5e+3EBr62BuVXgj6UPnkpZs3MvAqOK/jqvWr25w=;
 b=N0dTU1WSOo4LVAXO9M5U++homUxYWk0+pn87MpCtnGDuwcs/n6t7AiIp8h2tZ7yeON6Zw/XMTYnyH+TjPmbGpceZFQ0vAcgYNFMcne1vypSDpbCRvm99BN2n+brpkeErIoKPXzgd33ttDJcr4BRAIp6Ga7edq5v/PpAahMKtEMR4TygP2qPrVpBLz/sl1OnoCaXdUs3nnBy+tSdJfFWr/IOSjV61XztxbejR1oVqqfDusc8Dj3Utt7NR4DkYhULOcxt7B295LcGIWfWZqjN3e9vtwTTQhT66zOOYFYL49LjxpjjdgxaDNymqmvpkU1VGm0aeLv5ov10P0FC5b/RAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Avz5e+3EBr62BuVXgj6UPnkpZs3MvAqOK/jqvWr25w=;
 b=NW/Rzc/vjPiobwyC3PDI2BMv0ymC+h2Xr11AdKhv0tJRMfRdyOz1+4yMX0cDmogaUwKABQjI12iwb1pbdvhLuQsMMoKVYWvY0aa78Z3tQIVjkLsiko5aS83yg3zyuYfXwIRDnwzXqDgaw2FMy6J1HL617JDBH2SDfSfky9UwIfG07Es09tJSZbSaCBeRbIAmzPnM7BMwwmB78e0mOH087UE3Ysk1U46TV3a9zgX9yaH5L3evNUw+kHVg4tnRIoOGPIIgds63KN87T9wZFrYzY30dGIxDHAGZN8NKzbUtgASPFzqwWqcNDdyz89Iepaz05jJaQZ6euK0W8fQUmqtmfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:58:27 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:27 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 15:55:15 +0100
Subject: [PATCH v4 6/6] arm64: dts: rockchip: px30-ringneck-haikou: add
 rs485 support on uart5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v4-6-45aaf4d96328@theobroma-systems.com>
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AM0PR04MB6371.eurprd04.prod.outlook.com
 (2603:10a6:208:178::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6371:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 402d2297-329a-4ce6-3f6e-08dc1e7f4076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B2EHdQFhHVfIHVDeEtrMVG5Mn3scCo7JXD7IeFOHBW++LNmM0+tNyCZEl0eo1babFhMwJ6cw3K/fjfxSlka7CWj9eRlNJe3kJrXy4+dcg23n/F7m9Csl667rUOSQ/jSefDULzUDedzvUjIBAicW0LpPoyKpW6JqgbXtqFmqmsZcYVxVn9H/jtltxwYQ66r7v7Z40co3DFy2Z1VxJ+xBzYv+/EN3ct7SUsTe1ARdHvZV3sp0eD0fhA/pPNN/3pxsHM7pmN0yniaZpmEvHhhHPDE6gn/M88vuNHY+KD88cyNwKJTBFensfObIELiTdYw1H2969FcGnHsci2wVRlRzRIPDrYaDomY4Z0Z6tsCkwrMiORDb1aFuyv+HEU0vw9S3mTDVRFeboORzYSTgDfNFk7gqGVtJSulRx/FWjwuuHeArOVQy6n1+g3+au7y+Zc1sFEOyobVzChUSNkYVSiBzqGd14e0ynU305nbjsz2t0xVKeyjXsVYtZBughapBUvFMco52qNSTAzEfiUsNinCVkOJjXwRA5oBuJHdg+MQnWKz64flQtwfbHbkEGqJqw+B/AqIOfB+YlsBSlY930SCVoNoIhyD3KiOs068NB3uP0PE5pYxmBQgWKx/hURQUtLTbf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(54906003)(66556008)(86362001)(478600001)(38100700002)(6486002)(6506007)(36756003)(38350700005)(41300700001)(52116002)(4326008)(8676002)(8936002)(26005)(2616005)(316002)(5660300002)(66946007)(6512007)(6666004)(7416002)(2906002)(44832011)(83380400001)(107886003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXR3cWI0ZjRxNU0xTmswamRFSTkxWEpvVC93U2I0d2QzMWh2NzBPTjhoTklV?=
 =?utf-8?B?bkY3Z0h5VlBubnMzWmF2KzVHUEQ2TFc2VHpBU1Q1a2lRN1ZpM1VuYVB0Mk83?=
 =?utf-8?B?WXVYYkl3ZDVvdXl1RTJNTW1nd1VLQ3pxNStBakJ3YW12L05vaStOUDZpS2VV?=
 =?utf-8?B?eEJiWjl4YXIzRTJMTzAwNHNhYVM2NU1YRFlVUFhFYmJEN2k2NmhzTUx4SUpv?=
 =?utf-8?B?dTFSRkxKY1JBTmZ2UXNBa3dYTEFNQnM4QUZxdGs3R09mS1BPZ1hCUyt5TEUw?=
 =?utf-8?B?b3U0aHFLcUt0MG96MW9yKzFNZ0pWYnVXR1BUS1lxd3BGL25YbjNBVlhOeE5K?=
 =?utf-8?B?Y2Rwci9HZjVZaGl4MWNQNHM4Z21rMlBIbHNvV3daQVRzbXVxbnFHeklYenZ2?=
 =?utf-8?B?aW9DY0dDOFNraDEzNGFyZ0tXeDJReGk5aHk5MzUzdzBtSE1xK29SZ1kySlRP?=
 =?utf-8?B?L1pnbU0xeXB0dFpkc1NtYlFXK1I4aUdpM0NQRmtZaSs3NUdEOGZWcnRFcENB?=
 =?utf-8?B?YjNQZUF3YkF6cXprWmQzVG91NEZQclBoSmVyU0VoaW9zWDZrR2dlVW5QYVov?=
 =?utf-8?B?ejNDNHROdjE4WGZaNExqN1d2Yk53VWpDNjAvcnlSRzg2SmpON0JLdjRlMzZz?=
 =?utf-8?B?QkVrWmk5SHRQRUFUMlhVSWxXaldwN1ViTzJ3N2FSTTNPbmVwR0M0RTFHMTF1?=
 =?utf-8?B?bm1aK1Rob3gxSUwzc0RidU9leFV1WjlFYzVwOGZnSlZnMS94ckFyRE5FQWZw?=
 =?utf-8?B?ZThUOTg5bGN0V3c0VCtYTnpZZDRnSUhOOWk5WSsxY2QxMGp4QjMzSm1vaDRW?=
 =?utf-8?B?MldsR2RuZkgyNzlFM0xUU0orS2VXc0pTbnVuL3JOYVJBTWZqNnlnaFY1YXl0?=
 =?utf-8?B?VW45UGhrK2UvcmJwbGtGUnh0YUYxdDdueHFQTVg3Q0Q3R0YwR25ZT3Jhb2Z3?=
 =?utf-8?B?Ym5YTlNVQmdRd20xK1p2R1BDRkFvdlIzM1FyczE5WXh0ZHZ0K2xIT2lZRmtK?=
 =?utf-8?B?SW1TMU9xbnNENFYzSmg3dEhjR09nSXpma1JZYlJGT3FOT1VrL3NSaWFxRkFs?=
 =?utf-8?B?Z1VJNmVCRDdZTmFudHpKeUh4SjJkcXFJaUtRYXhHbkZDd1QxeStFWXpCVnR3?=
 =?utf-8?B?Q3YyelpoclVLR1czdW8xOHo0T3Z3bWZaT3NlL0NqNWFUY28rQ2ZZM0pNbWVN?=
 =?utf-8?B?LzNFQ1VXZThuRWJhU0ROT3NsSVFNMzFRK1RlekNPSkJReVVHSzhTalJ0SEgx?=
 =?utf-8?B?bytZcUc4U0FNY2k1Q2NXR0RZcnczb0llNk92SkFRREMrV3NiVzYvalpCbVF5?=
 =?utf-8?B?RXVra1h4dlVIc3VCeWR5K1p6VEZtUTNaUGkxbUpuWEVPRmVOSlYrRThlSWMw?=
 =?utf-8?B?TkRhZUtjdDFwb2VyNyt5NGNIazh2TmdpY29tbWpIK0dIRW9JcWJHOXpINFpn?=
 =?utf-8?B?T1hIWkk1cTEyV2YrTlNpNC9UYmJHUjdGNGdMMDRKdVBtTjJSRXhsb3c5dnA5?=
 =?utf-8?B?MWZ6aURZRFVWRE5CNWxTellUOUFkazVQUGlEZ2dxT0puNnlML0drMXB0VnhJ?=
 =?utf-8?B?RnJUamxZbWMrb285aDV2ME9WVE5HaUd0Tms2VmdyOGFQZElOYVVaamN5Ujhs?=
 =?utf-8?B?OXJ5bituUWplN1ltQ0JaU0ZXdnYrQkY2bVZYUkhQU3RVekwxc0JSMy9EQWRw?=
 =?utf-8?B?TEVYd2E3Ly80YS9JaStlL0pWczQ5QWZNdDJGcnNFUmFXUkFSWFI3VTd3L3Iw?=
 =?utf-8?B?b1dCeEhUR2p3dWlKSHJnL1Y3YzdhNGRVdlRuQnhCYzlmY1JVZkFybW1PeFB0?=
 =?utf-8?B?Q3hqOU9nRTZESUkyOEdxT1FWVU1RZnVJdFh4Q3pFQjZCSXNBQjIvaWh4VzVU?=
 =?utf-8?B?OG5rVmlrWXpwMUhlRUdpSXFJOEN3aXhLd0p3TkIwN3lRdlN0WVhlaVQ3Qlpr?=
 =?utf-8?B?bGFpREtjTmM5RnhVUWp2RXVPbi9YcTgrdkx1RGo1SlROSlJ1dklQV0twWlpD?=
 =?utf-8?B?RWZxbDRmb2JYcjFTbzRoVGFhSDNmNmhjR2dOMHZMZUhIbUlQVzBzNWVQK2pF?=
 =?utf-8?B?ZEMyNEhpTHRscEppY3o3K1ZIWThUVHBFd2lxa3NnL2hEUGgwVXBiZmp4bktj?=
 =?utf-8?B?cU1SaFlmaXRtV1lGVVZRT3E1eDhHeDQxWlFlcmNEQVhZUE9sKzdqN0hqbnRX?=
 =?utf-8?Q?3dcRZ9kCRdIMAorSbmRkIvw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402d2297-329a-4ce6-3f6e-08dc1e7f4076
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:27.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNSD3WHet0GRzBjZHYALvtbaUjYUVkP/uXjs6KuaQuv9S9gHNsPKQharQKbZscxLrQN+lMp3l3hf4rX/9hmeTwHQqVl6fQ1DAmFZEHTdpXQRTle+YO7ZGehzVypmgKxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

A hardware switch can set the rs485 transceiver into half or full duplex
mode.

Switching to the half-duplex mode requires the user to enable em485 on
uart5 using ioctl, DE/RE are both connected to GPIO0_B5 which is the
RTS signal for uart5. Which means GPIO0_B5 is implemented as rs485
rx-enable gpio.

In full-duplex mode (em485 is disabled), DE is connected to GPIO0_B5 and
RE is grounded (active). This requires rx-enable gpio to be inactive to
enable DE as well.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 16798eb77077..369a6518a487 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -227,6 +227,8 @@ &uart0 {
 
 &uart5 {
 	pinctrl-0 = <&uart5_xfer>;
+	rs485-rx-enable-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
+	rs485-rx-enable-inactive-when-rs485-disabled;
 	status = "okay";
 };
 

-- 
2.34.1


