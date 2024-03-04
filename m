Return-Path: <linux-kernel+bounces-89978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD2786F889
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37091F210A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97717E9;
	Mon,  4 Mar 2024 02:25:43 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D517CE;
	Mon,  4 Mar 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519143; cv=none; b=S18p1k9EFXL5Q/kCK65C3+jhM2xMeaWamAM+0Q1FQIOl7FaKVsSlclUWtNNBAEwPKP6MFIBzHLbS7hAVmaHbLl8+cxZElAc9VxWIFZ+h/MMhNKMZcNCt51G8PvjF8AxKiDPz+bAU4z52fxOTXdxsPauF91xCStn8mKc2+2W2aUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519143; c=relaxed/simple;
	bh=BsmGAfh2XqRzr5EfNwegTjuxW7ujt5apB8OJ8rltSyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFqfjzTOr1won/2czc2hctlStkfvdWTczvQav54anghUBBZU1osWjUFa1Oq/crOKeTyprKdfp7dmW5Y+1j0VLRx+GN+8Nu5P3OuqQJfDr1ly3vP4jud3dfvWMCV3LVd67YXhyRnjZiKYw0Y+yBiUy9Bemltm1rxMV5MzoqQe5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp68t1709519095t5e6k6ao
X-QQ-Originating-IP: XoKMA9p+o3jz8qsYVX+Yzx/2I8JC/G5QjVp9P9mWv90=
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Mar 2024 10:24:53 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: rZJGTgY0+YOaF7HxPHfzhYZlLNhnxkQc61joKwp2xIXrrxD4EkthjJm4+Sr7X
	m+Eqn5anMU2dxBalh2rqMW9L9XywopVqCy/HevMq340Kir4qDIrKdHxgSEAtsvFinmwZtrm
	1HF5zqKP6Y6jKYTdxf+YfxCol4pykcaO21XZwSbsZwL+K1nyXfD8vcGQZiGv4+5tttg5NqZ
	TD84bTQcP/cJQq6G5ThFevWg0xp7mTilYjr1r4qaFE50PoK+5883yQU56gsTAlYx7im36vT
	Zu/lYPG6WiIZNwK86cavuLYsENk0hJkbY5DC3B4w7b0adl1O/dhTtwvSSZWKD8hwY41mTKh
	HIX/FafWR7mtcrsobfnjSJg7UbACisjcV0E8rhTZfASBAn/cLnanMykI55+0w==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4045340637394204571
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: "JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arch/s390/perf: Register cpumf_pmu with type = PERF_TYPE_RAW
Date: Mon,  4 Mar 2024 10:27:01 +0800
Message-Id: <20240304022701.7362-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

The struct pmu cpumf_pmu has handled generic events. So it need some
flags to tell core this thing.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 41ed6e0f0a2a..6ba36cf50091 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1213,7 +1213,7 @@ static int __init cpumf_pmu_init(void)
 	debug_register_view(cf_dbg, &debug_sprintf_view);
 
 	cpumf_pmu.attr_groups = cpumf_cf_event_group();
-	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", -1);
+	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", PERF_TYPE_RAW);
 	if (rc) {
 		pr_err("Registering the cpum_cf PMU failed with rc=%i\n", rc);
 		goto out2;
-- 
2.25.1


