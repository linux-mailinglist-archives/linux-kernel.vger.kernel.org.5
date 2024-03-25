Return-Path: <linux-kernel+bounces-116731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668688A2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5291C396E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380E1607BD;
	Mon, 25 Mar 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="IBZNe2Xh"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF216D30B;
	Mon, 25 Mar 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357357; cv=fail; b=TrDz1Y/pgmZCI+BC4RzIcSsmod+IIbrI6xG/xFFG4Ci0hzmBtQFV6OmWMK4f6kKyZRVNaTCQwAVD69XEP5dzo6YPyxTrjpuX4zsT+1FvAzMOt0Z7RF+8uXyMR+5tTff/2/7+S0JBRl64puFAUR530Ym5aZqp38q+pDMg2meQM0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357357; c=relaxed/simple;
	bh=uJWLgdZ0F1usFwrM/9eFnCR4ubKzvobRPZ2obZQ9i0s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=SF+rViFotcLIA+Y9J4alTjwvp0ncvH0UbkIT4ngtjjM2GVH/8x6TvVDpl+yrHTJiZgaKfxCoYJDZpgogZtls77chOuf2mynZ7QDKdvvVh4rYV/PaDoV2QZnhnFnjuYrc1te3aNBRWQJo4SJrC5uaYGDSEkFIG0EzQsA+cVqFLyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=IBZNe2Xh; arc=fail smtp.client-ip=40.107.7.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7lR6LQJeMffUMuPO0C/BD4667V7xaaT0Les0mLQKpK0EYAjB5M8xn9XO2rm8sEKhiAOpD7ZTOrYJGoRuaoo6aFXa7izgTPYIR62AYQKNRKXXjAAEVQC3c/JLlu53Xc3AYYUwsN3KGLrkinFQi+T/8vSl5gbTrIrgMZ9E3XJ2TkhnSigH/+iAh2uYyXUPqXXBZYT1YvRGSadu7qF74AA0l7iDxHmejRneAYKPbrtqG2v/+DsirPScM5qRIa3mDvg8Fm/ZR+85rX2s25JPK6qrlUXGicIxA0eSu+9guMOAXi0u6OGBy/P54ehgkKYjadatRAhHgr1XH3H9Plq2Jyqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDFhHmJ6fTevFO/VvBjyncpIvzciOrcr2xGIS8DRa0M=;
 b=a90g4C4WZY2M++e/SQabBNL5yFeu80Mmi1ub86fwgNf5P5VNiWnZ0y8fKwdfFRqUqX4jftvXTA6WMKNJqh6qdWXKc2NJMgNh9oayx1x9lHv0Nv3oPe8TMfvhXylJOnvTgZmnRmmm640wuA4+eKtOPFRnhwKWtVMEmE+m1pJLr6xaLgxPbdRwE7q8APwBsFYuKXf3y6qo1w1HURdzFWZmLYrrHCNyRFc2ZiGknBglNvbNCoL7OJ3C7/cdInz9cCqTVn7kp36nBgcJrWufIWwH7dr2kVu//G92GrzdNwG/BGo/2uD3lZK5P0uBW3E3ijeQNiFPAoJ/IzxQui2X/v5/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDFhHmJ6fTevFO/VvBjyncpIvzciOrcr2xGIS8DRa0M=;
 b=IBZNe2Xh3VCcq2uqafNkw729VGGSgN1KS1uePQoeLEG3fKcmUjOV960yczkkHqP5rLZF5q7DwYy0iZny5bLxLl/boxMqGRX3I8avysG86FoontRs2J5Nn4oeusJZm1H+31VSw/IpsIk3q5ofI4C4ExJCoWVqBXwbhvZJ3F4WUPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB7848.eurprd08.prod.outlook.com (2603:10a6:150:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:02:27 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:02:27 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] usb: typec: tipd: fix event checking in interrupt
 service routines
