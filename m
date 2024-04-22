Return-Path: <linux-kernel+bounces-153951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13B8AD542
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3FEB2361A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A4157487;
	Mon, 22 Apr 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DVrpZCoY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D3156F3E;
	Mon, 22 Apr 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815443; cv=fail; b=UQSSk7cnCF5Rh7JVG3tGVLgngY4itT3rXuCXSndxQPeiILjzz1QcrbILXZ7ljp0VS2FTrInr35jLYURszIMigQEpDMEbDNoBvLsTqx7pBEKTyHrXFVJUhqSGdXWFBlToKFe+XwiMZY9v28xywNrwhCbk+BC/Q4kbnP6K3CS6UPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815443; c=relaxed/simple;
	bh=0ZRbRQcNzLlc5p8hNyg69kRtTQG09ucYbKiY+xtKRF8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g7K5XlLkY0wsK7TqJI+AudR6ebUCqbQdLY3yPmGUxNq2iHB1leZgEAdl9y7vTfn6PKFSb5Ahr6LDNMIGzTJWfqdpw0i+978R+xC0/YU98BkM88jzmQhiLtLB6Vt7lhYTCxo4c2SlnrFeNsy8gQZ2eaOjLGVnT5zg81Eqcccu5SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DVrpZCoY; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nlhn19xXUnSuIuuFB8+r2BigTGuacygCq3Hhl/vSHL+qBgulVhqTJ7wDAVWaQxMu/QA2uvg5HPY/ajWD2l8AFecw5VgBEObjMQsjVHDL4rDidsEeE8Ck0c1Cfqwm9Hufe9V91FKD82RBLwoyb8hsZ+G3iF+L5GfdRbiAOzuqeVKgqOyUkOrY1EzMw7UW6QLHTEb877YZ9ob4Y05lOqypGeo4c+mPD5/yQ2xFRjxSy02bTAkfAxtlqEAhWcEhJee9LOb53GfR8gOwrBLG44xxcT9TpEFxSLbnF4MrXabkc9+FQneLHLcwoziP8KJFbHEAdCC2yEFMtMYSBCwgOEnCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtMTD/4S3J402A4i3R4PGR6JLD2G4mFmwxoe0/4aREc=;
 b=lT1zmtKAunfYgUiP+7zL7RwQxKbA66GNIIv+iz6+MSzE9/AViMHYS8/NSDzW7fRyqoz/ktRatbzRJdr6RQX+nYT4GStAG3b+acZBTFg9KEauhLoxToB7NB2ftOLDXTW6fYTgW3E/ypH2q76e18VCThqxBtQqclpW8vg/lfGiT7tPah/0kHtHA0+ymWSsyq9hGvi5A5mKDbHsLYwX4Yj/2re/KLqnhD67etIAa2KHoDMwYN+cljhkyDx7732HZrnCh3yhXsWhh5qSo+lg47CJHWOiETm8hEyxdHm37QSBRT+X9FuMdTycvhKQOnvriLCY+7KagTepYqOD5PVw0ghhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtMTD/4S3J402A4i3R4PGR6JLD2G4mFmwxoe0/4aREc=;
 b=DVrpZCoYzR+SgCbIPlRlRSJ9Qn8bn9JyEQJgU67Mh9/2wxpn1dlahs+/ac/EjuyUHORpQ8QTYB64Yk04ehW5x30TNJeKaMopcJjJPpT64BzpRq86Tllu+s8p0c9fddhIeNoB32a1MHon8CEvYVBBe3se6V3mD5mBC35mOgSfvWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:11 -0400
