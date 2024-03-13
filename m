Return-Path: <linux-kernel+bounces-101121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DA87A2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC41C21330
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D712E54;
	Wed, 13 Mar 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GmNF8iqq"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2019.outbound.protection.outlook.com [40.92.107.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110AC122;
	Wed, 13 Mar 2024 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710307867; cv=fail; b=bCGS29Zq3ZKedxgdvbeGGuRsmYjFkkRMm56onHa2fLt/ykmz3k5XYNHDIqZ1PExnM9jwc2ufiMOHzxcszI4X+pHa+wWzn8aYM+xRt6mes1ceQoS2u6FKbqwSiKaDQDb+AyLaFryvxLjKZBwbV0wHujZiBM4EEiBNWxwuEMtNsB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710307867; c=relaxed/simple;
	bh=sfzTcWKT+IVG0bQbG8cdE51BLAJGmmw8QImpAwDr1wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gaae8Wt07YBQ9+a/qqUhVFJLCm/VXh7pD7xgYf3oiVZXry8wFmrYbIscItxFSkU9Hr4kcI0c0nf6xLdmvlEvZntb/hBwm+ut+R/izBP1bdwi1QTVIj4I2IeKxNA0S5a29G25nAQtdybRyxnNg4GydrMGjdi7doQQUdRIQhRHY1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GmNF8iqq; arc=fail smtp.client-ip=40.92.107.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muAaNwLORX7fJ+Ig1DsuYO7blGz6HZO79OhrPEZsnOsFStgoNBCo+/vH9QJtb54umTHOyL/PerlhE2ON5Um7V2yljheKQIBVMjqhCiPLs/AcLZtT3cdQVWzM3BpLyXJBuzSYjF58NRQi1owkHYosMiVJvCrso8WGnHWH3r8s5mWETuA++vmZ/vyxnqLvAd0hnifaAt+lnPfqzSTTHzmivq7xE4htBNROtNRlwcmA6K5KTfWBN9ar63HNxipGTLsqpnFq76iu1MaKSzPCSyY2qhfk0qEs9PK8tdwu9kikkIq307w38aG3r+T+JAM5gtd6C7wTYuG5W+C6y0BcVxbqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMI7xVKU4uDUE42Kzzfj+N4wy0Shf9QGDbMALqTDRcw=;
 b=SavSeSp0UexO5Al53v0VlaFQ38DRdGeyk1mc2sLiUmWRVB5CF2cWTCBi9RJBPHIeR6gibXdXGhCdYZ4sfLcObM9m8S0luy7DNw6ujU5xfp0SHLw+juyuirHD3TemPUbslg5cura3wlmOeOXgkgLhdc42+eJkobL+NGkpvpPrlx5bbe2Oi19aaHpu5LBoTIiYTb4ZUeFsX3xv1iLzy/QqQ8BAzSowlKe8OGYmrSZWLft9NDQ9PzZygoYS56Z/3XGMPBt64gTlyg86bKNdZYDTMj32Uo8tPKEgU2yReHwiDdzUtx10g46CxaBv07eq9JJJp1JD74l9nQ863lt07Ow2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMI7xVKU4uDUE42Kzzfj+N4wy0Shf9QGDbMALqTDRcw=;
 b=GmNF8iqqYTQsj4+uSc2g4p4/UU3wPwQRj94/C7Yd2mbqP6dqzUsgzjCk6RSp7CgOH7ddo2BbaF/tVQFYd+XUYRoZsOMAFfnzZ7e4OKcJ2sjt8afkTrCAZCvMfufOCbqs0BaP0PpF+DUfTEFWjcy3oAtDTe2MHGh29iG6hGddHJfnh18ieB0ip5hYe6Aa5SuX8dMVX113bl+P88oKKAv8OgsmrsUjNS4zsUWzOOJptxoXAX9E9SOKSx/WS5ROqj3+A3V5RrcLi8belE/5wKeuRvZh7v/fqgT2mgwld2Sh8sDOYgpUKEI/r4Arqb7WAQl+GCyJZnyQ/PAIOCYm0jVz8A==
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com (2603:1096:400:47a::10)
 by SEZPR04MB5777.apcprd04.prod.outlook.com (2603:1096:101:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 05:30:58 +0000
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::e19a:45cb:fc9e:b6af]) by TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::e19a:45cb:fc9e:b6af%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 05:30:58 +0000
From: Enlin Mu <enlin.mu@outlook.com>
To: tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlinmu@gmail.com
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
Date: Wed, 13 Mar 2024 05:30:41 +0000
Message-ID:
 <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [yhOtgPa62GqTez0h+f9oCUgf5NdoVv9oxy4qTc9Bn1rBBrB0LeVyYT5nK6yxjERcNBm2X5X+Zv0=]
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To TYSPR04MB7084.apcprd04.prod.outlook.com
 (2603:1096:400:47a::10)
