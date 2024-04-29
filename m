Return-Path: <linux-kernel+bounces-162415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55EA8B5ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730AE286A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153B7BB01;
	Mon, 29 Apr 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwcmDchp"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FA76413
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399556; cv=none; b=NCui5wsdEH3Q1k864/v0dMWsA+9uQbpqrfGYTdLviOsQ7bR448ecQJhcXPrOKnzQ65sIhDsMrUn55J2urwO1xsXDpr69TZctivgxzq0+nSZyXoVOo4AombFM1/EVhc6ofEITvJofPdr2A861zn6xMGS7/M4mfjzV7UrTWTzsXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399556; c=relaxed/simple;
	bh=JUTIW6FwmRC4re1w/6L4Vvb2fU9dfL0clbAE1qtVCys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBfQx6ghdcVheLBovEFLNqlmsUB1bcoI1ZAXNoeV+7wc26ZpQOeeSkF6e5s5XMMApIYiBw6IIp9BKjkjVPuD3V4u/Fea/IWNAU7B/SAnkmRYVvf8pR8UVchwn7L4+bdtAwnDhL0RjNfuntGsp9gft+8ZluAEMJX2oNbHPnkLbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OwcmDchp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db13ca0363so71648041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399552; x=1715004352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7PwnHMKHYTfq+/GlcRBAJxV8k/M8+pq8KDTTyHcZEg=;
        b=OwcmDchpRFgfiRLCgodVYPcVydrQU52YB7FWK3My5xsyBKUJCBgHm/H3wre6pwTOXS
         bRI3eA6hOfLBsPAa1nMG486nt43xwRG1y6gQ3uV3zcBPrn7WrVpsObACGULxKcw9Gznh
         /GGqsYqCSqtcu7MiNCqV2Toroj6wr9CvXzV5arNJX/9mKt92nx+Ctn+9/mdX2PTwYGJD
         fpuaFHn7Qy9ufGXIkw8q2QbMKdYYJftMbcQl7yNSPCR0lOpyB9WCtCd6+Y1EIXZ4X6Di
         qaNxqQl4y8bMXplxJKOJNDkNHYc/hNXBR6q0FugE00cKamoy7LipB3Khl3uMtYCGAK+z
         rqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399552; x=1715004352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7PwnHMKHYTfq+/GlcRBAJxV8k/M8+pq8KDTTyHcZEg=;
        b=f9EPpjai3guKCOuweqpj9JLzv6WOnMV1QJCzVvZ5EoMzz8/7fsfaBWzMQSihhiqNqs
         8FUFFwn/ndNXPRQrKTyQKAkMdNOv/GgP1yOxrVSQzQFMJprCdA5IEIk5IcAS+CQCR/rU
         QlGdTDwQAyJHo6cdFRuTjjVLv6ExGvynvrFRX4PCUtHZ83wSm9Fbfdjk8B45M5LkRIRK
         l1jzZuNwOmb03nIvmqJzLvAbQWDhknc57RaugVI99pP26ejtEv2gwoa/fKUyNmSIpR6J
         2+NBRjthGGVxdSxkIeAh8V/b85JX7FYMjnuAef7Kcrdc10I1TosNIqhTCtZrCevmi060
         ZB7g==
X-Forwarded-Encrypted: i=1; AJvYcCWGEIWiqr99UMSi8Hg6c9tz7notklJksQT3981CQ7Jr0CWNsWpWk+OHrqChqrdeq7wle9IGeto0Yl30p7whPG4jlCsa4Jr4k08RD0LU
X-Gm-Message-State: AOJu0YxMWL9qowxl4bT3BQemNLQhwxEfRcWkpx6KUL4CNOFcM+9LKgjC
	4hx83Il2cJiwfw4+V3kTmIBd3AVKRu+K4sDoguMvwQ7JRBmeRBP+RkPUHANbq2U=
X-Google-Smtp-Source: AGHT+IFR8cvupOz4nvn65URl6ZTQLfP1foLQ6aQMTVOSVqjXElBksfqqnj9dzeKq2OEC3TicFEDdMA==
X-Received: by 2002:a05:651c:211b:b0:2d8:d972:67e3 with SMTP id a27-20020a05651c211b00b002d8d97267e3mr10312447ljq.5.1714399552449;
        Mon, 29 Apr 2024 07:05:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:52 -0700 (PDT)
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
Subject: [PATCH 1/6] pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:26 +0200
Message-Id: <20240429140531.210576-2-ulf.hansson@linaro.org>
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

To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
during s2idle on a PREEMPT_RT based configuration, we can't use the regular
spinlock, as they are turned into sleepable locks on PREEMPT_RT.

To address this problem, let's convert into using the raw spinlock, but
only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
this way, the lock can still be acquired/released in atomic context, which
is needed in the idle-path for PREEMPT_RT.

Do note that the genpd power-on/off notifiers may also be fired during
s2idle, but these are already prepared for PREEMPT_RT as they are based on
the raw notifiers. However, consumers of them may need to adopt accordingly
to work properly on PREEMPT_RT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h |  5 ++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 342779464c0d..abd3c069df8b 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 	.unlock = genpd_unlock_spin,
 };
 
+static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->raw_slock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&genpd->raw_slock, flags);
+	genpd->raw_lock_flags = flags;
+}
+
+static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
+					int depth)
+	__acquires(&genpd->raw_slock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
+	genpd->raw_lock_flags = flags;
+}
+
+static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->raw_slock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&genpd->raw_slock, flags);
+	genpd->raw_lock_flags = flags;
+	return 0;
+}
+
+static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
+	__releases(&genpd->raw_slock)
+{
+	raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
+}
+
+static const struct genpd_lock_ops genpd_raw_spin_ops = {
+	.lock = genpd_lock_raw_spin,
+	.lock_nested = genpd_lock_nested_raw_spin,
+	.lock_interruptible = genpd_lock_interruptible_raw_spin,
+	.unlock = genpd_unlock_raw_spin,
+};
+
 #define genpd_lock(p)			p->lock_ops->lock(p)
 #define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
 #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
@@ -2069,7 +2111,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 
 static void genpd_lock_init(struct generic_pm_domain *genpd)
 {
-	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+	if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
+		raw_spin_lock_init(&genpd->raw_slock);
+		genpd->lock_ops = &genpd_raw_spin_ops;
+	} else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
 		spin_lock_init(&genpd->slock);
 		genpd->lock_ops = &genpd_spin_ops;
 	} else {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d3280d35f..670392ecd076 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -194,8 +194,11 @@ struct generic_pm_domain {
 			spinlock_t slock;
 			unsigned long lock_flags;
 		};
+		struct {
+			raw_spinlock_t raw_slock;
+			unsigned long raw_lock_flags;
+		};
 	};
-
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
2.34.1


