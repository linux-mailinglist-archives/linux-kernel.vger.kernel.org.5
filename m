Return-Path: <linux-kernel+bounces-103513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5DD87C073
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78631F2353C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174D7351E;
	Thu, 14 Mar 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Nolyqij3"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2103.outbound.protection.outlook.com [40.92.47.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324B73161;
	Thu, 14 Mar 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430647; cv=fail; b=Mx5dn+n0izO8JHg6FaAJwyCIM8Qk7PJpdyCuxHey8/0Y0RjMITWzu3Rr8J7Jqq3pyrNDq9eopbnAieJj/GEy9IDi5zHC7NAskSa/pmvJ+euIwMV+ojqIxc5L4pfhc1keGWc94c7krwQL44JqHfHyhKd5d+0f73fmYEFfp63tkBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430647; c=relaxed/simple;
	bh=KGpu6XTESecw4acs1KGy93NGZNiEm/cWrqr/MsHfZl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ocqk1RkAET0PBxHmQTNNrD8z9vJiS6O+DaZ++CX8xsIoBlAVH6fbFhbJ/HuWgJuqUwSf4xU6CYP/tujQqcZVz6sCIyTfYDnSTXNLxP2Va9JpIy7dfi69IOjjBJdGv4syE487BSPv5oYdJD52olnJyrvdV4HtQzVnPB7UvgE6Enk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Nolyqij3; arc=fail smtp.client-ip=40.92.47.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq/iFpu9M3+u/KFlXsr6T5uHbDtpkklMoM7A/HNn/gp7cuXbROJ3kgSQ42LQPKBikDILsYHgo2r+6XS8gzgPmvH3V2iK7oUptw6fIKbXgh6HDFsuoL23RA3Swg4lVd00Oe3gRGY99diwmwgkPaV2l92HsR+bC2AbJP8eTHK0x1T1MJTVexHHDcxWDmyON5+woHQFtRzQ+pdIlyiQ6e5GjA3VjHbK6brVXcNd21MGXtmodLhIq//Hghs6HlXB8reAiU857ochFjuKu+5qFg+diEfrrAmsXuovTFvTnjbaR+wpfnyEUOqltvlWJIPzdVuTv8Lfoc7NlCc/wjX/7W/Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=Wt50euCOOWfOuBtSMB70NnZ4blp22HUpb6QV4cp2Tn04DaSsZ2dxZSkVrJXJT+/i9twHewhXP2BEHyZWFjnIRc1Kukkb8duqA9w/WkolaghTDzxexQslZRJzHGujDbluABLmife/LVw3cIpr25McMaTir3qG+Ktq0ETVozWYBOOPf2P4/Q2fnfC8mMQXOudMac2upd86NLGYL32q3fPYKUM29pwXv/7OQNmbGfsW2NWUXD7zaIL1ocxVv4MBgfEIBbb3djYFOpvGieQ8d/ffpUEQpn5tpMM2xovYgaFBt5lLP7xw2zEeERwvJ1O3PhW4Srw3uvhhizw8xfv9y/jLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=Nolyqij3fv3G0RMmLfZhBrAmVlx5sct3YDnfiJ5V9rmsRkPEG+SqGCVm2KITlvg6cBb+ukaul9q39KqWvFlCwjXVvSrVk6OGPi53fVOxv/stfLg0Oqcz9LdBr8VIE5DYCt8C/VfhKt4sDlAcxiln7VaP3CmJdMHLa+NJg2pmsNhHdPD3AAQR7RYMWkyuguqaoOiH88xTS7fQ4gaeKpo/dL6Zy84ellkCvudMGdwpi0zF2cILkvUEZdXf5rzHGIZZnDhJURz+MBiElI8hbdUGSAriOLMrdmRqg6P7kGUiGSKBy1gkX6UCrw2sAZVpenG51EXgQRABVcsEF2umb8RHLg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by PH7P220MB1063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 15:37:22 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 15:37:22 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 2/5] ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
Date: Thu, 14 Mar 2024 11:37:04 -0400
Message-ID:
 <LV3P220MB1202878508CD42D5E8CAA565A0292@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314153707.31551-1-lnimi@hotmail.com>
