Return-Path: <linux-kernel+bounces-40232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F383DCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367EB1F22A54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D51CFB4;
	Fri, 26 Jan 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="IU8jxQHF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E31CD1F;
	Fri, 26 Jan 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281112; cv=fail; b=Yi6iQ3W3JBlhsc5Ev8Crpp1Ocy1NsHfczrsB2f4q+FiiFqP039v2Asl4oczHpue7Oib798ZDTLUcYpiKcKrps2hWeirrYuU88KtLWkgAreo6UlVjQ3SeZb9cJzYwDQu3c7vTHXEFk2QUQz0gO0wyfWY4chsbyBj1uZFbzzBzzs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281112; c=relaxed/simple;
	bh=KOYx3HqUw7l2CpCi9YA/OeonY3wOAz99gPL5b470tyc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IKckgdBf2pc3zdFHJM7DWfiwd1x+UGj2Z4S0c6DMS3QkMZeIjVw+mkv/nntmoNaSbshg2wm83DPew9+86KY6veG0F4R0hAWIYDw5u1veQ69H+lOOJOvkmJJ7JTf45jsOoJaeixDV/f11czKp8R6t8rO3tp/Z4+Qw02rEpm80ixI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=IU8jxQHF; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJlgeLV+KopdFamoZVVisgk5eg9lpyvwFBsiUYTzZoI2Pf7j8S5w9WvpdfpxD0gUTaSYPO0wk6d8vwzo33IZn9Wh+6wU1SUrRHjR49yUaw4xyUSYSYusFmCx8Da/irxrzMMDoIa0Qe/PY8JQm9E7TxT6Nm+zu8j1/8d6yKj23mSM3D8LlUizJ3gGvsYW/ryjjCvIRirk+FcxSPM+hL9gl65B/Ka7cbXOCTq+8xyfYhqjh4kDsTMPadRsjLUJ0SNr4050ETlHhChius05dnTCyJojDpl2Aw7b/Q2rUF8gg60fzvMz48qGfpEt97kpOZ/Il9KV+YtF9GRTPyk1aPWYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTLh7Dd/7uz1m4CtqrTzye9JHtHx9qlYpEWKaOA4UaE=;
 b=T+Mm3fBuhzKo/mL389j333IFGLqU2Xw+Ykcu7S/CGLngyZIViCUJy4rclGZc4qFKVtc50Nw4tUUPIk3jeFmJN9XH/I7MRadk6MGwSd+sFqZO811roNnBNY7e/GG5HvoaL5AfSAVF9mg5LImDn7knjSVRVQcXJ3MkCbLtpd3V0/tkfyn859ZrTNecrf3mpUSahhWXi3VkILBkZ8Up2YX1wgC90ig8FrxRC+DHobNbiVc432cQrEwclHkTTQ+maOsbhKPjq/uWGY50iynobnLnT6z4xx/oEpzZxE2bTtYefg0GhGNzMzDRaPA1gqa4bZbzU8m7DpOxn1F5gr0w+qaiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTLh7Dd/7uz1m4CtqrTzye9JHtHx9qlYpEWKaOA4UaE=;
 b=IU8jxQHF0UjIr1OPl2XJlVJMh/MxZPuOBjF+17GljZM5PCZ2yBcHJZqc66F59a/3Zn1pgmM3ofYPw+Ykxk+y86nltCwFtjz7KWhDnJZFsrRlU5Itvp+gh5Vzyc9NGrlxT1R3RVNF3KztOr0/bcq7mut2mS8Ap1a89lcMmtvZ6XdtfuNTxm5xGtp+ORB7lvj3Vl2BhW2jD/eWdHJBoyw6Oa3dhVLituLXoM5ZfM1rO27CRUR6132yPrBTIMA8pgSpJRsbeVNb4j7kDtvM7KdQqtvqbGZo3c2sioBJ7odO+eXBERFBGSYX2FWbA7PaE1zpDqs0l4wStRXDnBEGzWXqsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:58:26 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:26 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 15:55:13 +0100
