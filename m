Return-Path: <linux-kernel+bounces-60464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AF850547
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796C71C231FD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D55CDC5;
	Sat, 10 Feb 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="GCw4/z15"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D20B29;
	Sat, 10 Feb 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583151; cv=none; b=k1sUYCi9jhMtbav04W426gce0F37Bz4RU82wIvCBLYgkHYDnJvmeP0AK7qM+HQbahAcW46SmK52mGzz1RqM1IovLIYEFODcrfq0NxHHw4JtjK0sy0oCtGrda8Gl07c2CU40kx97swG/4XYhTGHxvPwvijNLsK0CDP/gqNYZwZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583151; c=relaxed/simple;
	bh=MLscEvys7CkwJ0WxPqlrDzMHLVP8Bn8ODUyIZURny1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AAs/tub8qTB26xl4v5LA8Zh4gNRP91PS0t1bKOzA9XTIGCw7M0JbBJa/Dw5XobFpz8Z8vmpppMkW0zEe0g4rbrE1R/3TAG3bTZGxzf9jfWKiGbtmihGlD6t+5c2Ef4tK0bIbHtGjA7+MrxYhgeVbGU6lb/LOP5rgMrTLMEybtdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=GCw4/z15; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707583147; bh=MLscEvys7CkwJ0WxPqlrDzMHLVP8Bn8ODUyIZURny1M=;
	h=From:Subject:Date:To:Cc;
	b=GCw4/z15KPrOT5eWGUHBqwpxVgLWTUOMdiDjJSrEGgg2OqZuaH9Fnt+Pi/JP85eOy
	 yg0D4++wUt0B97AVyMUrXXFu7Z4k93q/Y+fTkIadppUtW+yIdy5ff6dAgcjhXBRKiB
	 TAC8OUqSAvlbDi1O03AWShNTuf+rPSaQr2EyvJxY=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/3] Add RPMPD support for MSM8974
Date: Sat, 10 Feb 2024 17:38:55 +0100
Message-Id: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+mx2UC/3XMOw6DMBBF0a2gqTORGWwMVNlHRIHCEFwAlk0sP
 vLe49CnvE965wTPzrCHJjvBcTDeLHMKumXwGrv5zWj61ECCpKBc4OSnqtYSnZ1sjyXLauBCS9I
 K0sc6Hsx2ec829Wj8urj94kP+W/9JIUeBPdeFUlxWkrrHUczr577tB7Qxxi/4j5XHqgAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=MLscEvys7CkwJ0WxPqlrDzMHLVP8Bn8ODUyIZURny1M=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6anGU+ceIvc8ovgKI3hlGxY32ZIT/ED/VJcS
 9YoXGRcaLSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcempwAKCRBy2EO4nU3X
 Vow3EADTlxUCIj723jnL1SxpoYT8xMTjRbNUHWXqTlNiXOzvl9FhVksSD9Y9L1yUXF5QHJsqksl
 gy7zFi4tzqy/67X7wHcTG8JAInmkRX8o2HfpJ32n98uMhEp3xtA5N24rPkO8U1IHqAYTkUC779y
 1cyH5mA+sS8ieTzUKqmOB3IXIduMTqvUEyf0IYAEY/M8KIdX4sjQ1GfUsiyD6tYLUGYq+VU4x2V
 hGKqWKrvWX3p1YcU7zNqaorD6ZJRt2SojjgZd1Dhk7PFJRJ0NfKNX6mrUFnCmdPWcOahy9k31tG
 SDYd/EA58TWQwxhnO36nDlT97ZHfMZkkmc07WsVG55G4kCFIhMXoNZ+qGXpHEh5bivGNaWFEYEP
 JpOaYz8BNNnz0hMFTJOg5s+rKqBVOPcZASCc10oKDnS0taQwoEZtcwyh6WAt3uWaA83yRC4BQVM
 3IErPPNkngBibpRS0Ys5KTEh6BHW/kZaZdBTlqyFGhxoe7KRJ815bJldjfYY6UUXAfPDbjxCle3
 GA1Kx21hBcvufKj4RAGMkONUUdkyJcQqNa+P964OHoE4Y9rJg6xgNJbx6bw6tB7lHVyhgmIiYP6
 4rkpmkUNgc7mnHjhOe988Q1ksLDEZHjPyiakQ/BZWjsyI1oSEuMykud9dPvTxEPW9L/eBgibI/l
 bezPg+Ue/sdtvpA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add driver support for the RPM power domains found on the different
MSM8974 devices.

Devicetree integration will come at a later point since also some
mostly remoteproc drivers need to be adjusted.

Also the MX power domains on this SoC seems to work quite a bit
differently, we'd need to send raw voltages to it, so these are ignored
in this series.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Drop MSM8974_VDDGFX_AO in all patches
- Link to v1: https://lore.kernel.org/r/20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz

---
Luca Weiss (3):
      dt-bindings: power: rpmpd: Add MSM8974 power domains
      pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power domains
      pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  2 +
 drivers/pmdomain/qcom/rpmpd.c                      | 83 ++++++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h             |  7 ++
 3 files changed, 92 insertions(+)
---
base-commit: 6e3fa474051f3d276ea708bdb8e8e1f66d1d3ee5
change-id: 20240210-msm8974-rpmpd-6e48fe374275

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


