Return-Path: <linux-kernel+bounces-123250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A6890524
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA01F27B28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CDE135A67;
	Thu, 28 Mar 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="iDWfN7gX"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2112.outbound.protection.outlook.com [40.107.14.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C842131E4B;
	Thu, 28 Mar 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643139; cv=fail; b=KPROXA6L7oLKB3fLiPdplvcVFKNMaAeTSGNY7OocGhiwzZ7vkW3NrU20XWI//XQlg2LBp4ULtmkswxVpgRYGGtvnvHI4akotGTv1h7iUb33+msdEp1JYyYbXau471KFuoqci42x1EOkH9FrUoKjZvn/pEeDc+/B+blelvjMJVY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643139; c=relaxed/simple;
	bh=V4DZHkcARNC7fc2daZ1OECCct358ildSRykedHXTgNU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CTjmDdadwTzZX4CjUJrRtlcLadrb8AwbHVeicKYTapWC8OAGx6mQVJA54Rz/2GKyO3E4dwtjLbD9rRCXmXtrIusLGIFOgxUtfTuGJq+Z8Ufi5xP9SeWxltKjjmwHvtoYfT+yqkBdAeYEd+D6TcdhlwLTbUqb0/gEKHicisxcEts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=iDWfN7gX; arc=fail smtp.client-ip=40.107.14.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaK6cfEogjOcNj02EkcRL8nz+tyBeNpF/+lHW7bL80SkH+SeU7WvhlsLQpP5xSyxGTwIrGIEbz6Oy7+suJZa2+1wUSEY9RHMeHw/n3vJ3Af18wzw4vHOxv2X1a4E71zRFnhT4AfxSrDlCg+BVQUUsf5trXmqRBLuKse7H09QwXTIP1dAkkCNBi32wVVGH5HkAY/D5XMw0bbwStccB8VC9DqkN4Yq4jubK4eBW8wx49qrV7GE0t8BZNsijAOcjkoHBWAc7TjDtTPjbVBH2MFKTQBHsbdl902vdqUY2dLT2r5p8JQEjvllckozLHfV8juAj729Ac6d5/ayo8z+8/D+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6IxgU3KTNIxgzSKuZaYIlNmkj61o383/aiDnWetpD8=;
 b=fdMtIxi5YIS0ybWoN8QrOW0ApMMpOSHr4DQKYKt91AjCXLdlPLYmtLrtj0HhZFyD0tZl/RHL5gm3yEOLJUu0BzEqPKnDssBeiH7Ah0cdeSupFYGwfvfucHyNvTZB2mv11ijLfMADcatgfY0kRXWEelbRGnPLHvGPFD0wFrRGwUBG7e4yCY0XaE4amwCBiKZ3P2aKEoZGvI0igFhvwoKNpSfqtQYYd1OqHnfeTR8KP3yApib7bkLsVzUNdyt8oxk7jX/KcR5RR9jEy8NkSrlbvdk09BCsY17VclmQnHmZN6FxvV7j9HmRLvCA2xfnr6R/EPuSPoH/2q36Ooia+aZxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6IxgU3KTNIxgzSKuZaYIlNmkj61o383/aiDnWetpD8=;
 b=iDWfN7gXrpyAopoqIRcCxFeefXnuKSxV8JTeSwNBEAbdQSkr8JkL6hNYAfetis0i2hAgGSxgNrd1iU2QhduXv2nWTxllBDymuGv0HrJsaCTpOv9kKnJRXvVqn1TPC9NyTsX8xNH+iPyOV9uFlBA0Uu2p8xkqKl4eTnklbiIDFxA=
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
 16:25:30 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 28 Mar 2024 17:25:22 +0100
Subject: [PATCH RESEND 2/2] usb: typec: tipd: fix event checking for
 tps6598x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-tps6598x_fix_event_handling-v1-2-865842a30009@wolfvision.net>
References: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711643129; l=3228;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=V4DZHkcARNC7fc2daZ1OECCct358ildSRykedHXTgNU=;
 b=EYYZBw9lYkGl66Au7iw5Fo6Ti15BswYI5iZ3asEWwZ3ATXFY1isyOeJxyyVh5RPVU4p8b7cG3
 cQcU1kZkvXlAohfkPEMk4Yvq3Q98c4ABsyhnNnLO4NQ/EywcrgqEDKL
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
X-MS-Office365-Filtering-Correlation-Id: 9f848e5d-4806-45f4-b26d-08dc4f43af18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S8/PqXeag3i877C6DAj0Ez1y3Wq/KRZIfL7+cEBBZQDxDX2Tfh6kLXEmXm9JI/bNNScGfRJj0lTcgUUNEoTZf1qpPsOd8xBvWu7n0DOSBcuJj6MWkGJEczO9e7NY5yd/I4IJrhsZwquZpYj0hRjtI/URZFdCnUbWil1IYfAvpSW8a7HlyM86QrrHKb6Ant2TjsteS5t2DBZoX+ADJyV0D7XknzD6ShHODgA0AlQ05ohiRHWEvIZzqPVA1tzRac6Ul3nrkCEZFArpPPmXaDWRghC/sTmnUY2Q4p7dvqcF5+aaYZCJTjcAP9W4Hy9/7v/v939qR07KFuCeeuPU4Zl6mgf9JF5V6mSzw5v05kKW+15KpWC2uYifMVtAyX7Ui0HWyRPIXAiqeDNmKKfe2GWyD9uUZta3b1vAjyJCMU4mch/APEYaRSRGrYWvWTtDgBVV4yM1us8Uevta72bjGUVXTxR53sqalaOR++TqcMbUnZBuVwrEiTl2Xr3h2QmZMOelGJyRdHqyf8RidlsnotAgeuEZ3vQ1jSwnhF2BkRGIMHCuIH6LdgNEqlIfj6CARyTG/6q0xpNBvEHxl9Lt8Xh/2107kvfvbaq7VSmtbKIirkXy1T6z59l8y+pJ2TmLVytr4W08XZxlO68pE+kafroqVBiHRhbyAaNV7UpZGVSXoAzsiJ+vZHmtZMzK6jBHq3eLaT+0eOCU7G1JScgQ7OnKeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFaSHZXMlM4ZXNIVmxtN2tDTFhDNFQvV2w0K253R0lhbERaMjVrQzBBb0V6?=
 =?utf-8?B?V3lUQ1lkZG5hTnd2aHY1YUk4WWlQbjQwUFM5VjJlZlNCUVhGdkZMcEFyc1FU?=
 =?utf-8?B?UkE3b1lMdTZuTm1HV3FOZXpMWXYxa3I0U2R3L0NGNTZkYjdFOWRadkhmdHVG?=
 =?utf-8?B?NEl0SURDMGU2STNmMlhvSThtOS9PUFJ4NTlRZXJIWHUxVnAybEdZRHBvQmdz?=
 =?utf-8?B?QWkxc2xoK1Fhb0owVGZnYjJjUFp5NnpQcHZkb0UwR2c4MHVDNHZMc1dpbGhV?=
 =?utf-8?B?d2RQa2dHMy9UeFg2ZENkWGhMTVF3OTZkOGVUMGx6WktyaXFzeDFWeElSYWts?=
 =?utf-8?B?YTBOcEdKYzBOYUlQNDFVeXlRSS9TN2ZHU3d3WTRGYlVHUlE2R0pXbmIxcEVH?=
 =?utf-8?B?OEx1U1Yzdm8yZmUxbUIrakdleEUrMWxDUFB0Zmp2VFoxN280bkd6QUhFT2lT?=
 =?utf-8?B?cVM0RS9FQ091S3l4dnlKL2ZheXgyTktTcFFuTUhYL3lRaCt1MFVOUjQwOC8r?=
 =?utf-8?B?K2hPZ0ZDOVgxTmQyQnhrRXdiZGZaOFZ4NnVGMlRYOW9zVlNHcUtCcjJwOGZX?=
 =?utf-8?B?STAzcUFFa1d0dm9UaFZCWjNEOEcvQmZramgxeGl6emNKUFZ4MjVEL0J2ZTZG?=
 =?utf-8?B?MVByUkZPUGJZZzdlcll3d0YzZi9wUXNPamRJR1FqMzVYbUdXcmc0Mm5WdWVj?=
 =?utf-8?B?VnBsOCtybzVpRHFONExxQzFBTXQyNGFsRFBlZEtFYnVoMFo3dDhZUU5McmdB?=
 =?utf-8?B?LzdobHRGc0VJQVJsb1NxUWM5SFlDcElxcXFCbEErVW0yN2V1Yk90SGdVdFFv?=
 =?utf-8?B?K0VZZm1XV1NkTHV1ZExnQ1lPZzRJTUhFTkd2dFBFZUh0VU8yVDBQUm1yaVRD?=
 =?utf-8?B?UHJwdmVCcmpGQ1pSaDFQUkwvSzFVL3BWS2Rib3I2aHZvekRkdStkcFByM0Q4?=
 =?utf-8?B?KzI5VG04UURrQlVmQVpnQTFxc3lQT0EwYytIQnNxS3BzOHB3ellLV1FVRjZq?=
 =?utf-8?B?OFFzV3d3SmFFV0dRYWdBQS8rQ1QvTXpMUWorZTM1L3JvNE40dlh5cVVhMjFS?=
 =?utf-8?B?TjgyRzBwUkRHRHo3RE5yNTJxMFFJeVhuOGFqQXhCRmRrNXoyNmZuU2JCMXRz?=
 =?utf-8?B?aFdFaWlRU29iZmk1cVV0a2c5YUJXRjZqS1RJK0FMM3d4MFF3Vm5nYWlkd3Av?=
 =?utf-8?B?ME4yUWU2NWhHQytiOFVQbnZjYm1CVlVITTlrNHExcG9WcW5TQ3NxUXZnNGpr?=
 =?utf-8?B?Z3hTK2o1RHk3aFhJS1lkOWJ6eHdTb0I4N2dJby9BaTRHdVBmRXZZME1CMGFm?=
 =?utf-8?B?VHRRNGRlY1M1bVk4N3NuZjN6NFduaXRpSXNzUzgweXJiN3F3WnI5dUhVU0d6?=
 =?utf-8?B?RGdJdzIwTWRoOHI5YS93bWlKeGdtUjRTZUh2bkQ5S0dla25mbmdTdWVneG1J?=
 =?utf-8?B?L2xJRTRvalNRcmFBN0pieEhqbXowbzhLdFgvOVgwNkVqRTFWK3hsS2lXNjZO?=
 =?utf-8?B?YnBPWjVteTJwY01DUWFJOFh4SEpKRUtBdnhqR2p1OEc4Tm93ZDJXcG9UeG5n?=
 =?utf-8?B?RUVaMW0vN2FTZ0FGVXQrWERqWTUxTG5DV1RaZDlwOVRiVWhXeUdQYVlJcUtP?=
 =?utf-8?B?Sk8yQjRrbmx5YnIrZng0Nzd0Y2x5QUExK0RCVVMwSlZGWFZHQ2MzQkY0WWky?=
 =?utf-8?B?NkZ6a0xSNUtKZ0xFeG12ZjhsVVZ5eFhIZHBlRTMwNGp3ZUJNNllLV2owZnhh?=
 =?utf-8?B?RVNvcGNkUHlzbnNZVE9VRHlzTjNRK1JtK3RBR2E5bGhuS3BWbXJiRlFDNDkz?=
 =?utf-8?B?QmI1S096RGpLZFNIMEM2Ri8vREtRZGltRHZlMUdJaFNDNmFKM3hBMzRSN1I0?=
 =?utf-8?B?OTRVYnhrRlhhTHJ5YTBGNHRnN1VuUTBOY2hXOHludmovczdUaUtxaGlZZDB2?=
 =?utf-8?B?M2VxUE1KNGJHZmE5UkNVOG1lTnYrUW5ydDNLYVFqVU9FeFFPQmduQkpvM0c1?=
 =?utf-8?B?am5GRklKVkluS0M0ZWNmSmdvS25INmVwN3NJVURMNU5ySDBjOXc0WkdWZmRk?=
 =?utf-8?B?aENrMlBONGdZaXFSR0Y2SzlFWURWeVYwaXFtblZwUkROK3BTMldzM3lndkpw?=
 =?utf-8?B?ZEpWVTI4SUI2VTFqSS9lMkN1VTg1RStYQlRoWE1NcnpOR1RMSjZObGZCaGJw?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f848e5d-4806-45f4-b26d-08dc4f43af18
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:25:29.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZF19nSLcxGp8eV0hRx5BxB9oN+wQVJTsRVX8BqWazTGvfVh2vIUFKNOBL4loi2jBj6vUPKXxuf/HGlOEMDZnLScdLqY4b/0jLyESfpqxIcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10358

The current interrupt service routine of the tps6598x only reads the
first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
that any event above that range will be ignored, leaving interrupts
unattended. Moreover, those events will not be cleared, and the device
will keep the interrupt enabled.

This issue has been observed while attempting to load patches, and the
'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.

Read the complete INT_EVENT registers to handle all interrupts generated
by the device in a similar fashion to what is already done for the
tps25750.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7c2f01344860..308748d6cae6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -637,48 +637,53 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event1[2] = { };
+	u64 event2[2] = { };
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
 	if (ret) {
-		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, 11);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
+		goto err_unlock;
+	}
+	trace_tps6598x_irq(event1[0], event2[0]);
 
-	if (!(event1 | event2))
+	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, 11);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, 11);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event1[0] | event1[1] | event2[0] | event2[1])
 		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 

-- 
2.40.1


