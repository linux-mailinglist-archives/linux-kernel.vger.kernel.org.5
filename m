Return-Path: <linux-kernel+bounces-58294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F784E428
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C231F27090
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68507C092;
	Thu,  8 Feb 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="adr0xMYk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D007C0AF;
	Thu,  8 Feb 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406870; cv=fail; b=WF5vwSu+vzqsfVdCaJRjFbGCSdefJeNuo3KhYcBiIK5cGb9MMUoDGymtZV6zvZ7JZM3Odo6TtQjsDLDGUiN2vXmwLELRqEFn4XI1fGbsowf9halVDMZTHh9JXKqOjZqE95ThZMmss4gzHlOls6m26ixIGz7CNnQHd9BhWKvRonI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406870; c=relaxed/simple;
	bh=gquAvkpDZjUkNwoGbcgbREdZMUWh/clynuzwvu3sdvI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=d90cPLjIu6zUMS3O6fH909QPmWkePb77yJjn8YlKqegfpI20/RQlH7Z/0rhUo/+LUfoizlNT64MIeb32exOEgywXEZMyztcyM9APjLTvm6q/4nzbcKy7i8ZbTeru8QxbkjvRF9XaFkT5awEbZOBDL4rOkfcN57pEtFznbX2vCCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=adr0xMYk; arc=fail smtp.client-ip=40.107.22.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b79GYfjp3cmG2zYXMwiFU33QqSC86CVAYcNXpSQy1t4y2jXmsCP499JilsFXn4xS1yPEgMkU4w9VWR6CW3lThEwMJmWeeR5pzXvUEZg1UOeXKE5zwJVQXpK2I1fY/xoGofrT2qhMXTGJK+00IOVKN5D/LCaNzFpqFJHZVaBniuxwqGh2TRjsvGMmGE8GTYFA0Hyx/v2/UaNJ0KXxqzdwK9b0C1a5Pl0aPHunCAxY4aHC0AOBmAevibpFqvWRgs8/GnkqCymtXcwnLAfja6cwuO/4mb4QlkhdPJDtYVJnK4CDkdOdZ3rbXBUZsPshoYL5klfIpeXwBumIn2scpOk+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0tgRX/4H7h4ugkYuOlqLOf6LgZ2vYOM8jf0K5DX87A=;
 b=IksXZUpJEB+UgrenZg4H/gM78jm5AZlL53D7GhtwuA1nZXEe+8/Eac+bRyeHYK42q7cErkCStx5aNPgsBFmcgqjsdk2HuS9Gbsgwo8b9g4bjJ1ItRJe7iRzCrm7ZeX8Xn2B2iVBygnHcE4hfTubDNVEvDvTZRvKUBR+jy0obWIpsBlSHwTfLMIf3lpDFqNhAMrHKMM2IDcWKn0f4rt8GSnIqIm5iEXYf3Pm/yAPpkgT7cWgOZlLakSpgiQ7N5R0Z2rLGeV1Wt43BEJIy6DuhlpRuxpgUK7FMdkDEk28IJkhI1hEnOxm9WaVgLVUWV3d7HVAoxj/yOJ3qBSf/n4jDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0tgRX/4H7h4ugkYuOlqLOf6LgZ2vYOM8jf0K5DX87A=;
 b=adr0xMYk9B8LW4FjKzgw1LrKdtPDx+++TTfBTLpY8TzKSKxqI9oBWoSxwpfWi/0IghRa92ZKkMzzHV0PT7wSdpEBrq+ixrPUEQWo9mXhwOr/vK/Xa3zCwigRIWZHe0MrNPcjwrXvZFD01cyeQskZaVaZJj+FabqPJgsZ/RHPuijoZIqB8NuNTvNPIHCgreugZ1DjTdOvnjkx4yl8TbBs1J2c6hwr0VkqB3lhDq3DJLPVtyb+ZDHI4/LNuURsmmm/elAthunLJIwy6dETmVozplwU3DgKXdCerTNaLgJcrD02KNFTTsePRCixs1JzC7XEZMsiQI48ME5npU5HYoBR9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 15:40:59 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 15:40:59 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Subject: [PATCH v6 0/2] serial: 8250: Add support for rs485 half/full
 duplex on puma/ringneck-haikou
