Return-Path: <linux-kernel+bounces-162419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035318B5AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979131F2304A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D481725;
	Mon, 29 Apr 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANV24eal"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E17E110
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399563; cv=none; b=XKUsik9R30rs3s/jsX64igcSNUFJKHGOtjLPixoHw3fUq4g7VJy1cq4chE3xFM422w7MT5IPOWLBdjEU6sdaZG2HaahrLNHoB6g9oHCTTblWcX56GZqXQE8AFJRaK06MPV1SyrmB1DrHbh+IwD/glfddO7RmPuGHD51ABIj8qJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399563; c=relaxed/simple;
	bh=jSO/TwF193q6NQysycIGd6vDzmh/SnmSAu4Kev3da7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=He6egnOVae3PhFDn5qNNs7lxfDVNwFXY66nv64Lo6Ixw1C/SRQVv/gurXRT8hHLs71+PV0KC1zNx+NsIaT3QKK3ddzCjdhoya9RFetW9jrOn8bsjUMsdQxGPYNGZd750dtGbcYD4f+ZuE0o6si8w/BY2lUp7+sec/SNwerIkc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANV24eal; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e01d666c88so14243801fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399558; x=1715004358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryk8Yjnwcb/TeAS/NSYC6eu7KpbQ2RMUyBm2Fm6rA9s=;
        b=ANV24eal42bpfcOfoK6+3lvgO3RLohrNWPsGMfJ9BCyUxF8xkd8fT5B5Gb2oXMyA7X
         rwiRyNJx5Sh60wn3z/CkEpyLIZIzdqactruq0PJXP9SM4PQkYOZUrlZd2cypR9WzIaT8
         4e8F8dKDJzLiPZFTifQI53szRQL+O2md4i0SPH0KmTg8ZTwndT59MGEDmBPs8y03fg4B
         F/LSSDTfj1zWEHcxC2P7RwH8R7CNRlUbaR/Ux3+Yu8OxkMuLyIWhZwzeGMO3kwhe1bFy
         ABTjdHtsDVj+F561/qjZaXytwDHbLN3BiYgvFIwOoylPL8KSrZZgJle8Jg1fnnv/5W64
         hJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399558; x=1715004358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryk8Yjnwcb/TeAS/NSYC6eu7KpbQ2RMUyBm2Fm6rA9s=;
        b=uqzYzUoNN++JyY0BQ6b/Kci3sUb/oZ4dStOVikEZsPbx7iOT0IWhVLTLpEkmdHdrJX
         mPerwhczouSIDpRj7Nl2jHlGDiGQNQhJqdWwb2d09PTPB47+SkG71ASewQFzkuPE8sbe
         V1z7S7X4U0ml92MyU11q2Kgaxpr9NNCg9/7wHLjx3n6GFx3yvgP9tX4d8se2YW1Hzviw
         xs2rjrbDQmVTSDlyigIGXgT4ldid0r9SPfx9psC0G6loDRH+1NIOI4JLzZEgn2f4U6Ck
         8AHNhfzB9mLjc+4jocqu0mlsPcQapCoEAjyn8povmNQ5ND674pJNLEUNO19nWAMBGqAF
         iC8A==
X-Forwarded-Encrypted: i=1; AJvYcCWdyXCV//sUZJMye3Bw99ButbknuqQZbP0LLL+jfRCP7+RHri2wJxrCJzAzP0tuRrweRWVfWu+HLFhCuPeG384zdixruI78wuYVuz6I
X-Gm-Message-State: AOJu0YzypTOvoYx2k+rZZmp0Znwc6HwV/ArsaKii3eTKGAEcg94yIpIf
	+TVJ+8VgkptEPi2CeQ7i2Ot/+DzmG8nNibnzk87IxtSscLS8T1o+xB4lTZXKRDg=
X-Google-Smtp-Source: AGHT+IHXIApKuUwmhZVbv+qbGSSWrutGduBAYZPG18WJ+SF5X8KY8BLp8xAT7YhpWiZQaddV7NhglA==
X-Received: by 2002:a2e:be08:0:b0:2e0:2661:77fc with SMTP id z8-20020a2ebe08000000b002e0266177fcmr3590162ljq.39.1714399558442;
        Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
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
Subject: [PATCH 4/6] cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
Date: Mon, 29 Apr 2024 16:05:29 +0200
Message-Id: <20240429140531.210576-5-ulf.hansson@linaro.org>
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

When using the hierarchical topology and PSCI OSI-mode we may end up
overriding the deepest idle-state's ->enter|enter_s2idle() callbacks, but
there is no point to also re-assign the CPUIDLE_FLAG_RCU_IDLE for the
idle-state in question, as that has already been set when parsing the
states from DT. See init_state_node().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 782030a27703..d82a8bc1b194 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -234,7 +234,6 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
-	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
-- 
2.34.1


