Return-Path: <linux-kernel+bounces-40435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C983E014
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6A61C225A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F49421110;
	Fri, 26 Jan 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HNzWbr8C"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DA20B34;
	Fri, 26 Jan 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290128; cv=fail; b=izgo9P/2aRMCpmfn+aKX0gHhFqpX+I0USUVqUq5LAzS3+2NZXDX3lRQjIbEpQ3hOYkFpTU2MEYWSqe4DMz6y5b0Ndx7GHvrwj8c3eee5oLQlBIJ633eZsLOdhQVWqPMRoujCfjZiSwF6Hr1mUCKp+G2OluwDibCZh8pM1g1/Bt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290128; c=relaxed/simple;
	bh=gQQH//f+vjvcV1BTOIw+1BNw+SB4UGsB6T8Ukg/QAoY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XiKV3lQdZAkWAJcCWrvJLM31EvqNXnNnQ9lEXWqSnTvz5XV0cQqXsTvYdHuC8n8mcPk4jp4ri/a/ULLcYSvknXGNEDI6WOIeNM+5PkahYLKnY7fX771vSoA1N4ra6OUiKvpveGKNugMB8DHMcI4hp1CJ8LiFdptsvjDAbcXxv5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=HNzWbr8C; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRVN94Vw9339URPIliIaCmMj7oGHPnrcY3AzEwuQQTjJN3tDFNgFsx77TBseLCIquHQqU/azttB3yg4O8yITG7/qVSL3KqPz//i4PObgj76V9JlWHcV8/xwVZifVMLbdkasRijw9/2QOH1O33pW2qA4G2rTiWk2bD2tr8qCNcHProUzKgYEAB0okUig5b3JamQglyYAqkoJEynrYamONGmBuNN9iXYcxaelQwBARHhqpS0Je5OFuTNapIVRsF1zpD2L9472GnpxHkJqQ6kzaqpvRfXnj75qeBxgCrBeNBqS6DsklLm53rBhm6HWon833+nfVUWNGLWfN1FctTUcJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3D13ylB0RrpOulRlqk3gxsVJgIMce4Ga9Ejbqk3QrY=;
 b=ZJXdOuIP2X+KKagaZT88SgS3VD5IiOgISbvrcADBaP3qpFcPzdUTCZ7Nz50iimQ7DE4QS2oXJxdlZq/WfksCdZ8Ys0MHWAP/IdXvCMQpAvaHHbpzna6+ja1WZUQj+p2p49IC0I43etdzL9v1nLjiT4WGRuLy9bW4LjP0HYfGczJG/qWWgZonpqaHb9Kp2g/Bu4jyu2IWS43Zl/YutSRqjlFCyUUxL/+Y1LHujfDmjeAPcjOn4NOSg8zFgtJWA8fo/yp2jky0RpdMLR+a0RUXcjN3aAvpv5PXPJeFB1/e4T7Y+yf7yC/GUXVLRqjXIrW3evBuNyyVxIqoMxgmB3crRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3D13ylB0RrpOulRlqk3gxsVJgIMce4Ga9Ejbqk3QrY=;
 b=HNzWbr8C1Q6f1ZhC+lfUfyV/SUdGmm5WJNWm5atRvMd1dr1scx55W0DvUxrmUkYNitihUATkNe9CyTRfUc4dXLsfRt35QfFbcfFhXDeYuWfCkGTXZWByUAejRxZ/QEdAl2JnjA8uDEI623Md0HCvpTjqHsVJM8mnROzY0z7VEP2N5IOqfUwUAQ0l+9fI6p4jzHDcwJjZQBaX3nmE476eCgs5pP73YEqozVNUCjRnq2X/hAcAD7jykWXbCsz7f89X17HP5Rb9neEa2sZM1ZyAeZHrBgGzfT7PSbuNg9J+SNDLQZlHBKyLF7zvQbyq7eQUx7uzudZumaVXvswwZ7Ligw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:28:37 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:28:37 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 18:27:45 +0100
