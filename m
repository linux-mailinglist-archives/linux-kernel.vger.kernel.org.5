Return-Path: <linux-kernel+bounces-66420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0B855C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E2B2E7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F912E6D;
	Thu, 15 Feb 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eE0oELpZ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8C13AD1;
	Thu, 15 Feb 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985977; cv=none; b=o8mYfQ2AM28spPQA32z1tF1jd5yArSdflCdvqBz0M80YHPWRzs6mms3goG8AZ4SwhBO8ixXVGfJnAyCs5TUkAM/Ev5LavMDVVGFy2r/Kjporrn/g8Gn8UAZgeMDYZ+kCmPQ2YpGZ3ap+PdW0KpifiJfWApFnAaDku8setjqSarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985977; c=relaxed/simple;
	bh=AhM39UWbG/Oh4jBUS4gyxetK2SaA22mS/2gf/zbMErk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYhViza5DsJYxDzCdeBy2hXeErEgqW6ZnMUzUlixmhG25i6/ulyqnZw06Uh99xoA/cV07w097bLO33Rz0cC+pp6GdjXF/3jYXD+9VfAYJ72/GLR4aKgNbRcs8dy/Ncn+KNKMu1Q/lNpMbR0HSJzuLupIjRmh85S+DrSZn7PWykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eE0oELpZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8W7O0072534;
	Thu, 15 Feb 2024 02:32:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707985927;
	bh=/X1wR89ZBb3UtaGiPPrCIVmHNgdtrQGVd2HpQqSUzhQ=;
	h=From:To:CC:Subject:Date;
	b=eE0oELpZXEvMKOUNUGTX3O4fEgEYYOhyqxck6kjejIqmBheSWSWS/45w0gsARc/6y
	 1oiQTmGG7wPKxLRV4l69YU+szViKJGrWQPDE18c4R+ybSf2QofJPqZbk6fF1DKrWr9
	 UfK0aaw82Sq3c6bTQod9/+dv7iJfZ6voS6whNDjo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8W7bt005206
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:32:07 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:32:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:32:07 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8W5RU107645;
	Thu, 15 Feb 2024 02:32:06 -0600
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
Subject: [PATCH v3 0/2] Add common1 region for AM62, AM62A & AM65x
Date: Thu, 15 Feb 2024 14:02:03 +0530
Message-ID: <20240215083205.2902634-1-devarsht@ti.com>
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
 
Devarsh Thakkar (2):
  dt-bindings: display: ti,am65x-dss: Add support for common1 region
  arm64: dts: ti: Add common1 register space for AM62x, AM62A & AM65x
    SoCs

 .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                   | 5 +++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                  | 5 +++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                   | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.34.1


