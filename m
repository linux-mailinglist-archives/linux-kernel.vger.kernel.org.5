Return-Path: <linux-kernel+bounces-113375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30408883D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008DC1C23877
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3519EE3E;
	Sun, 24 Mar 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpZsjumi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C519EE20;
	Sun, 24 Mar 2024 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320176; cv=none; b=KCCBS6/jp17xI3c3SrIGTJrndTX5HQVVMtnrkKhPrW/khLMikFKG72TEg6ViB5mE5Bnflp8mH6sIffESUn0T2F1bHFZiqKuGQ3pIHEkjDewnyPVD2GDDAOO3Bji4fDAORjVfi1vCs4db8KmjlftPrPe8ddqXwxrS71M3Vf17rSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320176; c=relaxed/simple;
	bh=sDO/7EPn04XUVYeTtmQz25A4sojQUsLYT5PAGsrwO4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbbJ3yva2Y3migr/TqWDqGqZH/kfC/2CDl3ITWfOLL1+ziDnDLTzI4AR6aq6GhIkt9RDPgR8pqZuRG4ZvaNvqi3PS2f7+zD49OKgrACxECvg+iVUgst7iY2zqZHxMUs7jToN7l1on7SlrZyqz0ejXS0lryxKefQ/l3evdWbUxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpZsjumi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE5BC433C7;
	Sun, 24 Mar 2024 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320176;
	bh=sDO/7EPn04XUVYeTtmQz25A4sojQUsLYT5PAGsrwO4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpZsjumi1G3ACCk6yQL7fuwCQQ4kcofT4G9Rotx27evUkXI2/ur1s56495qPd86fu
	 Alw/meOVenRDvP02SNQykyvUaGbpQddI5bBhJD1u+tdKddP3NJg9zqY3GEYt4sTHYk
	 6DPYx81oS+CfFjsHujmy8sN04ucVUiDuZkSt4o+ZpqqH0hciV+1Tr6AJ+VKDv0Xrtm
	 +fgyC6NiYXT32TYWxF/e8C7JjdRmuHGRYzb86gVKmdUmbzBdy9tclffmon91GpEqsI
	 LpQBQ/O4msHeg1ShAM/iwY6Klj0yes1FkTpfp4cpMBsGYDzqX1Tg0yVSICutOkDyz2
	 UiqZchQbDjghA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 484/715] dt-bindings: arm-smmu: fix SM8[45]50 GPU SMMU if condition
Date: Sun, 24 Mar 2024 18:31:03 -0400
Message-ID: <20240324223455.1342824-485-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit dc94d0cc718329a39ea2e986a123421a9203b471 ]

The if condition for the SM8[45]50 GPU SMMU is too large,
add the other compatible strings to the condition to only
allow the clocks for the GPU SMMU nodes.

Fixes: 4fff78dc2490 ("dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/578686/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml         | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a4042ae247702..38c48131e6e7b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -484,7 +484,12 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,sm8450-smmu-500
+          items:
+            - const: qcom,sm8450-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+
     then:
       properties:
         clock-names:
@@ -508,7 +513,11 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,sm8550-smmu-500
+          items:
+            - const: qcom,sm8550-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
     then:
       properties:
         clock-names:
-- 
2.43.0


