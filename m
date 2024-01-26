Return-Path: <linux-kernel+bounces-40432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515D83E00B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14DB281A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8181208D9;
	Fri, 26 Jan 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="DqOCkTAT"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6D20310;
	Fri, 26 Jan 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290123; cv=fail; b=YXMgIcGBYFnj+eATIHFoSn9UxNqr2Q/RiAKUhkYuuDL5kNYDSpAawY2zPf5jOVk82PRMF6Yk/IpSjwergp4qSHZx+EPXOsff1vLC0Z5/Vfusq74EcdunkX1/jSUVDWjtIk0Tjm1lBE2lIwVA9ktdVfGUbXuepTP8SeDZMTIb7uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290123; c=relaxed/simple;
	bh=NRrgh+Y9FIMseBhbOBZyhEbQUd5QdnX7T6VYG5vpoOo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BQUpGXe4s0di7VLO1dvKwXG2qPxVNX5G8OXEROVWvjNAdxLyGU/GVvfwAYDqyXfjHxBax5uc6KonFiZWxo83KRiG34KqL1ILZwix0QfZUNu1s+wUZT6mnXNu67jJ7GG/3OJalS17+Wi9Y4V63JbFC4Rack+vzMiZ31+dH16icdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=DqOCkTAT; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN6fy3Rp9fOOkOrqNREq14ptydzsnXtAj8xD3NNg16gnfrlcYz0phBf3SzhHDlQY5+f1Gf5oCf0lNGRb2H6j6LJm4eb9+nFvIi5j40nBFCB9+dLk6u7CB+n7ltV6nhyNnNmd0DXrx/8QxiEYmi+D6QFXnusYVCDRGdZn9xlGxBO0oGRPTH7ScGnB0oNlY0h3ibp05dJqEWUV19C8A4OisavraPVjczCNHBjQ3/c2AWoLormf58uvMYhkyXPdHUqKPTVCsUySAcZXOY8lXSnr7d2sj+pANTir1cOcFhf85odly4CIn+8f2gftwTXiGItD2wO97k8QggtbDk7F3q/9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=parlSHQK5YZjdQ16b5JzjP0e9/POUszZXm2OhL0Vmzc=;
 b=GsOcDvQjFWdKm6cQjaisK9FBuT5cX4PIeOVVRY10UFIrhSKntvG7N0ARQXm3tcUfqA2CkPsSOEmKLHzpOCWT8cm8+vnOsGDmECSZVIRYEVOUOQ37cZsdPGh0jMHwVOewWsWWf/XkDObdQm90w0mBitAiR2XGPB1pKNgq/vgtxpB+4jfLXOLlHnruaQh33shDUtV2NyiRb/PvIKglr5/mWO8kCJHKfFIoKN566LlYx1jK0f2luttMX2RebduoeP8TGoRRKOrkg0PdLqbqd7N58WfhSQzMPQyG+MjskCfxsVp2wAPPppGH4BmsQk+7U+sBFzcTUJKkPOD/Z7NQnXhfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=parlSHQK5YZjdQ16b5JzjP0e9/POUszZXm2OhL0Vmzc=;
 b=DqOCkTAT1CZl/ekaB4Rs2sNQf9Xg/bJViyBAbO3bpvj8VZM1JTcgtAG+fADyU1GVJq/huaWUqjymaHw2xI0HT3+SzOKOU8OJtoj7esZdvexdC9Kj1gPzET4wq41WIINS4vLPgl4NkBKN5fSvCDWPCBk91vAO82b2WwWVrjqLM27Wl7bpOhFRY2p4UZI41Ji4shrXzyixsxnW3sXWIjWyLMCxbMuHcrYU7GtNmPVSdY/h99Sm2FsKARRtINvdB2lpWmZ67YQlt7SKZPr93eBGtPad24oZW0XqHyXD1b0jNknVWj0WKq4+BfPlH8D3K7pJCi9ScldDyox3no+zzzpHuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:28:35 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:28:34 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Subject: [PATCH v5 0/6] serial: 8250: Add support for rs485 half/full
 duplex on puma/ringneck-haikou