X-Microsoft-Original-Message-ID:
 <20240313053041.152591-1-enlin.mu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR04MB7084:EE_|SEZPR04MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 43790805-7e8e-455f-055f-08dc431ec349
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9Xmq7W9edkj+H8FcuyZZ+q5XONKgxb1iEN6m64xdtTbjdL3jzOVNbLNFARU1+qY7eogLyZPZlBXfn96s/Ojg5BdTx5BHoNb5i9gq3xlr1bPciEBJ67elc2VxHI2iuEyPwf3Urv0jpm2K5Xuleq9hbQdrVGfiU7Y48+FWev0awKz1w51ycJhIhP1y7MnNCTgvrjITdud33+eo8ruJBf1QNr5ucKexa5YT8Zx+rbf/5DEai3+dk9mRdBDd65CQ7Zvowo5X29xdybHBYDqoMcBS7i5q1Mk5jstWl9LZpZ1HuhJiCQnZmXSgs3cEobANEZNxLDtiHyWlgiqMJmL5ZV76T9WWkse3fgt1ECoTm2AJLySY6xOaC3Rjt/llSfczq2DtbskgA6WFRJR+oQTxNFSOTkmJaLzeS7Ifa8i8BJ8xV8HdqakgKAYWq4JGp/oTMvKd2llhT95zkzihQ4EdueYdx1lnD6THEI70Lm/E4IUuJG8XQlxpn4p2SsTa+jJuqG82l2DXrmKJl6flCvlvq4emgktMKI9rlkPW7MncTPTn+vGgnioeSWNiEY/s7L4JGQwrLFNxsUdOtlX8Zce5G9CFCvxBZRfbo83qZSxAg43IvrHWSTYYnaOy6Hx9DZohNti1RnxVlDruMbBXHy/aYXjIA/RTUMNPubZjXkRA7LmOrUC2+DEBLJVYSbEi/nM4r8c76p0Hq8oG5M1FNp8E4ebpX2m+wSg7pgFrMRZpFHrre6SbOfN6nDtVZ9hSty9voBsd3uFI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yb7SlXi35n/jf1p7t0WJqTdo1Fi9bOgsd9MLPGuN9q4Vr9zV9DSbH6O6gnvLM4EvEj4eR5SGHrICE4L/DyYiVs2+kXwztKYoA+onSX/ggakibOUnpWP6DQvhHZoqA0OkPehvWwgHY191oujK/W7GDVVT58Y9jat2mi02r3eXu+IPnXS2e8noLqC+MW5rGkrpKhJlm9KGsnC6ERfR4GpkWovCXw5oGn8f5K+icPC8LH77Z2oRxAwDUsg+manRv/p9ma+6IQ70p1fMl3V5VqDIZH6mqZzfjzrVOEWTX0IttK3/8/iJU43LJYN2VtzZSK6aurjOlspPaSR/q7JPEjovz6scSWUuc+yBxNnXybLix5V+b+DpHR+zrfp5wqcXe9qQxMjflQGDrNOXqsGLymf5bsidNTordVrr4ZJ6sKrMyMDdo9roasbGyTwX+e5IOFCb8OzCIUJtO4lJnrDeSYkCaopTn8O/d3jTOLIn3xun/kAswnw7q/NayTL3s3z2/H78zbd01Fn0+IvCWABeKhS1u2M6vHxQT4H4ALpge8n8kbt5zzrEfkr/7tKP6aijtskn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVzCBW+mjsjtVpLPmXYUzD6IXA8Vs9AotZnsk4H/UNsxv+0VV1xa39MT8V5i?=
 =?us-ascii?Q?5dqLcALWz+tLdozy9/ELO95w02gu3NJUFbt8NYOvbgedFLrei8hMKqiIR/yT?=
 =?us-ascii?Q?gWejDDmup7Sk5/dejN/O1W8SFgTYd3Su7Qexx5CGLqeTnG3uQe7eEs6rlzt9?=
 =?us-ascii?Q?jixy9A4PjMHsSNcoHsTIe6eHFt9Q5CHu5rCq4TxXo6VG7Mase9ioAOohAuse?=
 =?us-ascii?Q?RupVe/KxrbAFjmGlZQkB3jsIuvWZFqVf9u9CBy8foHbbtRkBrq4zFYKpDa9K?=
 =?us-ascii?Q?DQfnCaihIjZiOW1ubmfU1NjeMuW/G3fYCcrRzmXkSz6ahrMN1n6NbYIxH35w?=
 =?us-ascii?Q?Kcs7cYAwjBDHPN48MJaet1V6yj8cWOoKJNDpfVXI9RmN/ksamKxVFENd1/du?=
 =?us-ascii?Q?Ixdipzua2ihrq6NcCojs+mL7OnaefSh94qC8AWsSAtjfbDQmk5PofS7zIPzj?=
 =?us-ascii?Q?YDiH6rIaeGhTzdEzpW6/TTcTNU32LddduwsL6Uy3XL4auX2pECbH0LeALLhR?=
 =?us-ascii?Q?Pap+WI0zaRDOhdAQOFan9Psidk8gkY8UE9Pgr/YJWa2y4fLjgG5rgxjI6jUL?=
 =?us-ascii?Q?7PR9j2LGtLE34hCSaDog9HndrrQwda4CUX/Oq6SEJidvuEDh/JUXN4gVrbc5?=
 =?us-ascii?Q?/orrB7Dlgj2bihe5H5xuL8p/ic80q9bPFEUxqmUhI0w8S3eyXK6b1b3x9c+r?=
 =?us-ascii?Q?PWG6PnpEKjN9M3VP4YfQ9gSnCYmi93fLBlaqQD4vDUEj3QwCSoruiTcSC95I?=
 =?us-ascii?Q?ixON3pJPlp47jPKM9JMHQqkgsUYO99TUHGIVTpwTAveLa+SrZwJk3mtEWtlG?=
 =?us-ascii?Q?rRgVe/x0ksSBCCFOGiq2WSF2Bs7g2GHSj7ZA7rOfpGHP1r8qSOaTgv2HD/21?=
 =?us-ascii?Q?Vnrd4nrX/7ARVsZNCnZ2kLqbc46XrVqRK6n7hZoVXoGK4JwTMKYcFy7nKAEa?=
 =?us-ascii?Q?QP632IjKYal129nkKGVb+5s17CMrNgvktpGxxJK60dQe/XtEwhje4ZYK6WAk?=
 =?us-ascii?Q?Jwypf2Nc/5ddXhZwyq7lZP3T9aF1nsWXjoOzv3BJCLh5jFVWGdHGVxABw4Ub?=
 =?us-ascii?Q?qUBjdA6yr6+0x2dNIoCuglPdWwVJwxRFUdQ991gnw8nAOPCiQXL5zf/CHdK/?=
 =?us-ascii?Q?Hb2pXCRmwFmCGe9slvYPSg3blQ9MK6gnL51oKCQJnkf7yv1ah/auOKIj4dYx?=
 =?us-ascii?Q?ALzZb1sOH41VUXjt7/g/SnTOAirOATjyTQWL/HZXOIdCvMV8Vg5Eo8Tw+nzL?=
 =?us-ascii?Q?e6Xf1HgC05kNIGvGDLGGDetolB+BjDV3fjj57ZbpTT28P62UuMpveUSwA4W8?=
 =?us-ascii?Q?z4e3+ZDKB91be9KCzvVG0ARzILyOC/3pyU1z5ZX/OxuN1g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43790805-7e8e-455f-055f-08dc431ec349