Subject: [PATCH v5 4/6] serial: 8250: set rx-enable gpio state when rs485
 is disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v5-4-5d934eda05ca@theobroma-systems.com>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
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
X-MS-Office365-Filtering-Correlation-Id: 304068e2-a041-46b0-d5d1-08dc1e943a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EQr4VWAF/W7dDyMfAk/JQ42oPwHA+wJL6h9ynoxuHuHNrZK34wtXtbQ3gFcaTucjnyCDknWR7zPG+ifntJ2nZDsQ5/3CkIHxoFs/P2Iu/dcmnOIaDzRk2CP0Ix/JlCkuiUuc2jCjXP48anJvaqcctKz0ztLotMcQ9/pxkVIXX9bLKwV/wjayw0AAi/EY7eO4g3PyTSslM0+GdovI64+eBOkYOeOZ8njbkOpdPaNU7utkIoryGngRpfrRqrXwQEd+kXB8CRYsjDHl67YdKoI8t/spm7LwFOwGVQPsstyhT90teKi4is7rxoDWbbM5mxNUxHgzXH50DYlt6I3/WQsaHc6v8D99qf5L2XY/PUn2CC0XZ7/cDGcbNCw5W+kBtsR2OA4/LCkYnaetRrapCETqe8B5muE/fwzWfkdXgTNkepq0pBR3xxn7+DqOUE/sv0rYyRCSn/BTnrTyM0m7NAKHRr7qw6epx53zB8YJ1PdQMC5ApdBmHPyr/vBqh0o+R+1jeUhSQPWkYL8A3VhWNNmFBq1z1OU28yLHHho82jNYpNCpvuI2vbG9qxEEDY3BC/r4cueuahT0tY/JOScXwtPgzVvdrVxB6qC20qXFsOiSlwgO2d8d/8Zh+lKj/O90xGsF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(478600001)(8676002)(4326008)(7416002)(8936002)(66556008)(54906003)(5660300002)(6486002)(44832011)(66476007)(316002)(2906002)(110136005)(66946007)(86362001)(6666004)(38350700005)(52116002)(6512007)(38100700002)(83380400001)(6506007)(2616005)(41300700001)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yks5RWVoQ0NXNC90bHRWWGxlRTh0b2RxTlUzL2JVSmFveThUMmpnZGNoWWFn?=
 =?utf-8?B?N3hvbTRiaVhwM05GWmRubytvNVJKKzN0cTB5MFVYOHprdmwrUWlOZG5iQVEw?=
 =?utf-8?B?dHNTaDFhaERmaVJmV3hHaG11THpvVkVMd0I3anNoZElpYjZpcTFmbVJkdFFZ?=
 =?utf-8?B?UVI0Tys3R2dJSEQ0bHlMM0szL2o4ekdWL0ppZzZGSXpCZzNacmc5cmc5THE0?=
 =?utf-8?B?WFRMdFVBOFp4N2o1bEFKbGhDUG43MTZPNDFMSWNOVlVGcmtIOTUvRW0rREpN?=
 =?utf-8?B?MnNYTVhCbDI2bThWWUhubnNvRjljTlJ5TkRpOUorNG9RZ2puTmhCMGFCM1BV?=
 =?utf-8?B?VTBtQldTZjBISUhkQnJ3bk9LOU0zZHQwQklKK3ZHTm16MUVObDhxUmp0V1Fj?=
 =?utf-8?B?dEdxT25uSXBvWC90RHNrVkpiS0pUb0VLUGROaUVaWW5weFF1L05YL0xmN3ll?=
 =?utf-8?B?ZjRjWmZZVE94dlVjQ1hwNGMyeFRFWlRmRTVMQWtrQ3Z5ODFCR21rYmNFQmhk?=
 =?utf-8?B?ZDlyU2loOWgrL0xCenBTOG1uY1R2SFZuK3U4dXFZYnVDbStXMnpOb2tUNHE4?=
 =?utf-8?B?R3Z0NnJpR1VsN25DMjVsamdFS1RiZ2RZYkJ4RzFJaUczNVZ5dzcvNVZsU3o1?=
 =?utf-8?B?bi9pTEZNTTNTWFU0YjZGVVh5T002Ri9NSVJidDVDRHpVbktYTWRMRzNBeWw0?=
 =?utf-8?B?RWtkOHUwN1pRcExIRk5vTFJxa2wrMmdWbmxZYURmTDZHc3VsTEVaaEN3SzVC?=
 =?utf-8?B?azg3OEMzZ0JnZ0tISEQwQjZFRjZJM2RYb1hON2JYYWhSMzJCNGk4NjNnNk4w?=
 =?utf-8?B?UlUrakNXT3RwVGZXUDdMVG9Ed2ppazdwQ3c3QWxFRzNLaXo0ZDRZbnBxY1FL?=
 =?utf-8?B?ekk2c1ZNSVRXYlpMOEJXYWpRUVBvRXRHeGMrRzRneStxdzBoc2JWU2xQejcx?=
 =?utf-8?B?UnpZOExnVTVyVTVwMDcxYVdhTUgwRXM5ZTJ5QWRkQWhCb1Z2L2tiL1dXWVhJ?=
 =?utf-8?B?VVpMVlJmZjhUQlgxWHhvRUVoYTNMVU1BcEIxWXZseGtZY0xXLzg4SGF2RjVI?=
 =?utf-8?B?MkE3aElMTzdOa1RDaG45azlHTk5BQ2ZhT3BqWWNqRGgrZ1Qvc3lIbmdBQXhN?=
 =?utf-8?B?eGkvVjBiSlZVaHMzTVMvejZ2d1I2bHJFYlBHNGFKMG5ieVZBTGExVnNTSmsy?=
 =?utf-8?B?TUNBSW9uQUpTSlgvc2Z3R1Z3d3dtTEduNUJCK3dOVWk2dnRFaWliSGpBekdN?=
 =?utf-8?B?VUMzQnN2SHdvNTdOdHQ3Sko0dWtyZVU5Mm1iSW03Q2RTZUhHQ1hoL2JxWmdr?=
 =?utf-8?B?TTBsOEpOS0xvelVkMDZMM1c3Ylc3Nk1iRElOdzFBdlJGZUQ2MURqcmlyUDJB?=
 =?utf-8?B?a0RhOWl0UHgzOU1ES3VNTW9nanE2OEp4MlZmT0FsTEVNaWZnYlhmc1RRMlR6?=
 =?utf-8?B?WnhDaVp3NHh6NHg5R09POFpTWi9Da1JVWU80cGU4K3NCTzZYMjJReEF6SXo5?=
 =?utf-8?B?bGFLZnRNampGeHpkanBRT2RMeC8vYXp3YVBCN0IvejRlVFJuK1JrUi9Zcmlm?=
 =?utf-8?B?YkpMNnp0SUIycWFZNGhlS0ZwN0JVbVRDalRzNG5SNlFoVUxBR3VLck5zanZJ?=
 =?utf-8?B?UUMxNVkwaDJRSDZDNmtKeTVpUk1xUWk3MUUxY0RCelVMZzFRRTlwclJxVFU4?=
 =?utf-8?B?MFEyUHlEdjd2emRhSW82cm5BQU9hUDlZcTZ6ZVJ3aHNLSDFQU0lyZWdsempz?=
 =?utf-8?B?ZnNibXZDMm50TkFONnFYRUFLRkF4dHBucXNBcWRoeHVTUGZwR0pLRDJEdG5w?=
 =?utf-8?B?dHJHZUZVdk5ENkIzNXg5aXJXREw0UFAyQUVUVnJqTjhMcEJQM0RiOFJuSU9F?=
 =?utf-8?B?RUFLcW5HSVZjeFZTWXByZUZTeVRzbGtnNVN0M1RlTUt2aENvaXU2eldHQnEw?=
 =?utf-8?B?UTlxU1UySjRnLzJ5aVZzNXI0bVdRMk93Z3pYZy9uQ0ZncDBTZXRPTUJBd1hh?=
 =?utf-8?B?a3ZoM2Y5ZUNPNi9YNXVMZExNWHRocHErTGJhNjFyN2s3NW16QU5JRkxldDh6?=
 =?utf-8?B?MUpVTUx2UldSMUdzTEdRVG80SmEyTmVXanNmTDBBaW16b1dlZHB4RXFhY1ll?=
 =?utf-8?B?bkJDbkorQ3ZuSTVuWm81a0RMRVNyeVZYME9iMm5icTF3ZjdtZVByeUdOUjJP?=
 =?utf-8?Q?Sj9E76MgDagUlVgqzlGblEo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304068e2-a041-46b0-d5d1-08dc1e943a44
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:28:36.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svuCXIXvdO8RLh0wz1RLk+l8SHeqGUJ0lyzbJ3/mS8V9tShn+ziAKvmiYVFWvvXRvtog6mOwWdA6Bcc1N0D6vhoLgIasNcDLdg0WQnOVftg6YA6kfoYvT3JlC3ZM9hRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