Date: Fri, 26 Jan 2024 18:27:41 +0100
Message-Id: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3rs2UC/53PwYrDIBDG8VcpnmvRiSZmT/seSw/GGRuhiYsGa
 Sl599oeloVuetjjNzA/+N9YphQos4/djSUqIYc416H3O+ZGO5+IB6ybgQAlJGiOVHi6cJrtcCa
 OxkiDg+8cGFZ/vhP5cHl6X8e6x5CXmK5PvsjHdUsqkguuW4POWuvAwecyUhxSnCzP17zQlA8uT
 uyhFvVWUlXyTQ/eSaW8NBvS/qeq/UtoFCC2NCiU/f8Epa31Cvu2AfOuRv+ueZF0lUQnhKROIjS
 b0rqud4hupgXOAQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: acdd3803-7402-4637-e53f-08dc1e943910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SM/N5GSqYRTKTHjb+Gc5QmzGhw9R+T8EduscFf9ITmS4febcckg1iEqcRuzHz9XWIIZVVpl5HzXf7BxwkpAi0yiml71zqQmvi5tMvWS1ZGbQOe341ot5OVjLJwdDL+/O+SHG2p70/83cUrzmXVmQF2h+48dT/yHevvOQNtXKmF0AEWNehC5VhqyxFy6/XUVXp31PP6COtxtOa4+nPLuoHFo3PcYoCnXbyuHdQ5R/LxUwtpvxLB9gp0w4lf4A2WZdG0GR+2mFcqIiBesFJxDI7hukiMhGp5ly+EmUxV2ocvTo7vcr6Xl59dc38Kz1mVYQqC31Qsos0bLjKx608rZhG8Yr9AvWtHldQWgv9XZNUQGIsCH43SuedzAfcU26msgxPlsQ2QSW+TKWRA2Es3ydXRH00HtyadbQPNBeQZAY4/8/CwWA5Gqt2eI/vX179hQDfowFYHAms8nqPi1EUCFOYP0/a6hW6vce5pxBOUeLPR7h1v+T0aIkeGzeEUOd6qUfAYViuoVYSlxLhYkfHwEF+kV3p2NuAgD1nJFNVzY33fAscpBfJpZDZ68Bc06vcYDJiIIef5GF7azTcZArJSaWF2nt7xdIpzCNpnJEgazOkNm3sGofQCZOZt1fxfL5hU2tyel/03mZQsXNENkbMp7zvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(366004)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(36756003)(478600001)(8676002)(4326008)(7416002)(8936002)(66556008)(54906003)(5660300002)(6486002)(44832011)(966005)(66476007)(316002)(2906002)(110136005)(66946007)(86362001)(6666004)(38350700005)(52116002)(6512007)(38100700002)(83380400001)(6506007)(2616005)(41300700001)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1lHNlEyMTk5MUdhK2VTdzFzOVpMdGQ1a2hDazM2RFl3WkJ4YjZqQzEzM2x1?=
 =?utf-8?B?aWo0N2RCVkFUMGxuVTZqbUJEd2pXU2JFVDI5NXBRaWZXVkVFNi9Dc2c5NUxX?=
 =?utf-8?B?cFlCSWpXNkRBUStzUytkc2t4cnJrUWlZekJHVUZoME1CK2hMeXBSUU1pV3dq?=
 =?utf-8?B?bnNhbFlHRmw5QUJQUlhTejNmUHRXZUl3MmNJUnNsNHFKOGh5U0hRMStkcHJ2?=
 =?utf-8?B?N3VlK3JCemM2R0RXbHFRTVFWbkVIUGNna3pmRkErRU1qNisvUEJqbVZLd2Vm?=
 =?utf-8?B?cHJZZ3NiU0JudjN5KzB0MUlCMU9qVW9JS1hBdGxnN0hQSjFKeWpseEJGNVIy?=
 =?utf-8?B?c054c25KZGRncENpUVJPWHAwYWFWVlYvNGRMY1h1endqYWNiTXg3Q1U5dkZq?=
 =?utf-8?B?Tjhxam5SalNKalFBSnJTSjZYZExpczNyRUo2aWMvd0x1ZGdJWHlFQWdwTEpV?=
 =?utf-8?B?UW5ZdFRPQUltc1JuTXFSNENKcmxQUDlDRkFjeEsrSnR4azNlcHF4Sk1KbnB4?=
 =?utf-8?B?SVJ0WCtMSHFFQmV5UXU0cGswRytFTmZFdjJic244RGg1ZzAxcDN6ZXNmZExD?=
 =?utf-8?B?VGJsb3hvM3YvOHAyLzhQM0MwcHpkZzF5dk10SmNncXpqSU5yZzNadkc5amFG?=
 =?utf-8?B?YWh5U05yM0lzL1VpSkZ1QUNrQ2JWZzNSNFJOZEozdEppWnJzUHNiK3ByYnNt?=
 =?utf-8?B?eEQvV2R3MTVnMHBVem9xdWtFb0FKek1MWFVPcmRPUHN4b1Z1Z0x6UGllbWJz?=
 =?utf-8?B?Vk42a0FrSzhkT21SUE9QTTFKZGQ1NzBuQm1NWmFSbzhucDBtd01lRDVYVHZx?=
 =?utf-8?B?OW1YVUl5cXMyRy8xaTFWbDFHTjVkYlVOL1FPbysway9KUHBZWmpUaW4zeDA2?=
 =?utf-8?B?UTZjbFhQcTB0bXBRczFyWnhuTEFtbjBBSHpPc1VLN0RXeTdtZ2YyNHdvRW50?=
 =?utf-8?B?ZHI4Q0M0T2dWd0o3U2xFQndtSTZ0eWgzQ3FhTjlRWUtXZHNiT3hUUGx3OWpm?=
 =?utf-8?B?Wm1pRFhoYlJqZWp5SzJEd1lZRk93T2VPTTBMMHpuQ3NWc0JKZklsYlZtTlpu?=
 =?utf-8?B?Nlh3R2JDMFNJWTNCR2hmL0xuVXVreE5QL0pnbTN2bVlieFpRRE1COTVIbGpU?=
 =?utf-8?B?YUdFT0w0U0RxdzdyaGN4YWdLeHd4b1JhMFByVnlTK0tyTFpEbEtWWHUxblo1?=
 =?utf-8?B?cVkzV3BaaFZENlBoMFFqZFdlU09zRml1aHo4QUt2VUNhWmRTc1FnTTRnTG83?=
 =?utf-8?B?YWdGTFVnMXo0cy9LdGtQSGVJQjM3eERiMER2dW9NdWw2cHVHaDZUbVdHdmZI?=
 =?utf-8?B?SXV5UDNoM29MYmV2cHhoTmRHOENzYUQwWWIrY2tZbUJ5bFZqM2MzZWNQTTht?=
 =?utf-8?B?NzZIZWNRRi8wb0JoU1ZwOGQ2N0NyRVNWdXA0YXV6eUxac2ptUkxHWUp2Slp5?=
 =?utf-8?B?ZDZnVUc1bjRYT0tOdS9vd08yYm5wZ3ZSZXl5NU1wVjJIMmdWd3pKSWRiN0hk?=
 =?utf-8?B?T0xQWnpRRDQwUGFPYjNnOHdodk9sS1lxenpubGxQaWcwRWVCUnVya2RVbVlZ?=
 =?utf-8?B?YWVUZHRrekZmc3hYc3F6MVY5NUJXR0N0TjFLczdWR2dIQ1hzK0FoU1o4R3g0?=
 =?utf-8?B?R3JmN2tLcGp2aDZIV0JsaXRIbkZ3Z2RONVFVQjBTZlkySTk5MUdibjh5YTJF?=
 =?utf-8?B?ODZmK3dvT3d0TUx3MVZGdVVLcDdHWUcrWkZubUtkRyttK21CdU03N1JVanhk?=
 =?utf-8?B?UkcxQlQzbVhORVU4TFdXRlBVcUlnSGdDUDdCOVpzVld3OTB6MzJsQzZrMWM1?=
 =?utf-8?B?RHo0Z2NaQ0tKbXlTR1lUMHUrMVNNbGZqQ1Bva0dxMDQxSStxN2lKUUpaN2RN?=
 =?utf-8?B?WDh2cVRNcVpLelJUc2xFUGtNcU03eGVGRzZCMFNPL09TdHlKb2oyODBGUDJP?=
 =?utf-8?B?bWJ6MHpBY3dkRHNRY2JTcWtqUEtpWS93L09sWjVWeEl0cWVpTGVmaWdRM2xm?=
 =?utf-8?B?empOMnFCZ29LY080UnBPQ2ZFa01xVDI1N2xxaElFNnpMNFJ6cUZUQXFmL3hY?=
 =?utf-8?B?QWE5TnRVeUh4azVkcWNRd3czeU4ycnhjakJja0pTVVF6cGNFMGlkNmFBYzhu?=
 =?utf-8?B?bFoyQmFZQkVYUlExd3pBdDJyWmgzQWtPMVR4QzBZUm85ZDVKNDNNZC9aNHQw?=
 =?utf-8?Q?GpXgn5MSPh37VL9X2xDZH8k=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd3803-7402-4637-e53f-08dc1e943910
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:28:34.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSe4Lkdte9WQccOXkUjtutcWYxVu0ilDiyWffXLVNnCaV3c/vug6YeLY0ZWb4VKLM3AW3v6UCnJbQD+cnHWTWJl2zAvcf4/Q9UPn9xe7Nkxf2tixY6J55WkxZc3fbZYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