Subject: [PATCH v4 4/6] serial: 8250: set rx-enable gpio state when rs485
 is disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v4-4-45aaf4d96328@theobroma-systems.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c0ebeb1-be25-4032-f3ba-08dc1e7f3fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ikwHT/+cbQmtqAhpOtEGbU0vuw5FSbJMS7eJfTaLYFPoWCsop7taknZ6ampf5edwpbP0iEBHkIZ30g1NjumSDQZRhYGudootMhwyuDKSasZF5mk6Tln0Kdvrt53NFT3We1I2rEQeg2l/+UG2VJ778purf7kyIE6HA8veHAL81Pr3NAOAEGyw7gvX+bUs0Uve+l8Qr0yJuJGQAk9TVFku18ZxiWeKgfSWqHaKg7/y4rzJE8t2L9bi53NH2Qeqkc+pXZnA6S5l1mXP12XMkdVn5H0TCuq7J5i+4twOQCIWzh9qZSE7XzJ+t9Dxw9S8wNt8Hu1sKSvkNJ1UZRpoDa7+6eR+Rp5XQfFdQzfXH2fEQJPqjQ2xgeq7+Sl6FaD0v5ZA8FA8hlxD3vWQs0fXDO46rvrxFWMiQXdnw/TEdB/tdeEmGFi9WU/lU0bkxqSYrnuYWIruodiWrYBUxvgyjk6u2o8XUJDjZ3omivzJ2o5WvBxhl2nWU4mOMytV06+pGbQuBPANHoSuU4UIbrnPYexP0koy1GKiQnmh3BUb489VEzO1eyDrHsrSSfP7vdIka+TFVsZSyOOw47khx7YS+0I0Mk+S56f2TSyygj0W4l/Nnc97xR05D1jSOqxVcFMbro1J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(54906003)(66556008)(86362001)(478600001)(38100700002)(6486002)(6506007)(36756003)(38350700005)(41300700001)(52116002)(4326008)(8676002)(8936002)(26005)(2616005)(316002)(5660300002)(66946007)(6512007)(6666004)(7416002)(2906002)(44832011)(83380400001)(107886003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L09kWVhaa0VwVDJDZXNpb0RDMG1YZSt3OGdEQlNBb01WVWhrVS9lUnlVOHBR?=
 =?utf-8?B?Um1jMG14ZDJhU1BuVHdXNGVYd3diblBEbEg3enhmVU1ZZHpjRnp4ZmtMVlZP?=
 =?utf-8?B?TG5NSEJZanNXMFFibXREbjIzNlU1cE9YdXdZdzNBM0pIU3hhYlhXTVc0TDhM?=
 =?utf-8?B?akhKSm9ZTHVQWkVWUVdmd084SkxsSCs4TGs4TU9wNzlqL05BbzN6UGVtdzVC?=
 =?utf-8?B?YXFGUHJLMXc1T0pjbFpUVS9mQ3lwOS9nRTIyK3RYZHJLNDJvLzZlekVDWExr?=
 =?utf-8?B?T3pvdWN0aUtjMjVqWnd2VDVrclpMNnJTT0laazQ4dXBiS1o3MEwwaTErSllF?=
 =?utf-8?B?OUw4Nk9jNXlBOGlIZk1TNEZGbnh5emsxT2lZdDRJZjl3MmxsT3ZXNG9ZREty?=
 =?utf-8?B?SGhrWkF4NnRNYUJpRjNaSENwdStDS3NzNStKdmFWVldHTG9iKzdGYzcyNkZ6?=
 =?utf-8?B?TTBwQk1iaWZJZHdjTWdZd0IzdWNVNk1UR05CdzFEVDhCM1pXNldadEZGTlJJ?=
 =?utf-8?B?R1NZekdaVTBnUk9JV2U0V2VFR3lYS0g3aDRGSDlyU3lIdFNQMkFHcW5VODh6?=
 =?utf-8?B?RTBxKzBtRzV5dUpjYU9aQnJ6YkFYVVdNald5aXFPL0ZPTjhCcVJXMGhKWFM4?=
 =?utf-8?B?U3FzZzdQejJDMVdrek5ua0dsb0ZPa3I4bkhVOUFqeXFydm4veWY1dmVuZXkw?=
 =?utf-8?B?cnBBR0RreUd3MlYyWk5WVHBpbnE2cHM4eVNROTNIMjV2dEUxcjZ2dnh2cmVK?=
 =?utf-8?B?L09ubzEvNjgzYmlsV0tYc1NvaFptVDhMTW93aVpwdWFjamZ3UlBUTjZBaHky?=
 =?utf-8?B?YjBPS2I5UDg3eWJBQnJvMDMvdjUrcU5QVitpM1V2bkdJMzErSUhCTldRK1ZZ?=
 =?utf-8?B?NDRKVzRlazNmTGYvb3ROcC9WZHVmLzYrekN6M1QyeHlpWVd1cWhPRldFRDBK?=
 =?utf-8?B?Yy9BV3NneUdwclRCaGxVZFRiWW01MEVQTW5nd0kvVjJoTDBacnhhMGxvQldl?=
 =?utf-8?B?QU5aZkZjTm1wYUtmaEx1NkkrVUJaU1lTWmtZalR2SjF4dnN1RXNkOEtUT0Vi?=
 =?utf-8?B?VTgwa2RSbDFpRnhPWHNYckhiR2kydTdJU09oWHYyVitlYi9LWDBkK1JEejV3?=
 =?utf-8?B?VUZJdE92MlRTSk1sT3hOSWx4TXI2U3c3bHFiSmQxK29Oa0RwY0llTVFSVHRs?=
 =?utf-8?B?TlZvYnVwZnhxV281VWRxdmtOYVBJVUVyazB4T2RtcDczNTdWM1B0eUJzVmo0?=
 =?utf-8?B?aTNscUpCdW5LOTd4TEVKNVZRREdKeHZuKzIzbE9TOTdLOUFSOVI2T0ZHa1NS?=
 =?utf-8?B?RFViWXVIQjJsUlVWbGo1NWt0YlA2Vi9vT0Z5RTAzR2ZqV1B0ZlRjNGpsdWpq?=
 =?utf-8?B?NGNZU2pXOTEvOFJDajRaUEEvZkdrQzYrWnlMRXdGNngyaUVqOVhEa2VRbkM1?=
 =?utf-8?B?Qko4Yk9DWlR0QnM3Q25EampsbEdCYXZvYTl1RDlwdmdDQm11V0hQNWo1dmlY?=
 =?utf-8?B?KzBLelhxZmtqbGl6bXlSYlgrVWRQem5hSVFxTGZIVXhpVWpYRzAxYjI1TDBV?=
 =?utf-8?B?alBKckVUbnFFazNmcHJ0SnNPbVJOMTlwT3RaSjl2SDMyWEJFbnBUWUNKajUr?=
 =?utf-8?B?VmN4d1djVDk5Yzl4aEtORG94MkU1bWVhYm1aWXpRVXVqVWY3QmFKOFI5WTN2?=
 =?utf-8?B?ZHh0QlVPQUphYXhFUGgyaTBET0MwdFIzWGpaTjZOVHdkR09LWUJ3RzFId0p5?=
 =?utf-8?B?S1R5RHpKeG5vRjFXbDd4Z3ZMUFlOOGppeVMxQko1RnJwRmwxVTlyQVZLQlk4?=
 =?utf-8?B?N2FabHNoV2dIanYvV3gvV3J1Y1hFU0pjclJTQllYcWJ2RTc0TDVyOFp5ZkNj?=
 =?utf-8?B?a3RBd3JYZmhSUFJMVFYrd0hGbzNSRDZrRDJNbUdld1ZvRytpOWliMVpiSXZG?=
 =?utf-8?B?NDdNeS80bXVVeXAxRHRTeXJMSTNIQUgycGJ4dzF6K1haeGFCS3MyZjlyNUd5?=
 =?utf-8?B?WGFnbmlLeDlmUHZxRnVxU3lkOXdKMy9LbS8zcXJWYWYrZkpnYjFuUEhQN0ky?=
 =?utf-8?B?cEliZVFHWTJpbkdYNVVGVUVkOGFXVGdHaGRoWHNUSmpQUWRXK3JqM3cwK25t?=
 =?utf-8?B?OVFRYTZCWlhRL29pR3F5REk5c1FPR0tBUG1YQ0ppdjhZMjZ6M3FZeStObzlH?=
 =?utf-8?Q?ZntQtaAH5SObQODDmWjjLB4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0ebeb1-be25-4032-f3ba-08dc1e7f3fc1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:26.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clzWHEw8xOlS8yBTA2WH9Q4a/FbnYMFn5A0nbIv37DXvRUcuhoPkhhbCpHhh1IhQ2Ubp2UrofvkN9fi36W7PMrLYVncfjvAm8hp9X1m/TFmzDPmJxibZFX+CWEXo0Xw7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

Add the possibility to de-activate rx-enable gpio when rs485 is disabled.
This defines the state of RE or DE/RE signal when em485 is disabled.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++++
 drivers/tty/serial/serial_core.c    | 6 ++++++
 include/linux/serial_core.h         | 1 +
 3 files changed, 11 insertions(+)

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
index 47aeece985f3..6460646cf83c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3663,6 +3663,12 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
+	port->rs485_re_gpio_inactive_when_rs485_disabled = device_property_read_bool(dev,
+		"rs485-rx-enable-inactive-when-rs485-disabled");
+
+	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable",
+		port->rs485_re_gpio_inactive_when_rs485_disabled ? GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
+
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


