Return-Path: <linux-kernel+bounces-151030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F018AA826
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22BE283E74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12762C15D;
	Fri, 19 Apr 2024 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wBBNWwIj"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2561883D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506451; cv=none; b=HNfFMEDI7TOytdsX+v6UxjRihYjoV1R0U8+AJS3mlIKoTqw8/rnfPgbXxa7VddyNmOiAMV3ee5gCxQDnZP63vlqfiYqnaOkHPgQFgYAw6ycQL332TPtkDW2NSOaLKAkRgOENqOzQzjWyjChUvzqpsG+3rqdgPBKm0QQtUvf35f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506451; c=relaxed/simple;
	bh=kf6YARDWwHP/63s0q0JsZOyzLSuz+PAHNQyz4RYosjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUz/yzSBTJi/CyILySdhNCwmt5NgtsYJAp/90xnp1h7504YKm28JC1mzEj6XVjsYzMxGw5irRwf+rbzUI2Ng+GaSl9v5xXE2rRJI6osYfgTytt/sgEHk1tPOcyuKX5PhjNE4G7Tmh8+P2OjyvkjPyanCRoQjg7bO55JBaq4Nbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wBBNWwIj; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J60Hpm117966;
	Fri, 19 Apr 2024 01:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713506417;
	bh=fPqihXFlJ/zn1WlqYp5TDhpo7/g50LVTUp2MJcOrJcs=;
	h=From:To:CC:Subject:Date;
	b=wBBNWwIjCBRIp50SU3TpZ6xXUnLGMGi0A4Fg7UvWHwR9WYvJ6T9GzEjCN8lmzzDfH
	 ZhyXHkDq+5gBYAtwPns7+fea7om9I+wejihg3wKjoV79uMNmAZVQHzX65szCMh1H7l
	 p2Qdq70Azrf+6XjtzURv3Gf/EvEGGx8hYPHQ3EN4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J60HVP111653
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 01:00:17 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 01:00:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 01:00:17 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J60EF3033217;
	Fri, 19 Apr 2024 01:00:14 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>
CC: <quic_bjorande@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH] arm64: defconfig: Enable HSR driver
Date: Fri, 19 Apr 2024 11:30:13 +0530
Message-ID: <20240419060013.14909-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

HSR is a redundancy protocol that can be realized with any
two port ethernet controller.

Many of TI's K3 SoCs support multi port ethernet controller.
So enable HSR driver inorder to support this protocol on
such SoCs.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 11fa4aa40094..750343564f41 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -176,6 +176,7 @@ CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_ACT_MIRRED=m
+CONFIG_HSR=m
 CONFIG_NET_ACT_GATE=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
-- 
2.17.1


