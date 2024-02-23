Return-Path: <linux-kernel+bounces-78602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390528615AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80CC28769D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9212A165;
	Fri, 23 Feb 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMrhpPkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893D83CC3;
	Fri, 23 Feb 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701789; cv=none; b=mOO5sZKYspBS4ZC2AnFU07tqw9iUmNpLOl20fV6NCmPnn/svHz+iquyfANXYii5Kae1TNO2d1nTM+sjLWxxbVcqdxmnUY7UIwuYpl+RZEgBj0slKFxbedo3S93sFIFYUfF/AyH40xOMtwtcSPbbdCvP5EEBjFmumnUj9WZY2OrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701789; c=relaxed/simple;
	bh=OWj2b5i7fpfFVzm3D5FLX7tedf5qUfedcLWseSq8y7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWNseEvwfg3CVg4Em64aHMzUurlDNDliN3nP47UXO+dKaa64gmOlhfegf+TCu7Uih6EzF0ipPjAHnB7B/cizeXr7HEucRsbCWlv9uNdoygKUX+xGYu7DX/C6Y48aGznF1UGje/2ObutmyAywTofHb3WWAq5ltLIZfBF+p0EEf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMrhpPkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C76C43609;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=OWj2b5i7fpfFVzm3D5FLX7tedf5qUfedcLWseSq8y7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMrhpPkqFG9r00mtXMNDXeW0UgnlRmsYPdHbyg/9/4Z0HEmdvntpW5CGszqUtomla
	 B+EPNYxM2lTEWEirudMCLMviRTm9sQPqwXZrL9zYTIjn2gsYMJCX9q+BxKrGDpc4cx
	 YyKPwjDbXwaqfZoxeHZG9GjXD/UfKyCkK8Uf4oy1NFCfeuuCcUbMHwDRGpbfRw1lzs
	 nRBKklaoM1guPH/h4JCPEggS4Ton0f8E9jMSlkRXpriINSLhY/5xKbLBoPS1HgJqWs
	 8NumliXEAp6iJN/qM2FrnRQejdl0UECHN7VoaSTjEJaK792mlHVYoUjvEOnBQ0pD3D
	 WfuUvasNTOkBQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Fh-1XsO;
	Fri, 23 Feb 2024 16:23:11 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 07/12] arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
Date: Fri, 23 Feb 2024 16:21:19 +0100
Message-ID: <20240223152124.20042-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
speed that the boot firmware has brought up the link at (and that
Windows uses).

This is specifically needed to avoid a large amount of link errors when
restarting the link during boot (but which are currently not reported).

This also appears to fix intermittent failures to download the ath11k
firmware during boot which can be seen when there is a longer delay
between restarting the link and loading the WiFi driver (e.g. when using
full disk encryption).

Fixes: 123b30a75623 ("arm64: dts: qcom: sc8280xp-x13s: enable WiFi controller")
Cc: stable@vger.kernel.org      # 6.2
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 2c17e137563a..a67756ada990 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -768,6 +768,8 @@ &pcie3a_phy {
 };
 
 &pcie4 {
+	max-link-speed = <2>;
+
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


