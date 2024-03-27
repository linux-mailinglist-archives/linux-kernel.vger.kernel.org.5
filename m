Return-Path: <linux-kernel+bounces-121975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9FC88F015
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F59B232B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317B153560;
	Wed, 27 Mar 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvpuxGVa"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315E1534E9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571269; cv=none; b=GBhc8LBX+R0N+dyzc0GTNURo/L1IELPIqs4bvGvmo3rAm/gvxt4As2/NVadqgk7AhG1L8+pJa2c2L3oYIamb0qwUabENe74wp/9PYS3lHTTysyEZGK3Zlir99k66dWQ8knuS7Py77klB2Gr1E7lE03955M5bKnAACr4aGnKkdKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571269; c=relaxed/simple;
	bh=XlLrWtTmg8s6/XeVCQZ9E5GXfb4dRX9E/Mp5HjCCdVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2/aD4mNRuQpQOimqi8XPMZoOmwP+fyoavjYQIaTXu6Kdjd2T3A6OfkRNvxs5XnP4u48WV1wo8sfPzw+fx8rQ5h54erlMYrfCFNQmLunYfP1Is62W2Yzj2mtoXlvCW4aSSM2npYAUfXAHK0QW9p9nZUEotfzlCx1FV9XBbcJz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gvpuxGVa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so270771b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711571267; x=1712176067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlQlD7myWbCJBZn4zLaj3UQ5LgDpgVdZ5/7RcoFhMMk=;
        b=gvpuxGVaHElUanW7cbHo1rE/Ey38pNklRGI4ge2eHGYcNOd8PmksDnhIU9wMQp8rAG
         w0IM8ZJAjxd559ezNWlQG1ZlOJXzPOWnEMc3wt+x5sOiuEPZAeAm7c0YOuTiqgpDymJV
         XanlG903bbsWTcnqCHe37NpqvJBa/LGXeKTz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571267; x=1712176067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlQlD7myWbCJBZn4zLaj3UQ5LgDpgVdZ5/7RcoFhMMk=;
        b=BJPlg3eMDQgnwkJHK3BMhvBHsvf8tCVMmd+9WX5XmWfiPqJOmgujF1VhvFMAkrTNek
         Fe/r8QdkM/sMQvWF+w0C4+Pe0jisUewlJbJE5iZmo8JDLd5vu7uL47xOqV90pV/ukCST
         UKD2F6ZH+wgrIWjSZyGbc8qR3U9didLylzejMboXrhbIRYaOWST7+0MQdtvzcV0Flgcx
         n6dywpKrt4rQsZ0DdqNnyRhQwRS1GEXizjf9XMbXwYl2i4+xg/16/muHtV4ZVdFkSWu1
         Pkkmd/tWBRugi4K7NcD8NXa/UAj9HIpotilW5t4jkvoOMe9pHMLKigbZKvxZ/38L+mGg
         OVZQ==
X-Gm-Message-State: AOJu0Yzc5YL411pfwcHxWEuLiRhaZHtTVI/7zWqgxeFHaEy22mIIMsN2
	DQQR1jvVczC5ykbR1/jplWAo2BhoyZfj3cQ9LlScaoa1SdzcxCTolwb6RZSuhA==
X-Google-Smtp-Source: AGHT+IFZUfMHq9peOune+htb5ZoHYhdcO8/RJ3COKKB5hswynLS0DibaW32eMRntBRlKzrHvHeFAuA==
X-Received: by 2002:a05:6a00:3cd5:b0:6ea:baed:a136 with SMTP id ln21-20020a056a003cd500b006eabaeda136mr1128489pfb.8.1711571267067;
        Wed, 27 Mar 2024 13:27:47 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id y8-20020a62b508000000b006e319d8c752sm8234371pfe.150.2024.03.27.13.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:27:46 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH 2/2] clk: qcom: Properly initialize shared RCGs upon registration
Date: Wed, 27 Mar 2024 13:27:38 -0700
Message-ID: <20240327202740.3075378-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240327202740.3075378-1-swboyd@chromium.org>
References: <20240327202740.3075378-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's two problems with shared RCGs.

