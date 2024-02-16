Return-Path: <linux-kernel+bounces-68097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3EC8575F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B887CB213CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2AB14A90;
	Fri, 16 Feb 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uA/KiaCG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A314A82;
	Fri, 16 Feb 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064694; cv=none; b=AC/pYSJWSSse9/Or1FbjPMm71Yb19WMRgjiSq54xt7CVr6f2O1HhcPF+Z3TIo3qhFfA/EEaWdbh7H6B0iHBKKnFj6zH1CtOuej8dOYLOUUC2TmmsXxIQk0U43UcnVc6dwS/N+mNLYvrGr7LKrSWhxKT1LhVYi46ZZGVkhhyf7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064694; c=relaxed/simple;
	bh=OjNcTROTQuYiQBi7zbRQZh7+zMPm1lCe0wYciCgWBaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRLoEPmhv3cxMwXJ6nJHSv64J0NfDOfegZlKUxY8NDkjZ6x6tfvxzftTKxf83BxxcvmLMuBm+4OAY/aktTGExMQvOGBxfXRkKKiijdXpCMSjAnGQWoH2yhkyY4v4Un/8sWFkkemVrW4zYHcdKc/oZrZNAat25416kKlY0w+jaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uA/KiaCG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OS5G010608;
	Fri, 16 Feb 2024 00:24:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708064668;
	bh=jR7zLnCATcHDsbKaHff/Ke+5+AL39mtD15RLlVq4wbU=;
	h=From:To:CC:Subject:Date;
	b=uA/KiaCGvx1RMBQQmRON4nSIlo5clqTtPNO8bbAjlwqSdSUAAqM1KFxoQlBpONjTj
	 /nehz3Lw7NcCjWWVkCLgANbwVB7pIV+XRjpsDPD8cOEzuEVi3GekEX+72bAhdkb3D6
	 LHDzCTbLphoqNDsyvGk029kA8kadimHy+BO47rqs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6ORU3002244
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:24:28 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:24:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:24:27 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OQV7039766;
	Fri, 16 Feb 2024 00:24:27 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v5 0/4] Add common1 region for AM62, AM62A & AM65x
Date: Fri, 16 Feb 2024 11:54:22 +0530
Message-ID: <20240216062426.4170528-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This adds DSS common1 region for respective SoCs supporting it.

Changelog:
V2 : Remove do-not-merge tag and add am62a dss common1 reion
V3 : Add Fixes tag to each commit
V4 : Add Reviewed-by tag and AM62A SoC TRM Link
V5 : Split dts patch to separate patches for each SoC

Devarsh Thakkar (4):
  dt-bindings: display: ti,am65x-dss: Add support for common1 region
  arm64: dts: ti: Add common1 register space for AM65x SoC
  arm64: dts: ti: Add common1 register space for AM62x SoC
  arm64: dts: ti: Add common1 register space for AM62A SoC

 .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                   | 5 +++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                  | 5 +++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                   | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.34.1


