Return-Path: <linux-kernel+bounces-106053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA3187E864
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97727282A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C67364CD;
	Mon, 18 Mar 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT9X8kJt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4E2D043;
	Mon, 18 Mar 2024 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760804; cv=none; b=qIH7gwyOCWtrFMYo4Xd7FOUsrEKc9Wk1dvY8qtM36iE3SvzJj4MJk+BwC96KN56w6HSjm7GEclXyXCdW8XXVKrsR3Vh8vFnF++jLOjz8lftdanYXZ5s7dA3crs7In2/MJqINMtvtJxxRy+edxlAGLhA4K7ztjYEVkuzkWJmHTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760804; c=relaxed/simple;
	bh=BqJofWzBZ49ZnhpiMHa0n+HH/iMa54LnUvfzH7cFXIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y+c5/7y4rPU7wr7myhVXuumo06uZs0O5KPlfheFcz0G3AJbE6H/hmNJ4RXXdgeQejcf45s8/Dxk/ONhARGE3hmohbsFHZG29g9JBxmrIHqv3w8izPKeSJ5anJ5Wr74MIKczkEVFrpDte2NnrAR2ZR+DfXsEreju1P6O5rxYHtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT9X8kJt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512ed314881so2878540e87.2;
        Mon, 18 Mar 2024 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760801; x=1711365601; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQx6cVe56Px3+YlHXZYmXT77wEkrjM+Ro9npnPmCVyo=;
        b=LT9X8kJtbIb6D/xn8IgCFgFfoA80B+B6j/my1xgOz67ye1JvbV6xLwhuUPcaEulgg4
         ksEmZyka1eo7LojBHsxPjyM2AODR9crj6L+Kpj3ok35HlgR5lZkceP4aD9VnmiQ10DlS
         5UwWZqQrqyfKOlCiWGR2ArUFpKT05KLjIiRgi/QcO/6z6HZJWNYs/n6Ot3ehsr6Zsgos
         sALEHXzGXJr0JtrmDtkyXPepVF/pqbjb4UVrj1C18y2umPD3EwmSWNeLss2q7EgaN5YJ
         i1euSAUbt4ifnxIixpuonAB2zN5XA6RwF9mXqyPbSwb/mNjTe0h3bAh2wUjyKbjh3PzB
         /YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760801; x=1711365601;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQx6cVe56Px3+YlHXZYmXT77wEkrjM+Ro9npnPmCVyo=;
        b=AICzQjPWYA0AlkwSvQvO/R/2QIwS/nT9IaSwq3bXfPtoEdBLzMbtUroApqgWSJmr7b
         GrhTWlFZsll6p2aHNE+1ZVwsTWrmSxjZ3VGcpN1qovjdHz2w3SQLaypB7zu82vL+Tdh+
         X1AwDiuAdzmARyQgWl/mQytwTEMSl4YNeOwAlViE8XHalZ//XSPq5KCeRCNCWD7a4qD4
         eLNV6nOiEoq5DOMyRhvV5YfdFINtDHYmfNat73Ij2fPXqIe4YKvOa8w5hIZ2cDyRu6FD
         4xSwPw7Mh9mfIc/UNHNlVVEdHH9lavfJiL470gzKdCw47csO0hi3bDbgipQ3kZd8fk4p
         ttSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5181hFmO1awXBnFsjAi/tL6FFmgF8ANri6y1rHry0RvRfzboUdcZXUya0t4eJulSVOe4NlCW8KaE+ArwfTxLV8ptYcyRLj0LKu1SpA0Hnkm0yxdEu7ibxwkr/97NJeEhvcQkMCoy9
X-Gm-Message-State: AOJu0Yy7shC+efWvukVlTXe0MzpCr4eK5h45SniYJceQBMSvE1Jl0oJz
	4wKfsbsk5+CBaCq3jFS3Qs42dSfNdUYUL/QAMCi5KEtsJT0uOqKs
X-Google-Smtp-Source: AGHT+IFfwoIV5QQ7JwOWuzu5wAgYOBzxBaVbW5H7m2JiJzcJposCtLyphnpBDv1c8nwrpjlEy/GVgQ==
X-Received: by 2002:a05:6512:3d88:b0:513:a833:cda2 with SMTP id k8-20020a0565123d8800b00513a833cda2mr9268859lfv.53.1710760801141;
        Mon, 18 Mar 2024 04:20:01 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm6650421wrb.62.2024.03.18.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:20:00 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/5] clk: qcom: apss-ipq-pll: various cleanups
Date: Mon, 18 Mar 2024 12:19:54 +0100
Message-Id: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFoj+GUC/x3MTQqEMAxA4atI1hOw/oCdqwyzCJpqoNRMw4hQv
 LvF5bd4r4BxFjZ4NwUyH2Kypwr3amDeKK2MslRD13ZD27sRSc1Q9IcaI86RKf0VybH3FPwyjQP
 UVDMHOZ/t53tdN2NMnIJmAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

This series contains a few patches to perform some cleanup in the
apss-ipq-pll driver.

The set is based on v6.8 and it depends on the following patches:
  - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
     Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
  - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
     Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (5):
      clk: qcom: apss-ipq-pll: reuse Stromer reg offsets from 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: use an 1-D array for Huayra pll register offsets
      clk: qcom: apss-ipq-pll: remove 'pll_type' field from struct 'apss_pll_data'
      clk: qcom: apss-ipq-pll: constify match data structures
      clk: qcom: apss-ipq-pll: constify clk_init_data structures

 drivers/clk/qcom/apss-ipq-pll.c | 70 +++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)
---
base-commit: 9b65bf93985e8bd5bc5476beef59ba56f3f99697
change-id: 20240315-apss-ipq-pll-cleanup-a1e99af9d854

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


