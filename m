Return-Path: <linux-kernel+bounces-152146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA08AB9D3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DD31C209B5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC35F9DF;
	Sat, 20 Apr 2024 05:17:02 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70E17BCC;
	Sat, 20 Apr 2024 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590222; cv=none; b=dnDbbRH+XXdl1TByYCkKZ09FfXuny1E/GLMMp7IXz3aTuUMxN3cQyHwoKF0mF0s6kqHe0e0r7dcrJNnV19Wima0PlzEIOLzSCugn8AK7NMt336iqgKV9F6lujGf2GQk4K0CWdYAFwmObVZ3YUkE2xHQxNqQ/cEkNhfSnwH1IdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590222; c=relaxed/simple;
	bh=WBVRxLIdWKwIhWvkYX40p+kNDCgLtSNi083tiZeIF84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FccMjHRAxmXIyITDk4UkjQB2YgE4foAU6Oo0fbMfOeotY8U9tKi6JP1e+awe3svGYImf//v/LuDeg0+3tBxmmkqVfQ5IVUV/mVjz9Kcikx/8x+n47Cjoig4YXcYu6KNnD+WpLEFWNLyPgAGK/95dVSivLtgwuFZk8X6zRoldAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1713590188tfw8vcz
X-QQ-Originating-IP: TNQvptNIxgg5QGK1FQfunMTw1q79c5Uv8QKx3BF48ik=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:16:26 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: E6xLhkkW4u1WF/joyXGZBmgPq4Ovo3WKIDIrTweysvZbw5XLBL8UAFeSYqUo0
	DtDM10nNSTTpfqeWXh3On5re9mcvuSVgwBVIpuLvcTE9Y362B3eK1zkG8YyrHN8wRN9wts4
	HLMNy0gCm6oM0AQyBZ49Fl5y6AJj5lV/z7Mt/ZYwiSEwItGLmFia81WnE9lWD0GpWZN5pZb
	dzJLKLFM0e2Qg/VxpJ5ctncxlAcSVdGAZCsn3Sc3ydUu6rqhnChi9clHllZt7OCH4u5PF62
	gIXmnU6ZpzGc0+dsJPYm4mEPSCq6Qh8kVjGnd8CKDWZGZsbY9Hf3DGupHY34QeggwVaphas
	1aZOtdoeHOF7Q+6WtMguW9IhmcMpT0THL9/CLZqtQeCFrwatuiAbxC86O+MxvBMx24eqgNZ
	rHK/hISZ/y1xk2+zeWdekg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16907030830474196779
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 5/7] sparc: Remove on-stack cpumask var
Date: Sat, 20 Apr 2024 13:15:45 +0800
Message-Id: <20240420051547.3681642-6-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240420051547.3681642-1-dawei.li@shingroup.cn>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Since the cpumask var resides in __init function, which means it's free
of any concurrenct access, it can be safely marked with static to get
rid of allocation on stack.

while at it, mark it with __initdata to keep it from persistently
consumed memory.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1ca9054d9b97..088d9c103dcc 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1438,7 +1438,7 @@ static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
 static int __init numa_parse_mdesc_group(struct mdesc_handle *md, u64 grp,
 					 int index)
 {
-	cpumask_t mask;
+	static cpumask_t mask __initdata;
 	int cpu;
 
 	numa_parse_mdesc_group_cpus(md, grp, &mask);
-- 
2.27.0


