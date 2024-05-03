Return-Path: <linux-kernel+bounces-167277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EB8BA6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3278B2177B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D66139D12;
	Fri,  3 May 2024 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U2759/lD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D1848D;
	Fri,  3 May 2024 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717481; cv=none; b=PLQl6hDljFIdaiX0MyyDlN9cJpUJvj5aTvTv4k6psK7Ir2YwI2dvpMThYPf619MdevgaFwqlfgzDMkmL9aQuG1c0OhR4hGFPRj+BHRQQf4ebHGOvAqHdLPzEpRIBJ3D2GsgSIivvNnWqSLEr68tM/8hDDxwObZ6cUYVfQrVzE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717481; c=relaxed/simple;
	bh=4bZeLZFrWcnHn01n+AqXU/zz0FUy9Xsns81W6NJLBfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHByHt/+7skKafcfRQX9ZJFdbo5wqlJsdk2aSqWX+N40rcQn76anhkYKUOCUEStXcPANleaFM42aRfDpwmbe4+z1YnRS5MHYp+vz/AbVKKAEBvQsUQdAQZd0fGWiVgpIN/CjpfdyfBca+KiQNQmguOfdjBWMqd7GkYx0cnCCgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U2759/lD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4436OJwv026360;
	Fri, 3 May 2024 01:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714717459;
	bh=7oj3KtYbBGcsVoZunC1YXVSFiiYrwIdgbTPUb2sfHKU=;
	h=From:To:CC:Subject:Date;
	b=U2759/lDRIDlKxw5Rq3jMZDkfWlgbb0i6WBlqPu6afwn58OHVJkoLIOMPNy0oyovp
	 w4kHC8f0aFHyNKv9/wYp8tM+FxnzQevbncQlcrJHOoXxhLT7Vmkcssh5uwBnl1vPs/
	 zvjCo1BAQ4B54YPtUNaXVhb3m7IvCG5mkqAD1jpk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4436OIs3030791
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 01:24:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 01:24:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 01:24:18 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4436OEaY130748;
	Fri, 3 May 2024 01:24:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <s-anna@ti.com>,
        <hnagalla@ti.com>
Subject: [PATCH 0/4] Switch MAIN R5F clusters to Split-mode for TI SoCs
Date: Fri, 3 May 2024 11:54:10 +0530
Message-ID: <20240503062414.804209-1-b-padhi@ti.com>
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

TI SoCs (J7200, J721E, J721S2 & J784S4) have multiple R5F clusters in
the MAIN domain. All of these clusters are configured for LockStep mode
at the moment. Switch all of these R5F clusters to Split mode by default
to maximize the number of R5F cores. The MCU R5F cluster continues to be
in the preferred LockStep mode.

Note that this configuration is the default for remoteproc mode (kernel
driver boots the R5F processors). These will be overridden for
early-booted remoteprocs through the corresponding IPC-only support in
the K3 R5F remoteproc driver.

Apurva Nandan (1):
  arm64: dts: ti: k3-j784s4-main: Switch MAIN R5F clusters to Split-mode

Beleswar Padhi (1):
  arm64: dts: ti: k3-j721s2-main: Switch MAIN R5F clusters to Split-mode

Suman Anna (2):
  arm64: dts: ti: k3-j7200-main: Switch MAIN R5F cluster to Split-mode
  arm64: dts: ti: k3-j721e-main: Switch MAIN R5F clusters to Split-mode

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1


