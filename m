Return-Path: <linux-kernel+bounces-142054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4968A26CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA74C282598
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619446537;
	Fri, 12 Apr 2024 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEXCuH0k"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875B46433
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904081; cv=none; b=m1NvxnBZl3NYomEfo88aHMhnY8O7dSyLyA+QLb0p806OyMrVTTA41jPv8x8IgPfKDXnIoBoMYsRyzkkvEzD7RajXKgQ+jr3BQaCp9CaQQpS59QfNDRzuJp+CTQ2cVCOqVOXTvtwY4qg9FvKhKE1nT64KcGVLfDzNgCD07M9iSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904081; c=relaxed/simple;
	bh=m7pKDrYga2gbTAdKQCqTuI7axWf7A1B7kNQ/eadgX08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFxIwJHThhbuaGnFlsL9GTbqSK6nbV7ZQ+houoHGD1A9T3uw3dMVsrfCjda3sW0Z8nQ5rTc2ewJzRTXkk1tQdPzjggJHBA20f5iJo2/YydlaBWjfVUnklFWeGi7kdy941RC1dlXBCGlCpridc191HdXZv/2Mw0oxaeHNsaObPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEXCuH0k; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221e6bf537dso400929fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712904078; x=1713508878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiaQ+iCBsBW1064aL5cRxOlJgLtaI/KNe1W4qG45Tis=;
        b=FEXCuH0kwNUKPOx++wzmjp16l5THVC7WE0GIJpMwTPJsZQf7d0zPRtB+lh8F9jgCT7
         cEVP3wD34dD7xk3p0R89S8CxyTtpue4dU1uadTJaMSIHVYk8bomy0atb9AeWjOuuvhq0
         CCT+0SCjDyvkSo3ztPVJAUNOTh4chRXviY7coerP/g6Z7Wc7KEx/MQQvflBJqyfyLAFC
         1MoeF9wSG42yLIu86/bKslmxJz6oISFv+WhTjmsxd7JDUaSW4Wa6aOjUcIWLRJXDTBgi
         8vosKlQO/co1YjDBu8VXDMZ70VN38JId5dM5rgr3PhvUkDKxadXseO20Y6F6FsM9rsXj
         m5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904078; x=1713508878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiaQ+iCBsBW1064aL5cRxOlJgLtaI/KNe1W4qG45Tis=;
        b=kHGT8Raf9rEDSXz3pUyYpqbAbSmjfTv7GU/kq0JkUqpdZx9RR9wyuGk4NZYVsdqS1A
         feewp1EixJZOw/rdLOUFRaoCl7OA4X1D2S438A56KM2pgWGFo2Q7+o9e5BW/cfq5c3dS
         gPQGnjHCKW/TvXvvmFjPWJpPi1f8zk9ZLV98rrDTvRsyyKMrSGCPdo7/12sAIyNn/c+9
         cP2T9Ht+MGDZbwKKZl2S7NFMYLaAXut//X3pZQ1H8nVgrmdFkG9MXpqLG/NybZaLGvNv
         XdY2SLLGFJfDpY5z1I3L86Mj+wP5MXnB/ghXteVxlUzC1XHQvQVodmLnuA76p95cyjsP
         FHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcfWtcxg6R/TelheLrYe8b+mjTAu/1zJzoiR2ezB+CEBd+DgC8mts9eOTEpAXjYZXqpzVOP3qnmXWKMyh8qMdslw/JbsUIrifbIYXh
X-Gm-Message-State: AOJu0Yx04r+q8MPKas4kjMzsDHIgWTMX/Sa1GWY1JFGCJhgNhP2v5qkn
	sRzVaaxTB36Ih7rffLorcBxSEVqryTQrAuySsYbdREtTkJJWJuOoURD4ulHkxVE=
X-Google-Smtp-Source: AGHT+IGhXLKIVJAVcYVe9Su6xebSXosIe9oKNvMHq69VsegpumGuzgTzXIEpEa9N3vOembun61CVGQ==
X-Received: by 2002:a05:6870:a453:b0:22e:de07:84a8 with SMTP id n19-20020a056870a45300b0022ede0784a8mr1962568oal.0.1712904078367;
        Thu, 11 Apr 2024 23:41:18 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006ead618c010sm2196079pfo.192.2024.04.11.23.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:41:17 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds using same table
Date: Fri, 12 Apr 2024 12:11:10 +0530
Message-Id: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The required_opp_tables parsing is not perfect, as the OPP core does the
parsing solely based on the DT node pointers.

The core sets the required_opp_tables entry to the first OPP table in
the "opp_tables" list, that matches with the node pointer.

If the target DT OPP table is used by multiple devices and they all
create separate instances of 'struct opp_table' from it, then it is
possible that the required_opp_tables entry may be set to the incorrect
sibling device.

Unfortunately, there is no clear way to initialize the right values
during the initial parsing and we need to do this at a later point of
time.

Cross check the OPP table again while the genpds are attached and fix
them if required.

Also add a new API for the genpd core to fetch the device pointer for
the genpd.

Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218682
Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Fix an `if` condition.
- s/Bugzilla/Closes/ and change ordering.

 drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
 drivers/pmdomain/core.c   | 10 ++++++++++
 include/linux/pm_domain.h |  6 ++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e233734b7220..cb4611fe1b5b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			const char * const *names, struct device ***virt_devs)
 {
-	struct device *virt_dev;
+	struct device *virt_dev, *gdev;
+	struct opp_table *genpd_table;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
@@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			goto err;
 		}
 
+		/*
+		 * The required_opp_tables parsing is not perfect, as the OPP
+		 * core does the parsing solely based on the DT node pointers.
+		 * The core sets the required_opp_tables entry to the first OPP
+		 * table in the "opp_tables" list, that matches with the node
+		 * pointer.
+		 *
+		 * If the target DT OPP table is used by multiple devices and
+		 * they all create separate instances of 'struct opp_table' from
+		 * it, then it is possible that the required_opp_tables entry
+		 * may be set to the incorrect sibling device.
+		 *
+		 * Cross check it again and fix if required.
+		 */
+		gdev = dev_to_genpd_dev(virt_dev);
+		if (IS_ERR(gdev))
+			return PTR_ERR(gdev);
+
+		genpd_table = _find_opp_table(gdev);
+		if (!IS_ERR(genpd_table)) {
+			if (genpd_table != opp_table->required_opp_tables[index]) {
+				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
+				opp_table->required_opp_tables[index] = genpd_table;
+			} else {
+				dev_pm_opp_put_opp_table(genpd_table);
+			}
+		}
+
 		/*
 		 * Add the virtual genpd device as a user of the OPP table, so
 		 * we can call dev_pm_opp_set_opp() on it directly.
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4215ffd9b11c..c40eda92a85a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
+struct device *dev_to_genpd_dev(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	if (IS_ERR(genpd))
+		return ERR_CAST(genpd);
+
+	return &genpd->dev;
+}
+
 static int genpd_stop_dev(const struct generic_pm_domain *genpd,
 			  struct device *dev)
 {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d3280d35f..f24546a3d3db 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline struct device *dev_to_genpd_dev(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.31.1.272.g89b43f80a514


