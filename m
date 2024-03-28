Return-Path: <linux-kernel+bounces-122679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C988FB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B49E2947A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7017D40D;
	Thu, 28 Mar 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URF+LCSK"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE17CF34;
	Thu, 28 Mar 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617813; cv=none; b=WHZB+Lbo6aSUmtkZLBcaR7wlLC+UCQBu0+B0KHWbq4bBQw7zraCAfk4NJ/Lwq2bMtu9fHFwbBwxiXfKBUTwKxNNGgGgvpgI8+HqkNSi8RglEl6SXgSYGtapeTkEaV+lKvoLp0kVEoc3LpMEvxShiZzYwxLbD3+3StGswkLCo2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617813; c=relaxed/simple;
	bh=msboZSvAs3rKXrzoZpAC3lNr3u77Vxq32R9YL+VRzhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgZFbt+C/fWdF9hHwwTRwep4TlZGc04rbmhMESqiPG1X0CaRtiI9vPE08PQ5RE5Z03mw5SlhhL6JyyxZBt2QY+zmkDPRnKZl2qfVPktnqcZfo6tiFFlNcj5p59PYP9RQmB0LDjLmu8T7MmM6cjKaBfZJKBoRN3pdV6AiHUBcVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URF+LCSK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513da1c1f26so769288e87.3;
        Thu, 28 Mar 2024 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711617809; x=1712222609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kERrctOxilteq7B+FoyyzfQy4DSZnPiyIPJxR2jkj8w=;
        b=URF+LCSKxftUetYZKXuTNUWPC/onPjTkfWEGTNpjt6GsiWU+f2nFdJjjfZpnIyjRei
         VY0rEycjF9sDAhcBzv0EBCeWEQ0GIMr9f2rbEj6Op6Dujy8TDxV1bUvjg3Y+PQbENB8e
         P7oYLJSBKhDpcH3s/tj2PSSmBG962tKuWvhLabnG5jaRZhineVFGxhvJk4dPnU1j7smj
         uTClxIdTtgPEB2XyLjKeVZVc8knmEIJF/6VPPPX7nm1yZIJu83LEaX9uTOhfoex43Ap4
         RInzu8jTzUydyaWb7Ki4LaVTdapqKgZJfIVNi+xHpPM0Mku3y9LtCWStAzjqpCvS+s7G
         SNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617809; x=1712222609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kERrctOxilteq7B+FoyyzfQy4DSZnPiyIPJxR2jkj8w=;
        b=gm9iTk5x5DSXQJfb2cvRXJtjI1RG+R0DTDF7vbzGQ+PN1K8LA5lxZJ1hzHfCJIiQq8
         NHuVsGlnsop5KP8k/uJeIKiUNiYoNQDhSvinvMjpQ13Ho/EgWcg7kCzuhxtT+eqlV/dp
         TPuMiGyxPX0TEI1pB1KkPAj2dB1CJzp1og25rS19zfv/Q74zPKCJsQ5XCzaJEkt5yLKP
         TEOVhBnGdhdycWU+p+pU1K2jG92oD+23Z7vWiVrloBot7Ll2dYdCrx3ufU9/LRfrL8/T
         fInXEpYpoX7tQXgFd5x4q6bSQPNHZPZWmIUUsnPE+yB8SwtlHXjDZsTjd4kCRr894d5y
         IBhA==
X-Forwarded-Encrypted: i=1; AJvYcCWPY1Wk2VccSVwjZKn2tdvVERUbPKE3l9XTN/T/Q5W9dpzRlAzAJXNqSILFt3M9U4ap3yxFSPsCfJDXBDQL/1U9WdPS+yrLiN3oXs8C4eK16fwVggDW/JFUkswKHuJDfwIrSvePgVjX
X-Gm-Message-State: AOJu0YzUUJ3/1qAHFsfhlspbFBRqM+Z5hKMI+7q9hF0C9HhldJNdd7rh
	2t3jkwc84CC+ZmqeIb1L/+0S6APJ6nT+Ng886Xim5p1v/ETgnIoL
X-Google-Smtp-Source: AGHT+IG4zlQLJnWJsl2FO8//XHxrNRk0QG7sBNC80UpYkSaXvWEHz43jR5USDMaYqJMC92M1FaJJ/w==
X-Received: by 2002:ac2:52ab:0:b0:515:bbe9:f208 with SMTP id r11-20020ac252ab000000b00515bbe9f208mr1308454lfm.19.1711617808779;
        Thu, 28 Mar 2024 02:23:28 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cf2-20020a0564020b8200b0056b0af78d80sm609298edb.34.2024.03.28.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:23:28 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 28 Mar 2024 10:23:13 +0100
Subject: [PATCH v4 4/5] clk: qcom: apss-ipq-pll: constify clk_init_data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-apss-ipq-pll-cleanup-v4-4-eddbf617f0c8@gmail.com>
References: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
In-Reply-To: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

The clk_init_data structures are never modified, so add const
qualifier to the ones where it is missing.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
 - no changes
 - Link to v3: https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-4-15c4aeeb14ac@gmail.com

Changes in v3:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tags from Dmitry and Konrad
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com

Changes in v2:
 - no changes
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-5-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 191b87df51bb..1a6f4db25379 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -15,7 +15,7 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 	.clkr = {
 		.enable_reg = 0x0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "a53pll",
 			.parent_data = &(const struct clk_parent_data) {
 				.fw_name = "xo",
@@ -55,7 +55,7 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	.clkr = {
 		.enable_reg = 0x0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "a53pll",
 			.parent_data = &(const struct clk_parent_data) {
 				.fw_name = "xo",

-- 
2.44.0


