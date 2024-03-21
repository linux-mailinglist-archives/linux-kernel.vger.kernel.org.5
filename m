Return-Path: <linux-kernel+bounces-109785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D08855AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF541F23F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CB5B1E9;
	Thu, 21 Mar 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzbmQlIh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049F5820A;
	Thu, 21 Mar 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009744; cv=none; b=Inmb3Oa9kz42qrt/21gVni50phlxGM+m8mT1cOqzwhaBy1qMVMxYKzDppIfR+Wzt0g7p2TPeSDxq4Q+ZvYEdx0224TCBXg6U5jnMlpyQ9LHCKg84YTrg4SvbLbbISVFm19D9eu51tcM1I5/aTY6IcNYCNiZqZOOe2CBSyHFfrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009744; c=relaxed/simple;
	bh=O7U89RzaL527EY7aNrVQy/gmY9Ebh3baiEJlTjbRvS4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uiOtNH5qdxpPI3W/W63gFx4+cNuCXeORfw9I6MHoKZCU+zUNgbZimPF9ACoXhoW5sYR9J8a3UG7flXUBnrfIqzWkOFjnrVcJ6sFKhwYWzJiau7OPqeEkJf5+ftlwcgdRDtI8jBtNBsTT2vRTQx/CjgcwQJ/0Ph0gXzAOc0FLJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzbmQlIh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0189323b4so4630945ad.1;
        Thu, 21 Mar 2024 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711009741; x=1711614541; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhm6r5ii2MnVoReh09l/GcQlftroxvx/BpXtnE9i4cM=;
        b=SzbmQlIhkrmO268uG/EhpcTyWdAbOMAvVEJKzY1DlB1OGCJ+gGMnx4UZcNiCyCb0hn
         COGccuPkzF4wSj81POp50jWIQGu1w/+vGGHBr1aMxmMHKGwyGqS8qfp/T3S3N4JCewpv
         QiwjCUYJxYeZiHf1R2isuj+pBw4NgTuxMtZYCDR96LuKgBkfNCXTCiK88ntfDIvB3npX
         j7MV0wMMPBGH5O7gHpdyja3E+XmZZuUCcLZZtbC5yN+YeavFJWsggK6tqpCCWvVqQF3b
         Q0a55wyECuFp0/QlYYD24NT5MvCv0woHp6yQUgk+x5OQ+O3gqAHY53GJKIFmGE2PSIKZ
         kVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009741; x=1711614541;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lhm6r5ii2MnVoReh09l/GcQlftroxvx/BpXtnE9i4cM=;
        b=E+ua1P1pDpKYhls4lzrnjslFY3T6ARzGxW5Mz13QPreL1mrB9BLDKVmeLNYbnjXATX
         8vJrrUBU50/JlLViYwbiBmuJMT9KcAnRcuHFT0S8jTp2fQfOZDtDRFD6NKrR26ELWub7
         zy4keOkOU7dbAXqNXBtmcbIjVmPddmKtIbyfAuQg8k95rAVI2Z/tS5SUnP3FvB2gC+Gk
         Q6U67xK/dXjeUevH8cO/PYKMXszUlccTHz7kOYeEO7bl5lmuVK3SElVY6MMGCvoHUZlG
         Sc10qynvEQnA6LubMWrJmpccSSleLCjf3a2ygFrgJMMuODI5ioIc3osQ8ulv8cr/8abV
         gDcg==
X-Forwarded-Encrypted: i=1; AJvYcCWY02dYuAvbYSi16M1JbKZQLQI/wwAolp0rbIW3D6bnYWKU3MRnfLFJ1faKUJxCEU4swpSkQuDXxqI4FHhX/HWyve3EqxnS0PBQbpZmbNZRpRaBksMwYMWXieXV+EN1jAF/
X-Gm-Message-State: AOJu0Yy5nR7dMfnBWETlQAjjT4xJdsEqFEDkZvSU/CKoO+tOxtFNxqFh
	6O0I2vXYpydAaLLUbLVBfKPWJ41P336mhbpcKjJP9U8zjXXmtfHqxe1WRfbe
X-Google-Smtp-Source: AGHT+IGzKiV5D6ELGwOpe4uQ08tTrLlmZl8i4ZN0By/Wx16wLkFGD/NaR9jADQ/O1EYlqg0ILWYw/g==
X-Received: by 2002:a17:903:22c2:b0:1de:fe77:41e0 with SMTP id y2-20020a17090322c200b001defe7741e0mr5048192plg.64.1711009741208;
        Thu, 21 Mar 2024 01:29:01 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709026e1000b001e0410bfccasm5678306plk.126.2024.03.21.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 01:29:00 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Make stall-tasks directly exit when rcutorture tests end
Date: Thu, 21 Mar 2024 16:28:50 +0800
Message-Id: <20240321082850.1756-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the rcutorture tests start to exit, the rcu_torture_cleanup() is
invoked to stop kthreads and release resources, if the stall-task
kthreads exist, cpu-stall has started and the rcutorture.stall_cpu
is set to a larger value, the rcu_torture_cleanup() will be blocked
for a long time and the hung-task may occur, this commit therefore
add kthread_should_stop() to the loop of cpu-stall operation, when
rcutorture tests ends, no need to wait for cpu-stall to end, exit
directly.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3f9c3766f52b..6a3cd6ed8b25 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2490,7 +2490,7 @@ static int rcu_torture_stall(void *args)
 		pr_alert("%s start on CPU %d.\n",
 			  __func__, raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
-				    stop_at))
+				    stop_at) && !kthread_should_stop())
 			if (stall_cpu_block) {
 #ifdef CONFIG_PREEMPTION
 				preempt_schedule();
-- 
2.17.1