X-MS-Exchange-CrossTenant-AuthSource: TYSPR04MB7084.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 05:30:58.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5777

From: Enlin Mu <enlin.mu@unisoc.com>

On the Arm platform,arch_timer may occur irq strom,
By using the next_timer of hrtimer_cpu_base, it is
possible to quickly locate abnormal timers.
As it is an out of tree modules,the function needs
to be exproted.

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 include/linux/hrtimer.h | 1 +
 kernel/time/hrtimer.c   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb615..2a37d2a8e808 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -277,6 +277,7 @@ static inline void hrtimer_start(struct hrtimer *timer, ktime_t tim,
 
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
+extern struct hrtimer_cpu_base *get_hrtimer_cpu_base(int cpu);
 
 static inline void hrtimer_start_expires(struct hrtimer *timer,
 					 enum hrtimer_mode mode)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 70625dff62ce..f7cf7d48b91d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1309,6 +1309,12 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 }
 EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
 
+struct hrtimer_cpu_base *get_hrtimer_cpu_base(int cpu)
+{
+	return &per_cpu(hrtimer_bases, cpu);
+}
+EXPORT_SYMBOL_GPL(get_hrtimer_cpu_base);
+
 /**
  * hrtimer_try_to_cancel - try to deactivate a timer
  * @timer:	hrtimer to stop
-- 
2.39.2


