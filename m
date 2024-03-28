Return-Path: <linux-kernel+bounces-123249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87781890521
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEC1B24A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD51327E2;
	Thu, 28 Mar 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="bmFz19dW"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2112.outbound.protection.outlook.com [40.107.14.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F212F399;
	Thu, 28 Mar 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643137; cv=fail; b=Ezo/Dy2fFNJrtsQsQQKFUsVUmFds/LDpcG4mV7mUCn6pdUOtjk/cRhSC7ns/9ZlXTdxYnV0RV3Q0Fvf3jOiD/2aepUi+NzjwpKDGXOtTu/wKazgzB6PIVnY+y7VddJgKVgHzl3lLkimhYXw8pL5B/3Z2kG/2wkuEPC42Xg69KTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643137; c=relaxed/simple;
	bh=osEPO1tew+CMOpuv5J9rsKi+wmwKhDnB1kdG/lLAHPc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tf0lvuRBEiw8gHnn3SVPw4ixqpzPG+isOpnBCfT05jq//6Bk+C+XTuY2TRM2EZj9fLp+saCPbRReKYVOaAtOQYpH1J5znFfIZGoq3tWhc7OA7OJRzEbNGpYWtubDXVoqVZZ3En1qP8z0yoWCeII1VuFwuWl7tszDKLDva6DR2fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=bmFz19dW; arc=fail smtp.client-ip=40.107.14.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnYhzCoK3E89ZDA5UCmCz6NkBpNWDrENUd8F0HCR1Gv7khvADjwp2j2/22FSlh0pOotFpWdGVkEW4tUPKzRCZxsFQtXU7cWgsbVpHsqwFD/CZa7P2AjULGvywWngkD3d5GOO6RRvjG+tDfVf8RKxD54xc4jNJQ2bnfKxnQv9jTDQX2khiy5580FBJbICk4pl4QONfVLeVYNYzerj8iYXz43myECZYTapdqx/Qw5MSvJcg++x5i5nd0WCEFRryQQ5sldbcwrSP7u2insvE4lJn1Px2uy1jgYEhkgZMvPEAb5JKkfSLvfIDgcdWru9xZAH79NHdnDY8IFVj9PgYY9QKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXaF0eUZPso8n7boIJy4yTZBwSmWexgEDBQC14JUkQg=;
 b=OGt2WRKUiONkxaM/orgl7/KoVS7vIb3sGgxxoNVxFeNO068vAZkMq/SrrxL9GjkC1KAsMFliGeaF7CcP55V78Bikt4OBkgA4fq939rE3GkOkB7o2RVGWLRRq851Rmh16gWum8/ahPcqBYXylbgCvsqP/B0Nl1C+FKza/XIqJ3h1DRmb0RbMm9DmRntHXr4jj2ufQEiqnyr8To8KhmBs7dTd1evVBVTgRCE3ABo8/mN7OGk1GVI/EPnxuSQXLaIEW2BgEH9Za5X04rwzqXog4GNGTvsRhVwMca30NnZ1v4yTx1lWAuKa9Ku4FMQbB23MbQGaaavHIwyMwnYkryKqikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXaF0eUZPso8n7boIJy4yTZBwSmWexgEDBQC14JUkQg=;
 b=bmFz19dW/wGcsLVFQITyCT6IswF4+fGe2xrMARbLgJBhnRwTZWSGME7qaohr9vvlKQUMxU7Vm9bTBwCq/iJ6eJKGdGVWdL1aczoh0fByE5UA/O4Zc7Tv3ZvUBNNzj57JgWKyz5PjuEYzq/cQMmo9xq5LEKUZdywY+kmMH9uzZsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB10358.eurprd08.prod.outlook.com (2603:10a6:10:415::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 16:25:30 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:25:29 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 28 Mar 2024 17:25:21 +0100
Subject: [PATCH RESEND 1/2] usb: typec: tipd: fix event checking for
 tps25750
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-tps6598x_fix_event_handling-v1-1-865842a30009@wolfvision.net>
References: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711643129; l=1932;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=osEPO1tew+CMOpuv5J9rsKi+wmwKhDnB1kdG/lLAHPc=;
 b=fbGkF19sZagneYA4EdYoIeH/pgszNTTzOCkb3NsSvgrJn+cyX2sSP+pTc5dmss0DmD6bnnlNT
 30Jv0DqEsLBC3MATUDjE0SSp1CYS0bZcLNOMUBJfYLR91OW4b7z8HTB
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::39) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b69eca-fe5b-4d6d-804e-08dc4f43aee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XJ1Uhtzg/6bal60GAXJpz8oggVXiEV9TjUDWY6LsJH66taWPA2PiUkmExK+I+pdbwI2gibR1U2d2GXmSdSLT1g2gIpTxLwomSOnft0/PdUc2elyJg3FgPUFh7DMLJyY9zjmZsNpFjd11EIFwGeJFDGxeJsE1liPpg6LI6M1Q4grx4UEYoZNrXAJVEWN4f6r+faecZIqHdq4BnO4NE3eqj0v+SsxerQXLf5ZhUBRO+RdX/rcp9QbiERWYu+P4sQNZ6poiI4y+LelKTnf+IyI8TH1PE3w5Ahc7HAn3ENzxgUgVUX+EjTNE6UgIwedL1evGMS1gMDl5m1D6IemCnjXPgtX/Zp/xUHAXgdqSQTHH/xnWaDXxuQRKWSuo+aVSUG3b7Gu57MSvwplMf7u/NjGOagSNObmSXpXqq3M1PirGN+bsqZrpbhtl6hPrMCKHkvjFmFnPYWYPjMKTtNbYWQuexCAERZ35U+jl5SCOVi/knuYtxQiMF62luFo+/D4svOnqR0jCKhV9jWVTpt0mTK9L3DFfxpolq/rH128rlqrfYwJXLJrm6UlYgXHZxp0TVu5DcGqLY0mHJTo6Vq+a4TceWoNhaQCPvl3bQaBoO29tgQFFMgDispMsAqm85fYGHh6hzKsc24EQAmYdQIqnD0WlQFVxkPNsCDKUmRpqiJnW3rACmH7xeDX9Y5ozQgNYgsW0TKEavvI1ujUx3Nxle7l1z4Cadfs+FL5tEg7k5GDHRDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFBlRkh1UHNpQW5CUzZwOXl0RU95Rmp0WWc5WWNhbWJqVTd1QlZ3MEpVUEd5?=
 =?utf-8?B?NkZ0UTQ4WXNFUFBDU0xXSm91WEpUTlBkcUFuTlBMTzhxU3Y1SnQvWExEeHN3?=
 =?utf-8?B?ZXlOYmdGcHIzR0hnMG1XT3ROK0Vjcjc0dXlQbUxTZ3ZuV3ZQb3M5RlMvWHJF?=
 =?utf-8?B?SE5vT2kxcGlsY0V6eFZVVUI1ZVJoU2I1U0QwKzJXZElPV0JNZUloMzdSeUxo?=
 =?utf-8?B?SnpQcHdEY3BtSXdiNkVuc1Z3UHRjOEdvUzVyQkd1VUg4eFQyVER5WE1KajJw?=
 =?utf-8?B?c0xxaDhGSmMrK2p2VnpxNnRJS0lRT3NUOEN2cDZPejNBT0pLaTFreWRWY1dJ?=
 =?utf-8?B?QlQ3ZkUyaHJRK3FBeXlEL3VwK1pTTnVPMUhnZ0YveHNCQTI5U05Bc1AvTzVu?=
 =?utf-8?B?RjVVVEJDeU9EUC8vdStUdDFrcnNwdUpHM2tzTjltbXdtRjUyMFlGQjEvYlhr?=
 =?utf-8?B?d3RqTDBxdE12NjgwZStGeEhDVklQUk1ncTBidURYRm5sQk0zdk9BZ1VURHdN?=
 =?utf-8?B?ais5M2twa0dEcmxnZC95N1JRanNrTGgyWHV0V2pFVzZhZ1hNVW03cnRBVmpz?=
 =?utf-8?B?RllWMXBuZUxjNjJlR2xLWGdOei9TaUpTb1c5c0xtZmo3Nk5jcDdGVlBuSm93?=
 =?utf-8?B?UlNBUGplTW5kb0tuOTRqQkN3UStzMm1WTVEyTVRlb1kxdlpLdTRFMndUdnZE?=
 =?utf-8?B?blo0eFN6RVNMeHZQT0VrRUV3R2dhOE90Q2o1U295SGJyd3d1bHp3SUloVU50?=
 =?utf-8?B?bldHeXVUTm1aOTNiRklkZk1PRE84S1VsRm9aU0tnM0wwTzhpNExvV3F3SGRl?=
 =?utf-8?B?REROQnI3UGlxZjBBbkp1NkRXdU5Ld1Uyd3VFS0tBeUpCNEN5eUd6YlpDK0ZV?=
 =?utf-8?B?TlBZTlh0SDIxbTRUOGcxWEQvQ3E4a05YbytZSFA4eW1vTThEdmszRXJ5UGd0?=
 =?utf-8?B?VkNFVmtuSTBONkY3ZjVuYng0eWNMS1UvK0U4S3BuRklEckhwUWpreTFleXA5?=
 =?utf-8?B?c3lDdG14WExaMUdvT05JL1ozalI1QlR3TXkvWkY1WGJPeDFSTWYveU1FMDlr?=
 =?utf-8?B?VG9QVDFFWHpnTGp6ZWdvclh6Q0hyOHN4dUgrMU9DRU1Ic2IzVEY0MkxiWHBx?=
 =?utf-8?B?c1Q2Tis2ZXJ1VkdwdVlFd2pQSkJNOUt3K3AvZmlwWnNPYmNqRkZuV25FOFBi?=
 =?utf-8?B?SUdvUU5GMWVaNmt1UXNzbkxSeUpXRkJiSlF3R0dYVjVPMi9uV2dWbSsrYzdS?=
 =?utf-8?B?UWRzRGcwc2U5SmVWVFJwWDRZNmxBNGxvWVorZE13TzJYaWp1WjU5QmpqNUM3?=
 =?utf-8?B?VlNaYndjRC8vSHU2d1l2WUNKT2hUNTBZZ1hKUi9RczFzcS9vNzVYQ202Mmov?=
 =?utf-8?B?NVQ0cXJ1TEYzMk1jV0lEdW9xbEVZTWtKYkp3eUlyd1h6SFVqbk91K2JpUXhw?=
 =?utf-8?B?bEJCZUR1aEN1Rm9HNnBpT1hPS21yS1lJZVJzbEJiQWRjMXBVMUN0Vm1qVnpu?=
 =?utf-8?B?V1A5WUF6N2Z1QmlTbVdQbHIxZ1Nsa1piN3pCTmFHR3kyWU50OEJEbzY3d1dn?=
 =?utf-8?B?OVBGZjB1elVubjNJMFNSYUY2Y0JHWjc0T2QvNjdpWTN4eGJKazFQK2lCdDNp?=
 =?utf-8?B?YVd0Wm5BaVBjSm53TnJ3c1lSeXZJSWlYbk9QNEhnS2xwVjFaS0Y2a1JRUzBj?=
 =?utf-8?B?OXo3dUlSVzVLL3RaT1VBeXdaOERJeWVuK29WVnBkWXFHUFFweUJRWGh6Qm1C?=
 =?utf-8?B?UFJOTmh4cW5PUWZWMElBbExxVVlNMi94dUNTeUFETTRSOVV1YStRdEpxU2hV?=
 =?utf-8?B?OEgvV0d0bWpaNzVDZmlYSVpza3ZiUURoaHRyYzB1cEtCUWhOL0pnL2RKTUxK?=
 =?utf-8?B?Vk04L1V3NFA1SjV0eTVXK0IrTWdneTlYZVd0bGZqdnJ4bFI2QklOemc0U201?=
 =?utf-8?B?Vmh6V2dXajRkZWFOMlhxQWJpOHhBTFN6SjM0UVNYOVI5QWhURS9EQmx3RnlP?=
 =?utf-8?B?eTZ4ei9nQXRybUxCczVTSU5MYzMwaUFoZzNyYlBTTTFrV3dTTlJ2V3NzV3Jp?=
 =?utf-8?B?aG1qMVdXeE1Bdi9QNVdxVEVIZEJtQjgvdHhBRGI5dVUydHN3NEdrQksvN29t?=
 =?utf-8?B?V0ZKeHRhUi9oSjdrU0VpRDV4L3dKcjg2ODVHaEpYYm44eTkvSElUekZSTkVB?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b69eca-fe5b-4d6d-804e-08dc4f43aee7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:25:29.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxWSlIEksCCkXv93dRDBhTQ7qgJ5JuZ6vLqPpWRgdldmMHASTjFfS/Jb1GWkMJU5dTpCfQEnC32JKWHRWCbBVHwFQYRTBMTECzoFIoF4vyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10358

In its current form, the interrupt service routine of the tps25750
checks the event flags in the lowest 64 bits of the interrupt event
register (event[0]), but also in the upper part (event[1]).

Given that all flags are defined as BIT() or BIT_ULL(), they are
restricted to the first 64 bits of the INT_EVENT1 register. Including
the upper part of the register can lead to false positives e.g. if the
event 64 bits above the one being checked is set, but the one being
checked is not.

Restrict the flag checking to the first 64 bits of the INT_EVENT1
register.

Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0717cfcd9f8c..7c2f01344860 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -604,11 +604,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
@@ -617,7 +617,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	 * a plug event. Therefore, we need to check
 	 * for pr/dr status change to set TypeC dr/pr accordingly.
 	 */
-	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
 	    tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 

-- 
2.40.1


