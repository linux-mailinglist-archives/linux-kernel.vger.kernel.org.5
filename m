Return-Path: <linux-kernel+bounces-162418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5908B5AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B0B288DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B37EF1E;
	Mon, 29 Apr 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/iMwAhf"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EA7D074
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399560; cv=none; b=QgNbLxOP7Y6G/HAiXnxweY2wrwFEVwmgk6QMJbFW9W1aseSx5Wk43sz/0xDoWwEMIzXqb/Li4BDh3utSzXr9b0f9Df78k9G7FrwTOcwmpID7Hh6S3C28SdP8EkE0+a37aVTWkR7NORbrDbxdadrcyUerJNK5FEexD/wOmSR68ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399560; c=relaxed/simple;
	bh=1UeH8qsec/NsG1L4r/jxKyr3U9Kx19UIvj4u750pz7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7s3oc02rpzFEQqbg1+lkZofwp7Eb8fuSN94chi3ZuAHghPkj8q0sV2UWE7yKpiXtbofespvNs6f6oeczqxS+HQwAPFu6JSxE6dK999efH96X9CBq/wkXj7/EDk1KaLKyJ1mgfNGEF7rSyX5opJFvgXNAkElFOYjQK9Xibgkrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/iMwAhf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2def8e58471so69435791fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399557; x=1715004357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW5irYe0gjQq7lL2yVFdE32QB/2sja742dgELwuFIJk=;
        b=c/iMwAhfHedZjTaiZxINk9MIxWrW7IwFedzFroyC697A6qVFBcR9ZXmzzLjgSYEDjN
         pNEE8aDqnj5P+N9LiOchFD1jGyvqZc+SroHpZUFrQeEvlCtUVuqB1WfvbhDl0ouvuiSX
         +2/D4U0s+fW0MPPHiHeGiGMCIN/1LU79utIzK3MEbNQottQgLklgq2h0NO7EC5RcSt9d
         G/pvdOsOGKIVQUG9b09YcFdnUi0qQWq1S15Oiw1D68oq+dZDqj+EsBMcDSeBYMTLnTDj
         TIUtMp0CosUZD5C5IWoG/ff0pnufhY8hL9q9N+sKBcTLEu2mlMmVgWVBoB99RU23LtRd
         6eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399557; x=1715004357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW5irYe0gjQq7lL2yVFdE32QB/2sja742dgELwuFIJk=;
        b=HfcwYKtRMGRfzCsIiyeVAlLEI5t7b7yC5cWcLDJIxmVXoj31O7OtWw80W4ckM/ucZc
         bvN3qYhvHPFE9groEEM7z2Nr9YoPOYah43mnZHFNL813T0kCOSwarBFl2aHHk/tJvWPG
         mx4z/e+mzz53SaQpXF9l18B4L28NL6rFPkr9DBKVQjuj1ZqBfSs6o6YiBmj4Fh8pR4nu
         N6imEcKg7W2IdJroIZVhkGlG25jB2ZsyOHhQuAJOWzavLcQaLo0bp7pkuffGe3Zf+jex
         RD/XynK051NTQwXI8wsgteWqchA9JSV3h7HGdw+KHXA6k6EnEmCL5zVS2M/S8kIrRi84
         IgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHQAxUwdRDx+y+GUGFu/CQ1AjuIiHR3zz/61lXHUn99Y+6EhffRKRAmNTNTQrmThtKntkp5Rqwgw55HXJVHxnw9EoKu5Z2Yu0ai45
X-Gm-Message-State: AOJu0YycbqvMIs/xsbc6QQ5PzRw30UwEBIYWaLVw553AO0r6mXi/DP8w
	QjpLp+skq4HQFJb9RDNvDZX3jmKG3MyFDRJaoyZOye9jPuIgN5MA2fd7a+486CE=
X-Google-Smtp-Source: AGHT+IGF1UWUkvnjVr7+ybR1e2V30LVUypzK2Fkn+AyO/pGbJIHureio72OUBUaKULp0nWYCZstvjA==
X-Received: by 2002:a2e:730c:0:b0:2d8:5af9:90c5 with SMTP id o12-20020a2e730c000000b002d85af990c5mr8482506ljc.39.1714399557079;
        Mon, 29 Apr 2024 07:05:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:56 -0700 (PDT)
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
Subject: [PATCH 3/6] cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:28 +0200
Message-Id: <20240429140531.210576-4-ulf.hansson@linaro.org>
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

The domain-idle-states are currently disabled on a PREEMPT_RT based
configuration for the cpuidle-psci-domain. To enable them to be used for
system-wide suspend and in particular during s2idle, let's set the
GENPD_FLAG_RPM_ALWAYS_ON instead of GENPD_FLAG_ALWAYS_ON for the
corresponding genpd provider.

In this way, the runtime PM path remains disabled in genpd for its attached
devices, while powering-on/off the PM domain during system-wide suspend
becomes allowed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index fae958794339..ea28b73ef3fb 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -67,12 +67,16 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 
 	/*
 	 * Allow power off when OSI has been successfully enabled.
-	 * PREEMPT_RT is not yet ready to enter domain idle states.
+	 * On a PREEMPT_RT based configuration the domain idle states are
+	 * supported, but only during system-wide suspend.
 	 */
-	if (use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (use_osi) {
 		pd->power_off = psci_pd_power_off;
-	else
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+	} else {
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
+	}
 
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
-- 
2.34.1


