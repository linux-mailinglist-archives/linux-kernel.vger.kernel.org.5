Return-Path: <linux-kernel+bounces-90503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A9870055
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018EC1F25E87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31C37167;
	Mon,  4 Mar 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jna1ogaf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCB3839F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551365; cv=none; b=k9H09ilN074GG0Mxz38ZsfzDTCe1tICqZ8ujNdjjD8Q8CGyrARdBBGKssRgCiU4klq/rfZSWgVii+X31GSVY1umln5AKz8n/MCFBgGc3UzNjeaj8opNp//xypsw3fEr9fm61SnXBY+mGLmJTKdtpTRrUxYpbNAP0My/Vy/gD8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551365; c=relaxed/simple;
	bh=4F/3pvoKPicmhJlfUvzEOvWzzDu4xBXOv6jna4p07u8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SUlSwqAYRmUHNNW2hji2AFm03qXKYiK7nXqCG1YRuqi2H9CvwpGTmvBGMLWduCvWMErTVSUIopRhrc4YEY4pvMsGgJ4CitQ+syREAgEfCO1aQP8dJATTn0Nh0krfvxlEZrLLP3VuG3WeGE6s/j0rR0pbURZFv4jfdgNk3XYxjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jna1ogaf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e58d259601so2740853b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709551363; x=1710156163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfdTBXeEYKopzUYmugLEzbdirAWxeCvLjKk0bWULobA=;
        b=Jna1ogafl93NSLBHvs+lxS/585PJk+MolX5HJVQ0KDmwr5gthXGdR7hl6Y6lUKjiOw
         P1Sky7q+5GNnM/owmUYkYQ315iEestDtWBBtdhICnkrELW/Fm2yQ7THz+GOKCFSudARi
         LviE1q/GAo7NigqAPzYTCbCFciJAVKLPKGaFV+W0NDEIUxvckeI6p6Gqjo02fp7MoAQI
         k58kbv7wV61ALc0+Y/cq6/hmmHuK0FPKxBbcUtitJaluKXJAo00aR4N5mqAY3iz1ZNMy
         PBHEvuQmqJFNuQkOTQHK5acFBkqgO9cJtc6Rd3w6ncNH6EiT2LBrdpjkscG6Ab57UnzE
         Cmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551363; x=1710156163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfdTBXeEYKopzUYmugLEzbdirAWxeCvLjKk0bWULobA=;
        b=j1L0WG0FTFV6/A395OoxnhsRxR79kcSELj3pbdtIjcpMugIMR4iZtuYT4YjwNziQXO
         5JL9jKdb5De6/RMzF2HMWL+uWgncl6+RxuMZsuXb4KiGMre+b4mP6M3X/j3Yakwxw+z9
         EseSejD87CSuOOjbCQHs+8iDVYj6n2dhg1YEPegNGMDZAf4YoDQl/ZY6Pbz2eEOS4+nz
         vPk4ojofvPvZf4zpf+uUZ0dxVajABUoA9oqLZtcl9UsDQLYqNcClPukU2JIqlz8hOkUE
         ONYrRePs9znyKws4oSCMO9MptTog2qwKPkMQE+baIBYBxY9C4z8Q1ETLakRaAvWZPGRt
         FOvg==
X-Forwarded-Encrypted: i=1; AJvYcCVvBBJXvLYuMqmLoShshkSnLRzRkJRbVy1hYMlcNkKnFomFgWbxYd/qlrqgr8S7UHJSVzFSdFcsX0WMQZ8aaT5WlZ6pB1RTMZGsEgt4
X-Gm-Message-State: AOJu0Yz8Pr9O9wEEchx8q0uuvT82gTI+HA/ouTnDEsc2lQI6SAzyPDzi
	Gn30lqOZRS6smIRrLT1/ZkOZlJWw+pKwaebrnMSBgjbRNVak5NcKRTgZfuQN3/A=
X-Google-Smtp-Source: AGHT+IHqFMWOfl9tVFl2Amp3r1hgjAKb7v8stgiiurB0hYbr37gSBL/VdKul0V4K6tiB9sapT0BOhA==
X-Received: by 2002:a05:6a21:339f:b0:1a0:f4d2:31ab with SMTP id yy31-20020a056a21339f00b001a0f4d231abmr11208495pzb.19.1709551363016;
        Mon, 04 Mar 2024 03:22:43 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00188e00b006e55f6cd7fesm6968031pfh.137.2024.03.04.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:22:42 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] OPP: debugfs: Fix warning with W=1 builds
Date: Mon,  4 Mar 2024 16:52:38 +0530
Message-Id: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently get the following warning:

debugfs.c:105:54: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
                 snprintf(name, sizeof(name), "supply-%d", i);
                                                      ^~
debugfs.c:105:46: note: directive argument in the range [-2147483644, 2147483646]
                 snprintf(name, sizeof(name), "supply-%d", i);
                                              ^~~~~~~~~~~
debugfs.c:105:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
                 snprintf(name, sizeof(name), "supply-%d", i);

Fix this and another potential issues it by allocating larger arrays.
Use the exact string format to allocate the arrays without getting into
these issues again.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Use string name while allocating memory for the array to fix potential
issues later on.

 drivers/opp/debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index ec030b19164a..27c3748347af 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -56,11 +56,11 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
 				struct dentry *pdentry)
 {
 	struct dentry *d;
-	char name[20];
+	char name[] = "icc-path-XXXXXXXXXX"; /* Integers can take 10 chars max */
 	int i;
 
 	for (i = 0; i < opp_table->path_count; i++) {
-		snprintf(name, sizeof(name), "icc-path-%.1d", i);
+		snprintf(name, sizeof(name), "icc-path-%d", i);
 
 		/* Create per-path directory */
 		d = debugfs_create_dir(name, pdentry);
@@ -78,7 +78,7 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
 				  struct opp_table *opp_table,
 				  struct dentry *pdentry)
 {
-	char name[12];
+	char name[] = "rate_hz_XXXXXXXXXX"; /* Integers can take 10 chars max */
 	int i;
 
 	if (opp_table->clk_count == 1) {
@@ -100,7 +100,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 	int i;
 
 	for (i = 0; i < opp_table->regulator_count; i++) {
-		char name[15];
+		char name[] = "supply-XXXXXXXXXX"; /* Integers can take 10 chars max */
 
 		snprintf(name, sizeof(name), "supply-%d", i);
 
-- 
2.31.1.272.g89b43f80a514


