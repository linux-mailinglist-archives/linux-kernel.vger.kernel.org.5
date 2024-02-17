Return-Path: <linux-kernel+bounces-69749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E747E858E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D242819F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A3200C7;
	Sat, 17 Feb 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mxbfM98H"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310711D54F;
	Sat, 17 Feb 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158050; cv=none; b=kj7hL0PStxgH+lxEyHEh5q++tedYyakYvyeQfSuEVtM827VGBx1Ry4jqjXvbRPK6obL7IeoiBVj0fpwQtH7i2vg5X3sXz+3qfUqbSVFJAFcfaTw2LGArfc/WDqrhLIugyYXEI6kXG1E2ML1nWKcw1OpK91PZQ+ZYb5oaPc6uEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158050; c=relaxed/simple;
	bh=6sRPoZ3Ar/8gydeQdoTDVVaduVMOVcG5NbSDDkFAjtc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPU1uslhEIsHa1H9lOi0lR+fI1yUGMTaQ1nge1aDesO67rU4NoRKPqdjz6p76snMTsxlyYYwq9P+SE7AmIJVU22KxZv/9oeCCbbYMcF+7ruAGxSgvi/6XowTnSbMDXl6ZpDQ+uIjvcKwR8I+Zq/qmB0pG+HurAIJ7xJ2whdrQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mxbfM98H; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oiyq9kLog9Cp/R7ZfxBUXhF6KOaPMsO94BpECX+dYb0=; b=mxbfM98HHkXyp4E+iRyalJMa5g
	QYVSWJA1O5+4A2b23uy1Cf8S7+FqY9kCsLUwmbqrfNcxDHigsaMTdbYOjlNfHRy27XtOO7b04EBYw
	qWEYIEi1TSgffJSyCsao83o/jfTOUr2AKXBI1Ka46+jWPBNT8YuSSivyxlD2aydVwWzfE7QZ1aYjI
	MSJideydVD3tD6ITiELRouwFdM42IxNCapqep1Xrk3oWLqs7uloB1ZBKElhse9XZUCcVqEzUm4MQ5
	WbMb/e9Af7tcFY3tVi4q7mn+sdV5sm/d4uo+XAut+lbwbIi7h4qjoaV2+u4ksGxHBrYh6WXN2Z4ho
	cGwOGvLQ==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw2-009WAg-IO; Sat, 17 Feb 2024 09:20:34 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw2-00Dabx-0D;
	Sat, 17 Feb 2024 09:20:34 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	andreas@kemnade.info,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v4 5/5] mfd: twl4030-power: accept standard property for power controller
Date: Sat, 17 Feb 2024 09:20:07 +0100
Message-Id: <20240217082007.3238948-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217082007.3238948-1-andreas@kemnade.info>
References: <20240217082007.3238948-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of only accepting the ti specific properties accept also
the standard property. For uniformity, search in the parent node
for the tag. The code for powering off is also isolated from the
rest in this file. So it is a pure Linux design decision to put it
here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl4030-power.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 1595e9c76132d..0bca948ab6bae 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -686,6 +686,9 @@ static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 	if (of_property_read_bool(node, "ti,use_poweroff"))
 		return true;
 
+	if (of_device_is_system_power_controller(node->parent))
+		return true;
+
 	return false;
 }
 
-- 
2.39.2


