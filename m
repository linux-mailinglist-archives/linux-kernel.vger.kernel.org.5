Return-Path: <linux-kernel+bounces-119111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CA988C452
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5803B1C60DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D882D7D;
	Tue, 26 Mar 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrcqGyo3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D627603B;
	Tue, 26 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461693; cv=none; b=FieJZKgVH7oQQBbCVTzCQUJWxf8H1nWEAudmPIilySFGyxYj3xayS3TCgu9IkWudVEXR0Y53T/YAYDIUo/3Gma+7wv1BbcYjz6+rjgIuzJkwi3FGc+0p8J9lQPSzrUwSvbou+KamMpmJprAx+uhKZX6VWfX2D2tRFxrnXt1OKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461693; c=relaxed/simple;
	bh=3YqcMcSeQrAJhFxyehRFqJm+kpoklrIhOsCDq/mQiJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwaiPwxWS4U9TU1aByluLFZhohTV8KO4SLMUGOy2OHeH52eVjfcF1eNOOAsfAXJB0du7ltT1h+qwq/x3Z7wxgmMy5cr49JZwpsGExrEe9sms2ADlXmJ8rXiLIw9LXB/Hby+4yI6icCznLX5uYeWLfLVZMzZCD1PGu46sZw5NI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrcqGyo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B044BC433B1;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461692;
	bh=3YqcMcSeQrAJhFxyehRFqJm+kpoklrIhOsCDq/mQiJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrcqGyo3X5Uw4H9MVaz14s65PrNgYiJli1b8J62iU0vPDWMQcRje0CDGMRNJHcv/L
	 zDEC97fo3KmH/yjcsCSlFreXdYXLNiqqcYmg8nBCS0i2oA6dfBQ2xKlztsyDscfCQi
	 Mqg1aa7v92THqN8Io6Z3B/TlAEH9savCoiEvQDJ6ihrnF4V8j4Qe2oN0v8YlmCc3aa
	 /YhFQhX9iPucFsKjCPeQITVgYWyFObwRuGaElK5+uZr5fBN2hfXmPx76Y5zlRJdydO
	 VYoj0Z/+hPjD1VRBcRa9+iIwmQu9z1fg6dLZLMHR8LOAsvYYdHgYWSFgNHHI3N40xC
	 Iihi8D3wLsp1w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rp7Mz-000000005Yx-0NM3;
	Tue, 26 Mar 2024 15:01:41 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/5] arm64: dts: qcom: sa8540p: drop fallback gpucc compatible
Date: Tue, 26 Mar 2024 15:01:08 +0100
Message-ID: <20240326140108.21307-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326140108.21307-1-johan+linaro@kernel.org>
References: <20240326140108.21307-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the fallback SC8280XP GPU clock controller compatible that was
added temporarily to handle the transition to the new SA8540P
compatible.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 3b31a9ea3492..9c2e99d30d08 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -168,7 +168,7 @@ opp-2592000000 {
 };
 
 &gpucc {
-	compatible = "qcom,sa8540p-gpucc", "qcom,sc8280xp-gpucc";
+	compatible = "qcom,sa8540p-gpucc";
 
 	/* SA8295P and SA8540P doesn't provide gfx.lvl */
 	/delete-property/ power-domains;
-- 
2.43.0