This series tries to revive the work of Heiko Stuebner from 2020

On the boards that we are using (ringneck/puma-haikou) a hardware switch
can set the rs485 transceiver into half or full duplex mode.

In half-duplex mode the DE/RE signal of the rs485 transceiver is not
connected to an RTS signal whose control is already handled in the rs485
emulation (start/stop callbacks), but rather to a gpio. And since enabling
the receiver requires setting this gpio active we need to do that in em485
while receiving and disable it while sending to enable the driver mode.

In full-duplex mode RE is grounded and separated  from DE. Meanwhile the
rx-enable gpio remains connected to the DE pin. In this case the
receiver-enable gpio should be disabled to enable driver mode in parallel
to the enabled receiver.

This patch-series adds support for controlling the receiver mode using a
gpio in em485 for half-duplex mode while allowing users to keep using the
full-duplex feature if em485 is disabled.

Changes in v5:
- set port->rs485_re_gpio in "serial: 8250: Support separate rs485 rx-enable GPIO"
- Link to v4: https://lore.kernel.org/r/20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com

Changes in v4:
- define the state of rx-enable gpio when em485 is disabled
- add rs485 half/full duplex support to ringneck/puma-haikou
- use dev_err_probe instead of dev_err if error is -EPROBE_DEFER

Changes from the 2020 submission include:
- external gpio for optional receiver-enable handling
- Link to v3: https://lore.kernel.org/all/20200517215610.2131618-1-heiko@sntech.de/

---
Farouk Bouabid (4):
      dt-bindings: serial: add binding for rs485 rx-enable state when rs485 is disabled
      serial: 8250: set rx-enable gpio state when rs485 is disabled
      arm64: dts: rockchip: rk3399-puma-haikou: add rs485 support on uart2
      arm64: dts: rockchip: px30-ringneck-haikou: add rs485 support on uart5

Heiko Stuebner (2):
      dt-bindings: serial: Add binding for rs485 receiver enable GPIO
      serial: 8250: Support separate rs485 rx-enable GPIO

 Documentation/devicetree/bindings/serial/rs485.yaml   |  9 +++++++++
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts   |  4 +++-
 drivers/tty/serial/8250/8250_port.c                   | 11 ++++++++++-
 drivers/tty/serial/serial_core.c                      | 11 +++++++++++
 include/linux/serial_core.h                           |  2 ++
 6 files changed, 37 insertions(+), 2 deletions(-)
---
base-commit: 5ebe731c2a586b379103f736cd498bcca3cf1ea9
change-id: 20240125-dev-rx-enable-d8818dbf7c28

Best regards,
-- 
Farouk Bouabid <farouk.bouabid@theobroma-systems.com>


