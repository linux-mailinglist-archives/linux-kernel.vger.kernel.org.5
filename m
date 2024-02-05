Return-Path: <linux-kernel+bounces-52935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94136849E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64621C20F91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C765482F9;
	Mon,  5 Feb 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OGseCoHX"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1224776A;
	Mon,  5 Feb 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147322; cv=none; b=b/51aLa/UF5EHNtBtZ8ZG7gOyDVWSe/nWW3iWCHgW7ccQi4hXQdSyGYY0Pn5OFuIhHlDQNSInjligKFwbyoBOlrbALrXbXNunCRgWjEVCeO3GhhLDER5ElJVVl8Yzgoj/BaRpgsH+wNkoR5jZ8crJdWOVrcbnbnV52khHDHgCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147322; c=relaxed/simple;
	bh=ykTFCWhmo1CcFg+mieS6pNHkMkwN4QV8FPxwm0fymFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=my+0rfMCOmUBH8ExKVV/pp6xR+zsVuAoKV11dtJ4ioAthsJVX8KrIQjyX6AFveBG8dmT/mxHiakDN15etUCxxLZTmk5HcDToq5t8D98LVei+dWyEoDKzRwo6R9K3ITU1Zl0glY5GHZmpTBjA/GuXYUCQurgeMbmjkgevmNhTWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OGseCoHX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F7E324000A;
	Mon,  5 Feb 2024 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yETsBPXWcWY3g53aJQJ3Y4mu+dfHGI3TLEovxztjpk=;
	b=OGseCoHXU7uAnYuj4c/bj3Biua+cEz5wOWQ7XibIBreFCCcA5YUUVTrHgbZaX09uN6A5NR
	gf4lfkrilalFQ3vhH1UkrS6bb3j7NshwjnHmVrv2y99UKiEW0kNWQhGy7upfzAoBHm6Rj/
	AFSxagdD47EM/lPeWsDMkPD0r2yGHNXnPcdDbVibZvPHixEcjL2VCJZqTatKFPcriK0voj
	I0i3kvfPtTLKWfeggARX57S2MuDMlCF76wSbk4f4NvZyIdPnvJSWQVahUji5/iLkqX9DsR
	17AgnDsPOG2lU/aicPvFYKBJ2nBbBlJD7SNB+hSPssrQ21LMEiAlUDYqIhyHuw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v7 14/14] MAINTAINERS: Add entry for Mobileye MIPS SoCs
Date: Mon,  5 Feb 2024 16:35:00 +0100
Message-ID: <20240205153503.574468-15-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Add Vlad, Théo and myself as co-maintainers for the Mobileye MIPS
SoCs.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3444c8c6512e..b18f328ee8ee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14546,6 +14546,18 @@ W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/mn88473*
 
+MOBILEYE MIPS SOCS
+M:	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+M:	Gregory CLEMENT <gregory.clement@bootlin.com>
+M:	Théo Lebrun <theo.lebrun@bootlin.com>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	arch/mips/boot/dts/mobileye/
+F:	arch/mips/configs/eyeq5_defconfig
+F:	arch/mips/mobileye/board-epm5.its.S
+F:	include/dt-bindings/soc/mobileye,eyeq5.h
+
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-modules@vger.kernel.org
-- 
2.43.0


