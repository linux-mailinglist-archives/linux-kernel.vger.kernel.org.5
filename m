Return-Path: <linux-kernel+bounces-29013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60288306DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B71F25303
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F31EB42;
	Wed, 17 Jan 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ko9Y1Kto"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243C1EB44
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497513; cv=none; b=B02y2qEiTm5MSuAi5sPAuAUchtnKVcCZLLT2M6HDYBq7v82jRGFcrFhlMJPBjoiUmcNWKPdbrT7A9VJYBvaYFmyKzPD3Ibz54S8WIOFIo3a57mxy3+5/jEKFit7CeasBn4nCJ61UtGdjbcV9xDPlmciOX6FObgOt5+zvrm6oC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497513; c=relaxed/simple;
	bh=4pfhhJ6nKwIRmP3erZaYcFWifxCQ0B5IiO08u5mirU0=;
	h=DKIM-Signature:Received:Received:X-UD-Smtp-Session:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=gqCCJ76rWNeJ76RCV+MEUzCxEoHcR5CyfWBChEg61KMuYyUTiZyE9wCHIRrhUWA1bxf+agj33fKpMjm0wSaZjEtuQjgHu486/zfpjCCjimFpRE/LXMjupJ67hyHP6+zHK2PBtZ5x8TVmyvsPDVA3iMrfVYQfsc/UAqOumzY6uRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ko9Y1Kto; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Gm6DXUbLl/SBcL7Tq61flrVhouAD9tPRtlD6zCnjH7E=; b=ko9Y1K
	toxtvK1ef7XAsff+gKBYfzKSmnxs+07pLBPemTTr/T/TfWtRAARlQDGVT6w0AtZM
	KVLGx68BuO7gBwCGCLV0nfw60/gZ+hoO5yaRIAo0t+aYsYumr/SPTkxQXKnaS/kz
	yYBsrYCscYLh8oaQ77WTzTu/090v4d9iLOdgXE4Vmk5xagMt3mFqrEr3I9C3VQoj
	DX9tn6qPkn85qmvRo3pibZxKm3a5T63MnE5cPjqGHb736XuQTCSCZaQqHB6VdOzu
	uwf5ceQEr1BffMkcm6WWGeCoT30EucjP6LENAqWannaesTwEEWBqScLBvzPScetC
	IcCA0SHuZgfV8N9A==
Received: (qmail 2754662 invoked from network); 17 Jan 2024 14:18:21 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jan 2024 14:18:21 +0100
X-UD-Smtp-Session: l3s3148p1@1My/FCQP4qpehhtJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/2] arm64: dts: renesas: ulcb-kf: add node for GNSS
Date: Wed, 17 Jan 2024 14:18:07 +0100
Message-Id: <20240117131807.24997-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
References: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since last version:

* use 'reg_3p3v' instead of custom regulator

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 40a5f98c1190..e3cc0e0e73cc 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -392,6 +392,13 @@ &scif1 {
 	pinctrl-names = "default";
 
 	status = "okay";
+
+	gnss {
+		compatible = "u-blox,neo-m8";
+		reset-gpios = <&gpio_exp_75 6 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_3p3v>;
+		current-speed = <9600>;
+	};
 };
 
 &sdhi3 {
-- 
2.39.2