Add the possibility to de-activate rx-enable gpio when rs485 is disabled.
This defines the state of RE or DE/RE signal when em485 is disabled.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++++
 drivers/tty/serial/serial_core.c    | 6 +++++-
 include/linux/serial_core.h         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 54d8f809b81e..fbd0212d2397 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -582,12 +582,16 @@ static int serial8250_em485_init(struct uart_8250_port *p)
  */
 void serial8250_em485_destroy(struct uart_8250_port *p)
 {
+	struct uart_port *port = &p->port;
+
 	if (!p->em485)
 		return;
 
 	hrtimer_cancel(&p->em485->start_tx_timer);
 	hrtimer_cancel(&p->em485->stop_tx_timer);
 
+	gpiod_set_value(port->rs485_re_gpio, !port->rs485_re_gpio_inactive_when_rs485_disabled);
+
 	kfree(p->em485);
 	p->em485 = NULL;
 }
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8067d20c5275..abcba88dd5a7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3663,7 +3663,11 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
-	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable", GPIOD_OUT_HIGH);
+	port->rs485_re_gpio_inactive_when_rs485_disabled = device_property_read_bool(dev,
+		"rs485-rx-enable-inactive-when-rs485-disabled");
+
+	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
+		port->rs485_re_gpio_inactive_when_rs485_disabled ? GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
 	if (IS_ERR(port->rs485_re_gpio)) {
 		ret = PTR_ERR(port->rs485_re_gpio);
 		port->rs485_re_gpio = NULL;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 364583203a24..fa5a92b56360 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -585,6 +585,7 @@ struct uart_port {
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
 	struct gpio_desc	*rs485_re_gpio;		/* gpio RS485 receive enable */
+	bool	rs485_re_gpio_inactive_when_rs485_disabled;
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };

-- 
2.34.1


