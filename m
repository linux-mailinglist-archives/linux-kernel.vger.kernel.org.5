Return-Path: <linux-kernel+bounces-40233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD983DCEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9121F228D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194781D557;
	Fri, 26 Jan 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZaUO7Wtm"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A761CD3C;
	Fri, 26 Jan 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281113; cv=fail; b=nIElQ714lc3EaXTzGkuqM4Zfbkk9mjX6EoxyLYnO9a8SYwYYAHoGDIDb3M8lcYOJSAh9lgrklzhAsv9yeaJVAzFTtXs78uEAzx+st30FwQQhT5erz1ikyQsgT+gMeNbS8tOsDXQDdRv9Sc1077mKH0Kwa6vZBjiFBiJE2lySiCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281113; c=relaxed/simple;
	bh=UJ01PbicafcI1eWCsVl4OWKj06gEvqRghSNktL78ryI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ub8j1eUPXvFhNSoR1LylIBklg91ceAQaI2bJS4G+Yy+UNuJUdKl3aK5p2iQ3B4HwptVb4VuUZhs/F5U0TftFlJrko2ljS3Sy2STYKXX20ParZAHS8XbqFmtu87v4k/p7g9TAk14oPvxGO88PS7P36ZDiTQI6Gc0CL2PHip0s7LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=ZaUO7Wtm; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzw1ttR8RLafb27Mdeldww3hHogk5b9S1x/FSXiiBo2efjbtOplmVs4CQQMCtE9LKtEdmUr3DNY3mzXJc9eCZ6aY4EDGC//PyRf0ShfGz2sifTgufK1bZBMlcU89HytVLp958/t0M+xYrr0/Wat0F1h4N0EWtMZ/GrQjNZGuR0m0LyWFUFd3pn1GdxzAZ/7b3vhsKT4yjlHzE/UrE54ghEuDI8GvA8d1TKj2vkUDG1zOCziUHNUazUNjC8P2miDP8C/o/87QUFyuvP9AnoZnTAbsE6yGUFrqV8X5LhzpuxPOucu6188ZOvLpqCI3WYuCkXkoSsg6Iu2F1FGFIMAMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAmoF69IojkL6YgOhO8yZRs4ByYMziuzYgj+3Si/pPU=;
 b=TO6CFhRyZpgkpiK98KruCSAihNjKHCl46NWHCUUtkunkSMye9eGL6SzpSFs7Y6zyYlEpliPmiz7Wdz32hG6TmFX/5bMfN0+D8FW9D0o3zMJZvQU/NmfKx2wxAnmF3kw4dtiThNdy165CgTjdyywEXkDYhrDl06pxA1tgpb8d6w+risNZyaNZ3SQJ1cFfkGmBTndH1SqryU3rbBr8i65tRld4LlcGXD4D6KiF7Tik4Yp2MdvQvjAUVCCe4DgzRArfXAkNMAmWs1qO3Z8DkcskUjjvicTwVXLCgIJAgdZwRU7FVMrNPyTKYF6hXgtIGBqOZKGg+Wv1NvwmzLr+8HVI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAmoF69IojkL6YgOhO8yZRs4ByYMziuzYgj+3Si/pPU=;
 b=ZaUO7WtmXCEVh5xoG5NA/rj6mbPE6n9gam6baqNAp204Kg1Cjwv9o5yYh+iKgyCLec5VxJh4+h8wLGYqw6iGyNpoZuS1sQFfKfZULqwT2GiL1C7GRGeOi/Slgu11LTdvzfzry2Mh7bo6T7CVatMaS+IRLnhXsG6UHZQ94M+oHRgX5H4EqyJuj8FAy0hrPMDIMHcpuwb9Jyh3oIcLqxWLyzvr3op+yldxzIfoDYMXTbdpRQsbWSooBUBZovl6sU6Orc1KKM82QJh5u3Pgjo8lMmaoEd/pxkcelzYeGzrfmWrOf7a/wNjp+EjYWby9HtnHKSafBeH1GkNlkcmHBVFmKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:58:25 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:25 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 15:55:11 +0100
