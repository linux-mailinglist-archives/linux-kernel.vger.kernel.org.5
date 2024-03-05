Return-Path: <linux-kernel+bounces-92515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D858872180
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6F5288A05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2214986AC6;
	Tue,  5 Mar 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij3ROZg9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671941C6B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649157; cv=none; b=g64JwCtNGWpquiX9MiUNoaIaBh8xq1NmuNhPCRMH5bpl0c4Tw4Il4XHcDync0qTjtpi9dD/uGthkhOh/Ohtxdouwxu+tiwOmyf3QQ45Djak2a0LMN9W/ms+jt7D5J0qRPbOHju7mNmN0WkADu9SpJ1p78iANASZJ/3rt+Pu6fr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649157; c=relaxed/simple;
	bh=YKmGAMLdVeRSE3ciGzXs5gkjDxxcjstVUVnX5eWBf9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnzpMyetsgd95FbjP7Rq3ynD7po8WF3zRwZoOThOO+g9YO0ic6J1nOt43lLIcIeeHZDPzys3X9RBoJEC8Gyjxm9YnLEC2JiqQaS7K8QwE3u/43AR6Rrsgt0SFE05ouUfJoRfEL7W6A6jUUPSI2iSOjBtyeFZD/y0Snv6kOsxTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ij3ROZg9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709649155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JBzs20izmKSa/w0xJo132WZv3DDpsSKC3qmblEUsN0Q=;
	b=ij3ROZg9g1josndz+MmBy60bagk3rFjslaYaO+Z7ucj52ro973bP3kZbegCM1fBQr2whc5
	LGyNKsBF7dvolOm7vDUNegi2MF8N45kDdBDHIoncVOoTr9/ymjC4MuH6B6/4H1xLwtYh5v
	o8WCs5NVc+qJErrvIgsWzyQK2wZBvSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-QgkDEyOIP6iJvdrHKJfo7w-1; Tue, 05 Mar 2024 09:32:29 -0500
X-MC-Unique: QgkDEyOIP6iJvdrHKJfo7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CDD01800442;
	Tue,  5 Mar 2024 14:32:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4EB817A8E;
	Tue,  5 Mar 2024 14:32:25 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	david@ixit.cz,
	cristian.ciocaltea@collabora.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro
Date: Tue,  5 Mar 2024 15:32:18 +0100
Message-ID: <20240305143222.189413-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

With default dts configuration for BPI-R2Pro, the regulator for sd card is
powered off when reboot is commanded, and the only solution to detect the
sd card again, and therefore, allow rebooting from there, is to do a
hardware reset.

Configure the regulator for sd to be always on for BPI-R2Pro in order to
avoid this issue.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index f9127ddfbb7d..b3ea54b6ba37 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -416,6 +416,8 @@ regulator-state-mem {
 
 			vccio_sd: LDO_REG5 {
 				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 
-- 
2.43.2


