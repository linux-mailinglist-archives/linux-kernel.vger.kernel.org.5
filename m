Return-Path: <linux-kernel+bounces-149638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2F8A93D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83914B2186A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E313C473;
	Thu, 18 Apr 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vo+0Itc9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7F25622;
	Thu, 18 Apr 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424603; cv=none; b=sI/hOaiigs3ArNIhgoME9+/Tmxr/bCugCeTQgdaARKhs7+yZ6Y1QBPJRpxLY6fTay6KeC48ZCjbbHhKK7b9SHR9Q4I15zu2VHsQqYQ/7MEoxWDwnXX6ggfCwWb1W048rOg9dFB5Hxo7mOZrTsXJGne7bWgl3OCT2jtNrSoEqk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424603; c=relaxed/simple;
	bh=/oLK4PfFO0gZ94u76QwBpVv3b8XYxW6dweephRWBSQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=svDeQ+/39Zv568CwPSOiIufoOYKUdNAbYP2nFmOQ6sUWgLfiTaLCP0DQU9qLIbz/nlDS0H1a7XOELaVhFJ3voteUeLdrZbGrTYXkyz7GLRVKhBxwOmv8g12ZgRarc1/7jJwimtFNf5Uz1ES+3qhaHCWMBytzF4gAYMGnpFyVipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vo+0Itc9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43I7GMwh010849;
	Thu, 18 Apr 2024 02:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713424582;
	bh=0WH3XvEyyv9kr9Npqgm6GJ5WDh0InWBPjWA7Pc55j6o=;
	h=From:To:CC:Subject:Date;
	b=Vo+0Itc9HHulpjFIQ3VjLdPqgFZCG214RwILWI+xHwxhglau9+NIVpbKEjxkcKRhp
	 IYly2I9hN0p9ClQDOYhiLvL6eXhaEiZYSlwyIzsvIqYkxjNhW0P2FBnokLaX9e1Piq
	 jcpw4o24HFxx8LSy7+pDv5Py5kt8fPXVJs1m+nRQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43I7GM9j028680
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 02:16:22 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 02:16:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 02:16:22 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43I7GIS4027275;
	Thu, 18 Apr 2024 02:16:19 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <francesco@dolcini.it>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH v2 0/3] Arranging pin mux in alphabetical order
Date: Thu, 18 Apr 2024 12:46:07 +0530
Message-ID: <20240418071610.358944-1-u-kumar1@ti.com>
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

This series aims to align ordering of pin muxes in following order
main_pmx0/1, wkup_pmx0/1/2/3.

Sorry for this cosmetic push, but usages of pin muxes was not consistent
across the platforms, and even for j784s4-evm wkup_pmx1 was coded at two
place.

Dependency
This series is dependent upon 
https://lore.kernel.org/all/20240415095605.3547933-1-u-kumar1@ti.com/ 

Boot logs
https://gist.github.com/uditkumarti/28d7746486466f6d35f833ac829bbf6d

Change logs:
Changes in v2:
Splitting patch series into two as refactoring and fixes,
This series is for refactoring
Link of v1: https://lore.kernel.org/all/20240415063329.3286600-1-u-kumar1@ti.com/


Udit Kumar (3):
  arm64: dts: ti: k3-j784s4-evm: Arranging pin mux in alphabetical order
  arm64: dts: ti: k3-j721s2: Arranging pin mux in alphabetical order
  arm64: dts: ti: k3-j7200: Arranging pin mux in alphabetical order

 .../dts/ti/k3-j7200-common-proc-board.dts     | 131 +++++++++---------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  31 +++--
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  29 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  31 +++--
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 108 +++++++--------
 5 files changed, 163 insertions(+), 167 deletions(-)

-- 
2.34.1


