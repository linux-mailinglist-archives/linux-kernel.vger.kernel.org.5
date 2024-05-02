Return-Path: <linux-kernel+bounces-167016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161748BA371
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD891F21F29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8A1BC2F;
	Thu,  2 May 2024 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K6Ai+sun"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8931B810
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690028; cv=none; b=GOjC3/5lChOtQJt9sDxm8J8dVEqvMD3NHvp68xV/wfWdpalQhRSW2Zily6no04ro46e3lAnjD/0g4ihD3I+kdOoTNUfYEMiAzhVLXk4MX44LXzjdH7QNTKGj9xhBau9pqnKStHCFLwIrHw4c/EM1N3FA84guUossMEtEpNpbAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690028; c=relaxed/simple;
	bh=2tw3VT8n1orAAjB3CDexaTWdNy5Mymq5X/M0Bx7NKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0YzIezzvlUMpc+tI5yx0LPVthe1lme6JZaxK8DhCiBjj2R1PqHRAR5LJrYJ9p+90dTOASXyoqBrW4BTIqAwRywhIaLWV0tvZwiPJ5Yc40Zf0DN01J6ocsvyMmiIJyVLKr0le+Mwdm21SbkF5cNNSoZVUSQ9qADDnxQtVxN+Otg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K6Ai+sun; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so881919a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690026; x=1715294826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oB2+xL5MYPNEv+1SgDj7qGyBlX4a2YStkU8fToDeblY=;
        b=K6Ai+sunWuAHNB2PJxiRC7PyDnm8TZlOK44sKvGCPNU+buGvsuXO1PsBwdUh6I6mt1
         1jWzBU15rAae5l+yDKUdNMtUHc1WwbR05JIt12h2T5iVy+qhz41wzneGgUrnnIm/9Lav
         hduTg14OaJHJRNJCaWCIXZZPH+HiI9DOtXeaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690026; x=1715294826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oB2+xL5MYPNEv+1SgDj7qGyBlX4a2YStkU8fToDeblY=;
        b=IaEXY3RzAb1cFx/Z5de6Y0czQk7b8VDhfnFLpMq5ze1MS6leoNN+U0mVySkTEZfELL
         uoYW+HZE8mW2BF8dpUT8af7fSH/Cq4TUIAFAuOHaAa0EfhJHPJhTKjfIj+P2cRRgn//Y
         aAL9cObWXZgE1YXpx5Y8k75M/m7yym+GDzsSVXpnFjfsbyJIivcNDJVojpw3ggJU1Hlc
         OQmSh6KfpQDOrjxwmk6JDpg65qcJ0H+3AnMIRs8+2ipw2X8E/aLapnYNZ/KiDKHTxzjp
         n8vn6Im7jfr2e+w/MXKG8V2uu6e9Pv0R0ehMsGCnn3pIumYf5YzUft1EEEyjZ9KFTppe
         bUJg==
X-Gm-Message-State: AOJu0YyLmpaziMQqRDzFwQcb1cxtGC7TFz42oLU+0ttHiwS+kLvd2Yv+
	aRndEsKEzqbBOJDQJQ8iGN2G5XnEhskDzUTTsU+KiEm8U/0a1PpKUU3fu0CA4g==
X-Google-Smtp-Source: AGHT+IGACaC3M2PrjA0vgHZvQExpouOsAMlbJCDZZtD9hv36DwR+sh+0v1lxRfQ848vjoAH/UvdPEA==
X-Received: by 2002:a17:90a:b82:b0:2b2:7c65:efa0 with SMTP id 2-20020a17090a0b8200b002b27c65efa0mr1306815pjr.26.1714690026365;
        Thu, 02 May 2024 15:47:06 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id p8-20020a170902780800b001eab1fb1093sm1899562pll.102.2024.05.02.15.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:47:05 -0700 (PDT)
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
Subject: [PATCH] clk: qcom: Park shared RCGs upon registration
Date: Thu,  2 May 2024 15:47:02 -0700
Message-ID: <20240502224703.103150-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
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
due to static initializers. If a driver calls clk_enable() before
setting a rate or parent, it will set the parent to '0' which is
(almost?) always XO, and may not reflect the parent at registration. In
the worst case, this switches the RCG from sourcing a fast PLL to the
slow crystal speed.

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
chromebooks. What happens is that the bootloader leaves the
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
can't because the GDSC has wedged all the clks associated with the GDSC
causing clks to stay stuck off.

This leads to the following warning seen at boot and a black screen
because the display driver fails to probe.

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

Fix these problems by parking shared RCGs at boot. This will properly
initialize the parked_cfg struct member so that the parent is reported
properly and ensure that the clk won't get stuck on or off because the
RCG is parented to the safe source (XO).

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

This is an alternative approach to [1] which doesn't require any hacks
to disable clks during driver probe.

[1] https://lore.kernel.org/r/20240327202740.3075378-1-swboyd@chromium.org

 drivers/clk/qcom/clk-rcg2.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 5183c74b074f..b9f2a29be927 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1138,7 +1138,39 @@ clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return clk_rcg2_recalc_rate(hw, parent_rate);
 }
 
+static int clk_rcg2_shared_init(struct clk_hw *hw)
+{
+	/*
+	 * This does a few things:
+	 *
+	 *  1. Sets rcg->parked_cfg to reflect the value at probe so that the
+	 *     proper parent is reported from clk_rcg2_shared_get_parent().
+	 *
+	 *  2. Clears the force enable bit of the RCG because we rely on child
+	 *     clks (branches) to turn the RCG on/off with a hardware feedback
+	 *     mechanism and only set the force enable bit in the RCG when we
+	 *     want to make sure the clk stays on for parent switches or
+	 *     parking.
+	 *
+	 *  3. Parks shared RCGs on the safe source at registration because we
+	 *     can't be certain that the parent clk will stay on during boot,
+	 *     especially if the parent is shared. If this RCG is enabled at
+	 *     boot, and the parent is turned off, the RCG will get stuck on. A
+	 *     GDSC can wedge if is turned on and the RCG is stuck on because
+	 *     the GDSC's controller will hang waiting for the clk status to
+	 *     toggle on when it never does.
+	 *
+	 * The safest option here is to "park" the RCG at init so that the clk
+	 * can never get stuck on or off. This ensures the GDSC can't get
+	 * wedged.
+	 */
+	clk_rcg2_shared_disable(hw);
+
+	return 0;
+}
+
 const struct clk_ops clk_rcg2_shared_ops = {
+	.init = clk_rcg2_shared_init,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
 	.get_parent = clk_rcg2_shared_get_parent,

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


