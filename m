Return-Path: <linux-kernel+bounces-40434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFD83E013
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB9B21ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0A210EA;
	Fri, 26 Jan 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ADp6R7XP"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D020B03;
	Fri, 26 Jan 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290127; cv=fail; b=p0HMCRguNyaLjmOG63bDouHd4uOHiDhR6NJN1PMd7DZVpos5bzte5rOBwrG4jtLI62ZzqUasT6u1CDU9YPb6i8MOdbq5UYAZiLiOOJlR8r5jQIk1GWoaxm//wiCbBgNlvaIMLtOCd9TSZhJnTKMym1bME7fKtuavMxaaGtF53Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290127; c=relaxed/simple;
	bh=l1d13ELTWhBx9r7ZyCx38tmaecvefmaXOs1Rj89aQOU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o6j3QXQ658SNpByaWnN2y+beiYbQRgYtAdV+yU7J19hetCkUagM0ZTRx9mKYZygaaZt6aibzcXp6z6EJiiqS6Rtc4S8FJoo46S8mDKQCMRBOivxs+g1kH6PpQpabCnRDWAszxHQjBEOo1qAZXb4YzyQMHBca5ycFp7Wy92UVaQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=ADp6R7XP; arc=fail smtp.client-ip=40.107.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edYu0sIv44RobElJq9+LJs3LFvIVuuc4YJF2UX5cvt7Sm+pkmK6e3/2LagO58TPYYqruaGPFprRzFG95UzmAonZMcWmPg066i1dbZFX+xJJq5bAB6Ivd7mXTKqr6l6XfThAkYpBpjI9nTXeOTUcWT5hUgtPmYZjgsTjodUU60I21AbQodyUyM5k+DgFM0MH1cMZpUpn9bMpINlkTXVxBmCzx0HN5pqblxMBn3eHIbR5yDqEu7J7s1/kE00FwSY9EJtNlS/sCy9Vn97huxJuUejPzKIprLiq2dsZoj3VtGLsTusXR6aKTVqgJ7MoFrQ+a3proX2sDmaM5aV4pLLSJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P56s9wl03DY+fLo6EIOde11v+SFMSsCN3B9R9xRY4w0=;
 b=WtIQE3xnvm0XFAHxeoU2RxJvyScFozhSmbfSt5/TI7D61j1nwEgU9OK68qHU1eQdB58WI3u5QU3v5OAzsvXbsY6sW/2NKwLuFJH83z2rBkGfWNT2SAc3MmvkR6pRkd1UC5W2XYXR/VmitiBAXk2UJomoxPwj98DKpheUrn5lidzl5iwUYVtwuG50FdLkSuwQw3oAVsRRmFr8EZiMeypIECa9138WVlzh64VrLGDb/m2J1dexz52IQIh6cLpkzn7IU2zYqPMoVcUeO6bdwuNTRL/d7kXgjqqppYDI1drO6qZzj4H/rXwah8KsOK+ENKXOB8l1jb3aAdFHLpx45i+7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P56s9wl03DY+fLo6EIOde11v+SFMSsCN3B9R9xRY4w0=;
 b=ADp6R7XPUymzz4Q8gIdVNi+8yYplwWXQhlwQfglwtbJE6tIA4vXbJIXRUfSWcplx8pAUe89rPJCMtLIXkLJkaWJnCk8EMBWan27EktAqp5J9BNhrWHRJVDvFoMMhDsAhNdGPyS3yHrNWQqSwyy13xW3wEmJcwjPPOPdgYFJsqAflLWvkaOZuYrXS8EHgDJWa1M1Lri7MCKiqQvNFvCu+0BwePwraHBpAPJyH4XtF5Do7ZMQriOyDNalxOAOYwXQXnESuKJsEzpPsf1YWpciBBCs5SgUb2MnicDumBD4JwOKNZG7x3zlvKgwWxZVqoEp4YSWFmnybYNFQX5bx/3wkBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:28:36 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:28:36 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 18:27:43 +0100