Date: Mon, 25 Mar 2024 10:02:20 +0100
Message-Id: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJw9AWYC/x3MWwqAIBBA0a3EfCeUmT22EiGVUw2EhUYI0t4b+
 rxwuAkCesIAfZbA40OBTsdR5hks++Q2FGS5QRZSFZVU4r6Crrs2mpWiwQfdbdjZg9wmmsrWcrF
 aN7MGPlweWf33YXzfDyEW7wltAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711357347; l=1516;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=uJWLgdZ0F1usFwrM/9eFnCR4ubKzvobRPZ2obZQ9i0s=;
 b=rV6c/LzhqGDAiVXQDV+W90yGV7UYAfqNBkSULC7Roa7AmeGMCpNlI38jZn0c2Jl4ojNHzV3Fb
 bVqiRJDydzxBBXqK3doIR/Vq+jXmmbjcQ8qImAg3uy00a4BiaA4EYJz
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VE1PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:803:104::35) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd1c868-1035-41cc-4fe5-08dc4caa4b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3nmL31aFgA6Nnn5vOt+ZEwM1QAs+8alAqL3lt3AWI6bOeAKasnlyJPkPaYy7eAU05+N7XfmKF3DlN0O3IgU2kpgr+JNqIj2WHJI3wVSMgi8GIXxB7KVOA8o/myHxYt2+PP57sfAm4/ji+lxthc89rbbsMDes5a8qJUFHCF7sFK6H+ezN1v9ZEezHiQSxl507avhgujf3AYu4vc6zfMSIrFSWGLroTBO4i3iEwtl1ZNRGmp1AIHz/gGjpkzus0vOYMd96/HfJo4y0eDPv3ddUfctGAoX52nG9rAa6vYrEn1f65lYyN4zBOPNTgZoxlBQ0Wwa6M91E9l4drzfnslXaPN/LyyJWddWX075p8Kxp9qUnJ3YzUudlY4JLPiYLxtoXIihms5vBZZcv+kcfmAff5ydwLD/uK2PSLSgxzqf+4UzdLlEnnUGZCRJHAGr8ksrq1aQjXmD9DhqqyWMxNItwz6Y2X6Th35W0k+MBzxKMRV2AH4m46LA77biZIDRwUst7J1wYtaAhiLCkwyC1Xnek7EcEWj+pEMri+AwfikGfXly+y58uV7zjAjHZSneiPtKLiQ6q8RXsDxEnI02bgZSyUjwnFQ8ecL+/fJDPkJF8CIMzTo5rHXrgTFt0Zkhm00Psb5vYL44Bsl+oiLjS0ZBqLOT2XeTMK/iU55uLK2dUkKuIMT5mPCUx9CfEIaZHcKfadUJ/OjYpMeNIyKf/KPZ9Rw72LTJC2JJoXAldEsE2Xtc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlFsRUNjVzNXckY5MHJHampFdGVoWmFkS2k5SmRkZGdNc09FMWxCemRUeUhl?=
 =?utf-8?B?eFdONjVReGhmSFFhclNsQ2s1TmV4Z1RwbnhRVCswNytGeEtnMjF4UnE3WUpr?=
 =?utf-8?B?ZHREUjFmZjhrVFdkVnlaYUZXblN3M1dLdGFrM3JFVzIxOHk2VlE5emNhZTg5?=
 =?utf-8?B?cUMyeHd3aHdaQU8vMzRmNUE5Rm5lMUluT21Qc05HL3ljWVRKZ3pOajhqODFF?=
 =?utf-8?B?eTlsR1h4WHVRRU5XVEcvNzMrZFd3K1l0b0EzMUZkT1lFcGJuTW1YY1NWczI2?=
 =?utf-8?B?WTkrTnpNaWNJeVl0cm1haTFlTy83Mk90Z2dIcEVMMTEzRndpRzlDREc4Sjgx?=
 =?utf-8?B?dGwvQ1dJQzQ5RmlIcFhncWhmUkhPQkxMVlQ2TjljWS9kT2FNUzIyZlZEbWlP?=
 =?utf-8?B?Qncvc2o4VGMwTHI1cGR1aDYyZCttZ1B0MEtndHNWU0IwTms3V3RGWmNTVDJP?=
 =?utf-8?B?bzdVY2lpdFYweE5jQmkwQkpOaVB0bmVKL3FKS0tQejR5cytWRlRlQnRHVnNP?=
 =?utf-8?B?QW03bzNiUklJcm5UZVltTzc4bi83UU1hNGFpYisxaWl4aGZPSkZTVEIvQXhO?=
 =?utf-8?B?aHc5WmpKa0xXNHFPa2FpQTNQOTdTUmMrZmR6SXJpLzNUMmNFNVJ5UVBnVUR2?=
 =?utf-8?B?a3ZqcmVEdlZhYU10Z25hTWNxY1owdzhFOVV2Y2k4SmJoYUNxT1R3R3VlWGZR?=
 =?utf-8?B?bUNjUE1oeDFOazlqMDNJbjl2VWMwU0Jtdnd3YjhIOFZndzgwODYya2wvNmI5?=
 =?utf-8?B?TS9vYlFkbXZuUHVaSEtzbXdPRC9NZFUyOHVHbWxyMlZYN2RQWm1VcU5sTUdS?=
 =?utf-8?B?Vmk1d3ZvTmVQUU5FVmxEa2dMWVE4L0JaZjBVUHk0d0lzS2dvemNUajRYN0ta?=
 =?utf-8?B?V0JLbVh0U0hwV2J6eFBuSkNwM1N3cUJ3dHh0WGQ4dmtjTHJyZU42bEhoZUV4?=
 =?utf-8?B?cytZNzhFWFkvQktGR3ozOGsvMkxlSzBIcXZZdEVrOHRZeFh2eGRNd2Z2eTlz?=
 =?utf-8?B?THhNV0YzZnFoZHNjSDJiUzJvQVRnMmFqMzhnMVRLa0lVVXcvblFkMU5NM05V?=
 =?utf-8?B?bGw5NWJxMUdOQkpYQTFLWFcvSW91bC8yM1FTQTJ6VzhoSUQ5NWxZejR1ZXFw?=
 =?utf-8?B?RFJVMVU4RHJ3ZDJYamxnRUQ0ZEhCTmJsVUpPcXdvL0RTZlUvU0diWm4xak4y?=
 =?utf-8?B?ei95SHd2OXFPbmhQaUFGUkgrU0QyTFJFRWpIMTJ6dG9DUmUvVCtNQlZ0YitX?=
 =?utf-8?B?QnNvS2J5bmFrcUorUjc5ajRheDFpZGJCMkxuR24wNXdrT1lpRkd3bHhLZXJa?=
 =?utf-8?B?WGVKcWgyczdEZ3VxQVN4SFk0akgyaHVGRHg4RitRcHJ3amdscjFPazV0OFlR?=
 =?utf-8?B?emhmeGFaektlUVhvRGlqdzMwY2VXTnE3ZHZBcWhrY2V3c1g4SXFOT2xWUDZR?=
 =?utf-8?B?VVI5am80d3VhSnhtd3JLSENFY1cveHFGbThrUCthK0ZybWN2TmpFOG5ONTJt?=
 =?utf-8?B?U1FOdElpcW9PdjFlQ0tqSWxScWVwekczT3h6SGZNNUkxKy9uNVQyejhDbjQ5?=
 =?utf-8?B?MHZCVFh1QWIyV2wxQytsTE1lZHl5QVlGUUdKTUN1KzZDcXhjYTQzME9MRUNh?=
 =?utf-8?B?VmFINmpja0VBWGtWekFyNzhOekNDOEd4V3ZPVzhCZzhJT0lPQkNXVm41bVdU?=
 =?utf-8?B?OEQzbU5wZEtBN3ZOeW9YSUd1bTZZQmh6MVdXelhXYjVzY3FpcWpOREt0VGlJ?=
 =?utf-8?B?bTVNQitvSFEzU3VsZlp2WU5wUVNrYVp0cEJnR21MeHZkVit1bCtJQWxsNE9G?=
 =?utf-8?B?cTh5RmZ5ZXc4QjNadTgrbEtHbkE5MU5scEVoVzFXVU92NjVGVHdVb0NjenNJ?=
 =?utf-8?B?cnlMMUY2QlZWd1ZGSGgvTFBJa3R0cjV2cGNzbzgwaHVMcVV4S0libWVaZ05V?=
 =?utf-8?B?cDJCWGI5bmRGTDdJT1B6WmFBSDliR1phSVlmeWVyVloxTFlkYlQyOXJybmtl?=
 =?utf-8?B?eERXNUdtTFlyYlNldVhGQ0JGREw0b1gxSUc1blFzcnVia251aCtKQW5sMGpV?=
 =?utf-8?B?OWY3a1lyVTVMK3pRSU1INFE1YjdOY2VtRWpwYytPU2ovdmZabmk2SjVaY1V3?=
 =?utf-8?B?VjFpeWdRUlJTaUl4L0doQ243VExLVTh2eUJuQzZJMFg2SEdJR3ByMkJrRkdu?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd1c868-1035-41cc-4fe5-08dc4caa4b6f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:02:27.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhTaw3O/v8ZrI2jrlVS1EvcmG7jOoQYt37cNwnsiukOR4x3DFcCBDVYthpHPyVKn8DueA2azROScnvBCw6OYjXUKGaYUkVC3jVIrEqI0AM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7848

The ISRs of the tps25750 and tps6598x do not handle generated events
properly under all circumstances.

The tps6598x ISR does not read all bits of the INT_EVENTX registers,
leaving events signaled with bits above 64 unattended. Moreover, these
events are not cleared, leaving the interrupt enabled.

The tps25750 reads all bits of the INT_EVENT1 register, but the event
checking is not right because the same event is checked in two different
regions of the same register by means of an OR operation.

This series aims to fix both issues by reading all bits of the
INT_EVENTX registers, and limiting the event checking to the region
where the supported events are defined (currently they are limited to
the first 64 bits of the registers, as the are defined as BIT_ULL()).

If the need for events above the first 64 bits of the INT_EVENTX
registers arises, a different mechanism might be required. But for the
current needs, all definitions can be left as they are.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      usb: typec: tipd: fix event checking for tps25750
      usb: typec: tipd: fix event checking for tps6598x

 drivers/usb/typec/tipd/core.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240324-tps6598x_fix_event_handling-73d52cd667b6

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


