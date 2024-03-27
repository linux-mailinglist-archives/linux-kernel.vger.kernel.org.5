Return-Path: <linux-kernel+bounces-121973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF388F00E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01CE296BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEEF15218B;
	Wed, 27 Mar 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UyyCT3Fh"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A914F9D7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571265; cv=none; b=LFycM9k01nNa3tVHL/0JTd1V7707hjC8r1TYtq5NckZpHjpiFF8UvkO79MfPnajbzFlXFgcBYgzzJQAiPxsnfWijJox43F2kIRQRdRbAIWEMovy63obCfPjdXPLZ/Oewwdz4SDVBZ2TLdlhj+t3IhHRzesaA/X7N7Pz6mhFfb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571265; c=relaxed/simple;
	bh=UAlyW1XBQGh1I1s4OhUVYVSvSBWjHao81V/7b/ey64s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKDnDkp0qEXqM/ivYJb1qt9Sj45PtlMfkPVhfxxWoaqexQXnF8/t5PJt13B3ULI8V+rI00NFapUkmHKyXli+mzmY6Fs/hIU4TIZYzb0zhDgUeBMP/2IxdFlE1Dfq8QY82Su+HVVy83oYMsG6amPelBmDZwaPylsuAm8hstC2oUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UyyCT3Fh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e704078860so298388b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711571264; x=1712176064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LCVHzKM95nxrye1cfXoHnsCw/TjZEQVmmlga0bm4uZk=;
        b=UyyCT3FhawgJwkSzxqzkwJSvoYbqqG2Elii0u1mUyG9X3kI0kfU7NSHJImc6evsGqM
         1i/wYv0XszdtcF4Ci4+3hvGGK4oq26rzS4Ro++CNiogjw9fejAgHB/CkOz41G+5f8Se3
         z9V/fgPojoJqal/z6AtKEh2omcAEHzECt/Zhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571264; x=1712176064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCVHzKM95nxrye1cfXoHnsCw/TjZEQVmmlga0bm4uZk=;
        b=uZlA8vyNEZMgAa7F8M/CsMzKICkh720Jsy1/JHEE/dJkQkhJYCQ+zxyrFHmrGROcQS
         6SKX1c4xxs/FwFIYvh+Qo7Ojhxfus2wRFvJNMgElMc5Tzs9DpAy6kujqzYMVueUr0NkM
         v062mW0EGRSpdLksDJdcsosioSwIHsqANHWtfz5tNq7yMz8LKWudIxQGg6InX5BhfLlF
         6usULAppA3ceZpZNFM78G6098yykfssk1LOfmoEEgPkIX3Ao9l71aMSsuITV31GF6t6V
         OWq19cYhkZZumeo0ihAwBzpT2GkRTu2GXk050c6xE5hzUth0n+8EHCCm/H4aMvj8ML1h
         pAag==
X-Gm-Message-State: AOJu0YzuGIP9H169F1taiYZY0uLz5TSLSMAg3+ZHg1S6RBlejgyJ5c99
	zcAWiSsy2VZVdLPz9vPk0Yx4YVh9BVFmSuKZPrBBHKNTcT0ulxjUXXc7EROqEA==
X-Google-Smtp-Source: AGHT+IHA1C7H1G9I13NxUAKmeyvwBUmBLxBfdkaCF4Xl43hsabFFNBcw1oAA9mmdxMEWX6SsZ2Maiw==
X-Received: by 2002:a05:6a20:7495:b0:1a3:683a:2cbd with SMTP id p21-20020a056a20749500b001a3683a2cbdmr1160699pzd.17.1711571263614;
        Wed, 27 Mar 2024 13:27:43 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id e3-20020aa78c43000000b006e56bf07483sm8303143pfd.77.2024.03.27.13.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:27:42 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 0/2] Fix a black screen on sc7180 Trogdor devices
Date: Wed, 27 Mar 2024 13:27:36 -0700
Message-ID: <20240327202740.3075378-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a black screen seen at boot on Trogdor devices.
The details of that problem are in the second patch, but the TL;DR is
that shared RCGs report the wrong parent to the clk framework and shared
RCGs never get turned off if they're left force enabled out of boot,
wedging the display GDSC causing the display bridge to fail to probe
because it can't turn on DSI.

The first patch is basically a hack. It avoids a problem where the mdss
driver probes, turns on and off the mdp clk, and hangs the rotator clk
because the rotator clk is using the same parent. We don't care about
this case on sc7180, so we simply disable the clk at driver probe so it
can't get stuck on.

The second patch fixes the shared RCG implementation so that the parent
is properly reported and so that the force enable bit is cleared. Fixing
the parent causes the problem that the first patch is avoiding, which is
why that patch is first. Just applying this second patch will make it so
that disabling the mdp clk disables the display pll that the rotator clk
is also using, causing the rotator clk to be stuck on.

This problem comes about because of a combination of issues. The clk
framework doesn't handle the case where two clks share the same parent
and are enabled at boot. The first clk to enable and disable will turn
off the parent. The mdss driver doesn't stay out of runtime suspend
while populating the child devices. In fact, of_platform_populate()
triggers runtime resume and suspend of the mdss device multiple times
while devices are being added. These patches side-step the larger issues
here with the goal of fixing Trogdor in the short-term. Long-term we
need to fix the clk framework and display driver so that shared parents
aren't disabled during boot and so that mdss can't runtime suspend until
the display pipeline/card is fully formed.

Stephen Boyd (2):
  clk: qcom: dispcc-sc7180: Force off rotator clk at probe
  clk: qcom: Properly initialize shared RCGs upon registration

 drivers/clk/qcom/clk-rcg2.c      | 19 +++++++++++++++++++
 drivers/clk/qcom/dispcc-sc7180.c | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Laura Nao <laura.nao@collabora.com>

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
https://chromeos.dev