Subject: [PATCH v4 2/6] serial: 8250: Support separate rs485 rx-enable GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v4-2-45aaf4d96328@theobroma-systems.com>
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
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
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
X-MS-Office365-Filtering-Correlation-Id: 0fa91db1-8cba-44ea-948a-08dc1e7f3ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A82CKa80Xrtd3ZaodR/758D6c8kmoD21U16F7mXaB9W/kA/yWV57+v8YFTM/aY6vlF70IuO9s+gNG/NYRTBzdie9ifEpfRhjz+YEcD7L3KQLf5KVTcTSb3fRs5CC0WmcRA8cUrUDmiow1bMxikUjuJ5iHPg6gplxAcwFIC1F1mjcFXYEt/exVJp+x1tR4K9DmnCRu5S4zzZeK21KJ50j/dRjwl82aVQYYXAH68jNNNza6XFcga9axXgvXL95W/rF3+l2zJTg5Y38i/KXWQv0ULVO8ngTrBdZnFbC5NIUR61SMD1v4BspvIDyVkYC/2hSHVzn/J/RqAbrwuClUaIZhehjCyE69S70hKInxeEHaF6InGQ9gIaypLs4AVuEMTaODId1tVS7CRKW1K6oDNoTMjVXtYt16HkP8Gxp2VSBMfwio37DMGXWZ17q0JhY/Av5FSG+9kWZ6hLhzjLqGcVHpN1PZBE19mLJoxpSzNg943oegwntgr2QZVl9I04KvZ4B9i6TiEBWorAa+Z5JdNCwjbLKZqhNVVbTxSV4MTtyZ6Ztw2MaGwBGmJBBi3Z0RpIO0Epz2KOOIXTdH9C1BasAsvIBwQm9qnAhtse5LZwTi5wuS5sldznSW7/wd206G0ZX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(54906003)(66556008)(86362001)(478600001)(38100700002)(6486002)(6506007)(36756003)(38350700005)(41300700001)(52116002)(4326008)(8676002)(8936002)(26005)(2616005)(316002)(5660300002)(66946007)(6512007)(6666004)(7416002)(2906002)(44832011)(83380400001)(107886003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVRUZU1UdGZxRkc3eE1WMFlWNWFWREIrWW5kU0JkdDUrTUttNUw4Z2I1cHpI?=
 =?utf-8?B?ckZ3SmlDVDZWUnJCdmY0KzRiSWpPSmJZcDVMaWg3OStGeFAxMHYya2luQzBp?=
 =?utf-8?B?NlN5cHNIdXlGS2JQak1WU1FtZkhCOElVMUxNdVQ4ZlRhMEU1ZTdpQXdsNWRX?=
 =?utf-8?B?MHJPZk9Nc1lhL2M4MVBrSWNGU2ZkZnZYdTBKWDZKZlNVK2R5MmwwSXR6eCtL?=
 =?utf-8?B?RWMvNm9FT0tsZGJaUTI5MURXQlFrMTR3YVhKd2Q0WVg4bUU4OEZsQUpPNVVm?=
 =?utf-8?B?VGllVGJOTVJVRUlwNm44KzE2Y3B6K2gxdnI4ckcxcnBZS3BrRFVNdVhRYzho?=
 =?utf-8?B?UlFpYTdvWjlNUGxwenpHVS9YVldlUUN6emk1Z2F3NHVOeWhKL1NlTWxBK1FY?=
 =?utf-8?B?bUxjQTBva3UwZXowSUNBaE1wOFpsY1c4ZUY3bzFkc1EyNk9HRFlkbzdoR3hj?=
 =?utf-8?B?L2Y2MmZvekpiNFV6OENqYkZUc2ZKN3V6OXZuRjNPN0hub2xWclVnRWsyVXE3?=
 =?utf-8?B?SlA2NDNNbUhhTS8rSmxvOHdVbk1pUGFUVTREL3NUcXErUVh6SFVGcFl5OHdS?=
 =?utf-8?B?T3ZROWhJMnZ4NHhBSnlrMEwrdU9RZmtyN0p2d3d5OWoxYlFpbUNYU0Vtbnk0?=
 =?utf-8?B?OXBUUm5NRjZzSUVYTThvbDZuRzQvY0hUeFF5bks1MU1mN2RnUytQWXdkQk5a?=
 =?utf-8?B?QXp2blErb3o5ZHFEVmoyRmgzSlRzcmYwNGFEeEIva2RwT1lnUmxiaDBHZlJv?=
 =?utf-8?B?RDlkV2pxYnNlU3gvRzRqbGZ2c1JHUmNJOTlRQkRxblFCMjBza3ovRVFoSXBO?=
 =?utf-8?B?WU1BVkVCdHFIb21SdnA3QWh3RVlNWmkrTkduVHpOZ2duWTJjYUYwRWJzUGhp?=
 =?utf-8?B?YzJ5QTRvSG1sRDZSSUQxa0RoSzkyWkVPbmJ5cmFnUUkyOTBFdEplMkx4aEVv?=
 =?utf-8?B?bXk0S3ViZlFCNXhvTnNlZHRTMHZ2V1RLdlNOeVVZVzEzbjlESWl5dnRCMkF2?=
 =?utf-8?B?R0hKbGgrbFRBcC9kaG5qSGExWEt2dWxZNHlHU2k5S0VVTUhWYXdXc0RHZWhi?=
 =?utf-8?B?c2JpNkVnQWR1UVpDZE1aTjlIWmVvMHpCL3pQZFZZdkt4amVJbU44WnR6WDlV?=
 =?utf-8?B?Q044d01mNGMyVnJUUTJjQWhnZkdtblh2dTRwRHhCZm4vYnBzYi9ZL0ZNbHJv?=
 =?utf-8?B?R0RZcUg5UStRbElmQ3laMjU2cXA4VzBTZ2NXWDN5ekJQdFdCVUM3RU9qalVL?=
 =?utf-8?B?VHNCekREMTA2aFV0dHBlaU5HZFFCK05aMTFBbjFXa2drVHczeFJwZ0R3NC8v?=
 =?utf-8?B?bjlvb2s5UDVsVHViSnBoWXR4M3dGUE4zTkdLQUFEODRxSzBQRDR3MDJ0TGpH?=
 =?utf-8?B?MnFDMUNRZVUvMDVwb2dKR0dTQ2VtZHY1NEZjU1NNVnNscjdNWjRyNVRXTXZO?=
 =?utf-8?B?YzhwUW13YVp5N1hJZWZQSzViLzhYUlZvKzR4d015NDd0NjRQdWJwN21udnVl?=
 =?utf-8?B?ZzVPNEMzUC95RlEzQ291Vk1IM0pzV1ZBc0lvdjhVeEEwaW80RUtnaE54UFlw?=
 =?utf-8?B?ME13a0lVNHNGMnFKNklKMkVuN3VBaGwrSWcvQjhxbW1EWUMzZ2R4SWMzaWNu?=
 =?utf-8?B?Q2NFSWduUUlVdlpUd3ZBN0I0SHBSZzJmVENteS9zcjlkSlZ3bjVrSFpqOTB4?=
 =?utf-8?B?NS8xZS82eU95UmlPZUhVWFUrUFpScTFncVpJSCtLelhGNEFlVXRTaVBMSWxt?=
 =?utf-8?B?eWJYdEVYUnQ2Y0lGSkFWaHJ4NkY0cE40UDM0bi9SRmVjSmFsT3NkRlcweXF0?=
 =?utf-8?B?OFdJQ2hxVTU3WXhkek93WU5RRHFnZkx6aGhDSjcvdEg5NzRuYlpJVlFtQ1NQ?=
 =?utf-8?B?ZzJ0QjdmWHRXS3hLaEJpbjFMTnViRTdEbWx1cWt5MWVGWWNsdHdHNCt3NWR2?=
 =?utf-8?B?UE0rZWJaVEtvOUhXdWwvUkd3NUVhak5FS1JlYXA2a0lHSHpQVTZqOVpJaWRm?=
 =?utf-8?B?VUpGc2pHZHQwSGlXLzRZSkZhVlVQNVFVYUpEeU5FT1RTekdmMFE4MFZodkNN?=
 =?utf-8?B?dWJDeGVqNW81YUwyTVlzZnRtSTRLZlZ5QkdWYk53VG5scTFSeE9RaW1LZCt2?=
 =?utf-8?B?T08rRlBscmxmaU5iWWNOODJjOWQ3c2VCRW5FQlg4MzV3OGFxSGpvVmRqSUJa?=
 =?utf-8?Q?fdj00cXJW2iONy06xDNlV5A=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa91db1-8cba-44ea-948a-08dc1e7f3ee7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:24.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwWSvnqlvkljgiPPUcnMZWKEu3DOmEtWWjA5a9JZhyFGURyMILYuuZCzumyTzTKwDU8+v8pzwp44lM3EbRy404VB14aky93KZkf4YU0oaAliKTBD/BDjQFjJ+9WRbmsJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The RE signal is used to control the duplex mode of transmissions,
aka receiving data while sending in full duplex mode, while stopping
receiving data in half-duplex mode.

On a number of boards the !RE signal is tied to ground so reception
is always enabled except if the UART allows disabling the receiver.
This can be taken advantage of to implement half-duplex mode - like
done on 8250_bcm2835aux.

Another solution is to tie !RE to RTS always forcing half-duplex mode.

And finally there is the option to control the RE signal separately,
like done here by introducing a new rs485-specific gpio that can be
set depending on the RX_DURING_TX setting in the common em485 callbacks.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 ++++++-
 drivers/tty/serial/serial_core.c    | 6 ++++++
 include/linux/serial_core.h         | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb9..54d8f809b81e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1402,6 +1402,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 void serial8250_em485_stop_tx(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
+	struct uart_port *port = &p->port;
 
 	/* Port locked to synchronize UART_IER access against the console. */
 	lockdep_assert_held_once(&p->port.lock);
@@ -1418,6 +1419,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		gpiod_set_value(port->rs485_re_gpio, 1);
 		serial8250_clear_and_reinit_fifos(p);
 
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
@@ -1567,9 +1569,12 @@ static inline void __start_tx(struct uart_port *port)
 void serial8250_em485_start_tx(struct uart_8250_port *up)
 {
 	unsigned char mcr = serial8250_in_MCR(up);
+	struct uart_port *port = &up->port;
 
-	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
+		gpiod_set_value(port->rs485_re_gpio, 0);
 		serial8250_stop_rx(&up->port);
+	}
 
 	if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
 		mcr |= UART_MCR_RTS;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b56ed8c376b2..47aeece985f3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3663,6 +3663,12 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
+	if (IS_ERR(port->rs485_re_gpio)) {
+		ret = PTR_ERR(port->rs485_re_gpio);
+		port->rs485_re_gpio = NULL;
+		return dev_err_probe(dev, ret, "Cannot get rs485-rx-enable-gpios\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 536b2581d3e2..364583203a24 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -584,6 +584,7 @@ struct uart_port {
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
+	struct gpio_desc	*rs485_re_gpio;		/* gpio RS485 receive enable */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };

-- 
2.34.1


