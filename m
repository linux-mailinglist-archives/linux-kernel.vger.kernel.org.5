Return-Path: <linux-kernel+bounces-126719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52089893C22
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8912826E7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3454643AC7;
	Mon,  1 Apr 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll19echC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2B4206B;
	Mon,  1 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980630; cv=none; b=GtSBZOqFwIjChkX8iPeAOVYqjwM07/7yJdBhi7b4scATIOU11g/+wTvC4W0dw6RLDDWLD7PbtYQUcmcXoLPpzgGvmR1J22Lqbu9ub+SujbNvnRrfPbZbIUh2OGLPV6BrpxZfDFfihNxCHIxjL3SHi155GC4IKyXf1mefjckqEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980630; c=relaxed/simple;
	bh=Laz6b4ZNO3NIb2vOEm+kujYn+MoE/n6//P01xV2m5dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZS5Bkx+b6XXexbsZ/IV4rZULtkHYKxuxP7iPaFNm/CBq+zm3ZIyvpSziLp574DaiupwdL8nctUMA1t2uwNv5Rj5pOB5jZ5tPO0UsMkdchxo1TErByy/vraBemvv3cjjEzm9dYXMBkUV5AIRoznPCLb5D8N59bx3nqQQ4BMj1f/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll19echC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE011C433C7;
	Mon,  1 Apr 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980630;
	bh=Laz6b4ZNO3NIb2vOEm+kujYn+MoE/n6//P01xV2m5dw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ll19echC7Z2wVivFpBsL0mQ4xHB7HMJs39/NSx19LgB4eXxUjWn6haXcOOUYXI/Pv
	 0fIUR8kkDeR9jObK5ZRvqyJabaFQtBb0afVanqnRqyltO9sx4Mdizv/cackZUV8wX9
	 9QfhIYt1sU1NKiGsQwxdVwXLT8py+uh8wa5fc6HX7QEZzH4pKqg0JxMby1E39P8D25
	 Iz43qtpWQTPkZys18lXRHsCswLkz4o6C6UpiTXlSGk3GpOoGGTGiJVGgABizS+Ot3f
	 UiVVh+D/tSdjYj5LEIf9J8sp+JSCelwBjdrv6GWP7Ij9eknDuBL6dElIwAqAQe0gYt
	 abAaN71G2yyAw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] arm64: dts: stratix10: socdk: drop unneeded flash address/size-cells
Date: Mon,  1 Apr 2024 16:10:22 +0200
Message-Id: <20240401141025.98125-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flash node uses single "partition" node to describe partitions, so
remove deprecated address/size-cells properties to also fix dtc W=1
warnings:

  socfpga_stratix10_socdk.dts:182.10-211.4: Warning (avoid_unnecessary_addr_size): /soc@0/spi@ff8d2000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 26173f0b0051..4eee777ef1a1 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -180,8 +180,6 @@ rtc@68 {
 &qspi {
 	status = "okay";
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "micron,mt25qu02g", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <100000000>;
-- 
2.34.1


