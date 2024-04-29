Return-Path: <linux-kernel+bounces-162421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A800E8B5AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F5BB25744
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864281AD0;
	Mon, 29 Apr 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynNUlOaN"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D280604
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399564; cv=none; b=mMypSmI6bANLOAU1JwI9uklqt/jy+GIZIczDn+6pQZhr+xLYsjunPE1oQwzWxqb+Vnvwi7l01Y3ffFj3LoLshLjal5rm1/fWbBisOgIDrAlSASyur+Ok5PFSTlrkLp6CUE7RxxIP8Ziyw/oI4BLbJTL7Qb8uhai9B4R+uR0yt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399564; c=relaxed/simple;
	bh=bIu8MbW3zdEnNCbcclk/lNsKop9RpekiJmMvuMEBXIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbwbXn39kvkGreqIFexRXgDw2Z0fCuBcAKNhtClW1KcDWrdfwefJ/8mj83nMGYMt+1VAu3oXafwCQzS8QusPezc+m9GTsxCdp00jE1g3H36QzHzNV6gQK6l5ZwSkwXIJCSN+OXs/AmNnD+0UvMQrsJdG0eSbA5E9z5/XXt7NvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynNUlOaN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2df83058d48so30621601fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399561; x=1715004361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDwOmSA7MQ7+zytHkA+laGeE0LQljf7L1jWo+P70lko=;
        b=ynNUlOaNVD7iZgypmP3lZCl0KpXUrvNBCUIpdi1Eha1nepv9lFYNM/v1anteWxOBY+
         PIf6WkEx/l3Le/oG4cTXCrbJXluBfipnb+wLin7DhzA1oT3fvN6KhjMlozBoOTNwWHhM
         3J5bK7YUquew17u0XdAY/Y/WH8dfpjj9TqHoNfdHd/R8Hb+j0KwMFDHoQsqQPVSvbP1B
         NjWReMvfvlCS2Q56EM7yt9YN4EPA+2gXxylUSStP5JijZ0s3u5L/dGDx6alA+290oln/
         2LV5nrCr1VS37kQvP/bTzGLJKmhE+80adYj/F0ryZWZIsZez2H/hMVWYHXmoFqX5WLD3
         XOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399561; x=1715004361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDwOmSA7MQ7+zytHkA+laGeE0LQljf7L1jWo+P70lko=;
        b=eE7cR/KA506AbKzUrzJ/5qQXLwYHeuUWFbi5QMdhxRG3mDIuDtPQREcVkVig0JK2Pq
         WF1VZeZHvARniUtnniLV6J0zX0mtjWvZpvu72ZURrJBDOnliFeGiDSkCfT1OYQeud9Zt
         lUqjFQ2X5TvPemtLgJI/MC9rB7WjhW8bPbPok+tznRx1RkOB/v27mkTmiOTk99MmMwc9
         y55vkSzJNWifqJcNVOKR8LpGPt26DYioC89TAMK3/FOD6OO/d2BZ4hGZdpwirEKExXv3
         y2QTggMXUyjLvI1yZFQ/C3aecyEQN45J2LkvmrEA5/D35/5jZ/GCtPuczKLmy3xaXRiX
         C2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/DKXAaGar7rfw7GeaTbmLNrFqWAx7g0BusaiN+P23sXt6PgGYLecochAx1ZeufpTT97A5ubMKuAZvql+0n6L0ZfTICUV7+TPs5C4U
X-Gm-Message-State: AOJu0Yw+NnydDHBh9l/fYKp6P5qOO+noaFeudl45PbFNApWrG8U9v5G+
	WtYus+Cv0qJn5ThR+aMYfQSI4UgUtvos5CgCfvo3DyJg8JixrgSfNvUBzUUuq60=
X-Google-Smtp-Source: AGHT+IHp/AQbEYZZdpmQu1KIboKwTFnhRTHy3IUitMBtdTfQEIp1e8p8oPGMBXNXjtBT0xrYq8GO+w==
X-Received: by 2002:a2e:93d5:0:b0:2dd:6d67:3064 with SMTP id p21-20020a2e93d5000000b002dd6d673064mr6309727ljh.28.1714399560822;
        Mon, 29 Apr 2024 07:06:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:06:00 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:31 +0200
Message-Id: <20240429140531.210576-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429140531.210576-1-ulf.hansson@linaro.org>
References: <20240429140531.210576-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable the domain-idle-states to be used during s2idle on a PREEMPT_RT
based configuration, let's allow the re-assignment of the ->enter_s2idle()
callback to psci_enter_s2idle_domain_idle_state().

Similar to s2ram, let's leave the support for CPU hotplug outside
PREEMPT_RT, as it's depending on using runtime PM. For s2idle, this means
that an offline CPU's PM domain will remain powered-on. In practise this
may lead to that a shallower idle-state than necessary gets selected, which
shouldn't be an issue (besides wasting power).

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index ad6ce9fe12b4..2562dc001fc1 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -233,18 +233,17 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 
 	psci_cpuidle_use_syscore = true;
 
-	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
-	 * deeper states.
+	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
+	 * s2ram and s2idle.
 	 */
-	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	psci_cpuidle_use_cpuhp = true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+		psci_cpuidle_use_cpuhp = true;
+	}
 
 	return 0;
 }
-- 
2.34.1


