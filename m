Return-Path: <linux-kernel+bounces-91512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E400871276
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E911C224BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26D717C96;
	Tue,  5 Mar 2024 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="esTPgzLJ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCF18026;
	Tue,  5 Mar 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603357; cv=fail; b=hWl6Ee94y0cOxp948g4fIbFMzets1fS7DlgZQ/qq+b3+SFRB6UQiP9v7d7qjLvAlyrv+/WNx2inqQeOXsHbdyeINWASTWIcoTEPNIB3yFGH7Fo4m+xktkcEHvVt9jHoeUT/dzx6IOcc8kvSdXFSkTJZGppmJvJ6LS6t1PPm7wmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603357; c=relaxed/simple;
	bh=w0B4jNOdGrj/R8zBykjKmmMQirfTlDwDSrmXPzyg4E4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=igWv2wets3EiQNSjrrPbDUz2fYgdxlsPB/i20Rp4BDDYcoTZiWkqW8msT2lX2Ac+2VzBLYpP92erPEGbIzcdOE1LpjYxS6BmYxztP4BLH3N8RC+q6pM+Xb/oao1v+xl3Jb4qKRIGWiwg42SlOgN9RkUxuJXXaSP8qJYZMFrwpmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=esTPgzLJ; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIDw+kIg/lXekYBYtXngKA5hR8u7PrXm2mD7jdef8gIx3UHrTy2AV/vJtNW4j/sDynHkQCkSEBFwcHaAcj/LuM+RGaepBFhsXvlqBnmjtFI3l6CefKVm+aUO6G8lb1mnJruCFcBb8OtGQFDRmmtRX0YDL5IA3+8jWSMChHzbS2f90R2z+rJG2BHQqSyLfJTeNJMXB4tWm88YG3hUFEXUYvHVt/PuIgx9XbBETkZXvxH6c0woaTVTkOsTe6FRWlmej+FBmMK2RunsC0unRfZ2X+lxEuLPdKTTYjinfTIel7hoE2U9xCD6AmTmPv9oQgl0TECP67t/64WuJFyam3ER6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+ZVVVw333Vd4QWWlnX7zC7MRQSjORjycBYC2Vxfm4U=;
 b=lONTLTjuS8hBJgGI8Wkr8IvnI2696g400kHLFJDg8up3RlOBHPdrUTLVbEhNU+PmfSU9H4ekTDAxIMUo0j5HOvuJPOo0gP5XkuAo+4NNs1PIII+jzO+toupMJrIzd8Gu0XKxWpGoLkLAIBxoKWm4be24osQqJ5ZePJJUNySFIidDRH0y/RKS2r+zeiDOOhAEndakK4f/fmS9gJIDr+29q9030yQWnFUTN3llUx0oDLCCatykHYt+QIbFBdQPahUtjg1/96S+L7lqKxzo9B/mu3LxHHZm1qEjjPd3QP465wC/CdodmiO607JWA232cROKVGv1qmO0AIPzrNUZnJ4I2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+ZVVVw333Vd4QWWlnX7zC7MRQSjORjycBYC2Vxfm4U=;
 b=esTPgzLJy2KtWBPFAl5NNUJk4UqfX/vXLd6Hbr7v58v+ApikeMouX/gyXL194enujxUYXmrcEgzu0mpp7vyymmJlAwC1mu9iZpy2CXBNzlbjLqNFN56iLW8MlW1cg6Y2+h40weDhgcw1bQ+hrsRVr/GZT9R8JzWNyT2WnXFOfnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8933.eurprd04.prod.outlook.com (2603:10a6:10:2e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 01:49:13 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::643f:faca:24da:e9aa%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 01:49:13 +0000
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
Subject: [PATCH V2] tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled
Date: Tue,  5 Mar 2024 09:57:06 +0800
Message-Id: <20240305015706.1050769-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DU2PR04MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cec08e-60e8-4bbc-4af5-08dc3cb6752e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZyCjSYtS2QE7PBC9IWTl4Ouw4gQylJr4ycV4sll4QQqsMA35KABQGEoLtpCcjnEDEmXPIQ5+Y0KfSV2+OUAw9/RgQlsyj3CmKV2kAJ+LGCIxSNIjc/jdk4tVPg6nIp8zJO3gesWpCyDsjv4D91whmpQha793g3tPBhhfRGh0TuoAhhtJ+F+5kimSPiwvqLENIhXiIqrezv+ia6tn65mz3qib3Y1+ZNYv47eouWlPHLYM1rp/OnRGri4D09HzEsiS5hNoDV+AQgPZHvuzau+jgVmZpo0c9H9dljfGfTzuso26kql9pTEMhzjpcQ6oeOHRLLJRbfHlRttBuhnVL08hjgyyhUJqVK+Wli1sptq3JZhcCdJbZEygC2vYq7W4P8tvhe+f1PlxkoDiMpUgP4GrVVO9WDuOrJWfN9HjjPZ/W01e9S6WHdtD1kkqwNlwqbmY215jm8/ZUnPGVQEIQiCUG13FogLvklXumMT/9UDxb5wfcoOg8T8j2V8Qv1pAbO1kyQ/rRE67+P2YIzC+GXuefNDi1N79BHAsf7NpAp3R0QxNYY9y3RhKVGDeQGtbtmiE8ZGq0wtmIjdDlVHEyklQJK3Z2hjjNtZkA/mxA5st2FcK9vI8v7pX7ldtgJYU59YA0nbbP9ASNKzSdrIBpR8lYBISsmHWwVYsIczwJfvpB5vIMv/Tv3q0YBdEAyQ7/MpWhPLUhaX+gSK43za7q9G+E743PTcDp9Qbd6H1Oh4SHNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUptR3VIdHdwdEtwaStnOHlmUXU3Q284YXhVMXNRMHlHQ1hiZW1rVVdrdzR4?=
 =?utf-8?B?bEMvck51dlNXalFGOWNqclllb0E2cVc1TGdraXM2VDhGY1NxeFV0SktoU1Nk?=
 =?utf-8?B?MGtnTU1sZFhQZStkcDc4WW8vTlowOXVpeUxqN3UxdkN0bDlYODVVN0lOSUR6?=
 =?utf-8?B?eGJOUTBPM0U4aURuVU5uSGRLVERSRG5NamwxeXRWYlNVMHZHKzQvZjU2WXk3?=
 =?utf-8?B?dDJqVmV6bWJud0VzK0w3SUg5NXkxTWpQRlFXdEV5WVdYUEQ0aGxxYUpuaEFr?=
 =?utf-8?B?ZHdMVHpiTVNvZ2IwOEVvNWNQNGxma1lDOFRNR2hFK0VVeXB3YTNqZDBFUXlN?=
 =?utf-8?B?V1BLaGk2K3EvdzFJeSt4ZU5qZ0dNYjFCbm90QUNnMzk2TmJ2VEw5RXNWTWZx?=
 =?utf-8?B?STFFcVp6c3JJN0toUzNMM2xTUEpqQTNmVHRwSW1xcVNHM0VXSnlsYzRESGs2?=
 =?utf-8?B?SU1aU21idWtZc3M3L3M0bjNSMXAyQ1RuY0lhNS9SY3pYZGZVSXkwODJQTWF0?=
 =?utf-8?B?K2pVemhESWpVT1YyQnJNaGF4UkdrODBaODM3cVNqdS93alFMbC9lcGl0MDB6?=
 =?utf-8?B?K3ZSL1lxUWNDMWpWVFpiRS9lMWY1THhWcytoTUhXZGlnNjRFMUdZMTNVdzJm?=
 =?utf-8?B?VXc4TkI0ODc4bXVVMDlVZEQzblRkZTZvZVhOMndqVDBLUENkVlV5RzEyaUpF?=
 =?utf-8?B?NkNVRDNSeEJYQTZqL0xvcWlMZURUcmhWSklaUWNuUXEvMGlhS0drejVLS0JZ?=
 =?utf-8?B?Mm4yakdiRm1PTlgvZW56ZTVzdjBmTmgwV0Y5SmZzdE9hK3lFSXQvdVpJKzd3?=
 =?utf-8?B?djZwM3VNS0xLamZmZmZ5VlpPcWF2V1lUMyt3ZkZ0Wkd2M2dlM1g3YU9FWkls?=
 =?utf-8?B?UnV1TnJyN2hYSGtRNlkwYlNHOVJTUGxhcTQ0RVNzcVBtWkJhUGxYUE1BaXly?=
 =?utf-8?B?WDNqYmpsSkwyMUNGeHQrRVpJeUJnSVF5dzY2WjRFZVFXdkwwc0VZMjIxN0g5?=
 =?utf-8?B?Q3doM2ExUlRmREVlazg4UVpIVnBieDVwNjkrKzdJbnRDdThmeUJlTXJlTXlC?=
 =?utf-8?B?V1dwOGRPNHd0eFQ0d1NzUkVyOEhUNmxPcjQwd21nd3pYYlRWMmRubE9rditO?=
 =?utf-8?B?S2xiZDEwYUZpT3o0YjlzZTc3cFEwaldCSUh2eDhqV1JNeDRCd25CNDRMcm5R?=
 =?utf-8?B?QTRSQ0JSNHROcjBvaUdnNFB3WldMK3V2bzJFNjBLOXFuVXJHTUVmZlk3aWpw?=
 =?utf-8?B?NzczY05ieGtROTE0eitrZDVHcytNdWI0OU9GTW9QeHJIcUZKbEJmdzJqWXNH?=
 =?utf-8?B?d0YvU0tVMkdHRDNqcnpZS2kxVFUzT1pLekVDb2ZxTWN4U0tmckhURC9BeldQ?=
 =?utf-8?B?QjdjOWdkZXZnMTRtaTA2SlZ3cktSYmc2aXNvTVRxUUUxaHJSVXZmMk9QbVA3?=
 =?utf-8?B?YndSRXFpRjlCOWRZTldrYnZSK1VlZUZ3d2FVSkNaQmJyd0FJdVo3M3VoaGdN?=
 =?utf-8?B?ZlpxdSs1NG5QNkpzM3E5QjNoeEt6dk5SL0l3RTczUGtGZkhuSm1TSFhwTVRx?=
 =?utf-8?B?UmZMNHB0blRqbGtsWmpLZkxIZEVybHAybzBpU3BCaG1UanVXVlluMmZ6OXNQ?=
 =?utf-8?B?Z0dRQzAvaG1aNzZ2Tlc4K0UrZWFNamdNSFRVTUdFdEdtWklUREkweDBjbXpN?=
 =?utf-8?B?NlFEdFVmYXZia1hSMGVFT3N6Q2xFOEFnNjNCZzQva05YZFF0U1RlN3l3SXVT?=
 =?utf-8?B?YnNiMnUxbFFCbjdneWEvOUFFUUZFdXoxd0RUM0N3eFdWUEU5dmloNEwzMXNl?=
 =?utf-8?B?Z0VOcjYvYXo4NHhsKzNzQ1BSMGlmc1BqS0NJVWxOamNINnVhT1lpRFNhZjRm?=
 =?utf-8?B?dEQwUEtsVWl0Tk5IMk1Gb3FySHZtNXZVZnFWbVYvQmJPSmV1MSttei8zdnpG?=
 =?utf-8?B?QTJPajF1bDhsUUN0dUVEVmtpU2IxR0VtYk9MamYvR1hzRnllQjFKblFTTStK?=
 =?utf-8?B?WDlzOGxvSW5PbDJLak4zakoybjZWV3Y5ZWhkNW53czJjVTZ5TXVDY1ZKaUtS?=
 =?utf-8?B?MWsxdVdhOXFHWXA1K25ieVRmNTVzL2l2NlRaUEJvbnVQbVdIbTN6TWprMjhM?=
 =?utf-8?Q?aQvMaxMYI2rVfc85woRXorotZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cec08e-60e8-4bbc-4af5-08dc3cb6752e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 01:49:13.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uN1SE0fTrhtJI3CDXgST9zlsPKFtircaCtaX77857copKCildsMjuGPdIHJZRA6ze0g0rL3BOqbJC4WCtgB0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8933

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

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Move the "restore control register" comment message to the appropriate place.
2. Add Fixes tag.
---
 drivers/tty/serial/fsl_lpuart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5ddf110aedbe..bbcbc91482af 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2345,9 +2345,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	lpuart32_write(&sport->port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
-	lpuart32_write(&sport->port, modem, UARTMODIR);
-	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
+	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* re-enable the CTS if needed */
+	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
 		sport->is_cs7 = true;
-- 
2.37.1