Subject: [PATCH v3 09/10] arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-9-680cee731ced@nxp.com>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
In-Reply-To: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=915;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0ZRbRQcNzLlc5p8hNyg69kRtTQG09ucYbKiY+xtKRF8=;
 b=CJNBT1TcuR9DfMmHc7m34bbKSa9weJPZ8epUIvmb5IgLGV8fOaVbnv1dnIvChs3wrgb6W5VVi
 MA917wRZnGdBg3+ub6oSpSDNBLRaBGSBXwP1A1syw33OO9+z2iuaINe
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: efef3bda-08c7-4a7c-aade-08dc6305790e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG9FSElIT0QyR1Z4YmlsUVVUelhudWVKdld3ZzZGSU1uM1czOWprNmo3bS82?=
 =?utf-8?B?UTA4T09saTRPUmxjVkMrQ2RxY1hzOXJyN3FiTXowMnFSVElCUURHUmcrTGVV?=
 =?utf-8?B?bGRnK3l1YkhMWkF6clVZSkh2TzN2byttK1dHQVVGcFBUVXNYREE3THJJNWxp?=
 =?utf-8?B?VGQzYVZFSmJBVlBvVHIvaG55aG5acHYrWi9BV2FqQTYzaWMxNGsxUWF6cWZ0?=
 =?utf-8?B?TTBjc1lxd2ZFRUR6QU1FeVVFbDEvb0dySWpNZGdBK2JzYkV6SXN0MUxjMnlN?=
 =?utf-8?B?WWdKNTYxZVhSVkplSk1scDZESE53aWRjVFZxeGQ0U245MHVSOGgweU82MWh0?=
 =?utf-8?B?ZUxJbWovQVJjU0M4TVZIN20rU3V2Z1pTdlFpLzBMT2pGZ3YzTi9mbmxlMGU5?=
 =?utf-8?B?b0YwVDlnV2x2UEZVOTRORXpxcGROTVpxZlNhNjk0eTNwU1dIQ0pXY0VDbHZz?=
 =?utf-8?B?Z3JXUWVhL0lsTXNXLzlPTEJvQnFtaVU2d0llMzdtejdMWUNTaG4xV2ZOZCt6?=
 =?utf-8?B?MmtqSkRUbS82NDFNU2JrRkpoUWhRMGQ3Ujc3enlnZExrRG1mSXdNOUZGK3Zk?=
 =?utf-8?B?M1pCbUQxYmNOK1d0cmc1bDFYMXBFeVBYUVdoTW96bkVTbXd5cDUwalBxdjQr?=
 =?utf-8?B?Y1oxc0Q2UHZPd1ZqUGdieGdlb1VzM3gxNlY5RjY0UHN5aVNkbXEwMVNGbzZm?=
 =?utf-8?B?cGROenRJSUF2VG1PU3dtZG0vemY0aVRxUVZ2cmxYTUZzT2xveGw0Nno5QXdN?=
 =?utf-8?B?ZlR5eG0wMUlRcUhWdmYwRUlGS215cHJFM3J5V05LdjEwMjlaQlNVVndOdVg0?=
 =?utf-8?B?ckdDdWxReG5QSmF4MGVLWTVKLzZXQWpZSGVFMGNCTDJMSTl0T0ZzNUhaVEsw?=
 =?utf-8?B?VUhxbWFsc21TZlR1VFZjdGFuTTBBL2oxbXc5K3JRSytpbmVscmlmTVprZHhD?=
 =?utf-8?B?RVE0ZENtQ1RsMk96MU1RRkwxVUZUbHNyME5acVBDUDMzZHhubWdkbWhRMDNN?=
 =?utf-8?B?dVRPYzl5a0VDV3IvWVREUDhRTDE5eUM3RXo3TjBpb1NwbDdlaTNRL3J3d0F0?=
 =?utf-8?B?TkV6YVo4Y0I0bmE0aGpmRlplRW5WbkpKSDJ0L2xybWtLVU5mN3paY3dvMURt?=
 =?utf-8?B?amJMeGsyeUoyS2xqUHlFM1ViYUU0Ykx1UlRaWmt3TEhkWC9xQnhXbFhISXNB?=
 =?utf-8?B?c2YwZWJuUnlwbG0xUlJkNVFPVnU3aWJxdGVaNTFXK25HUUIzTGkvNTZKUHpw?=
 =?utf-8?B?SGx0ckFJbHd3VTVwVWZwWlRoZ0xkVWxWaHNuSHdlWTN3eDkxQTU0NjkxUm5Y?=
 =?utf-8?B?dXFmbG5nVGY2TGZPYU8zTW9yUmRuUWNqZUhPNFlPa29LMi9GaXM0WEtYQnJJ?=
 =?utf-8?B?OThSVThQOGJoN0N5eTZwa0N5cjBBV2ZpNTVzaGNNd1U2b0ZyQ0V3enM5ZzhO?=
 =?utf-8?B?eW42elVwU25BOFVzNWhxVGlVWTV3SEZJa2JsTVZMaW9pcWtVdFdPWElWWE5L?=
 =?utf-8?B?T2JZN25LUVFZalNPOXp5dzV4S055UHM5TFRUUEM0K0NxK0ZOS2FLdXRnL2lY?=
 =?utf-8?B?RnBlNlZXQmIyMkJkSjFWVnhmM3JHVTBKNDVoUFowY3ZCZm5WMHhXUXlsQUJE?=
 =?utf-8?B?RVNZOFppaHJabGRZR3hLdVBROGZ4MlJZUjNSelhlWXhyUXA1YlhFdGRhYU40?=
 =?utf-8?B?Q1kxRzJIeDlTeUMrUWtJNHJDcHZ3TVZlbFQ4VHFVcjREMDRsY0hKNGx6V0ZN?=
 =?utf-8?Q?03n4iIjOUa3IifXg0Zlx6/iWTMSbMUKdoBn3NpM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUVBSnQyWG0vd3M1TjQ0aUdjZmtMWHFkS2g0V0FKK1BJcko2azVIckRqYU9O?=
 =?utf-8?B?VnF4YVE0ZXFnK09UdlBUNkJvRjBGcm9OY2pPZmloZHBCc2REbnFKRWFadFUw?=
 =?utf-8?B?Yzg1dG9EWnBJcmhOTGRnUXgvMTEwV1F2YW4yQkRXaUxvcXhKQUx2RCtVQ2No?=
 =?utf-8?B?dVpJeW9tOW9iQk5UMG4xRWNORlZVRkxERFI2QWFZc3lDL1ZlM2dNTkRUUXFj?=
 =?utf-8?B?WEtkMVYyM3ZXQmR4TEloeHFoQkVZVmtSMktSKzdHRWZEeS9CMTNLWTZJbG1J?=
 =?utf-8?B?dUxDTGxkd0lUOE54WUdxbFlmTVd2cUNZMVo2VXpYRXNzSGtCbHd0QlBkeTcv?=
 =?utf-8?B?WkcyZHpHOHlnT1ZoQ3Jrc0psMU55L0owTWFjYlFkeStXR3RmRytYcHRyaGJ0?=
 =?utf-8?B?TGwzK2tsZ3pJNGRKcUswNFlRd2QwZkVoVFJBb3RlNGVNSFlYVjB6K1NJemF2?=
 =?utf-8?B?cGFpNTdXQnIxaVNTd3ZpSUJleWJ6L0RNMERDSlV2d1lJNVBsWitWMVJzY2Yx?=
 =?utf-8?B?bHBpRTNFUjlzTE1wckJvTndqaEUzV0cyZkd3WWtrZU1ZK2ZxRGVQVWdoYWdX?=
 =?utf-8?B?ckdDNUVEMGdhUStPSEpJZzMyTEIzeE5PbUEvbkM3cVRWdERVNENwWWJBaWE2?=
 =?utf-8?B?YUFraVFFcjQ2QmlwSkVDVzliSVFYQWo2dG1DTjB2OXBnVHdTbEJsUHVTS3hi?=
 =?utf-8?B?L2k1aG9IRXUrQ3JtczBlSTJpUkhYYXpOeXY2M1JBV1BsOGdvZ0g2cXhxZEM4?=
 =?utf-8?B?byt6TE9LeXRYR21TZE5IemtVWjlBNzdya0RpaXVXQWZtZEVPTHVWRXVEVWps?=
 =?utf-8?B?UGFnQjBONnJLL2FLODhHT3MrMTJiS0ZIQlZsbFkvemFaZWNwRUtmZHJiUm1L?=
 =?utf-8?B?UDhrcTcxekF5d2tIOXVrSHdiRUhmYWRVNXhUTDN1M3ZPMkRTaXVzQkhnc3VS?=
 =?utf-8?B?YkxwRitnZk1RYS9vRkh2TzYxbzRDbkNJRFZmeGpsNVdkdTg3UU5uUmxkRnp3?=
 =?utf-8?B?U3Y5Y1ZiQVJPTUNEbE95TncxNFNHam1MMG5EZzNwSXRZWFVRSG1VSU4rR3g0?=
 =?utf-8?B?am8yaTVMem1nOEpUa2dpQm50OE04TzAwTFJ4VFNsanVDdFdvVTk3VHh5Z2Ey?=
 =?utf-8?B?Qmh4bG8yUC92bHZrTFhGQXA1a0ZScDVvOVVJT0huelorSEkrZTJQQzVhOU1F?=
 =?utf-8?B?ZkJXNHMxT0VnS2JJejdIZDcveFlYVDY4UW9oMzRFcCtqSVhFaTJmdElYaDN3?=
 =?utf-8?B?NDhLV1kwaks4aXdHZ3pBQjRlR1M0dDUwVzZBakdCUkVkMXV2ZUFRd1BOazA5?=
 =?utf-8?B?UHZnT2lHKzhFK3RuWldXb1I3KzBoOVlkQ3BvQXFVU3Z4MVo3a252a0pCZWxN?=
 =?utf-8?B?RW9KLzl4d3hMbjRLcFJ4T2MrSlJBSFE4Ti9Hd3dQWjVISFBPb3AxRVo3R1dN?=
 =?utf-8?B?OFJrTlIxTEl1amNtRlp3U1FGZlUvNkhFaU9ud3ZFUVJpcUtzQ2d1S2lsZFhl?=
 =?utf-8?B?dXVCNEdJcWs3K1FKM1Q1ekZ0R3BKczQwM0pKaUNvQVFrOTZ6c3gxZWJSaldO?=
 =?utf-8?B?VWtBOEFSQWNDN2JSdTk4QVVDZXFOM0xSelZ2L0dYMkhMUGZQNmcyT0ZBcUM4?=
 =?utf-8?B?NFhlOFZlZDNjeVUvWldoMFFMVWNJUm5vekFnai9WL3FCYk5lWlY0V001NzQ5?=
 =?utf-8?B?dERtekJsZFpEMm9xNjg4NUNZbFJvRkhzeXVPTGlrbThnYUtxUE1DZy85R3pw?=
 =?utf-8?B?L3hldzlYeVdSdFFpWGlzemNlVWp5L2t5NFpDRkhPOSs5aWFEVzRZYzNZZ2dV?=
 =?utf-8?B?TmRueTVJY2kwY3g4dW44aUdiMVdpT0VWSUVDeDBKQmtuNjNUc3FSY1hMUDhz?=
 =?utf-8?B?UlI3UjFIQTZiYThNb3hMWVpNUnQrNHRLbVM0Wms3eFJGaysvZkdoTmxqL0ZH?=
 =?utf-8?B?cXpvS08xUk9XQ3FhT3NYNWNiZHJhSk1MYlRvU0gyYmN5YjBhOWNqVk5wNFBP?=
 =?utf-8?B?QzlleFBpbFhISzl3RjlPK2w1WUs1UWxRN3p5VlMyemxuRnpjdURVVHlKUHo2?=
 =?utf-8?B?dzRFVGdtVlNNdjloREVFS2Y3OVhsQzljdWVGK2FKUFA1M0ZjR3RvRURCMHJq?=
 =?utf-8?Q?QukJ341I2xGkr2789uHnLhind?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efef3bda-08c7-4a7c-aade-08dc6305790e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:33.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53hiAcX7x7zT0jshkI9KyqgnAtCcY0U9usPN+PHAktfwEkJw3VRN4m9ixEfRCAHZnatERs0JglbSqUGzD3lyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

add ocotp ad fec_mac[0,1] for imx8qm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 96a940c6046d8..734bee4294dfe 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -333,6 +333,21 @@ rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		ocotp: ocotp {
+			compatible = "fsl,imx8qm-scu-ocotp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			read-only;
+
+			fec_mac0: mac@1c4 {
+				reg = <0x1c4 6>;
+			};
+
+			fec_mac1: mac@1c6 {
+				reg = <0x1c6 6>;
+			};
+		};
+
 		tsens: thermal-sensor {
 			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
 			#thermal-sensor-cells = <1>;

-- 
2.34.1


