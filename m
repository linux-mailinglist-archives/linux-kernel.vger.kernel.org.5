Return-Path: <linux-kernel+bounces-106456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15287EEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0701C22127
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB55647D;
	Mon, 18 Mar 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="L/vixNec"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2042.outbound.protection.outlook.com [40.92.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3673555784;
	Mon, 18 Mar 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783163; cv=fail; b=tx/DMPIt+kHKFj5ZUlFcSoGIhSu7V/J2FkEhxjvSfrWijfTKibOHBE+jHKCrwR6o2RHkhW9UT8caNgt0DRw0ySVD07qDDwQ9a7te6Pwgmkt3DdWax957gSHQp1Gg0I7InMIAGlmxRPsCvIYRE4PKP1W5eG+iEz/1qSHGUzTL+r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783163; c=relaxed/simple;
	bh=KGpu6XTESecw4acs1KGy93NGZNiEm/cWrqr/MsHfZl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpJrzsgcLcE7mv/9KqT6pnx1ki0zmbXt18KWCrkmEyX/9S9Ng5FB1LwWw4HFoNiAykC6TEl8uBzDHerKWRgW78CoNTyq2qLZ2TZpUwP/aEK/KHprz65BnIRH8ZIvdRD1ZXNGH3o5dikDroytYPKcGnLCvQVXnDO95Xyv8pRJeiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=L/vixNec; arc=fail smtp.client-ip=40.92.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmUEbvYIuPOyX40uYHTLrBbl4okhfUcz0Po7n1z5obRHWoCuwoAkZvL/SO2SyUyqtpS1mg1CjAYgTtF/7cq4LqDhuQoJs869M0/d0M9UuxHGTYCHIrL1YNkxWV6qzBYtk6ajGzOK/u+EQ/NQIdSewnn/wHHvOTUCHrupGi4EtywfiFXgV3/TbTxQk5DQBxIQa5Jr7XEN/E5RfWmUsX+1SyjDUxBIT9y31fkNiGmudEzJX7icyYgGAQS1KT5lMo/v5e0pBuzl1ro5t4cnQDVD4r4Wkvk1PDOkQxDYLz4/wj9hpZOKi3bN/St9Oh22mtRGtUEH12wm3GX23YTQ9qVZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=R/eKK38N6zzI1d610PFU7MbAzkDM/MQ5QqxaivLsqoVFyPFkVsSjntvfboqAAfIg5ge/v0yiiXoI2mbY0aJbxAEeuAzk1EvmAuXqIACrOykc2kCvDemqZyk5emeFabpzj4dveK04nIejN3pEZGFsP0pYSNUmwyaqK62Mc+5bTHIsRdkCHqRhd8hH+eU2AOwIJk4D111C8wZlMOIVhzKDHjZ7F3AtoiR8R84z1q8GDK4D/lR5LufdmBAWU2Jq0Vwqa8nx8213sWxn34HzHTiuKg5tcWWeVjvtGpuVctjIwwvHWD3qvcHPlPXcaRcKo5UVOz4mavsKI+e/kMEF83Yr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=L/vixNecIDGEeZU8g4h7SRrRz+MoZNzKx46QN88NZzW1iblpYqwW8hNn41qVWpiXRzSO+RoKVO4R5UP/QMTuz5K04QD9jE2OR3ojAD5C8simZVvRXoZXdsUK3Jj04uubd+5tKrSkyN63GMh/yDitHTiZSa/SaghQb//wiZKo7HAFyVjsrVVmaIIMUTOvgT/CYFShyc+6SiXsVRAb+IQk9Dd0+UIbF95a9dwB0xb4WvwW60kfQdx0XsUiPxVJG/3gxTIAH28QnnbtBkoKLmtV5zQyEEVn0qpYjUNcB0DdEwClWz+TwIxWKpFW6fweAfDiuz2wDdkqx0PX4aNlj5iTlg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ0P220MB0785.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:408::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 17:32:40 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:32:39 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 2/5] ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
Date: Mon, 18 Mar 2024 13:32:10 -0400
Message-ID:
 <LV3P220MB1202DAC9F2BD1B46BAB89EC5A02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318173213.28475-1-lnimi@hotmail.com>
References: <20240318173213.28475-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [I8lL7JDOdxbgfOPRDUDnZEjCA4iYvVQP]
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240318173213.28475-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ0P220MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c08f35-74cf-401c-91b5-08dc477168d9
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9wYTvfIwcniUcOEk7m2BTCc/2soZMML5seGwi/ef2jHXJNzOplKBJJaSTrmxPESvI1EoV+/U8i7+xFYz5F8LT/p1ai80cts3hXDP74R6TIracBhvxDIiWArtC/3606+lV62cUMU6iCDN2SCCjmnqEhYpBe2+lcjwFHQ6EBCzFmntFvQ8kqa4lPiRfmzO/zOg6c8MLQR/sMiytZj905djqqgAa2CnE4986z4r/+DyiDaeBKb8Ro3hj0CUmcABr8qAcHTDSlfgHZ2+8CRyn6D6fA1IsWNMPLVwiY0UtbmYCb7t+7vVbKT+KKkivCY7h3BUSr2SRavvU5aBloaBunZaoWQhh8o+BFSS9YIooEUnQ4V3VvsChLk5nGV3IZcvt0em+wQKOht9lc2LSaOJL6yfya7oNH7dtBFBRbDYtbBSgpGjCkerRrTFHepNWM+iqpZwcUNqVubvHBdzLwOE3ox41Y7iypyrF8jtZet7BaYdT0TF6940hBBPNS7Ch7fIYbq8VlNeEOauE+zOyeOgfkEO/XZv/XePiEiRdoB3AhXiJ6d37wtEWQLv3JABwSq8d4VHy+4ve7cAovbz/xa6Khe+Fc21r7ZmWlNNVZfYX6p+BLStU02coKpDuaun5AYhAePMsYmKuF3iRNE+tt0tQOSuz+4uNsBP/qaKohTQV6O+98CL+FiCLwvq/wnQAWz2Us73WhMkGecLlcbbf3ZxIIMNp9NQYaKPDv166wZXG0NPJxsb+6psLfasviIBqqWOzKeU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eBKWUlP1HOSkv8ZqDd9AlpiQXg4ZdtE47KrKKyxFqgZwo1nN8cLEOapOfeTSGJW8waerPsJX69/5uEd0Fc1c8qJw7CaC+eSzP49+/keNMN4FoKrSnLt3q55aDS9S22KtPMPiSoFbz39aXjnJhr0Rqtr/fyRolDZMuZKTtKHwgH0qomWNB0pvlwPO4hJX3CYaqNaAzIku0IBIJ6n0MDfu053KWL9jHO45EnTOjjRaYzVeYG1s6ft+8r+iKAstLpMnUIEtIpLjgKrdm1YIENnJ9GClFQYhIp5dpoDKRyaRp6THFIGrlJCSMRLQRJbxlBLbFq+zGetaJzOSO9PN2Vkt8xHykpgMw0hNjATPwzYQ1pwgpkrVE9I3pT63qqy4zHM7p/QD2n4bWCub96yLGPbUcUDdzg6ra3ZS02QWb2y9Evlqwn/zwTX4csKvm2KSyjydXGtQJ+73oIi41fwYsVGDzPZaT0jbbkSw7ITWEiW51DPaL/VxLJlDw/4XKZ+avkSfyFS9ueX7YMZc1I2LSA59Nq9ORpBkSH955nThF6ZKHUJuLw9N3H7URVj3jQ8zd5Py
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?unwKzV3URCSLczfwkNX58i4Te+MHQKIwIJ31rklRAuv6cjvKX08GMMS5Ls9J?=
 =?us-ascii?Q?jXcX5bi3fMAseMgCNJUHuNz4crF88drJr/ERONKwU1eMQOHTzG9SN+anJvUO?=
 =?us-ascii?Q?WNc7PJUeFK9C2o1BDFFjFIHoyS/qLrkAMMtm22R/5dVzMY7ifihk4yOs1mKc?=
 =?us-ascii?Q?2GwfiaZ0hufXf6w1xVKTJefMKS/f/Tc2hBzQ9sR6tGXhg1mfzwB1j5WzcDyC?=
 =?us-ascii?Q?eH37msopGNgyr+SKjMQBcsgdI5NbeQ/X9zYnx7sJJNv8YQvRGZDDdkYMOhyX?=
 =?us-ascii?Q?RRDLru4bcj8Mj8x074XwxaGdNxaIM1z+QnWR9JFnGcS0MvuKwi1if0sdZWIV?=
 =?us-ascii?Q?WiMosRbZsvaBTWCaJFE9UTip5rrmowJCvtUp6H91CIK1KfZuvTlYujFhgXnV?=
 =?us-ascii?Q?TT0/2jXleir3AkedMJERLKBlhIBGFW+yFt1i/j9ZOMBFI73BXXR2RH70Xbfk?=
 =?us-ascii?Q?dgMNbZf1tRjcEwqB7WUJIylvSk7gvnDxBBE5tWopl5mCI5oMV3/R/+llJK9R?=
 =?us-ascii?Q?Y0p3pBihynrzOAreovl0pimmpYjfxl+26nl4hUSN/DLTXcspVkOcUtbIjVq8?=
 =?us-ascii?Q?x0CnzakDdjaSYPqULiHycDZV248IYLU9at91FXz60FDf9+sMig5p6Q1L4rRR?=
 =?us-ascii?Q?Jh30ZfSKa9J5E4qd5+fNy1WhDg+s0Y6VeXVJo7xDKHYKI5LHVlpzI96qHvUb?=
 =?us-ascii?Q?6Z3UTzKzqVB/AN/DY8uVhfAzED3atPeX86mQff47mKBLKu2D17AbasMkyQtY?=
 =?us-ascii?Q?BdV4Pfisoa6sxsd1fUDujIHbeAmVG7YFM1sESWb0fZqF2JH4cj8XMbUtl54G?=
 =?us-ascii?Q?eJB5WWqoVQXDqJ9vwcTbHFJ3qaVsA3oGVrxDhdT72MkPzwspXdQX6SvubvtX?=
 =?us-ascii?Q?Fl9/ksZDSHDRYAc5uNLFspJe+YO5OcdWTHUSvVGMepBf2qoC199VXhIyTJ7F?=
 =?us-ascii?Q?e7qY/Tmvs5MUp50NXwUF6vQUF2GUexVRmMF+c7j9D0SGDPttW7fR5hlo6fiw?=
 =?us-ascii?Q?+6BwCm7HWZ93q9wI+ci6FnoceWKgjG9UoEha4kzOA4QzFbxbRMIdKw/mPwjf?=
 =?us-ascii?Q?pHfAdTq1h5x2o+U1Ujk7cMgU46LXZxkjYPYtFzNGfdFC/0VRfAbULZWr6mYf?=
 =?us-ascii?Q?sfsRfHf6jhBXPAho9pENUTzSqL9CHI2W9R88MiT+iGMAvt5JdKYRURBsDJzs?=
 =?us-ascii?Q?wcVJiECQbKlydoqklh+LNdKgETddjCbsB8dKmwhVyu609X7WWnZl6NrtATY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c08f35-74cf-401c-91b5-08dc477168d9
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:32:39.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0785

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