References: <20240314153707.31551-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZATv621bfdZ6bff+sBwAroxHwN5hCYN8]
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240314153707.31551-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|PH7P220MB1063:EE_
X-MS-Office365-Filtering-Correlation-Id: cd011521-e712-4c1f-00e3-08dc443ca441
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4lceALnJy6GNIba0D/Fv6Tbfg1YyjOIjyWQHRfvU4ewxaLLoaQu6xj79+x+XamDWT8UkKIt0VTglfIvguCp636PgqPTcdl3saV+n03wXPDMXL+wEZ78QtIIvQmBqyz7DPaPVzy7Du+thU7dDaNIlToSIavoa19qC9z0VyBuc8/BXNv9cbu6LTbZg89T0UQQmKxGwBfpZ5nwis+q4CC+USaN43iZpJ3xB17mU62BnxO6QtRITLCu0rtdVi3vhDItZngtn2oJbWnhV35aNjCch9CMwWZnNrrGGol1A49nl9p8tS8Cu1n3lU+WE9WEiaZ+Jxvdp+FI/iye3YJGw13oxXUqId2ozk9y6AYI9G+TPbefP40Z7aYXPaXn5fovr3CMQtVjTXa3ubrTF0SheTvOwdE8vEKvf2sC5n2+s/raba57D/uKY1ubyDuRgR3vupeN5KteUYEfXtpaTB9G/t9IAckKrhN4FhNi+0cBjpOTmssrhV7PEXugZ9wStzvJLR6Ks+njjkv8SFgXXo48hrRbbfzv3Tm5xI2GMYI7exnSm03SpUFD0ddxJ1EcNwGg7SQJM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyJm+mfLdGC/jIjA6aLyYqjpUkD7aK7s0EqotVjp5QCS7rmmaFdQn+LErIfT?=
 =?us-ascii?Q?hNmCJll6FeUtk5SifbUqLndS1TGwwh5rNOo4ypgSQmKBJ6tAWWr7SuMf1eKO?=
 =?us-ascii?Q?Jr5QWYYRysVyT5v4eyXIZ4XN++mI1k8GJUCPq+cewSEyaPpHBe2QfWaC4+lU?=
 =?us-ascii?Q?Ieax4tAeTKp+MdpTzyhmpyTom+rs95WSf5wtBJjygDWLxLzxLh5nDAfVG0QJ?=
 =?us-ascii?Q?oHquf8vxFge4C2SDBvlAMONztdyveaHPYHyxEGHbz0Q1Xdup6lE3F02tc0IX?=
 =?us-ascii?Q?bIl4/T9sTsG7hJvOYe/LZRdc8fg61VZdRM8OV9hWVG26iQptZ2p3ocGSmpCZ?=
 =?us-ascii?Q?Xd/dwS8sSntQdBawyhco/lDDU9pIQjzwoxAvP4ZYt3nH1I+tRyIoS+XJAO/E?=
 =?us-ascii?Q?qJajBsCoLQlBaggJywYcYIqQp3BRpsOCxXSeMMbMygtGuLkCqB1awVTKRDr4?=
 =?us-ascii?Q?IExlZXuIoMFwDVsf103JttFu/cYRh8FbepoHlg5tXQ9DyCghUdALrslIt9Qk?=
 =?us-ascii?Q?aaq1Q+No87C0xqsfX+U9E2FvNdN+OPNdv97oHzvodL2/joxNarnOhBPOKGQb?=
 =?us-ascii?Q?xPv0p9csJn6pkGv9tDBktCV8amCVBVCjNO2f0gauMOuui1rpOKcEjHNkkncn?=
 =?us-ascii?Q?dZE/9fhd85Y47ZD+F0CBiSxXyeLYmRyFkDenX5hsgajIuS0fpTPp+MdXBym+?=
 =?us-ascii?Q?KcArEarjTEOtvYEf7XwX8aep6fsW90P+DiBF22zBvUwrpJMOekXYIDSBvi0h?=
 =?us-ascii?Q?uO8+tuGJZHP+GQzGbLYpP0RzEXKJt4hMbUYSQkN+xyLrULkoXsT08zu62DQs?=
 =?us-ascii?Q?Jh9VzghWGL6Hqrd/WJoSvPnnP7iGAw9jVK2pP/XtZfu6TutsNrA/8PqyqZkD?=
 =?us-ascii?Q?LkoHHos9o1WVq0jEKY3NZ8MJ7tR8M8Qu1oyzxjSRxA02dXAG+e9JXYQSMcSM?=
 =?us-ascii?Q?ePlQSYtfr1sCgahDBpyQUWTPXZNzLg7smD06evQYamOwRXGKoHN0djLFeLIR?=
 =?us-ascii?Q?0oGy4Py+VIKIxHFk4ZPquoDEk2p7E3oIwv1eR/9PfPsNz75FGtAY3agdf4mA?=
 =?us-ascii?Q?tgKFQ9rEQt92jdEZozzfx0qpa4O0pd55bvFL2kTonXNvCHjAXKjilOygQFDZ?=
 =?us-ascii?Q?VozW6zRfxM6jSLr0E8g1ayiZIxufcZAX4MHY9ao8YJfn45c7fYw5yDHBZvaw?=
 =?us-ascii?Q?h4d+7u9zwd5hdMlwSQClm4OC1cWeyCHRZ9zaj7iJPIE1m1kt8QBZXDQHblc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cd011521-e712-4c1f-00e3-08dc443ca441
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 15:37:22.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1063

From: Min Li <min.li.xe@renesas.com>

In order for phase pull-in to work, write phase timer shall be 0
when not in write phase mode. Also Fix u8 -> u16, DPLL_WF_TIMER
and DPLL_WP_TIMER are 2-byte registers

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f8556627befa..d069b6e451ef 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1396,6 +1396,20 @@ static int idtcm_set_pll_mode(struct idtcm_channel *channel,
 	struct idtcm *idtcm = channel->idtcm;
 	int err;
 	u8 dpll_mode;
+	u8 buf[2] = {0};
+
+	/* Setup WF/WP timer for phase pull-in to work correctly */
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
+
+	if (mode == PLL_MODE_WRITE_PHASE)
+		buf[0] = 160;
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
 
 	err = idtcm_read(idtcm, channel->dpll_n,
 			 IDTCM_FW_REG(idtcm->fw_ver, V520, DPLL_MODE),
-- 
2.39.2


