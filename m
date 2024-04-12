Return-Path: <linux-kernel+bounces-142251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574538A2980
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DA61C22878
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E63A1DE;
	Fri, 12 Apr 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3Ux2N+K"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9F4A39
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911315; cv=none; b=dpdDetEAM1zmYsZCwm1tQZ5M84IZPTy6VKLLhTj76q6OCGoxasWiyFZuD5jG+RS34S7yxcIJt1eWiK6k7xqtutZcPBm7S23kfcTuHZ5ud+DqPjdWAxPDHISVhHjOLMQrmI0BWJiIe0o7+Lj+8JBw/L8pd780vVArvgR9X+rhFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911315; c=relaxed/simple;
	bh=ikLHZ7DNZW/Ca/CIjkJHHCPEm9GHST1v51vR14ltSUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avvlTRfIBlXFb/p39JrP/j0sGlvYPL3iWnkeWVZt0SxP206xuR8NzYBi7srDno8dyHyEnatz80PlZIBgW/wJyk+4H8ErXM0xz6sASDlEnpEdSNIv7EMq9OSPm8dNLM7/jyw97iQkqxEq5uQ6cmTEi07G8/zjOgGmhVENeSsp9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3Ux2N+K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0b889901bso6016215ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712911313; x=1713516113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiD5nR4sveHdMLlVkzf7AW+Iyy665nseig81tvRhcYc=;
        b=B3Ux2N+KlO/ONETyL4O0ukDGXe8tzVMKIienB32opYEd+RNhVIPlFqEwzSlznpd1EG
         Uq7D7Zu8EkMsi5MVt00ZDGuG2BhWI2Vu2oP8WqutLwLMO1DWmiTNhrHUSS8hMhgbpCte
         nphl7zIrqgakl4U5L+4SpnmjtJ6YzAjfoy47lAkeRHb9xiYS5ppkEmmJ/nR7pUATTsE2
         aZAuDiRXG56hNf5wHyB6fGr2lAIpmrSYxIIY1yCxOpOmERufXhHKAXQ3+NTDFcawz8a/
         hRFfah+/fxp39S0WujvelLvXbY/uPpzPIgZBwWV7FgmB97eyrNWBfgy8BnuWNSlZAF8q
         +Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911313; x=1713516113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiD5nR4sveHdMLlVkzf7AW+Iyy665nseig81tvRhcYc=;
        b=oFOT0mDWbgMwQgTMZ1wLu5aBtuJpE18ruIecec2iqHskHKzjnZ9qBFws/r6+IwUbAd
         i5ynkFODr/bBNdMjzTgzUKaBqMkC3YUqer2NfXVg+ELB9X1+nhirgcK5Bm7y24Cm3Yvk
         ExMhUc2+m2DjG5w+ORZ1WHF4JkgvcjYWQAnYaqP2pY2OPwRTdq+/jZOjIYyc/VYrp7tG
         ZHREjFLMJJpGaEMELtFBt7i8xHm8QZetZtzar+g2U6gn0ArQa/KlOLoaBhdUFg54umfq
         rtokMiatMKeWFTsF9t56OwDUY43mhovSkfgK46A/13MOops0uQVHLMbt3obB7Ew+AzeX
         B6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXcE4HJWpJW382sm5bL8YAYGAtYT+KXRE0nkV0SCDgKRfPAtsZuCc5oawRl3uQR+H7qre+Tkmbso2U3b9xb/w9vjb3s1tthWzC4KmPq
X-Gm-Message-State: AOJu0YydG2E6bxojDZepMv4YOEqc6X8RzV4Msswtd+eUNz884vpoNe8y
	cEmh/vyi2Y3yTd7R6GS9RY2MelgHhlCxgHRosbFW4UvYkiIj2SPpWNVevdGb0eo=
X-Google-Smtp-Source: AGHT+IHqzlVXqP2gD1aO7lBgZP0b5sN+Gg/7Pf6rKemMohLxQodYUBQtZz+jscLJUuNFNJuktFAiiQ==
X-Received: by 2002:a17:903:2442:b0:1e4:5b89:dbf3 with SMTP id l2-20020a170903244200b001e45b89dbf3mr2129510pls.35.1712911313230;
        Fri, 12 Apr 2024 01:41:53 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902904300b001e2bbc0a672sm2455762plz.188.2024.04.12.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:41:52 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: Always clear freq_table pointer
Date: Fri, 12 Apr 2024 14:11:46 +0530
Message-Id: <68294ce534668c6ab3b71a1b3e6650227c6e1f20.1712911186.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The freq_table pointer must be cleared even if the exit() callback isn't
present.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:

- Dropping the other change as it is covered by:

  https://lore.kernel.org/all/20240411231818.2471-1-sensor1010@163.com/

 drivers/cpufreq/cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a19d76a..13980cb0527a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1679,10 +1679,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+		return;
 	}
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	policy->freq_table = NULL;
 }
 
 static int cpufreq_offline(unsigned int cpu)
-- 
2.31.1.272.g89b43f80a514


