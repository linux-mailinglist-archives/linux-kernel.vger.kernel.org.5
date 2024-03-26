Return-Path: <linux-kernel+bounces-119107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E966788C450
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E645B22BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98176901;
	Tue, 26 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyWCR6rB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FE74C0B;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461693; cv=none; b=ObGC9Siezth9Z/iTu+qrWY2yWhq46/Brl1f9aA4XR/NFE7VsHWK/vXsAql0kGdjdZRMnrW7YlyMPlt5H6vg02hP5CZl00wjmEcv27ADtj0YV7T73A9iQkCmj0pyGk8oeCCLWLq7szNZx4o5IMvCquUy/I1FjXLTYLbD5nkqpV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461693; c=relaxed/simple;
	bh=mSAR/ds6sNoK+caG9qPwIX3WHSQBTErTxeDXv/sxkCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz/IviagompFJOPP/+kfN4AL3BIslvwMnwjlgMdneWsCd1EdRGO8svQ2BrG/XfitOUjD2aiTaq/fw4LZr0psr/sXtK6y5L4E//pZ43IYkBv9XZxwUolV/iQB32Zzu7BGNn+CgaVtb9StLMhmVbdnVRzBLARq9aqMI0WqgRRLej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyWCR6rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F84C433F1;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461692;
	bh=mSAR/ds6sNoK+caG9qPwIX3WHSQBTErTxeDXv/sxkCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyWCR6rBVaxhyy3gtY2q/5fsuIadAnK7pf/x0bZfKqvCGfKwq+jbgeURiklGKsSWP
	 MGwa31t2xVfbOiDESji2/FZhKhSys8WDdCopOCWJPWW/Ae9XxCFPnPGHsK0TCmsld9
	 /cKMMJZFdVg/DJfw3C9sGkYFASlW4Bq0HvuxBLUT5p86AzHbZhlBS5D52ZQc+WITXH
	 fwRRb9uRejd5BKsuBF1jMr7KeHkzzRdes2aWMHn4aWMBdYjfHowWx4MLjdZlFrIT+7
	 rK08Ll/nRqB7yEHCxWpM9ia+kqUSPg+8ujiK0LjhC8kTo0qkoKMBrEUq4fJP8qpITY
	 rbH1TGqg/sLYg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rp7My-000000005Yp-37IP;
	Tue, 26 Mar 2024 15:01:40 +0100
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
Subject: [PATCH 1/5] dt-bindings: clock: qcom: add SA8540P gpucc
Date: Tue, 26 Mar 2024 15:01:04 +0100
Message-ID: <20240326140108.21307-2-johan+linaro@kernel.org>
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

The SA8540P platform is closely related to SC8280XP but differs in that
it uses an external supply for the GX power domain.

Add a new compatible string for the SA8540P GPU clock controller so that
the OS can determine which resources to look for.

Fixes: e60b95d2b687 ("dt-bindings: clock: qcom: Allow VDD_GFX supply to GX")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index f57aceddac6b..5b385e4976b6 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -28,6 +28,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-gpucc
+      - qcom,sa8540p-gpucc
       - qcom,sa8775p-gpucc
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
-- 
2.43.0