The first problem is that they incorrectly report the parent after
commit 703db1f5da1e ("clk: qcom: rcg2: Cache CFG register updates for
parked RCGs"). That's because the cached CFG register value needs to be
populated when the clk is registered. clk_rcg2_shared_enable() writes
the cached CFG register value 'parked_cfg'. This value is initially zero
due to static initializers. If a driver calls clk_enable() first before
setting a rate or parent, it will set the parent to '0' which is
(almost?) always XO, and may not reflect the real parent. In the worst
case, this switches the RCG from sourcing a fast PLL to the slow crystal
speed.

The second problem is that the force enable bit isn't cleared. The force
enable bit is only used during parking and unparking of shared RCGs.
Otherwise it shouldn't be set because it keeps the RCG enabled even when
all the branches on the output of the RCG are disabled (the hardware has
a feedback mechanism so that any child branches keep the RCG enabled
when the branch enable bit is set). This problem wastes power if the clk
is unused, and is harmful in the case that the clk framework disables
the parent of the force enabled RCG. In the latter case, the GDSC the
shared RCG is associated with will get wedged if the RCG's source clk is
disabled and the GDSC tries to enable the RCG to do "housekeeping" while
powering on.

Both of these problems combined with incorrect runtime PM usage in the
display driver lead to a black screen on Qualcomm sc7180 Trogdor
chromebooks.  What happens is that the bootloader leaves the
'disp_cc_mdss_rot_clk' enabled and the 'disp_cc_mdss_rot_clk_src' force
enabled and parented to 'disp_cc_pll0'. The mdss driver probes and
runtime suspends, disabling the mdss_gdsc which uses the
'disp_cc_mdss_rot_clk_src' for "housekeeping". The
'disp_cc_mdss_rot_clk' is disabled during late init because the clk is
unused, but the parent 'disp_cc_mdss_rot_clk_src' is still force enabled
because the force enable bit was never cleared. Then 'disp_cc_pll0' is
disabled because it is also unused. That's because the clk framework
believes the parent of the RCG is XO when it isn't. A child device of
the mdss device (e.g. DSI) runtime resumes mdss which powers on the
mdss_gdsc. This wedges the GDSC because 'disp_cc_mdss_rot_clk_src' is
parented to 'disp_cc_pll0' and that PLL is off. With the GDSC wedged,
mdss_runtime_resume() tries to enable 'disp_cc_mdss_mdp_clk' but it
can't because the GDSC has wedged all the clks associated with the GDSC.

 disp_cc_mdss_mdp_clk status stuck at 'off'
 WARNING: CPU: 1 PID: 81 at drivers/clk/qcom/clk-branch.c:87 clk_branch_toggle+0x114/0x168
 Modules linked in:
 CPU: 1 PID: 81 Comm: kworker/u16:4 Not tainted 6.7.0-g0dd3ee311255 #1 f5757d475795053fd2ad52247a070cd50dd046f2
 Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : clk_branch_toggle+0x114/0x168
 lr : clk_branch_toggle+0x110/0x168
 sp : ffffffc08084b670
 pmr_save: 00000060
 x29: ffffffc08084b680 x28: ffffff808006de00 x27: 0000000000000001
 x26: ffffff8080dbd4f4 x25: 0000000000000000 x24: 0000000000000000
 x23: 0000000000000000 x22: ffffffd838461198 x21: ffffffd838007997
 x20: ffffffd837541d5c x19: 0000000000000001 x18: 0000000000000004
 x17: 0000000000000000 x16: 0000000000000010 x15: ffffffd837070fac
 x14: 0000000000000003 x13: 0000000000000004 x12: 0000000000000001
 x11: c0000000ffffdfff x10: ffffffd838347aa0 x9 : 08dadf92e516c000
 x8 : 08dadf92e516c000 x7 : 0000000000000000 x6 : 0000000000000027
 x5 : ffffffd8385a61f2 x4 : 0000000000000000 x3 : ffffffc08084b398
 x2 : ffffffc08084b3a0 x1 : 00000000ffffdfff x0 : 00000000fffffff0
 Call trace:
  clk_branch_toggle+0x114/0x168
  clk_branch2_enable+0x24/0x30
  clk_core_enable+0x5c/0x1c8
  clk_enable+0x38/0x58
  clk_bulk_enable+0x40/0xb0
  mdss_runtime_resume+0x68/0x258
  pm_generic_runtime_resume+0x30/0x44
  __genpd_runtime_resume+0x30/0x80
  genpd_runtime_resume+0x124/0x214
  __rpm_callback+0x7c/0x15c
  rpm_callback+0x30/0x88
  rpm_resume+0x390/0x4d8
  rpm_resume+0x43c/0x4d8
  __pm_runtime_resume+0x54/0x98
  __device_attach+0xe0/0x170
  device_initial_probe+0x1c/0x28
  bus_probe_device+0x48/0xa4
  device_add+0x52c/0x6fc
  mipi_dsi_device_register_full+0x104/0x1a8
  devm_mipi_dsi_device_register_full+0x28/0x78
  ti_sn_bridge_probe+0x1dc/0x2bc
  auxiliary_bus_probe+0x4c/0x94
  really_probe+0xf8/0x270
  __driver_probe_device+0xa8/0x130
  driver_probe_device+0x44/0x104
  __device_attach_driver+0xa4/0xcc
  bus_for_each_drv+0x94/0xe8
  __device_attach+0xf8/0x170
  device_initial_probe+0x1c/0x28
  bus_probe_device+0x48/0xa4
  deferred_probe_work_func+0x9c/0xd8
  process_scheduled_works+0x1ac/0x4dc
  worker_thread+0x110/0x320
  kthread+0x100/0x120
  ret_from_fork+0x10/0x20

Fixes: 703db1f5da1e ("clk: qcom: rcg2: Cache CFG register updates for parked RCGs")
Reported-by: Stephen Boyd <sboyd@kernel.org>
Closes: https://lore.kernel.org/r/1290a5a0f7f584fcce722eeb2a1fd898.sboyd@kernel.org
Closes: https://issuetracker.google.com/319956935
Reported-by: Laura Nao <laura.nao@collabora.com>
Closes: https://lore.kernel.org/r/20231218091806.7155-1-laura.nao@collabora.com
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/clk-rcg2.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 5183c74b074f..a150b4317d6f 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1138,7 +1138,26 @@ clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return clk_rcg2_recalc_rate(hw, parent_rate);
 }
 
+static int clk_rcg2_shared_init(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* Initialize cached cfg so the parent is reported properly */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->parked_cfg);
+
+	/*
+	 * Clear any force enable of the RCG from boot. We rely on child clks
+	 * (branches) to turn the RCG on/off in the hardware and only set the
+	 * enable bit in the RCG when we want to make sure the clk stays on for
+	 * parent switches or parking.
+	 */
+	clk_rcg2_clear_force_enable(hw);
+
+	return 0;
+}
+
 const struct clk_ops clk_rcg2_shared_ops = {
+	.init = clk_rcg2_shared_init,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
 	.get_parent = clk_rcg2_shared_get_parent,
-- 
https://chromeos.dev


