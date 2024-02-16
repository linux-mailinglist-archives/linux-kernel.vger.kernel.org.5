Return-Path: <linux-kernel+bounces-69441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCD858902
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007A81F22162
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D81151CF0;
	Fri, 16 Feb 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpf0ihhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AF14F9D0;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123026; cv=none; b=Bprgz6GWafVRglnMXzQDEe0q5AGqHymQoIiL/2j7ZCDBi8foTLZTA8AlwJ+/t7/ng8ccqPOsrpZuG0wFIokHFzpE6R5/oedqzFsbaEibO+ErrdVPVMjjNStfVtkoPXi6alDHaUV31Pw/9t7jX25QinU4JFgyzAVcEtgjbzsbgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123026; c=relaxed/simple;
	bh=JzqwkQRLgk7k3EhjNENSRph/tpijOyPkAp/qgI/FbTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH3GgmyyveSnrfuUZLXWcP5CIbU5zV8h8awhH/9N82Yd0A0Cpam5+N0Q4K08wZOkzhSoV8OaeB+uhRLVC8tyOADevR/eujrJ0jHOhEDV465t2dRnJke2f+tiU578+fhUSN5kIBt1tWOMGRM6dqUHf9lwN3c8k/Vji15jLvXE9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpf0ihhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F8C43394;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123025;
	bh=JzqwkQRLgk7k3EhjNENSRph/tpijOyPkAp/qgI/FbTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpf0ihhqBaUaKZ07WeiSCPM47kBjhAMQgJCpHLZ9rhjUDTBV6VtowPTO0pUbdEeul
	 hJuq3UBxK7cSRkydkOexMZ9/aC6bK69eK0eILbfniBszT3zJCAtah0tZ5MGvmHHYXC
	 bnYwrrSbGHcKUqmjKMWY5XErsxP7alzoEc9UfNMHe3BAJLbBEWShRIke7M6DpQmw1t
	 lsegDz1nI0IGTbq9/Y0gr8b1eaqCKwyOl4g991v7UhUqz6oXIDRGrPJtY4ZfDi6OTp
	 6+M4pNTQoAl6SX5npzFOlEd5RX9IDzfEvsQBLGaGtCaZzn7/ZFIee+nURADQrLtUyA
	 5Q6NQ/pJXm9nQ==
Received: by mercury (Postfix, from userid 1000)
	id DD78E10633F4; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 15/16] dt-bindings: arm: add UNI-T UTi260B
Date: Fri, 16 Feb 2024 23:34:34 +0100
Message-ID: <20240216223654.1312880-16-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible value for i.MX6ULL based UNI-T UTi260B thermal camera.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..7b65f9c9c1a5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -708,6 +708,7 @@ properties:
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
               - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
               - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
+              - uni-t,uti260b             # UNI-T UTi260B Thermal Camera
           - const: fsl,imx6ull
 
       - description: i.MX6ULL Armadeus Systems OPOS6ULDev Board
-- 
2.43.0