Date: Thu, 08 Feb 2024 16:39:54 +0100
Message-Id: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMr1xGUC/53PTWrDMBCG4asEraOif8td9R6lC1kzqgW1FSQjE
 oLvHjmLUGidRZafQA/zXknBHLGQ98OVZKyxxDS3YY4H4kc3fyON0DYRTCjGhaaAleYzxdkNP0j
 BWm5hCJ0XlrQ/p4whnu/e51fbYyxLypc7X/n2uidVThnVxoJ3znnhxccyYhpymhwtl7LgVN58m
 simVvVUUk0KshfBc6UCtzvS8VFl/hOkEgAGBwW8f01Q2rmgoDdS2Gc1+nfNH0k3iXWMcew4CPl
 CzSZo6KVCcEx7t3fLuq43q+3IHxACAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0208.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::29) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fc29b6-cebb-4f20-ecd3-08dc28bc58da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GE4X8/lvpwtMavRwUn08ZNNJdNXqyM5ZmoSz36Eg+7lCP94qu5bBvLTpOHDSqQ0lHSMklpa+doG949r3fh58EI5U4YgOj+U+j6RPRp4PURQ2sseXZ3vmnPfjjchjLG7jtdopGxU9qM2y1KWBsp+I2xpT9cgGaCbIZ6cuS1kZ+NUp3xkPVxr1H9K7eBDC9WlU9foe7lOvNouuwyK6nfMGwC7OgPgKGL8RG4WyKChoPaCDR/X2BOVNrBsgoadiQt7JLURp8xsTHWP5zNGytM4ZDK3sXzjdcHc/Y7Gxt9csueoIPmWaxCFpOhlrCYlNV0FR2qpVXoZcR96F6LJrT6xUiWmUqDyjjC0sXZz2llDy3uedp/7NDqjrcudYvQjVwWyc8/ovVzr7g/AzITyXOYh9d9f9pNNMMat4vySi8WAcGwp4IGelacxlmdynsXY473nEckOJVidpd864T0Xwdi8yKff4aECNAOnJEhAPD/T2PCUB0Wd+aiB+bs+SOAOF7ktIbFYs2eYKcquKKN9z0cb9UYI0DL3/cjAvgtjk1xTIrSkZ8H0AlY7kPMgQHdrzLW6K4OLG+vhw32quBTjz/oxoWCedN0uHO+ETHmB9UPhABLI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(107886003)(86362001)(2616005)(26005)(6486002)(966005)(44832011)(478600001)(5660300002)(2906002)(38350700005)(110136005)(66476007)(66556008)(316002)(66946007)(8936002)(4326008)(36756003)(6512007)(8676002)(6666004)(6506007)(52116002)(38100700002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjBFbUs3U2dyb2sxYlJtTUk4U2xyS041dUdXNVVFcUhibWxaZTVFOFIvdXJD?=
 =?utf-8?B?Sk0rTFVWSUxYdXRMRjBFOHE4TytVWURNY2poREhkN3FEK2ZCOENYYk5XR0Jm?=
 =?utf-8?B?MEpGaGpKRE1VMXJ1d0RvMUpLdUl2ejJQWkNnc3FHdWZ1ckVkQmhveWZRNHdH?=
 =?utf-8?B?QlhyanhENnFyMnNMR3V4Ulg1ZHUvYktidnJHakUzM0wyMGRzVFEyZkNnNEs4?=
 =?utf-8?B?eklBd3lybW9kcGFXVS91WTRzWlM0YnowMjJoR3ZXNStHTktRMFhhYUQvOWpw?=
 =?utf-8?B?ZGV5QWdUdGpOVGx5cXk0RThvamYwVmhZMjc0aDJMQmpnSTJJY1EwcnFMc0dR?=
 =?utf-8?B?QXZ3WXg0bWZxaVIxT2dPUWJ1a2UraUhIdC85cU1odFBxSkV0eVkvZ1VxWjh0?=
 =?utf-8?B?MWc4VFkwaHBwQndsNmZWc1VFNGE3Q0g0bFRXalhKVnYzQ2JuRUJUR3B5aTNZ?=
 =?utf-8?B?VUptc1ZnR00rNWl4QmlMc1MrZWZEUXQwTjhtQnpRakJjeVYwTVdJaEEvMG1h?=
 =?utf-8?B?QXYxNllFeWp2a2E2VnV2cVd0N083ZDcrZlN2RXJTYXZHbkdSS1JhVUh0TmFE?=
 =?utf-8?B?ZU5lbkV2L01uTzF5VlZaVndnWk9zWTRpbWlXb2JTTnJ3aG9QclRaaDExYzY4?=
 =?utf-8?B?V2dzeU5KenljbnRzNWMwb3M1ektySFBMV3ZhN0tZeWl6aXJaTjZRa09RSXJR?=
 =?utf-8?B?dHZkbEl2ajRxdmdGWC8ra29WSUNSMDNyeDBDUE8xRTFBZG9ISGVtdzJRWDk3?=
 =?utf-8?B?bk9nQkpwSEFUMDF3bUtjRG8zSkZqNUdtdTJ2SFF3UGFuNEJXdzZsbU1JZmc3?=
 =?utf-8?B?T2I4NHcxYnV5VjlCYll4SHRTVjFvTU1qTXdkQUJRNVJhT0JUZERtd00xY3Bq?=
 =?utf-8?B?Y3lwaHVKeVYyME9WQ3NaSFpra1REcjlRcHlBOHd3QVJrSmZtaVlHait3WW81?=
 =?utf-8?B?bXRpL0FETjBQMVl3T3pYM05OaWs1YWpaMTI5ZUM4VHhoYVF1YnRDeTRlNzlG?=
 =?utf-8?B?M1hoaHQwT203SzZkbFl2YU55T0JyaVM0dE13amZyNGFMaGFBWUEvMTJYT1Zq?=
 =?utf-8?B?SlZNZXlTZ2VJUk1DeTYrSVlVWEx5bDlXLzlQaXJqemJRa0M5N1FvMkx5Z3NB?=
 =?utf-8?B?VHFsNldWaExwSU1GblFESWpzaEtqMlp3UiszZHZrdmhNNDhpVTE0YW9QNTR6?=
 =?utf-8?B?Y3NBc1hOcUFZWVJrUjBOQUpOcFFvTGdIMzBySDh0dGZxUHJjRWQ0WWxQd1Qw?=
 =?utf-8?B?TXlxa0FxSlZudGxoR1lvUUl6K2JseS9nY0o0eEs3UXhmOTNpQ0R3dWZqMWR2?=
 =?utf-8?B?dHE5TmFsNEFFWlFaaytUK1RaTnk0dzE0L2ZXNWFlK1Z4cGM3ZmhXK3ZTdlFa?=
 =?utf-8?B?SFBkRTNydmIyZGpoWU1TMVFkdVp6NVptWE03Q2ZHRU9adVAycU1YZHJ2a1I4?=
 =?utf-8?B?eTF6WW5SdUtLV1hjMFVxMWo2OWFaeWltSEFDd0ZqbVpSRWpzajIwZjIwYVVM?=
 =?utf-8?B?TmlCeXhlTTdjejRzNDZvU2UxaDA4ZWRDYkdTZGRhaXoyaDZGLzVxdGVBcHNB?=
 =?utf-8?B?VTFGbFdmUm9Wcm4xVW5MVEZHSVI3ck1ha3BpUHViRmFBVkIxcnlscjRwSDBp?=
 =?utf-8?B?OVByc0lJc0hvQktUR0pVSGtmb1IvczhMckZ6S2xGM3UwVk5vVDlybUhKMDhC?=
 =?utf-8?B?ZmhWOWt2UCtFNnc1UC9ROXA0cVdRTlFRbVNHQ2I1cTg4QXNYYVVrdm9tK3Jr?=
 =?utf-8?B?VWwvRjhkWkJyb2dRVlFwMVV5dmhHejkxRjN0dFpieVBrMVZhby83MjBpcE96?=
 =?utf-8?B?NzI1VkJwV2MzYS9iQXZFd1VCT0xTOEwyajVoaGFsK2lNYjAvTzZRRG5zcVE5?=
 =?utf-8?B?RSswTWZXNUZXVzZ5S3RhQzV2SzcxRlQxMWpwYitjbUlLQ0p6b0N2QlYwMWc5?=
 =?utf-8?B?ZjhOcFcvUS9xU21PWnRkUTk4L24yN3EzblVvRXVnYm8wQ3hnaE9Ka3doVmhs?=
 =?utf-8?B?ZGo0WXZOTWduVThEMkZQeW5HWWx4YkZrSG5hbGdBeitUS2pLWWJIei9WcUJN?=
 =?utf-8?B?SThFTHNmYW1IbXIzdnFBRDNjblR1QU5TOFMvZVJBWWlkWlYvbUlTNVBjb0Zl?=
 =?utf-8?B?WnFkekJYVnplUUVZQ0VqZkZZUGI5MGFHbWdyYm1ndElBOFZ3aWo3ZkRLV3VB?=
 =?utf-8?Q?UlyEaCwofT2lZkG5t+GxSH0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fc29b6-cebb-4f20-ecd3-08dc28bc58da
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:40:59.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA5muTlw8OFinvOmVEOSln7Ca1SsR/7YQlLHALhB98EPMPAd+yfuKrf2va3W9QAyWInbCGg2/k6DeFpBf2MQZ/nDaoIpqDFVpM9O1vFTSrbS0rze0XcalhZdf3J/4C4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621

On the boards that we are using (ringneck/puma-haikou) a hardware switch
can set the rs485 transceiver into half or full duplex mode.

In half-duplex mode the DE/RE signal of the rs485 transceiver is not
connected to an RTS signal whose control is already handled in the rs485
emulation (start/stop callbacks), but rather to a gpio. And since enabling
the receiver requires setting this gpio active we need to do that in em485
while receiving and disable it while sending to enable the driver mode.

In full-duplex mode RE is grounded and separated from DE. Meanwhile the
rx-enable gpio remains connected to the DE pin. In this case the
receiver-enable gpio should be disabled to enable driver mode in parallel
to the enabled receiver.

This patch-series adds support for controlling the driver/receiver mode
using rts-gpios.

Changes in v6:
- "rts-gpios" property is used instead of implementing "rs485-rx-enable-gpios"
- "rs485-rx-enable-inactive-when-rs485-disabled" property is no longer
  implemented, since rts-gpios is already controlled outside of the em485
  context
- Link to v5: https://lore.kernel.org/r/20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com

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
Farouk Bouabid (2):
      arm64: dts: rockchip: rk3399-puma-haikou: add rs485 support on uart2
      arm64: dts: rockchip: px30-ringneck-haikou: add rs485 support on uart5

 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 5ebe731c2a586b379103f736cd498bcca3cf1ea9
change-id: 20240125-dev-rx-enable-d8818dbf7c28

Best regards,
-- 
Farouk Bouabid <farouk.bouabid@theobroma-systems.com>


