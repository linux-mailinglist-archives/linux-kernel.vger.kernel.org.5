Return-Path: <linux-kernel+bounces-89968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E9A86F858
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD00AB20D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA317C8;
	Mon,  4 Mar 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kj65FoHv"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3EA31;
	Mon,  4 Mar 2024 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517607; cv=fail; b=sLz1qBIY5l45YR6iaTQEFFOqFGmvdOQwlcd6FQVqxpvzdL1N02jV9GQCuiT71/Fwi7Fzvzb10yo/WX8g3myeeys/26445TxwJYpWBvFwxh5kbWEeAi7AhLgI7aLdscUrv+8oglGfSHdC14hwrL3kfk5pv5LgYyzacfYHgqUhJSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517607; c=relaxed/simple;
	bh=AHzr6an/u/3D8jN/H2BTmKZk+tPXSHnpSodxSaXz640=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TwC+RQHL/sjpTN9ZjH21itsBQsBbptTZJdzH/6nafSCbxeWtMSAzzll/9KfZqA+ai1UeLOhfNeoKHToRF4g6L8UalGNb75o/tFY0tCFOznZuPDlMCKyRWvXm1i/lYR5AtUhwN3rG/lTBQunIODg1ymo06168gWPK8EtFtDd+Kt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kj65FoHv; arc=fail smtp.client-ip=40.107.8.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv1SGhKw2TpCv62vEZtH7xyTcfhYK1Wacr2Kk1nRRvhLnzneK4wh6Ih64RuSCPT181h/VDK4JDWzvCzC1t2hP2kcVYDma191+lw2AndqLHDr3HtihnhB4515hBp+kgbJneBzZA75e/T5GeOxiL3lfmYKsYPWVbCr9X4+kKPwC2tDcjSpBjZR/WP6Pq4ZOKuOBBSrBxo89k4pPqMSLNZyrHaTCC+QgaHuncDL09GQrkaxJFxABJ5gbXQZM+6B9M4Hmffa23Edz7nZYFB2V0KPMhJymtEV1BcD326KwyALTgtH59VmauR78Zayh53/lWMRXKLdtpX8cDWsqOS6v5cwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBHquXc9OSoe7dBIVnlvVe4lm3iPG7yoZL5CfPxxCPs=;
 b=SBgPEKXM+UEB3AlWsf+ywMaB3LwnR+2vOELxrkYSjWtGy9XhBGR3AIYxxAdSKARBRyWkGRx3UaNWZ/MvZCP65vpNECG3VJkz/M1W7fByjhBXeA5Ft60tL5csspjk++m+o+R2XbEKV/cfDk0wWU/TS/33O9LpNgo5o/owRbZ13Jch9BcY2zUWFeqQbA8Dt04NFjmwJ/W9ePCmwo4k2d3pMbD61yD6nagdlO5gNOxe4sBdX75sI+wXSJpIRGxP0e9Rgx1Hs4UfNNyOEO0glIYTA+0MJjzU0s6bUwB8zh4utqW+0rVepAYJYn+N7zdbAv4bYu8de/81rK3lO45j+kJrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBHquXc9OSoe7dBIVnlvVe4lm3iPG7yoZL5CfPxxCPs=;
 b=kj65FoHvL451Eg+6YM9QpVDtxaookZJlEyLDC5iGs3wt1kMTlGlar7bgQvW/s1DKUbUa/GYKtKEwSp0QtUeZbxz/E5h3DCromovFeOorBI/UOHHXcH3plL34nAgkjRjS5xmIU7rmSM1WksYYqbSxcppFraI5nLzbbupcmW3KtxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 02:00:02 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:00:02 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de,
	ilpo.jarvinen@linux.intel.com,
	shenwei.wang@nxp.com,
	alexander.sverdlin@siemens.com,
	robert.hodaszi@digi.com,
	robh@kernel.org,
	tglx@linutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	frank.li@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled
Date: Mon,  4 Mar 2024 10:07:12 +0800
Message-Id: <20240304020712.238637-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dbd8c9-8f96-4b92-1b52-08dc3beece05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oZ0d6wUYkIxqDLNJNVl9Lmtsl6NxxUj0YHvPPFgNs/WhWAXHhhuoVeOI999V3s714KlJdrr3Dd14J/R1e3gR+aKY5zTHh1KSKtXPVb8YwN7vmoFRf1o3rSWoBYSsHZF8+0RAIf0zJxmgZwRJMof48FTlPZEIXz6aPGi8xas0S74IS3clbAtyd0KAh23ENHDfFbhj7G9WP6T0fU8WwL/n5uk1oiZLXHO4YHe00806shhwwWZhK6k5hfMoo2yFs4P/5tVQO9voIoAkD9809+BNcyX/iPxa0qh9qcK8rsraCoRM+b1YND95cE3AE+SNJa2WwSsibdNCb5Y5wJvjmIeUGk9bL4hcp9P2h/Vop60PQ4NDS80UZw80LeH2lcuqSuU8CpaAJ/iXbhJxdo7yl9toYqm7lHA9IkOt/bTYvQ85Mg28eZRTP6k8Y0LPekdLqTLUasrxxHOuk4Hc4ZWuqEH75VlpCcK6V430LeT0Zf1+e1ySpknhALK2LZKk7N8RknHnhxSnXQ2Va9F6oaNWbHpIGqCHTdtnCU1Wpq2C1vn/onBVI13PVlZeqa1e2hnYzEZuzADTNUXHezQgZBQEQ0DMXjQya+oHBM1Sqbp6Z/N8kh5JHNXZppld8+FXOp5iccr4a6ihtWqfs9SmxrpDq7Tz9RESCDnH7sBQ/3ROZV/ck4HLzQweO8fITZqfpJeMo3fC2FMLWj/nqoPkmLa/r0kRCeF/9uC/DUXIqc7VDG4cqHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1oMjBXekpwanBkVHRNY3hUUGNRRjVnYjRYYitFZ2Rycm9ueDcvaTF6anE2?=
 =?utf-8?B?TU9jcGVVYmQvdm9lVG9PditrNUs0OEJUSGdXOHNNMkhSVmprWTdsK21uUVI3?=
 =?utf-8?B?Njg1V3o1bVVNKzBZSnRlVGlsWHhjbjZOaXRwSHRyOG16SjR6WUg2eGwxN1V3?=
 =?utf-8?B?TVFXckxnZ09SeFUwY0IxU2FOQ1JlMWhBalRJTEhNRFVmMTdZam1kUHF5RGdh?=
 =?utf-8?B?d0RjUUVqMWQxcXFiMG94WHNRVU9Relp2RzVzd1F4R0F1bkkzdGovWmNqVnJt?=
 =?utf-8?B?Wjg3QmpWdFNKaTFvUUkrc25mSDArZ3pOdGNJYWUrRnYwQ0N5dmJtVk9OdFpF?=
 =?utf-8?B?ZEMrSzNyZERrang0cTdOSkZLN0ZrQWJrU0g4SEgxSmNBZEFhUVBlWmo4Zll1?=
 =?utf-8?B?TmJ6ZkQzTE5lWGpxQTF3elpjRUwwelNmV1FaMTAxYlAvTE9xSk5BT0ZMbGVy?=
 =?utf-8?B?YTJqNlVRVmdwM2ZyWnVUb1NUQWl1ZXNDOFJxSGhEV3dBVG5iNlpodE1LQWlj?=
 =?utf-8?B?TktIOVJpRE9wenFtTERuVDIwMGJMR29nbnRpOE9EVjlCZjRtQ0RnbXlOZDcr?=
 =?utf-8?B?QnY3V29rOFArRmoyN1lQZGpoWGp4MGRzeFg4bHpRTkZHcHVMT3haMm9Id1Ew?=
 =?utf-8?B?alNQcXVHVjJzdUcvV3VGdmhwbVBUSVBEZ0x2MjAxRG0ybjRiZHF5V1hFZ0dL?=
 =?utf-8?B?YkFMQWFoYmJTUmRhN3l6MnMyUUNzY3gxdGNRZTBDUWJ1N1ZvVGovWkdlYTF2?=
 =?utf-8?B?TU9uc2t3U2ZpWU4rQnN0TDAycVM2YzFCTUV5RGZ5WldTWUxqV0htUFFYRCtH?=
 =?utf-8?B?Y3Z5cFlmWE12TzNud0k4ZWluRGZqbnhYZkM3aDRFN0xCRlUrb1h2bnhsR3g3?=
 =?utf-8?B?OGpna1NDTERSREdpaHNiQmVPZ2llQUtnQjhoOGg4dHRIVVJ0Mm85K254dDlD?=
 =?utf-8?B?MGcyeFZrTUpwTUhxamZ3UHlVL0ZKNmVlajhKaDFjMjd1c1ZKRTd1SWlmanMy?=
 =?utf-8?B?UU5OZEJLbVpWTDNYUmFRSDM4OU9aVk9FZkM2RGs2eVB5TEJmS3piZ2dDWmkw?=
 =?utf-8?B?K0tidmZpd2ZQaGhCOERxcU1TdHcvYVhoM1FVQXdxTkFlc2F6SXlEbEtONFV0?=
 =?utf-8?B?ZHZITmt3eXVHMWFFblR4VUpURmF2bUJTM3NJV1pZalNiVnE2TGFsLzJQNk5U?=
 =?utf-8?B?VEpYSDVHMzdjQ0VKczNkd2FvcVNEemY0RUh1bTQ3ZW1WNHZMOXh1Yk1mSUxX?=
 =?utf-8?B?UzY1amZWZjlvclQxVE00MmNBNjhuRE1aNGpDclZudklkNFh0UmxyK1B0a25C?=
 =?utf-8?B?dmtmdFV6a1Bxdk1iR1RiRmRTN3YvSCtoWGx1b2Zvc04vTm5PWXlmUXlFUFYx?=
 =?utf-8?B?Tkl2RWg2Z0Y5UC9ZcmZPNmJZeU8walpURGcxMkg4ZmYxNDkyOWp5ZU1RVTNl?=
 =?utf-8?B?WlI0RDljZmh6ODFwa2hza3Myam5RbTFVc2RWb1kxanVNa2J4UU51WVpDcFIx?=
 =?utf-8?B?c094SjlqM28vZDVtbUFsanM4NVg1VDNkY1VTRWh4UDRYTHpFNHpvSXRWL094?=
 =?utf-8?B?eWxmd0FWb1VMQzYybk5BbnVnV1RCWWV6ZE9ldG5EcEFtZW9mZ2FmNkU3VW94?=
 =?utf-8?B?MnErOUM2c1ZKY2tPUm0xK25wWWZEcHFOMDhXd2E3c25QWTZKWUFpV2R5TERJ?=
 =?utf-8?B?dURJNGRjZENpRWR5YVZBRXdyU25tZDFaWmd3dzUreEZPQldORmdaTVdnU1Iv?=
 =?utf-8?B?RlFXN3dMVlNXeTBIK0FaVDZNNURjVEpWL3hnYU5BeHVISkdMZkJhSWtsbVZi?=
 =?utf-8?B?d2VVc2J1Mmc5Z1ZVZGo5ZGtOTHU3dmtlbW9sVi8xZE5uY3ZSbEpwQk5Ca21T?=
 =?utf-8?B?TXN4MTNGZFRmY3VUOGFIY2ErRlJTbzNTc3F0Z1FWckZSOUxNNGhOUnE1OUd6?=
 =?utf-8?B?TkFQZkswWmRVcEtIUDJaTlhkS2RsNGx0SjRweUxmSStmWGZWSEJMSnV4MTdP?=
 =?utf-8?B?MGNlWjAreFljTisyQVF0RTNkWkE3WlVBOE9PMzlITFB3OGZ4WUdHWEFMV1V2?=
 =?utf-8?B?dVdxWmc5d2h2bjdTNW40OHk2cHVTb3FYVjh4MmxFYVExOG1XL1EyeVB4QWNS?=
 =?utf-8?Q?j1t12nONHUszUs3zvMuVycgLs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dbd8c9-8f96-4b92-1b52-08dc3beece05
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 02:00:02.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yhY2eat4y64uNU4k68ksNeBN6QTWjuRYg+VkOdl5sX4kvilHjDh9Rv4UotKraqG2rhLr6psoqkZ+4gFDo4zCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

If the remote uart device is not connected or not enabled after booting
up, the CTS line is high by default. At this time, if we enable the flow
control when opening the device(for example, using “stty -F /dev/ttyLP4
crtscts” command), there will be a pending idle preamble(first writing 0
and then writing 1 to UARTCTRL_TE will queue an idle preamble) that
cannot be sent out, resulting in the uart port fail to close(waiting for
TX empty), so the user space stty will have to wait for a long time or
forever.

This is an LPUART IP bug(idle preamble has higher priority than CTS),
here add a workaround patch to enable TX CTS after enabling UARTCTRL_TE,
so that the idle preamble does not get stuck due to CTS is deasserted.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5ddf110aedbe..dce1b5851de0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2345,8 +2345,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	lpuart32_write(&sport->port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
+	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* re-enable the CTS if needed */
+	lpuart32_write(&sport->port, modem, UARTMODIR);
+
 	/* restore control register */
 
 	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
-- 
2.37.1


