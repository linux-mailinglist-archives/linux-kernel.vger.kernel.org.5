Return-Path: <linux-kernel+bounces-162416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC28B5ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E2A286D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8197BB13;
	Mon, 29 Apr 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5Itbw1P"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77F762DA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399556; cv=none; b=ZE3OezdsphSsjgCKDrL3YykEhDSOvqr88usKV5vJk0BPn4+pNH+bOh/0d4gy8hf6v0Jwy2w+GUHqxESvUoj3goew1n8cs1OMZm8uf9jHO/mBnY1znmtIy5c7FJ+8Agk+QiYNatk8vng3pGR25ifc1f5CRcNx9KWyaPVvFeaUX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399556; c=relaxed/simple;
	bh=Uf9ddhEBMCM/OlaEb7CTzNoTY6fpHPR3X42S1b/KeT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKETqlJHIiO5fAuN4TB5kJMpBz2jDeTQX2gUcGLsMTA3snukAEBFo2+ZBO5EoQ931hVIlbExmx9EcmVeU2O+kwvdivYSI9nEGirFLaIMEfr1VDBCNBTlg3RLGIDzO5qRoOS4/ihEuLoFfYeb33ClNBEsueUNDAquFx85YTXTm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5Itbw1P; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso34012301fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399551; x=1715004351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXJMGZU5gWJajF1DAzW8nc/IcTR1txmF3L1/3ROYhek=;
        b=D5Itbw1P1NBmUpFO10twp0nncx6lGHp36H83ra6rvujpSaPPDKnRhxdAts5LwIMMYr
         SuPBDb97ici9jxQfwgrrqBCXtMpCH+sQQjr6ghCO/NTTlpHB3vtFo8c98Iu13oid4iH8
         94N/17OLYNSLQCYPUGDZO4EkmdQXb9ZNrDgprLQhLzbacgkAIxURc8iLSqmvIdp+OHCZ
         Rh3PD+E3XG6wevU51XUQZ+lLoPDS447axOw81uHXSZt4zH8Kh8N67OuCk31FxyR/Ue9+
         H60kN2QdrYyXij+N8pm6VDf9JkPtQD9CunuV1m2P0Ij9RQf4GA6ES9O3Zi85+vEaWg0h
         aNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399551; x=1715004351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXJMGZU5gWJajF1DAzW8nc/IcTR1txmF3L1/3ROYhek=;
        b=iCJC7iTAGdkD9oukmI3sS6svs3dTFmRVkkWIIL3nWyqRVNH1dXfKz1vHeMUXN/xeLr
         pb/3Uc6Bv14aQi8BWWTHtr1wL6ooFZ32xUosXLXfg963vpxJgfyS3zEeQXlbv62gpVat
         am2Up5Zme3a6VNlHG67cZsA0vM+KeL9dsxZjahPnMA9buM7L/GMk3+C60k0dArRcem+Z
         xacO5bi327HLBRlEthptYDA1Jc4D79y4pFjB6G26/sB6Wpi0yKsSuAeiX+zvhCahtKAo
         bmcpJM99pt+Luk7o1CeYviu6uX4nLDSWYd9yhPzv1QBOKCLr8WJvo2S/2YH51+hNRhKc
         fz+g==
X-Forwarded-Encrypted: i=1; AJvYcCX5FBiNLPcdzcza2DKtuhJG9QDZbgQtHgfnDpjPiR8nogMiFf0CHTqzePJnunVsqmVGjPLlJHec8oYN7nh5rSVpPqX2Q070CTkSY7EE
X-Gm-Message-State: AOJu0YwWPdNSXy21Ruar5risz8QWvXCfBn7smdztKoB2xcSrnD68HPrv
	YvfSyd64TZdHbMgIZ0HmM3m0hx6LUlXH1GME80EgY93NWAp7/ZFEBtHZA2iMibw=
X-Google-Smtp-Source: AGHT+IFUjAW34oQS8Y+fnyeVdUbDkDis1iigpkrMI5QToMUOQcc8rZfl2WurAe5k4jfFMqtb5cerlQ==
X-Received: by 2002:a05:651c:2107:b0:2df:dea1:5378 with SMTP id a7-20020a05651c210700b002dfdea15378mr6030267ljq.16.1714399551361;
        Mon, 29 Apr 2024 07:05:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:50 -0700 (PDT)
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
Subject: [PATCH 0/6] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:25 +0200
Message-Id: <20240429140531.210576-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hierarchical PM domain topology and the corresponding domain-idle-states
are currently disabled on a PREEMPT_RT based configuration. The main reason is
because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
genpd and runtime PM can't be use in the atomic idle-path when
selecting/entering an idle-state.

For s2idle/s2ram this is an unnecessary limitation that this series intends to
address. Note that, the support for cpuhotplug is left to future improvements.
More information about this are available in the commit messages.

I have tested this on a Dragonboard 410c.

Kind regards
Ulf Hansson


Ulf Hansson (6):
  pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
  pmdomain: core: Don't hold the genpd-lock when calling
    dev_pm_domain_set()
  cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
  cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
  cpuidle: psci: Enable the hierarchical topology for s2ram on
    PREEMPT_RT
  cpuidle: psci: Enable the hierarchical topology for s2idle on
    PREEMPT_RT

 drivers/cpuidle/cpuidle-psci-domain.c | 10 ++++--
 drivers/cpuidle/cpuidle-psci.c        | 26 +++++++++-----
 drivers/pmdomain/core.c               | 52 +++++++++++++++++++++++++--
 include/linux/pm_domain.h             |  5 ++-
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.34.1


