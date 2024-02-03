Return-Path: <linux-kernel+bounces-51256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129BB84885C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23D2285C72
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328295FDCD;
	Sat,  3 Feb 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="TAIdHCEh"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D85F86E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987549; cv=none; b=ufsls6EDr4KMDLfC3wuSTFVTCdYCRIf/Eg3MXqM1zoYRWaxMKEgbrcEE6p5K/6FjsP3ljPYLCZ7r6kkRRxnjubQvH+tPaGXnvQZ72NBkzDG0a6LIfKIZmnxtYMyUhknR3/KQKjxrU/goFjU+pIPQv/9NcriFt4PUa0A0427JM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987549; c=relaxed/simple;
	bh=bd7lZoKMBfp0dNJw3NMwekWLKolEqwplDPJst9vEqNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ermsmkwWTdTIUKB6JHnaPGMFTFELPNQ4sNdTT+nNaQxpsdkMfeP76JsUcevXiPn+3TRC18Oyu4gomTRQIDU+5zNYh5Xs960DeIsbxEMF+EQ66d/wxWXRfTB7cMM0GHfSatCNmuQ4mElOzhIv/9mNnU1rvWKmHXpGiJnZjpZJkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=TAIdHCEh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706987545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7cWIwnS8VWIVYNfovS60jJxitrKNEY+l7a3wpu9pzs=;
	b=TAIdHCEhyaYlc7T8IU8N3I+0e+nbVbDNFp+Q95Z0sUBUz3qbQVu/hjscMg2CE4iBV0qMtQ
	bFMMcIqhiEwZNOJAXLVFWdp/tirHQaDloxTGO1idBDhN0AQ4qIEs1ugl/yl9jn6bkLEncz
	i/DoAGmfavATZ65Geim5mSn3ZTBtDTwM4xIKHcf5DJ9idZlNSM5XrKWbC1PAA/P7sMVoqz
	awqdjK1Wv9iJYSvXXtO7YNjFZXRpw5OJ4hbzJv+hIMMNx+4VigvRzpe7/JtMcR7SvjjZoa
	XMCLOpXrRnA+N+xY0zjwvJnaGuEa+MQ9opMlD5yzQUNdLOTV7UrBFT5XbWPaVQ==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: fix GPU firmware path
Date: Sat,  3 Feb 2024 21:11:55 +0200
Message-ID: <20240203191200.99185-2-jenneron@postmarketos.org>
In-Reply-To: <20240203191200.99185-1-jenneron@postmarketos.org>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix GPU firmware path so it uses model-specific directory.

Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 0c22f3efec20..49b740c54674 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -350,7 +350,7 @@ &gpu {
 
 	zap-shader {
 		memory-region = <&gpu_mem>;
-		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
+		firmware-name = "qcom/sc8180x/LENOVO/82AK/qcdxkmsuc8180.mbn";
 	};
 };
 
-- 
2.42.0