Subject: [PATCH v5 2/6] serial: 8250: Support separate rs485 rx-enable GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v5-2-5d934eda05ca@theobroma-systems.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7fb270f3-4e58-4a2d-3af1-08dc1e9439af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uyr7kRpOo2+s/HUqozm8zOo99oKW5pm7EO8utB3lOy7xcqnpuv2uC//f+kmE2728hYCeKvSq7Zl5M9g4EOVy9f93hX5snVQLedxo7fk79JYsCdjrtp0KoShsPA5ePMShBy16u33jOxhSnOv8vq/S3uCR7a7LPioq73O1FUUF6RoZVV//D9vD1gSnXc0hCJYguMpD8nnjPPSV9yR/JwFLinV2Sx/lF7IheaoJC6ykXwePGU+r0RqBf+NYkGcMjMyYal7wfsiZvDz2Kb06CWZXnQI/3pDdmTNpm+eP5EC75p6Q7ZzSX8BZjRjqIWX5i7ysUoSDjpVLcEndYeBips96GnQcB5DUXa/qOJHrd7uxwKBZXzp1IrR3Drh2wKcUN4UjNgjZNXfCvafAKpdu/jNK1EWXyUvSU1iGoQf7YDT38ljXPIUJ+RP5pYK8Kjeq8H1VwZv9nT0mMf/wLNpw5vvL+oFN3Ne3I+oPnQ6cijeega+XPzjds8YAvhr/xmmHDxTGzxUk0Obs+/nwNxH6NnAu8elhnq/g+VZ8fzzP40P4PiJnJ5r9SZBYiWytukFmTLPwjvTv0JV4OR2AhxQjq4AYxnUpaTnVMuDwPrzeZ247a2Z53r3XqkuyeibfudYhY0R6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(478600001)(8676002)(4326008)(7416002)(8936002)(66556008)(54906003)(5660300002)(6486002)(44832011)(66476007)(316002)(2906002)(110136005)(66946007)(86362001)(6666004)(38350700005)(52116002)(6512007)(38100700002)(83380400001)(6506007)(2616005)(41300700001)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk16cC82ODNScHltRWVEekQ4dG5aa0FUZzJmTUZaZTl3Nk5PRUZ1K2NlQ3pr?=
 =?utf-8?B?aG5Xd1hQL1lGWEdnZ09RSXl3Qkh1cm1hcE5OWFB5a3hoSGR1NllhRGlDa1RV?=
 =?utf-8?B?UldIdUpsV2ptV0RDSUJOaklJNUhIYWZ6RGVHWGZZVzRHSnl6c3pFSHkzSmw2?=
 =?utf-8?B?cUR3SDVNWnVwOGFBWDNFbTNVL3NRVEJXc0JUejhhakQvNTluRCsxVHdUSUU2?=
 =?utf-8?B?bXFiSmJoekxSNzB1Z054V1MxdXNlWnRTdzR6Vk85eDlEdDBPTWQ1aWdVR3FG?=
 =?utf-8?B?K1JpOVcrOFdadzExVWlacW9xcXBsMXBsRjIvR2dZM2ZWTW9jMEVhdnArWnRr?=
 =?utf-8?B?S2dEZHdwY0NYOTJRRTRLaCttU09PdFBnOWxRNDVKZTc4Y1lSVUM5b2c4VklN?=
 =?utf-8?B?bnlCemU2ekdlSEFycE5IWnVsaTQwY0dsREoyNmF4T1BWcFgvN2RLQWJTQzE2?=
 =?utf-8?B?RU5rdGV4NVQ0ZTlCM3o4SDJUUzllMUhHSmtkRFl5VmF1ZEI1V2hLVWFmOGwv?=
 =?utf-8?B?cjdNMU1pQWpMeWpNc0F0TE96cDVjZTAyTzlQMFUwbno2ME5xc0NZMGRwN2FH?=
 =?utf-8?B?eWxQeU5MTlppRmJUS0VrZWdxaHQwckJzSlQ5c28yZ3d2dGV5QVFWREFyY0po?=
 =?utf-8?B?akdBbU9ibFAwVTRtSklvUEVFay9HdEdYREVtSUF4MFd4d3RmQWRxY1hsVVVG?=
 =?utf-8?B?Tng1VVd5VlJuNGZlcmh0Tmp1Wnp1R3o0NVJPejdVbXM4QUVLMjFoK0s0V2tC?=
 =?utf-8?B?Mkxpb1lnV29iNlZjRUhwMDRJbkdZUW9KQk5tQWlEV1gvLzBxMmk5VHhQWG9n?=
 =?utf-8?B?RXB5dVN1aFdCZzkzMzVtZzAvSkpjRWVXdmREWmF0QWhxYThOM0FaSHc1K0Ey?=
 =?utf-8?B?T2FQZFV6THE3dmRNYWwwUnc4NzRWNWxWRmNBRDJLdTF0QkQrZWxINWNoNmZz?=
 =?utf-8?B?QnovclVEV25laFM1cDVqMlBsbTV1amVhZmRTV3FVWXl4SmtUWngyNE95L0dE?=
 =?utf-8?B?UUk2SDByLy8rTWZZMUYrOStSSkJWaFRiZFdlVE1KOGxISFBaL0VUcW5mMW9I?=
 =?utf-8?B?Qmh4NkU3NzFidUJDYitaWWVNV2dRVWU1ZWpXUk9xOUFTWGxhNDEzeVRweHpF?=
 =?utf-8?B?RlRiQVcvM1dhYU9oVGVDWUc2dUtYYjBvL1kwMXltb3B2Y0VWTGFhSWVGc29V?=
 =?utf-8?B?LzFGbisyK3dmaFM2YWZ1TnVXRTMrMFpIQlBueFJoeWRYcCs0dVpiSWJOaVQy?=
 =?utf-8?B?b0pDWHVheS9Ib0swRjhwcUNEcktoUEdJZklzK0N6SkdJNFFCMHh3VUVsWlZL?=
 =?utf-8?B?KzZNT0ZqRWloRzFseURQTGswNE55M0lBNEVYelNOWkU1WDlCeDQyWGlNNHFE?=
 =?utf-8?B?eEJrRWdveERrcXNxUThGbk5TSHJQU2dwb3g0WmUvcHhPMU1FdWFHWnQzV0Jl?=
 =?utf-8?B?NFVyWnF5TmYrRUVsR3pudXRManJOUFB1WW9RNFY1VGFGb1gyRjQrM0dYRGxB?=
 =?utf-8?B?YzczWXhGRHNQLzRreGpmYjVqU3pYVHBLY1VDb1BuWXRmTHNMVERpNEtnR0oy?=
 =?utf-8?B?dHRNd2JlNzk2T2g0U2Y4Q2dVS2M3UVFrWk1FdEQxQkEvZWR3Y3pPeXQ2SzA2?=
 =?utf-8?B?ZkVOWW1HMkZNNU9QcXhYVm5XV0FWc2UwSEtOZGJuSHRwQnVzSHN0Tm1wZkdh?=
 =?utf-8?B?a1hkbEVITkdJeWh5Ymkxcy9yRXJaZ3pXcS9YQXJXaG9OOFpPR1hEbUNsTlE3?=
 =?utf-8?B?V0ZDSEpPS1BkdUZ1MlpyYStNVTU4NEYxcVQrbUtDRTFhSGVlQWY0eGdXS0I3?=
 =?utf-8?B?KzZ2OUt1MkVMWXVNT0Z0VEx3WUJITzJrajFKUElDbll3MlZocGYzUUwzdklO?=
 =?utf-8?B?STNEakgxc1VhOFBWWEpDRmppdlY3eGEyWWhLejczZ09WbGNZZ2o1c0RtWkcy?=
 =?utf-8?B?UldpNllBQnJRU0t5YzNpK3JRSlBEUExtUmFoQ3lrVXVMbmtDbTNBbUN5QjE3?=
 =?utf-8?B?TDAvN1FTZHFGdmZSajdXWEU0aWdaWFZNY3pDWGNUWDFzQU1tTVRKWVI4Zk1F?=
 =?utf-8?B?NzNkQmdKQklodXZWQWVXbVVjcnVvN2V6S01qdTlMNzRKeGcwTXZScVJvT0pp?=
 =?utf-8?B?eDhPTEdzZW43b2RCeFNjMjQwRzhlS0ZJMXFZTk5ObzJHSlUxTEhTWVRya05J?=
 =?utf-8?Q?yHduxOMsTb677ApkMEtDOfs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb270f3-4e58-4a2d-3af1-08dc1e9439af
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:28:35.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F+Id2AURCQke3YY6C8vaNSt1m/OfO8inVXITehemhIK2ekpJun3/MKslgDfLt5TgetdfA/KN7Y/P+3Qzt3btlzvNPamfhDQ+gQzfjgcnyhxo9JT7w5sZTOv/YqI+GIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

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
 drivers/tty/serial/serial_core.c    | 7 +++++++
 include/linux/serial_core.h         | 1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index b56ed8c376b2..8067d20c5275 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3663,6 +3663,13 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (port->rs485_rx_during_tx_gpio)
 		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
 
+	port->rs485_re_gpio = devm_gpiod_get_optional(dev, "rs485-rx-enable", GPIOD_OUT_HIGH);
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


