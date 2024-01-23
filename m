Return-Path: <linux-kernel+bounces-34994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AF838A40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C21C25E69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8B59B4C;
	Tue, 23 Jan 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="Mo9m6cFH"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E545A0EB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001986; cv=none; b=WFqHIDdAXkl4Br7Yi3e3antbNPlx/V9SF+OFGCP9ThTTvVpJzcxO5T+VrOnKTQiguTPXJTW2WbBZURa0txN4IMGeXOJYMfyrVDiNW3n1ZSa3C+5VH+tjsau8eykdG9LIRW158Gpo7hT0+xg1Tm+O0ln5t828R+wZcQUn9zsG4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001986; c=relaxed/simple;
	bh=d+ji7QeA2nW3W7Gc/Juv21P65TRJBRAPQQXq7yw1sK4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Wc24SXR5apgVwDP94DG+fHeq9qNlX7vHqc5rRVHOC/1ct6YakHZxy+NUbGnTXZOOAjg6rjMW6d7lJcXYOMH0UEScKD+SCmcHsoehZj2TjRiudDFxG6eCXrHhGZMybea3MIK+HaHHIfV/pIuIU6PvQ/WFAN+X2tOjhzfVUyFtJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=Mo9m6cFH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccae380df2so40601091fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1706001982; x=1706606782; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da3DB4fuctftgszn0IBbViUysDG4/tuurWVRkb8i9zc=;
        b=Mo9m6cFHbh35eG05TCpyBAw5nW41qjqpC2PHGpTUV62gpTfirKNHuGGX57dnsbSxJ6
         rdzKx50+iTtuPXWACg5yMTvg8Vf4vyuWD7zFL3LKC8y8+jNXgVGYt9iRFA6/HTQFFSMG
         QXY4qNy0EmOpuYrnAJ/sgQRS1ZxOzAqGHLBuf1ECqHLKn1fzH+y4NXO/CF7ZCUbdYrC5
         2kf7Ek0dd5oWHckGzNLJX10ckZ6EqyAuNHs3Ap3COduoZHw8jKL7GEfy0YzHs1jz9jJ9
         se0cZd0im6AkrHPppD9GNv0CAOdYVN6qMY89d4cKs1J0v+IcuTkBaLChg6QGqujR5F+j
         OhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001982; x=1706606782;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da3DB4fuctftgszn0IBbViUysDG4/tuurWVRkb8i9zc=;
        b=UQWGPgCSJHGFqZ8EQkxfkps62iMFSx+1srn+1a7gRVN/HcDEj1aBGQZluCm+yzj5XJ
         z4KGidnvNbmkymVnAjGKm3F3SnV8ABFmdLlo/yCiKsAnjwj5aSSqV0vYQOkKn9cVCox6
         rqwTxB08G6FcTUStTgb7xbwxkf6Og+sgAjfy+Q6jqsEu2sa/fHwuhivLuQlfUaCwnobY
         A/gG4GL0If4Bz1hnl7SQGrDZmPJjRwS1evRzAVa/Y1xgQoWpMKvUIrQJ7+hYpZ3dWdxd
         EGQeaFM5VplkdkNH4bjauHwq8tN0PKLQbbvpLa7l2NqvLZ5ZRy4VZvy75YIu8VWYQ3mZ
         bAGg==
X-Gm-Message-State: AOJu0Yw8TmNbq1/6Jt9F8txj1Z9U24x2lHL8Hp+HHBZVNYA/OjXDr4i0
	vizpOdPxcPKIaxjHt1MXyxqhca/L67CwsWskxS9ohUA2Iz2RCCo55Levn2wgesk=
X-Google-Smtp-Source: AGHT+IHI6Qn5P31tRVp9wkWdE0blQn6n0A5HtclN71tDiZKAJ3uAaQHsYm3HctwCzZ3l8O/L7QQpXA==
X-Received: by 2002:a05:651c:1c7:b0:2cf:2d0:2236 with SMTP id d7-20020a05651c01c700b002cf02d02236mr1278001ljn.105.1706001982001;
        Tue, 23 Jan 2024 01:26:22 -0800 (PST)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id q31-20020a2ea69f000000b002cf088cef55sm186679lje.55.2024.01.23.01.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:26:21 -0800 (PST)
From: Mantas Pucka <mantas@8devices.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Mantas Pucka <mantas@8devices.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: qcom: gcc-ipq6018: add qdss_at clock needed for wifi operation
Date: Tue, 23 Jan 2024 11:26:09 +0200
Message-Id: <1706001970-26032-1-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Without it system hangs upon wifi firmware load. It should be enabled by
remoteproc/wifi driver. Bindings already exist for it, so add it based
on vendor code.

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---

Changes in v2:
  Remove CLK_IS_CRITICAL flag
  Note in commit message that clock should be enabled by remoteproc driver

 drivers/clk/qcom/gcc-ipq6018.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index b366912cd648..cef787674479 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -3522,6 +3522,22 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_qdss_at_clk = {
+	.halt_reg = 0x29024,
+	.clkr = {
+		.enable_reg = 0x29024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_qdss_at_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&qdss_at_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_qdss_dap_clk = {
 	.halt_reg = 0x29084,
 	.clkr = {
@@ -4361,6 +4377,7 @@ static struct clk_regmap *gcc_ipq6018_clks[] = {
 	[GCC_SYS_NOC_PCIE0_AXI_CLK] = &gcc_sys_noc_pcie0_axi_clk.clkr,
 	[GCC_PCIE0_PIPE_CLK] = &gcc_pcie0_pipe_clk.clkr,
 	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
+	[GCC_QDSS_AT_CLK] = &gcc_qdss_at_clk.clkr,
 	[GCC_QDSS_DAP_CLK] = &gcc_qdss_dap_clk.clkr,
 	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
 	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
-- 
2.7.4


